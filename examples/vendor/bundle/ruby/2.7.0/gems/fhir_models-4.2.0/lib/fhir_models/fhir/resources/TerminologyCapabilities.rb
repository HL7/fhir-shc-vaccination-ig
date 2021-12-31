module FHIR
  class TerminologyCapabilities < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = ['context', 'context-quantity', 'context-type', 'date', 'description', 'jurisdiction', 'name', 'publisher', 'status', 'title', 'url', 'version']
    METADATA = {
      'id' => {'type'=>'id', 'path'=>'TerminologyCapabilities.id', 'min'=>0, 'max'=>1},
      'meta' => {'type'=>'Meta', 'path'=>'TerminologyCapabilities.meta', 'min'=>0, 'max'=>1},
      'implicitRules' => {'type'=>'uri', 'path'=>'TerminologyCapabilities.implicitRules', 'min'=>0, 'max'=>1},
      'language' => {'valid_codes'=>{'urn:ietf:bcp:47'=>['ar', 'bn', 'cs', 'da', 'de', 'de-AT', 'de-CH', 'de-DE', 'el', 'en', 'en-AU', 'en-CA', 'en-GB', 'en-IN', 'en-NZ', 'en-SG', 'en-US', 'es', 'es-AR', 'es-ES', 'es-UY', 'fi', 'fr', 'fr-BE', 'fr-CH', 'fr-FR', 'fy', 'fy-NL', 'hi', 'hr', 'it', 'it-CH', 'it-IT', 'ja', 'ko', 'nl', 'nl-BE', 'nl-NL', 'no', 'no-NO', 'pa', 'pl', 'pt', 'pt-BR', 'ru', 'ru-RU', 'sr', 'sr-RS', 'sv', 'sv-SE', 'te', 'zh', 'zh-CN', 'zh-HK', 'zh-SG', 'zh-TW']}, 'type'=>'code', 'path'=>'TerminologyCapabilities.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/languages'}},
      'text' => {'type'=>'Narrative', 'path'=>'TerminologyCapabilities.text', 'min'=>0, 'max'=>1},
      'contained' => {'type'=>'Resource', 'path'=>'TerminologyCapabilities.contained', 'min'=>0, 'max'=>Float::INFINITY},
      'extension' => {'type'=>'Extension', 'path'=>'TerminologyCapabilities.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'modifierExtension' => {'type'=>'Extension', 'path'=>'TerminologyCapabilities.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
      'url' => {'type'=>'uri', 'path'=>'TerminologyCapabilities.url', 'min'=>0, 'max'=>1},
      'version' => {'type'=>'string', 'path'=>'TerminologyCapabilities.version', 'min'=>0, 'max'=>1},
      'name' => {'type'=>'string', 'path'=>'TerminologyCapabilities.name', 'min'=>0, 'max'=>1},
      'title' => {'type'=>'string', 'path'=>'TerminologyCapabilities.title', 'min'=>0, 'max'=>1},
      'status' => {'valid_codes'=>{'http://hl7.org/fhir/publication-status'=>['draft', 'active', 'retired', 'unknown']}, 'type'=>'code', 'path'=>'TerminologyCapabilities.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/publication-status'}},
      'experimental' => {'type'=>'boolean', 'path'=>'TerminologyCapabilities.experimental', 'min'=>0, 'max'=>1},
      'date' => {'type'=>'dateTime', 'path'=>'TerminologyCapabilities.date', 'min'=>1, 'max'=>1},
      'publisher' => {'type'=>'string', 'path'=>'TerminologyCapabilities.publisher', 'min'=>0, 'max'=>1},
      'contact' => {'type'=>'ContactDetail', 'path'=>'TerminologyCapabilities.contact', 'min'=>0, 'max'=>Float::INFINITY},
      'description' => {'type'=>'markdown', 'path'=>'TerminologyCapabilities.description', 'min'=>0, 'max'=>1},
      'useContext' => {'type'=>'UsageContext', 'path'=>'TerminologyCapabilities.useContext', 'min'=>0, 'max'=>Float::INFINITY},
      'jurisdiction' => {'type'=>'CodeableConcept', 'path'=>'TerminologyCapabilities.jurisdiction', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/jurisdiction'}},
      'purpose' => {'type'=>'markdown', 'path'=>'TerminologyCapabilities.purpose', 'min'=>0, 'max'=>1},
      'copyright' => {'type'=>'markdown', 'path'=>'TerminologyCapabilities.copyright', 'min'=>0, 'max'=>1},
      'kind' => {'valid_codes'=>{'http://hl7.org/fhir/capability-statement-kind'=>['instance', 'capability', 'requirements']}, 'type'=>'code', 'path'=>'TerminologyCapabilities.kind', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/capability-statement-kind'}},
      'software' => {'type'=>'TerminologyCapabilities::Software', 'path'=>'TerminologyCapabilities.software', 'min'=>0, 'max'=>1},
      'implementation' => {'type'=>'TerminologyCapabilities::Implementation', 'path'=>'TerminologyCapabilities.implementation', 'min'=>0, 'max'=>1},
      'lockedDate' => {'type'=>'boolean', 'path'=>'TerminologyCapabilities.lockedDate', 'min'=>0, 'max'=>1},
      'codeSystem' => {'type'=>'TerminologyCapabilities::CodeSystem', 'path'=>'TerminologyCapabilities.codeSystem', 'min'=>0, 'max'=>Float::INFINITY},
      'expansion' => {'type'=>'TerminologyCapabilities::Expansion', 'path'=>'TerminologyCapabilities.expansion', 'min'=>0, 'max'=>1},
      'codeSearch' => {'valid_codes'=>{'http://hl7.org/fhir/code-search-support'=>['explicit', 'all']}, 'type'=>'code', 'path'=>'TerminologyCapabilities.codeSearch', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/code-search-support'}},
      'validateCode' => {'type'=>'TerminologyCapabilities::ValidateCode', 'path'=>'TerminologyCapabilities.validateCode', 'min'=>0, 'max'=>1},
      'translation' => {'type'=>'TerminologyCapabilities::Translation', 'path'=>'TerminologyCapabilities.translation', 'min'=>0, 'max'=>1},
      'closure' => {'type'=>'TerminologyCapabilities::Closure', 'path'=>'TerminologyCapabilities.closure', 'min'=>0, 'max'=>1}
    }

    class Software < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Software.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Software.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Software.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'name' => {'type'=>'string', 'path'=>'Software.name', 'min'=>1, 'max'=>1},
        'version' => {'type'=>'string', 'path'=>'Software.version', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :name              # 1-1 string
      attr_accessor :version           # 0-1 string
    end

    class Implementation < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Implementation.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Implementation.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Implementation.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'description' => {'type'=>'string', 'path'=>'Implementation.description', 'min'=>1, 'max'=>1},
        'url' => {'type'=>'url', 'path'=>'Implementation.url', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :description       # 1-1 string
      attr_accessor :url               # 0-1 url
    end

    class CodeSystem < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'CodeSystem.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'CodeSystem.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'CodeSystem.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'uri' => {'type'=>'canonical', 'path'=>'CodeSystem.uri', 'min'=>0, 'max'=>1},
        'version' => {'type'=>'TerminologyCapabilities::CodeSystem::Version', 'path'=>'CodeSystem.version', 'min'=>0, 'max'=>Float::INFINITY},
        'subsumption' => {'type'=>'boolean', 'path'=>'CodeSystem.subsumption', 'min'=>0, 'max'=>1}
      }

      class Version < FHIR::Model
        include FHIR::Hashable
        include FHIR::Json
        include FHIR::Xml

        METADATA = {
          'id' => {'type'=>'string', 'path'=>'Version.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Version.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Version.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'code' => {'type'=>'string', 'path'=>'Version.code', 'min'=>0, 'max'=>1},
          'isDefault' => {'type'=>'boolean', 'path'=>'Version.isDefault', 'min'=>0, 'max'=>1},
          'compositional' => {'type'=>'boolean', 'path'=>'Version.compositional', 'min'=>0, 'max'=>1},
          'language' => {'type'=>'code', 'path'=>'Version.language', 'min'=>0, 'max'=>Float::INFINITY},
          'filter' => {'type'=>'TerminologyCapabilities::CodeSystem::Version::Filter', 'path'=>'Version.filter', 'min'=>0, 'max'=>Float::INFINITY},
          'property' => {'type'=>'code', 'path'=>'Version.property', 'min'=>0, 'max'=>Float::INFINITY}
        }

        class Filter < FHIR::Model
          include FHIR::Hashable
          include FHIR::Json
          include FHIR::Xml

          METADATA = {
            'id' => {'type'=>'string', 'path'=>'Filter.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Filter.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Filter.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'code' => {'type'=>'code', 'path'=>'Filter.code', 'min'=>1, 'max'=>1},
            'op' => {'type'=>'code', 'path'=>'Filter.op', 'min'=>1, 'max'=>Float::INFINITY}
          }

          attr_accessor :id                # 0-1 string
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :code              # 1-1 code
          attr_accessor :op                # 1-* [ code ]
        end

        attr_accessor :id                # 0-1 string
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :code              # 0-1 string
        attr_accessor :isDefault         # 0-1 boolean
        attr_accessor :compositional     # 0-1 boolean
        attr_accessor :language          # 0-* [ code ]
        attr_accessor :filter            # 0-* [ TerminologyCapabilities::CodeSystem::Version::Filter ]
        attr_accessor :property          # 0-* [ code ]
      end

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :uri               # 0-1 canonical
      attr_accessor :version           # 0-* [ TerminologyCapabilities::CodeSystem::Version ]
      attr_accessor :subsumption       # 0-1 boolean
    end

    class Expansion < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Expansion.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Expansion.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Expansion.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'hierarchical' => {'type'=>'boolean', 'path'=>'Expansion.hierarchical', 'min'=>0, 'max'=>1},
        'paging' => {'type'=>'boolean', 'path'=>'Expansion.paging', 'min'=>0, 'max'=>1},
        'incomplete' => {'type'=>'boolean', 'path'=>'Expansion.incomplete', 'min'=>0, 'max'=>1},
        'parameter' => {'type'=>'TerminologyCapabilities::Expansion::Parameter', 'path'=>'Expansion.parameter', 'min'=>0, 'max'=>Float::INFINITY},
        'textFilter' => {'type'=>'markdown', 'path'=>'Expansion.textFilter', 'min'=>0, 'max'=>1}
      }

      class Parameter < FHIR::Model
        include FHIR::Hashable
        include FHIR::Json
        include FHIR::Xml

        METADATA = {
          'id' => {'type'=>'string', 'path'=>'Parameter.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Parameter.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Parameter.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'code', 'path'=>'Parameter.name', 'min'=>1, 'max'=>1},
          'documentation' => {'type'=>'string', 'path'=>'Parameter.documentation', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 string
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 1-1 code
        attr_accessor :documentation     # 0-1 string
      end

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :hierarchical      # 0-1 boolean
      attr_accessor :paging            # 0-1 boolean
      attr_accessor :incomplete        # 0-1 boolean
      attr_accessor :parameter         # 0-* [ TerminologyCapabilities::Expansion::Parameter ]
      attr_accessor :textFilter        # 0-1 markdown
    end

    class ValidateCode < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'ValidateCode.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'ValidateCode.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'ValidateCode.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'translations' => {'type'=>'boolean', 'path'=>'ValidateCode.translations', 'min'=>1, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :translations      # 1-1 boolean
    end

    class Translation < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Translation.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Translation.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Translation.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'needsMap' => {'type'=>'boolean', 'path'=>'Translation.needsMap', 'min'=>1, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :needsMap          # 1-1 boolean
    end

    class Closure < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Closure.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Closure.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Closure.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'translation' => {'type'=>'boolean', 'path'=>'Closure.translation', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :translation       # 0-1 boolean
    end

    attr_accessor :id                # 0-1 id
    attr_accessor :meta              # 0-1 Meta
    attr_accessor :implicitRules     # 0-1 uri
    attr_accessor :language          # 0-1 code
    attr_accessor :text              # 0-1 Narrative
    attr_accessor :contained         # 0-* [ Resource ]
    attr_accessor :extension         # 0-* [ Extension ]
    attr_accessor :modifierExtension # 0-* [ Extension ]
    attr_accessor :url               # 0-1 uri
    attr_accessor :version           # 0-1 string
    attr_accessor :name              # 0-1 string
    attr_accessor :title             # 0-1 string
    attr_accessor :status            # 1-1 code
    attr_accessor :experimental      # 0-1 boolean
    attr_accessor :date              # 1-1 dateTime
    attr_accessor :publisher         # 0-1 string
    attr_accessor :contact           # 0-* [ ContactDetail ]
    attr_accessor :description       # 0-1 markdown
    attr_accessor :useContext        # 0-* [ UsageContext ]
    attr_accessor :jurisdiction      # 0-* [ CodeableConcept ]
    attr_accessor :purpose           # 0-1 markdown
    attr_accessor :copyright         # 0-1 markdown
    attr_accessor :kind              # 1-1 code
    attr_accessor :software          # 0-1 TerminologyCapabilities::Software
    attr_accessor :implementation    # 0-1 TerminologyCapabilities::Implementation
    attr_accessor :lockedDate        # 0-1 boolean
    attr_accessor :codeSystem        # 0-* [ TerminologyCapabilities::CodeSystem ]
    attr_accessor :expansion         # 0-1 TerminologyCapabilities::Expansion
    attr_accessor :codeSearch        # 0-1 code
    attr_accessor :validateCode      # 0-1 TerminologyCapabilities::ValidateCode
    attr_accessor :translation       # 0-1 TerminologyCapabilities::Translation
    attr_accessor :closure           # 0-1 TerminologyCapabilities::Closure

    def resourceType
      'TerminologyCapabilities'
    end
  end
end