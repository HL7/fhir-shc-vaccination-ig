RuleSet: id-should-not-be-populated(path)
* {path}id ^short = "Should not be populated"
* {path}id ^definition = "For [data minimization reasons](profiles.html#data-minimization-and-privacy), this element SHOULD NOT be populated when generating a resource conforming to this profile for inclusion in one of the Bundles profiled in this IG."
* {path}id ^comment = "Not including `id` may result in FHIR validation errors of resources. These errors can be ignored for the purposes of assessing conformance to this IG."

RuleSet: reference-to-absolute-uri(path)
* {path}.reference ^short = "This SHOULD use an absolute URI like `resource:0` that will resolve within the containing Bundle."
* {path}.reference 1..1
* {path}.type 0..0
* {path}.identifier 0..0
* {path}.display 0..0

RuleSet: reference-to-ad-profile-comment(element)
* {element} ^comment = "Note that this is a reference to the Fallback Profile (`SHCPatientGeneralAD`) rather than the Primary Profile.

This is because in some cases, implementers may be able to use the Primary Profile for this resource, but need the Fallback Profile for the Patient resource.

Resource instances that conform to the Primary Profile of Patient will **also** conform to the Fallback Profile of Patient. Implementers SHALL use the Primary Profile of Patient whenever possible. For more information see the [Profiles](profiles.html) page."