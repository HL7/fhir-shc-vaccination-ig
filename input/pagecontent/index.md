<span class="label label-danger">NOTE</span> This implementation guide is under **active development** on [GitHub](https://github.com/dvci/vaccine-credential-ig/issues), and **may change without notice**. Please comment on or [create](https://github.com/dvci/vaccine-credential-ig/issues/new) an issue on GitHub if you have questions, comments, or suggestions. Contributions are welcome!

<div class="alert alert-info" role="alert" markdown="1">
<p style="font-size: 2rem;"><strong>Known issues</strong></p>

* The [official FHIR CVX code system](https://terminology.hl7.org/2.0.0/CodeSystem-v2-0292.html) does not have up-to-date [CVX codes](https://phinvads.cdc.gov/vads/ViewValueSet.action?id=6F408928-7C62-EB11-819A-005056ABE2F0). We are working with HL7 to resolve this. In the meantime, we have defined a temporary local code system called `http://hl7.org/fhir/sid/cvx-TEMPORARY-CODE-SYSTEM`. This will be replaced by `http://hl7.org/fhir/sid/cvx` or another non-local code system as soon as possible. Implementers may use `http://hl7.org/fhir/sid/cvx-TEMPORARY-CODE-SYSTEM` to avoid validation errors when testing, but should use `http://hl7.org/fhir/sid/cvx` in production. Verifiers should validate CVX codes using the [PHVS_VaccinesAdministeredCVX_CDC_NIP value set](https://phinvads.cdc.gov/vads/ViewValueSet.action?oid=2.16.840.1.114222.4.11.934).<br><br>
* Other value sets in this IG are not being properly expanded. We are working to resolve this.<br><br>
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

To represent patient and clinical data related to a vaccination, the [VaccineCredentialBundle] SHALL be used to wrap resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data                       | Profile: Data Minimization                      | Purpose                                       | Required in bundle?     |
| --------------------------------------------- | ----------------------------------------------- | --------------------------------------------- | ----------------------- |
| [VaccineCredentialPatient]                    | [VaccineCredentialPatientDM]                    | Identify the patient                          | Exactly 1 required      |
| [VaccineCredentialImmunization]               | [VaccineCredentialImmunizationDM]               | Describe a vaccination                        | 1 or more required      |
| [VaccineCredentialVaccineReactionObservation] | [VaccineCredentialVaccineReactionObservationDM] | Describe an adverse reaction to a vaccination | Optional (experimental) |
| Bundle: [VaccineCredentialBundle]             | Bundle: [VaccineCredentialBundleDM]             | Bundle for wrapping the above resources       | n/a                     |

Examples using these profiles:

> **Scenario 1:** A patient receives two doses of the Moderna COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario1Bundle.json)

> **Scenario 2:** A patient receives two doses of the Pfizer-BioNTech COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario2Bundle.json)


#### Use case 2: laboratory test result credentials

To represent patient and laboratory test result information, [Covid19LaboratoryBundle] or [InfectiousDiseaseLaboratoryBundle] SHALL be used to wrap resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data                                                 | Profile: Data Minimization                                                  | Purpose                                 | Required in bundle? |
| ----------------------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------- | ------------------- |
| [VaccineCredentialPatient]                                              | [VaccineCredentialPatientDM]                                                | Identify the patient                    | Required            |
| [Covid19LaboratoryResultObservation]                                    | [Covid19LaboratoryResultObservationDM]                                      | Identify the lab test and result        | Required            |
| Bundles: [Covid19LaboratoryBundle], [InfectiousDiseaseLaboratoryBundle] | Bundles: [Covid19LaboratoryBundleDM], [InfectiousDiseaseLaboratoryBundleDM] | Bundle for wrapping the above resources | n/a                 |

An example using these profiles:

> **Scenario 3:** A patient is tested for SARS-CoV-2 (COVID19) antigen via rapid immunoassay on February 17, 2021 with result detectable. [See an example of a FHIR Bundle representing this.](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario3Bundle.json)

A laboratory results profile specific to COVID-19 is provided to limit the `code` to a [value set describing COVID-19-specific tests][Covid19LaboratoryTestValueSet]. Additional disease-specific profiles may be added in the future. To represent a disease without a specific set of profiles, implementers SHALL use [InfectiousDiseaseLaboratoryResultObservation] and [InfectiousDiseaseLaboratoryResultObservationDM], which can be used with [VaccineCredentialLaboratoryBundle].

### Approach to constraints in profiles

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

    For example, constraining the [VaccineCredentialImmunization] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

    For example, some parties may only consider FDA-approved or EUA vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

1. Constraints are applied to specific data elements in [Allowable Data profiles](conformance.html#data-minimization) when their inclusion (1) is does not support our use case and could harm patients; or (2) is contrary to our [key design principles](https://vci.org/about#key-principles). For example, `Patient.identifier` is not allowed in resources conforming to [VaccineCredentialPatient] as this may include a MRN or SSN, which would introduce a significant privacy risk for patients.

### Identity assurance

The [VaccineCredentialPatient] and [Covid19LaboratoryBundle]/[InfectiousDiseaseLaboratoryBundle] profiles include a mechanism for indicating level of identity assurance of the patient. This uses the [IdentityAssuranceLevelValueSet] in this format:

```json
"meta": {
  "security": [{"code": "IAL1"}]
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