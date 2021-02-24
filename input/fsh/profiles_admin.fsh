////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatient
Id:          vaccine-credential-patient
Parent:      Patient
Title:       "Patient Profile"
Description: "Slight modification of Patient, with identifier as 0..0 and limited MS."

* ^status = #draft

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