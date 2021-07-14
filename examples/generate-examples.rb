require "health_cards"
require 'open-uri'

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
    if bundle.entry.any? {|entry| entry.resource.is_a? FHIR::Observation}
        puts "skip observation"
     else
        outputPrefix = File.basename(filename, File.extname(filename))
        jws = @issuer.issue_jws(bundle, type: HealthCards::COVIDHealthCard)
        payload_minified = HealthCards::HealthCard.decompress_payload(jws.payload)
        smarthealthcard = HealthCards::Exporter.download([jws])
        qr_codes = HealthCards::Exporter.qr_codes(jws)
        File.write("#{outputPrefix}-jws-payload-minified.json", payload_minified.to_json)
        File.write("#{outputPrefix}-jws.txt", jws)
        File.write("#{outputPrefix}-file.smart-health-card", smarthealthcard)
        qr_codes.chunks.map.with_index { |ch, idx| 
            File.write("#{outputPrefix}-qr-code-numeric-value-#{idx}.txt", ch.qrcode.data)
        }
     end
  end