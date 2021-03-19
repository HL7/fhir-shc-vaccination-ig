This specification uses the conformance verbs SHALL, SHOULD, and MAY as defined in [RFC 2119].

### MustSupport interpretation

[Elements in FHIR can be labeled as `MustSupport`](https://www.hl7.org/fhir/conformance-rules.html#mustSupport), denoted in profiles by this symbol: <span style="padding-left: 3px; padding-right: 3px; color: white; background-color: red;" >S</span>.

**`MustSupport` does not mean an element is required.** Required elements are those with a minimum cardinality of 1 or greater.

Instead, `MustSupport` indicates implementers ["SHALL provide 'support' for the element in some meaningful way"](https://www.hl7.org/fhir/conformance-rules.html#mustSupport).

In this Implementation Guide, "support in some meaningful way" is defined as follows:

- **Issuers:**

    1. Issuers SHALL populate any elements marked as `MustSupport` **if and only if the necessary data are available in their system**. See [Missing data](#missing-data) below for details.

    1. Issuers SHOULD NOT populate any elements that are not marked as `MustSupport` unless they believe the element contains valuable information for Verifiers. This is due to the payload size constraints of SMART Health Cards; see the [Data minimization](#data-minimization) section below for more details on how to reduce payload size when implementing. To avoid contradicting cardinality, all required elements (minimum cardinality > 0) are therefore also labeled as `MustSupport`.

- **Verifiers:**

    1. Verifiers SHALL read and meaningfully process elements marked BOTH as `MustSupport` and `Is-Modifier`. Note that `Is-Modifier` elements [by definition](https://www.hl7.org/fhir/conformance-rules.html#isModifier) **cannot be safely ignored** as they may change the meaning of the resource.

    1. For other elements flagged with `MustSupport`, Verifiers MAY process at their own discretion.

### Missing data

- If an Issuer does not have data for a `MustSupport` data element, the data element SHALL be omitted from the resource.
- If an Issuer does not have data for a required data element (minimum cardinality > 0), the Issuer SHALL NOT produce the resource.

### Data minimization

The payload size of [SMART Health Cards is limited](https://smarthealth.cards/#health-cards-are-small), which limits the amount of data that SHOULD be included in FHIR resources that appear in SMART Health Card payloads.

To assist Issuers in producing FHIR resources that have the minimal necessary data, this IG includes **"data minimization" (DM) profiles** in addition to "allowable data" (AD) profiles. The AD profiles identify required and `MustSupport` elements (see above). The DM profiles add additional constraints on top of their AD counterparts using `0..0` cardinality.

Resources produced by issuers SHALL conform to the AD profiles, and SHOULD conform to the DM profiles UNLESS the Issuer intentionally includes additional information in the resource believed to be useful to Validators.

See the following section for information on how to validate against the DM profiles.

Additionally:

- Implementers SHOULD NOT populate `Resource.id`, `Resource.meta`, or `Resource.text` elements.

- Implementers SHOULD use `resource:0` syntax for IDs and references.
    - Implementers SHOULD populate `Bundle.entry.fullUrl` elements with short resource-scheme URIs (e.g., `{"fullUrl": "resource:0}`).
    - Implementers SHOULD populate `Reference.reference` elements with short resource-scheme URIs (e.g., `{"patient": {"reference": "Patient/resource:0"}}`) which SHALL resolve within the bundle.
    - _Note that the Bundle examples reflect this guidance for their contained resources, but the other resource-specific examples cannot because the FHIR IG Publisher requires their `id` value matches their filename._

- Implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when using any value from a value set with a `required` binding, or using specified values from a value set with an `extensible` binding.

- Likewise, implementers SHOULD NOT populate `CodeableConcept.text` or `Coding.display` when specifying codes that are fixed in profiles.

- String length should be limited; invariants are used within the IG to produce warnings when strings exceed the expected length for a `MustSupport` element (except for patient name).

- Implementers SHOULD use `YYYY-MM-DD` precision for all `dateTime` fields EXCEPT for laboratory results (described below). Greater precision will result in a warning when validating a resource.
    - Implementers SHALL use `YYYY-MM-DDThh:mm:ss+zz:zz` format for `effective[x]` dateTime elements in [Covid19LaboratoryResultObservation] and [InfectiousDiseaseLaboratoryResultObservation]. Additionally, implementers SHALL follow this conformance requirement from [FHIR R4's documentation for the dateTime type](http://hl7.org/fhir/R4/datatypes.html#dateTime):

        > If hours and minutes are specified, **a time zone SHALL be populated**. Seconds must be provided due to schema type constraints but may be zero-filled and may be ignored at receiver discretion. \[Emphasis added.\]

### Bundles

Bundles produced by Issuers SHALL validate against [VaccineCredentialBundle] or [Covid19LaboratoryBundle]/[InfectiousDiseaseLaboratoryBundle] without errors, and SHOULD validate against [VaccineCredentialBundleDM] or [Covid19LaboratoryBundleDM]/[InfectiousDiseaseLaboratoryBundleDM] without errors.

If an Issuer wishes to include both vaccination and laboratory test results in the same Bundle resource, this resource SHALL validate against both [VaccineCredentialBundle] and [VaccineCredentialLaboratoryBundle], and SHOULD validate against their DM counterparts.

### Validation

To validate a specific resource against a profile, the [FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar) can be used, where [package.tgz is downloaded from the IG](package.tgz):

```sh
# Run to get latest validator_cli.jar (~80MB)
curl -L -O https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar

# Run to get latest package from this IG to validate against
curl -L -O http://build.fhir.org/ig/dvci/vaccine-credential-ig/branches/main/package.tgz

# Run to validate; note you will need to update the paths to (1) validator_cli.jar; (2) package.tgz;
# (3) the resource you wish to validate.
#
# You will also need to specify the URI of the profile you wish to validate against. This can be found
# under "Defining URL" on any of the profile pages in this IG.
java -jar path/to/validator_cli.jar -version 4.0.1 \
-ig path/to/package.tgz \
-profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/covid19-laboratory-result-observation-dm \
path/to/resource.json
```

For convenience, here are the commands for validating bundles:

* [VaccineCredentialBundle]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/vaccine-credential-bundle \
    path/to/bundle.json
    ```

* [VaccineCredentialBundleDM]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/vaccine-credential-bundle-dm \
    path/to/bundle.json
    ```

* [Covid19LaboratoryBundle]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/covid-19-laboratory-bundle \
    path/to/bundle.json
    ```

* [InfectiousDiseaseLaboratoryBundle]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/infections-disease-laboratory-bundle \
    path/to/bundle.json
    ```

* [Covid19LaboratoryBundleDM]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/covid-19-laboratory-bundle-dm \
    path/to/bundle.json
    ```

* [InfectiousDiseaseLaboratoryBundleDM]:

    ```sh
    java -jar path/to/validator_cli.jar -version 4.0.1 \
    -ig path/to/package.tgz \
    -profile http://hl7.org/fhir/uv/smarthealthcards-vaccination/StructureDefinition/infections-disease-laboratory-bundle-dm \
    path/to/bundle.json
    ```

To test validation, use one of the example bundles: [Scenario1Bundle], [Scenario2Bundle], or [Scenario3Bundle]; click the "JSON" tab and choose "Download", and then provide the path to the downloaded file in the above command for `path/to/bundle.json`.

You can also use the online validator at <https://inferno.healthit.gov/validator/>. To use this, click "Advanced Options" and upload [package.tgz](package.tgz), then select the name of the profile you want to validate against in the dropdown.

{% include markdown-link-references.md %}
