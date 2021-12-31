module FHIR
  class SampledData < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = []
    METADATA = {
      'id' => {'type'=>'string', 'path'=>'SampledData.id', 'min'=>0, 'max'=>1},
      'extension' => {'type'=>'Extension', 'path'=>'SampledData.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'origin' => {'type'=>'Quantity', 'path'=>'SampledData.origin', 'min'=>1, 'max'=>1},
      'period' => {'type'=>'decimal', 'path'=>'SampledData.period', 'min'=>1, 'max'=>1},
      'factor' => {'type'=>'decimal', 'path'=>'SampledData.factor', 'min'=>0, 'max'=>1},
      'lowerLimit' => {'type'=>'decimal', 'path'=>'SampledData.lowerLimit', 'min'=>0, 'max'=>1},
      'upperLimit' => {'type'=>'decimal', 'path'=>'SampledData.upperLimit', 'min'=>0, 'max'=>1},
      'dimensions' => {'type'=>'positiveInt', 'path'=>'SampledData.dimensions', 'min'=>1, 'max'=>1},
      'data' => {'type'=>'string', 'path'=>'SampledData.data', 'min'=>0, 'max'=>1}
    }

    attr_accessor :id         # 0-1 string
    attr_accessor :extension  # 0-* [ Extension ]
    attr_accessor :origin     # 1-1 Quantity
    attr_accessor :period     # 1-1 decimal
    attr_accessor :factor     # 0-1 decimal
    attr_accessor :lowerLimit # 0-1 decimal
    attr_accessor :upperLimit # 0-1 decimal
    attr_accessor :dimensions # 1-1 positiveInt
    attr_accessor :data       # 0-1 string
  end
end