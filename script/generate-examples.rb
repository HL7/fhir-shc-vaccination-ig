require "health_cards"
require 'open-uri'

module HealthCards
  class COVIDLabHealthCard < HealthCards::COVIDLabResultPayload
    def to_json(*args)
      to_hash(filter: false).to_json(*args)
    end
  end

  class COVIDImmunizationHealthCard < HealthCards::COVIDImmunizationPayload
    def to_json(*args)
      to_hash(filter: false).to_json(*args)
    end
  end
end

def private_key
  jwks = URI.open("https://raw.githubusercontent.com/smart-on-fhir/health-cards/main/generate-examples/src/config/issuer.jwks.private.json").read
  keyset = HealthCards::KeySet.from_jwks(jwks)
  keyset.keys[0]
end

@private_key = private_key
@issuer = HealthCards::Issuer.new(key: @private_key, url: 'https://spec.smarthealth.cards/examples/issuer')
Dir.glob('bundle*.json') do |filename|
  # Skip examples of fallback profiles
  next if filename.include? "-fallback"

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
  payload = HealthCards::Payload.decompress_payload(jws.payload)
  smarthealthcard = HealthCards::Exporter.file_download([jws])
  qr_codes = HealthCards::QRCodes.from_jws(jws)

  File.write("#{outputPrefix}-jws-payload-minified.json", payload.to_json)
  File.write("#{outputPrefix}-jws-payload-expanded.json", JSON.pretty_generate(payload))
  File.write("#{outputPrefix}-jws.txt", jws)
  File.write("#{outputPrefix}-file.smart-health-card", smarthealthcard)
  qr_codes.chunks.each do |chunk|
    File.write("#{outputPrefix}-qr-code-numeric-value-#{chunk.ordinal - 1}.txt", chunk.data)
    File.write("#{outputPrefix}-qr-code-#{chunk.ordinal - 1}.png", chunk.image)
  end
end