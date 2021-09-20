module FHIR
  class RelatedArtifact < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = []
    METADATA = {
      'id' => {'type'=>'string', 'path'=>'RelatedArtifact.id', 'min'=>0, 'max'=>1},
      'extension' => {'type'=>'Extension', 'path'=>'RelatedArtifact.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'type' => {'valid_codes'=>{'http://hl7.org/fhir/related-artifact-type'=>['documentation', 'justification', 'citation', 'predecessor', 'successor', 'derived-from', 'depends-on', 'composed-of']}, 'type'=>'code', 'path'=>'RelatedArtifact.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/related-artifact-type'}},
      'label' => {'type'=>'string', 'path'=>'RelatedArtifact.label', 'min'=>0, 'max'=>1},
      'display' => {'type'=>'string', 'path'=>'RelatedArtifact.display', 'min'=>0, 'max'=>1},
      'citation' => {'type'=>'markdown', 'path'=>'RelatedArtifact.citation', 'min'=>0, 'max'=>1},
      'url' => {'type'=>'url', 'path'=>'RelatedArtifact.url', 'min'=>0, 'max'=>1},
      'document' => {'type'=>'Attachment', 'path'=>'RelatedArtifact.document', 'min'=>0, 'max'=>1},
      'resource' => {'type'=>'canonical', 'path'=>'RelatedArtifact.resource', 'min'=>0, 'max'=>1}
    }

    attr_accessor :id        # 0-1 string
    attr_accessor :extension # 0-* [ Extension ]
    attr_accessor :type      # 1-1 code
    attr_accessor :label     # 0-1 string
    attr_accessor :display   # 0-1 string
    attr_accessor :citation  # 0-1 markdown
    attr_accessor :url       # 0-1 url
    attr_accessor :document  # 0-1 Attachment
    attr_accessor :resource  # 0-1 canonical
  end
end