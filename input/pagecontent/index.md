<div class="alert alert-info" role="alert" markdown="1">
**DRAFT Implementation Guide** This implementation guide is under active development on [GitHub](https://github.com/dvci/vaccine-credential-ig/issues), and may change without notice. Please comment on or [create](https://github.com/dvci/vaccine-credential-ig/issues/new) an issue on GitHub if you have questions, comments, or suggestions. Contributions are welcome!
</div>

### Scope

This [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG):

1. Describes the clinical information necessary to create a [SMART Health Card] identifying vaccination and laboratory testing status for infectious diseases such as [COVID-19](https://www.cdc.gov/coronavirus/2019-ncov/index.html). In particular, it describes the content of the credential subject of a verifiable credential in which the credential types include "https://smarthealth.cards#health-card", "https://smarthealth.cards#immunization" and/or "https://smarthealth.cards#laboratory", and optionally "https://smarthealth.cards#covid19".
2. Describes a minimal set of patient information (name and contact information) that is also included in the [SMART Health Card].

The goal of this IG is to constrain resources for use specifically in [SMART Health Cards]. This applies to the contents of both digital and paper Health Cards, including Health Cards produced via a Health Card-specific FHIR endpoint like `[base]/Patient/:id/$HealthWallet.issueVc`. This IG is not applicable to general purpose FHIR endpoints like `[base]/Patient/:id/Immunization`; these are governed by other IGs like [US Core](https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html).

### Actors

The primary actors are:

1. **Issuers** who produce the FHIR resources described in this IG. These may be the entities responsible for giving vaccinations or reporting laboratory results, including health systems, pharmacies, clinical labs, and doctors offices.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG.

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent COVID-19 vaccination status and laboratory testing for verification purposes in a SMART Health Card.

Due to the size constraints of the SMART Health Card payload, a "data minimization" profile is provided to supplement each of the "allowable data" profiles. Please see the [Data minimization](#data-minimization) section for details.

#### Use case 1: vaccination credentials

To represent patient and clinical data related to a vaccination, the [VaccineCredentialBundle] SHALL be used to wrap resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data                       | Profile: Data Minimization                      | Purpose                                       | Required in bundle?     |
| --------------------------------------------- | ----------------------------------------------- | --------------------------------------------- | ----------------------- |
| [VaccineCredentialPatient]                    | [VaccineCredentialPatientDM]                    | Identify the patient                          | Exactly 1 required      |
| [VaccineCredentialImmunization]               | [VaccineCredentialImmunizationDM]               | Describe a vaccination                        | 1 or more required      |
| [VaccineCredentialVaccineReactionObservation] | [VaccineCredentialVaccineReactionObservationDM] | Describe an adverse reaction to a vaccination | Optional (experimental) |

Examples using these profiles:

> **Scenario 1:** A patient receives two doses of the Moderna COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021.
>
> Example resources:
>
> - [Scenario1Bundle]
> - [Scenario1Patient]
> - [Scenario1Immunization1]
> - [Scenario1Immunization2]
> - [Scenario1Location]

> **Scenario 2:** A patient receives two doses of the Pfizer-BioNTech COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021.
>
> Example resources:
>
> - [Scenario2Bundle]
> - [Scenario2Patient]
> - [Scenario2Immunization1]
> - [Scenario2Immunization2]
> - [Scenario2Location]

#### Use case 2: laboratory test result credentials

To represent patient and laboratory test result information, the [VaccineCredentialLaboratoryBundle] SHALL be used to wrap  resources conforming to these profiles:

{:.table-striped.table}
| Profile: Allowable Data              | Profile: Data Minimization             | Purpose                          | Required in bundle? |
| ------------------------------------ | -------------------------------------- | -------------------------------- | ------------------- |
| [VaccineCredentialPatient]           | [VaccineCredentialPatientDM]           | Identify the patient             | Required            |
| [Covid19LaboratoryResultObservation] | [Covid19LaboratoryResultObservationDM] | Identify the lab test and result | Required            |

An example using these profiles:

> **Scenario 3:** A patient is tested for SARS-CoV-2 (COVID19) antigen via rapid immunoassay on February 17, 2021 with result detectable.
>
> Example resources:
>
> - [Scenario3Bundle]
> - [Scenario1Patient]
> - [Scenario3Lab]

A laboratory results profile specific to COVID-19 is provided to limit the `code` to a [value set describing COVID-19-specific tests][Covid19LaboratoryTestValueSet]. Additional disease-specific profiles may be added in the future. To represent a disease without a specific set of profiles, implementers SHALL use [InfectiousDiseaseLaboratoryResultObservation] and [InfectiousDiseaseLaboratoryResultObservationDM], which can be used with [VaccineCredentialLaboratoryBundle].

### Implementation notes

- Implementers should see the [Conformance](conformance.html) page for further details, including details on `MustSupport` interpretation. Note that `MustSupport` **does not** mean an element is required in all cases.
- If an Issuer wishes to include both vaccination and laboratory test results in the same Bundle resource, this resource SHALL validate against both [VaccineCredentialBundle] and [VaccineCredentialLaboratoryBundle].

#### Data minimization

The payload size of [SMART Health Cards is limited](https://smarthealth.cards/#health-cards-are-small), which limits the amount of data that SHOULD be included in FHIR resources that appear in SMART Health Card payloads.

To assist Issuers in producing FHIR resources that have the minimal necessary data, this IG includes "data minimization" (DM) profiles in addition to "allowable data" (AD) profiles. The AD profiles identify required and `MustSupport` elements (see the [Conformance](conformance.html) page for further details). The DM profiles add additional constraints on top of their AD counterparts using `0..0` cardinality. Resources produced by issuers SHALL conform to the AD profiles, and SHOULD conform to the DM profiles UNLESS the Issuer intentionally includes additional information in the resource believed to be useful to Validators.

To validate a specific resource against a DM profile, the [FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) can be used, where [package.tgz is downloaded from the IG](package.tgz):

    java -jar path/to/validator_cli.jar -version 4.0.1 -ig hl7.fhir.us.core -ig package.tgz path/to/resource.json -profile http://hl7.org/fhir/us/smarthealthcards-vaccination/StructureDefinition/covid19-laboratory-result-observation-dm

Additionally:

- Implementers SHOULD NOT populate `Resource.id`, `Resource.meta`, or `Resource.text` elements.
- Implementers SHOULD populate `Bundle.entry.fullUrl` elements with short resource-scheme URIs (e.g., {"fullUrl": "resource:0}).
- Implementers SHOULD populate `Reference.reference` elements with short resource-scheme URIs (e.g., {"patient": {"reference": "Patient/r:0"}}) which SHALL resolve within the bundle.
- Implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when using any value from a value set with a `required` binding, or using specified values from a value set with an `extensible` binding.
- Likewise, implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when specifying codes that are fixed in profiles.
- Use `YYYY-MM-DD` precision for all `dateTime` fields. Greater precision will result in a warning when validating a resource.

#### Compatibility with IIS

Resources representing a vaccination and associated data should be able to be directly populated with data from [IIS](https://www.cdc.gov/vaccines/programs/iis/index.html) implementations using the [HL7 v2.5.1 Implementation Guide for Immunization Messaging, Release 1.5](https://repository.immregistries.org/resource/hl7-version-2-5-1-implementation-guide-for-immunization-messaging-release-1-5-1/).

### Supplemental data dictionary

There is an [Excel data dictionary](data-dictionary/data_dictionary.xlsx) available here. This presents the IG's content in a format that may be more accessible than the default FHIR artifact pages. The Data Dictionary is a Excel spreadsheet that lists data elements and some details about them. If there is a discrepancy between the Data Dictionary and the FHIR artifacts, the FHIR artifacts are taken as the source of truth.

----

MITRE: Approved for Public Release. Distribution Unlimited. Case Number 21-0225

{% include markdown-link-references.md %}

<style>
/* Moves the TOC down below the info box */
div.markdown-toc {
    margin-top: 15rem;
}
</style>
