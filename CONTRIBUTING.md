# Contributing to this IG

The FHIR resources in this IG are defined using [FSH](https://fshschool.org/), rather than JSON or XML.

## Style guide

- Prefer MUST, MUST NOT, SHOULD, SHOULD NOT and MAY for [RFC 2119] key words.
- Referring to resources:
  - Use names (e.g., VaccineCredentialImmunization) rather than IDs (e.g., `vaccine-credential-immunization`) within the IG.
  - Use [reference-style Markdown links](https://daringfireball.net/projects/markdown/syntax#link) when linking to pages within the IG, and use `{% include markdown-link-references.md %}` whenever possible to define the references. This allows you to use `[VaccineCredentialImmunization]` to link to the the corresponding profile, rather than `[VaccineCredentialImmunization](StructureDefinition-vaccine-credential-immunization.html)`.
    - If you want to change the text of the link, you can use `[Vaccine Credential Immunization profile][VaccineCredentialImmunization]`.
    - All appearances of mCODE Artifact names, titles, or IDs MUST be linked to the IG page defining the artifact as described above.
- Use surrounding backticks (\`) to indicate machine-interpretable strings such as FHIR paths (e.g., `Observation.code`) and canonical URIs. In addition to signaling machine-interpretability, this also disambiguates characters that appear similar in variable-width fonts like l/I (`l/I`) or O/0 (`O/0`).
  - Do not use backticks around mCODE FHIR Artifact names (e.g., VaccineCredentialImmunization). Instead, link them to their IG page as described above.
- Capitalize base FHIR resource names (e.g., Patient), but do *not* use backticks around them unless they are in a machine-interpretable context such as a FHIR path.
- FHIR Shorthand (FSH)
  - Prefer RuleSets over abstract profiles

{% include markdown-link-references.md %}