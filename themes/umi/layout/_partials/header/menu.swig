{% import 'menu-item.swig' as menu_item %}

<nav class="site-nav">
  {% if theme.menu %}
    <ul id="menu" class="main-menu menu">
{#      {% for name, path in theme.menu %}#}
{#        {% set respath = path %}#}
{#        {% if path == '[object Object]' %}#}
{#          #}{# Main Menu (default menu item for Submenu) #}
{#          {% for subname, subpath in path %}#}
{#            {% set itemName = subname | lower %}#}
{#            {% set respath = subpath %}#}
{#            {% if itemName == 'default' %}#}
{#              {% set itemName = name | lower %}#}
{#              {{ menu_item.render(name, itemName, respath) }}#}
{#            {% endif %}#}
{#          {% endfor %}#}
{#        {% else %}#}
{#          #}{# Main Menu (standard menu items) #}
{#          {% set itemName = name | lower %}#}
{#          {{ menu_item.render(name, itemName, respath) | trim }}#}
{#        {% endif %}#}
{#      {% endfor %}#}
      {% for name, path in theme.menu %}
        {% set itemName = name.toLowerCase() %}
        <li class="menu-item menu-item-{{ itemName | replace(' ', '-') }}">
          <a href="{{ url_for(trim(path.split('||')[0])) }}" rel="section"{% if path.split('||')[2] %} target="_blank"{% endif %}>
            <i class="menu-item-icon {{ trim(path.split('||')[1]) }}"></i>
            {{ __('menu.' + name) | replace('menu.', '') }}
          </a>
          {% if theme.submenu[itemName] %}
            <ul class="submenu submenu-{{ itemName | replace(' ', '-') }}">
              {% for name, path in theme.submenu[itemName] %}
                {% set itemName = name.toLowerCase() %}
                <li class="submenu-item submenu-item-{{ itemName | replace(' ', '-') }}">
                  <a href="{{ trim(url_for(path)) }}" rel="section" target="_blank">
                    {{ __('menu.' + name) | replace('menu.', '') }}
                  </a>
                </li>
              {% endfor %}
            </ul>
          {% endif %}
        </li>
      {% endfor %}

      {% if hasSearch %}
        <li class="menu-item menu-item-search">
          {% if theme.swiftype_key %}
          <a href="javascript:;" class="st-search-show-outputs">
            {% elseif theme.local_search.enable || theme.algolia_search.enable %}
            <a href="javascript:;" class="popup-trigger">
              {% endif %}
              {% if theme.menu_icons.enable %}
                <i class="menu-item-icon fa fa-search fa-fw"></i> <br />
              {% endif %}
              {{ __('menu.search') }}
            </a>
        </li>
      {% endif %}
{#      <li class="menu-item search">#}
{#        <form class="search-form">#}
{#          <input name="keyword" type="text" class="search-input" placeholder="站内搜索">#}
{#          <button type="submit" class="search-submit"><i class="fas fa-search"></i></button>#}
{#        </form>#}
{#      </li>#}
    </ul>
    {% if hasSearch %}
    <div class="search">
      <i class="fa fa-search"></i>
    </div>
    {% endif %}
  {%- endif %}
</nav>
