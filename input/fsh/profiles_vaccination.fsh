////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialImmunization
Id:          vaccine-credential-immunization
Parent:      Immunization
Title:       "Immunization Profile - Allowable Data"
Description: "Defines a profile representing a vaccination for a vaccine credential Health Card."

* insert id-should-not-be-populated()

* patient only Reference(VaccineCredentialPatient)
* patient MS
* insert reference-to-absolute-uri(patient)

* meta.security 0..1
* meta.security from IdentityAssuranceLevelValueSet (required)
* meta.security ^short = "Limited security label to convey identity level of assurance for patient referenced by this resource. Coding SHOULD include only code."
* meta.security ^definition = "Limited security metadata which conveys an attestation that the immunization provider performed a certain level of identity verification at the time of service. If known, Issuers SHALL attest to the highest level that applies."
* meta.security MS

* occurrence[x] MS
* occurrence[x] ^definition = "Date vaccine administered."
* occurrence[x] ^comment = "See `occurrenceDateTime`." // Remove inherited comment, which is not meaningful for our context.
* occurrenceDateTime 1..1 MS
* occurrenceDateTime ^definition = "Date vaccine administered (`YYYY-MM-DD` format)."
* occurrenceDateTime ^comment = "For data minimization reasons, only year, month, and date SHOULD be reported for this element. Exact time (hour, minute, second) are not relevant for our use cases."
* occurrenceDateTime obeys date-invariant

// Parent profile short description is not as clear as it could be
* primarySource ^short = "Information in this record from person who administered vaccine?"

* vaccineCode MS
* vaccineCode from VaccineCredentialVaccineValueSet (extensible)
* vaccineCode obeys vaccine-code-invariant
* vaccineCode ^definition = "Implementers SHALL use a code from VaccineCredentialVaccineValueSet if this value set contains an appropriate code.

For COVID-19-related vaccinations, implementers SHOULD use one of the CVX codes [listed on the CDC's COVID-19 vaccine-related codes list](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html) whenever possible.

We are actively investigating adding additional codes that are not United States-centric."

* lotNumber MS
* lotNumber obeys should-be-under-20-chars
* lotNumber obeys should-not-include-string-lot
* lotNumber ^short = "String representing lot number like `0123L45A`"
* lotNumber ^definition = "Lot number of the vaccine product. Implementers SHOULD NOT include text synonymous with \"lot number\" in this element as this is redundant. For example, use `0123L45A` rather than `Lot # 0123L45A`."

* protocolApplied 0..0 // See explanation in pagecontent/StructureDefinition-vaccine-credential-immunization-intro.md

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

* status ^short = "Whether or not the vaccination was completed"
* status MS
* status = #completed

// If `status` is fixed to `completed`, `statusReason` is meaningless since it's only used for
// incomplete vaccinations.
* statusReason 0..0
// This is the value set we would use if we were including `statusReason`
// * statusReason from VaccineCredentialStatusReasonValueSet (extensible)

* reportOrigin from VaccineCredentialReportOriginValueSet (extensible)
* site from VaccineCredentialVaccineSiteValueSet (extensible)
* route from VaccineCredentialVaccineRouteValueSet (extensible)
* fundingSource from VaccineCredentialFundingSourceValueSet (extensible)

* reaction.detail only Reference(VaccineCredentialVaccineReactionObservation)

* isSubpotent MS
* isSubpotent ^definition = "Indication if a dose is considered to be subpotent.

Issuers SHALL populate `isSubpotent` with `true` if the dose is known to be subpotent. Alternatively, Issuers MAY choose to not produce an Immunization resource at all if the dose is known to be subpotent as this resource would be unlikely to provide value to the other actors.

Issuers SHALL NOT populate `isSubpotent` for potent doses.

Verifiers SHALL assume that if an Immunization resource is provided and `isSubpotent` is not `true`, then the dose was fully potent."
* isSubpotent ^comment = "It is critical that Verifiers process this element if it exists and is set to `true`. Therefore, `isSubpotent` is marked as `MustSupport` because it is also flagged with `Is-Modifier`, and per the [conformance requirements](conformance.html), Verifiers SHALL \"meaningfully process\" elements that are `MustSupport` and `Is-Modifier`.

This element is therefore an exception to the guidance that Issuers must populate `MustSupport` elements if the data are available. An invariant is used to provide a computable representation of this exception: it will produce an error if `isSubpotent = false`, which is the expected value of this element for the vast majority of resources. Because full potency is implicit per this element's definition, we do not want to populate `isSubpotent` with `false` because it increases payload size without adding information.

If `isSubpotent` was not allowed at all (`0..0` cardinality), the concern is that resources where `isSubpotent = true` would inadvertently be generated without any indication they were not potent."
* isSubpotent obeys shall-be-true-if-populated-invariant

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialImmunizationDM
Id:          vaccine-credential-immunization-dm
Parent:      VaccineCredentialImmunization
Title:       "Immunization Profile - Data Minimization"
Description: "Defines a profile representing a vaccination for a vaccine credential Health Card. Only elements necessary for Verifiers can be populated."

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
* manufacturer 0..0
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

// Required in DM profile to provide implementers with sterner warning when straying from the expected value sets
* vaccineCode from VaccineCredentialVaccineValueSet (required)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservation
Parent:         Observation
Id:             vaccine-credential-vaccine-reaction-observation
Title:          "Vaccine Reaction Observation Profile - Allowable Data"
Description:    "Profile for reporting a reaction to a vaccine.

This profile may not be necessary depending on the use cases for this IG, but it's included for now because
we wanted to have value sets corresponding to all the value sets in the IIS core data elements. In this
profile, VaccineCredentialVaccineReactionValueSet includes the IIS adverse reaction codes."
* ^status = #draft

* id obeys should-be-under-20-chars

* code = SCT#293104008 "Vaccines adverse reaction (disorder)"

* subject only Reference(VaccineCredentialPatient)
* subject 1..1 MS
* subject ^short = "Patient with reaction to vaccine"
* subject ^definition = "Reference to a VaccineCredentialPatient-conforming resource who had a reaction to the vaccine."

// Not sure if this is the best element to use to refer to the immunization(s) attributed to the reaction
* focus only Reference(VaccineCredentialImmunization)
* focus 1..* MS
* focus ^short = "Immunization causing the reaction"
* focus ^definition = "Reference to the VaccineCredentialImmunization-conforming resource representing the vaccination(s) causing the reaction."

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from VaccineCredentialVaccineReactionValueSet (extensible)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservationDM
Parent:         VaccineCredentialVaccineReactionObservation
Id:             vaccine-credential-vaccine-reaction-observation-dm
Title:          "Vaccine Reaction Observation Profile - Data Minimization"
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