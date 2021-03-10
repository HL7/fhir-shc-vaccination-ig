////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatient
Id:          vaccine-credential-patient
Parent:      Patient
Title:       "Patient Profile - Allowable Data"
Description: "Slight modification of Patient, with identifier as 0..0 and limited MS."

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers."

* meta.security 0..1
* meta.security from IdentityAssuranceLevelValueSet (required)
* meta.security ^short = "Limited security label to convey patient identity level of assurance. Coding SHOULD include only code."

* name 1..*
* name and name.given and name.family MS
* name obeys name-invariant

// Keeping gender MS as it is likely available and useful for interfacing with IIS
// See https://github.com/dvci/vaccine-credential-ig/pull/31#issuecomment-773434836 for details
* gender MS
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)

// We want address.country and address.postalCode to be included if available
// See https://github.com/dvci/vaccine-credential-ig/issues/37#issuecomment-776042494
* address.country MS
* address.postalCode MS

* birthDate MS

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatientDM
Id:          vaccine-credential-patient-dm
Parent:      VaccineCredentialPatient
Title:       "Patient Profile - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated."

* meta.versionId 0..0
* meta.lastUpdated 0..0
* meta.source 0..0
* meta.profile 0..0
* meta.tag 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* active 0..0
* name.id 0..0
* name.extension 0..0
* name.use 0..0
* telecom 0..0
* deceased[x] 0..0
* address.use 0..0
* address.type 0..0
* address.text 0..0
* address.line 0..0
* address.city 0..0
* address.state 0..0
* address.period 0..0
* address.text 0..0
* maritalStatus 0..0
* multipleBirth[x] 0..0
* photo 0..0
* contact 0..0
* communication 0..0
* generalPractitioner 0..0
* managingOrganization 0..0
* link 0..0