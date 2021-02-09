////////////////////////////////////////////////////////////////////////////////////////////////////

Instance: ExampleImmunizationNoCVX
InstanceOf: VaccineCredentialImmunization
Title: "Example: Immunization where the CVX is not known"
* status = #completed
* vaccineCode.coding[+] = CatchCodeCS#OTHER-VACCINE
* vaccineCode.coding[+] = #acme-inc-covid-temporary-code "Acme, Inc. COVID-19 vaccine (EUA)"
* patient = Reference(Scenario1Patient)
* occurrenceDateTime = "2021-01-21"
* primarySource = true
* location = Reference(Scenario1Location)
* lotNumber = "some lot number"