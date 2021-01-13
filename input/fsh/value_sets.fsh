////////////////////////////////////////////////////////////////////////////////////////////////////

Alias: CVX = http://hl7.org/fhir/sid/cvx
Alias: LNC = http://loinc.org
Alias: SCT = http://snomed.info/sct
Alias: ACT = http://terminology.hl7.org/CodeSystem/v3-ActReason

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem:  OtherSpecifyCS
Id:          yellow-card-other-specify-code-system
Title:       "Other Specify Code System"
Description: "A code system containing codes signifying a value set has been extended, using an 'Other ____, Specify' approach."
* #OtherCVX "Other vaccine CVX code."
* #OtherAntibodyResult "Other antibody result"

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    YellowCardCVXValueSet
Id:          yellow-card-cvx-value-set
Title:       "CVX codes value set"
Description: "Curated set of CVX codes for the Vaccine Yellow Card"
* OtherSpecifyCS#OtherCVX

// Moderna COVID-19 Vaccine: SARS-COV-2 (COVID-19) vaccine, mRNA, spike protein, LNP, preservative free, 100 mcg/0.5mL dose
* CVX#207

// Pfizer-BioNTech COVID-19 Vaccine: SARS-COV-2 (COVID-19) vaccine, mRNA, spike protein, LNP, preservative free, 30 mcg/0.3mL dose
* CVX#208

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    YellowCardAntibodyResultValueSet
Id:          yellow-card-antibody-result-value-set
Title:       "Antibody results value set"
Description: "Result codes for SARS coronavirus 2 antibodies"
* OtherSpecifyCS#OtherAntibodyResult
* LNC#LA6577-6 "Negative"
* LNC#LA6576-8 "Positive"

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.statusReason
ValueSet:    YellowCardStatusReasonValueSet
Id:          yellow-card-status-reason-value-set
Title:       "Status reason value set"
Description: "Reasons a vaccine was not given"
* ACT#IMMUNE
* ACT#MEDPREC
* ACT#OSTOCK
* ACT#PATOBJ

// Support for IIS value set for RXA-18 (refusal reason) - this is CDC NIP002
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3380

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.reportOrigin
ValueSet:    YellowCardReportOriginValueSet
Id:          yellow-card-report-origin-value-set
Title:       "Secondarily reported record source value set"
Description: "Source of secondarily reported records"

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-origin

// Support for IIS value set for RXA-9 - this is part of CDC NIP001
* include codes from system https://phinvads.cdc.gov/vads/ViewCodeSystem.action?id=2.16.840.1.114222.4.5.293

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.site
ValueSet:    YellowCardVaccineSiteValueSet
Id:          yellow-card-vaccine-site-value-set
Title:       "Body site for vaccine administration value set"
Description: "Body site vaccine was administered"

// Support for IIS value set for RXR-2
* include codes from system http://terminology.hl7.org/CodeSystem/v2-0163

// Support for example binding from base FHIR Immunization resource
* include codes from system http://terminology.hl7.org/CodeSystem/v3-ActSite

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.route
ValueSet:    YellowCardVaccineRouteValueSet
Id:          yellow-card-vaccine-route-value-set
Title:       "Vaccination route value set"
Description: "How vaccine entered the body"

// Support for IIS value set for RXR-1
* include codes from system http://terminology.hl7.org/CodeSystem/v2-0162

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-route

////////////////////////////////////////////////////////////////////////////////////////////////////

// Not sure if we want to create a value set for program eligibility. This is presumably not
// relevant for COVID-19, and the IIS value set (for OBX-5) is user-defined.

////////////////////////////////////////////////////////////////////////////////////////////////////

// For Immunization.fundingSource
ValueSet:    YellowCardFundingSourceValueSet
Id:          yellow-card-funding-source-value-set
Title:       "Funding source value set"
Description: "Funding source for the vaccine"

// Support for IIS value set for OBX-5 (extensible)
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3287

// Support for example binding from base FHIR Immunization resource
* include codes from system http://hl7.org/fhir/ValueSet/immunization-funding-source

////////////////////////////////////////////////////////////////////////////////////////////////////

// For vaccine reaction Observation (YellowCardVaccineReactionObservation)
ValueSet:    YellowCardVaccineReactionValueSet
Id:          yellow-card-vaccine-reaction-value-set
Title:       "Adverse reaction value set"
Description: "Codes describing reactions to vaccinations"

// Support for IIS value set for OBX-5
* include codes from system https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.3288

////////////////////////////////////////////////////////////////////////////////////////////////////
