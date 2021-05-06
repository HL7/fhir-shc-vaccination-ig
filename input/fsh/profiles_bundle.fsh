////////////////////////////////////////////////////////////////////////////////////////////////////

RuleSet: fullurl(path)

* {path}fullUrl 1..1
* {path}fullUrl MS
* {path}fullUrl ^short = "Locally unique identifier like resource:0"
* {path}fullUrl ^definition = "Identifier for the contained resource that is locally unique within this Bundle. The identifier SHALL use `resource:#` format, where `#` is an integer incremented from 0 to _n_ within the Bundle."
* {path}fullUrl ^comment = "n/a"
* {path}fullUrl obeys vc-shall-be-resource-uri

RuleSet: common-bundle-rules

* id ^short = "Should be omitted"
* id ^definition = "It is not necessary to provide an `id` for Bundles profiled in this IG. This element SHOULD be omitted for data minimization reasons."
* id ^comment = "n/a"
* id obeys vc-should-be-omitted

* type  = #collection
* type MS
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* insert id-should-not-be-populated(entry.)
* insert fullurl(entry.)

RuleSet: common-bundle-dm-rules

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
* total 0..0
* link 0..0
* entry.link 0..0
* entry.search 0..0
* entry.request 0..0
* entry.response 0..0
* signature 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccinationCredentialBundle
Parent: Bundle
Id: vaccination-credential-bundle
Title: "Vaccination Credential Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    vaccinationCredentialImmunization 1..* MS and
    vaccinationCredentialVaccineReactionObservation 0..*

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatient

* entry[vaccinationCredentialImmunization] ^short = "Immunization"
* entry[vaccinationCredentialImmunization] ^definition = "Immunization"
* entry[vaccinationCredentialImmunization].resource only VaccinationCredentialImmunization

* entry[vaccinationCredentialVaccineReactionObservation] ^short = "Vaccination reaction"
* entry[vaccinationCredentialVaccineReactionObservation] ^definition = "Vaccination reaction"
* entry[vaccinationCredentialVaccineReactionObservation].resource only VaccinationCredentialVaccineReactionObservation

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: VaccinationCredentialBundleDM
Parent: Bundle
Id: vaccination-credential-bundle-dm
Title: "Vaccination Credential Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record using data minimization profiles."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    vaccinationCredentialImmunization 1..* MS and
    vaccinationCredentialVaccineReactionObservation 0..*

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatientDM

* entry[vaccinationCredentialImmunization] ^short = "Immunization"
* entry[vaccinationCredentialImmunization] ^definition = "Immunization"
* entry[vaccinationCredentialImmunization].resource only VaccinationCredentialImmunizationDM

* entry[vaccinationCredentialVaccineReactionObservation] ^short = "Vaccination reaction"
* entry[vaccinationCredentialVaccineReactionObservation] ^definition = "Vaccination reaction"
* entry[vaccinationCredentialVaccineReactionObservation].resource only VaccinationCredentialVaccineReactionObservationDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19LaboratoryBundle
Parent: Bundle
Id: covid19-laboratory-bundle
Title: "COVID-19-specific Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    laboratoryResultObservation 1..* MS

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatient

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only Covid19LaboratoryResultObservation
* entry[laboratoryResultObservation] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseLaboratoryBundle
Parent: Bundle
Id: infectious-disease-laboratory-bundle
Title: "Infectious Disease (Generic) Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record for a generic infectious disease."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    laboratoryResultObservation 1..* MS

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatient

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only InfectiousDiseaseLaboratoryResultObservation
* entry[laboratoryResultObservation] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseLaboratoryBundleDM
Parent: Bundle
Id: infectious-disease-laboratory-bundle-dm
Title: "Infectious Disease (Generic) Laboratory Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record for a generic infectious disease for data minimization."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    laboratoryResultObservation 1..* MS

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatient

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only InfectiousDiseaseLaboratoryResultObservationDM
* entry[laboratoryResultObservation] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19LaboratoryBundleDM
Parent: Bundle
Id: covid19-laboratory-bundle-dm
Title: "COVID-19-specific Laboratory Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19 data minimization."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    VaccinationCredentialPatient 1..1 MS and
    laboratoryResultObservation 1..* MS

* entry[VaccinationCredentialPatient] ^short = "Patient"
* entry[VaccinationCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[VaccinationCredentialPatient].resource only VaccinationCredentialPatientDM

* entry[laboratoryResultObservation] ^short = "Laboratory result"
* entry[laboratoryResultObservation] ^definition = "Laboratory result"
* entry[laboratoryResultObservation].resource only Covid19LaboratoryResultObservationDM
* entry[laboratoryResultObservation] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////