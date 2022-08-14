<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  {{ partial('_partials/head/head.swig', {}, {cache: theme.cache.enable}) }}
  <title>{% block title %}{% endblock %}</title>
</head>

<body itemscope itemtype="http://schema.org/WebPage">
  <div class="container {% block page_class %}{% endblock %}">
    <header class="header"  itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner">
        {% include '_partials/header/index.swig' %}
      </div>
    </header>
    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap clearfix">
          {% block content %}{% endblock %}
          {% block sidebar %}{% endblock %}
        </div>
      </div>
    </main>

    <footer class="footer" id="footer">
      {% include '_partials/footer/index.swig' %}
    </footer>
  </div>
  {%- if theme.pjax %}
  <div id="pjax">
    {%- endif %}
    {% include '_third-party/math/index.swig' %}
    {% include '_third-party/quicklink.swig' %}

    {{- next_inject('bodyEnd') }}
    {%- if theme.pjax %}
  </div>
  {%- endif %}
{#  {% include '_partials/mask/index.swig' %}#}
  {{ partial('_scripts/index.swig', {}, {cache: theme.cache.enable}) }}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/umi.min.js"></script>
</body>
</html>
