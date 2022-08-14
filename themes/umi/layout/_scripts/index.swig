{#{{ partial('_scripts/bootstrap.swig', {}, {cache: theme.cache.enable}) }}#}
{% include 'vendors.swig' %}
{{ umi_js('components/sidebar.js') }}
{{ umi_js('next-boot.js') }}
{%- if theme.pjax %}
  {% include 'pjax.swig' %}
{%- endif %}
