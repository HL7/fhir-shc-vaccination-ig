# Example resources

Examples are typically generated within a FHIR Implementation Guide. However, the [FHIR Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) responsible for building Implementation Guides places additional requirements on examples that are incompatible with this IG's [data minimization criteria](http://build.fhir.org/ig/dvci/vaccine-credential-ig/branches/main/conformance.html#data-minimization), such as requiring `id` elements and not recognizing absolute URIs like `resource:0` for within-Bundle resolution.

Until these issues with the IG Publisher are resolved, we are storing our example resources in this folder outside the IG build process, and linking from the IG to these files on GitHub.

## Scenarios:
 - `Scenario1Bundle.json` is a patient who received two doses of Moderna vaccine, reported via CVX
 - `Scenario2Bundle.json` is a patient who received two doses of Pfizer vaccine, reported via CVX
 - `Scenario3Bundle.json` is a patient who tested positive on COVID19 antigen rapid immunoassay test

## Examples for various code systems

See `byCodeSystems` folder.

| file                       | description                                      |
|:--------------------------:|:-------------------------------------------------|
| `air_immunization`         | Patient received one dose of AstraZeneca vaccine |
| `atc_immunization`         | Patient received one dose of Janssen vaccine, manufacturer specified by MVX     |
| `atc_gtin_immunization`    | Patient received one dose of Janssen vaccine, specified by ATC and GTIN systems |
| `cvx_immunization`         | Patient received two doses of an unspecified vaccine, presumably (but not necessarily) from China, Russia, or another foriegn country |
| `gtin_immunization`        | Patient received two doses of Moderna vaccine    |
| `icd11_immunization`       | Patient received two doses of Pfizer vaccine, manufacturer specified by MVX     |
| `icd11_gtin_immunization`  | Patient received two doses of Moderna vaccine, specified by ICD-11 and GTIN     |
| `snomed_immunization`      | Patient received two doses of Pfizer vaccine, manufacturer specified by GLN     |
| `snomed_gtin_immunization` | Patient recieved two doses of Moderna vaccine, manufacturer specified by SNOMED and GTIN |


## Validation notes:
`Scenario3Bundle.json` validation was moved from `tests.csv` to `tests_errors.csv`, and all examples in `examples/byCodeSystems` (besides CVX and SNOMED) are also placed in `tests_errors.csv`. This
is because these examples rely on intensional ValueSets that point to inactive terminology servers, so automated testing raises Code Invalid errors. The codes in `examples/byCodeSystem` were 
manually checked to be correct against human documentation and the files ran successfully on Inferno except for the Invalid Code errors. Before rolling out a stable release we should move this
validation to `tests.csv` and make sure the terminology servers are pointed to properly. (CVX and SNOMED terminology servers seem to work and the codes pass in `tests.csv`).

Also note the `tests_errors.csv` and testing implementation only tests for one error per file, so only one error has been specified. However the examples with two doses actually raise the
error twice, and examples that specify multiple code systems (i.e: ICD-11 and GTIN) raise more Invalid Code errors. 
