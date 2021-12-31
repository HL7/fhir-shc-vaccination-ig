module FHIR
  class NamingSystem < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = ['context', 'context-quantity', 'context-type', 'date', 'description', 'jurisdiction', 'name', 'publisher', 'status', 'contact', 'id-type', 'kind', 'period', 'responsible', 'telecom', 'type', 'value']
    METADATA = {
      'id' => {'type'=>'id', 'path'=>'NamingSystem.id', 'min'=>0, 'max'=>1},
      'meta' => {'type'=>'Meta', 'path'=>'NamingSystem.meta', 'min'=>0, 'max'=>1},
      'implicitRules' => {'type'=>'uri', 'path'=>'NamingSystem.implicitRules', 'min'=>0, 'max'=>1},
      'language' => {'valid_codes'=>{'urn:ietf:bcp:47'=>['ar', 'bn', 'cs', 'da', 'de', 'de-AT', 'de-CH', 'de-DE', 'el', 'en', 'en-AU', 'en-CA', 'en-GB', 'en-IN', 'en-NZ', 'en-SG', 'en-US', 'es', 'es-AR', 'es-ES', 'es-UY', 'fi', 'fr', 'fr-BE', 'fr-CH', 'fr-FR', 'fy', 'fy-NL', 'hi', 'hr', 'it', 'it-CH', 'it-IT', 'ja', 'ko', 'nl', 'nl-BE', 'nl-NL', 'no', 'no-NO', 'pa', 'pl', 'pt', 'pt-BR', 'ru', 'ru-RU', 'sr', 'sr-RS', 'sv', 'sv-SE', 'te', 'zh', 'zh-CN', 'zh-HK', 'zh-SG', 'zh-TW']}, 'type'=>'code', 'path'=>'NamingSystem.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/languages'}},
      'text' => {'type'=>'Narrative', 'path'=>'NamingSystem.text', 'min'=>0, 'max'=>1},
      'contained' => {'type'=>'Resource', 'path'=>'NamingSystem.contained', 'min'=>0, 'max'=>Float::INFINITY},
      'extension' => {'type'=>'Extension', 'path'=>'NamingSystem.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'modifierExtension' => {'type'=>'Extension', 'path'=>'NamingSystem.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
      'name' => {'type'=>'string', 'path'=>'NamingSystem.name', 'min'=>1, 'max'=>1},
      'status' => {'valid_codes'=>{'http://hl7.org/fhir/publication-status'=>['draft', 'active', 'retired', 'unknown']}, 'type'=>'code', 'path'=>'NamingSystem.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/publication-status'}},
      'kind' => {'valid_codes'=>{'http://hl7.org/fhir/namingsystem-type'=>['codesystem', 'identifier', 'root']}, 'type'=>'code', 'path'=>'NamingSystem.kind', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/namingsystem-type'}},
      'date' => {'type'=>'dateTime', 'path'=>'NamingSystem.date', 'min'=>1, 'max'=>1},
      'publisher' => {'type'=>'string', 'path'=>'NamingSystem.publisher', 'min'=>0, 'max'=>1},
      'contact' => {'type'=>'ContactDetail', 'path'=>'NamingSystem.contact', 'min'=>0, 'max'=>Float::INFINITY},
      'responsible' => {'type'=>'string', 'path'=>'NamingSystem.responsible', 'min'=>0, 'max'=>1},
      'type' => {'valid_codes'=>{'http://terminology.hl7.org/CodeSystem/v2-0203'=>['DL', 'PPN', 'BRN', 'MR', 'MCN', 'EN', 'TAX', 'NIIP', 'PRN', 'MD', 'DR', 'ACSN', 'UDI', 'SNO', 'SB', 'PLAC', 'FILL', 'JHN']}, 'type'=>'CodeableConcept', 'path'=>'NamingSystem.type', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/identifier-type'}},
      'description' => {'type'=>'markdown', 'path'=>'NamingSystem.description', 'min'=>0, 'max'=>1},
      'useContext' => {'type'=>'UsageContext', 'path'=>'NamingSystem.useContext', 'min'=>0, 'max'=>Float::INFINITY},
      'jurisdiction' => {'type'=>'CodeableConcept', 'path'=>'NamingSystem.jurisdiction', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/jurisdiction'}},
      'usage' => {'type'=>'string', 'path'=>'NamingSystem.usage', 'min'=>0, 'max'=>1},
      'uniqueId' => {'type'=>'NamingSystem::UniqueId', 'path'=>'NamingSystem.uniqueId', 'min'=>1, 'max'=>Float::INFINITY}
    }

    class UniqueId < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'UniqueId.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'UniqueId.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'UniqueId.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'type' => {'valid_codes'=>{'http://hl7.org/fhir/namingsystem-identifier-type'=>['oid', 'uuid', 'uri', 'other']}, 'type'=>'code', 'path'=>'UniqueId.type', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/namingsystem-identifier-type'}},
        'value' => {'type'=>'string', 'path'=>'UniqueId.value', 'min'=>1, 'max'=>1},
        'preferred' => {'type'=>'boolean', 'path'=>'UniqueId.preferred', 'min'=>0, 'max'=>1},
        'comment' => {'type'=>'string', 'path'=>'UniqueId.comment', 'min'=>0, 'max'=>1},
        'period' => {'type'=>'Period', 'path'=>'UniqueId.period', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :type              # 1-1 code
      attr_accessor :value             # 1-1 string
      attr_accessor :preferred         # 0-1 boolean
      attr_accessor :comment           # 0-1 string
      attr_accessor :period            # 0-1 Period
    end

    attr_accessor :id                # 0-1 id
    attr_accessor :meta              # 0-1 Meta
    attr_accessor :implicitRules     # 0-1 uri
    attr_accessor :language          # 0-1 code
    attr_accessor :text              # 0-1 Narrative
    attr_accessor :contained         # 0-* [ Resource ]
    attr_accessor :extension         # 0-* [ Extension ]
    attr_accessor :modifierExtension # 0-* [ Extension ]
    attr_accessor :name              # 1-1 string
    attr_accessor :status            # 1-1 code
    attr_accessor :kind              # 1-1 code
    attr_accessor :date              # 1-1 dateTime
    attr_accessor :publisher         # 0-1 string
    attr_accessor :contact           # 0-* [ ContactDetail ]
    attr_accessor :responsible       # 0-1 string
    attr_accessor :type              # 0-1 CodeableConcept
    attr_accessor :description       # 0-1 markdown
    attr_accessor :useContext        # 0-* [ UsageContext ]
    attr_accessor :jurisdiction      # 0-* [ CodeableConcept ]
    attr_accessor :usage             # 0-1 string
    attr_accessor :uniqueId          # 1-* [ NamingSystem::UniqueId ]

    def resourceType
      'NamingSystem'
    end
  end
end