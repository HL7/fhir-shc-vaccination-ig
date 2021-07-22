document.addEventListener("DOMContentLoaded", function() {
    // Fixes "&amp;" rendered in the publish box
    // Remove when this is resolved: https://github.com/HL7/fhir-ig-publisher/issues/299
    if(document.getElementById('xpublish-box')) {
        document.getElementById('xpublish-box').textContent = document.getElementById('xpublish-box').textContent.replace('&amp;', '&');
    }
});