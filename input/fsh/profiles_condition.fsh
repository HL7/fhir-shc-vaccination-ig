////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccinationCredentialCondition
Id:          vaccination-credential-condition
Parent:      Condition
Title:       "Condition Profile - Allowable Data"
Description: "Defines a profile representing an assertion of past infection for a SMART Health Card."

* . ^definition = "Describes the details of a patient being clinically diagnosed with an infectious disease."

* insert id-should-not-be-populated()

* subject only Reference(VaccinationCredentialPatient)
* subject MS
* insert reference-to-absolute-uri(subject)

* meta.security 0..1
* meta.security from identity-assurance-level (required)
* meta.security ^short = "Limited security label to convey identity level of assurance for patient referenced by this resource."
* meta.security ^definition = "Limited security metadata which conveys an attestation that the provider performed a certain level of identity verification at the time of service. If known, Issuers SHALL attest to the highest level that applies."
* meta.security MS

* onset[x] MS
* onset[x] ^short = "Estimated or actual date."
* onset[x] ^comment = "See `onsetDateTime`."
* onsetDateTime 1..1 MS
* onsetDateTime ^comment = "For data minimization reasons, only year, month, and date SHOULD be reported for this element. Exact time (hour, minute, second) are not relevant for our use cases."
* onsetDateTime obeys vc-date-invariant

* abatement[x] MS
* abatement[x] only dateTime
* abatementDateTime 0..1 MS
* abatementDateTime ^comment = "For data minimization reasons, only year, month, and date SHOULD be reported for this element. Exact time (hour, minute, second) are not relevant for our use cases."
* abatementDateTime obeys vc-date-invariant

* code 1..1
* code MS

* code.coding 1..*
* code.coding MS

* verificationStatus ^short = "The verification status to support the clinical status of the condition. SHOULD only include confirmed conditions."
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccinationCredentialConditionCovid19
Id:          vaccination-credential-condition-covid-19
Parent:      VaccinationCredentialCondition
Title:       "Condition Profile - Allowable Data - COVID-19"
Description: "Recommended profile for implementers to identify COVID-19 conditions for a SMART Health Card."

* code from confirmed-covid-19-infection (required)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccinationCredentialConditionDM
Id:          vaccination-credential-condition-dm
Parent:      VaccinationCredentialCondition
Title:       "Condition Profile - Data Minimization"
Description: "Defines a profile representing an assertion of past infection for a SMART Health Card. Only elements necessary for Verifiers can be populated."

* id 0..0
* meta.versionId 0..0
* meta.lastUpdated 0..0
* meta.source 0..0
* meta.profile 0..0
* meta.tag 0..0
* meta.id 0..0
* meta.extension 0..0
* identifier 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* clinicalStatus 0..0
* verificationStatus 0..0
* category 0..0
* severity 0..0
* bodySite 0..0
* encounter 0..0
* recordedDate 0..0
* recorder 0..0
* asserter 0..0
* stage 0..0
* evidence 0..0
* note 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccinationCredentialConditionCovid19DM
Id:          vaccination-credential-condition-covid-19-dm
Parent:      VaccinationCredentialConditionDM
Title:       "Condition Profile - Data Minimization - COVID-19"
Description: "Recommended data minimization profile for implementers to identify COVID-19 conditions for a SMART Health Card."

* code from confirmed-covid-19-infection (required)