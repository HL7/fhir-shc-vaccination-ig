# Contributing to this IG

## Contribution workflow

We use a standard GitHub pull request workflow for all contributions.

All commits that nontrivially affect IG content must have messages prefixed with a [jira.hl7.org](https://jira.hl7.org) `FHIR` issue number before merging into `master`[^rename]. Here's [an example](https://github.com/HL7/fhir-shc-vaccination-ig/commit/21a6336bbeb754daddb2275fc05deabf882e6402):

> FHIR-33267: Remove invariant that is no longer needed
>
> ...rest of commit message...

This allows us to track commits closely with the [HL7 balloting process](https://confluence.hl7.org/display/HL7/HL7+Balloting) that governs this IG. If you don't have an HL7 Jira issue for your change, you can create one yourself after [requesting a (free) Jira account from HL7](https://jira.hl7.org/secure/CreateIssue.jspa?pid=11200&issuetype=11300), or ask the maintainers to create an HL7 Jira issue for you as part of your pull request.

Before requesting review/merging of a pull request, please [clean up your commit history](https://about.gitlab.com/blog/2018/06/07/keeping-git-commit-history-clean/) and add the `FHIR-00000` prefix if needed. If you need to reference multiple issues, you can separate them with commas.

Branch names like `FHIR-00000-some-short-description` are preferred but not required.

Contributors may open a pull request to add themselves to the credits list on [index.html in the IG build](https://github.com/HL7/fhir-shc-vaccination-ig/blob/master/input/pagecontent/index.md#credits).

[^rename]: This will be renamed to `main` once the [FHIR CI build](https://fhir.github.io/auto-ig-builder/builds.html) supports this).

## IG style guide

The FHIR resources in this IG are defined using [FSH](https://fshschool.org/), rather than JSON or XML.

- Prefer MUST, MUST NOT, SHOULD, SHOULD NOT and MAY for [RFC 2119] key words.
- Referring to resources:
  - Use names (e.g., SHCVaccinationDM) rather than IDs (e.g., `shc-vaccination-dm`) within the IG.
  - Use [reference-style Markdown links](https://daringfireball.net/projects/markdown/syntax#link) when linking to pages within the IG, and use `{% include markdown-link-references.md %}` whenever possible to define the references. This allows you to use `[SHCVaccinationDM]` to link to the the corresponding profile, rather than `[SHCVaccinationDM](StructureDefinition-shc-vaccination-dm.html)`.
    - If you want to change the text of the link, you can use `[SHC vaccination profile][SHCVaccinationDM]`.
    - All appearances of artifact names, titles, or IDs MUST be linked to the IG page defining the artifact as described above.
- Use surrounding backticks (\`) to indicate machine-interpretable strings such as FHIR paths (e.g., `Observation.code`) and canonical URIs. In addition to signaling machine-interpretability, this also disambiguates characters that appear similar in variable-width fonts like l/I (`l/I`) or O/0 (`O/0`).
  - Do not use backticks around FHIR Artifact names (e.g., SHCVaccinationDM). Instead, link them to their IG page as described above.
- Capitalize base FHIR resource names (e.g., Patient), but do *not* use backticks around them unless they are in a machine-interpretable context such as a FHIR path.
- FHIR Shorthand (FSH) guidelines
  - Prefer RuleSets over abstract profiles