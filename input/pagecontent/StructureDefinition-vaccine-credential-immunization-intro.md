### Usage

#### Identifying vaccines

`Immunization.vaccineCode` uses the "Other, specify" pattern to provide flexibility for representing vaccinations that are not part of the published [CVX value set](http://hl7.org/fhir/sid/cvx). `Immunization.vaccineCode` has a required binding to [VaccineCredentialCVXValueSet], which includes all CVX codes plus an additional `OtherCode#OtherVaccine` code.

Implementers MUST use a valid CVX code if one is available in the published value set.

If one is not available, implementers MAY set `Immunization.vaccineCode.coding.code` to `OtherVaccine`, `Immunization.vaccineCode.coding.display` to `Other vaccine without published CVX`, and `Immunization.vaccineCode.text` to some string describing the vaccine. [Here is an example of a resource employing this approach.](Immunization-ExampleImmunizationNoCVX.html)

#### Identifying target disease

Implementers MUST populate `Immunization.protocolApplied.targetDisease` to indicate which disease the vaccine is targeting.

{% include markdown-link-references.md %}