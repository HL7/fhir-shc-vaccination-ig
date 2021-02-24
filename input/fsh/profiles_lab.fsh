////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialLaboratoryResultObservation
Parent:         Observation
Id:             vaccine-credential-laboratory-result-observation
Title:          "Vaccine Laboratory Result Observation Profile"
Description:    "Profile for reporting lab results indicating current or previous infection status for verified credentials."
* ^status = #draft

* status MS

* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the $this pattern"
* category contains
    Laboratory 1..1 MS
* category[Laboratory] = ObsCat#laboratory

* code MS

* subject only Reference(VaccineCredentialPatient)
* subject 1..1 MS
* subject ^short = "Patient to whom lab result applies"
* subject ^definition = "Reference to a VaccineCredentialPatient-conforming resource who is subject of lab result."

* effective[x] MS
* effective[x] only dateTime or Period

* value[x] MS

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        Covid19CredentialLaboratoryResultObservation
Parent:         VaccineCredentialLaboratoryResultObservation
Id:             covid-19-credential-laboratory-result-observation
Title:          "COVID 19 Laboratory Result Observation Profile"
Description:    "Profile for reporting lab results indicating current or previous COVID 19 infection status for verified credentials."
* ^status = #draft

* code MS
* code from Covid19CredentialLaboratoryCodeValueSet (extensible)

* value[x] only CodeableConcept or Quantity
* valueCodeableConcept from Covid19CredentialLaboratoryResultValueSet (extensible)

* bodySite 0..0
* method 0..0
* component 0..0
