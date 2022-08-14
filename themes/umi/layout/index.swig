{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template %}
{% import '_macro/post.swig' as post_template %}

{% block title %}
  {{ title }}
  {%- if theme.index_with_subtitle and subtitle %}
    - {{ subtitle }}
  {%- endif %}
{% endblock %}

{% block page_class %}
  {% if is_home() %}page-home{% endif -%}
{% endblock %}

{% block content %}
  <section id="posts" class="posts-expand">
    {% for post in page.posts.toArray() %}
      {{ post_template.render(post, true) }}
    {% endfor %}
  </section>

  {% include '_partials/pagination.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
