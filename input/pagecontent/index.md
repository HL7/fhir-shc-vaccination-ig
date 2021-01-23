This is a **rough draft** of a FHIR Implementation Guide for representing the clinical information needed for a digital vaccination record, or other vaccination/immunity-related health record contained within a [Health Card](https://healthwallet.cards/).

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent COVID-19 vaccination status for verification purposes. We also want to support other observations that could be used to indicate immunity in the future, such as an antibody test or previous COVID-19 infection confirmed with PCR.

Secondarily, we want to support representation of vaccination, immunity, or lack of infection (such as Tuberculin Skin Testing results) for other infectious diseases. We therefore avoid constraints that limit use in other diseases unless such constraints are necessary to support COVID-19 use cases.

### Approach to constraints

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than validating these representations for a specific use case (e.g., requiring a specific set of vaccines). Using a FHIR IG for validation will require highly constrained profiles, which pose the following problems:

1. It may not be possible to update IG constraints quickly enough to respond to real-world changes.

    For example, constraining the [VaccineCredentialImmunization] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Actors may have different validation criteria.

    For example, some parties may only consider FDA-approved or EUA vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

#### Conformance verbs

This specification uses the conformance verbs MUST, SHOULD, and MAY as defined in [RFC 2119].

#### MustSupport interpretation

The [MustSupport](https://www.hl7.org/fhir/conformance-rules.html#mustSupport) flag indicates that implementation shall provide "meaningful support" for the element, as defined by its implementation guide. This IG follows the MustSupport [definitions in US Core](http://hl7.org/fhir/us/core/general-guidance.html#must-support).

Note that MustSupport does **not** indicate a field is required. This is instead governed by the cardinality of the field.

### Profiles

- **[VaccineCredentialPatient]**: Currently the same as USCorePatientProfile. This can be removed if we decide we can use USCorePatientProfile as-is.

- **[VaccineCredentialImmunization]**: Represents an immunization, includes vaccine information such as the CVX code identifying the vaccine, who administered the vaccine, etc.

- **[VaccineCredentialAntibodyResultValueSet]**: Represents the results of an antibody test. Included because a positive antibody test could be interpreted as showing immunity to the disease.

- **[VaccineCredentialVaccineReactionObservation]**: Represents an adverse reaction to a vaccination. Included because an adverse reaction may be interpreted by some actors as justification for not receiving the full series of a vaccination.

Additionally, the following profiles from other IGs are used to represent key resources needed to implement this IG:

- **[USCoreLocation]** represents the location (entity, not body site) where the patient received their vaccination.

#### Bundle

The **[VaccineCredentialBundle]** collects resources conforming to the profiles listed above. Resources conforming to profiles outside this IG MAY also be included in Bundles conforming to [VaccineCredentialBundle].

Each Bundle resource MUST include resources related to one patient and one target disease. The target disease is identified as follows:

- By `protocolApplied.targetDisease` in [VaccineCredentialImmunization]
- By `extension[targetDisease]` in [VaccineCredentialImmuneStatus]
- By the reference to an Immunization resource in [VaccineCredentialVaccineReactionObservation]

TODO: Add guidance on when specific resources should be included in the bundle.

### Examples

1. Scenario 1: A patient receives two doses of the Moderna COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021.

    Example resources:

    - [Scenario1Bundle]
    - [Scenario1Patient]
    - [Scenario1Immunization1]
    - [Scenario1Immunization2]
    - [Scenario1Location]

1. Miscellaneous examples:

    1. [ExampleImmunizationNoCVX]\: Immunization resource showing how to record a vaccine without a published CVX code.

{% include markdown-link-references.md %}