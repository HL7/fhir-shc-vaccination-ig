module FHIR
  class StructureMap < FHIR::Model
    include FHIR::Hashable
    include FHIR::Json
    include FHIR::Xml

    SEARCH_PARAMS = ['context', 'context-quantity', 'context-type', 'date', 'description', 'jurisdiction', 'name', 'publisher', 'status', 'title', 'url', 'version', 'identifier']
    METADATA = {
      'id' => {'type'=>'id', 'path'=>'StructureMap.id', 'min'=>0, 'max'=>1},
      'meta' => {'type'=>'Meta', 'path'=>'StructureMap.meta', 'min'=>0, 'max'=>1},
      'implicitRules' => {'type'=>'uri', 'path'=>'StructureMap.implicitRules', 'min'=>0, 'max'=>1},
      'language' => {'valid_codes'=>{'urn:ietf:bcp:47'=>['ar', 'bn', 'cs', 'da', 'de', 'de-AT', 'de-CH', 'de-DE', 'el', 'en', 'en-AU', 'en-CA', 'en-GB', 'en-IN', 'en-NZ', 'en-SG', 'en-US', 'es', 'es-AR', 'es-ES', 'es-UY', 'fi', 'fr', 'fr-BE', 'fr-CH', 'fr-FR', 'fy', 'fy-NL', 'hi', 'hr', 'it', 'it-CH', 'it-IT', 'ja', 'ko', 'nl', 'nl-BE', 'nl-NL', 'no', 'no-NO', 'pa', 'pl', 'pt', 'pt-BR', 'ru', 'ru-RU', 'sr', 'sr-RS', 'sv', 'sv-SE', 'te', 'zh', 'zh-CN', 'zh-HK', 'zh-SG', 'zh-TW']}, 'type'=>'code', 'path'=>'StructureMap.language', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'preferred', 'uri'=>'http://hl7.org/fhir/ValueSet/languages'}},
      'text' => {'type'=>'Narrative', 'path'=>'StructureMap.text', 'min'=>0, 'max'=>1},
      'contained' => {'type'=>'Resource', 'path'=>'StructureMap.contained', 'min'=>0, 'max'=>Float::INFINITY},
      'extension' => {'type'=>'Extension', 'path'=>'StructureMap.extension', 'min'=>0, 'max'=>Float::INFINITY},
      'modifierExtension' => {'type'=>'Extension', 'path'=>'StructureMap.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
      'url' => {'type'=>'uri', 'path'=>'StructureMap.url', 'min'=>1, 'max'=>1},
      'identifier' => {'type'=>'Identifier', 'path'=>'StructureMap.identifier', 'min'=>0, 'max'=>Float::INFINITY},
      'version' => {'type'=>'string', 'path'=>'StructureMap.version', 'min'=>0, 'max'=>1},
      'name' => {'type'=>'string', 'path'=>'StructureMap.name', 'min'=>1, 'max'=>1},
      'title' => {'type'=>'string', 'path'=>'StructureMap.title', 'min'=>0, 'max'=>1},
      'status' => {'valid_codes'=>{'http://hl7.org/fhir/publication-status'=>['draft', 'active', 'retired', 'unknown']}, 'type'=>'code', 'path'=>'StructureMap.status', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/publication-status'}},
      'experimental' => {'type'=>'boolean', 'path'=>'StructureMap.experimental', 'min'=>0, 'max'=>1},
      'date' => {'type'=>'dateTime', 'path'=>'StructureMap.date', 'min'=>0, 'max'=>1},
      'publisher' => {'type'=>'string', 'path'=>'StructureMap.publisher', 'min'=>0, 'max'=>1},
      'contact' => {'type'=>'ContactDetail', 'path'=>'StructureMap.contact', 'min'=>0, 'max'=>Float::INFINITY},
      'description' => {'type'=>'markdown', 'path'=>'StructureMap.description', 'min'=>0, 'max'=>1},
      'useContext' => {'type'=>'UsageContext', 'path'=>'StructureMap.useContext', 'min'=>0, 'max'=>Float::INFINITY},
      'jurisdiction' => {'type'=>'CodeableConcept', 'path'=>'StructureMap.jurisdiction', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'extensible', 'uri'=>'http://hl7.org/fhir/ValueSet/jurisdiction'}},
      'purpose' => {'type'=>'markdown', 'path'=>'StructureMap.purpose', 'min'=>0, 'max'=>1},
      'copyright' => {'type'=>'markdown', 'path'=>'StructureMap.copyright', 'min'=>0, 'max'=>1},
      'structure' => {'type'=>'StructureMap::Structure', 'path'=>'StructureMap.structure', 'min'=>0, 'max'=>Float::INFINITY},
      'import' => {'type'=>'canonical', 'path'=>'StructureMap.import', 'min'=>0, 'max'=>Float::INFINITY},
      'group' => {'type'=>'StructureMap::Group', 'path'=>'StructureMap.group', 'min'=>1, 'max'=>Float::INFINITY}
    }

    class Structure < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Structure.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Structure.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Structure.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'url' => {'type'=>'canonical', 'path'=>'Structure.url', 'min'=>1, 'max'=>1},
        'mode' => {'valid_codes'=>{'http://hl7.org/fhir/map-model-mode'=>['source', 'queried', 'target', 'produced']}, 'type'=>'code', 'path'=>'Structure.mode', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-model-mode'}},
        'alias' => {'type'=>'string', 'path'=>'Structure.alias', 'min'=>0, 'max'=>1},
        'documentation' => {'type'=>'string', 'path'=>'Structure.documentation', 'min'=>0, 'max'=>1}
      }

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :url               # 1-1 canonical
      attr_accessor :mode              # 1-1 code
      attr_accessor :alias             # 0-1 string
      attr_accessor :documentation     # 0-1 string
    end

    class Group < FHIR::Model
      include FHIR::Hashable
      include FHIR::Json
      include FHIR::Xml

      METADATA = {
        'id' => {'type'=>'string', 'path'=>'Group.id', 'min'=>0, 'max'=>1},
        'extension' => {'type'=>'Extension', 'path'=>'Group.extension', 'min'=>0, 'max'=>Float::INFINITY},
        'modifierExtension' => {'type'=>'Extension', 'path'=>'Group.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
        'name' => {'type'=>'id', 'path'=>'Group.name', 'min'=>1, 'max'=>1},
        'extends' => {'type'=>'id', 'path'=>'Group.extends', 'min'=>0, 'max'=>1},
        'typeMode' => {'valid_codes'=>{'http://hl7.org/fhir/map-group-type-mode'=>['none', 'types', 'type-and-types']}, 'type'=>'code', 'path'=>'Group.typeMode', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-group-type-mode'}},
        'documentation' => {'type'=>'string', 'path'=>'Group.documentation', 'min'=>0, 'max'=>1},
        'input' => {'type'=>'StructureMap::Group::Input', 'path'=>'Group.input', 'min'=>1, 'max'=>Float::INFINITY},
        'rule' => {'type'=>'StructureMap::Group::Rule', 'path'=>'Group.rule', 'min'=>1, 'max'=>Float::INFINITY}
      }

      class Input < FHIR::Model
        include FHIR::Hashable
        include FHIR::Json
        include FHIR::Xml

        METADATA = {
          'id' => {'type'=>'string', 'path'=>'Input.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Input.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Input.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'id', 'path'=>'Input.name', 'min'=>1, 'max'=>1},
          'type' => {'type'=>'string', 'path'=>'Input.type', 'min'=>0, 'max'=>1},
          'mode' => {'valid_codes'=>{'http://hl7.org/fhir/map-input-mode'=>['source', 'target']}, 'type'=>'code', 'path'=>'Input.mode', 'min'=>1, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-input-mode'}},
          'documentation' => {'type'=>'string', 'path'=>'Input.documentation', 'min'=>0, 'max'=>1}
        }

        attr_accessor :id                # 0-1 string
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 1-1 id
        attr_accessor :type              # 0-1 string
        attr_accessor :mode              # 1-1 code
        attr_accessor :documentation     # 0-1 string
      end

      class Rule < FHIR::Model
        include FHIR::Hashable
        include FHIR::Json
        include FHIR::Xml

        METADATA = {
          'id' => {'type'=>'string', 'path'=>'Rule.id', 'min'=>0, 'max'=>1},
          'extension' => {'type'=>'Extension', 'path'=>'Rule.extension', 'min'=>0, 'max'=>Float::INFINITY},
          'modifierExtension' => {'type'=>'Extension', 'path'=>'Rule.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
          'name' => {'type'=>'id', 'path'=>'Rule.name', 'min'=>1, 'max'=>1},
          'source' => {'type'=>'StructureMap::Group::Rule::Source', 'path'=>'Rule.source', 'min'=>1, 'max'=>Float::INFINITY},
          'target' => {'type'=>'StructureMap::Group::Rule::Target', 'path'=>'Rule.target', 'min'=>0, 'max'=>Float::INFINITY},
          'rule' => {'type'=>'StructureMap::Group::Rule', 'path'=>'Rule.rule', 'min'=>0, 'max'=>Float::INFINITY},
          'dependent' => {'type'=>'StructureMap::Group::Rule::Dependent', 'path'=>'Rule.dependent', 'min'=>0, 'max'=>Float::INFINITY},
          'documentation' => {'type'=>'string', 'path'=>'Rule.documentation', 'min'=>0, 'max'=>1}
        }

        class Source < FHIR::Model
          include FHIR::Hashable
          include FHIR::Json
          include FHIR::Xml

          MULTIPLE_TYPES = {
            'defaultValue' => ['base64Binary', 'boolean', 'canonical', 'code', 'date', 'dateTime', 'decimal', 'id', 'instant', 'integer', 'markdown', 'oid', 'positiveInt', 'string', 'time', 'unsignedInt', 'uri', 'url', 'uuid', 'Address', 'Age', 'Annotation', 'Attachment', 'CodeableConcept', 'Coding', 'ContactPoint', 'Count', 'Distance', 'Duration', 'HumanName', 'Identifier', 'Money', 'Period', 'Quantity', 'Range', 'Ratio', 'Reference', 'SampledData', 'Signature', 'Timing', 'ContactDetail', 'Contributor', 'DataRequirement', 'Expression', 'ParameterDefinition', 'RelatedArtifact', 'TriggerDefinition', 'UsageContext', 'Dosage', 'Meta']
          }
          METADATA = {
            'id' => {'type'=>'string', 'path'=>'Source.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Source.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Source.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'context' => {'type'=>'id', 'path'=>'Source.context', 'min'=>1, 'max'=>1},
            'min' => {'type'=>'integer', 'path'=>'Source.min', 'min'=>0, 'max'=>1},
            'max' => {'type'=>'string', 'path'=>'Source.max', 'min'=>0, 'max'=>1},
            'type' => {'type'=>'string', 'path'=>'Source.type', 'min'=>0, 'max'=>1},
            'defaultValueBase64Binary' => {'type'=>'base64Binary', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueBoolean' => {'type'=>'boolean', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueCanonical' => {'type'=>'canonical', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueCode' => {'type'=>'code', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDate' => {'type'=>'date', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDateTime' => {'type'=>'dateTime', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDecimal' => {'type'=>'decimal', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueId' => {'type'=>'id', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueInstant' => {'type'=>'instant', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueInteger' => {'type'=>'integer', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueMarkdown' => {'type'=>'markdown', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueOid' => {'type'=>'oid', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValuePositiveInt' => {'type'=>'positiveInt', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueString' => {'type'=>'string', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueTime' => {'type'=>'time', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueUnsignedInt' => {'type'=>'unsignedInt', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueUri' => {'type'=>'uri', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueUrl' => {'type'=>'url', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueUuid' => {'type'=>'uuid', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueAddress' => {'type'=>'Address', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueAge' => {'type'=>'Age', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueAnnotation' => {'type'=>'Annotation', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueAttachment' => {'type'=>'Attachment', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueCodeableConcept' => {'type'=>'CodeableConcept', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueCoding' => {'type'=>'Coding', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueContactPoint' => {'type'=>'ContactPoint', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueCount' => {'type'=>'Count', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDistance' => {'type'=>'Distance', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDuration' => {'type'=>'Duration', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueHumanName' => {'type'=>'HumanName', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueIdentifier' => {'type'=>'Identifier', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueMoney' => {'type'=>'Money', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValuePeriod' => {'type'=>'Period', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueQuantity' => {'type'=>'Quantity', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueRange' => {'type'=>'Range', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueRatio' => {'type'=>'Ratio', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueReference' => {'type'=>'Reference', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueSampledData' => {'type'=>'SampledData', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueSignature' => {'type'=>'Signature', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueTiming' => {'type'=>'Timing', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueContactDetail' => {'type'=>'ContactDetail', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueContributor' => {'type'=>'Contributor', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDataRequirement' => {'type'=>'DataRequirement', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueExpression' => {'type'=>'Expression', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueParameterDefinition' => {'type'=>'ParameterDefinition', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueRelatedArtifact' => {'type'=>'RelatedArtifact', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueTriggerDefinition' => {'type'=>'TriggerDefinition', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueUsageContext' => {'type'=>'UsageContext', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueDosage' => {'type'=>'Dosage', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'defaultValueMeta' => {'type'=>'Meta', 'path'=>'Source.defaultValue[x]', 'min'=>0, 'max'=>1},
            'element' => {'type'=>'string', 'path'=>'Source.element', 'min'=>0, 'max'=>1},
            'listMode' => {'valid_codes'=>{'http://hl7.org/fhir/map-source-list-mode'=>['first', 'not_first', 'last', 'not_last', 'only_one']}, 'type'=>'code', 'path'=>'Source.listMode', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-source-list-mode'}},
            'variable' => {'type'=>'id', 'path'=>'Source.variable', 'min'=>0, 'max'=>1},
            'condition' => {'type'=>'string', 'path'=>'Source.condition', 'min'=>0, 'max'=>1},
            'check' => {'type'=>'string', 'path'=>'Source.check', 'min'=>0, 'max'=>1},
            'logMessage' => {'type'=>'string', 'path'=>'Source.logMessage', 'min'=>0, 'max'=>1}
          }

          attr_accessor :id                              # 0-1 string
          attr_accessor :extension                       # 0-* [ Extension ]
          attr_accessor :modifierExtension               # 0-* [ Extension ]
          attr_accessor :context                         # 1-1 id
          attr_accessor :min                             # 0-1 integer
          attr_accessor :max                             # 0-1 string
          attr_accessor :type                            # 0-1 string
          attr_accessor :defaultValueBase64Binary        # 0-1 base64Binary
          attr_accessor :defaultValueBoolean             # 0-1 boolean
          attr_accessor :defaultValueCanonical           # 0-1 canonical
          attr_accessor :defaultValueCode                # 0-1 code
          attr_accessor :defaultValueDate                # 0-1 date
          attr_accessor :defaultValueDateTime            # 0-1 dateTime
          attr_accessor :defaultValueDecimal             # 0-1 decimal
          attr_accessor :defaultValueId                  # 0-1 id
          attr_accessor :defaultValueInstant             # 0-1 instant
          attr_accessor :defaultValueInteger             # 0-1 integer
          attr_accessor :defaultValueMarkdown            # 0-1 markdown
          attr_accessor :defaultValueOid                 # 0-1 oid
          attr_accessor :defaultValuePositiveInt         # 0-1 positiveInt
          attr_accessor :defaultValueString              # 0-1 string
          attr_accessor :defaultValueTime                # 0-1 time
          attr_accessor :defaultValueUnsignedInt         # 0-1 unsignedInt
          attr_accessor :defaultValueUri                 # 0-1 uri
          attr_accessor :defaultValueUrl                 # 0-1 url
          attr_accessor :defaultValueUuid                # 0-1 uuid
          attr_accessor :defaultValueAddress             # 0-1 Address
          attr_accessor :defaultValueAge                 # 0-1 Age
          attr_accessor :defaultValueAnnotation          # 0-1 Annotation
          attr_accessor :defaultValueAttachment          # 0-1 Attachment
          attr_accessor :defaultValueCodeableConcept     # 0-1 CodeableConcept
          attr_accessor :defaultValueCoding              # 0-1 Coding
          attr_accessor :defaultValueContactPoint        # 0-1 ContactPoint
          attr_accessor :defaultValueCount               # 0-1 Count
          attr_accessor :defaultValueDistance            # 0-1 Distance
          attr_accessor :defaultValueDuration            # 0-1 Duration
          attr_accessor :defaultValueHumanName           # 0-1 HumanName
          attr_accessor :defaultValueIdentifier          # 0-1 Identifier
          attr_accessor :defaultValueMoney               # 0-1 Money
          attr_accessor :defaultValuePeriod              # 0-1 Period
          attr_accessor :defaultValueQuantity            # 0-1 Quantity
          attr_accessor :defaultValueRange               # 0-1 Range
          attr_accessor :defaultValueRatio               # 0-1 Ratio
          attr_accessor :defaultValueReference           # 0-1 Reference()
          attr_accessor :defaultValueSampledData         # 0-1 SampledData
          attr_accessor :defaultValueSignature           # 0-1 Signature
          attr_accessor :defaultValueTiming              # 0-1 Timing
          attr_accessor :defaultValueContactDetail       # 0-1 ContactDetail
          attr_accessor :defaultValueContributor         # 0-1 Contributor
          attr_accessor :defaultValueDataRequirement     # 0-1 DataRequirement
          attr_accessor :defaultValueExpression          # 0-1 Expression
          attr_accessor :defaultValueParameterDefinition # 0-1 ParameterDefinition
          attr_accessor :defaultValueRelatedArtifact     # 0-1 RelatedArtifact
          attr_accessor :defaultValueTriggerDefinition   # 0-1 TriggerDefinition
          attr_accessor :defaultValueUsageContext        # 0-1 UsageContext
          attr_accessor :defaultValueDosage              # 0-1 Dosage
          attr_accessor :defaultValueMeta                # 0-1 Meta
          attr_accessor :element                         # 0-1 string
          attr_accessor :listMode                        # 0-1 code
          attr_accessor :variable                        # 0-1 id
          attr_accessor :condition                       # 0-1 string
          attr_accessor :check                           # 0-1 string
          attr_accessor :logMessage                      # 0-1 string
        end

        class Target < FHIR::Model
          include FHIR::Hashable
          include FHIR::Json
          include FHIR::Xml

          METADATA = {
            'id' => {'type'=>'string', 'path'=>'Target.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Target.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Target.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'context' => {'type'=>'id', 'path'=>'Target.context', 'min'=>0, 'max'=>1},
            'contextType' => {'valid_codes'=>{'http://hl7.org/fhir/map-context-type'=>['type', 'variable']}, 'type'=>'code', 'path'=>'Target.contextType', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-context-type'}},
            'element' => {'type'=>'string', 'path'=>'Target.element', 'min'=>0, 'max'=>1},
            'variable' => {'type'=>'id', 'path'=>'Target.variable', 'min'=>0, 'max'=>1},
            'listMode' => {'valid_codes'=>{'http://hl7.org/fhir/map-target-list-mode'=>['first', 'share', 'last', 'collate']}, 'type'=>'code', 'path'=>'Target.listMode', 'min'=>0, 'max'=>Float::INFINITY, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-target-list-mode'}},
            'listRuleId' => {'type'=>'id', 'path'=>'Target.listRuleId', 'min'=>0, 'max'=>1},
            'transform' => {'valid_codes'=>{'http://hl7.org/fhir/map-transform'=>['create', 'copy', 'truncate', 'escape', 'cast', 'append', 'translate', 'reference', 'dateOp', 'uuid', 'pointer', 'evaluate', 'cc', 'c', 'qty', 'id', 'cp']}, 'type'=>'code', 'path'=>'Target.transform', 'min'=>0, 'max'=>1, 'binding'=>{'strength'=>'required', 'uri'=>'http://hl7.org/fhir/ValueSet/map-transform'}},
            'parameter' => {'type'=>'StructureMap::Group::Rule::Target::Parameter', 'path'=>'Target.parameter', 'min'=>0, 'max'=>Float::INFINITY}
          }

          class Parameter < FHIR::Model
            include FHIR::Hashable
            include FHIR::Json
            include FHIR::Xml

            MULTIPLE_TYPES = {
              'value' => ['id', 'string', 'boolean', 'integer', 'decimal']
            }
            METADATA = {
              'id' => {'type'=>'string', 'path'=>'Parameter.id', 'min'=>0, 'max'=>1},
              'extension' => {'type'=>'Extension', 'path'=>'Parameter.extension', 'min'=>0, 'max'=>Float::INFINITY},
              'modifierExtension' => {'type'=>'Extension', 'path'=>'Parameter.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
              'valueId' => {'type'=>'id', 'path'=>'Parameter.value[x]', 'min'=>1, 'max'=>1},
              'valueString' => {'type'=>'string', 'path'=>'Parameter.value[x]', 'min'=>1, 'max'=>1},
              'valueBoolean' => {'type'=>'boolean', 'path'=>'Parameter.value[x]', 'min'=>1, 'max'=>1},
              'valueInteger' => {'type'=>'integer', 'path'=>'Parameter.value[x]', 'min'=>1, 'max'=>1},
              'valueDecimal' => {'type'=>'decimal', 'path'=>'Parameter.value[x]', 'min'=>1, 'max'=>1}
            }

            attr_accessor :id                # 0-1 string
            attr_accessor :extension         # 0-* [ Extension ]
            attr_accessor :modifierExtension # 0-* [ Extension ]
            attr_accessor :valueId           # 1-1 id
            attr_accessor :valueString       # 1-1 string
            attr_accessor :valueBoolean      # 1-1 boolean
            attr_accessor :valueInteger      # 1-1 integer
            attr_accessor :valueDecimal      # 1-1 decimal
          end

          attr_accessor :id                # 0-1 string
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :context           # 0-1 id
          attr_accessor :contextType       # 0-1 code
          attr_accessor :element           # 0-1 string
          attr_accessor :variable          # 0-1 id
          attr_accessor :listMode          # 0-* [ code ]
          attr_accessor :listRuleId        # 0-1 id
          attr_accessor :transform         # 0-1 code
          attr_accessor :parameter         # 0-* [ StructureMap::Group::Rule::Target::Parameter ]
        end

        class Dependent < FHIR::Model
          include FHIR::Hashable
          include FHIR::Json
          include FHIR::Xml

          METADATA = {
            'id' => {'type'=>'string', 'path'=>'Dependent.id', 'min'=>0, 'max'=>1},
            'extension' => {'type'=>'Extension', 'path'=>'Dependent.extension', 'min'=>0, 'max'=>Float::INFINITY},
            'modifierExtension' => {'type'=>'Extension', 'path'=>'Dependent.modifierExtension', 'min'=>0, 'max'=>Float::INFINITY},
            'name' => {'type'=>'id', 'path'=>'Dependent.name', 'min'=>1, 'max'=>1},
            'variable' => {'type'=>'string', 'path'=>'Dependent.variable', 'min'=>1, 'max'=>Float::INFINITY}
          }

          attr_accessor :id                # 0-1 string
          attr_accessor :extension         # 0-* [ Extension ]
          attr_accessor :modifierExtension # 0-* [ Extension ]
          attr_accessor :name              # 1-1 id
          attr_accessor :variable          # 1-* [ string ]
        end

        attr_accessor :id                # 0-1 string
        attr_accessor :extension         # 0-* [ Extension ]
        attr_accessor :modifierExtension # 0-* [ Extension ]
        attr_accessor :name              # 1-1 id
        attr_accessor :source            # 1-* [ StructureMap::Group::Rule::Source ]
        attr_accessor :target            # 0-* [ StructureMap::Group::Rule::Target ]
        attr_accessor :rule              # 0-* [ StructureMap::Group::Rule ]
        attr_accessor :dependent         # 0-* [ StructureMap::Group::Rule::Dependent ]
        attr_accessor :documentation     # 0-1 string
      end

      attr_accessor :id                # 0-1 string
      attr_accessor :extension         # 0-* [ Extension ]
      attr_accessor :modifierExtension # 0-* [ Extension ]
      attr_accessor :name              # 1-1 id
      attr_accessor :extends           # 0-1 id
      attr_accessor :typeMode          # 1-1 code
      attr_accessor :documentation     # 0-1 string
      attr_accessor :input             # 1-* [ StructureMap::Group::Input ]
      attr_accessor :rule              # 1-* [ StructureMap::Group::Rule ]
    end

    attr_accessor :id                # 0-1 id
    attr_accessor :meta              # 0-1 Meta
    attr_accessor :implicitRules     # 0-1 uri
    attr_accessor :language          # 0-1 code
    attr_accessor :text              # 0-1 Narrative
    attr_accessor :contained         # 0-* [ Resource ]
    attr_accessor :extension         # 0-* [ Extension ]
    attr_accessor :modifierExtension # 0-* [ Extension ]
    attr_accessor :url               # 1-1 uri
    attr_accessor :identifier        # 0-* [ Identifier ]
    attr_accessor :version           # 0-1 string
    attr_accessor :name              # 1-1 string
    attr_accessor :title             # 0-1 string
    attr_accessor :status            # 1-1 code
    attr_accessor :experimental      # 0-1 boolean
    attr_accessor :date              # 0-1 dateTime
    attr_accessor :publisher         # 0-1 string
    attr_accessor :contact           # 0-* [ ContactDetail ]
    attr_accessor :description       # 0-1 markdown
    attr_accessor :useContext        # 0-* [ UsageContext ]
    attr_accessor :jurisdiction      # 0-* [ CodeableConcept ]
    attr_accessor :purpose           # 0-1 markdown
    attr_accessor :copyright         # 0-1 markdown
    attr_accessor :structure         # 0-* [ StructureMap::Structure ]
    attr_accessor :import            # 0-* [ canonical ]
    attr_accessor :group             # 1-* [ StructureMap::Group ]

    def resourceType
      'StructureMap'
    end
  end
end