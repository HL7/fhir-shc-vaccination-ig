////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatient
Id:          vaccine-credential-patient
Parent:      Patient
Title:       "Patient Profile - Allowable Data"
Description: "Slight modification of Patient, with identifier as 0..0 and limited MS."

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers."

* name 1..*
* name and name.given and name.family MS
* name obeys name-invariant

// Keeping gender MS as it is likely available and useful for interfacing with IIS
// See https://github.com/dvci/vaccine-credential-ig/pull/31#issuecomment-773434836 for details
* gender MS
* gender from http://hl7.org/fhir/ValueSet/administrative-gender (required)

* birthDate MS

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatientDM
Id:          vaccine-credential-patient-dm
Parent:      VaccineCredentialPatient
Title:       "Patient Profile - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated."

* meta 0..0
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
* address 0..0
* maritalStatus 0..0
* multipleBirth[x] 0..0
* photo 0..0
* contact 0..0
* communication 0..0
* generalPractitioner 0..0
* managingOrganization 0..0
* link 0..0