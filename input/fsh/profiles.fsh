////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialPatient
Id:          vaccine-credential-patient
Parent:      USCorePatientProfile
Title:       "Patient Profile"
Description: "***Currently this profile does not modify USCorePatientProfile, and can be removed if
                USCorePatientProfile is sufficient for our use cases.***"

* ^status = #draft

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialImmunization
Id:          vaccine-credential-immunization
Parent:      http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization
Title:       "Immunization Profile"
Description: "Defines a profile representing a vaccination for a vaccine credential Health Card."

* ^status = #draft

* patient only Reference(USCorePatientProfile)

// Parent profile short description is not as clear as it could be
* primarySource ^short = "Information in this record from person who administered vaccine?"

* vaccineCode from VaccineCredentialCVXValueSet (required)
* vaccineCode obeys vaccine-code-invariant

* lotNumber MS

// Marking dose sequence information as MS due to the importance for COVID
* protocolApplied 1..1 MS
* protocolApplied.doseNumber[x] only positiveInt
* protocolApplied.doseNumber[x] MS
* protocolApplied.seriesDoses[x] MS
* protocolApplied.targetDisease 1..1 MS
* protocolApplied.targetDisease from VaccineCredentialTargetDiseaseValueSet (extensible)

* location only Reference(USCoreLocation)
* location MS

* status ^short = "Whether or not the vaccination was completed"

* reportOrigin from VaccineCredentialReportOriginValueSet (extensible)
* site from VaccineCredentialVaccineSiteValueSet (extensible)
* route from VaccineCredentialVaccineRouteValueSet (extensible)
* fundingSource from VaccineCredentialFundingSourceValueSet (extensible)
* statusReason from VaccineCredentialStatusReasonValueSet (extensible)

* reaction.detail only Reference(VaccineCredentialVaccineReactionObservation)

* isSubpotent MS
* isSubpotent ^definition = "Indication if a dose is considered to be subpotent. By default, a dose should be considered to be potent. Verifiers SHALL assume that if an Immunization resource is provided and isSubpotent is not true, then the dose was not subpotent. Issuers SHALL only populate isSubpotent if the value is true. Issuers SHALL NOT produce an Immunization resource for a known subpotent dose without populating isSubpotent."

Invariant:   vaccine-code-invariant
Description: "If the code representing 'Other Vaccine' is used, a second code from outside the original value set must be present."
Expression:  "coding.where(code = 'OtherVaccine').exists() implies coding.where(code != 'OtherVaccine' and $this.memberOf('http://hl7.org/fhir/us/vaccinecredential/ValueSet/vaccine-credential-cvx-value-set').not()).exists()"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialImmuneStatus
Parent:         USCoreLaboratoryResultObservationProfile
Id:             vaccine-credential-immune-status
Title:          "Immune Status Profile"
Description:    "Defines constraints and extensions on the observation resource for the minimal set of data to query and retrieve vaccine credential immune status."
* ^status = #draft

* subject only Reference(USCorePatientProfile)
* effective[x] 1..1 MS
* effective[x] only dateTime
* effective[x] ^short = "When immune status was assessed"

* extension contains
    VaccineCredentialTargetDisease named targetDisease 1..1 MS

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from VaccineCredentialAntibodyResultValueSet (required)

Extension: VaccineCredentialTargetDisease
Id: vaccine-credential-target-disease
Title: "Target disease of the observation"
Description: "Disease "
* ^status = #draft
* ^experimental = true
* ^context[0].type = #element
* ^context[0].expression = "VaccineCredentialImmuneStatus"
* value[x] only CodeableConcept
* value[x] from VaccineCredentialTargetDiseaseValueSet (extensible)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservation
Parent:         Observation
Id:             vaccine-credential-vaccine-reaction-observation
Title:          "Vaccine Reaction Observation Profile"
Description:    "Profile for reporting a reaction to a vaccine.

This profile may not be necessary depending on the use cases for this IG, but it's included for now because
we wanted to have value sets corresponding to all the value sets in the IIS core data elements. In this
profile, VaccineCredentialVaccineReactionValueSet includes the IIS adverse reaction codes."
* ^status = #draft

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

Profile: VaccineCredentialBundle
Parent: Bundle
Id: vaccine-credential-bundle
Title: "Vaccine Credential Bundle"
Description: "The bundle of resources that represents the clinical content of a digital vaccination record."

* type  = #collection
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Slicing based on the profile conformance of the entry"
* entry and entry.resource MS

* entry contains
    // These resources are required per Conformance > Supported Profiles.
    vaccineCredentialPatient 1..1 MS and
    vaccineCredentialImmunization 0..* MS and
    vaccineCredentialImmuneStatus 0..* MS and
    vaccineCredentialVaccineReactionObservation 0..* MS and
    vaccineCredentialLocation 0..* MS


* entry[vaccineCredentialPatient] ^short = "Patient"
* entry[vaccineCredentialPatient] ^definition = "The patient who is the subject of the Bundle"
* entry[vaccineCredentialPatient].resource only VaccineCredentialPatient

* entry[vaccineCredentialImmunization] ^short = "Immunization"
* entry[vaccineCredentialImmunization] ^definition = "Immunization"
* entry[vaccineCredentialImmunization].resource only VaccineCredentialImmunization

* entry[vaccineCredentialImmuneStatus] ^short = "Immune status"
* entry[vaccineCredentialImmuneStatus] ^definition = "Immune status"
* entry[vaccineCredentialImmuneStatus].resource only VaccineCredentialImmuneStatus

* entry[vaccineCredentialVaccineReactionObservation] ^short = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation] ^definition = "Vaccination reaction"
* entry[vaccineCredentialVaccineReactionObservation].resource only VaccineCredentialVaccineReactionObservation

* entry[vaccineCredentialLocation] ^short = "Location (real world, not body site)"
* entry[vaccineCredentialLocation] ^definition = "Location (real world, not body site)"
* entry[vaccineCredentialLocation].resource only USCoreLocation
