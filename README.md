# SMART Health Cards Vaccination and Testing FHIR Implementation Guide

CI build of this IG available at <http://build.fhir.org/ig/HL7/fhir-shc-vaccination-ig>.

## Building

The IG can be built by running `./_genonce.sh` on Mac/Linux, or `_genonce.bat` on Windows.

Building requires downloading the [IG Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) to `input-cache/publisher.jar`. This can be done by running `./_updatePublisher.sh` on Mac/Linux or `_updatePublisher.bat` on Windows, or by [downloading it from here](https://github.com/HL7/fhir-ig-publisher/releases). You will also [need the Jekyll dependency](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation#IGPublisherDocumentation-Installing).

## Tests

Shell

    ./mvnw test

Windows

    ./mvnw.cmd test

Assumes Sushi and Java JDK are pre-installed. Will run Sushi to generate files in /fsh-generated.

Test output is in target/validator.log and target/surefire-reports.

Test cases are defined in src/test/resources.
<ol>
<li>tests.csv: list of json resource files and profiles that they should validate against without errors. Test case will fail if there are any validation issues of severity error (warning and information severity will pass).</li>
<li>tests_errors.csv: used for test cases that should result in validator issues. It contains a list of json resource files and the profiles that they should validate against, along with expected issue severity, location, or message fragment. Test case will fail if there is no matching validation issue. Expected columns are optional. If all are left blank, then any validator issue will match.</li>
</ol>

## Contributing

Pull requests are welcome! Please see [CONTRIBUTING.md](https://github.com/HL7/fhir-shc-vaccination-ig/blob/master/CONTRIBUTING.md) for details.

## License

Copyright 2021 The MITRE Corporation

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
```
http://www.apache.org/licenses/LICENSE-2.0
```
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

## Code of Conduct

Everyone interacting in the this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow this [code of conduct](https://github.com/dvci/health_cards/blob/master/CODE_OF_CONDUCT.md).