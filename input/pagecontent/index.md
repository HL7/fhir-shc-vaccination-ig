### Scope

This [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG):

1. Describes the clinical information necessary to create a [SMART Health Card] (SHC) identifying vaccination and laboratory testing status for infectious diseases such as [COVID-19](https://www.cdc.gov/coronavirus/2019-ncov/index.html). In particular, it describes the content of the subject of a [SMART Health Card] in which the card [types](https://spec.smarthealth.cards/vocabulary/) include `https://smarthealth.cards#health-card`, `https://smarthealth.cards#immunization` and/or `https://smarthealth.cards#laboratory`, and optionally `https://smarthealth.cards#covid19`.
2. Describes a minimal set of patient information (name and contact information) that is also included in the [SMART Health Card].

**The goal of this IG is to define the conformance criteria of FHIR resources for use specifically in [SMART Health Cards].** This applies to the contents of both digital and paper Health Cards, including Health Cards produced via a [SMART Health Card-specific FHIR endpoint](https://spec.smarthealth.cards/#via-fhir-health-cards-issue-operation) like `[base]/Patient/:id/$health-cards-issue`. This IG is not applicable to general-purpose FHIR endpoints like `[base]/Patient/:id/Immunization`, nor is it meant to describe the canonical representation of clinical data in electronic health record systems; these are governed by other IGs like [US Core](https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html).

Note that this IG is not directly related to the [SMART App Launch Framework](http://www.hl7.org/fhir/smart-app-launch/). The term SMART was [originally coined](https://smarthealthit.org/an-app-platform-for-healthcare/about/) as an acronym for �Substitutable Medical Apps, Reusable Technology�,.  The name comes from [SMART Health IT](https://smarthealthit.org/), who also developed the [SMART Health Card] framework that this IG supports. SMART App Launch and SMART Health Cards are designed to work well together (the former being one of multiple methods for issuing the latter), but they don't have a hard dependency with each other.

### Actors

The primary actors are:

1. **Issuers** who produce the FHIR resources described in this IG. These may be the entities responsible for giving vaccinations or reporting laboratory results, including health systems, pharmacies, clinical labs, and doctors offices.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG.

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent COVID-19 vaccination status and laboratory testing for verification purposes in a SMART Health Card. We support other infectious diseases as a secondary use case. To meet these use cases, we provide profiles of a [FHIR Bundle](https://www.hl7.org/fhir/bundle.html) that describes the contents of [the `fhirBundle` element in a SMART Health Card](https://spec.smarthealth.cards/#data-model). We also provide profiles of the resources contained within this Bundle.

This IG defines two types of profiles:
1. Allowable Data (AD)
1. Data Minimization (DM)

The DM profiles are "Primary" profiles which constrain the content to fit within the limits of a Quick Response (QR) code.
The AD profiles are "Fallback" profiles which have fewer constraints than DM profiles, but if extra content is included it may result in multiple QR codes.

The SMART Health Cards Framework constrains the size of the FHIR payload embedded within a SMART Health Card to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This IG is designed to support creating resources that fit within these size constraints. (While it is possible to generate a [denser QR code](https://www.qrcode.com/en/about/version.html), the [SMART Health Cards Framework] developers found that denser QR codes could be difficult to scan.) SMART Health Card payloads are compressed, so the precise number of available uncompressed bytes for the embedded FHIR Bundle is not knowable (the compression ratio depends on the specific content being compressed). In practice, we have found that bundles of resources conforming to the [data minimization profiles](profiles.html#data-minimization) in this IG do fit within the payload constraints.

Due to these size constraints and to preserve patient privacy, information that is not necessary for Verifiers SHALL NOT be included in SMART Health Cards. With respect to patient privacy, note that when a SMART Health Card is issued, it is [cryptographically signed](https://spec.smarthealth.cards/#signing-health-cards) by the Issuer. This means that the contents, including the FHIR Bundle, cannot be changed without invalidating the signature. It is therefore critical for Issuers to exclude any information that could represent a privacy risk to a patient when presenting their SMART Health Card to a Verifier.

#### Use case 1: immunization records

**Scenario 1:** A patient receives two doses of the Moderna COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. Here is [an example of a FHIR Bundle representing this scenario](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario1Bundle.json), which contains the following resources:

* {% assign example = site.data.examples["StructureDefinition-shc-patient-us.html"][0] %}[Patient resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCPatientUnitedStatesDM]
* {% assign example = site.data.examples["StructureDefinition-shc-vaccination.html"][0] %}[Immunization resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCVaccinationDM]
* {% assign example = site.data.examples["StructureDefinition-shc-vaccination.html"][1] %}[Immunization resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCVaccinationDM]

**Scenario 2:** A patient receives two doses of the Pfizer-BioNTech COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021. Here is [an example of a FHIR Bundle representing this scenario](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario2Bundle.json), which contains the following resources:

* {% assign example = site.data.examples["StructureDefinition-shc-patient-us.html"][1] %}[Patient resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCPatientUnitedStatesDM]
* {% assign example = site.data.examples["StructureDefinition-shc-vaccination.html"][2] %}[Immunization resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCVaccinationDM]
* {% assign example = site.data.examples["StructureDefinition-shc-vaccination.html"][3] %}[Immunization resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCVaccinationDM]

The example Bundle resources for both scenarios above conform to [SHCVaccinationBundleDM].

#### Use case 2: laboratory test results

**Scenario 3:** A patient is tested for SARS-CoV-2 (COVID19) antigen via rapid immunoassay on February 17, 2021 with result detectable. Here is [an example of a FHIR Bundle representing this scenario](https://github.com/dvci/vaccine-credential-ig/blob/{{ site.data['git-branch'] }}/examples/Scenario3Bundle.json), which contains the following resources:

* {% assign example = site.data.examples["StructureDefinition-shc-patient-us.html"][2] %}[Patient resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCPatientUnitedStatesDM]
* {% assign example = site.data.examples["StructureDefinition-shc-covid19-laboratory-result-observation.html"][0] %}[Observation resource: {{example.title}}]({{ example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch']}}) conforming to [SHCCovid19LaboratoryResultObservationDM]

### Profiles

For the list of profiles defined in this IG please see [the Profiles page](profiles.html).

Note that a profile is derived from either the base FHIR resource or another profile of the FHIR resource. In this IG, an AD profile may be derived from the base FHIR resource, and the corresponding DM profile would be derived from the AD profile.  The DM profile can be considered a child of the AD profile. A child profile cannot remove or relax a constraint defined in the parent profile. However, it is often the case that a child profile will impose stricter constraints than the parent profile.

### Approach to constraints

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

    For example, constraining the [SHCVaccinationDM] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

    For example, some parties may only consider United States Food and Drug Administration (FDA)-approved or Emergency Use Authorization (EUA) vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

1. Cardinality constraints are applied to specific data elements in [Allowable Data profiles](profiles.html#data-minimization) when their inclusion (1) does not support our use case and could harm patients; or (2) is contrary to our [key design principles](https://vci.org/about#key-principles). For example, `Patient.identifier` is not allowed in resources conforming to [SHCPatientUnitedStatesAD] as this may include a Medical Record Number (MRN) or Social Security Number (SSN) in the United States, which would introduce a significant privacy risk for patients.

### Approach to terminology bindings

Value set bindings for [`MustSupport` elements](profiles.html#mustsupport-interpretation) are `required`, meaning that resources MUST use a code specified in the bound value set. This is to ensure implementers know which code systems can be expected to appear in a given element.

In general, the value sets used in these `required` bindings are as broad as possible. For example, in the [VaccineCVX] value set, all codes from the [CVX code system](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) are included (as opposed to defining a value set with just COVID-related CVX codes, for example).

In cases where disease-specific value sets exist, this IG may provide profiles with bindings to these restricted value sets (e.g., [SHCCovid19LaboratoryResultObservationDM]) to help implementers identify the preferred subset of codes for that disease. However, in these cases, this IG will also provide generic equivalents to these profiles with broad value sets (e.g., [SHCInfectiousDiseaseLaboratoryResultObservationDM]). Implementers MAY fall back to the generic version of such profiles if the code they need is not part of the disease-specific value sets.

### Identity assurance

The [SHCVaccinationDM] and [SHCCovid19LaboratoryResultObservationDM]/[SHCCovid19LaboratoryResultObservationDM] profiles include a mechanism for indicating level of identity assurance of the patient. This uses the [IdentityAssuranceLevel] value set in this format:

```json
"meta": {
  "security": [{"system": "https://smarthealth.cards/ial", "code": "IAL1.2"}]
}
```

Issuers SHALL populate these elements if identity assurance information is available.

### Compatibility with IIS

Resources representing a vaccination and associated data should be able to be directly populated with data from [IIS](https://www.cdc.gov/vaccines/programs/iis/index.html) implementations using the [HL7 v2.5.1 Implementation Guide for Immunization Messaging, Release 1.5](https://repository.immregistries.org/resource/hl7-version-2-5-1-implementation-guide-for-immunization-messaging-release-1-5-1/).

### Author contact information

This FHIR Implementation Guide was initially developed by [VCI](https://vci.org), and is currently [an HL7 project](https://confluence.hl7.org/display/PHWG/SMART+Health+Cards+-+Vaccination+and+Testing+IG+Project+Page) sponsored by the [Public Health Work Group](https://confluence.hl7.org/display/PHWG/Public+Health+Work+Group).

Please direct questions or comments about this IG to the channels listed [here](contact.html).

----

MITRE: Approved for Public Release. Distribution Unlimited. Case Number 21-0225

{% include markdown-link-references.md %}