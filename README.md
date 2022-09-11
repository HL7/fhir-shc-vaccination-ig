# _SMART Health Cards: Vaccination & Testing FHIR Implementation Guide_ -- Complete Examples

The examples in the [FHIR IG](https://github.com/HL7/fhir-shc-vaccination-ig/tree/master/input/examples) are of the FHIR resources that may be contained within a [SMART Health Card](https://smarthealth.cards/).

While these examples may be used in constructing a full SMART Health Card, doing this is beyond the scope of the FHIR IG as it is governed by the [SMART Health Cards specification](https://spec.smarthealth.cards/). Therefore, full SMART Health Card examples are not included in the published FHIR IG.

However, implementers may find it useful to have full SMART Health Cards that use the Bundle examples in the FHIR IG. These are provided here for convenience.

[This Jupyter notebook](https://github.com/dvci/health-cards-walkthrough/blob/main/SMART%20Health%20Cards.ipynb) demonstrates the process for creating a SMART Health Card from a FHIR Bundle. You can reverse this process using the [Verifier Portal](https://demo-portals.smarthealth.cards/VerifierPortal.html). (Note that the examples below will show an SSL error in the Verifier Portal for the issuer public key.)

## COVID immunization

| |File|Description|
|-|-|-|
|1|[`bundle-immunization-covid.json`](bundle-immunization-covid.json)|FHIR Bundle example copied from the IG|
|2|[`bundle-immunization-covid-jws-payload-expanded.json`](bundle-immunization-covid-jws-payload-expanded.json)|Expanded Health Card containing #1|
|3|[`bundle-immunization-covid-jws-payload-minified.json`](bundle-immunization-covid-jws-payload-minified.json)|Minified version of #2|
|4|[`bundle-immunization-covid-jws.txt`](bundle-immunization-covid-jws.txt)|Signed Health Card containing #3 ([more information](https://spec.smarthealth.cards/#health-cards-are-encoded-as-compact-serialization-json-web-signatures-jws))
|5|[`bundle-immunization-covid-qr-code-numeric-value-0.txt`](bundle-immunization-covid-qr-code-numeric-value-0.txt)|Numeric QR containing #4|
|6|[`bundle-immunization-covid-qr-code-0.png`](bundle-immunization-covid-qr-code-0.png)<br>![](https://github.com/HL7/fhir-shc-vaccination-ig/raw/master-examples/bundle-immunization-covid-qr-code-0.png)|QR code representation of #5|


## Monkeypox immunization

| |File|Description|
|-|-|-|
|1|[`bundle-immunization-monkeypox.json`](bundle-immunization-monkeypox.json)|FHIR Bundle example copied from the IG|
|2|[`bundle-immunization-monkeypox-jws-payload-expanded.json`](bundle-immunization-monkeypox-jws-payload-expanded.json)|Expanded Health Card containing #1|
|3|[`bundle-immunization-monkeypox-jws-payload-minified.json`](bundle-immunization-monkeypox-jws-payload-minified.json)|Minified version of #2|
|4|[`bundle-immunization-monkeypox-jws.txt`](bundle-immunization-monkeypox-jws.txt)|Signed Health Card containing #3 ([more information](https://spec.smarthealth.cards/#health-cards-are-encoded-as-compact-serialization-json-web-signatures-jws))
|5|[`bundle-immunization-monkeypox-qr-code-numeric-value-0.txt`](bundle-immunization-monkeypox-qr-code-numeric-value-0.txt)|Numeric QR containing #4|
|6|[`bundle-immunization-monkeypox-qr-code-0.png`](bundle-immunization-monkeypox-qr-code-0.png)<br>![](https://github.com/HL7/fhir-shc-vaccination-ig/raw/master-examples/bundle-immunization-monkeypox-qr-code-0.png)|QR code representation of #5|

## COVID lab test results

| |File|Description|
|-|-|-|
|1|[`bundle-lab-test-results-covid.json`](bundle-lab-test-results-covid.json)|FHIR Bundle example copied from the IG|
|2|[`bundle-lab-test-results-covid-jws-payload-expanded.json`](bundle-lab-test-results-covid-jws-payload-expanded.json)|Expanded Health Card containing #1|
|3|[`bundle-lab-test-results-covid-jws-payload-minified.json`](bundle-lab-test-results-covid-jws-payload-minified.json)|Minified version of #2|
|4|[`bundle-lab-test-results-covid-jws.txt`](bundle-lab-test-results-covid-jws.txt)|Signed Health Card containing #3 ([more information](https://spec.smarthealth.cards/#health-cards-are-encoded-as-compact-serialization-json-web-signatures-jws))
|5|[`bundle-lab-test-results-covid-qr-code-numeric-value-0.txt`](bundle-lab-test-results-covid-qr-code-numeric-value-0.txt)|Numeric QR containing #4|
|6|[`bundle-lab-test-results-covid-qr-code-0.png`](bundle-lab-test-results-covid-qr-code-0.png)<br>![](https://github.com/HL7/fhir-shc-vaccination-ig/raw/master-examples/bundle-lab-test-results-covid-qr-code-0.png)|QR code representation of #5|

----

Note: this is an [orphan branch](https://git-scm.com/docs/git-checkout#Documentation/git-checkout.txt---orphanltnew-branchgt), which is updated [automatically by a GitHub Action](https://github.com/HL7/fhir-shc-vaccination-ig/blob/master/.github/workflows/generate-examples.yml) whenever the examples change on the `master` branch. No version history is saved for this branch to avoid ballooning the repository size over time.

Please see the [README on the `master` branch](https://github.com/HL7/fhir-shc-vaccination-ig/tree/master) for more information about this project.
