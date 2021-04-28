### Usage

#### Identifying vaccines

The `vaccineCode` element has two different slices, which are used to identify vaccines:

1. `vaccineCode.coding[vaccine]` identifies the disease(s) targeted (e.g., COVID-19) and type of vaccine (e.g., mRNA) at a minimum. Valid codes are defined in [VaccinationCredentialVaccineValueSet], and currently include only [CVX codes](https://www2a.cdc.gov/vaccines/iis/iisstandards/vaccines.asp?rpt=cvx) but will be expanded in the future to include similar codes from other code systems. For example, `CVX#208` is `COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose` and `CVX#197` is `influenza, high-dose, quadrivalent`. This slice is required.
1. `vaccineCode.coding[vaccineManufacturer]` identifies the manufacturer of the vaccine. Valid codes are defined in [VaccinationCredentialVaccineManufacturerValueSet]. This slice is not required, but SHOULD be populated if the necessary data are available to the Issuer.

Additional slices may be defined in the future if necessary to identify specific boosters for COVID-19 vaccinations.

When vaccine and manufacturer are provided using US-centric terminology (CVX and MVX, respectively) for COVID-19 vaccinations, CDC [provides a list](https://www.cdc.gov/vaccines/programs/iis/COVID-19-related-codes.html) that includes "Sale Proprietary Name" (e.g., `Moderna COVID-19 Vaccine`). The "Sale Proprietary Name" or other trade name SHALL NOT be included in FHIR resources, but MAY be used by Issuers when producing human-readable representations of these resources.

#### Conformance for `status` and `statusReason`

The `status` element indicates if a given Immunization resource represents a completed vaccination, or if the vaccination was not completed for some reason.

Issuers SHALL only produce resources conforming to this profile IF `status` has the value `completed`, which is reflected in the profile by fixing the value of `status` to `completed`. Note that `status` is required rather than being omitted entirely due to inheriting `1..1` cardinality from the [Immunization](http://hl7.org/fhir/R4/immunization.html) resource, along with an `Is-Modifier` flag. This profile adds the `MustSupport` flag indicating Verifiers SHALL meaningfully process this element as described on the [Conformance](conformance.html) page, which is important in case a non-conforming resource is provided that has `status` set to a value other than `completed`.

The `statusReason` element is disallowed (`0..0` cardinality) because it is not meaningful when `status` is `completed`.

#### Why `protocolApplied` is not allowed

The `protocolApplied` element is set to `0..0` cardinality because it reflects the provider's intent, rather than being an authoritative source of information about the dose number and number of doses in the series. Including this element could lead to confusion with verifiers who do not recognize this distinction.

Instead, verifiers should use the presence and timestamps of multiple doses along with `vaccineCode` to make their own determination about whether or not an Immunization resource represents a valid dose of the vaccine and, if applicable, completion of a series.

{% include ad-profile.md %}