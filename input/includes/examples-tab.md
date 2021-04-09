<script>
document.addEventListener("DOMContentLoaded", function() {
  $('<li><a href="{{  page.path | replace: '-dm.html', '.html' | replace: '.html', '-examples.html' }}">Examples</a></li>').insertAfter('.nav-tabs li.active');
});
</script>