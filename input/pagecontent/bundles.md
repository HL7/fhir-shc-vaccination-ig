{% include profile-set-nav.md resourceName="bundles" %}

<script>
// Move Markdown TOC below navigation
var ref = document.querySelector('h4');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertBefore(el, ref);
</script>

### Usage

Issuers SHALL ensure the contents of `.vc.credentialSubject.fhirBundle` in a [SMART Health Card](https://spec.smarthealth.cards/#data-model) (or equivalent payload in another health card standard) conforms to one of the Bundle profiles listed on this page.

Holders and Verifiers SHOULD provide a user-facing notification if the FHIR payload does not conform to one of the Bundle profiles on this page. They MAY choose to not further process non-conforming payloads.
