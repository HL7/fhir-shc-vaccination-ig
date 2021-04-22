### Usage

#### Identifying laboratory tests

Implementers SHALL use [a COVID-19-specific LOINC](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1114.9/expansion) to identify a COVID-19-related laboratory tests if a suitable code is available in that value set, which is reflected in the required binding for this value set.

Implementers should fall back to [InfectiousDiseaseLaboratoryResultObservation] if a suitable code is not available; this fallback profile is the same as this one apart from the value set binding.

{% include ad-profile.md %}