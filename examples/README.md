# Example resources

Examples are typically generated within a FHIR Implementation Guide. However, the [FHIR Publisher](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation) responsible for building Implementation Guides places additional requirements on examples that are incompatible with this IG's [data minimization criteria](http://build.fhir.org/ig/dvci/vaccine-credential-ig/branches/main/conformance.html#data-minimization), such as requiring `id` elements and not recognizing absolute URIs like `resource:0` for within-Bundle resolution.

Until these issues with the IG Publisher are resolved, we are storing our example resources in this folder outside the IG build process, and linking from the IG to these files on GitHub.

# Generate examples

Examples of SMART Health Cards generated from this Implementation Guide are generate via Ruby script generate-examples.rb.

    gem install health_cards
    ruby generate-examples.rb