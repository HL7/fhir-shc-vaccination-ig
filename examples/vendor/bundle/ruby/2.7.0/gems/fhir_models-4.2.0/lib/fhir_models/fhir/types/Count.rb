module FHIR
  class Count < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = []
    METADATA = {
      'id' => {'type'=>'string', 'path'=>'Count.id', 'min'=>0, 'max'=>1},
      'extension' => {'type'=>'Extension', 'path'=>'Count.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'value' => {'type'=>'decimal', 'path'=>'Count.value', 'min'=>0, 'max'=>1},
      'comparator' => {'valid_codes'=>{'http://hl7.org/fhir/quantity-comparator'=>['<', '<=', '>=', '>']}, 'type'=>'code', 'path'=>'Count.comparator', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/quantity-comparator'}},
      'unit' => {'type'=>'string', 'path'=>'Count.unit', 'min'=>0, 'max'=>1},
      'system' => {'type'=>'uri', 'path'=>'Count.system', 'min'=>0, 'max'=>1},
      'code' => {'type'=>'code', 'path'=>'Count.code', 'min'=>0, 'max'=>1}
    }

    attr_accessor :id         # 0-1 string
    attr_accessor :extension  # 0-* [ Extension ]
    attr_accessor :value      # 0-1 decimal
    attr_accessor :comparator # 0-1 code
    attr_accessor :unit       # 0-1 string
    attr_accessor :system     # 0-1 uri
    attr_accessor :code       # 0-1 code
  end
end