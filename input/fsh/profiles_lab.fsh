////////////////////////////////////////////////////////////////////////////////////////////////////

// Defines a common set of rules to use for Observation profiles in this IG based on
// https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-observation-lab.html.
//
// This approach is preferable to a hierarchy of profiles or the use of abstract profiles because
// it allows the "differential" view in the built IG to show all differences from the base
// resource, rather than differences from the parent profile. Usually implementers will want to see
// the former rather than the latter.
RuleSet: LaboratoryResultObservation

* status MS
* status from completed-observation-status (required)

* code MS

* subject only Reference(shc-patient-general-ad)
* subject 1..1 MS
* subject ^short = "Patient to whom lab result applies"
* subject ^definition = "Reference to a VaccinationCredentialPatient-conforming resource who is subject of lab result."

* effective[x] MS
* effective[x] only dateTime or Period
* effective[x] 1..1

* value[x] 1..1
* value[x] MS
* value[x] only CodeableConcept or Quantity or string
* value[x] ^comment = "Issuers SHALL provide a computable representation of laboratory results if at all possible. If the Issuer is unable to accurately translate laboratory results into a computable form, it is unlikely a Verifier will be able to interpret the results. Issuers SHALL make every possible effort to resolve non-computable results prior to issuing credentials. In rare cases when this is not possible, Issuers MAY populate `valueString` with a free text result."
* valueCodeableConcept 0..1 // work-around to ensure alphabetic order of elements in diff of structure definition - see https://github.com/hapifhir/org.hl7.fhir.core/issues/562
* valueQuantity obeys vc-observation-quantity-should-have-range
* valueString ^short = "String representation of results; used ONLY when a computable representation is not possible"
* valueString obeys vc-should-be-under-20-chars

* referenceRange MS
* referenceRange ^short = "Provides guide for interpretation. SHOULD include if using valueQuantity."
* referenceRange ^comment = "Issuers SHOULD provide a reference range for quantitative lab results to allow recipients to correctly interpret the results. Issuers MAY provide a reference range for free text (string) results."
* referenceRange obeys vc-observation-range-only-quantity-or-string

* performer only Reference(Organization)
* performer MS
* performer 0..1
* performer ^short = "Organization which was responsible for laboratory record; typically the organization collecting the sample or performing the test."
* performer ^definition = "Organization which was responsible for laboratory record. Typically this is the organization that collected the sample (e.g., a pharmacy or outpatient facility) or performed the test (e.g., a clinical laboratory). Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."

// VCI-specific (not from US Core)
* insert id-should-not-be-populated()

* meta MS
* meta.security 0..1
* meta.security from identity-assurance-level (required)
* meta.security ^short = "Limited security label to convey identity level of assurance for patient referenced by this resource."
* meta.security ^definition = "Limited security metadata which conveys an attestation that the lab testing provider performed a certain level of identity verification at the time of service. If known, Issuers SHALL attest to the highest level that applies."
* meta.security MS

* performer MS
* performer 0..1
* performer only Reference(Organization)
* performer MS
* performer ^short = "Organization which was responsible for the laboratory test result."
* performer ^definition = "Only `Observation.performer.display` SHOULD be populated. See the definition of that element for details."
* performer.display ^short = "Short, human-readable text representation of the organization."
* performer.display MS
* performer.display 1..1
* performer.display ^definition = "Organization which was responsible for the laboratory test result. Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."
* performer.display obeys vc-should-be-under-30-chars


* insert reference-to-absolute-uri(subject)

* insert SpecimenSupervisionStatusAD

////////////////////////////////////////////////////////////////////////////////////////////////////


RuleSet: SpecimenSupervisionStatusDM

* component ^slicing.rules = #closed

* component 0..1
* component[specimen-supervision-status].code.id 0..0
* component[specimen-supervision-status].code.extension 0..0
* component[specimen-supervision-status].code.coding.id 0..0
* component[specimen-supervision-status].code.coding.extension 0..0
* component[specimen-supervision-status].code.coding.display 0..0
* component[specimen-supervision-status].code.coding.version 0..0
* component[specimen-supervision-status].code.coding.userSelected 0..0
* component[specimen-supervision-status].code.text 0..0

* component[specimen-supervision-status].valueCodeableConcept.id 0..0
* component[specimen-supervision-status].valueCodeableConcept.extension 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding.id 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding.extension 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding.display 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding.version 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding.userSelected 0..0
* component[specimen-supervision-status].valueCodeableConcept.text 0..0

// Has to be at the bottom, or these elements show up in the snapshot for the slice
* component.id 0..0
* component.extension 0..0
* component.modifierExtension 0..0
* component.dataAbsentReason 0..0
* component.interpretation 0..0
* component.referenceRange 0..0


////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: SpecimenSupervisionStatusAD

* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.description = "Slicing based on the code"
* component ^slicing.rules = #open
* component contains specimen-supervision-status 0..1 MS

* component[specimen-supervision-status].code.coding 1..1
* component[specimen-supervision-status].code.coding.system = SCT (exactly)
* component[specimen-supervision-status].code.coding.system 1..1
* component[specimen-supervision-status].code.coding.code 1..1
* component[specimen-supervision-status].code.coding.code = #1208522006 (exactly)
* component[specimen-supervision-status].code.coding.code ^short = "SNOMED CT concept 'Type of supervision for specimen collection (observable entity)'"

* component[specimen-supervision-status].valueCodeableConcept from SpecimenCollectionSupervisionStatus (required)
* component[specimen-supervision-status].valueCodeableConcept 1..1
* component[specimen-supervision-status].valueCodeableConcept.extension 0..0
* component[specimen-supervision-status].valueCodeableConcept.coding 1..1
* component[specimen-supervision-status].valueCodeableConcept.coding.system 1..1
* component[specimen-supervision-status].valueCodeableConcept.coding.code 1..1


////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        SHCCovid19LaboratoryResultObservationAD
Parent:         Observation
Id:             shc-covid19-laboratory-result-observation-ad
Title:          "COVID-19 Laboratory Result Observation Profile - Allowable Data"
Description: "Defines a [fallback (AD) profile](./profiles.html#conformance-to-profiles) representing a laboratory testing result for COVID-19 in a health card.

[See here for implementation details](./laboratory-results-observation.html)."

* insert LaboratoryResultObservation

// This binding can be required because implementers can fall back to SHCInfectiousDiseaseLaboratoryResultObservation
* code from https://terminology.smarthealth.cards/ValueSet/lab-qualitative-test-covid (required)
* code ^definition = "If an appropriate code is not found in the bound value set, use the SHCInfectiousDiseaseLaboratoryResultObservation profile instead, which allows any LOINC."

* valueCodeableConcept from https://terminology.smarthealth.cards/ValueSet/lab-qualitative-result (required)
* code ^definition = "If an appropriate code is not found in the bound value set, use the SHCInfectiousDiseaseLaboratoryResultObservation profile instead, which allows for any SNOMED CT descendant of `441742003` \"Evaluation finding (finding)\" or `362981000` \"Qualifier value (qualifier value)\"."

////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: LaboratoryResultObservationDM

* code.id 0..0
* code.extension 0..0
// Since code.coding is expanded in the snapshot, add a rule to require the
// necessary elements to conform to the required binding. This is redundant, but
// not having the cardinality rules will be more confusing than omitting them.
* code.coding 1..1
* code.coding.id 0..0
* code.coding.extension 0..0
* code.coding.system 1..1 // needed for required binding -- see above
* code.coding.version 0..0
* code.coding.code 1..1 // needed for required binding -- see above
* code.coding.display 0..0
* code.coding.userSelected 0..0
* code.text 0..0
* id 0..0
* identifier 0..0
* meta.versionId 0..0
* meta.lastUpdated 0..0
* meta.source 0..0
* meta.profile 0..0
* meta.tag 0..0
* meta.id 0..0
* meta.extension 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* basedOn 0..0
* partOf 0..0
* category 0..0
* subject.id 0..0
* subject.extension 0..0
* encounter 0..0
* focus 0..0
* issued 0..0
* dataAbsentReason 0..0
* interpretation 0..0
* note 0..0
* bodySite 0..0
* method 0..0
* specimen 0..0
* device 0..0
* hasMember 0..0
* derivedFrom 0..0
* performer.id 0..0
* performer.extension 0..0
* performer.reference 0..0
* performer.type 0..0
* performer.identifier 0..0
* valueCodeableConcept.id 0..0
* valueCodeableConcept.extension 0..0
// Since valueCodeableConcept.coding is expanded in the snapshot, add a rule to require the
// necessary elements to conform to the required binding. This is redundant, but
// not having the cardinality rules will be more confusing than omitting them.
* valueCodeableConcept.coding 1..1
* valueCodeableConcept.coding.id 0..0
* valueCodeableConcept.coding.extension 0..0
* valueCodeableConcept.coding.system 1..1 // needed for required binding -- see above
* valueCodeableConcept.coding.version 0..0
* valueCodeableConcept.coding.code 1..1 // needed for required binding -- see above
* valueCodeableConcept.coding.display 0..0
* valueCodeableConcept.coding.userSelected 0..0
* valueCodeableConcept.text 0..0
* valueCodeableConcept.text 0..0
* referenceRange.id 0..0
* referenceRange.extension 0..0
* referenceRange.modifierExtension 0..0
* referenceRange.appliesTo 0..0
* referenceRange.age 0..0
* referenceRange.type.id 0..0
* referenceRange.type.extension 0..0
* referenceRange.type.text 0..0
* valueQuantity.id 0..0 // Needed to fix test failure - this makes no sense but it works. See https://github.com/dvci/vaccine-credential-ig/pull/145
* valueString.id 0..0 // Needed to fix test failure - this makes no sense but it works. See https://github.com/dvci/vaccine-credential-ig/pull/145

* insert SpecimenSupervisionStatusDM

////////////////////////////////////////////////////////////////////////////////////////////////////


Profile:        SHCCovid19LaboratoryResultObservationDM
Parent:         SHCCovid19LaboratoryResultObservationAD
Id:             shc-covid19-laboratory-result-observation-dm
Title:          "COVID-19 Laboratory Result Observation Profile - Data Minimization"
Description: "Defines a [primary (DM) profile](./profiles.html#conformance-to-profiles) representing a laboratory testing result for COVID-19 in a health card.

[See here for implementation details](./laboratory-results-observation.html)."

* insert LaboratoryResultObservationDM

* insert reference-to-ad-profile-comment(subject)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        SHCInfectiousDiseaseLaboratoryResultObservationAD
Parent:         Observation
Id:             shc-infectious-disease-laboratory-result-observation-ad
Title:          "Generic Laboratory Result Observation Profile - Allowable Data"
Description: "Defines a [fallback (AD) profile](./profiles.html#conformance-to-profiles) representing an infectious disease laboratory testing result in a health card.

[See here for implementation details](./laboratory-results-observation.html)."

* insert LaboratoryResultObservation

// Show an error if the code is part of a value set used in a disease-specific profile. If that's
// the case, there's no reason to use this generic profile -- the disease-specific profile should
// be used instead.
* code from http://hl7.org/fhir/ValueSet/observation-codes (required) // All LOINCs - https://www.hl7.org/fhir/valueset-observation-codes.html
* code ^short = "LOINC identifying the lab test"

* valueCodeableConcept from lab-result-findings (required)

////////////////////////////////////////////////////////////////////////////////////////////////////


Profile:        SHCInfectiousDiseaseLaboratoryResultObservationDM
Parent:         SHCInfectiousDiseaseLaboratoryResultObservationAD
Id:             shc-infectious-disease-laboratory-result-observation-dm
Title:          "Generic Laboratory Result Observation Profile - Data Minimization"
Description: "Defines a [primary (DM) profile](./profiles.html#conformance-to-profiles) representing an infectious disease laboratory testing result in a health card.

[See here for implementation details](./laboratory-results-observation.html)."

* insert LaboratoryResultObservationDM

* insert reference-to-ad-profile-comment(subject)
