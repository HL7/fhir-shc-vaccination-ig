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

* code MS

* subject only Reference(VaccinationCredentialPatient)
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
* valueString ^short = "String representation of results; used ONLY when a computable representation is not possible"
* valueString obeys vc-should-be-under-20-chars
* valueQuantity obeys vc-observation-quantity-should-have-range

* referenceRange MS
* referenceRange ^comment = "Issuers SHOULD provide a reference range for quantitative lab results to allow recipients to correctly interpret the results. Issuers MAY provide a reference range for free text (string) results."
* referenceRange obeys vc-observation-range-only-quantity-or-string

* performer only Reference(Organization)
* performer MS
* performer 0..1
* performer ^short = "Organization which was responsible for laboratory record."
* performer ^definition = "Organization which was responsible for laboratory record. Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."

// VCI-specific (not from US Core)
* insert id-should-not-be-populated()

* status obeys vc-observation-status-shall-be-complete

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

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        Covid19LaboratoryResultObservation
Parent:         Observation
Id:             covid19-laboratory-result-observation
Title:          "COVID-19 Laboratory Result Observation Profile - Allowable Data"
Description:    "Profile for reporting COVID-19-related laboratory results indicating current or
previous infection status."

* insert LaboratoryResultObservation

// This binding can be required because implementers can fall back to InfectiousDiseaseLaboratoryResultObservation
* code from covid-lab-tests-loinc-vsac (required)
* code ^definition = "If an appropriate code is not found in the bound value set, use the InfectiousDiseaseLaboratoryResultObservation profile instead, which does not have a required binding."

* valueCodeableConcept from qualitative-lab-result-findings (required)
* code ^definition = "If an appropriate code is not found in the bound value set, use the InfectiousDiseaseLaboratoryResultObservation profile instead, which does not have a required binding."
/*
TODO: Test using `device` rather than `method`, like so:

{
    device:{
        identifier: {
            system: "some_system",
            value: "some_id"
        }
    }
}

* method MS
* method ^short = "Device or technique used by laboratory"
* method ^definition = "Identifies the device or technique used by the laboratory, such as a test kit or piece of laboratory equipment."
* method ^comment = "The method element is used rather than device for data minimization reasons: device is a reference, which would require an additional FHIR resource."
*/

////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: LaboratoryResultObservationDM

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
* component 0..0
* performer.id 0..0
* performer.extension 0..0
* performer.reference 0..0
* performer.type 0..0
* performer.identifier 0..0
* valueCodeableConcept.text 0..0
* valueQuantity.id 0..0
* valueString.id 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////


Profile:        Covid19LaboratoryResultObservationDM
Parent:         Covid19LaboratoryResultObservation
Id:             covid19-laboratory-result-observation-dm
Title:          "COVID-19 Laboratory Result Observation Profile - Data Minimization"
Description:    "Profile for reporting COVID-19-related laboratory results indicating current or
previous infection status. Only elements necessary for Verifiers can be populated."

* insert LaboratoryResultObservationDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        InfectiousDiseaseLaboratoryResultObservation
Parent:         Observation
Id:             infectious-disease-laboratory-result-observation
Title:          "Generic Laboratory Result Observation Profile - Allowable Data"
Description:    "Profile for reporting laboratory results indicating current or previous infection status for a disease without a specified laboratory result profile."

* insert LaboratoryResultObservation

// Show an error if the code is part of a value set used in a disease-specific profile. If that's
// the case, there's no reason to use this generic profile -- the disease-specific profile should
// be used instead.
* code from http://hl7.org/fhir/ValueSet/observation-codes (required) // All LOINCs - https://www.hl7.org/fhir/valueset-observation-codes.html
* code ^short = "LOINC identifying the lab test"
* code obeys vc-shall-not-be-a-covid-loinc

* valueCodeableConcept from lab-result-findings (required)

////////////////////////////////////////////////////////////////////////////////////////////////////


Profile:        InfectiousDiseaseLaboratoryResultObservationDM
Parent:         InfectiousDiseaseLaboratoryResultObservation
Id:             infectious-disease-laboratory-result-observation-dm
Title:          "Generic Laboratory Result Observation Profile - Data Minimization"
Description:    "Profile for reporting laboratory results indicating current or previous infection status for a disease without a specified laboratory result profile.
Only elements necessary for Verifiers can be populated."

* insert LaboratoryResultObservationDM