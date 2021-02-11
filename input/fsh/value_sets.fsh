////////////////////////////////////////////////////////////////////////////////////////////////////

Alias: CVX = http://hl7.org/fhir/sid/cvx
Alias: LNC = http://loinc.org
Alias: SCT = http://snomed.info/sct
Alias: ACT = http://terminology.hl7.org/CodeSystem/v3-ActReason

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem:  CatchCodeCS
Id:          vaccine-credential-catch-code-cs
Title:       "CatchCodeCS Code System"
Description: "A code system containing codes that signify a code outside a specified value set has been used, using an 'Other ____, Specify' approach."
* #OTHER-VACCINE "Other vaccine without published CVX"
* #OTHER-ANTIBODY-RESULT "Other antibody result"

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineCredentialCVXValueSet
Id:          vaccine-credential-cvx-value-set
Title:       "CVX codes value set"
Description: "Curated set of CVX codes for the vaccine credential Health Card"
* CatchCodeCS#OTHER-VACCINE
* include codes from system CVX


// Not limiting to just COVID EUA vaccines for now - see index.md for details
// Moderna COVID-19 Vaccine: SARS-COV-2 (COVID-19) vaccine, mRNA, spike protein, LNP, preservative free, 100 mcg/0.5mL dose
// * CVX#207
// Pfizer-BioNTech COVID-19 Vaccine: SARS-COV-2 (COVID-19) vaccine, mRNA, spike protein, LNP, preservative free, 30 mcg/0.3mL dose
// * CVX#208

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineCredentialAntibodyResultValueSet
Id:          vaccine-credential-antibody-result-value-set
Title:       "Antibody results value set"
Description: "Result codes for SARS coronavirus 2 antibodies"
* CatchCodeCS#OTHER-ANTIBODY-RESULT
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
