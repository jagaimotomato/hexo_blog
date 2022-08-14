{% set js_vendors = {} %}

{%- if theme.pjax %}
  {%- set js_vendors.pjax = 'pjax/pjax.min.js' %}
{%- endif %}

{%- if theme.mediumzoom %}
  {%- set js_vendors.mediumzoom = '//cdn.jsdelivr.net/npm/medium-zoom@1/dist/medium-zoom.min.js' %}
{%- endif %}

{%- if theme.lazyload %}
  {%- set js_vendors.lazyload = '//cdn.jsdelivr.net/npm/lozad@1/dist/lozad.min.js' %}
{%- endif %}


{%- if theme.motion.enable %}
  {%- set js_vendors.velocity = 'velocity/velocity.min.js' %}
  {%- set js_vendors.velocity_ui = 'velocity/velocity.ui.min.js' %}
{%- endif %}

{%- for name, internal in js_vendors %}
  {%- set internal_script = umi_vendors(internal) %}
  <script src="{{ theme.vendors[name] or internal_script }}"></script>
{%- endfor %}
