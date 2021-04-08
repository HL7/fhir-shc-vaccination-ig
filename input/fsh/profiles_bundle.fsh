////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccineCredentialBundle
Parent: Bundle
Id: vaccine-credential-bundle
Title: "Vaccine Credential Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record."

* id ^short = "Should be omitted"
* id ^definition = "It is not necessary to provide an `id` for Bundles profiled in this IG. This element SHOULD be omitted for data minimization reasons."
* id ^comment = "n/a"
* id obeys should-be-resource-uri

* type  = #collection
* type MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* entry.fullUrl 1..1
* entry.fullUrl MS
* entry.fullUrl ^short = "Locally unique identifier like resource:0"
* entry.fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHOULD use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* entry.fullUrl ^comment = "n/a"

* insert id-should-not-be-populated(entry.)

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

Profile: Covid19LaboratoryBundle
Parent: Bundle
Id: covid-19-laboratory-bundle
Title: "COVID-19-specific Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19."

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
* entry[laboratoryResultObservation].resource only Covid19LaboratoryResultObservation
* entry[laboratoryResultObservation] obeys vc-lab-1

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseLaboratoryBundle
Parent: Bundle
Id: infectious-disease-laboratory-bundle
Title: "Infectious Disease (Generic) Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record for a generic infectious disease."

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
* entry[laboratoryResultObservation].resource only InfectiousDiseaseLaboratoryResultObservation
* entry[laboratoryResultObservation] obeys vc-lab-1

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseLaboratoryBundleDM
Parent: Bundle
Id: infectious-disease-laboratory-bundle-dm
Title: "Infectious Disease (Generic) Laboratory Bundle - Data Minimization"
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