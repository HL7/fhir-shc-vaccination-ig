{% assign basepath = page.path | replace: '-resource-examples.html', '.html' | replace: '-dm.html', '.html' | replace: '-ad.html', '.html' %}

<span class="label label-warning">Note</span> Both the [primary (data minimization)]({{basepath | replace: '.html', '-dm.html'}}) and [fallback (allowable data)]({{basepath | replace: '.html', '-ad.html'}}) versions of this profile use this same set of examples. ([More information on the two types of profiles](profiles.html#data-minimization).)

<ul>
    {% for example in site.data.examples[basepath] %}
        <li>
          <a href="{{example.url | replace: 'GIT_BRANCH_GOES_HERE', site.data['git-branch'] }}">{{example.title}}</a>
        </li>
    {% endfor %}
</ul>

<script>
document.addEventListener("DOMContentLoaded", function() {
  $('<li class="active"><a href="#">Examples</a></li>').insertAfter('.nav-tabs li:first');

});
</script>