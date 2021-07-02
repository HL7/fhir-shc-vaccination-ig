This Implementation Guide (IG) includes Data Minimization (DM), which include only the minimum set of elements necessary to create a valid resource, and fallback Allowable Data (AD) profiles. More detail about the difference between DM and AD profiles is available below.

### Profile groups

<table class="table">
<thead>
    <tr>
        <th>Profile Group</th>
        <th>Primary Profiles (DM)</th>
        <th>Fallback Profiles (AD)</th>
        <th>Scope</th>
    </tr>
</thead>
<tbody>
{% for resource in site.data.profiles %}
{% assign r = resource[1] %}
{% assign resourceName = resource[0] %}

    {% for profileSet in r.profileSets %}
    <tr>
        {% if forloop.first == true %}
            <td rowspan="{{ forloop.length }}">
                <strong>{{ r.name }}</strong><br>
                {{ r.description }}
                {% if r.instructions %}
                    {% capture url %}{{r.instructions}}{% endcapture %}
                    <br><br>
                    <span class="label label-success">Start here!</span>
                    <a href="{{ r.instructions }}">Implementation instructions</a>
                {% endif %}
            </td>
        {% endif %}
        {% capture url %}StructureDefinition-{{ profileSet.slug }}-dm.html{% endcapture %}
        <td><a href="{{ url }}">{{ profileSet.name }}</a></td>

        {% capture url %}StructureDefinition-{{ profileSet.slug }}-ad.html{% endcapture %}
        <td ><a href="{{ url }}">Fallback</a></td>

        <td>{{ profileSet.scope }}</td>
    </tr>
    {% endfor %}
{% endfor %}
</tbody>
</table>

<hr style="margin-top: 3em; margin-bottom: 3em;">

### How to use profiles for implementation

<span class="label">Note</span> This specification uses the conformance verbs SHALL, SHOULD, and MAY as defined in [RFC 2119].

In general, implementers (typically Issuers of SMART Health Cards) who are generating resources meant to conform with this IG SHOULD:

1. Start by [validating](#validation) against the DM profile for a given FHIR resource, and attempt to resolve any errors.
2. If an Issuer has a good faith belief that resolving a validation error against a DM profile would reduce utility for Holders or Verifiers, they MAY validate against the less constrained fallback AD profile instead.

    Issuers should be aware that adding in extraneous information to FHIR resources may not make it possible for the SMART Health Card to fit in a legible QR code. Issuers should refer to [SMART Health Cards Framework] for details.

All resources meant to conform with this IG SHOULD conform to the relevant DM profiles, and SHALL conform to the relevant fallback AD profiles.

In some cases, multiple pairs of DM/AD profiles of the same resource are provided (e.g., "Universal Patient" vs. "US-Only Patient"). Implementers SHALL use the _most specific_ set of profiles for their given use case. For example, a US-based implementer SHALL use the "US-Only Patient" profiles. Likewise, an implementer producing resources representing COVID-19 lab results SHALL use the COVID-19-specific lab results profiles.

The recommended workflow for reading profiles of a given resource in this IG is as follows:

1. Begin by reading the [IG's home page](index.html) and this page in their entirety.
1. Then look at the table above for the specific Profile Group you need. Start by reviewing the "Implementation instructions" page for that Profile Group, if provided (will appear with <span class="label label-success">Start here!</span> in the table above and on each related profile's page).
1. If multiple pairs of DM/AD profiles are available within this Profile Group, choose the one with the **narrowest** applicable scope.
1. Review the "Snapshot" tab on the Primary (DM) profile. The elements listed here SHOULD/SHALL be included based on  `MustSupport` (<span style="padding-left: 3px; padding-right: 3px; color: white; background-color: red;" >S</span> in the "Flags" column) and [cardinality](https://www.hl7.org/fhir/conformance-rules.html#cardinality) (in the "Card.") column. Elements not listed here SHOULD NOT or SHALL NOT be included. Details on interpreting cardinality and `MustSupport` for this IG are available [below](#mustsupport-interpretation).
    - For more information about the data type for a given element, click the data type link in the "Type" column. This will bring you to the relevant portion of the FHIR specification for that data type.
    - The "Description & Constraints" column has a short description of each element. Some elements may also have a "Binding" listed here, which indicates values SHALL come from the specified list. (This IG uses "Required" for all value set bindings, but other IGs may use [more flexible binding strengths](https://www.hl7.org/fhir/terminologies.html#strength).)
1. For each element that you include in your resource, review the detailed definition for the element in this IG. To find this, click the element's name in the "Snapshot" table of the relevant profile. The detailed definition may have more implementation and conformance information including applicable [invariants](https://www.hl7.org/fhir/conformance-rules.html#constraints).

### MustSupport interpretation

[Elements in FHIR can be labeled as `MustSupport`](https://www.hl7.org/fhir/conformance-rules.html#mustSupport), denoted in profiles by this symbol: <span style="padding-left: 3px; padding-right: 3px; color: white; background-color: red;" >S</span>.

**`MustSupport` does not mean an element is required.** Required elements are those with a minimum cardinality of 1 or greater.

Instead, `MustSupport` indicates implementers ["SHALL provide 'support' for the element in some meaningful way"](https://www.hl7.org/fhir/conformance-rules.html#mustSupport).

In this Implementation Guide, "support in some meaningful way" is defined as follows:

- **Issuers:**

    1. Issuers SHALL populate any elements marked as `MustSupport` **if and only if the necessary data are available in their system**. See [Missing data](#missing-data) below for details.

    1. Issuers SHOULD NOT populate any elements that are not marked as `MustSupport` unless they believe the element contains valuable information for Holders and/or Verifiers. This is due to the payload size constraints of SMART Health Cards; see the [Data minimization](#data-minimization) section below for more details on how to reduce payload size when implementing. To avoid contradicting cardinality, all required elements (minimum cardinality > 0) are therefore also labeled as `MustSupport`.

- **Verifiers:**

    1. Verifiers SHALL read and meaningfully process elements marked BOTH as `MustSupport` and `Is-Modifier`. Note that `Is-Modifier` elements [by definition](https://www.hl7.org/fhir/conformance-rules.html#isModifier) **cannot be safely ignored** as they may change the meaning of the resource.

    1. For other elements flagged with `MustSupport`, Verifiers MAY process at their own discretion.

### Required elements

Elements with a minimum [cardinality](https://www.hl7.org/fhir/conformance-rules.html#cardinality) of 1 or greater are considered required.

### Missing data

- If an Issuer does not have data for a `MustSupport` data element, the data element SHALL be omitted from the resource. Implementers SHALL NOT produce placeholder data when data are not available; instead, omit the element.
- If an Issuer does not have data for a required data element (minimum cardinality > 0), the Issuer SHALL NOT produce the resource.

### Data minimization

The FHIR payload within a SMART Health Card SHALL be [small enough](https://spec.smarthealth.cards/#health-cards-are-small) to allow the entirety of the SMART Health Card to fit within [a single Version 22 QR code](https://spec.smarthealth.cards/#chunking). This limits the amount of data that SHOULD be included in FHIR resources that appear in SMART Health Card payloads.

To preserve patient privacy, information that is not necessary for Verifiers SHALL NOT be included in SMART Health Cards. With respect to patient privacy, note that when a SMART Health Card is issued, it is [cryptographically signed](https://spec.smarthealth.cards/#signing-health-cards) by the Issuer. This means that the contents, including the FHIR bundle, cannot be changed without invalidating the signature. It is therefore critical for Issuers to exclude any information that could represent a privacy risk to a patient when presenting their SMART Health Card to a Verifier.

See the [Validation section](#validation) for information on how to validate a resource against a profile.

Additionally:

- Implementers SHOULD NOT populate `Resource.id` or `Resource.text` elements. `Resource.meta` SHOULD NOT be populated, except for `Resource.meta.security` in the vaccination and laboratory test results profiles.

- Implementers SHALL use `resource:0` syntax for IDs and references.
    - Implementers SHALL populate `Bundle.entry.fullUrl` elements with short resource-scheme URIs (e.g., `{"fullUrl": "resource:0}`).
    - Implementers SHALL populate `Reference.reference` elements with short resource-scheme URIs (e.g., `{"patient": {"reference": "resource:0"}}`) which SHALL resolve within the bundle.

- Implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when using any value from a value set with a `required` binding, or using specified values from a value set with an `extensible` binding.

- Likewise, implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when specifying codes that are fixed in profiles.

- String length should be limited; invariants are used within the IG to produce warnings when strings exceed the expected length for a `MustSupport` element (except for patient name).

- Implementers SHOULD use `YYYY-MM-DD` precision for all `dateTime` fields EXCEPT for laboratory results (described below). Greater precision will result in a warning when validating a resource.
    - Implementers SHALL use `YYYY-MM-DDThh:mm:ss+zz:zz` format for `effective[x]` dateTime elements in [SHCCovid19LaboratoryResultObservationDM] and [SHCInfectiousDiseaseLaboratoryResultObservationDM] (and their AD counterparts). Additionally, implementers SHALL follow this conformance requirement from [FHIR R4's documentation for the dateTime type](http://hl7.org/fhir/R4/datatypes.html#dateTime):

        > If hours and minutes are specified, **a time zone SHALL be populated**. Seconds must be provided due to schema type constraints but may be zero-filled and may be ignored at receiver discretion. \[Emphasis added.\]

### Bundles

Bundles meant to populate the `fhirBundle` element of a SMART Health Card with a type of `https://smarthealth.cards#covid19` SHALL conform to one of the Bundles profiled in this IG.

The profiles of Bundle in this IG MAY be used with other types of SMART Health Cards.

### Validation

Resources may be assessed for conformance using one of [the tools listed under "Conformance testing" on this page](https://confluence.hl7.org/pages/viewpage.action?pageId=111122184#SMARTHealthCardsImplementationTools-Conformancetesting), or manually with the FHIR Validator (described below).

Note that these tools **do not** check for `MustSupport` conformance as this depends on the particulars of the data available to the actor producing the resource. Implementers MUST manually check `MustSupport` conformance based on the criteria described above.

To validate a specific resource against a profile, the [FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar) can be used, where [package.tgz is downloaded from the IG](package.tgz):

```sh
# Run to get latest validator_cli.jar (~80MB)
curl -L -O https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar

# Run to get latest package from this IG to validate against
curl -L -O https://vci.org/ig/vaccination-and-testing/package.tgz

# Run to validate; note you will need to update the paths to (1) validator_cli.jar; (2) package.tgz;
# (3) the resource you wish to validate.
#
# You will also need to specify the URI of the profile you wish to validate against. This can be found
# under "Defining URL" on any of the profile pages in this IG.
java -jar path/to/validator_cli.jar -version 4.0.1 \
-ig path/to/package.tgz \
-profile http://hl7.org/fhir/uv/shc-vaccination/StructureDefinition/shc-vaccination-dm \
path/to/immunization.json
```

The command above would validate `path/to/immunization.json` against the [SHCVaccinationDM] profile. To validate against a different profile, change `shc-vaccination-dm` to the [identifier](http://www.hl7.org/fhir/structuredefinition-definitions.html#StructureDefinition.identifier) of the profile you want to validate against. This can be found at the end of the canonical URL listed at the top of each profile's page in the IG.

Additional [testing and validation tools may be found here](https://confluence.hl7.org/display/PHWG/SMART+Health+Cards+Implementation+Tools).

{% include markdown-link-references.md %}

<script>
// Move Markdown TOC below alert box for cosmetics
var ref = document.querySelector('h3:nth-of-type(2)');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertBefore(el, ref);
</script>
