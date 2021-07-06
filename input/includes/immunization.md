### Usage

#### Scope and terminology

An Immunization resource conforming to this profile SHALL be used to describe a single vaccine given to a patient.

For vaccinations that require multiple doses of a vaccine (e.g., the mRNA-based COVID-19 vaccines that have a two-dose series), a separate Immunization resource SHALL be provided for each vaccine given in the series.

Note that:

> While the terms "immunization" and "vaccination" are not clinically identical, for the purposes of the FHIR resources, the terms are used synonymously. ([source](https://www.hl7.org/fhir/immunization.html))

#### Identifying vaccines

The `vaccineCode` element is used to identify the vaccine given to the patient.

Implementers SHALL use one of the following code systems for identifying vaccinations in the `vaccineCode` element:

----------

{:.table-striped.table.table-bordered}
| Code system                                    | Value set                                  | Example                                                                                    | COVID-19: Specify manufacturer?  |
| ---------------------------------------------- | ------------------------------------------ | ------------------------------------------------------------------------------------------ | -------------------------------- |
| GTIN: `https://www.gs1.org/gtin`               | [VaccineGTIN]                       | `380777273990` ([Moderna COVID-19 vaccination], NDC `80777-273`)                           | No                               |
| CVX: `http://hl7.org/fhir/sid/cvx`             | [VaccineCVX]                        | `207` ("COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose")                                   | No (optional for other diseases) |
| AIR\*                                          | [Australian Immunisation Register Vaccine] | `COVAST` ("COVID-19 Vaccine AstraZeneca")                                                  | No                               |
| SNOMED CT: `http://snomed.info/sct`            | [VaccineSNOMED]                        | `1119349007` ("Severe acute respiratory syndrome coronavirus 2 mRNA only vaccine product") | Yes (required)&dagger;           |
| ICD-11: `http://id.who.int/icd11/mms`          | [VaccineICD11]                       | `XM0GQ8` ("COVID-19 vaccine, RNA based)                                                    | Yes (required)                   |
| ATC/DDD: `https://www.whocc.no/atc_ddd_index/` | [VaccineATC]                         | `J07BX03` ("covid-19 vaccines")                                                            | Yes (required)                   |

\* The URI for AIR is `https://www.humanservices.gov.au/organisations/health-professionals/enablers/air-vaccine-code-formats`.

&dagger; The UK edition of SNOMED CT includes codes for COVID-19 vaccines that identify specific vaccine products. [Children of `39330711000001103`](https://termbrowser.nhs.uk/?perspective=full&conceptId1=39330711000001103&edition=uk-edition&release=v20210317&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999001261000000100,999000691000001104), such as [`39326811000001106`](https://termbrowser.nhs.uk/?perspective=full&conceptId1=39326811000001106&edition=uk-edition&release=v20210317&server=https://termbrowser.nhs.uk/sct-browser-api/snomed&langRefset=999001261000000100,999000691000001104) ("Generic COVID-19 mRNA (nucleoside modified) Vaccine Moderna 0.1mg/0.5mL dose dispersion for injection multidose vials (product)"), can therefore be used without separately specifying the manufacturer as long as the Fully Specified Name includes the manufacturer of the vaccine.

[Australian Immunisation Register Vaccine]: https://www.healthterminologies.gov.au/integration/R4/fhir/ValueSet/australian-immunisation-register-vaccine-1
[Moderna COVID-19 vaccination]: https://www.accessdata.fda.gov/spl/data/bf508dc6-df89-b057-e053-2a95a90abda9/bf508dc6-df89-b057-e053-2a95a90abda9.xml

----------

Some additional information about the table above:

* A **code system** defines a set of "codes" and their mappings onto specific meanings. For example, the [CVX code system][CVX] includes the code `207`, which is mapped to the meaning "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose". Using a code system helps to ensure implementers represent a given concept in a consistent way that other implementers can understand.
* A **value set** defines a group of codes that can be used within a specific element. For example, we define a [value set of SNOMED-CT codes for vaccine products][VaccineTypeSNOMED] for use in the `vaccineCode` element. FHIR allows an element to be "bound" to a value set, meaning that the contents of that element must come from the value set (for a "[required binding][binding]") or should come form the value set (for a "[preferred binding][binding]").
* Codes from multiple code systems may be used in `vaccineCode`. While these codes all generally identify vaccines, they may do so at different levels of **granularity**. For example, some codes may just identify the target disease and type of vaccine. Others may identify specific vaccine products. The table above is sorted roughly from most to least granular.

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

##### Support for additional code systems

Implementers may request support for an additional code system by [opening a new GitHub issue](https://github.com/dvci/vaccine-credential-ig/issues/new).

#### Vaccine manufacturer

There are two approaches for identifying vaccine manufacturer that are supported by this IG:

1. Include GTIN in `vaccineCode` (preferred)
2. Populate `manufacturer.identifier` (fallback)

Adding a GTIN to `vaccineCode` is preferred because this is less verbose than using `manufacturer.identifier`, and because `manufacturer.identifier` is not a CodeableConcept. This means that it cannot be bound to a value set like `vaccineCode`.

However, if populating `manufacturer.identifier`, Issuers SHALL identify a code system URI in `system` and use a code from that code system in `value`. Specifically, Issuers SHALL use a code from one of the code systems below in `manufacturer.identifier.value`:

{:.table-striped.table.table-bordered}
| Code system                                      | Example                   |
| ------------------------------------------------ | ------------------------- |
| MVX: `http://hl7.org/fhir/sid/mvx`               | `MOD` (Moderna)           |
| GLN: `https://www.gs1.org/gln`                   | `0380777000008` (Moderna) |

For example, to identify Moderna, either of the following may be used:

* MVX

    ```
    ...
    "manufacturer": {
      "identifier": {
        "system": "http://hl7.org/fhir/sid/mvx",
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

##### When should vaccine manufacturer be provided?

**For COVID-19:** If `vaccineCode` contains a code from a code system with `No` in the "COVID-19: Specify manufacturer?" column in the table above, Issuers SHALL NOT separately provide manufacturer. Otherwise, if `vaccineCode` contains a code from a code system with `Yes (optional)` in the "COVID-19: Specify manufacturer?" column, Issuers MAY separately provide manufacturer. Otherwise, Issuers SHALL separately provide manufacturer using one of the approaches described above. (Note the exception for some UK SNOMED CT codes as described with the &dagger; with the above table.)

This is necessary to provide sufficient information for Verifiers to assess immunity based on the vaccination data in the SMART Health Cards. For example, the Pfizer and Moderna mRNA COVID-19 vaccines share the same SNOMED code (`1119349007`) but have different timing for the second dose; Verifiers may wish to know if two doses were administered with the correct timing and confirm that they were both from the same manufacturer. Another example: there is a single ATC/DDD code (`J07BX03`) for *all* COVID-19 vaccines; this is not sufficient information for Verifiers to assess immunity because some vaccines require multiple doses and some do not.

**For other diseases:** If `vaccineCode` contains a GTIN, Issuers SHALL NOT separately provide manufacturer. Otherwise, Issuers SHOULD provide the manufacturer if they believe this information could be necessary or useful for Verifiers.

For example, if there are multiple vaccines for a specific disease with different numbers of doses, different schedules for doses, or meaningful differences in effectiveness, Issuers SHOULD provide manufacturer using one of the approaches described above.

Note manufacturer and lot number may be recorded together in vaccine records. To conform with this IG, manufacturer SHALL NOT appear in the `lotNumber` element; instead, Issuers SHALL apply the above conformance criteria to determine when and how manufacturer can be identified.

#### CVX and MVX codes

When vaccine and manufacturer are provided using US-centric terminology (CVX and MVX, respectively) for COVID-19 vaccinations, CDC [provides a list](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html) that includes "Sale Proprietary Name" (e.g., `Moderna COVID-19 Vaccine`). The "Sale Proprietary Name" or other trade name SHALL NOT be included in FHIR resources, but MAY be used by actors when producing human-readable representations of these resources.

Note that as of May 2021, CVX implicitly identifies specific vaccine products and manufacturers **only for COVID-19**. For other diseases, CVX typically identifies just the target disease and vaccine type. Issuers that only populate `vaccineCode` with a CVX code therefore SHALL NOT populate a `manufacturer` for COVID-19 vaccinations UNLESS they believe this information is important for Verifiers. Issuers using CVX MAY populate a `manufacturer` for non-COVID-19 vaccinations.

<div class="alert alert-info" role="alert" markdown="1">
Implementers using CVX to identify a COVID-19 vaccination SHOULD conform to **[this CVX-specific allowable data profile][VaccinationCredentialImmunizationCVXCovid19]**.
</div>

#### Universal terminology: GTIN and GLN

In addition to the US-centric CVX and MVX code systems, this IG supports [GTIN] for identifying vaccine products, and [GLN] for identifying manufacturers. GTIN and GLN are international standards governed by [GS1](https://www.gs1.org) for identifying products and their manufacturers. Note GTINs may differ depending on the packaging of a product and country of sale, so there may be multiple GTINs assigned to the same vaccine product. (Note that for COVID-19, [EU member states as well as Norway and Iceland agreed to use the same GTIN for each COVID-19 vaccine product](https://www.ema.europa.eu/en/documents/other/questions-answers-labelling-flexibilities-covid19-vaccines_en.pdf), but this is not typically the case.)

For example, the following GTINs are assigned to the Janssen (Johnson & Johnson) COVID-19 vaccine:

    00359676580157
    05413868119794
    05413868119800
    05413868119817
    05413868119824
    05413868119831
    05413868119893
    05413868119930
    05413868119947
    05413868119954
    05413868119961
    05413868119978
    05413868119985
    05413868120110
    05413868120349
    05413868120356

The manufacturer can be looked up from a GTIN using a search tool [like this one](https://gepir.gs1.org/index.php/search-by-gtin). For example, the GTIN `00359676580157` is associated with `Janssen Products LP`, in Piscataway, New Jersey, USA (GLN = `0359676000006`).

A "company prefix" appears at the beginning of each GTIN, and ranges of these prefixes are controlled by the GS1 offices in specific countries. For example, the `035` prefix in `00359676580157` [means the code was assigned by GS1 US](https://www.gs1.org/standards/id-keys/company-prefix). The `541` prefix in the other GTINs listed above [means the GTIN is assigned by GS1 Belgium & Luxembourg](https://www.gs1.org/standards/id-keys/company-prefix).

In the US, the GTIN for pharmaceuticals [is derived from the National Drug Code](https://www.rxtrace.com/2012/01/depicting-an-ndc-within-a-gtin.html/). Because the example above (`00359676580157`) is a US product, the NDC can be extracted:

    GTIN 00359676580157
     NDC    5967658015

The NDC of `59676-580-15` [corresponds to a carton of 10 multi-dose vials of the Janssen COVID-19 vaccine](https://www.janssenlabels.com/emergency-use-authorization/Janssen%20COVID-19%20Vaccine-HCP-fact-sheet.pdf).

For Verifiers, the method for identifying the vaccine product associated with a specific GTIN may differ depending on the associated GS1 office and locale. For example:

* In the US, Verifiers can perform lookups based on the NDC extracted from a GTIN using a tool like [the FDA National Drug Code Directory](https://www.accessdata.fda.gov/scripts/cder/ndc/index.cfm).
* In the UK, Verifiers can perform GTIN lookups using a tool like [NHS dm+d (dictionary of medicines and devices) code lookup tool](https://services.nhsbsa.nhs.uk/dmd-browser/code-lookup). For example, [the lookup of the GTIN `30380777700688`](https://services.nhsbsa.nhs.uk/dmd-browser/ampp/view/183524) shows this corresponds to the Moderna mRNA vaccine.

Some locales may not have a GTIN lookup tool for pharmaceuticals or vaccines. In these cases, it may be necessary to contact the manufacturer of the vaccine to determine the canonical list of GTINs used to represent a given vaccine product. Note that even if product-level GTIN lookup is not available from a central database, the manufacturer associated with a given GTIN can be looked up using a search tool [like this one](https://gepir.gs1.org/index.php/search-by-gtin).

#### Universal terminology: SNOMED CT

This IG also supports the use of [SNOMED CT for identifying vaccines][VaccineTypeSNOMED]. Note that some of the SNOMED CT codes that are part of this value set expansion, [including the COVID-19-related SNOMED CT codes][snomed-covid], may be used under the a [Creative Commons Attribution 4.0 International License][cc-ail] as part of [the SNOMED Global Patient Set](https://gps.snomed.org). Please refer to <https://gps.snomed.org> to determine which specific SNOMED CT codes may be used under this license.

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
