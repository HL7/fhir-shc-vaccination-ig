### Usage

#### Identifying laboratory tests

Implementers SHALL use the [Covid19LaboratoryTestValueSet] to identify laboratory tests if a suitable code is available in that value set, which is reflected in the required binding for this value set.

Implementers should fall back to [InfectiousDiseaseLaboratoryResultObservation] if a suitable code is not available; this fallback profile is the same as this one apart from the value set binding.

{% include markdown-link-references.md %}
