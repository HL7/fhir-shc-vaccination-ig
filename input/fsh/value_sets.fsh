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

ValueSet:    VaccineTypeSNOMEDValueSet
Id:          vaccine-type-snomed-value-set
Title:       "Value set: SNOMED-CT vaccine product codes"
Description: "This value set includes the vaccination product codes from SNOMED Clinical Terms®.

**Note that the value set expansion below may be out of date, and may not include COVID-19-related
codes.** Implementers SHALL defer to [the canonical list of COVID-19-related SNOMED codes][snomed-covid]
for COVID-related vaccines when it does not match the codes listed below.

[snomed-covid]: https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content
"

* ^copyright = "This value set includes content from SNOMED-CT, which is copyright © 2002+
International Health Terminology Standards Development Organization (IHTSDO), and distributed by
agreement between IHTSDO and HL7. Implementer use of SNOMED-CT is not covered by this agreement.

Note that some of the SNOMED-CT codes that are part of this value set expansion,
[including the COVID-19-related SNOMED codes][snomed-covid],
may be used under the a [Creative Commons Attribution 4.0 International License][cc-ail] as part
of [the SNOMED Global Patient Set](https://gps.snomed.org). Please refer to [https://gps.snomed.org](https://gps.snomed.org)
to determine which specific SNOMED codes may be used under this license.

[snomed-covid]: https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content
[cc-ail]: https://creativecommons.org/licenses/by/4.0/
"

* include codes from system SCT where concept is-a #787859002

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineTargetICD11ValueSet
Id:          vaccine-target-icd-11-value-set
Title:       "Value set: all ICD-11 codes for vaccine types"
Description: "This value set includes the subset of [ICD-11](https://icd.who.int/en) that identify vaccine types.

Note that the COVID-related ICD-11 vaccine codes are not in the `09/2020` version of ICD-11. They
can be found on the [maintenance platform](https://icd.who.int/dev11/l-m/en), and include:

* `XM1NL1`: COVID-19 vaccine, inactivated virus
* `XM5DF6`: COVID-19 vaccine, live attenuated virus
* `XM9QW8`: COVID-19 vaccine, non-replicating viral vector
* `XM0CX4`: COVID-19 vaccine, replicating viral vector
* `XM5JC5`: COVID-19 vaccine, virus protein subunit
* `XM1J92`: COVID-19 vaccine, virus like particle (VLP)
* `XM6AT1`: COVID-19 vaccine, DNA based
* `XM0GQ8`: COVID-19 vaccine, RNA based

Implementers should consider the [ICD-11 maintenance platform](https://icd.who.int/dev11/l-m/en)
the canonical source of ICD-11 codes for COVID-19 vaccines.

Note that this value set should contain the same codes as the [WHO Vaccine List value set](https://who-int.github.io/svc/ValueSet-who-svc-vaccines.html),
and may be replaced with the WHO value set once that is published.
"

* ^copyright = "TBD. More information can be found here: https://icd.who.int/icdapi/docs2/license/
Contact licensing@who.int to obtain further information."

// HL7 Terminology Authority page for ICD-11
// https://confluence.hl7.org/pages/viewpage.action?pageId=97481986

// XM3KV2 Bacterial vaccines
* include codes from system ICD11 where concept is-a #XM3KV2

// XM61M7 Viral vaccines
* include codes from system ICD11 where concept is-a #XM61M7

// XM4W25 Combination vaccines
* include codes from system ICD11 where concept is-a #XM4W25

// XM7C66 Bacterial and viral vaccines, combined
* include codes from system ICD11 where concept is-a #XM7C66


////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccineTargetATCValueSet
Id:          vaccine-target-atc-value-set
Title:       "Value set: all ATC codes for vaccine types"
Description: "This value set includes the subset of [ATC](https://www.whocc.no/atc_ddd_index/?code=J07) that identify vaccine targets.

Note that an ATC code for COVID-19 vaccines (`J07BX03`) [has been created](https://www.who.int/medicines/publications/druginformation/issues/WHO_DI_34_4_ATC-DDD_ClassificationTemp.pdf) and will be added to the next published version of ATC/DDD slated for January 2022."
// Antatomic, Therapeutic and Chemical Classification (ATC)
// https://confluence.hl7.org/pages/viewpage.action?pageId=104584082

* ^copyright = "© Copyright WHO Collaborating Centre for Drug Statistics Methodology, Oslo, Norway. Use of all or parts of the material requires reference to the WHO Collaborating Centre for Drug Statistics Methodology. Copying and distribution for commercial purposes is not allowed. Changing or manipulating the material is not allowed."

* include codes from system https://www.whocc.no/atc_ddd_index/ where concept is-a #J07

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialLabTestValueSet
Id:          vaccination-credential-lab-test-value-set
Title:       "Value set: laboratory tests"
Description: "This value set includes codes for identifying laboratory tests."

* include codes from system LNC

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialLabTestResultsValueSet
Id:          vaccination-credential-lab-test-results-value-set
Title:       "Value set: laboratory test results"
Description: "This value set includes codes for identifying laboratory test results."

// Include all clinical finding codes
* include codes from system SCT where concept is-a #404684003

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    VaccinationCredentialCOVIDLabTestResultsValueSet
Id:          vaccination-credential-covid-lab-test-results-value-set
Title:       "Value set: COVID-19 laboratory test results"
Description: "This value set includes codes for identifying laboratory test results. It includes both SNOMED-CT and LOINC codes."

* include codes from valueset covid-lab-test-results-snomed-vsac

// Include codes from LOINC answer lists

// http://loinc.org/vs/LL1055-4 // Detected|Not det|Equiv|Inconcl|Spec unsat for eval
* LNC#LA11882-0 "Detected"
* LNC#LA11883-8 "Not detected"
* LNC#LA11885-3 "Equivocal"
* LNC#LA9663-1 "Inconclusive"
* LNC#LA13548-5 "Specimen unsatisfactory for evaluation"

// http://loinc.org/vs/LL2206-2 // Neg|Borderline|Pos|Strong Pos
* LNC#LA6577-6 "Negative"
* LNC#LA4259-3 "Borderline"
* LNC#LA6576-8 "Positive"
* LNC#LA18996-1 "Strong positive"

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: IdentityAssuranceLevelCodeSystem
Id: identity-assurance-level-code-system
Title: "Identity Assurance Level Code System"
Description: "Code representing identity assurance level, based on NIST 800-63-3"
* ^url =  https://smarthealth.cards/ial
* ^copyright = "Copyright Computational Health Informatics Program, Boston Children's Hospital, Boston, MA as part of the [SMART Health Cards Framework](https://smarthealth.cards/ial). Licensed under CC-BY 4.0 (<https://creativecommons.org/licenses/by/4.0/>)."
* #IAL1 "Name and birth date were self-asserted."
* #IAL1.2 "An unspecified ID was used to verify name and birth date."
* #IAL1.4 "A US state-issued photo ID or nationally-issued photo ID was used to verify name and birth date."
* #IAL2 "Either remote or in-person identity proofing is required. IAL2 requires identifying attributes to have been verified in person or remotely using, at a minimum, the procedures given in NIST Special Publication 800-63A."
* #IAL3 "In-person identity proofing is required. Identifying attributes must be verified by an authorized CSP representative through examination of physical documentation as described in NIST Special Publication 800-63A."


ValueSet:    IdentityAssuranceLevelValueSet
Id:          identity-assurance-level-value-set
Title:       "Identity Assurance Level Value Set"
Description: "Relevant identity assurance level codes, based on NIST 800-63-3. See <https://smarthealth.cards/ial> for details."
* include codes from system IAL
* exclude IAL#IAL1


////////////////////////////////////////////////////////////////////////////////////////////////////
