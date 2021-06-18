<table class="table">
<thead>
    <tr>
        <th>Group</th>
        <th>Primary (DM)</th>
        <th>Fallback (AD)</th>
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

### How to use profiles for implementation

This Implementation Guide (IG) includes Data Minimization (DM) and fallback Allowable Data (AD) profiles of each relevant resource. More detail about the difference between DM and AD profiles is available on the [Conformance page](conformance.html#data-minimization).

In general, implementers (typically Issuers of SMART Health Cards) who are generating resources meant to conform with this IG SHOULD:

1. Start by [validating](conformance.html#validation) against the DM profile for a given FHIR resource, and attempt to resolve any errors.
2. If an Issuer has a good faith belief that resolving a validation error against a DM profile would reduce utility for Holders or Verifiers, they MAY validate against the less constrained fallback AD profile instead.

All resources meant to conform with this IG SHOULD conform to the relevant DM profile, and SHALL conform to the relevant fallback AD profiles.

In some cases, multiple pairs of DM/AD profiles of the same resource are provided (e.g., "Universal Patient" vs. "US-Only Patient"). Implementers SHALL use the most specific set of profiles for their given use case. For example, a US-based implementer SHALL use the "US-Only Patient" profiles. Likewise, an implementer producing resources representing COVID-19 lab results SHALL use the COVID-19-specific lab results profiles.

The recommended workflow for reading profiles of a given resource in this IG is as follows:

1. First review the "Implementation details" page, if provided, which is marked with <span class="label label-success">Start here!</span> in the table above. This contains critical information for implementers, and is linked prominently at the top of relevant profiles in addition to appearing in the tables below.
1. Review the "Snapshot" tab on the DM profile for the resource. The elements listed here SHOULD/SHALL be included based on  `MustSupport` (<span style="padding-left: 3px; padding-right: 3px; color: white; background-color: red;" >S</span> in the "Flags" column) and [cardinality](https://www.hl7.org/fhir/conformance-rules.html#cardinality) (in the "Card.") column. Elements not listed here SHOULD NOT/SHALL NOT be included. Details on interpreting cardinality and `MustSupport` for this IG are available on the [Conformance](conformance.html) page.
    - For more information about the data type for a given element, click the data type link in the "Type" column. This will bring you to the relevant portion of the FHIR specification for that data type.
    - The "Description & Constraints" column has a short description of each element. Some elements may also have a "Binding" listed here, which indicates values SHALL come from the specified list. (This IG uses "Required" for all value set bindings, but other IGs may use [more flexible binding strengths](https://www.hl7.org/fhir/terminologies.html#strength).)
1. For each element included in your resource, click the element's name in the "Snapshot" table. This will take you to the detailed definition of the element, which may have more implementation and conformance information.
