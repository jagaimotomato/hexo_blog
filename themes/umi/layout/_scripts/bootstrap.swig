{%
  set boot_scripts = [
  'bootstrap.js'
]
%}

{% for bs in boot_scripts %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/{{ bs }}"></script>
{% endfor %}
