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
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #closed
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
    patient 1..1 MS and
    immunization 1..* MS and
    vaccineReaction 0..*

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[immunization] ^short = "Immunization"
* entry[immunization] ^definition = "Immunization"
* entry[immunization].resource only VaccinationCredentialImmunization

* entry[vaccineReaction] ^short = "Vaccination reaction"
* entry[vaccineReaction] ^definition = "Vaccination reaction"
* entry[vaccineReaction].resource only VaccinationCredentialVaccineReactionObservation

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
    patient 1..1 MS and
    immunization 1..* MS and
    vaccineReaction 0..*

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatientDM

* entry[immunization] ^short = "Immunization"
* entry[immunization] ^definition = "Immunization"
* entry[immunization].resource only VaccinationCredentialImmunizationDM

* entry[vaccineReaction] ^short = "Vaccination reaction"
* entry[vaccineReaction] ^definition = "Vaccination reaction"
* entry[vaccineReaction].resource only VaccinationCredentialVaccineReactionObservationDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19LaboratoryBundle
Parent: Bundle
Id: covid19-laboratory-bundle
Title: "COVID-19-specific Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only Covid19LaboratoryResultObservation
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseLaboratoryBundle
Parent: Bundle
Id: infectious-disease-laboratory-bundle
Title: "Infectious Disease (Generic) Laboratory Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record for a generic infectious disease."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only InfectiousDiseaseLaboratoryResultObservation
* entry[labResult] obeys vc-bundle-lab-status-complete

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
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only InfectiousDiseaseLaboratoryResultObservationDM
* entry[labResult] obeys vc-bundle-lab-status-complete

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
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatientDM

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only Covid19LaboratoryResultObservationDM
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseConditionBundle
Parent: Bundle
Id: infectious-disease-condition-bundle
Title: "Infectious Disease Condition Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital infectious disease condition record."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    condition 1..1 MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[condition] ^short = "Condition"
* entry[condition] ^definition = "Condition"
* entry[condition].resource only VaccinationCredentialCondition

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: InfectiousDiseaseConditionBundleDM
Parent: Bundle
Id: infectious-disease-condition-bundle-dm
Title: "Infectious Disease Condition Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital infectious disease condition record using data minimization profiles."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    condition 1..1 MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[condition] ^short = "Condition"
* entry[condition] ^definition = "Condition"
* entry[condition].resource only VaccinationCredentialConditionDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19ConditionBundle
Parent: Bundle
Id: covid19-condition-bundle
Title: "COVID-19-specific Condition Bundle - Allowable Data"
Description: "The bundle of resources that represents the clinical content of a digital condition credential record specifically for COVID-19."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    condition 1..1 MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatient

* entry[condition] ^short = "Condition"
* entry[condition] ^definition = "Condition"
* entry[condition].resource only VaccinationCredentialConditionCovid19

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: Covid19ConditionBundleDM
Parent: Bundle
Id: covid19-condition-bundle-dm
Title: "COVID-19-specific Condition Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital condition credential record specifically for COVID-19 data minimization."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    condition 1..1 MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only VaccinationCredentialPatientDM

* entry[condition] ^short = "Condition"
* entry[condition] ^definition = "Condition"
* entry[condition].resource only VaccinationCredentialConditionCovid19DM

////////////////////////////////////////////////////////////////////////////////////////////////////