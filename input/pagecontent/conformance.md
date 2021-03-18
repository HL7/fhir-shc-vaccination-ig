### Approach to constraints in profiles

The IG is currently focused on coordinating implementers' representations of relevant clinical data, rather than evaluating risk or applying decision rules based on these clinical data. For example, this IG does not include information about which vaccine products are considered effective, or which dosing protocols are appropriate for a given product. The rationale for focusing on "conveying a clinical history" rather than "evaluating risk or making decisions" is:

1. Risk evaluation algorithms are likely to evolve faster than IG constraints can be updated.

    For example, constraining the [VaccineCredentialImmunization] profile to require specific `vaccineCode` values (e.g., only `CVX#207` and `CVX#208` for the current Moderna and Pfizer-BioNTech vaccines) could pose a problem if a new vaccine receives emergency authorization: recipients of the new vaccination would have non-conforming Immunization resources due to the constraints on `vaccineCode` until the IG could be updated and published.

1. Risk evaluation algorithms may be actor- or context-dependent.

    For example, some parties may only consider FDA-approved or EUA vaccines to be acceptable, while others may accept vaccines approved in other countries.

    Embedding stringent validation criteria in our FHIR profiles may make it impossible for implementers with less stringent criteria to use this IG.

1. More constrained profiles for risk evaluation can be created based on the profiles in this IG, but it's not possible to remove constraints in a child profile.

### Conformance verbs

This specification uses the conformance verbs SHALL, SHOULD, and MAY as defined in [RFC 2119].

### MustSupport interpretation

- Issuers SHALL populate any elements marked as `MustSupport` **if and only if the necessary data are available in their system**.
- Issuers SHOULD NOT populate any elements that are not marked as `MustSupport` unless they believe the element contains valuable information for Verifiers. This is due to the payload size constraints of SMART Health Cards; see the [Data minimization](index.html#data-minimization) section below for more details on how to reduce payload size when implementing.
- Verifiers SHALL be able to "meaningfully process" elements marked BOTH as `MustSupport` and `Is-Modifier`; these elements [by definition](https://www.hl7.org/fhir/conformance-rules.html#isModifier) **cannot be safely ignored** as they may change the meaning of the resource. For other elements flagged with `MustSupport`, Verifiers MAY process at their own discretion.

Note that `MustSupport` does **not** indicate an element is **required** to be present in resource instances. Required elements are those with a minimum cardinality of 1 or greater. Instead, `MustSupport` is used to indicate elements that SHALL be populated **if and only if the necessary data are available in the Issuer's system.**

### Missing data

- If an Issuer does not have data for a `MustSupport` data element, the data element SHALL be omitted from the resource.
- If an Issuer does not have data for a required data element (minimum cardinality > 0), the Issuer SHALL NOT produce the resource.

{% include markdown-link-references.md %}
