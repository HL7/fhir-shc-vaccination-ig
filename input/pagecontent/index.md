This is a **rough draft** of a FHIR Implementation Guide for representing the clinical information needed for a digital vaccination record, or other vaccination/immunity-related health record contained within a [SMART Health Card](https://healthwallet.cards/).

### Use cases

Our primary focus is on the use case of representing the minimal set of clinical data necessary to represent COVID-19 vaccination status for verification purposes.

Secondarily, we want to define patterns that support future use cases including:

* clinical data indicating current or previous COVID-19 infection status (e.g., laboratory testing results evaluating presence of RNA, antigens, or antibodies)
* clinical data pertaining to other infectious diseases

We therefore avoid constraints that limit use in other diseases unless such constraints are necessary to support COVID-19 use cases.

### Approach to constraints

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

    For example, constraining the [VaccineCredentialImmunization] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

    For example, some parties may only consider FDA-approved or EUA vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

#### Conformance verbs

This specification uses the conformance verbs SHALL, SHOULD, and MAY as defined in [RFC 2119].

#### MustSupport interpretation

The [MustSupport](https://www.hl7.org/fhir/conformance-rules.html#mustSupport) flag indicates that implementation shall provide "meaningful support" for the element, as defined by its implementation guide. This IG follows the MustSupport [definitions in US Core](http://hl7.org/fhir/us/core/general-guidance.html#must-support).

Note that MustSupport does **not** indicate an element is required to be present in resource instances. Required elements are those with a minimim cardinality of 1 or greater.

### Profiles

- **[VaccineCredentialPatient]**: Currently the same as USCorePatientProfile. This can be removed if we decide we can use USCorePatientProfile as-is.

- **[VaccineCredentialImmunization]**: Represents an immunization, includes vaccine information such as the CVX code identifying the vaccine, who administered the vaccine, etc.

- **[VaccineCredentialAntibodyResultValueSet] [experimental]**: Represents the results of an antibody test. Included because a positive antibody test could be interpreted as showing immunity to the disease. This profile is considered "experimental" as it does not pertain to the core scope of the IG.

- **[VaccineCredentialVaccineReactionObservation] [experimental]**: Represents an adverse reaction to a vaccination. Included because an adverse reaction may be interpreted by some actors as justification for not receiving the full series of a vaccination. This profile is considered "experimental" as it does not pertain to the core scope of the IG.

Additionally, the following profiles from other IGs are used to represent key resources needed to implement this IG:

- **[USCoreLocation]** represents the location (geographic, not body site) where the patient received their vaccination.

#### Bundle

The **[VaccineCredentialBundle]** collects resources conforming to the profiles listed above. Resources conforming to profiles outside this IG MAY also be included in Bundles conforming to [VaccineCredentialBundle].

Each Bundle resource SHALL include resources related to one patient and one target disease. The target disease is identified as follows:

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

1. Scenario 2: A patient receives two doses of the Pfizer-BioNTech COVID-19 vaccine. The first dose was administered on January 1, 2021, and the second dose on January 29, 2021.

    Example resources:

    - [Scenario2Bundle]
    - [Scenario2Patient]
    - [Scenario2Immunization1]
    - [Scenario2Immunization2]
    - [Scenario2Location]

1. Miscellaneous examples:

    1. [ExampleImmunizationNoCVX]\: Immunization resource showing how to record a vaccine without a published CVX code.

### Implementation notes

#### Data minimization

- Implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when using any value from a value set with a `required` binding, or using specified values from a value set with an `extensible` binding.
- Likewise, implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when specifying codes that are fixed in profiles.

{% include markdown-link-references.md %}
