////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccineCredentialBundle
Parent: Bundle
Id: vaccine-credential-bundle
Title: "Vaccine Credential Bundle"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record."

* type  = #collection
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    vaccineCredentialPatient 1..1 MS and
    vaccineCredentialImmunization 1..* MS and
    vaccineCredentialVaccineReactionObservation 0..*

* entry[vaccineCredentialPatient] ^short = "Patient"
* entry[vaccineCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[vaccineCredentialPatient].resource only VaccineCredentialPatient

* entry[vaccineCredentialImmunization] ^short = "Immunization"
* entry[vaccineCredentialImmunization] ^definition = "Immunization"
* entry[vaccineCredentialImmunization].resource only VaccineCredentialImmunization

* entry[vaccineCredentialVaccineReactionObservation] ^short = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation] ^definition = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation].resource only VaccineCredentialVaccineReactionObservation

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccineCredentialLaboratoryBundle
Parent: Bundle
Id: vaccine-credential-laboratory-bundle
Title: "Vaccine Credential Laboratory Bundle"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record."

* type  = #collection
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    vaccineCredentialPatient 1..1 MS and
    laboratoryResultObservation 1..* MS

* entry[vaccineCredentialPatient] ^short = "Patient"
* entry[vaccineCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[vaccineCredentialPatient].resource only VaccineCredentialPatient

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only AbstractLaboratoryResultObservation
* entry[laboratoryResultObservation] obeys vc-lab-1

////////////////////////////////////////////////////////////////////////////////////////////////////
