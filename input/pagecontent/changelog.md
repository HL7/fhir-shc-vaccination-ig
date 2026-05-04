### v1.0.0

The following Jira issues were addressed as part of the v1.0.0 release.

- [FHIR-33195](https://jira.hl7.org/browse/FHIR-33195): Move examples from external GitHub repo into the IG

    Migrated example resources that previously lived in an external GitHub repository into the IG itself so they are published as part of the IG and findable through the standard IG navigation.

- [FHIR-33267](https://jira.hl7.org/browse/FHIR-33267): Fix broken Markdown link and clarify compression wording in Section 1.3

    Repaired a malformed Markdown link in Section 1.3, and rewrote the description of compression in SMART Health Card payloads.

- [FHIR-33349](https://jira.hl7.org/browse/FHIR-33349): Allow gender in the AD Patient profile with an invariant warning

    Allowed Patient.gender in the AD (fallback) Patient profile rather than prohibiting it, added an invariant that emits a warning when gender is populated, and expanded the IG narrative on jurisdiction-specific profiles to better explain why and when gender may be appropriate.

- [FHIR-33350](https://jira.hl7.org/browse/FHIR-33350): Constrain Immunization.status and Observation.status to valid issuance values

    Replaced the existing invariant on Observation.status with a required value set binding to disallow inappropriate status codes (e.g., entered-in-error) in issued cards. Immunization.status is similarly constrained so cards cannot be issued for non-final or erroneous records.

- [FHIR-33380](https://jira.hl7.org/browse/FHIR-33380): Define SHC acronym on first use and introduce Primary/Fallback profile naming

    Introduced "SMART Health Card (SHC)" as a defined acronym on its first use in section 1.1 and added Section 1.3 narrative distinguishing Primary Profiles (data-minimization, DM) from Fallback Profiles (allowable data, AD), including their constraint relationships.

- [FHIR-33381](https://jira.hl7.org/browse/FHIR-33381): Spell out FDA and EUA acronyms on first use

    Expanded "FDA" and "EUA" to their full names on first use — "United States Food and Drug Administration (FDA)" and "Emergency Use Authorization (EUA)" — in the use-case discussion of vaccine acceptance criteria.

- [FHIR-33386](https://jira.hl7.org/browse/FHIR-33386): Document that broad value-set bindings track code system updates

    Added a note to Section 1.6 explaining that when a value set is defined as "include all codes from" a given code system, the binding is not pinned to a specific code system version, so updated content becomes available in expansions and via $validate-code as the underlying code system evolves.

- [FHIR-33433](https://jira.hl7.org/browse/FHIR-33433): Reduce vaccine code systems to CVX, ICD-11, and SNOMED

    Narrowed the allowed code systems for Immunization.vaccineCode from the broader original list (which mixed global and selected national systems) down to CVX, ICD-11, and SNOMED, removing the appearance of preferential treatment for specific national code systems.

- [FHIR-33464](https://jira.hl7.org/browse/FHIR-33464): Add Issuer guidance for handling missing Must Support data

    Addressed comment 6 in this Jira issue by adding Issuer guidance on the profiles page describing what to do when Must Support fields are unavailable, including how to handle unreconciled patient-entered or paper-card data. Comments 3-5 (selective disclosure, identity binding, framework neutrality) were determined to be out of scope.

- [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475): Restrict vaccineCode to CVX, SNOMED vaccine-product children, and specific ICD-11 codes

    Restricted Immunization.vaccineCode to a single value drawn from: any CVX code; any SNOMED code that is a child of 787859002 "Vaccine product" (across SNOMED editions); or a child of ICD-11 XM3KV2, XM61M7, or XM7C66. Aligns with the principle that wallets and verifiers must be able to display and process vaccine codes consistently.

- [FHIR-33525](https://jira.hl7.org/browse/FHIR-33525): Link COVID-19 to WHO instead of CDC in Scope section

    Updated the Scope section so the term "COVID-19" links to the WHO COVID-19 page rather than the CDC's, since this IG is universal-realm rather than US-specific.

- [FHIR-33526](https://jira.hl7.org/browse/FHIR-33526): Remove stray brackets from Use Cases home-page text

    Removed the superfluous square brackets in the Use Cases section that were rendering literally because of malformed Markdown link syntax.

- [FHIR-33527](https://jira.hl7.org/browse/FHIR-33527): Move examples into the IG instead of hosting them on GitHub

    Moved the example resources from the external GitHub repository directly into the IG so they are part of the published artifact and accessible via standard IG navigation and download.

- [FHIR-33528](https://jira.hl7.org/browse/FHIR-33528): Remove extraneous "is" in Approach to Constraints section

    Removed the duplicated word "is" from the cardinality-constraint sentence in the Approach to Constraints section.

- [FHIR-33529](https://jira.hl7.org/browse/FHIR-33529): Fix "steam" typo to "stream" on Contact page

    Corrected the typo "steam" to "stream" in the chat.fhir.org reference on the Contact page.

- [FHIR-33579](https://jira.hl7.org/browse/FHIR-33579): Narrow vaccine code systems to make verifier expectations realistic

    Addressed the concern about overly broad verifier requirements by drastically narrowing the allowed vaccine code systems (per [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475)), so that verifiers no longer face a requirement to interpret codes from systems unlikely to appear in their domain.

- [FHIR-33581](https://jira.hl7.org/browse/FHIR-33581): Reorder table of contents to place Profiles page before resource pages

    Reordered the IG's table of contents so the Profiles page appears before the Patient, Lab Results Observation, and Vaccination pages, giving readers the broader profile structure context before they encounter individual resource profiles.

- [FHIR-33584](https://jira.hl7.org/browse/FHIR-33584): Clarify that Immunization.status "completed" gates resource issuance

    Reworded the guidance on Immunization.status so it more clearly states that only Immunization events whose actual status is "completed" should be rendered as Immunization resources in an SHC FHIR Bundle, rather than implying the fixed value is conditionally applied.

- [FHIR-33585](https://jira.hl7.org/browse/FHIR-33585): Make profile descriptions consistent and group profiles on Artifacts page

    Reorganized the Artifact Summary page to group related profiles together (e.g., keeping AD and DM versions consecutive, moving Bundle profiles to the end) and harmonized profile descriptions so equivalent profiles are described in parallel.

- [FHIR-33586](https://jira.hl7.org/browse/FHIR-33586): Clarify that subject can reference more specific Patient profiles

    Added clarification that constraining .subject (or .patient) to the general Patient profile does not preclude pointing to a more specific derived profile such as the US-specific one, since profile inheritance allows the more specific profile to satisfy the general constraint.

- [FHIR-33597](https://jira.hl7.org/browse/FHIR-33597): Fix punctuation in Patient Usage section

    Corrected the misplaced colon in the Patient Usage narrative around the 0..0 cardinality constraint on US Patient profiles.

- [FHIR-33598](https://jira.hl7.org/browse/FHIR-33598): Fix Markdown link reference for VaccineSNOMED value set

    Corrected a Markdown reference link that pointed to an undefined label "VaccineTypeSNOMED" by changing it to the correct label "VaccineSNOMED", so the link to the SNOMED-CT vaccine-product value set renders correctly.

- [FHIR-33600](https://jira.hl7.org/browse/FHIR-33600): Improve color contrast of profile metadata to meet accessibility guidelines

    Adjusted the gray-on-white profile metadata styling at the top of profile pages to improve contrast for visually impaired users and better align with Section 508 accessibility expectations.

- [FHIR-33601](https://jira.hl7.org/browse/FHIR-33601): Require text element when family/given name cannot both be populated

    Updated the vc-name-invariant constraint and accompanying guidance so that when both family and given name cannot be populated, implementers must use Patient.name.text instead, rather than allowing a name with only a given name.

- [FHIR-33603](https://jira.hl7.org/browse/FHIR-33603): Replace patternCode/patternUri with fixedCode/fixedUri in vaccination profiles

    Switched the vaccination profile constraints on status and vaccineCode.coding.system from pattern-based fixings (patternCode, patternUri) to true fixed values (fixedCode, fixedUri), preventing additional ids or extensions from being attached to those elements.

- [FHIR-33607](https://jira.hl7.org/browse/FHIR-33607): Remove redundant type slicing on Immunization.occurrence[x]

    Removed the type-slice on occurrence[x]:occurrenceDateTime in the vaccination profiles since occurrence[x] is already constrained to dateTime, and replaced the duplicated constraints with an invariant where needed.

- [FHIR-33608](https://jira.hl7.org/browse/FHIR-33608): Reduce slicing complexity of vaccineCode code systems

    Reduced the number of code systems sliced under Immunization.vaccineCode.coding from six to three, which has the side-effect of simplifying the slicing structure.

- [FHIR-33652](https://jira.hl7.org/browse/FHIR-33652): Restrict qualitative lab result coding to SNOMED GPS via community-maintained ValueSet

    Restricted qualitative lab result codings to SNOMED GPS, bound to a community-maintained ValueSet hosted at terminology.smarthealth.cards that supports rapid updates. The IG explicitly scopes this to qualitative results, with the option to add other lab-result types in a future profile.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33666](https://jira.hl7.org/browse/FHIR-33666): Address GitHub-tracked issues critical to STU1 publication

    Worked through and resolved the issues filed on the project's GitHub issue tracker that were on the critical path for STU1 publication, ensuring they were not stranded by the close of the Jira-based ballot process.

- [FHIR-33688](https://jira.hl7.org/browse/FHIR-33688): Add data-flow and profile-relationship diagrams to the IG

    Added two diagrams to the IG: a data-flow diagram showing the relationships between the three actors (Issuer, Holder, Verifier) and the data exchanged between them, and a profile-relationship diagram on the Profiles page illustrating how the DM and AD profiles relate.

- [FHIR-33728](https://jira.hl7.org/browse/FHIR-33728): Keep lot number Must Support but expand the Must Support definition

    Retained Must Support on Immunization.lotNumber and expanded the Must Support definition to clarify that it applies "either for specific records or systems", reflecting that lot number is not always available in real-world deployments.

- [FHIR-33837](https://jira.hl7.org/browse/FHIR-33837): Decouple IG narrative from the SMART Health Cards Framework

    Rewrote the IG to make the FHIR Bundle definition framework-neutral so it can be embedded in QR-code frameworks other than SMART Health Cards. Replaced phrases like "SHCs issued in the US" with framework-neutral wording (e.g., "health cards issued in the US"), clarified the IG's relationship to the SHC spec, and added an FYI link to SHC governance information for implementers.

- [FHIR-33839](https://jira.hl7.org/browse/FHIR-33839): Move vaccine-cvx ValueSet canonical URL to terminology.smarthealth.cards

    Relocated the vaccine-cvx ValueSet (and its canonical URL) from hl7.org/fhir to terminology.smarthealth.cards to support rapid terminology updates outside the slower IG release cadence.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33840](https://jira.hl7.org/browse/FHIR-33840): Move vaccine-snomed ValueSet canonical URL to terminology.smarthealth.cards

    Relocated the vaccine-snomed ValueSet (and its canonical URL) from hl7.org/fhir to terminology.smarthealth.cards to support rapid terminology updates outside the slower IG release cadence.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33841](https://jira.hl7.org/browse/FHIR-33841): Move vaccine-icd-11 ValueSet canonical URL to terminology.smarthealth.cards

    Relocated the vaccine-icd-11 ValueSet (and its canonical URL) from hl7.org/fhir to terminology.smarthealth.cards to support rapid terminology updates outside the slower IG release cadence.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33842](https://jira.hl7.org/browse/FHIR-33842): Move lab-result-findings ValueSet canonical URL to terminology.smarthealth.cards

    Relocated the lab-result-findings ValueSet (and its canonical URL) from hl7.org/fhir to terminology.smarthealth.cards to support rapid terminology updates outside the slower IG release cadence.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33843](https://jira.hl7.org/browse/FHIR-33843): Move qualitative-lab-result-findings ValueSet canonical URL to terminology.smarthealth.cards

    Relocated the qualitative-lab-result-findings ValueSet (and its canonical URL) from hl7.org/fhir to terminology.smarthealth.cards to support rapid terminology updates outside the slower IG release cadence.

    **Note:** These ValueSets were subsequently moved back into this IG due to concerns about dependencies on resources not governed by a stable standards process like HL7 provides.

- [FHIR-33844](https://jira.hl7.org/browse/FHIR-33844): Replace literal brackets with proper hyperlink in Use Cases

    Replaced the literal square-bracketed text "\[constrains the size of the FHIR payload\]" in Section 1.3 with a properly-formatted hyperlink, so the bracketed phrase is no longer rendered as plain text.

- [FHIR-33845](https://jira.hl7.org/browse/FHIR-33845): Note that Patient example also conforms to SHCPatientGeneralDM

    Updated the Use Case 1 narrative to indicate that the John B. Anyperson Patient example conforms to both SHCPatientUnitedStatesDM and SHCPatientGeneralDM, making it explicit for non-US realm implementers that the example is valid against the universal profile as well.

- [FHIR-33846](https://jira.hl7.org/browse/FHIR-33846): Note that lab-results Patient example also conforms to SHCPatientGeneralDM

    Updated the Use Case 2 (laboratory test results) narrative to indicate that the James T. Anyperson Patient example conforms to both SHCPatientUnitedStatesDM and SHCPatientGeneralDM, supporting non-US realm implementers.

- [FHIR-33847](https://jira.hl7.org/browse/FHIR-33847): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28531000087107; instead, the broader resolution of [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) narrows allowed vaccine code systems and supersedes this code-specific change.

- [FHIR-33848](https://jira.hl7.org/browse/FHIR-33848): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 29061000087103; the broader vaccine-code-system change in [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33849](https://jira.hl7.org/browse/FHIR-33849): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28571000087109 (Moderna); the broader vaccine-code-system change in [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33850](https://jira.hl7.org/browse/FHIR-33850): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28581000087106 (Pfizer-BioNTech); the broader vaccine-code-system change in [FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33851](https://jira.hl7.org/browse/FHIR-33851): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28761000087108 (AstraZeneca); the broader vaccine-code-system change [in FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33852](https://jira.hl7.org/browse/FHIR-33852): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28951000087107 (Janssen); the broader vaccine-code-system change [in FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33853](https://jira.hl7.org/browse/FHIR-33853): Defer SNOMED Canadian COVID vaccine display name change to FHIR-33475

    Did not directly add a display name for SNOMED code 28961000087105 (COVISHIELD); the broader vaccine-code-system change [in FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33854](https://jira.hl7.org/browse/FHIR-33854): Defer Novavax SNOMED code addition to FHIR-33475

    Did not directly add the Novavax SNOMED code 29171000087106 to the value set; the broader vaccine-code-system change [in FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this code-specific change.

- [FHIR-33855](https://jira.hl7.org/browse/FHIR-33855): Defer Canadian Vaccine Catalogue value set inclusion to FHIR-33475

    Did not add slices pointing to the Canadian Vaccine Catalogue (CVC) generic and tradename value sets; the broader vaccine-code-system rework [in FHIR-33475](https://jira.hl7.org/browse/FHIR-33475) supersedes this jurisdiction-specific change.

- [FHIR-33857](https://jira.hl7.org/browse/FHIR-33857): Decouple cryptographic signing from privacy in the IG narrative

    Rewrote the narrative around payload minimization and cryptographic signing so the signature is no longer characterized as a privacy mechanism. The text now treats minimization as the privacy control and signing as an integrity/authenticity control.

- [FHIR-33860](https://jira.hl7.org/browse/FHIR-33860): Remove MITRE public-release statement and add a credits page

    Removed the MITRE public-release distribution statement from index.html and added a credits page (modeled on the Da Vinci CRD credits page) where MITRE contributors and the public-release notice are listed, reinforcing that the IG is fully under HL7 governance.

- [FHIR-33862](https://jira.hl7.org/browse/FHIR-33862): Spell out SHC, AD, and DM acronyms earlier and explain profile relationships

    Spelled out the SHC acronym early in the IG and added bullet-point explanations of the AD (allowable data) and DM (data-minimization) profile pair, including the parent-child relationship and the constraints between them, before either abbreviation appears.

- [FHIR-33865](https://jira.hl7.org/browse/FHIR-33865): Clarify narrative on jurisdiction-specific profiles and data minimization

    Rewrote the IG narrative to better explain the relationship between the universal profiles, jurisdiction-specific (e.g., US) profiles, and the data-minimization profiles, clarifying that jurisdiction-specific further-restriction is one example of a pattern other regions may follow.

- [FHIR-33875](https://jira.hl7.org/browse/FHIR-33875): Align IG navigation and look-and-feel with standard HL7 IG patterns

    Restructured the top menu to use it more effectively with "start here"-style top-level entries, added an Artifacts menu, and moved examples into the IG itself rather than linking out to GitHub, bringing the IG closer to the standard HL7 IG presentation.

- [FHIR-34173](https://jira.hl7.org/browse/FHIR-34173): Specify Issuer SHALL and Holder/Verifier SHOULD behavior for non-conformant bundles

    Added explicit guidance: Issuers SHALL ensure the FHIR Bundle in an SHC (or equivalent payload in another health-card standard) conforms to one of the IG's Bundle profiles, and Holders and Verifiers SHOULD provide a user-facing notification when the FHIR payload does not conform.

- [FHIR-34239](https://jira.hl7.org/browse/FHIR-34239): Document middle-name handling on Patient.name.given

    Added a `short` description on Patient.name.given clarifying that all non-family names (including middle names) are members of this element, and added a longer `comment` on Patient.name with additional detail on how to populate names for FHIR-unfamiliar implementers.

- [FHIR-34402](https://jira.hl7.org/browse/FHIR-34402): Apply Must Support to Patient.meta when meta.security is Must Support

    Marked Patient.meta as Must Support to maintain consistency with the conformance guideline that any Must Support child element requires its parent to also be Must Support, fixing an inconsistency where meta.security was MS but meta itself was not.

- [FHIR-34403](https://jira.hl7.org/browse/FHIR-34403): Add Observation.component slice for specimen collection supervision status

    Added a slice on Observation.component in the lab test profiles to represent specimen collection supervision status, allowing credentials to convey the method/supervision of specimen collection where verifiers have collection-related requirements.

- [FHIR-34447](https://jira.hl7.org/browse/FHIR-34447): Add Must Support to Patient.name.prefix and Patient.name.suffix

    Made name.prefix and name.suffix Must Support in the primary Patient profiles and added a comment on each indicating they SHOULD be included if they appear on a government-issued ID, addressing identity-matching mismatches.

- [FHIR-34803](https://jira.hl7.org/browse/FHIR-34803): Include wallet applications in the definition of "Implementers"

    Expanded the "Implementers" definition to explicitly include wallet applications used by Holders to store digital SHCs, in addition to Issuers and Verifiers.

- [FHIR-34815](https://jira.hl7.org/browse/FHIR-34815): Explain profile inheritance with a Venn diagram

    Added narrative describing how profiles inherit from base FHIR resources or from other profiles, accompanied by a Venn diagram.

- [FHIR-41676](https://jira.hl7.org/browse/FHIR-41676): Clarify that Performer is the collecting/testing organization

    Updated the `short` and `definition` of Observation.performer in the lab test profiles to clarify that Performer is typically the organization collecting the sample (e.g., a pharmacy or outpatient facility) or performing the test (e.g., a clinical laboratory), addressing user confusion when the test manufacturer was listed instead of the collection site.

- [FHIR-41677](https://jira.hl7.org/browse/FHIR-41677): Disallow display strings on Observation.code and valueCodeableConcept

    Added rules disallowing display text on Observation.code and Observation.valueCodeableConcept in the lab-test DM profiles (matching the existing treatment of vaccine codes), with additional rules to prevent the snapshot from misleadingly expanding the CodeableConcept presentation.


### v0.6.2

Initial (STU1 ballot) version.
