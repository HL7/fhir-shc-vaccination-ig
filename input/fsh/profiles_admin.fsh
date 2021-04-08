////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatient
Id:          vaccine-credential-patient
Parent:      Patient
Title:       "Patient Profile - Allowable Data"
Description: "Slight modification of Patient, with identifier as 0..0 and limited MS."

* insert id-should-not-be-populated()

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers."

* name 1..*
* name and name.given and name.family MS
* name obeys name-invariant
* name ^short = "Official name (i.e., legal name) of patient"
* name ^definition = "Official name (i.e., legal name) of the patient, corresponding to `official` in [this value set](http://hl7.org/fhir/R4/valueset-name-use.html). Issuers SHALL provide a single `name` element UNLESS they believe providing multiple `name` elements is critical for verification of the credential. If providing only a single `name` element, Issuers SHALL NOT populate `name.use`, and Verifiers SHALL assume that the provided name is `official`."
* name ^comment = "Cardinality for this element is set to `1..*` rather than `1..1` as in rare cases there may be a valid rational for including multiple `name` elements. The Data Minimization version of this profile reflects the rarity of this by setting `name` to `1..1`."

* birthDate MS

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatientDM
Id:          vaccine-credential-patient-dm
Parent:      VaccineCredentialPatient
Title:       "Patient Profile - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated."

* id 0..0
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
* name 1..1
* name.id 0..0
* name.extension 0..0
* name.use 0..0
* telecom 0..0
* gender 0..0
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