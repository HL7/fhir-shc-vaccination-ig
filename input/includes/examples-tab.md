<script>
document.addEventListener("DOMContentLoaded", function() {
  $('<li><a href="{{  page.path | replace: '-dm.html', '.html' | replace: '-ad.html', '.html' | replace: '.html', '-resource-examples.html' }}">Examples</a></li>').insertAfter('.nav-tabs li.active');
});
</script>