////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccineCredentialBundle
Parent: Bundle
Id: vaccine-credential-bundle
Title: "Vaccine Credential Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record."

* id obeys should-be-under-20-chars

* type  = #collection
* type MS
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

Profile: VaccineCredentialBundleDM
Parent: Bundle
Id: vaccine-credential-bundle-dm
Title: "Vaccine Credential Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record using data minimization profiles."

* id obeys should-be-under-20-chars

* type  = #collection
* type MS
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
* entry[vaccineCredentialPatient].resource only VaccineCredentialPatientDM

* entry[vaccineCredentialImmunization] ^short = "Immunization"
* entry[vaccineCredentialImmunization] ^definition = "Immunization"
* entry[vaccineCredentialImmunization].resource only VaccineCredentialImmunizationDM

* entry[vaccineCredentialVaccineReactionObservation] ^short = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation] ^definition = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation].resource only VaccineCredentialVaccineReactionObservationDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccineCredentialLaboratoryBundle
Parent: Bundle
Id: vaccine-credential-laboratory-bundle
Title: "Vaccine Credential Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record."

* id obeys should-be-under-20-chars

* type  = #collection
* type MS
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

Profile: InfectiousDiseaseLaboratoryBundleDM
Parent: Bundle
Id: infections-disease-laboratory-bundle-dm
Title: "Infections Disease (Generic) Laboratory Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record for a generic infectious disease for data minimization."

* id obeys should-be-under-20-chars

* type  = #collection
* type MS
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
* entry[laboratoryResultObservation].resource only InfectiousDiseaseLaboratoryResultObservationDM
* entry[laboratoryResultObservation] obeys vc-lab-1

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19LaboratoryBundleDM
Parent: Bundle
Id: covid-19-laboratory-bundle-dm
Title: "COVID-19-specific Laboratory Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19 data minimization."

* id obeys should-be-under-20-chars

* type  = #collection
* type MS
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
* entry[vaccineCredentialPatient].resource only VaccineCredentialPatientDM

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only Covid19LaboratoryResultObservationDM
* entry[laboratoryResultObservation] obeys vc-lab-1

////////////////////////////////////////////////////////////////////////////////////////////////////