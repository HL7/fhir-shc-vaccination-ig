////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: CVX
Id: cvx-temp
Title: "Temporary CVX code system"
Description: "Temporary CVX code system to add missing codes to http://hl7.org/fhir/sid/cvx from the canonical list at https://www2.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=tradename)."
* ^url =  http://hl7.org/fhir/sid/cvx-TEMPORARY-CODE-SYSTEM
* #207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose"
* #208 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"
* #210 "COVID-19 vaccine, vector-nr, rS-ChAdOx1, PF, 0.5 mL"
* #212 "COVID-19 vaccine, vector-nr, rS-Ad26, PF, 0.5 mL"

ValueSet:    VaccinationCredentialVaccineValueSet
Id:          vaccination-credential-vaccine-value-set
Title:       "Value set for identifying vaccines"
Description: "Includes [CVX codes](https://www2.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=tradename) to identify specific vaccinations."
* CVX#207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose"
* CVX#208 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"
* CVX#210 "COVID-19 vaccine, vector-nr, rS-ChAdOx1, PF, 0.5 mL"
* CVX#212 "COVID-19 vaccine, vector-nr, rS-Ad26, PF, 0.5 mL"

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.statusReason -- this element is currently not allowed
/*
ValueSet:    VaccinationCredentialStatusReasonValueSet
Id:          vaccination-credential-status-reason-value-set
Title:       "Status reason value set"
Description: "Reasons a vaccine was not given"
* ACT#IMMUNE
* ACT#MEDPREC
* ACT#OSTOCK
* ACT#PATOBJ

// Support for IIS value set for RXA-18 (refusal reason) - this is CDC NIP002
* include codes from system http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3380
*/

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.reportOrigin
ValueSet:    VaccinationCredentialReportOriginValueSet
Id:          vaccination-credential-report-origin-value-set
Title:       "Secondarily reported record source value set"
Description: "Source of secondarily reported records"

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-origin

// Support for IIS value set for RXA-9 - this is part of CDC NIP001
* include codes from system http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.7450

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.site
ValueSet:    VaccinationCredentialVaccineSiteValueSet
Id:          vaccination-credential-vaccine-site-value-set
Title:       "Body site for vaccine administration value set"
Description: "Body site vaccine was administered"

// Support for IIS value set for RXR-2
* include codes from system http://terminology.hl7.org/CodeSystem/v2-0163

// Support for example binding from base FHIR Immunization resource
* include codes from system http://terminology.hl7.org/CodeSystem/v3-ActSite

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.route
ValueSet:    VaccinationCredentialVaccineRouteValueSet
Id:          vaccination-credential-vaccine-route-value-set
Title:       "Vaccination route value set"
Description: "How vaccine entered the body"

// Support for IIS value set for RXR-1
* include codes from system http://terminology.hl7.org/CodeSystem/v2-0162

// Support for example binding from base FHIR Immunization resource
* include codes from valueset http://hl7.org/fhir/ValueSet/immunization-route

////////////////////////////////////////////////////////////////////////////////////////////////////

// Not sure if we want to create a value set for program eligibility. This is presumably not
// relevant for COVID-19, and the IIS value set (for OBX-5) is user-defined.

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.fundingSource
ValueSet:    VaccinationCredentialFundingSourceValueSet
Id:          vaccination-credential-funding-source-value-set
Title:       "Funding source value set"
Description: "Funding source for the vaccine"

// Support for IIS value set for OBX-5 (extensible)
* include codes from system http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3287

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-funding-source

////////////////////////////////////////////////////////////////////////////////////////////////////

// For vaccine reaction Observation (VaccinationCredentialVaccineReactionObservation)
ValueSet:    VaccinationCredentialVaccineReactionValueSet
Id:          vaccination-credential-vaccine-reaction-value-set
Title:       "Adverse reaction value set"
Description: "Codes describing reactions to vaccinations"

// Support for IIS value set for OBX-5
// Source: https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3288
* include codes from system http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.3288

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    Covid19LaboratoryTestValueSet
Id:          covid19-laboratory-test-value-set
Title:       "COVID-19 laboratory test code value set"
Description: "Currently includes COVID-19 lab codes via the
[LIVD SARS CoV2 Test Codes value set](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1114.9/expansion)."

// Support for CDC LIVD SARS CoV2 Test Codes
* include codes from system http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1114.9

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    LaboratoryResultValueSet
Id:          laboratory-result-value-set
Title:       "Laboratory result value set"
Description: "Currently includes COVID-19 lab result codes based on the conclusive values from the
[LIVD SARS CoV2 Test Result Codes value set](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1114.10/expansion).
Other value sets may be added in the future."

* SCT#10828004 "Positive (qualifier value)"
* SCT#260373001 "Detected (qualifier value)"
* SCT#260385009 "Negative (qualifier value)"
* SCT#260408008 "Weakly positive (qualifier value)"
* SCT#260415000 "Not detected (qualifier value)"
* SCT#720735008 "Presumptive positive (qualifier value)"

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
