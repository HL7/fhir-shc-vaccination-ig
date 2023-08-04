### Scope

This [FHIR Implementation Guide](https://www.hl7.org/fhir/implementationguide.html) (IG) **describes the FHIR contents of a [SMART Health Card] (SHC) for infectious disease vaccination records and laboratory testing status.** This includes a minimal set of patient information (name and contact information) that needed for this use case.

The [Data Model section of the SMART Health Cards specification](https://spec.smarthealth.cards/#data-model) provides the canonical description of the scope of this IG with respect to SHCs. Note that the content of this IG may be suitable for use in other health cards besides SHCs with similar scope and constraints.

Note that this IG is not directly related to the [SMART App Launch Framework](http://www.hl7.org/fhir/smart-app-launch/). The name comes from [SMART Health IT](https://smarthealthit.org/), who also developed the [SMART Health Card] framework that this IG supports. ("SMART" is an [acronym](https://smarthealthit.org/an-app-platform-for-healthcare/about/) for Substitutable Medical Apps, Reusable Technology.) SMART App Launch and SMART Health Cards are designed to work well together (the former being one of multiple methods for issuing the latter), but they don't have a hard dependency with each other.

This IG does not describe API operations for issuing health cards. Note that [the SHC specification does describe a FHIR API operation for issuing SHCs](https://spec.smarthealth.cards/#via-fhir-health-cards-issue-operation) (`[base]/Patient/:id/$health-cards-issue`).

This IG is not applicable to general-purpose FHIR endpoints like `[base]/Patient/:id/Immunization`, nor is it meant to describe the canonical representation of clinical data in electronic health record systems; these are governed by other IGs like [US Core](https://www.hl7.org/fhir/us/core/StructureDefinition-us-core-immunization.html).

### Actors

The primary actors are:

1. **Issuers** who produce the FHIR resources described in this IG. These may be the entities responsible for giving vaccinations or reporting laboratory results, including health systems, pharmacies, clinical labs, and doctors offices.
1. **Holders** who receive a [SMART Health Card] from an Issuer (which contains the FHIR resources described in this IG), and may display it to a Verifier.
1. **Verifiers** who read and analyze the FHIR resources described in this IG.

Issuers and Verifiers are considered "implementers" of this IG. Additionally, "wallet applications" used by Holders to store digital versions of their SHC are also considered implementers.

#### Privacy by design

Special attention is payed in this IG to protecting the privacy of Holders.

The design of the SMART Health Card specification results in the following characteristics of issued SMART Health Cards:

1. The contents cannot be changed (without re-issuing the entire SMART Health Card).
2. The entirety of the data within the SMART Health Card is transmitted from the Holder to the Verifier whenever a SMART Health Card is presented.

**Therefore, information that is not strictly necessary for a legitimate Verifier use case SHALL NOT be included in SMART Health Cards.**

For more information, please see [the data minimization and privacy section on the Profiles page](profiles.html#data-minimization-and-privacy).

This diagram shows the typical SHC workflow among these actors:

<!-- If the image below is not wrapped in a div tag, the publisher tries to wrap text around the image, which is not desired. -->
<div style="text-align: center;">{%include workflow.svg%}</div>

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent vaccination status and infectious disease-related laboratory testing in a SMART Health Card for outbreak/pandemic response. This IG may also be used to support use cases involving routine vaccination or infectious disease-related laboratory testing. To meet these use cases, we provide profiles of a [FHIR Bundle](https://www.hl7.org/fhir/bundle.html) that describes the contents of [the `fhirBundle` element in a SMART Health Card](https://spec.smarthealth.cards/#data-model). We also provide profiles of the resources contained within this Bundle.

The SMART Health Cards Framework constrains the size of the FHIR payload embedded within a SMART Health Card to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This IG is designed to support creating resources that fit within these size constraints. (While it is possible to generate a [denser QR code](https://www.qrcode.com/en/about/version.html), the [SMART Health Cards Framework](https://spec.smarthealth.cards/#every-health-card-can-be-embedded-in-a-qr-code) developers found that denser QR codes could be difficult to scan.) SMART Health Card payloads are compressed, with the amount of compression varying based on the content of the payload (in general, the more repeated content in the bundle, the higher the compression ratio). This means that it's not possible to calculate the precise number of _uncompressed_ bytes available for the embedded FHIR Bundle.

To support implementers' efforts to minimize payload size, this IG provides two different sets of profiles:

1. **Primary Profiles** focused on data minimization (DM). These profiles use cardinality constraints to prohibit elements beyond the minimal set needed to meet our use cases.
2. **Fallback Profiles**, with relaxed constraints that include all allowable data (AD).

More information can be found on the [Profiles page](profiles.html#data-minimization-and-privacy).

In practice, we have found that bundles of resources conforming to the Primary Profiles in this IG do fit within the payload constraints.

{% include privacy.md %}

#### Use case 1: immunization records

**Scenario 1:** A patient receives two doses of the Moderna COVID-19 vaccine, and a third dose of the 2022 bivalent booster. The first dose was administered on January 1, 2021, the second dose on January 29, 2021, and the booster on September 5, 2022. Here is [an example of a FHIR Bundle representing this scenario](Bundle-example-bundle-immunization-covid.json.html), which contains the following resources:

1. An instance of a Patient resource conforming to [SHCPatientUnitedStatesDM](StructureDefinition-shc-patient-us-dm.html)[^patientprofile]
1. An instance of an Immunization resource conforming to [SHCVaccinationDM] to represent the first dose
1. An instance of an Immunization resource conforming to [SHCVaccinationDM] to represent the second dose
1. An instance of an Immunization resource conforming to [SHCVaccinationDM] to represent the booster (third dose)

**Scenario 2:** A patient receives two doses of the Jynneos (modified vaccinia Ankara vaccine) vaccine for mpox/smallpox. The first dose was administered on August 1, 2022, and the second dose on August 29, 2022. Here is [an example of a FHIR Bundle representing this scenario](Bundle-example-bundle-immunization-mpox.json.html), which contains the following resources:

1. An instance of a Patient resource conforming to [SHCPatientUnitedStatesDM](StructureDefinition-shc-patient-us-dm.html)[^patientprofile]
1. An instance of an Immunization resource conforming to [SHCVaccinationDM] to represent the first dose
1. An instance of an Immunization resource conforming to [SHCVaccinationDM] to represent the second dose

The example Bundle resources for both scenarios above conform to [SHCVaccinationBundleDM].

#### Use case 2: laboratory test results

**Scenario 3:** A patient is tested for SARS-CoV-2 (COVID19) antigen via rapid immunoassay on February 17, 2021 with result detectable. Here is [an example of a FHIR Bundle representing this scenario](Bundle-example-bundle-lab-test-results-covid.html), which contains the following resources:

1. An instance of a Patient resource conforming to [SHCPatientUnitedStatesDM](StructureDefinition-shc-patient-us-dm.html)[^patientprofile]
1. An instance of an Observation resource conforming to [SHCCovid19LaboratoryResultObservationDM] to represent lab test results

The example Bundle resources for this scenario conforms to [SHCInfectiousDiseaseLaboratoryBundleDM].

[^patientprofile]: Note that this profile is based on [SHCPatientGeneralDM], so this example conforms to both.

### Profiles

For the list of profiles defined in this IG please see [the Profiles page](profiles.html).

### Approach to constraints

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

   For example, constraining the [SHCVaccinationDM] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the original Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

   For example, some parties may only consider United States Food and Drug Administration (FDA)-approved or Emergency Use Authorization (EUA) vaccines to be acceptable, while others may accept vaccines approved in other countries.

   Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

1. Cardinality constraints are applied to specific data elements in [Allowable Data profiles](profiles.html#data-minimization-and-privacy) when their inclusion (1) does not support our use case and could harm patients; or (2) is contrary to our [key design principles](https://vci.org/about#key-principles). For example, `Patient.identifier` is not allowed in resources conforming to [SHCPatientUnitedStatesAD] as this may include a Medical Record Number (MRN) or Social Security Number (SSN) in the United States, which would introduce a significant privacy risk for patients.

### Approach to terminology bindings

Value set bindings for [`MustSupport` elements](profiles.html#mustsupport-interpretation) are `required`, meaning that resources MUST use a code specified in the bound value set. This is to ensure implementers know which code systems can be expected to appear in a given element.

In general, the value sets used in these `required` bindings are as broad as possible. For example, all codes from the [CVX code system](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) are allowed for identifying vaccines (as opposed to defining a value set with just COVID-related CVX codes, for example).

In cases where disease-specific value sets exist, this IG may provide profiles with bindings to these restricted value sets (e.g., [SHCCovid19LaboratoryResultObservationDM]) to help implementers identify the preferred subset of codes for that disease. However, in these cases, this IG will also provide generic equivalents to these profiles with broad value sets (e.g., [SHCInfectiousDiseaseLaboratoryResultObservationDM]). Implementers MAY fall back to the generic version of such profiles if the code they need is not part of the disease-specific value sets.

Note that when a value set is specified as "Include all codes defined in ...", the definition does **not** constrain the value set content to a specific version of the code system. As the code system content is updated in new code system versions, the updated content will be available in the value set expansion (and via $validate-code). Also note that value set expansions in the published version of this IG may be out of date; please check with the canonical source of the code system for the most up-to-date set of codes that belong to a value set.

### Identity assurance

The [SHCVaccinationDM] and [SHCCovid19LaboratoryResultObservationDM]/[SHCCovid19LaboratoryResultObservationDM] profiles include a mechanism for indicating level of identity assurance of the patient. This uses the [IdentityAssuranceLevel] value set in this format:

```json
"meta": {
  "security": [{"system": "https://smarthealth.cards/ial", "code": "IAL1.2"}]
}
```

Issuers SHALL populate these elements if identity assurance information is available.

### Author contact information

This FHIR Implementation Guide was initially developed by [VCI](https://vci.org), and is currently [an HL7 project](https://confluence.hl7.org/display/PHWG/SMART+Health+Cards+-+Vaccination+and+Testing+IG+Project+Page) sponsored by the [Public Health Work Group](https://confluence.hl7.org/display/PHWG/Public+Health+Work+Group).

If you have questions or comments about this IG, please reach out to us via one of these channels:

1. The [smart/health-cards](https://chat.fhir.org/#narrow/stream/284830-smart.2Fhealth-cards) stream on [chat.fhir.org](https://chat.fhir.org/#narrow/stream/284830-smart.2Fhealth-cards) (requires free account)
2. The [`vaccination` HL7 listserv](http://lists.hl7.org/read/?forum=vaccination) ([sign up here](https://www.hl7.org/Special/committees/pher/listserv.cfm))
3. Email <vci-ig@mitre.org>

#### Credits

- Reece Adamson (The MITRE Corporation[^PRS])
- Cary Anderson (Apple Inc.)
- Shaumik Ashraf (The MITRE Corporation[^PRS])
- Ricky Bloomfield (Apple Inc.)
- Paul Denning (The MITRE Corporation[^PRS])
- Neelima Karipineni (The MITRE Corporation[^PRS])
- Josh Mandel (SMART Health IT and Microsoft)
- Max Masnick (The MITRE Corporation[^PRS])
- Pascal Pfiffner (Apple Inc.)
- JP Pollak (The Commons Project and Cornell)
- Isaac Vetter (Epic)

To be included in the credits, please open a pull request on [GitHub](https://github.com/HL7/fhir-shc-vaccination-ig) adding yourself to [this file](https://github.com/HL7/fhir-shc-vaccination-ig/blob/master/input/pagecontent/index.md). Anyone on the [GitHub contributors list](https://github.com/HL7/fhir-shc-vaccination-ig/graphs/contributors) or who has otherwise contributed to this IG may be included.

[^PRS]: MITRE: Approved for Public Release. Distribution Unlimited. Case Number 21-0225.

<br><br>


---

<br><br>

{% include ip-statements.xhtml %}

{% include markdown-link-references.md %}

---