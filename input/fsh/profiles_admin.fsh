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
* name ^comment = "Cardinality for this element is set to `1..*` rather than `1..1` as in rare cases there may be a valid rational for including multiple `name` elements. The Data Minimization version of this profile reflects the rarity of this by setting `name` to `1..1`. The open cardinality supports first and middle names for example, if they are not added to the given name field."
* name.text ^short = "Use instead of `family` and `given` if the patient's name cannot be easily split these elements"
* name.given ^short = "All of a patient's names, other than their family name, can be included in their given name"
// FHIR-34447 - Allow name.suffix in primary Patient profiles (https://jira.hl7.org/browse/FHIR-34447)
* name.prefix MS
* name.prefix ^comment = "SHOULD be included if it appears on a government-issued ID."
* name.suffix MS
* name.suffix ^comment = "SHOULD be included if it appears on a government-issued ID."

* birthDate MS
* birthDate ^comment = "If exact date of birth is partially or completely unknown, Issuers SHALL populate this element with the date of birth information listed on the patient's government-issued identification. This MAY include a partial date of birth like `1999` or `1999-01`, or \"filler\" for unknown portions. (E.g., if a patient was born in 1950 but does not know the month or day, their government-issued identification may fill the month and day with `-01-01`. In this case, it is acceptable to populate this element with `1950-01-01` even if it is known the patient was not actually born on January 1.) If date of birth is completely unknown and no government-issued identification is available, Issuers MAY omit this element."

* gender 0..1
* gender ^short = "Administrative gender"
* gender obeys use-only-if-required-by-law
* gender ^definition = "Administrative gender.

Issuers SHALL NOT include `gender` unless required by law in the jurisdiction where the SMART Health Card is issued.

Verifiers SHALL NOT use `gender` in their workflows unless required by law in both the jurisdiction where the SMART Health Card was issued and the jurisdiction governing the Verifier."
* gender ^comment = "SMART Health Cards cannot be used as a form of identification. From the [SMART Health Card specification](https://spec.smarthealth.cards/#can-a-smart-health-card-be-used-as-a-form-of-identification):

_\"SMART Health Cards are designed for use alongside existing forms of identification (e.g., a driver's license in person, or an online ID verification service). A SMART Health Card is a non-forgeable digital artifact analogous to a paper record on official letterhead. Concretely, the problem SMART Health Cards solve is one of provenance: a digitally signed SMART Health Card is a credential that guarantees that a specific issuer generated the record. The duty of verifying that the person presenting a Health Card is the subject of the data within the Health Card (or is authorized to act on behalf of this data subject) falls to the person or system receiving and validating a Health Card.\"_

To facilitate verifying that the person presenting a Health Card is the subject of the data within the Health Card (or is authorized to act on behalf of this data subject), the patient's name and date of birth are included the SMART Health Card. **Gender is typically not included** because name and date of birth are sufficient for verification workflows, and there may be legitimate reasons why gender in a SMART Health Card does not match that in an existing form of identification (e.g., a change in administrative gender, or differences in how gender is represented). Note that it may not be possible to get a re-issued SMART Health Card if a patient's administrative gender changes.

Additionally, patients may not wish to share their administrative gender with Verifiers. Since this information is typically not necessary for the Verifiers' use case, it should be omitted as is consistent with the [privacy by design](index.html#privacy-by-design) approach used throughout this IG."

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

Invariant:   use-only-if-required-by-law
Description: "SHALL be omitted UNLESS required by law in jurisdiction where SHC is issued"
Expression:  "$this.length() = 0"
Severity:    #warning


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

* gender 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCPatientUnitedStatesDM
Id:          shc-patient-us-dm
Parent:      shc-patient-general-dm
Title:       "Patient Profile - United States - Data Minimization"
Description: "Only elements necessary for Verifiers can be populated. For use in the United States."

* identifier 0..0
* identifier ^definition = "Identifer is not allowed in this IG due to risk of accidental, unnecessary exposure of sensitive identifiers to verifiers."