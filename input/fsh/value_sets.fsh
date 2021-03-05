////////////////////////////////////////////////////////////////////////////////////////////////////

Alias: CVX = http://hl7.org/fhir/sid/cvx
Alias: LNC = http://loinc.org
Alias: SCT = http://snomed.info/sct
Alias: ACT = http://terminology.hl7.org/CodeSystem/v3-ActReason

////////////////////////////////////////////////////////////////////////////////////////////////////


ValueSet:    VaccineCredentialVaccineValueSet
Id:          vaccine-credential-vaccine-value-set
Title:       "Value set for identifying vaccines"
Description: "Includes [CVX codes](https://www2.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=tradename) to identify specific vaccinations."
* include codes from system CVX

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineCredentialAntibodyResultValueSet
Id:          vaccine-credential-antibody-result-value-set
Title:       "Antibody results value set"
Description: "Result codes for SARS coronavirus 2 antibodies"
* LNC#LA6577-6 "Negative"
* LNC#LA6576-8 "Positive"

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.statusReason
ValueSet:    VaccineCredentialStatusReasonValueSet
Id:          vaccine-credential-status-reason-value-set
Title:       "Status reason value set"
Description: "Reasons a vaccine was not given"
* ACT#IMMUNE
* ACT#MEDPREC
* ACT#OSTOCK
* ACT#PATOBJ

// Support for IIS value set for RXA-18 (refusal reason) - this is CDC NIP002
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3380

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineCredentialTargetDiseaseValueSet
Id:          vaccine-credential-target-disease-value-set
Title:       "Target disease value set"
Description: "Disease targeted by the vaccination or other observation"
* codes from system SCT where concept is-a #40733004

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.reportOrigin
ValueSet:    VaccineCredentialReportOriginValueSet
Id:          vaccine-credential-report-origin-value-set
Title:       "Secondarily reported record source value set"
Description: "Source of secondarily reported records"

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-origin

// Support for IIS value set for RXA-9 - this is part of CDC NIP001
* include codes from system https://phinvads.cdc.gov/vads/ViewCodeSystem.action?id=2.16.840.1.114222.4.5.293

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.site
ValueSet:    VaccineCredentialVaccineSiteValueSet
Id:          vaccine-credential-vaccine-site-value-set
Title:       "Body site for vaccine administration value set"
Description: "Body site vaccine was administered"

// Support for IIS value set for RXR-2
* include codes from system http://terminology.hl7.org/CodeSystem/v2-0163

// Support for example binding from base FHIR Immunization resource
* include codes from system http://terminology.hl7.org/CodeSystem/v3-ActSite

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.route
ValueSet:    VaccineCredentialVaccineRouteValueSet
Id:          vaccine-credential-vaccine-route-value-set
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
ValueSet:    VaccineCredentialFundingSourceValueSet
Id:          vaccine-credential-funding-source-value-set
Title:       "Funding source value set"
Description: "Funding source for the vaccine"

// Support for IIS value set for OBX-5 (extensible)
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3287

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-funding-source

////////////////////////////////////////////////////////////////////////////////////////////////////

// For vaccine reaction Observation (VaccineCredentialVaccineReactionObservation)
ValueSet:    VaccineCredentialVaccineReactionValueSet
Id:          vaccine-credential-vaccine-reaction-value-set
Title:       "Adverse reaction value set"
Description: "Codes describing reactions to vaccinations"

// Support for IIS value set for OBX-5
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3288

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    Covid19LaboratoryTestValueSet
Id:          covid19-laboratory-test-value-set
Title:       "COVID-19 laboratory test code value set"
Description: "Currently includes COVID-19 lab codes via the
[LIVD SARS CoV2 Test Codes value set](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1114.9/expansion)."

// Support for CDC LIVD SARS CoV2 Test Codes
* include codes from system https://cts.nlm.nih.gov/fhir/valueset/2.16.840.1.113762.1.4.1114.9

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
