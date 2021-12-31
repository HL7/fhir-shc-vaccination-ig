module FHIR
  class ResearchDefinition < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    MULTIPLE_TYPES = {
      'subject' => ['CodeableConcept', 'Reference']
    }
    SEARCH_PARAMS = ['composed-of', 'context', 'context-quantity', 'context-type', 'date', 'depends-on', 'derived-from', 'description', 'effective', 'identifier', 'jurisdiction', 'name', 'predecessor', 'publisher', 'status', 'successor', 'title', 'topic', 'url', 'version']
    METADATA = {
      'id' => {'type'=>'id', 'path'=>'ResearchDefinition.id', 'min'=>0, 'max'=>1},
      'meta' => {'type'=>'Meta', 'path'=>'ResearchDefinition.meta', 'min'=>0, 'max'=>1},
      'implicitRules' => {'type'=>'uri', 'path'=>'ResearchDefinition.implicitRules', 'min'=>0, 'max'=>1},
      'language' => {'valid_codes'=>{'urn:ietf:bcp:47'=>['ar', 'bn', 'cs', 'da', 'de', 'de-AT', 'de-CH', 'de-DE', 'el', 'en', 'en-AU', 'en-CA', 'en-GB', 'en-IN', 'en-NZ', 'en-SG', 'en-US', 'es', 'es-AR', 'es-ES', 'es-UY', 'fi', 'fr', 'fr-BE', 'fr-CH', 'fr-FR', 'fy', 'fy-NL', 'hi', 'hr', 'it', 'it-CH', 'it-IT', 'ja', 'ko', 'nl', 'nl-BE', 'nl-NL', 'no', 'no-NO', 'pa', 'pl', 'pt', 'pt-BR', 'ru', 'ru-RU', 'sr', 'sr-RS', 'sv', 'sv-SE', 'te', 'zh', 'zh-CN', 'zh-HK', 'zh-SG', 'zh-TW']}, 'type'=>'code', 'path'=>'ResearchDefinition.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/languages'}},
      'text' => {'type'=>'Narrative', 'path'=>'ResearchDefinition.text', 'min'=>0, 'max'=>1},
      'contained' => {'type'=>'Resource', 'path'=>'ResearchDefinition.contained', 'min'=>0, 'max'=>Float::INFINITY},
      'extension' => {'type'=>'Extension', 'path'=>'ResearchDefinition.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'modifierExtension' => {'type'=>'Extension', 'path'=>'ResearchDefinition.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
      'url' => {'type'=>'uri', 'path'=>'ResearchDefinition.url', 'min'=>0, 'max'=>1},
      'identifier' => {'type'=>'Identifier', 'path'=>'ResearchDefinition.identifier', 'min'=>0, 'max'=>Float::INFINITY},
      'version' => {'type'=>'string', 'path'=>'ResearchDefinition.version', 'min'=>0, 'max'=>1},
      'name' => {'type'=>'string', 'path'=>'ResearchDefinition.name', 'min'=>0, 'max'=>1},
      'title' => {'type'=>'string', 'path'=>'ResearchDefinition.title', 'min'=>0, 'max'=>1},
      'shortTitle' => {'type'=>'string', 'path'=>'ResearchDefinition.shortTitle', 'min'=>0, 'max'=>1},
      'subtitle' => {'type'=>'string', 'path'=>'ResearchDefinition.subtitle', 'min'=>0, 'max'=>1},
      'status' => {'valid_codes'=>{'http://hl7.org/fhir/publication-status'=>['draft', 'active', 'retired', 'unknown']}, 'type'=>'code', 'path'=>'ResearchDefinition.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/publication-status'}},
      'experimental' => {'type'=>'boolean', 'path'=>'ResearchDefinition.experimental', 'min'=>0, 'max'=>1},
      'subjectCodeableConcept' => {'valid_codes'=>{'http://hl7.org/fhir/resource-types'=>['Patient', 'Practitioner', 'Organization', 'Location', 'Device']}, 'type'=>'CodeableConcept', 'path'=>'ResearchDefinition.subject[x]', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/subject-type'}},
      'subjectReference' => {'type_profiles'=>['http://hl7.org/fhir/StructureDefinition/Group'], 'type'=>'Reference', 'path'=>'ResearchDefinition.subject[x]', 'min'=>0, 'max'=>1},
      'date' => {'type'=>'dateTime', 'path'=>'ResearchDefinition.date', 'min'=>0, 'max'=>1},
      'publisher' => {'type'=>'string', 'path'=>'ResearchDefinition.publisher', 'min'=>0, 'max'=>1},
      'contact' => {'type'=>'ContactDetail', 'path'=>'ResearchDefinition.contact', 'min'=>0, 'max'=>Float::INFINITY},
      'description' => {'type'=>'markdown', 'path'=>'ResearchDefinition.description', 'min'=>0, 'max'=>1},
      'comment' => {'type'=>'string', 'path'=>'ResearchDefinition.comment', 'min'=>0, 'max'=>Float::INFINITY},
      'useContext' => {'type'=>'UsageContext', 'path'=>'ResearchDefinition.useContext', 'min'=>0, 'max'=>Float::INFINITY},
      'jurisdiction' => {'type'=>'CodeableConcept', 'path'=>'ResearchDefinition.jurisdiction', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/jurisdiction'}},
      'purpose' => {'type'=>'markdown', 'path'=>'ResearchDefinition.purpose', 'min'=>0, 'max'=>1},
      'usage' => {'type'=>'string', 'path'=>'ResearchDefinition.usage', 'min'=>0, 'max'=>1},
      'copyright' => {'type'=>'markdown', 'path'=>'ResearchDefinition.copyright', 'min'=>0, 'max'=>1},
      'approvalDate' => {'type'=>'date', 'path'=>'ResearchDefinition.approvalDate', 'min'=>0, 'max'=>1},
      'lastReviewDate' => {'type'=>'date', 'path'=>'ResearchDefinition.lastReviewDate', 'min'=>0, 'max'=>1},
      'effectivePeriod' => {'type'=>'Period', 'path'=>'ResearchDefinition.effectivePeriod', 'min'=>0, 'max'=>1},
      'topic' => {'valid_codes'=>{'http://terminology.hl7.org/CodeSystem/definition-topic'=>['treatment', 'education', 'assessment']}, 'type'=>'CodeableConcept', 'path'=>'ResearchDefinition.topic', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'example', 'uri'=>'http://hl7.org/fhir/ValueSet/definition-topic'}},
      'author' => {'type'=>'ContactDetail', 'path'=>'ResearchDefinition.author', 'min'=>0, 'max'=>Float::INFINITY},
      'editor' => {'type'=>'ContactDetail', 'path'=>'ResearchDefinition.editor', 'min'=>0, 'max'=>Float::INFINITY},
      'reviewer' => {'type'=>'ContactDetail', 'path'=>'ResearchDefinition.reviewer', 'min'=>0, 'max'=>Float::INFINITY},
      'endorser' => {'type'=>'ContactDetail', 'path'=>'ResearchDefinition.endorser', 'min'=>0, 'max'=>Float::INFINITY},
      'relatedArtifact' => {'type'=>'RelatedArtifact', 'path'=>'ResearchDefinition.relatedArtifact', 'min'=>0, 'max'=>Float::INFINITY},
      'library' => {'type'=>'canonical', 'path'=>'ResearchDefinition.library', 'min'=>0, 'max'=>Float::INFINITY},
      'population' => {'type_profiles'=>['http://hl7.org/fhir/StructureDefinition/ResearchElementDefinition'], 'type'=>'Reference', 'path'=>'ResearchDefinition.population', 'min'=>1, 'max'=>1},
      'exposure' => {'type_profiles'=>['http://hl7.org/fhir/StructureDefinition/ResearchElementDefinition'], 'type'=>'Reference', 'path'=>'ResearchDefinition.exposure', 'min'=>0, 'max'=>1},
      'exposureAlternative' => {'type_profiles'=>['http://hl7.org/fhir/StructureDefinition/ResearchElementDefinition'], 'type'=>'Reference', 'path'=>'ResearchDefinition.exposureAlternative', 'min'=>0, 'max'=>1},
      'outcome' => {'type_profiles'=>['http://hl7.org/fhir/StructureDefinition/ResearchElementDefinition'], 'type'=>'Reference', 'path'=>'ResearchDefinition.outcome', 'min'=>0, 'max'=>1}
    }

    attr_accessor :id                     # 0-1 id
    attr_accessor :meta                   # 0-1 Meta
    attr_accessor :implicitRules          # 0-1 uri
    attr_accessor :language               # 0-1 code
    attr_accessor :text                   # 0-1 Narrative
    attr_accessor :contained              # 0-* [ Resource ]
    attr_accessor :extension              # 0-* [ Extension ]
    attr_accessor :modifierExtension      # 0-* [ Extension ]
    attr_accessor :url                    # 0-1 uri
    attr_accessor :identifier             # 0-* [ Identifier ]
    attr_accessor :version                # 0-1 string
    attr_accessor :name                   # 0-1 string
    attr_accessor :title                  # 0-1 string
    attr_accessor :shortTitle             # 0-1 string
    attr_accessor :subtitle               # 0-1 string
    attr_accessor :status                 # 1-1 code
    attr_accessor :experimental           # 0-1 boolean
    attr_accessor :subjectCodeableConcept # 0-1 CodeableConcept
    attr_accessor :subjectReference       # 0-1 Reference(Group)
    attr_accessor :date                   # 0-1 dateTime
    attr_accessor :publisher              # 0-1 string
    attr_accessor :contact                # 0-* [ ContactDetail ]
    attr_accessor :description            # 0-1 markdown
    attr_accessor :comment                # 0-* [ string ]
    attr_accessor :useContext             # 0-* [ UsageContext ]
    attr_accessor :jurisdiction           # 0-* [ CodeableConcept ]
    attr_accessor :purpose                # 0-1 markdown
    attr_accessor :usage                  # 0-1 string
    attr_accessor :copyright              # 0-1 markdown
    attr_accessor :approvalDate           # 0-1 date
    attr_accessor :lastReviewDate         # 0-1 date
    attr_accessor :effectivePeriod        # 0-1 Period
    attr_accessor :topic                  # 0-* [ CodeableConcept ]
    attr_accessor :author                 # 0-* [ ContactDetail ]
    attr_accessor :editor                 # 0-* [ ContactDetail ]
    attr_accessor :reviewer               # 0-* [ ContactDetail ]
    attr_accessor :endorser               # 0-* [ ContactDetail ]
    attr_accessor :relatedArtifact        # 0-* [ RelatedArtifact ]
    attr_accessor :library                # 0-* [ canonical ]
    attr_accessor :population             # 1-1 Reference(ResearchElementDefinition)
    attr_accessor :exposure               # 0-1 Reference(ResearchElementDefinition)
    attr_accessor :exposureAlternative    # 0-1 Reference(ResearchElementDefinition)
    attr_accessor :outcome                # 0-1 Reference(ResearchElementDefinition)

    def resourceType
      'ResearchDefinition'
    end
  end
end