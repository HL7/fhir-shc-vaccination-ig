////////////////////////////////////////////////////////////////////////////////////////////////////
Invariant:  vc-lab-1
Description: "Bundle SHOULD only include results with status final or status that is subsequent to final."
Severity:   #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant: name-invariant
Description: "Require one of the key name elements to be filled. Allows for `text` for [names that cannot be cleanly categorized into `family` or `given`](https://www.nature.com/articles/d41586-020-02761-z)."
Expression: "family.exists() or given.exists() or text.exists()"
Severity: #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   vaccine-code-invariant
Description: "CVX code should be provided if an applicable CVX code exists."
Expression:  "coding.where($this.memberOf('http://hl7.org/fhir/uv/smarthealthcards-vaccination/ValueSet/vaccine-credential-cvx-value-set').not()).exists()"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   covid19-laboratory-test-code-invariant
Description: "Code from value set should be provided if an applicable code exists."
Expression:  "coding.where($this.memberOf('http://hl7.org/fhir/uv/smarthealthcards-vaccination/ValueSet/covid19-laboratory-test-value-set').not()).exists()"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   not-specified-laboratory-test-code-invariant
Description: "Code cannot be part of a value set for a specified disease. Instead, validate against the profile specific for the disease in question."
Expression:  "$this.memberOf('http://hl7.org/fhir/uv/smarthealthcards-vaccination/ValueSet/covid19-laboratory-test-value-set').not()"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   laboratory-result-invariant
Description: "Code from value set should be provided if an applicable code exists."
Expression:  "coding.where($this.memberOf('http://hl7.org/fhir/uv/smarthealthcards-vaccination/ValueSet/laboratory-result-value-set').not()).exists()"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   date-invariant
Description: "All timestamps SHOULD be represented as Dates (YYYY-MM-DD only)."
Expression:  "$this.toString().matches('^[0-9]{4}-[0-9]{2}-[0-9]{2}$')"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   shall-be-true-if-populated-invariant
Description: "Shall be `true` if populated"
Expression:  "$this.exists().not() or $this = true"
Severity:    #error

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   should-be-under-50-chars
Description: "Length SHOULD be <50 for data minimization."
Expression:  "$this.length() < 50')"
Severity:    #warning

////////////////////////////////////////////////////////////////////////////////////////////////////

Invariant:   should-be-under-20-chars
Description: "Length SHOULD be <20 for data minimization."
Expression:  "$this.length() < 20"
Severity:    #warning