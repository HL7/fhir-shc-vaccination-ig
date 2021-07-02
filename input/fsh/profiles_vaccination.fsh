////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCVaccinationAD
Id:          shc-vaccination-ad
Parent:      Immunization
Title:       "Vaccination Profile - Allowable Data"
Description: "Defines a profile representing a vaccination for a SMART Health Card."

* . ^definition = "Describes the event of a patient being administered a vaccine or a record of an immunization as reported by a patient, a clinician or another party. If the immunization is part of a multi-dose series, a separate Immunization resource SHALL be used to represent each dose."

* insert id-should-not-be-populated()

* patient only Reference(shc-patient-general-ad)
* patient MS
* insert reference-to-absolute-uri(patient)

* meta.security 0..1
* meta.security from identity-assurance-level (required)
* meta.security ^short = "Limited security label to convey identity level of assurance for patient referenced by this resource."
* meta.security ^definition = "Limited security metadata which conveys an attestation that the immunization provider performed a certain level of identity verification at the time of service. If known, Issuers SHALL attest to the highest level that applies."
* meta.security MS

* occurrence[x] MS
* occurrence[x] ^definition = "Date vaccine administered."
* occurrence[x] ^comment = "See `occurrenceDateTime`." // Remove inherited comment, which is not meaningful for our context.
* occurrenceDateTime 1..1 MS
* occurrenceDateTime ^definition = "Date vaccine administered (`YYYY-MM-DD` format)."
* occurrenceDateTime ^comment = "For data minimization reasons, only year, month, and date SHOULD be reported for this element. Exact time (hour, minute, second) are not relevant for our use cases."
* occurrenceDateTime obeys vc-date-invariant

// Parent profile short description is not as clear as it could be
* primarySource ^short = "Information in this record from person who administered vaccine?"



// Vaccine code
* vaccineCode 1..1
* vaccineCode MS
* vaccineCode ^short = "Codes identifying the vaccine product administered"

* vaccineCode.coding 1..*
* vaccineCode.coding MS
* vaccineCode.coding ^slicing.discriminator.type = #value
* vaccineCode.coding ^slicing.discriminator.path = "system"
* vaccineCode.coding ^slicing.rules = #closed
* vaccineCode.coding ^slicing.description = "Slicing based on the code system"

* vaccineCode.coding contains
    cvx 0..1 and
    gtin 0..1 and
    snomed 0..1 and
    icd11 0..1 and
    air 0..1

// It's necessary to fix `system` **in addition** to the value set binding for the slicing to work
* vaccineCode.coding[cvx] ^short = "CVX code identifying the administered vaccine product"
* vaccineCode.coding[cvx] from vaccine-cvx (required)
* vaccineCode.coding[cvx].system = "http://hl7.org/fhir/sid/cvx"

* vaccineCode.coding[gtin] ^short = "GTIN code identifying the administered vaccine product"
* vaccineCode.coding[gtin] from vaccine-gtin (required)
* vaccineCode.coding[gtin].system = "https://www.gs1.org/gtin"

* vaccineCode.coding[snomed] ^short = "SNOMED CT code identifying the administered vaccine product"
* vaccineCode.coding[snomed] from vaccine-snomed (required)
* vaccineCode.coding[snomed].system = "http://snomed.info/sct"

* vaccineCode.coding[icd11] ^short = "ICD11 code identifying the administered vaccine product"
* vaccineCode.coding[icd11] from vaccine-icd-11 (required)
* vaccineCode.coding[icd11].system = "http://id.who.int/icd11/mms"

// See http://build.fhir.org/ig/hl7au/au-fhir-base/StructureDefinition-au-immunization.html for the value set and code system URIs
* vaccineCode.coding[air] ^short = "Australian Immunisation Register Vaccine code identifying the administered vaccine product"
* vaccineCode.coding[air] from https://healthterminologies.gov.au/fhir/ValueSet/australian-immunisation-register-vaccine-1 (required)
* vaccineCode.coding[air].system = "https://www.humanservices.gov.au/organisations/health-professionals/enablers/air-vaccine-code-formats"

// Manufacturer
// Why we are doing this rather than an extension or in vaccineCode
// https://chat.fhir.org/#narrow/stream/179202-terminology/topic/Using.20multiple.20codes.20with.20CodeableConcept.20Datatype/near/236750401
// Note that the FHIR validator will not currently validate that a given `value` is in the `system`
// inside `manufacturer.identifier`.
* manufacturer MS
* manufacturer.identifier MS
* manufacturer.identifier ^short = "Only populate when vaccine type is not provided in vaccineCode"
* manufacturer.identifier.system MS
* manufacturer.identifier.system 1..1
* manufacturer.identifier.system obeys shall-use-known-vaccine-manufacturer-code-system
* manufacturer.identifier.system ^short = "Code system used to identify vaccine manufacturer"
* manufacturer.identifier.value MS
* manufacturer.identifier.value 1..1
* manufacturer.identifier.system ^short = "Code identifying vaccine manufacturer"


* lotNumber MS
* lotNumber obeys vc-should-be-under-20-chars
* lotNumber obeys vc-should-not-include-string-lot
* lotNumber ^short = "String representing lot number like `0123L45A`"
* lotNumber ^definition = "Lot number of the vaccine product. Implementers SHOULD NOT include text synonymous with \"lot number\" in this element as this is redundant. For example, use `0123L45A` rather than `Lot # 0123L45A`."

* protocolApplied 0..0 // See explanation in pagecontent/StructureDefinition-vaccination-credential-immunization-intro.md

* performer MS
* performer 0..1
* performer.actor only Reference(Organization)
* performer.actor MS
* performer.actor ^short = "Organization which was responsible for vaccine administration."
* performer.actor ^definition = "Only `Immunization.performer.actor.display` SHOULD be populated. See the definition of that element for details."
* performer.actor.display ^short = "Short, human-readable text representation of the organization."
* performer.actor.display MS
* performer.actor.display 1..1
* performer.actor.display ^definition = "Organization which was responsible for vaccine administration. Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."
* performer.actor.display obeys vc-should-be-under-30-chars

* status ^short = "Whether or not the vaccination was completed"
* status MS
* status = #completed

// If `status` is fixed to `completed`, `statusReason` is meaningless since it's only used for
// incomplete vaccinations.
* statusReason 0..0
// This is the value set we would use if we were including `statusReason`
// * statusReason from VaccinationCredentialStatusReasonValueSet (extensible)

// Support for IIS value set for RXA-9 - this is part of CDC NIP001
// * reportOrigin from http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.7450 (extensible)

// Support for IIS value set for RXR-2
// * site from http://terminology.hl7.org/ValueSet/v2-0163 (extensible)

// Support for IIS value set for RXR-1
// * route from https://terminology.hl7.org/2.1.0/ValueSet-v2-0162.html (extensible)

// Support for IIS value set for OBX-5 (extensible)
// * fundingSource from http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3287 (extensible)

* reaction.detail only Reference(shc-vaccination-reaction-observation-ad)

* isSubpotent MS
* isSubpotent ^short = "Set to `true` if dose is subpotent; omit otherwise"
* isSubpotent ^definition = "Indication if a dose is considered to be subpotent.

Issuers SHALL populate `isSubpotent` with `true` if the dose is known to be subpotent. Alternatively, Issuers MAY choose to not produce an Immunization resource at all if the dose is known to be subpotent as this resource would be unlikely to provide value to the other actors.

Issuers SHALL NOT populate `isSubpotent` for potent doses.

Verifiers SHALL assume that if an Immunization resource is provided and `isSubpotent` is empty, then the dose was fully potent."
* isSubpotent ^comment = "It is critical that Verifiers process this element if it exists and is set to `true`. Therefore, `isSubpotent` is marked as `MustSupport` because it is also flagged with `Is-Modifier`, and per the [conformance requirements](conformance.html), Verifiers SHALL \"meaningfully process\" elements that are `MustSupport` and `Is-Modifier`.

This element is therefore an exception to the guidance that Issuers must populate `MustSupport` elements if the data are available. An invariant is used to provide a computable representation of this exception: it will produce an error if `isSubpotent = false`, which is the expected value of this element for the vast majority of resources. Because full potency is implicit per this element's definition, we do not want to populate `isSubpotent` with `false` because it increases payload size without adding information.

If `isSubpotent` was not allowed at all (`0..0` cardinality), the concern is that resources where `isSubpotent = true` would inadvertently be generated without any indication they were not potent."
* isSubpotent obeys vc-shall-be-true-if-populated-invariant

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     SHCVaccinationDM
Id:          shc-vaccination-dm
Parent:      shc-vaccination-ad
Title:       "Vaccination Profile - Data Minimization"
Description: "Defines a profile representing a vaccination for a SMART Health Card. Only elements necessary for Verifiers can be populated."

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
* statusReason 0..0
* encounter 0..0
* recorded 0..0
* primarySource 0..0
* reportOrigin 0..0
* location 0..0
* manufacturer.reference 0..0
* manufacturer.type 0..0
* manufacturer.display 0..0
* expirationDate 0..0
* site 0..0
* route 0..0
* doseQuantity 0..0
* performer.function 0..0
* performer.id 0..0
* performer.extension 0..0
* performer.modifierExtension 0..0
* performer.actor.id 0..0
* performer.actor.extension 0..0
* performer.actor.reference 0..0
* performer.actor.type 0..0
* performer.actor.identifier 0..0
* note 0..0
* reasonCode 0..0
* reasonReference 0..0
* subpotentReason 0..0
* education 0..0
* fundingSource 0..0
* reaction 0..0
* programEligibility 0..0

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        SHCVaccinationReactionObservationAD
Parent:         Observation
Id:             shc-vaccination-reaction-observation-ad
Title:          "Adverse Reaction to Vaccination Observation Profile - Allowable Data"
Description:    "Profile for reporting a reaction to a vaccine.

This profile may not be necessary depending on the use cases for this IG, but it's included for now because
we wanted to have value sets corresponding to all the value sets in the IIS core data elements."
* ^status = #draft

* id obeys vc-should-be-under-20-chars

* code = SCT#293104008 "Vaccines adverse reaction (disorder)"

* subject only Reference(shc-patient-general-ad)
* subject 1..1 MS
* subject ^short = "Patient with reaction to vaccine"
* subject ^definition = "Reference to a SMART Health Card patient-conforming resource who had a reaction to the vaccine."

// Not sure if this is the best element to use to refer to the immunization(s) attributed to the reaction
* focus only Reference(shc-vaccination-ad)
* focus 1..* MS
* focus ^short = "Immunization causing the reaction"
* focus ^definition = "Reference to the VaccinationCredentialImmunization-conforming resource representing the vaccination(s) causing the reaction."

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3288 (extensible)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        SHCVaccinationReactionObservationDM
Parent:         shc-vaccination-reaction-observation-ad
Id:             shc-vaccination-reaction-observation-dm
Title:          "Adverse Reaction to Vaccination Observation Profile - Data Minimization"
Description:    "Profile for reporting a reaction to a vaccine. Only elements necessary for Verifiers can be populated."

* id 0..0
* meta 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* basedOn 0..0
* partOf 0..0
* category.id 0..0
* category.extension 0..0
* category.text 0..0
* issued 0..0
* performer 0..0
* dataAbsentReason 0..0
* interpretation 0..0
* note 0..0
* bodySite 0..0
* method 0..0
* specimen 0..0
* device 0..0
* referenceRange 0..0
* hasMember 0..0
* derivedFrom 0..0
* component 0..0
