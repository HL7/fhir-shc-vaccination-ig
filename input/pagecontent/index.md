# Vaccine Yellow Card Implementation Guide \[DRAFT\]

This IG is a rough draft including the profiles and value sets needed to represent vaccination status for COVID-19.

The current goals are as follows:

1. Examine existing FHIR resources and US Core profiles to assess suitability for the Vaccine Yellow Card.
1. Initial pass at identifying elements that should be marked as Must Support and/or required.
1. Define FHIR value sets that include value sets from the [V2 Immunization Messaging IG](https://www.cdc.gov/vaccines/programs/iis/technical-guidance/downloads/hl7guide-1-5-2014-11.pdf) (PDF), with the goal of facilitating mapping from V2-formatted data to FHIR resources.
1. Identify areas where implementation will depend on developing a concrete set of use cases. For example, if the IG is mean to be used to "validate" yellow card data, some additional elements would likely be marked as required compared to if the primary goal is to maximize compatibility with existing systems. For now we have erred on the side of compatibility.

Profiles and value sets are on the [Artifacts](artifacts.html) page. Additionally, a number of `TODO` items are noted as comments in the `.fsh` files.