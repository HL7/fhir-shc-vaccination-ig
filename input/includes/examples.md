{% assign basepath = page.path | replace: '-resource-examples.html', '.html' | replace: '-dm.html', '.html' %}

<span class="label label-warning">Note</span> Both the [allowable data]({{basepath}}) and [data minimization]({{basepath | replace: '.html', '-dm.html'}}) versions of this profile use this same set of examples. ([More information on the two types of profiles](conformance.html#data-minimization).)

<table style="grid">
  <tbody>
    {% for example in site.data.examples[basepath] %}
      <tr>
        <td>
          <a href="{{example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch'] }}">{{example.title}}</a>
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>

<script>
document.addEventListener("DOMContentLoaded", function() {
  $('<li class="active"><a href="#">Examples</a></li>').insertAfter('.nav-tabs li:first');

  // Get rid of "no examples for profile"
  $('.container .col-12 p:last').hide()
});
</script>