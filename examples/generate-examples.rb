require "health_cards"
require 'open-uri'

module HealthCards
  class COVIDHealthCardCustom < HealthCards::COVIDHealthCard
    allow type: FHIR::Observation, attributes: %w[status code subject effectiveDateTime performer referenceRange valueString valueQuantity valueCodeableConcept labCode patient]
  end
end

def private_key
  jwks = URI.open("https://raw.githubusercontent.com/smart-on-fhir/health-cards/main/generate-examples/src/config/issuer.jwks.private.json").read
  keyset = HealthCards::KeySet.from_jwks(jwks)
  keyset.keys[0]
end

examples_to_diseases = {
  "Scenario1Bundle.json" => ["covid19"],
  "Scenario2Bundle.json" => ["covid19"],
  "Scenario3Bundle.json" => ["covid19"],
  "Scenario4Bundle.json" => ["mmr", "varicella"],
}

@private_key = private_key
@issuer = HealthCards::Issuer.new(key: @private_key, url: 'https://spec.smarthealth.cards/examples/issuer')
Dir.glob('Scenario*Bundle.json') do |filename|
  puts filename

  bundle = FHIR::Bundle.new(JSON.parse(File.read(filename)))

  fhir_types = Set.new(bundle.entry.map {|e| e.resource.resourceType})
  fhir_types_to_vc_types = {
    "Observation" => "https://smarthealth.cards#laboratory",
    "Immunization" => "https://smarthealth.cards#immunization"
  }

  additional_vc_types = (Set.new(fhir_types.map {|t| fhir_types_to_vc_types[t]}) - [nil]).to_a
  additional_vc_types += examples_to_diseases[filename].map {|d| "https://smarthealth.cards#" + d}

  corrected_types = Class.new(HealthCards::COVIDHealthCardCustom) do
    fhir_version '4.0.1'

    additional_vc_types.each {|t| additional_types t}
  end


  outputPrefix = File.basename(filename, File.extname(filename))

  jws = @issuer.issue_jws(bundle, type: corrected_types)
  payload = HealthCards::HealthCard.decompress_payload(jws.payload)
  smarthealthcard = HealthCards::Exporter.download([jws])
  qr_codes = HealthCards::Exporter.qr_codes(jws)

  File.write("#{outputPrefix}-jws-payload-minified.json", payload.to_json)
  File.write("#{outputPrefix}-jws-payload-expanded.json", JSON.pretty_generate(payload))
  File.write("#{outputPrefix}-jws.txt", jws)
  File.write("#{outputPrefix}-file.smart-health-card", smarthealthcard)
  qr_codes.chunks.map.with_index { |chunk, idx|
    File.write("#{outputPrefix}-qr-code-numeric-value-#{idx}.txt", chunk.qrcode.data)
    File.write("#{outputPrefix}-qr-code-#{idx}.png", chunk.image)
  }
end