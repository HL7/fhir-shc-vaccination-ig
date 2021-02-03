////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario2Patient
InstanceOf: VaccineCredentialPatient
Title:      "Scenario 2: Example Patient"
* identifier.use = #usual
* identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#MR "Medical Record Number"
* identifier.system = "http://hospital.example.org"
* identifier.value = "m421"
* name.family = "Anyperson"
* name.given[0] = "Jane"
* name.given[1] = "C."
* contact.telecom[0].system = #phone
* contact.telecom[0].value = "555-555-5555"
* contact.telecom[0].use = #home
* contact.telecom[1].system = #email
* contact.telecom[1].value = "jane.anyperson@example.com"
* gender = #male
* birthDate = "1961-01-20"
* address.line = "321 State St"
* address.city = "Somecity"
* address.postalCode = "12345"
* address.country = "US"
* communication.language = urn:ietf:bcp:47#en-US "English (Region=United States)"
* communication.language.text = "English"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario2Immunization1
InstanceOf: VaccineCredentialImmunization
Title:      "Scenario 2: Example Immunization 1"
* status = #completed
* vaccineCode = CVX#208 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"
* patient = Reference(Scenario2Patient)
* occurrenceDateTime = "2021-01-01T11:45:33+11:00"
* primarySource = true
* location = Reference(Scenario2Location)
* lotNumber = "Lot #0000001"
* protocolApplied.doseNumberPositiveInt = 1
* protocolApplied.seriesDosesPositiveInt = 2
* protocolApplied.targetDisease = SCT#840539006 "COVID-19"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario2Immunization2
InstanceOf: VaccineCredentialImmunization
Title:      "Scenario 2: Example Immunization 2"
* status = #completed
* vaccineCode = CVX#208 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"
* patient = Reference(Scenario2Patient)
* occurrenceDateTime = "2021-01-29T11:45:33+11:00"
* primarySource = true
* location = Reference(Scenario2Location)
* lotNumber = "Lot #0000007"
* protocolApplied.doseNumberPositiveInt = 2
* protocolApplied.seriesDosesPositiveInt = 2
* protocolApplied.targetDisease = SCT#840539006 "COVID-19"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario2Location
InstanceOf: USCoreLocation
Title:      "Scenario 2: Example Location"
* name = "ABC Pharmacy"

////////////////////////////////////////////////////////////////////////////////////////////////////

Instance:   Scenario2Bundle
InstanceOf: VaccineCredentialBundle
Title:      "Scenario 2: Example Bundle"
* entry[+].resource = Scenario2Patient
* entry[=].fullUrl = "http://example.org/fhir/Patient/Scenario2Patient"

* entry[+].resource = Scenario2Immunization1
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario2Immunization1"

* entry[+].resource = Scenario2Immunization2
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario2Immunization2"

* entry[+].resource = Scenario2Location
* entry[=].fullUrl = "http://example.org/fhir/Immunization/Scenario2Location"
