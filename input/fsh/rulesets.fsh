RuleSet: id-should-not-be-populated(path)
* {path}id ^short = "Should not be populated"
* {path}id ^definition = "For [data minimization reasons](conformance.html#data-minimization), this element SHOULD NOT be populated when generating a resource conforming to this profile for inclusion in one of the Bundles profiled in this IG."
* {path}id ^comment = "Not including `id` may result in FHIR validation errors of resources. These errors can be ignored for the purposes of assessing conformance to this IG."

RuleSet: reference-to-absolute-uri(path)
* {path} ^comment = "This SHOULD use an absolute URI like `reference:0` that will resolve within the containing Bundle."