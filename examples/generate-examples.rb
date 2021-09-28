require "health_cards"
require 'open-uri'

module HealthCards
  class HealthCardCustom < HealthCards::HealthCard
    fhir_version '4.0.1'

    def to_hash
      {
        iss: issuer,
        nbf: Time.now.to_i,
        vc: {
          type: self.class.types,
          credentialSubject: {
            fhirVersion: self.class.fhir_version,
            fhirBundle: bundle.to_hash
          }
        }
      }
    end
  end
  
  class COVIDLabHealthCard < HealthCards::HealthCardCustom
    fhir_version '4.0.1'
    additional_types 'https://smarthealth.cards#covid19'
    additional_types 'https://smarthealth.cards#laboratory'
  end

  class COVIDImmunizationHealthCard < HealthCards::HealthCardCustom
    fhir_version '4.0.1'
    additional_types 'https://smarthealth.cards#covid19'
    additional_types 'https://smarthealth.cards#immunization'
  end
end

def private_key
  jwks = URI.open("https://raw.githubusercontent.com/smart-on-fhir/health-cards/main/generate-examples/src/config/issuer.jwks.private.json").read
  keyset = HealthCards::KeySet.from_jwks(jwks)
  keyset.keys[0]
end

@private_key = private_key
@issuer = HealthCards::Issuer.new(key: @private_key, url: 'https://spec.smarthealth.cards/examples/issuer')
Dir.glob('Scenario*Bundle.json') do |filename|
  puts filename
  bundle = FHIR::Bundle.new(JSON.parse(File.read(filename)))
  outputPrefix = File.basename(filename, File.extname(filename))

  jws = if bundle.entry.any? { |e| e.resource.is_a?(FHIR::Immunization) }
    @issuer.issue_jws(bundle, type: HealthCards::COVIDImmunizationHealthCard)
  elsif bundle.entry.any? { |e| e.resource.is_a?(FHIR::Observation) }
    @issuer.issue_jws(bundle, type: HealthCards::COVIDLabHealthCard)
  else
    puts "ERROR: Unable to determine credential type."
    exit 1
  end
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