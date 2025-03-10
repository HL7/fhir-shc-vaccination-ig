////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    LabResultFindings
Id:          lab-result-findings
Title:       "Lab result findings (SNOMED CT)"
Description: "This value set includes SNOMED CT codes for identifying laboratory test results."

* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement

The SNOMED International IPS Terminology is distributed by International Health Terminology Standards Development Organisation, trading as SNOMED International, and is subject the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/). For more information, see [SNOMED IPS Terminology](https://www.snomed.org/snomed-ct/Other-SNOMED-products/international-patient-summary-terminology)

The HL7 International IPS implementation guides incorporate SNOMED CT®, used by permission of the International Health Terminology Standards Development Organisation, trading as SNOMED International. SNOMED CT was originally created by the College of American Pathologists. SNOMED CT is a registered trademark of the International Health Terminology Standards Development Organisation, all rights reserved. Implementers of SNOMED CT should review [usage terms](http://www.snomed.org/snomed-ct/get-snomed-ct) or directly contact SNOMED International: info@snomed.org"
* ^experimental = false

* include codes from system SCT where concept descendent-of #441742003 // Evaluation finding (finding)
* include codes from system SCT where concept descendent-of #362981000 // Qualifier value (qualifier value)

////////////////////////////////////////////////////////////////////////////////////////////////////

ValueSet:    CompletedObservationStatus
Id:          completed-observation-status
Title:       "Completed observation status"
Description: "Contains a subset of <http://hl7.org/fhir/ValueSet/observation-status> for completed/amended observations."

* ^experimental = false


* ObsStatus#final
* ObsStatus#amended
* ObsStatus#corrected

////////////////////////////////////////////////////////////////////////////////////////////////////

CodeSystem: IdentityAssuranceLevelCodeSystem
Id: identity-assurance-level-code-system
Title: "Identity Assurance Level Code System"
Description: "Code representing identity assurance level, based on NIST 800-63-3"
* ^url =  "https://smarthealth.cards/ial"
* ^copyright = "Copyright Computational Health Informatics Program, Boston Children's Hospital, Boston, MA as part of the [SMART Health Cards Framework](https://smarthealth.cards/ial). Licensed under CC-BY 4.0 (<https://creativecommons.org/licenses/by/4.0/>)."

* ^experimental = false
* ^caseSensitive = false

* #IAL1 "Name and birth date were self-asserted."
* #IAL1.2 "An unspecified ID was used to verify name and birth date."
* #IAL1.4 "A US state-issued photo ID or nationally-issued photo ID was used to verify name and birth date."
* #IAL2 "Either remote or in-person identity proofing is required. IAL2 requires identifying attributes to have been verified in person or remotely using, at a minimum, the procedures given in NIST Special Publication 800-63A."
* #IAL3 "In-person identity proofing is required. Identifying attributes must be verified by an authorized CSP representative through examination of physical documentation as described in NIST Special Publication 800-63A."


ValueSet:    IdentityAssuranceLevel
Id:          identity-assurance-level
Title:       "Identity Assurance Level"
Description: "Relevant identity assurance level codes, based on NIST 800-63-3. See <https://smarthealth.cards/ial> for details."
* ^experimental = false
* include codes from system IAL
* exclude IAL#IAL1


////////////////////////////////////////////////////////////////////////////////////////////////////


ValueSet:    SpecimenCollectionSupervisionStatus
Id:          specimen-collection-supervision-status
Title:       "Specimen Collection Supervision Status"
Description: "Relevant codes representing specimen collection supervision status"
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement

The SNOMED International IPS Terminology is distributed by International Health Terminology Standards Development Organisation, trading as SNOMED International, and is subject the terms of the [Creative Commons Attribution 4.0 International Public License](https://creativecommons.org/licenses/by/4.0/). For more information, see [SNOMED IPS Terminology](https://www.snomed.org/snomed-ct/Other-SNOMED-products/international-patient-summary-terminology)

The HL7 International IPS implementation guides incorporate SNOMED CT®, used by permission of the International Health Terminology Standards Development Organisation, trading as SNOMED International. SNOMED CT was originally created by the College of American Pathologists. SNOMED CT is a registered trademark of the International Health Terminology Standards Development Organisation, all rights reserved. Implementers of SNOMED CT should review [usage terms](http://www.snomed.org/snomed-ct/get-snomed-ct) or directly contact SNOMED International: info@snomed.org"
* ^experimental = false
* SCT#1208526009 "Specimen collection by subject unsupervised by healthcare professional (finding)"
* SCT#1208525008 "Virtual supervision by healthcare professional of specimen collection by subject (finding)"
* SCT#1208524007 "In-person supervision by healthcare professional of specimen collection by subject (finding)"
* SCT#1208523001 "Specimen collection by healthcare professional (finding)"
