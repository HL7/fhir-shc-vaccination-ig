<span class="label label-danger">NOTE</span> This implementation guide is under **active development** on [GitHub](https://github.com/dvci/vaccine-credential-ig/issues), and **may change without notice**. Please comment on or [create](https://github.com/dvci/vaccine-credential-ig/issues/new) an issue on GitHub if you have questions, comments, or suggestions. Contributions are welcome!

<div class="alert alert-info" role="alert" markdown="1">
<p style="font-size: 2rem;"><strong>Known issues</strong></p>

* The expansion of [VaccinationCredentialVaccineValueSet] currently has an out-of-date list of [CVX codes](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx). This will be fixed in the next deploy of the HL7 terminology server (`tx.fhir.org`).<br><br>
* Other value sets in this IG may also have out-of-date expansions. If a given code is listed in the canonical source for a given code system or value set, it should be considered valid regardless of the expansion in this IG.<br><br>
* Validation with the FHIR Validator tool currently produces spurious errors for valid resources. [Details here](conformance.html#validation).

</div>

### Scope

This [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG):

1. Describes the clinical information necessary to create a [SMART Health Card] identifying vaccination and laboratory testing status for infectious diseases such as [COVID-19](https://www.cdc.gov/coronavirus/2019-ncov/index.html). In particular, it describes the content of the credential subject of a verifiable credential in which the credential types include `https://smarthealth.cards#health-card`, `https://smarthealth.cards#immunization` and/or `https://smarthealth.cards#laboratory`, and optionally `https://smarthealth.cards#covid19`.
2. Describes a minimal set of patient information (name and contact information) that is also included in the [SMART Health Card].

**The goal of this IG is to constrain resources for use specifically in [SMART Health Cards].** This applies to the contents of both digital and paper Health Cards, including Health Cards produced via a Health Card-specific FHIR endpoint like `[base]/Patient/:id/$health-cards-issue`. This IG is not applicable to general purpose FHIR endpoints like `[base]/Patient/:id/Immunization`; these are governed by other IGs like [US Core](https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html).

Note that this IG is not directly related to the [SMART App Launch Framework](http://www.hl7.org/fhir/smart-app-launch/). The name comes from [SMART Health IT](https://smarthealthit.org/), who also developed the [SMART Health Card] framework that this IG supports. SMART App Launch and SMART Health Cards are designed to work well together (the former being one of multiple methods for issuing the latter), but they don't have a hard dependency with each other.

### Actors

The primary actors are:

1. **Issuers** who produce the FHIR resources described in this IG. These may be the entities responsible for giving vaccinations or reporting laboratory results, including health systems, pharmacies, clinical labs, and doctors offices.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG.

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent COVID-19 vaccination status and laboratory testing for verification purposes in a SMART Health Card.

Due to the size constraints of the SMART Health Card payload, a "data minimization" profile is provided to supplement each of the "allowable data" profiles. Please see the [Data minimization](conformance.html#data-minimization) section for details.

#### Use case 1: vaccination credentials

To represent patient and clinical data related to a vaccination, the [VaccinationCredentialBundle] SHALL be used to wrap resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data                       | Profile: Data Minimization                      | Purpose                                       | Required in bundle?     |
| --------------------------------------------- | ----------------------------------------------- | --------------------------------------------- | ----------------------- |
| [VaccinationCredentialPatient]                    | [VaccinationCredentialPatientDM]                    | Identify the patient                          | Exactly 1 required      |
| [VaccinationCredentialImmunization]               | [VaccinationCredentialImmunizationDM]               | Describe a vaccination                        | 1 or more required      |
| [VaccinationCredentialVaccineReactionObservation] | [VaccinationCredentialVaccineReactionObservationDM] | Describe an adverse reaction to a vaccination | Optional (experimental) |
| Bundle: [VaccinationCredentialBundle]             | Bundle: [VaccinationCredentialBundleDM]             | Bundle for wrapping the above resources       | n/a                     |

Examples using these profiles:

> **Scenario 1:** A patient receives two doses of the Moderna COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario1Bundle.json)

> **Scenario 2:** A patient receives two doses of the Pfizer-BioNTech COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario2Bundle.json)


#### Use case 2: laboratory test result credentials

To represent patient and laboratory test result information, [Covid19LaboratoryBundle] or [InfectiousDiseaseLaboratoryBundle] SHALL be used to wrap resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data                                                 | Profile: Data Minimization                                                  | Purpose                                 | Required in bundle? |
| ----------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------- | ------------------- |
| [VaccinationCredentialPatient]                                              | [VaccinationCredentialPatientDM]                                                | Identify the patient                    | Required            |
| [Covid19LaboratoryResultObservation]                                    | [Covid19LaboratoryResultObservationDM]                                      | Identify the lab test and result        | Required            |
| Bundles: [Covid19LaboratoryBundle], [InfectiousDiseaseLaboratoryBundle] | Bundles: [Covid19LaboratoryBundleDM], [InfectiousDiseaseLaboratoryBundleDM] | Bundle for wrapping the above resources | n/a                 |

An example using these profiles:

> **Scenario 3:** A patient is tested for SARS-CoV-2 (COVID19) antigen via rapid immunoassay on February 17, 2021 with result detectable. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario3Bundle.json)

A laboratory results profile specific to COVID-19 is provided to limit the `code` to a [value set describing COVID-19-specific tests][Covid19LaboratoryTestValueSet]. Additional disease-specific profiles may be added in the future. To represent a disease without a specific set of profiles, implementers SHALL use [InfectiousDiseaseLaboratoryResultObservation] and [InfectiousDiseaseLaboratoryResultObservationDM], which can be used with [InfectiousDiseaseLaboratoryBundle].

### Approach to constraints in profiles

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

    For example, constraining the [VaccinationCredentialImmunization] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

    For example, some parties may only consider FDA-approved or EUA vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

1. Cardinality constraints are applied to specific data elements in [Allowable Data profiles](conformance.html#data-minimization) when their inclusion (1) is does not support our use case and could harm patients; or (2) is contrary to our [key design principles](https://vci.org/about#key-principles). For example, `Patient.identifier` is not allowed in resources conforming to [VaccinationCredentialPatient] as this may include a MRN or SSN, which would introduce a significant privacy risk for patients.

### Approach to terminology bindings

Value set bindings for [`MustSupport` elements](conformance.html) are `required`, meaning that resources MUST use a code specified in the bound value set. This is to ensure implementers know which code systems can be expected to appear in a given element.

In general, the value sets used in these `required` bindings are as broad as possible. For example, in [VaccinationCredentialVaccineValueSet], all codes from the [CVX code system](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) are included (as opposed to defining a value set with just COVID-related CVX codes, for example).

In cases where disease-specific value sets exist, this IG may provide profiles with bindings to these restricted value sets (e.g., [Covid19LaboratoryResultObservation]) to help implementers identify the preferred subset of codes for that disease. However, in these cases, this IG will also provide generic equivalents to these profiles with broad value sets (e.g., [InfectiousDiseaseLaboratoryResultObservation]). Implementers MAY fall back to the generic version such profiles if the code they need is not part of the disease-specific value sets.

Currently this IG uses US-centric terminology. We plan to add support for non-US terminology, and welcome any implementers outside the US to [identify which code systems and value sets are needed for their use cases](https://github.com/dvci/vaccine-credential-ig/issues/83).

### Identity assurance

The [VaccinationCredentialPatient] and [Covid19LaboratoryBundle]/[InfectiousDiseaseLaboratoryBundle] profiles include a mechanism for indicating level of identity assurance of the patient. This uses the [IdentityAssuranceLevelValueSet] in this format:

```json
"meta": {
  "security": [{"system": "https://smarthealth.cards/ial", "code": "IAL1.2"}]
}
```

Issuers SHALL populate these elements if identity assurance information is available.

### Compatibility with IIS

Resources representing a vaccination and associated data should be able to be directly populated with data from [IIS](https://www.cdc.gov/vaccines/programs/iis/index.html) implementations using the [HL7 v2.5.1 Implementation Guide for Immunization Messaging, Release 1.5](https://repository.immregistries.org/resource/hl7-version-2-5-1-implementation-guide-for-immunization-messaging-release-1-5-1/).

<!--
### Supplemental data dictionary

There is an [Excel data dictionary](data-dictionary/data_dictionary.xlsx) available here. This presents the IG's content in a format that may be more accessible than the default FHIR artifact pages. The Data Dictionary is a Excel spreadsheet that lists data elements and some details about them. If there is a discrepancy between the Data Dictionary and the FHIR artifacts, the FHIR artifacts are taken as the source of truth.

-->

### Contact information

This FHIR Implementation Guide was developed as part of the [Vaccination Credential Initiative](https://vci.org). Please direct questions or comments to [vci-ig@mitre.org](mailto:vci-ig@mitre.org).

----

MITRE: Approved for Public Release. Distribution Unlimited. Case Number 21-0225

{% include markdown-link-references.md %}

<script>
// Move Markdown TOC below alert box for cosmetics
var ref = document.querySelector('div.alert');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertBefore(el, ref.nextSibling);
</script>
