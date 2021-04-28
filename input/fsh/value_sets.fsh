////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialVaccineValueSet
Id:          vaccination-credential-vaccine-value-set
Title:       "Vaccines value set"
Description: "This value set includes codes for identifying vaccines."

// CVX codes - identifies disease and type of vaccine
* include codes from system http://hl7.org/fhir/sid/cvx

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialVaccineManufacturerValueSet
Id:          vaccination-credential-vaccine-manufacturer-value-set
Title:       "Vaccine manufacturer value set"
Description: "This value set includes codes for identifying vaccine manufacturers."

// MVX codes - identifies manufacturer https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.826
* include codes from valueset http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.826

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialLabTestValueSet
Id:          vaccination-credential-lab-test-value-set
Title:       "Laboratory tests value set"
Description: "This value set includes codes for identifying laboratory tests."

* include codes from system LNC

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialLabTestResultsValueSet
Id:          vaccination-credential-lab-test-results-value-set
Title:       "Laboratory test results value set"
Description: "This value set includes codes for identifying laboratory test results."

// Include all clinical finding codes
* include codes from system SCT where concept is-a #404684003

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: IdentityAssuranceCodeSystem
Id: identity-assurance-code-system
Title: "Identity Assurance Code System"
Description: "Code representing identity assurance level, based on NIST 800-63-3"
* ^url =  http://terminology.hl7.org/CodeSystem/loa
* #IAL1 "Name and birth date were self-asserted."
* #IAL1.2 "An unspecified ID was used to verify name and birth date."
* #IAL1.4 "A US state-issued photo ID or nationally-issued photo ID was used to verify name and birth date."
* #IAL2 "Either remote or in-person identity proofing is required. IAL2 requires identifying attributes to have been verified in person or remotely using, at a minimum, the procedures given in NIST Special Publication 800-63A."
* #IAL3 "In-person identity proofing is required. Identifying attributes must be verified by an authorized CSP representative through examination of physical documentation as described in NIST Special Publication 800-63A."

ValueSet:    IdentityAssuranceLevelValueSet
Id:          identity-assurance-level-value-set
Title:       "Identity assurance level value set"
Description: "Code representing identity assurance level, based on NIST 800-63-3"
* include codes from system LOA

////////////////////////////////////////////////////////////////////////////////////////////////////
