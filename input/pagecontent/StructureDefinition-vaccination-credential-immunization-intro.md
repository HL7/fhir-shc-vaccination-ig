### Usage

#### Scope and terminology

An Immunization resource conforming to this profile SHALL be used to describe a single vaccine given to a patient.

For vaccinations that require multiple doses of a vaccine (e.g., the mRNA-based COVID-19 vaccines that have a two-dose series), a separate Immunization resource SHALL be provided for each vaccine given in the series.

Note that:

> While the terms "immunization" and "vaccination" are not clinically identical, for the purposes of the FHIR resources, the terms are used synonymously. ([source](https://www.hl7.org/fhir/immunization.html))

#### Identifying vaccines

The `vaccineCode` element is used to identify the vaccine given to the patient.

Implementers SHALL use one of the following code systems for identifying vaccinations:

| Code system                         | Value set                      | Granularity              | Example                                                                                    | Copyright | License                         |
| ----------------------------------- | ------------------------------ | ------------------------ | ------------------------------------------------------------------------------------------ | --------- | ------------------------------- |
| CVX: `http://hl7.org/fhir/sid/cvx`  | [VaccineProductCVXValueSet]    | Disease + type           | `207` ("COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose")                                   | None      | None                            |
| GTIN: `https://www.gs1.org/gtin`    | [VaccineProductGTINValueSet]   | Disease + type + product | `380777273990` ([Moderna COVID-19 vaccination])                                            | TBD       | TBD                             |
| SNOMED-CT: `http://snomed.info/sct` | [VaccineProductSNOMEDValueSet] | Disease + type           | `1119349007` ("Severe acute respiratory syndrome coronavirus 2 mRNA only vaccine product") | IHTSDO    | [See value set](VaccineProduct) |

* A **code system** defines a set of "codes" and their mappings onto specific meanings. For example, the [CVX code system][CVX] includes the code `208`, which is mapped to the meaning "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose". Using a code system helps to ensure implementers represent a given concept in a consistent way that other implementers can understand.
* A **value set** defines a group of codes that can be used within a specific element. For example, we define a [value set of SNOMED-CT codes for vaccine products](VaccineProductSNOMEDValueSet) for use in the `vaccineCode` element. FHIR allows an element to be "bound" to a value set, meaning that the contents of that element must come from the value set (for a "[required binding][binding]") or should come form the value set (for a "[preferred binding][binding]").
* Codes from multiple code systems may be used in `vaccineCode`. While these codes all generally identify vaccines, they may do so at different levels of **granularity**. For example, some codes may just identify the target disease and type of vaccine. Others may identify specific vaccine products. At a minimum, `vaccineCode` SHALL contain at least one code identifying the disease(s) targeted (e.g., COVID-19) and type of vaccine (e.g., mRNA). Separate codes for disease(s) target and vaccination type MAY be used, but implementers SHOULD use a single code when possible to reduce payload size.

Issuers MAY include multiple codes within `vaccineCode`. For example:

```
...
"vaccineCode": {
  "coding": [
    {
      "system": "http://hl7.org/fhir/sid/cvx",
      "code": "207"
    },
    {
      "system": "https://www.gs1.org/gtin",
      "code": "380777273990"
    },
    {
      "system": "http://snomed.info/sct",
      "code": "1119349007"
    }
  ]
},
...
```

When using multiple codes, the codes SHALL NOT contradict each other. More information is [available here](https://www.hl7.org/fhir/datatypes.html#CodeableConcept), and excerpted below:

> More than one code may be used in CodeableConcept. The concept may be coded multiple times in different code systems.... Each coding (also referred to as a 'translation') is a representation of the concept as described above and may have slightly different granularity due to the differences in the definitions of the underlying codes. There is no meaning associated with the ordering of coding within a CodeableConcept.

However, for [data minimization](conformance.html#data-minimization) reasons, Issuers SHOULD typically include ONLY a single code that is the most granular (i.e., includes the greatest level of detail) of the options available in their system.

Verifiers can expect that codes from any of the systems listed above may appear in SMART Health Cards.

#### Vaccine manufacturer

When the code used in `vaccineCode` does not include the vaccine manufacturer, Issuers SHOULD include the manufacturer of the vaccine in `manufacturer.identifier`.

Note that this element is not a CodeableConcept, so it cannot be bound to a value set like `vaccineCode`. However, Issuers SHALL identify a code system URI in `system` and use a code from that code system in `value`. Specifically, Issuers SHALL use a code from [VaccinationCredentialVaccineManufacturerValueSet] to populate `manufacturer.identifier.value`. For example, to identify Moderna, either of the following may be used:

* MVX

    ```
    ...
    "manufacturer": {
      "identifier": {
        "system": "http://terminology.hl7.org/CodeSystem/MVX",
        "value": "MOD"
      }
    }
    ...
    ```

* GLN

    ```
    ...
    "manufacturer": {
      "identifier": {
        "system": "https://www.gs1.org/gln",
        "value": "0380777000008"
      }
    }
    ...
    ```

Note that implementers SHALL NOT include `manufacturer.identifier` when a GTIN is provided in `vaccineCode` as the GTIN identifies the manufacturer. This IG also supports SNOMED-CT for identifying vaccine products. Note that the SNOMED-CT codes for identifying COVID-19 vaccine products [are part of the SNOMED Global Patient Set (GPS)][snomed-covid] and can be used now under the same open license as the GPS, the
[Creative Commons Attribution 4.0 International License][cc-ail].

[snomed-covid]: https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content
[cc-ail]: https://creativecommons.org/licenses/by/4.0/

#### CVX and MVX codes

When vaccine and manufacturer are provided using US-centric terminology (CVX and MVX, respectively) for COVID-19 vaccinations, CDC [provides a list](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html) that includes "Sale Proprietary Name" (e.g., `Moderna COVID-19 Vaccine`). The "Sale Proprietary Name" or other trade name SHALL NOT be included in FHIR resources, but MAY be used by Issuers when producing human-readable representations of these resources.

#### Non-US-centric terminology

In addition to the US-centric CVX and MVX code systems, this IG supports [GTIN] for identifying vaccine products, and [GTN] for identifying manufacturers. This IG also supports the use of SNOMED for identifying

#### Conformance for `status` and `statusReason`

The `status` element indicates if a given Immunization resource represents a completed vaccination, or if the vaccination was not completed for some reason.

Issuers SHALL only produce resources conforming to this profile IF `status` has the value `completed`, which is reflected in the profile by fixing the value of `status` to `completed`. Note that `status` is required rather than being omitted entirely due to inheriting `1..1` cardinality from the [Immunization](http://hl7.org/fhir/R4/immunization.html) resource, along with an `Is-Modifier` flag. This profile adds the `MustSupport` flag indicating Verifiers SHALL meaningfully process this element as described on the [Conformance](conformance.html) page, which is important in case a non-conforming resource is provided that has `status` set to a value other than `completed`.

The `statusReason` element is disallowed (`0..0` cardinality) because it is not meaningful when `status` is `completed`.

#### Why `protocolApplied` is not allowed

The `protocolApplied` element is set to `0..0` cardinality because it reflects the provider's intent, rather than being an authoritative source of information about the dose number and number of doses in the series. Including this element could lead to confusion with verifiers who do not recognize this distinction.

Instead, verifiers should use the presence and timestamps of multiple doses along with `vaccineCode` to make their own determination about whether or not an Immunization resource represents a valid dose of the vaccine and, if applicable, completion of a series.

[binding]: http://hl7.org/fhir/R4/valueset-binding-strength.html
[Moderna COVID-19 vaccination]: https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=e0651c7a-2fe2-459d-a766-0d59e919f058

{% include ad-profile.md %}