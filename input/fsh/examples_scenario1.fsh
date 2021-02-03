////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario1Patient
InstanceOf: VaccineCredentialPatient
Title:      "Scenario 1: Example Patient"
* name.family = "Anyperson"
* name.given[0] = "John"
* name.given[1] = "B."
* contact.telecom[0].system = #phone
* contact.telecom[0].value = "555-555-5555"
* contact.telecom[0].use = #home
* contact.telecom[1].system = #email
* contact.telecom[1].value = "john.anyperson@example.com"
* gender = #male
* birthDate = "1951-01-20"
* address.line = "123 Main St"
* address.city = "Anytown"
* address.postalCode = "12345"
* address.country = "US"
* communication.language = urn:ietf:bcp:47#en-US "English (Region=United States)"
* communication.language.text = "English"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario1Immunization1
InstanceOf: VaccineCredentialImmunization
Title:      "Scenario 1: Example Immunization 1"
* status = #completed
* vaccineCode = CVX#207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose"
* patient = Reference(Scenario1Patient)
* occurrenceDateTime = "2021-01-01T11:45:33+11:00"
* primarySource = true
* location = Reference(Scenario1Location)
* lotNumber = "Lot #0000001"
* protocolApplied.doseNumberPositiveInt = 1
* protocolApplied.seriesDosesPositiveInt = 2
* protocolApplied.targetDisease = SCT#840539006 "COVID-19"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario1Immunization2
InstanceOf: VaccineCredentialImmunization
Title:      "Scenario 1: Example Immunization 2"
* status = #completed
* vaccineCode = CVX#207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose"
* patient = Reference(Scenario1Patient)
* occurrenceDateTime = "2021-01-29T11:45:33+11:00"
* primarySource = true
* location = Reference(Scenario1Location)
* lotNumber = "Lot #0000007"
* protocolApplied.doseNumberPositiveInt = 2
* protocolApplied.seriesDosesPositiveInt = 2
* protocolApplied.targetDisease = SCT#840539006 "COVID-19"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario1Location
InstanceOf: USCoreLocation
Title:      "Scenario 1: Example Location"
* name = "ABC Pharmacy"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario1Bundle
InstanceOf: VaccineCredentialBundle
Title:      "Scenario 1: Example Bundle"
* entry[+].resource = Scenario1Patient
* entry[=].fullUrl = "http://example.org/fhir/Patient/Scenario1Patient"

* entry[+].resource = Scenario1Immunization1
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario1Immunization1"

* entry[+].resource = Scenario1Immunization2
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario1Immunization2"

* entry[+].resource = Scenario1Location
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario1Location"
