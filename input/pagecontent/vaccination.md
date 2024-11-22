{% include profile-set-nav.md resourceName="vaccination" %}

### Usage

#### Scope and terminology

An Immunization resource conforming to this profile SHALL be used to describe a single vaccine given to a patient.

For vaccinations that require multiple doses of a vaccine (e.g., the mRNA-based COVID-19 vaccines that have a two-dose series), a separate instance of the Immunization resource SHALL be provided for each vaccine given in the series.

Note that:

> While the terms "immunization" and "vaccination" are not clinically identical, for the purposes of the FHIR resources, the terms are used synonymously. ([source](https://www.hl7.org/fhir/immunization.html))

#### Identifying vaccines

Implementers SHALL use a code from at least one of the following three [code systems](https://www.hl7.org/fhir/codesystem.html) to identify vaccines:

1. [CVX]
2. [ICD-11 for Mortality and Morbidity Statistics](https://icd.who.int/browse11/l-m/en) (ICD-11 MMS)
3. [SNOMED CT](https://www.snomed.org)

Code systems like these define a set of codes that are mapped onto specific meanings. Using a code system helps to ensure implementers represent a given concept in a consistent way that other implementers can understand.

Codes from at least one of these code systems SHALL be used to populate the `Immunization.vaccineCode` element to identify the vaccine given to the patient.

* **Issuers** of SMART Health Cards SHALL populate this data element with a code from the subset of these code systems that identify vaccines described in the "Applicable Subset of Codes" column below.
* **Verifiers** of SMART Health Cards SHALL be able to meaningfully process and interpret ANY code from the code systems listed in the table below that appear in the respective "Applicable Subset of Codes".

{:.table-striped.table.table-bordered}
| Code System | Identifying URI | Applicable Subset of Codes | ValueSet | Example |
| -- | -- | -- | -- | -- |
| **CVX** | `http://hl7.org/fhir/sid/cvx` | Any [CVX code][CVX] | [ValueSet][cvx-vs] | `230` ("Moderna COVID-19 Bivalent, Original + BA.4/BA.5") |
| **ICD-11 MMS** | `http://id.who.int/icd/release/11/mms` | Descendants of [Foundation entity `164949870`]† | [ValueSet][icd-vs] | `XM3DT5` ("COVID-19 Vaccine Moderna") |
| **SNOMED CT** | `http://snomed.info/sct` | Descendants of [`787859002`][SNOMED-vaccine-concept]‡ | [ValueSet][snomed-vs] | `28571000087109` ("COVID-19 SPIKEVAX 0.20 mg/mL mRNA Mod") |

[CVX]: https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=CVX
[Foundation entity `164949870`]: https://icd.who.int/browse11/l-m/en#/http%3A%2F%2Fid.who.int%2Ficd%2Fentity%2F164949870
[SNOMED-vaccine-concept]: https://browser.ihtsdotools.org/?perspective=full&conceptId1=787859002
[cvx-vs]: https://terminology.smarthealth.cards/ValueSet-immunization-all-cvx.html
[icd-vs]: https://terminology.smarthealth.cards/ValueSet-immunization-all-icd11.html
[snomed-vs]: https://terminology.smarthealth.cards/ValueSet-immunization-all-snomed.html

##### † Applicable subset of ICD-11 MMS codes

ICD-11 MMS is a linearization of the WHO-FIC Foundation; please see [the WHO-FIC Content Model Reference Guide](https://icd.who.int/icdapi/docs/ContentModelGuide.pdf) (PDF) for more information.

Each ICD-11 MMS code is linked to a WHO-FIC Foundation entity. For example, the ICD-11 MMS code `XM3DT5` ("COVID-19 Vaccine Moderna") is linked to `http://id.who.int/icd/entity/1211296175`. The ICD-11 MMS code (e.g., `XM3DT5`) is used in `Immunization.vaccineCode`, _not_ the linked Foundation entity.

Not all Foundation entities have corresponding ICD-11 MMS codes. In fact, the Foundation entity for "Vaccines" (`http://id.who.int/icd/entity/164949870`) that is used to define the applicable subset of ICD-11 MMS codes does not have a ICD-11 MMS code.

Implementers SHALL ensure that newly issued SMART Health Cards that identify vaccines with ICD-11 MMS use a code descending from `http://id.who.int/icd/entity/164949870` based on the [ICD API](https://icd.who.int/icdapi). As of publishing, FHIR terminology servers do not support expansion of an [intensional value set](http://hl7.org/fhir/valueset.html#int-ext) of ICD-11 MMS codes defined as descendants of a WHO-FIC Foundation entity. An [extensional ValueSet created using the ICD API][icd-vs] is provided for convenience.

##### ‡ Applicable subset of SNOMED CT codes

The SNOMED CT code system consists of multiple [extensions](https://confluence.ihtsdotools.org/display/DOCGLOSS/SNOMED+CT+extension) that add to the [SNOMED CT International Edition](https://confluence.ihtsdotools.org/display/DOCGLOSS/SNOMED+CT+International+Edition). All SNOMED CT codes are identified by the same canonical URI (`http://snomed.info/sct`) regardless of whether they are in the International Edition or an extension.

Any descendants of [`787859002`][SNOMED-vaccine-concept], including concepts from SNOMED CT extensions MAY be used to populate `Immunization.vaccineCode`.

#### Multiple values for `vaccineCode`

Issuers SHOULD NOT include multiple codes within `vaccineCode`. Including multiple codes increases the payload size (which can reduce the legibility of the QR code that contains the SMART Health Card), and could introduce conflicting data. SMART Health Cards with multiple values for `vaccineCode` should only be issued if the Issuer has a good faith belief that including multiple values for `vaccineCode` is necessary for workflows of downstream actors, or has a jurisdictional requirement to use a code from a code system other than CVX, ICD-11 MMS, or SNOMED CT.

If multiple values are provided for `vaccineCode`:

1. One of them SHALL be from CVX, ICD-11 MMS, or SNOMED CT.

2. The codes in `vaccineCode` SHALL NOT contradict each other; more information on conformance expectations for multiple codes in a CodeableConcept is [available here](https://www.hl7.org/fhir/datatypes.html#CodeableConcept), and excerpted below:

   > More than one code may be used in CodeableConcept. The concept may be coded multiple times in different code systems.... Each coding (also referred to as a 'translation') is a representation of the concept as described above and may have slightly different granularity due to the differences in the definitions of the underlying codes. There is no meaning associated with the ordering of coding within a CodeableConcept.

There is no expectation that Verifiers will be able to process `vaccineCode` values from code systems other than CVX, ICD-11 MMS, or SNOMED CT.

#### Vaccine identification specificity requirements

In some cases, identifying the specific formulation of a vaccine may be necessary for Verifiers to determine if the presented immunization(s) meet their criteria. For example, the timing of the initial two dose series of mRNA COVID-19 vaccines differed by manufacturer; in this case, it was necessary to identify the vaccine with greater specificity than just "mRNA COVID-19 vaccine" to determine if the vaccine schedule was followed.

`vaccineCode` SHALL include a code identifying the vaccine with sufficient specificity to support verification of compliance with the vaccine schedule of the Issuer's jurisdiction. For example, SHCs issued in the United States SHALL identify vaccines with sufficient specificity to determine if the [the CDC vaccine schedule](https://www.cdc.gov/vaccines/schedules/index.html) was followed.

If a relevant disease-specific ValueSet is available on [terminology.smarthealth.cards](https://terminology.smarthealth.cards) (see below), Issuers SHALL use a code from the highest-specificity applicable ValueSet.

#### terminology.smarthealth.cards

The SMART Health Cards community maintains [terminology.smarthealth.cards](https://terminology.smarthealth.cards), which provides ValueSets of codes for identifying vaccines, localization of display text, maps between different code systems, and a mechanism for rapidly updating these resources if necessary for a public health response.

Please direct questions related to vaccine terminology -- including adding additional codes to disease-specific ValueSets or creating a new disease-specific ValueSet -- to the [smart/health-cards Zulip stream at chat.fhir.org](https://chat.fhir.org/#narrow/stream/284830-smart.2Fhealth-cards) (free account required).

#### Identifying vaccine manufacturer

Issuers SHOULD NOT include vaccine manufacturer separately from `vaccineCode` in SMART Health Cards unless they (1) their is a jurisdictional requirement to do so; or (2) there is a downstream workflow that requires manufacturer information beyond what can be represented in `vaccineCode` using CVX, ICD-11 MMS, or SNOMED CT.

If an Issuer does need to include a vaccine's manufacturer separately from `vaccineCode`, it should be done using `Immunization.manufactuer.identifier`:

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

If `manufactuer.identifier` is populated, it SHALL NOT conflict with any value in `vaccineCode`.

Verifiers MAY choose to ignore `manufactuer.identifer`, and there is no expectation that Verifiers will process or interpret this data element.

Note manufacturer and lot number may be recorded together in other vaccine records. For SMART Health Cards, manufacturer SHALL NOT appear in the `lotNumber` element; instead, Issuers SHALL apply the above conformance criteria to determine if and how manufacturer should be included in the SMART Health Card.

#### Conformance for `status` and `statusReason`

The `status` element indicates if a given Immunization resource represents a completed vaccination, or if the vaccination was not completed for some reason.

Issuers SHALL only produce resources conforming to this profile IF the immunization event was performed AND warrants the `status` being valued `completed`. This requirement is reflected in the profile by fixing the value of `status` to `completed`. Note that `status` is required rather than being omitted entirely due to inheriting `1..1` cardinality from the [Immunization](http://hl7.org/fhir/R4/immunization.html) resource, along with an `Is-Modifier` flag. The profiles of Immunization in this IG add the `MustSupport` flag indicating Verifiers SHALL meaningfully process this element as described on the [Conformance](conformance.html) page, which is important in case a non-conforming resource is provided that has `status` set to a value other than `completed`.

The `statusReason` element is disallowed (`0..0` cardinality) because it is not meaningful when `status` is `completed`.

#### Why `protocolApplied` is not allowed

The `protocolApplied` element is set to `0..0` cardinality because it reflects the provider's intent, rather than being an authoritative source of information about the dose number and number of doses in the series. Including this element could lead to confusion with verifiers who do not recognize this distinction.

Instead, verifiers should use the presence and timestamps of multiple doses along with `vaccineCode` to make their own determination about whether or not an Immunization resource represents a valid dose of the vaccine and, if applicable, completion of a series.

[binding]: http://hl7.org/fhir/R4/valueset-binding-strength.html
[Moderna COVID-19 vaccination]: https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=e0651c7a-2fe2-459d-a766-0d59e919f058
