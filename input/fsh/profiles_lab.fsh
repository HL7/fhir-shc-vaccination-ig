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
    Laboratory 1..1 MS
* category[Laboratory] = ObsCat#laboratory

* code MS

* subject only Reference(VaccineCredentialPatient)
* subject 1..1 MS
* subject ^short = "Patient to whom lab result applies"
* subject ^definition = "Reference to a VaccineCredentialPatient-conforming resource who is subject of lab result."

* effective[x] MS
* effective[x] only dateTime or Period

* value[x] MS

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        Covid19LaboratoryResultObservation
Parent:         Observation
Id:             covid19-laboratory-result-observation
Title:          "Laboratory Result Observation Profile"
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
