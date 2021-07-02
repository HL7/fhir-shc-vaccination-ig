{% assign r = site.data.profiles[include.resourceName]  %}
<div class="well profile-set-nav" style="background-color: #fff; margin-top: 2em; width: 100%;">
    <div style="font-size: 1.2em; margin-top: -1.7em;">
      <span style="background-color: #fff; padding-left: 0.5em; padding-right: 0.5em;"><strong>{{ r.name }}:</strong> Profile Group Navigation</span>
    </div>
    <div style="margin-top: 1em;">
      <p>{{ r.description }} The current page is <span class="active-page-example">highlighted</span> below.</p>
      {% if r.instructions %}
      {% capture url %}{{r.instructions}}{% endcapture %}
      <p class="{% if page.path == url %}active-page{% endif %}"><span class="label label-success">Start here!</span>
        <a href="{{ r.instructions }}">Implementation instructions for {{ r.name }}</a>
      </p>
      {% endif %}
      <table class="table">
          <thead>
              <tr>
                  <th>Primary profile (DM)</th>
                  <th>Fallback Profiles (AD)</th>
                  <th>Scope</th>
              </tr>
          </thead>
          <tbody>
              {% for profileSet in r.profileSets %}
              <tr>
                  {% capture url %}StructureDefinition-{{ profileSet.slug }}-dm.html{% endcapture %}
                  <td class="{% if page.path == url %}active-page{% endif %}"><a href="{{ url }}">{{ profileSet.name }}</a></td>
                  {% capture url %}StructureDefinition-{{ profileSet.slug }}-ad.html{% endcapture %}
                  <td class="{% if page.path == url %}active-page{% endif %}"><a href="{{ url }}">Fallback</a></td>
                  <td>{{ profileSet.scope }}</td>
              </tr>
              {% endfor %}
          </tbody>
      </table>

      <div style="font-size: 0.8em;">
        For more information about the types of profiles in this IG, see <a href="profiles.html">the profiles page</a>.
      </div>
    </div>
</div>

<style>
  /* Hide top table on the profile pages */
  #segment-content > div > div > div > div > table.grid:first-of-type {
    display: none;
  }
  .active-page a, .active-page-example {
      background-color: #fffeca;
  }
</style>

<script>
  // If parent is inline-block, switch to inline. This will make the nav table always take up 100% width
  var parent = document.querySelector('.profile-set-nav').parentElement;
  if(parent.style.display == "inline-block") {
    parent.style.display = "inline";
  }
</script>

{% if page.path contains "-ad.html" %}
<div class="alert alert-danger" role="alert" markdown="1">
  **Note!** This is a fallback ["allowable data" profile](profiles.html#data-minimization). Implementers should validate against the ["data minimization" profile if possible]({{ page.path | replace: '-ad.html', '-dm.html' }}).
</div>
{% endif %}

{% include markdown-link-references.md %}

{% if page.path contains "-ad.html" %}
{% include examples-tab.md %}
{% endif %}

{% if page.path contains "-dm.html" %}
{% include examples-tab.md %}
{% endif %}