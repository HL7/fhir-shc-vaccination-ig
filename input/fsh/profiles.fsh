////////////////////////////////////////////////////////////////////////////////////////////////////

// Names are not limited to just COVID because this could be used for other diseases
Profile: VaccineCredentialPatient
Id:      vaccine-credential-patient
Parent:  USCorePatientProfile
Title:   "Patient Profile"

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


// Using Mark's "Other, specify: _____" approach to handle cases where a different CVX code
// needs to be used intentionally. If this is the case, the implementer would specify
// vaccineCode.coding[0] as `OtherCVX`, and vaccineCode.coding[1] as some other code.
//
// Extensible in case new vaccines are released before the IG can be updated.
* vaccineCode from VaccineCredentialCVXValueSet (extensible)
* vaccineCode obeys vaccine-code-invariant

// Marking vaccine lot number as MS because this is important for COVID vaccines due to more stringent
// storage temperature requirements than typical vaccines.
* lotNumber MS

// Marking dose sequence information as MS due to the importance for COVID
* protocolApplied.doseNumber[x]
    and protocolApplied.doseNumberPositiveInt
    and protocolApplied.seriesDoses[x]
    and protocolApplied.seriesDosesPositiveInt MS

// TODO: Consider profiling Location
* location MS

* status ^short = "Whether or not the vaccination was completed"

* reportOrigin from VaccineCredentialReportOriginValueSet (extensible)
* site from VaccineCredentialVaccineSiteValueSet (extensible)
* route from VaccineCredentialVaccineRouteValueSet (extensible)
* fundingSource from VaccineCredentialFundingSourceValueSet (extensible)
* statusReason from VaccineCredentialStatusReasonValueSet (extensible)

// TODO: Are there other value sets that need to be added to Immunization?

* reaction.detail only Reference(VaccineCredentialVaccineReactionObservation)

Invariant: vaccine-code-invariant
Description: "If the code representing 'Other CVX' is used, a second code from outside the original value set must be present."
Expression: "coding.where(code = 'OtherCVX').exists() implies coding.where(code != 'OtherCVX' and $this.memberOf('vaccine-credential-cvx-value-set).not()).exists()"
Severity: #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialImmuneStatus
Parent:         http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab
Id:             vaccine-credential-immune-status
Title:          "Immune Status Profile"
Description:    "Defines constraints and extensions on the observation resource for the minimal set of data to query and retrieve vaccine credential immune status."
* ^status = #draft

* subject only Reference(USCorePatientProfile)
* effective[x] 1..1 MS
* effective[x] only dateTime
* effective[x] ^short = "When immune status was assessed"

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
// TODO: Do we want to use the "other, specify" pattern here?
// TODO: What happens with ambiguous result? What about quantitative antibody studies?
* valueCodeableConcept from VaccineCredentialAntibodyResultValueSet (required)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservation
Parent:         Observation
Id:             vaccine-credential-vaccine-reaction-observation
Title:          "Vaccine Reaction Observation Profile"
Description:    "Profile for reporting a reaction to a vaccine.

This profile may not be necessary depending on the use cases for this IG, but it's included for now because
we wanted to have value sets corresponding to all the value sets in the IIS core data elements. In this
profile, `VaccineCredentialVaccineReactionValueSet` includes the IIS adverse reaction codes."
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