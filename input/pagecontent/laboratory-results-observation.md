{% include profile-set-nav.md resourceName="laboratory-results-observation" %}

<script>
// Move Markdown TOC below navigation
var ref = document.querySelector('h4');
var el = document.querySelector('div.markdown-toc');
ref.parentNode.insertBefore(el, ref);
</script>

### Usage

Note that the `performer` element indicates the laboratory performing the test, rather than the collector of the specimen used in the test.

Currently this IG does not support identifying how a specimen was collected (e.g., self-collected vs. collected by a healthcare worker). Please [contact us](contact.html) if you have a use case that necessitates capturing this information.