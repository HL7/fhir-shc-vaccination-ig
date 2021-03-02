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

* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the $this pattern"
* category contains
    laboratory 1..1 MS
* category[laboratory] = ObsCat#laboratory

* code MS

* subject only Reference(VaccineCredentialPatient)
* subject 1..1 MS
* subject ^short = "Patient to whom lab result applies"
* subject ^definition = "Reference to a VaccineCredentialPatient-conforming resource who is subject of lab result."

* effective[x] MS
* effective[x] only dateTime or Period

* value[x] MS

* performer only Reference(Organization)
* performer MS
* performer 0..1
* performer ^short = "Organization which was responsible for laboratory record."
* performer ^definition = "Organization which was responsible for laboratory record. Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        Covid19LaboratoryResultObservation
Parent:         Observation
Id:             covid19-laboratory-result-observation
Title:          "COVID-19 Laboratory Result Observation Profile - Allowable Data"
Description:    "Profile for reporting COVID-19-related laboratory results indicating current or
previous infection status."

* insert LaboratoryResultObservation

* code from Covid19LaboratoryTestValueSet (required)
* code obeys covid19-laboratory-test-code-invariant


* value[x] only CodeableConcept or Quantity
* valueCodeableConcept from LaboratoryResultValueSet (required)
* valueCodeableConcept obeys laboratory-result-invariant

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

* meta 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* basedOn 0..0
* partOf 0..0
* category.id 0..0
* category.extension 0..0
* category.text 0..0
* focus 0..0
* issued 0..0
* dataAbsentReason 0..0
* interpretation 0..0
* note 0..0
* bodySite 0..0
* method 0..0
* specimen 0..0
* device 0..0
* referenceRange 0..0
* hasMember 0..0
* derivedFrom 0..0
* component 0..0

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

* code obeys not-specified-laboratory-test-code-invariant

* value[x] only CodeableConcept or Quantity
* valueCodeableConcept from LaboratoryResultValueSet (required)
* valueCodeableConcept obeys laboratory-result-invariant

////////////////////////////////////////////////////////////////////////////////////////////////////


Profile:        InfectiousDiseaseLaboratoryResultObservationDM
Parent:         InfectiousDiseaseLaboratoryResultObservation
Id:             infectious-disease-laboratory-result-observation-dm
Title:          "Generic Laboratory Result Observation Profile - Data Minimization"
Description:    "Profile for reporting laboratory results indicating current or previous infection status for a disease without a specified laboratory result profile.
Only elements necessary for Verifiers can be populated."

* insert LaboratoryResultObservationDM