////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineProductCVXValueSet
Id:          vaccine-product-cvx-value-set
Title:       "Value set: all CVX codes"
Description: "This value set includes all [CVX](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) codes, which identify vaccine products."

* include codes from system http://hl7.org/fhir/sid/cvx

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineProductGTINValueSet
Id:          vaccine-product-gtin-value-set
Title:       "Value set: all GTIN codes"
Description: "This value set includes all [GTIN](https://www.gs1.org/gtin) codes, which may identify vaccine products."

* include codes from system https://www.gs1.org/gtin

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineProductSNOMEDValueSet
Id:          vaccine-product-snomed-value-set
Title:       "Value set: SNOMED-CT vaccine product codes"
Description: "This value set includes the vaccination product codes from SNOMED Clinical Terms®.

**Note that the value set expansion below may be out of date, and may not include COVID-19-related
codes.** Implementers SHALL defer to [the canonical list of COVID-19-related SNOMED codes][snomed-covid]
for COVID-related vaccines when it does not match the codes listed below.
"

* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+
International Health Terminology Standards Development Organization (IHTSDO), and distributed by
agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement.

Note that some COVID-19-related SNOMED codes [are part of the SNOMED Global Patient Set (GPS)][snomed-covid]
and can be used now under the same open license as the GPS, the
[Creative Commons Attribution 4.0 International License][cc-ail].

[snomed-covid]: https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content
[cc-ail]: https://creativecommons.org/licenses/by/4.0/
"

* include codes from system SCT where concept is-a #787859002

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialVaccineManufacturerValueSet
Id:          vaccination-credential-vaccine-manufacturer-value-set
Title:       "Vaccine manufacturer value set"
Description: "This value set includes codes for identifying vaccine manufacturers.

Codes from the following systems are currently included:

1. [MVX](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=mvx) (`http://terminology.hl7.org/CodeSystem/MVX` (preferred) or `http://terminology.hl7.org/CodeSystem/v2-0227`), a code system maintained by CDC for identifying manufacturers of vaccines
2. [GLN](https://www.gs1.org/standards/id-keys/gln) (`https://www.gs1.org/gln`), which can be used to identify \"any legal entity or organisation: such as
company operating in the supply chain including suppliers, customers, financial services companies, hospitals and freight forwarders\" ([source](https://www.gs1.org/docs/idkeys/GS1_Global_Location_Numbers.pdf))

"

// MVX codes - identifies manufacturer https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.826

// This value set uses http://terminology.hl7.org/CodeSystem/v2-0227 as the code system
* include codes from valueset http://phinvads.cdc.gov/fhir/ValueSet/2.16.840.1.114222.4.11.826

// There's another HL7 representation of MVX with a cleaner URI so use/prefer that
* include codes from system http://terminology.hl7.org/CodeSystem/MVX

// This is the code system for GLN (it resolves in a browser). There doesn't appear to be HL7/FHIR support for it currently.
* include codes from system https://www.gs1.org/gln

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
