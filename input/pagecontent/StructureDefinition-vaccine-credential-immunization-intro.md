### Usage

#### Identifying vaccines

`Immunization.vaccineCode` uses the "Other, specify" pattern to provide flexibility for representing vaccinations that are not part of the published [CVX value set](http://hl7.org/fhir/sid/cvx). `Immunization.vaccineCode` has a required binding to [VaccineCredentialCVXValueSet], which includes all CVX codes plus an additional `OtherCode#OtherVaccine` code.

Implementers MUST use a valid CVX code if one is available in the published value set.

If one is not available, implementers MAY set `Immunization.vaccineCode.coding.code` to `OtherVaccine`, `Immunization.vaccineCode.coding.display` to `Other vaccine without published CVX`, and `Immunization.vaccineCode.text` to some string describing the vaccine. [Here is an example of a resource employing this approach.](Immunization-ExampleImmunizationNoCVX.html)

#### Why `protocolApplied` is not allowed

The `protocolApplied` element is set to `0..0` cardinality because it reflects the provider's intent, rather than being an authoritative source of information about the dose number and number of doses in the series. Including this element could lead to confusion with verifiers who do not recognize this distinction.

Instead, verifiers should use the presence and timestamps of multiple doses along with `vaccineCode` to make their own determination about whether or not an Immunization resource represents a valid dose of the vaccine and, if applicable, completion of a series.

{% include markdown-link-references.md %}
