////////////////////////////////////////////////////////////////////////////////////////////////////

Instance: ExampleImmunizationNoCVX
InstanceOf: VaccineCredentialImmunization
Title: "Example: Immunization where the CVX is not known"
* status = #completed
* vaccineCode.coding[0] = OtherCode#OtherVaccine "Other vaccine without published CVX"
* vaccineCode.coding[1].system = "http://hl7.org/fhir/sid/ndc"
* vaccineCode.coding[1].code = #11111-1000-1
* vaccineCode.coding[1].display = "Acme, Inc. COVID-19 vaccine (EUA)"
* vaccineCode.text = "Acme, Inc. COVID-19 vaccine (EUA)"
* patient = Reference(Scenario1Patient)
* occurrenceDateTime = "2021-01-21"
* primarySource = true
* location = Reference(Scenario1Location)
* lotNumber = "some lot number"