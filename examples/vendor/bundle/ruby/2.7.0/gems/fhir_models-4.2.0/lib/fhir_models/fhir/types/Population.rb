module FHIR
  class Population < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    MULTIPLE_TYPES = {
      'age' => ['Range', 'CodeableConcept']
    }
    SEARCH_PARAMS = []
    METADATA = {
      'id' => {'type'=>'string', 'path'=>'Population.id', 'min'=>0, 'max'=>1},
      'extension' => {'type'=>'Extension', 'path'=>'Population.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'modifierExtension' => {'type'=>'Extension', 'path'=>'Population.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
      'ageRange' => {'type'=>'Range', 'path'=>'Population.age[x]', 'min'=>0, 'max'=>1},
      'ageCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Population.age[x]', 'min'=>0, 'max'=>1},
      'gender' => {'type'=>'CodeableConcept', 'path'=>'Population.gender', 'min'=>0, 'max'=>1},
      'race' => {'type'=>'CodeableConcept', 'path'=>'Population.race', 'min'=>0, 'max'=>1},
      'physiologicalCondition' => {'type'=>'CodeableConcept', 'path'=>'Population.physiologicalCondition', 'min'=>0, 'max'=>1}
    }

    attr_accessor :id                     # 0-1 string
    attr_accessor :extension              # 0-* [ Extension ]
    attr_accessor :modifierExtension      # 0-* [ Extension ]
    attr_accessor :ageRange               # 0-1 Range
    attr_accessor :ageCodeableConcept     # 0-1 CodeableConcept
    attr_accessor :gender                 # 0-1 CodeableConcept
    attr_accessor :race                   # 0-1 CodeableConcept
    attr_accessor :physiologicalCondition # 0-1 CodeableConcept
  end
end