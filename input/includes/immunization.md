### Usage

#### Scope and terminology

An Immunization resource conforming to this profile SHALL be used to describe a single vaccine given to a patient.

For vaccinations that require multiple doses of a vaccine (e.g., the mRNA-based COVID-19 vaccines that have a two-dose series), a separate Immunization resource SHALL be provided for each vaccine given in the series.

Note that:

> While the terms "immunization" and "vaccination" are not clinically identical, for the purposes of the FHIR resources, the terms are used synonymously. ([source](https://www.hl7.org/fhir/immunization.html))

#### Identifying vaccines

The `vaccineCode` element is used to identify the vaccine given to the patient.

Implementers SHALL use one of the following code systems for identifying vaccinations in the `vaccineCode` element:

| Code system                           | Value set                    | Granularity              | Example                                                                                    | Additional code(s) required |
| ------------------------------------- | ---------------------------- | ------------------------ | ------------------------------------------------------------------------------------------ | --------------------------- |
| CVX: `http://hl7.org/fhir/sid/cvx`    | [VaccineProductCVXValueSet]  | Disease + type + product | `207` ("COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose")                                   | -                           |
| GTIN: `https://www.gs1.org/gtin`      | [VaccineProductGTINValueSet] | Disease + type + product | `380777273990` ([Moderna COVID-19 vaccination])                                            | -                           |
| SNOMED-CT: `http://snomed.info/sct`   | [VaccineTypeSNOMEDValueSet]  | Disease + type           | `1119349007` ("Severe acute respiratory syndrome coronavirus 2 mRNA only vaccine product") | Manufacturer                |
| ICD-11: `http://id.who.int/icd11/mms` | [VaccineTypeICD11ValueSet]   | Disease                  | `XM0GQ8` ("COVID-19 vaccine, RNA based)                                                    | Manufacturer                |
{: .grid }

Some additional information about the table above:

* A **code system** defines a set of "codes" and their mappings onto specific meanings. For example, the [CVX code system][CVX] includes the code `208`, which is mapped to the meaning "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose". Using a code system helps to ensure implementers represent a given concept in a consistent way that other implementers can understand.
* A **value set** defines a group of codes that can be used within a specific element. For example, we define a [value set of SNOMED-CT codes for vaccine products][VaccineTypeSNOMEDValueSet] for use in the `vaccineCode` element. FHIR allows an element to be "bound" to a value set, meaning that the contents of that element must come from the value set (for a "[required binding][binding]") or should come form the value set (for a "[preferred binding][binding]").
* Codes from multiple code systems may be used in `vaccineCode`. While these codes all generally identify vaccines, they may do so at different levels of **granularity**. For example, some codes may just identify the target disease and type of vaccine. Others may identify specific vaccine products.

Issuers MAY include multiple codes within `vaccineCode` ONLY IF they believe the additional information is helpful for other actors. For example, an Issuer may be targeting a Verifier that prefers SNOMED, but the Issuer also wishes to provide manufacturer information via the GTIN. In this case, the following would conform:

```
...
"vaccineCode": {
  "coding": [
    {
      "system": "http://snomed.info/sct",
      "code": "1119349007"
    },
    {
      "system": "https://www.gs1.org/gtin",
      "code": "380777273990"
    }
  ]
},
...
```

When using multiple codes, the codes SHALL NOT contradict each other. More information on conformance expectations for multiple codes in a CodeableConcept is [available here](https://www.hl7.org/fhir/datatypes.html#CodeableConcept), and excerpted below:

> More than one code may be used in CodeableConcept. The concept may be coded multiple times in different code systems.... Each coding (also referred to as a 'translation') is a representation of the concept as described above and may have slightly different granularity due to the differences in the definitions of the underlying codes. There is no meaning associated with the ordering of coding within a CodeableConcept.

However, as described above, for [data minimization](conformance.html#data-minimization) reasons, Issuers SHOULD typically include ONLY a single code that is the most granular (i.e., includes the greatest level of detail) of the options available in their system UNLESS they believe another actor may benefit from the additional code. Typically at most two codes will be included in `vaccineCode`: a less granular code paired with a GTIN code to identify manufacturer as described below.

Verifiers SHALL be able to meaningfully process and interpret codes from ALL of the systems listed above.

#### Vaccine manufacturer

Vaccine manufacturer SHALL be provided by Issuers UNLESS `vaccineCode` includes a code from a system with "product"-level granularity as specified in the table above. The reason for this is that Verifiers may need to identify a specific vaccine product to determine if a multi-dose vaccination has been successfully completed (e.g., the Moderna and Pfizer COVID-19 vaccines have different timing for the 2nd dose).

If including manufacturer is necessary, Issuers SHALL choose ONLY one of the following methods for specifying manufacturer:

1. Include GTIN in `vaccineCode` (preferred)
2. Populate `manufacturer.identifier` (fallback)

Adding a GTIN to `vaccineCode` is preferred because this is less verbose than using `manufacturer.identifier`, and because `manufacturer.identifier` is not a CodeableConcept. This means that it cannot be bound to a value set like `vaccineCode`. However, if populating `manufacturer.identifier`, Issuers SHALL identify a code system URI in `system` and use a code from that code system in `value`. Specifically, Issuers SHALL use a code from one of the code systems below in `manufacturer.identifier.value`:

| Code system                                      | Example                   |
| ------------------------------------------------ | ------------------------- |
| MVX: `http://terminology.hl7.org/CodeSystem/MVX` | `MOD` (Moderna)           |
| GLN: `https://www.gs1.org/gln`                   | `0380777000008` (Moderna) |
{: .grid }

For example, to identify Moderna, either of the following may be used:

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

Verifiers SHALL be able to meaningfully process and interpret codes from ALL of the systems listed above.

#### CVX and MVX codes

When vaccine and manufacturer are provided using US-centric terminology (CVX and MVX, respectively) for COVID-19 vaccinations, CDC [provides a list](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html) that includes "Sale Proprietary Name" (e.g., `Moderna COVID-19 Vaccine`). The "Sale Proprietary Name" or other trade name SHALL NOT be included in FHIR resources, but MAY be used by actors when producing human-readable representations of these resources.

#### Universal terminology

In addition to the US-centric CVX and MVX code systems, this IG supports [GTIN] for identifying vaccine products (which [can be derived from the United States NDC](https://www.rxtrace.com/2012/01/depicting-an-ndc-within-a-gtin.html/), and is consistent internationally for COVID-19 vaccinations), and [GLN] for identifying manufacturers. GTIN and GLN are international standards governed by [GS1](https://www.gs1.org).

This IG also supports the use of [SNOMED-CT for identifying vaccines][VaccineTypeSNOMEDValueSet]. Note that some of the SNOMED-CT codes that are part of this value set expansion, [including the COVID-19-related SNOMED codes][snomed-covid], may be used under the a [Creative Commons Attribution 4.0 International License][cc-ail] as part of [the SNOMED Global Patient Set](https://gps.snomed.org). Please refer to <https://gps.snomed.org> to determine which specific SNOMED codes may be used under this license.

[snomed-covid]: https://confluence.ihtsdotools.org/display/snomed/SNOMED+CT+COVID-19+Related+Content
[cc-ail]: https://creativecommons.org/licenses/by/4.0/

#### Conformance for `status` and `statusReason`

The `status` element indicates if a given Immunization resource represents a completed vaccination, or if the vaccination was not completed for some reason.

Issuers SHALL only produce resources conforming to this profile IF `status` has the value `completed`, which is reflected in the profile by fixing the value of `status` to `completed`. Note that `status` is required rather than being omitted entirely due to inheriting `1..1` cardinality from the [Immunization](http://hl7.org/fhir/R4/immunization.html) resource, along with an `Is-Modifier` flag. This profile adds the `MustSupport` flag indicating Verifiers SHALL meaningfully process this element as described on the [Conformance](conformance.html) page, which is important in case a non-conforming resource is provided that has `status` set to a value other than `completed`.

The `statusReason` element is disallowed (`0..0` cardinality) because it is not meaningful when `status` is `completed`.

#### Why `protocolApplied` is not allowed

The `protocolApplied` element is set to `0..0` cardinality because it reflects the provider's intent, rather than being an authoritative source of information about the dose number and number of doses in the series. Including this element could lead to confusion with verifiers who do not recognize this distinction.

Instead, verifiers should use the presence and timestamps of multiple doses along with `vaccineCode` to make their own determination about whether or not an Immunization resource represents a valid dose of the vaccine and, if applicable, completion of a series.

[binding]: http://hl7.org/fhir/R4/valueset-binding-strength.html
[Moderna COVID-19 vaccination]: https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=e0651c7a-2fe2-459d-a766-0d59e919f058