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

Profile: SHCVaccinationBundleAD
Parent: Bundle
Id: shc-vaccination-bundle-ad
Title: "Vaccination Bundle - Allowable Data"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card for vaccinations."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    immunization 1..* MS and
    vaccineReaction 0..*

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-ad

* entry[immunization] ^short = "Immunization"
* entry[immunization] ^definition = "Immunization"
* entry[immunization].resource only SHCVaccinationAD

* entry[vaccineReaction] ^short = "Vaccination reaction"
* entry[vaccineReaction] ^definition = "Vaccination reaction"
* entry[vaccineReaction].resource only SHCVaccinationReactionObservationAD

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCVaccinationBundleDM
Parent: Bundle
Id: shc-vaccination-bundle-dm
Title: "Vaccination Bundle - Data Minimization"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card for vaccinations."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    immunization 1..* MS and
    vaccineReaction 0..*

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-dm

* entry[immunization] ^short = "Immunization"
* entry[immunization] ^definition = "Immunization"
* entry[immunization].resource only SHCVaccinationDM

* entry[vaccineReaction] ^short = "Vaccination reaction"
* entry[vaccineReaction] ^definition = "Vaccination reaction"
* entry[vaccineReaction].resource only SHCVaccinationReactionObservationDM

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCCovid19LaboratoryBundleAD
Parent: Bundle
Id: shc-covid19-laboratory-bundle-ad
Title: "COVID-19-specific Laboratory Test Results Bundle - Allowable Data"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card with lab results, specifically for COVID-19."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-ad

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only SHCCovid19LaboratoryResultObservationAD
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCInfectiousDiseaseLaboratoryBundleAD
Parent: Bundle
Id: shc-infectious-disease-laboratory-bundle-ad
Title: "Infectious Disease (Generic) Laboratory Test Results Bundle - Allowable Data"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card with lab results."

* insert common-bundle-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-ad

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only SHCInfectiousDiseaseLaboratoryResultObservationAD
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCInfectiousDiseaseLaboratoryBundleDM
Parent: Bundle
Id: shc-infectious-disease-laboratory-bundle-dm
Title: "Infectious Disease (Generic) Laboratory Test Results Bundle - Data Minimization"
Description: "The bundle of resources that represents the patient identification and clinical content of a SMART Health Card with lab results."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-dm

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only SHCInfectiousDiseaseLaboratoryResultObservationDM
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile: SHCCovid19LaboratoryBundleDM
Parent: Bundle
Id: shc-covid19-laboratory-bundle-dm
Title: "COVID-19-specific Laboratory Test Results Bundle - Data Minimization"
Description: "The bundle of resources that represents the clinical content of a digital lab credential record specifically for COVID-19 data minimization."

* insert common-bundle-rules
* insert common-bundle-dm-rules

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    patient 1..1 MS and
    labResult 1..* MS

* entry[patient] ^short = "Patient"
* entry[patient] ^definition = "The patient who is the subject of the Bundle"
* entry[patient].resource only shc-patient-general-dm

* entry[labResult] ^short = "Laboratory result"
* entry[labResult] ^definition = "Laboratory result"
* entry[labResult].resource only SHCCovid19LaboratoryResultObservationDM
* entry[labResult] obeys vc-bundle-lab-status-complete

////////////////////////////////////////////////////////////////////////////////////////////////////