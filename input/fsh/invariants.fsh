////////////////////////////////////////////////////////////////////////////////////////////////////
Invariant:  vc-bundle-lab-status-complete
Description: "Bundle SHALL only include results with status final or status that is subsequent to final."
Expression:  "$this.resource.ofType(Observation).status.lower() in ('final'|'amended'|'corrected')"
Severity:   #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant: vc-name-invariant
Description: "Require one of the key name elements to be filled. Allows for `text` for names that cannot be cleanly categorized into `family` or `given` (https://www.nature.com/articles/d41586-020-02761-z)."
Expression: "(family.exists() or given.exists()) xor text.exists()"
Severity: #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-shall-not-be-a-covid-loinc
Description: "This profile SHALL NOT be used to report results from COVID lab tests (https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1114.9/expansion). Use Covid19LaboratoryResultObservation instead."
Expression:  "$this.coding.memberOf('http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1114.9').not()"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-date-invariant
Description: "All timestamps SHOULD be represented as Dates (YYYY-MM-DD only)."
Expression:  "$this.toString().matches('^[0-9]{4}-[0-9]{2}-[0-9]{2}$')"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-shall-be-true-if-populated-invariant
Description: "Shall be `true` if populated"
Expression:  "$this.exists().not() or $this = true"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-under-50-chars
Description: "Length SHOULD be <50 for data minimization."
Expression:  "$this.length() < 50"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-under-40-chars
Description: "Length SHOULD be <40 for data minimization."
Expression:  "$this.length() < 40"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-under-30-chars
Description: "Length SHOULD be <30 for data minimization."
Expression:  "$this.length() < 30"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-under-20-chars
Description: "Length SHOULD be <20 for data minimization."
Expression:  "$this.length() < 20"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-omitted
Description: "SHOULD be omitted for data minimization."
Expression:  "$this.length() = 0"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-be-omitted-privacy
Description: "SHOULD be omitted to protect privacy and for data minimization."
Expression:  "$this.length() = 0"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-shall-be-resource-uri
Description: "IDs SHALL use resource:# format"
Expression:  "$this.matches('^resource:[0-9]+$')"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-should-not-include-string-lot
Description: "lotNumber SHOULD NOT include `Lot #`, `Lot Number`, etc."
Expression:  "$this.lower().contains('lot').not()"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-observation-status-shall-be-complete
Description: "SHALL be `final`, `amended`, or `corrected`"
Expression:  "$this.lower() in ('final'|'amended'|'corrected')"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-observation-quantity-should-have-range
Description: "Quantitative lab results SHOULD include reference range"
Expression:  "%resource.referenceRange.exists()"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant: shall-use-known-vaccine-manufacturer-code-system
Description: "SHALL use a known code system for identifying vaccine manufacturers"
Expression: "$this.matches('http://hl7.org/fhir/sid/mvx') or $this.matches('https://www.gs1.org/gln')"
Severity: #error
// Keep list of manufacturer code systems in sync with the intro text for our Immunization profiles

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vc-observation-range-only-quantity-or-string
Description: "Reference range SHOULD be included for quantitative lab results, MAY be included for free text (string) results, and SHOULD NOT be included otherwise"
Expression:  "$this.exists() and (%resource.value.ofType(Quantity).exists() or %resource.value.ofType(String).exists())"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////
