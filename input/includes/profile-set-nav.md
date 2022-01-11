{% assign r = site.data.profiles[include.resourceName]  %}
<div class="well profile-set-nav" style="background-color: #fff; margin-top: 2em; width: 100%;">
    <div style="font-size: 1.2em; margin-top: -1.7em;">
      <span style="background-color: #fff; padding-left: 0.5em; padding-right: 0.5em;"><strong>{{ r.name }}:</strong> Profile Group Navigation</span>
    </div>
    <div style="margin-top: 1em;">
      <p>{{ r.description }}</p>
      {% if r.instructions %}
      <p>
        {% capture url %}{{r.instructions}}{% endcapture %}
        <span class="{% if page.path == url %}active-page{% endif %}">
          <a href="{{ r.instructions }}" class="btn btn-success">Implementation instructions</a>
          {% if page.path != url %}<span class="highlight"><strong>&#8592;</strong> Start here!</span>{% endif %}
        </span>
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
                  <td class="{% if page.path == url %}active-page{% endif %}">
                    <a href="{{ url }}" class="btn">{{ profileSet.name }}</a>
                  </td>
                  {% capture url %}StructureDefinition-{{ profileSet.slug }}-ad.html{% endcapture %}
                  <td class="{% if page.path == url %}active-page{% endif %}">
                      <a href="{{ url }}" class="btn">Fallback</a>
                  </td>
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
 /* Restyle table at the top of each profile page */
  #segment-content > div > div > div > div > table.grid:first-of-type {
    margin-top: -12px;
    margin-left: 2%;
    width: 96%;
    border: none;
    background-color: #f5f5f5;

    /* Bananas stuff you apparently have to do to get both a border and round corners on a table */
    border-left: 1px solid rgb(220, 220, 220);
    border-right: 1px solid rgb(220, 220, 220);
    border-bottom: 1px solid rgb(220, 220, 220);
    border-bottom-right-radius: 5px;
    border-bottom-left-radius: 5px !important;
    overflow: hidden;
    box-shadow: 0px 0px 1px rgb(220,220,220)
  }

  #segment-content > div > div > div > div > table.grid:first-of-type td {
    font-size: 0.8em;
  }

  /* add 10px exterior padding to table */
  #segment-content > div > div > div > div > table.grid:first-of-type tr:first-of-type td { padding-top:10px; }
  #segment-content > div > div > div > div > table.grid:first-of-type tr:last-of-type td { padding-bottom:10px; }

  /* proper width on first column */
    #segment-content > div > div > div > div > table.grid:first-of-type tr td:first-of-type {
      min-width: 10em;
  }

  /* Fix font for defining url in table */
  #segment-content > div > div > div > div > table.grid:first-of-type tr:first-of-type td:last-of-type {
    font-family: Monaco, Menlo, Consolas, "Courier New", monospace !important;
    font-size: 12px;
  }

  #segment-content > div > div > div > div > table.grid:first-of-type td {
    border: none;
    padding: 0;
  }
  #segment-content > div > div > div > div > table.grid:first-of-type td p {
    font-size: 1em;
  }
  #segment-content > div > div > div > div > table.grid:first-of-type tr td:first-of-type {
    font-weight: bold;
    text-align:  right;
    padding-right:  0.5em;
  }
  #segment-content > div > div > div > div > table.grid:first-of-type tr td p:last-of-type {
    padding-bottom:  0;
    margin-bottom:  0;
  }



  .profile-set-nav .btn {
    font-size: inherit;
    font-weight: normal;
    border: 1px solid #ccc;
    color: #333;
  }
  .profile-set-nav .btn:hover {
    background-color: #e6e6e6;
    border-color: #adadad;
  }
  .highlight {
      background-color: #fffeca;
  }
  .profile-set-nav .active-page .btn, .profile-set-nav .active-page .btn:hover {
      /* background-color: #fffeca; */
      background: #fbfbfb;
      color: #da0c23;
      -webkit-box-shadow: inset 0px 0px 5px #c1c1c1;
      -moz-box-shadow: inset 0px 0px 5px #c1c1c1;
      box-shadow: inset 0px 0px 5px #c1c1c1;
      border: 0;
      cursor: not-allowed;
  }
  .profile-set-nav .btn-success {
    color: white;
  }
  .profile-set-nav .btn-success:hover {
    background-color: #449d44;
    border-color: #398439;
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
**Note!** This is a [fallback "allowable data" (AD) profile](profiles.html#data-minimization-and-privacy). Implementers should validate against the [primary "data minimization" (DM) profile if possible]({{ page.path | replace: '-ad.html', '-dm.html' }}).
{: .alert.alert-danger }
{% endif %}

{% include markdown-link-references.md %}

{% if page.path contains "-ad.html" %}
{% include examples-tab.md %}
{% endif %}

{% if page.path contains "-dm.html" %}
{% include examples-tab.md %}
{% endif %}


<script>
    // Set tab based on the anchor in URL
    var hash = window.location.hash;
    try {
        if(hash == "#tab-diff") sessionStorage.setItem('fhir-resource-tab-index', 1);
        if(hash == "#tab-snapshot") sessionStorage.setItem('fhir-resource-tab-index', 2);
        if(hash == "#tab-ms") sessionStorage.setItem('fhir-resource-tab-index', 3);

        // Default to snapshot tab
        if(!sessionStorage.getItem('fhir-resource-tab-index')) sessionStorage.setItem('fhir-resource-tab-index', 2);
    } catch(e) { }

    // Make it so that clicking the tabs also sets the anchor in the url
    document.addEventListener("DOMContentLoaded", function() {
        $('#tabs .ui-tabs-nav li').click(function() {
            var id = $(this).children('a').attr('id');
            if(id == "ui-id-2") window.location.hash = "#tab-diff";
            if(id == "ui-id-3") window.location.hash = "#tab-snapshot";
            if(id == "ui-id-4") window.location.hash = "#tab-ms";
        })
    });

    // Make gender invariant more visible
    if(window.location.pathname.split('/').pop() == 'StructureDefinition-shc-patient-general-ad.html') {
      document.addEventListener('DOMContentLoaded', function() {
        var newPageName = window.location.pathname.split('/').pop().replace('.html', '-definitions.html');
        jQuery('#tabs span:contains("use-only-if-required-by-law")').css('color', 'red');
        // Code point 60 is the "less than sign" -- putting the character directly in caused a
        // parsing error with the IG Publisher's facility for validating HTML.
        var lessThanSign = String.fromCodePoint(60)
        var toAppend = `. For more information see here ${lessThanSign}a href="${newPageName}#Patient.gender">here${lessThanSign}/a>.`
        jQuery('#tabs span:contains("use-only-if-required-by-law")').parent().append(toAppend);
      });
    }
</script>
