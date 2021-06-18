////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCPatientGeneralAD
Id:          shc-patient-general-ad
Parent:      Patient
Title:       "Patient Profile - General - Allowable Data"
Description: "Slight modification of Patient, with identifier as 0..0 and limited MS. For general use if no geographic-specific profile exists."

* insert id-should-not-be-populated()

// Inherited short and definition include animals
* . ^short = "Information about an individual receiving an individual receiving a vaccination or infectious disease-related laboratory test"
* . ^definition = "Demographics and other administrative information about an individual receiving a vaccination or infectious disease-related laboratory test."

* name 1..*
* name and name.given and name.family MS
* name obeys vc-name-invariant
* name ^short = "Official name (i.e., legal name) of patient"
* name ^definition = "Official name (i.e., legal name) of the patient, corresponding to `official` in [this value set](https://www.hl7.org/fhir/valueset-name-use.html). Issuers SHALL provide a single `name` element UNLESS they believe providing multiple `name` elements is critical for verification of the credential. If providing only a single `name` element, Issuers SHALL NOT populate `name.use`, and Verifiers SHALL assume that the provided name is `official`."
* name ^comment = "Cardinality for this element is set to `1..*` rather than `1..1` as in rare cases there may be a valid rational for including multiple `name` elements. The Data Minimization version of this profile reflects the rarity of this by setting `name` to `1..1`."
* name.text ^short = "Use instead of `family` and `given` if the patient's name cannot be easily split these elements"

* birthDate MS
* birthDate ^comment = "If exact date of birth is partially or completely unknown, Issuers SHALL populate this element with the date of birth information listed on the patient's government-issued identification. This MAY include a partial date of birth like `1999` or `1999-01`, or \"filler\" for unknown portions. (E.g., if a patient was born in 1950 but does not know the month or day, their government-issued identification may fill the month and day with `-01-01`. In this case, it is acceptable to populate this element with `1950-01-01` even if it is known the patient was not actually born on January 1.) If date of birth is completely unknown and no government-issued identification is available, Issuers MAY omit this element."

* gender 0..0
* gender ^short = "SHALL not be included"
* gender ^comment = "Self-identified gender may change over time, and it may not be possible to re-issue a credential updating the value of this element. Including this element could therefore create a situation where the gender element in the credential does not match that in another form of identification, or does not match the Holder's self-identified gender at the time they present their credential to a Verifier.

Because gender is a common field in administrative data, it is possible Issuers will include it without considering the potential harms to Holders as described above. We have therefore disallowed this element in both the allowable and data minimization profiles."

* photo 0..0
* photo ^comment = "Attachments are not allowed due to data size constraints."

* contact 0..0

* address.text 0..0
* address.text ^short = "SHALL not be included"
* address.text ^definition = "Full physical address SHALL not be included because of patient privacy concerns."
* address.text ^comment = "There are scenarios where a Holder of a credential may wish to present their credential without revealing their full physical address."
* address.line 0..0
* address.line ^short = "SHALL not be included"
* address.line ^definition = "Full physical address SHALL not be included because of patient privacy concerns."
* address.line ^comment = "There are scenarios where a Holder of a credential may wish to present their credential without revealing their full physical address."

* insert contact-information-should-not-be-populated(telecom.value)
* insert contact-information-should-not-be-populated(address.city)
* insert contact-information-should-not-be-populated(address.district)
* insert contact-information-should-not-be-populated(address.state)
* insert contact-information-should-not-be-populated(address.postalCode)

RuleSet: contact-information-should-not-be-populated(path)
* {path} obeys vc-should-be-omitted-privacy
* {path} ^comment = "For patient privacy reasons, this element SHALL NOT be populated unless the Issuer believes the credential cannot be verified in its absence."



////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCPatientGeneralDM
Id:          shc-patient-general-dm
Parent:      shc-patient-general-ad
Title:       "Patient Profile - General - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated. For general use if no geographic-specific profile exists."

* id 0..0
* meta 0..0
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
* deceased[x] 0..0
* address 0..0
* maritalStatus 0..0
* multipleBirth[x] 0..0
* photo 0..0
* communication 0..0
* generalPractitioner 0..0
* managingOrganization 0..0
* link 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCPatientUnitedStatesAD
Id:          shc-patient-us-ad
Parent:      shc-patient-general-ad
Title:       "Patient Profile - United States - Allowable Data"
Description: "Only elements necessary for Verifiers can be populated."

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers. For use in the United States."


////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCPatientUnitedStatesDM
Id:          shc-patient-us-dm
Parent:      shc-patient-general-dm
Title:       "Patient Profile - United States - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated. For use in the United States."

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers."