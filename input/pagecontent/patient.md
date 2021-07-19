{% include profile-set-nav.md resourceName="patient" %}

<script>
// Move Markdown TOC below navigation
var ref = document.querySelector('h4');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertBefore(el, ref);
</script>

### Usage

SMART Health Cards issued in the United States SHALL NOT have `Patient.identifier` set as this could include sensitive information such as a Social Security Number or MRN. This is reflected by the `0..0` cardinality of this element in the US profiles of Patient: issuers of SMART Health Cards in the United States SHALL conform [SHCPatientUnitedStatesAD] and SHOULD conform to [SHCPatientUnitedStatesDM].

For SMART Health Cards issued in other locations, `Patient.identifier` MAY be populated IF the contents do not present a privacy risk to the patient if shared outside a clinical setting (e.g., with a Verifier such as an airline or event venue). Issuers SHALL NOT include information in `Patient.identifier` that poses a privacy risk in such contexts. Issuers of SMART Health Cards outside the United States SHALL conform [SHCPatientGeneralAD] and SHOULD conform to [SHCPatientGeneralDM].
