{% include profile-set-nav.md resourceName="laboratory-results-observation" %}

### Usage

Note that `Observation.effective[x]` is the clinically relevant time/time-period, which is typically when the specimen assessed in the laboratory test was collected (as opposed to when the lab assay was performed).

Note that the `performer` element indicates the laboratory performing the test, rather than the collector of the specimen used in the test.

#### Specimen collection supervision status

The [specimen collection supervision status ValueSet][SpecimenCollectionSupervisionStatus] provides a method for identifying whether a specimen was collected by the patient with supervision, without supervision, etc. This is stored in `Observation.component`, identified by setting `Observation.component.code` to the SNOMED CT concept `1208522006` ("Type of supervision for specimen collection (observable entity)"). `Observation.component.valueCodeableConcept` is one of the codes in the [aforementioned ValueSet][SpecimenCollectionSupervisionStatus].
