{% macro render(post, is_index, post_extra_class) %}

  {% set headlessPost = Array.prototype.indexOf.call(['quote', 'picture'], post.type) > -1 %}

  {% set post_class = 'post post-type-' + post.type | default('normal') %}
  {% if post_extra_class > 0 %}
    {% set post_class = post_class + ' ' + post_extra_class | default('') %}
  {% endif %}
  {% if post.sticky > 0 %}
    {% set post_class = post_class + ' ' + 'post-sticky' %}
  {% endif %}

  <article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">
    {##################}
    {### POST BLOCK ###}
    {##################}
    <div class="post-date">
      <div class="post-month">{{ date(post.date, 'MM') }}月</div>
      <div class="post-day">{{ date(post.date, 'DD') }}</div>
    </div>

    <div class="post-block">
      <link itemprop="mainEntityOfPage" href="{{ config.url }}{{ url_for(post.path) }}">
      <span hidden itemprop="author" itemscope itemtype="http://schema.org/Person">
      <meta itemprop="name" content="{{ theme.author }}">
      <meta itemprop="description" content="{{ theme.signature }}">
      <meta itemprop="image" content="{{ url_for( theme.avatar | default(theme.images + '/avatar.gif') ) }}">
    </span>

      <span hidden itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
      <meta itemprop="name" content="{{ config.title }}">
    </span>

      {% if not headlessPost %}
      <header class="post-header">

        {# Not to show title for quote posts that do not have a title #}
        {% if not (is_index and post.type === 'quote' and not post.title) %}
        <{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title{% if post.direction && post.direction.toLowerCase() === 'rtl' %} rtl{% endif %}" itemprop="name headline">{#
          #}{# Link posts #}{#
          #}{% if post.link %}
            {% if post.sticky > 0 %}
              {{ post.sticky }}
              <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                  <i class="fa fa-thumb-tack"></i>
                </span>
            {% endif %}
            <a class="post-title-link post-title-link-external" target="_blank" href="{{ url_for(post.link) }}" itemprop="url">
              {{ post.title or post.link }}
              <i class="fa fa-external-link"></i>
            </a>
          {% else %}{#
          #}{% if is_index %}
            {% if post.sticky > 0 %}
              <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                    <i class="fa fa-thumb-tack"></i>
                  </span>
            {% endif %}
            <a class="post-title-link scaleup" href="{{ url_for(post.path) }}" itemprop="url">{#
            #}{{ post.title | default(__('post.untitled'))}}{#
            #}</a>{#
            #}{% else %}{{ post.title }}{% endif %}{#
          #}{% endif %}{#
          #}</{% if theme.seo %}h2{% else %}h1{% endif %}>
        {% endif %}

        {% if post.categories and post.categories.length and theme.post_meta.categories %}
          <div class="post-badge">
            {% for cat in post.categories %}
              <span itemprop="about" itemscope itemtype="http://schema.org/Thing">
        <a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">
          <span itemprop="name"># {{ cat.name }}</span>
        </a>
      </span>
            {% endfor %}
          </div>
        {% endif %}

        <div class="post-meta">
          <span class="post-time">
            {% if theme.post_meta.created_at %}
              <span class="post-meta-item-icon">
                <i class="far fa-calendar"></i>
              </span>
              {% if theme.post_meta.item_text %}
              <span class="post-meta-item-text">{{ __('post.posted') }}</span>
            {% endif %}
              <time title="{{ __('post.created') }}" itemprop="dateCreated datePublished" datetime="{{ moment(post.date).format() }}">{{ date(post.date, config.date_format) }}</time>
            {% endif %}

            {% if theme.post_meta.created_at and theme.post_meta.updated_at.enable %}
              <span class="post-meta-divider">•</span>
            {% endif %}

            {% if theme.post_meta.updated_at.enable %}
              <span class="post-meta-item-icon">
                <i class="fa fa-calendar-check-o"></i>
              </span>
              {% if theme.post_meta.item_text %}
              <span class="post-meta-item-text">{{ __('post.modified') }}&#58;</span>
            {% endif %}
              <time title="{{ __('post.modified') }}" itemprop="dateModified" datetime="{{ moment(post.updated).format() }}">
                {{ date(post.updated, config.date_format) }}
              </time>
            {% endif %}
          </span>

          {% if theme.symbols_count_time.enable %}
            <span class="post-wordcount">
              {% if theme.symbols_count_time.item_text_total %}
                {% if theme.symbols_count_time.post-meta-divider %}
                  <span class="post-meta-divider">•</span>
                {% endif %}
                <span class="post-meta-item-icon">
                  <i class="far fa-file-word"></i>
                </span>
                {% if theme.symbols_count_time.item_text_post %}
                <span class="post-meta-item-text">{{ __('post.wordcount') }}</span>
              {% endif %}
                <span title="{{ __('post.wordcount') }}">{{ symbolsCount(post.content) }}</span>
              {% endif %}

              {% if theme.symbols_count_time.post-meta-divider %}
                <span class="post-meta-divider">•</span>
              {% endif %}

              {% if theme.symbols_count_time.total_time %}
                <span class="post-meta-item-icon">
                  <i class="fa fa-clock"></i>
                </span>
                {% if theme.symbols_count_time.time %}
                <span class="post-meta-item-text">{{ __('post.min2read') }}</span>
              {% endif %}
                <span title="{{ __('post.min2read') }}">
                  {{ symbolsTime(post.content, theme.symbols_count_time.awl, theme.symbols_count_time.wpm, theme.symbols_count_time.suffix) }}
                </span>
              {% endif %}
            </span>
          {% endif %}

          {% if post.comments %}
          {% if (theme.duoshuo and theme.duoshuo.shortname) or theme.duoshuo_shortname %}
          <span class="post-comments-count">
                <span class="post-meta-divider">•</span>
                <span class="post-meta-item-icon">
                  <i class="fa fa-comment-o"></i>
                </span>
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count ds-thread-count" data-thread-key="{{ post.path }}" itemprop="commentCount"></span>
                </a>
              </span>
          {% elseif theme.facebook_comments_plugin.enable %}
          <span class="post-comments-count">
                <span class="post-meta-divider">•</span>
                <span class="post-meta-item-icon">
                  <i class="fa fa-comment-o"></i>
                </span>
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count fb-comments-count" data-href="{{ post.permalink }}" itemprop="commentCount">0</span> comments
                </a>
              </span>
          {% elseif theme.disqus.enable and theme.disqus.count %}
          <span class="post-comments-count">
                <span class="post-meta-divider">•</span>
                <span class="post-meta-item-icon">
                  <i class="fa fa-comment-o"></i>
                </span>
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count disqus-comment-count"
                        data-disqus-identifier="{{ post.path }}" itemprop="commentCount"></span>
                </a>
              </span>
          {% elseif theme.hypercomments_id %}
          <!--noindex-->
          <span class="post-comments-count">
                <span class="post-meta-divider">•</span>
                <span class="post-meta-item-icon">
                  <i class="fa fa-comment-o"></i>
                </span>
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count hc-comment-count" data-xid="{{ post.path }}" itemprop="commentsCount"></span>
                </a>
              </span>
          <!--/noindex-->
          {% elseif theme.changyan.enable and theme.changyan.appid and theme.changyan.appkey %}
          <span class="post-comments-count">
              <span class="post-meta-divider">•</span>
              <span class="post-meta-item-icon">
                <i class="fa fa-comment-o"></i>
              </span>
              {% if is_post() %}
                <a href="{{ url_for(post.path) }}#SOHUCS" itemprop="discussionUrl">
                  <span id="changyan_count_unit" class="post-comments-count hc-comment-count" data-xid="{{ post.path }}" itemprop="commentsCount"></span>
                </a>
              {% else %}
                <a href="{{ url_for(post.path) }}#SOHUCS" itemprop="discussionUrl">
                  <span id="url::{{ post.permalink }}" class="cy_cmt_count" data-xid="{{ post.path }}" itemprop="commentsCount" ></span>
                </a>
              {% endif %}
            {% elseif is_post() and theme.gitment.enable and theme.gitment.mint and theme.gitment.count %}
              <span class="post-comments-count">
                <span class="post-meta-divider">•</span>
                <span class="post-meta-item-icon">
                  <i class="fa fa-comment-o"></i>
                </span>
                <a href="{{ url_for(post.path) }}#comments" itemprop="discussionUrl">
                  <span class="post-comments-count gitment-comments-count" data-xid="{{ url_for(post.path) }}" itemprop="commentsCount"></span>
                </a>
              </span>
            {% endif %}
            {% endif %}

            {# LeanCould PageView #}
            {% if theme.leancloud_visitors.enable %}
              <span id="{{ url_for(post.path) }}" class="leancloud_visitors" data-flag-title="{{ post.title }}">
               <span class="post-meta-divider">•</span>
               <span class="post-meta-item-icon">
                 <i class="far fa-eye"></i>
               </span>
               {% if theme.post_meta.item_text %}
                 <span class="post-meta-item-text">被</span>
               {% endif %}
                 <span class="leancloud-visitors-count"></span>
                 <span class="post-meta-item-text">人看爆</span>
             </span>
            {% endif %}

            {% if not is_index and theme.busuanzi_count.enable and theme.busuanzi_count.page_pv %}
              <span class="post-meta-divider">•</span>
              <span class="page-pv">{{ theme.busuanzi_count.page_pv_header }}
            <span class="busuanzi-value" id="busuanzi_value_page_pv" ></span>{{ theme.busuanzi_count.page_pv_footer }}
            </span>
            {% endif %}
        </div>
        {% if post.description and (not theme.excerpt_description or not is_index) %}
          <div class="post-description">
            {{ post.description }}
          </div>
        {% endif %}
      </header>
      {% endif %}

      {#################}
      {### POST BODY ###}
      {#################}
      <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if post.direction && post.direction.toLowerCase() === 'rtl' %} rtl{% endif %}" itemprop="articleBody">
{#        {% if not is_index and toc(page.content).length > 1 %}<div class="post-toc-content"><div class="post-toc-title">文章目录</div>{{ toc(page.content, { "class": "nav", list_number: false }) }}</div>{% endif %}#}
        {# Gallery support #}
        {% if post.photos and post.photos.length %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {% set COLUMN_NUMBER = 3 %}
          {% for photo in post.photos %}
            {% if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{% endif %}
            <a class="post-gallery-img fancybox"
               href="{{ url_for(photo) }}" rel="gallery_{{ post._id }}"
               itemscope itemtype="http://schema.org/ImageObject" itemprop="url">
              <img src="{{ url_for(photo) }}" itemprop="contentUrl"/>
            </a>
            {% if loop.index0 % COLUMN_NUMBER === 2 %}</div>{% endif %}
          {% endfor %}

          {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
          {% if post.photos.length % COLUMN_NUMBER > 0 %}</div>{% endif %}
      </div>
      {% endif %}

      {% if is_index %}
        {% if post.description and theme.excerpt_description %}
          {{ post.description }}
          <!--noindex-->
          <div class="post-button text-center">
            <a class="btn scaleup" href="{{ url_for(post.path) }}">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
          <!--/noindex-->
          {% elif post.excerpt  %}
          {{ post.excerpt }}
          <!--noindex-->
          <div class="post-button text-center">
            <a class="btn scaleup" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#{{ __('post.more') }}{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
          <!--/noindex-->
          {% elif theme.auto_excerpt.enable %}
          {% set content = post.content | striptags %}
          {{ content.substring(0, theme.auto_excerpt.length) }}
          {% if content.length > theme.auto_excerpt.length %}...{% endif %}
          <!--noindex-->
          <div class="post-button text-center">
            <a class="btn scaleup" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#{{ __('post.more') }}{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
          <!--/noindex-->
        {% else %}
          {% if post.type === 'picture' %}
            <a href="{{ url_for(post.path) }}">{{ post.content }}</a>
          {% else %}
            {{ post.content }}
            <div class="post-button text-center">
              <a class="btn scaleup" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#{{ __('post.more') }}{% endif %}" rel="contents">
                {{ __('post.read_more') }} &raquo;
              </a>
            </div>
          {% endif %}
        {% endif %}
      {% else %}
        {{ post.content }}
      {% endif  %}
    </div>
    {#####################}
    {### END POST BODY ###}
    {#####################}

    {% if theme.wechat_subscriber.enabled and not is_index %}
      <div>
        {% include 'wechat-subscriber.swig' %}
      </div>
    {% endif %}

{#    {% if not is_index %}#}
{#      <div class="post-share">分享到：</div>#}
{#    {% endif %}#}

    {% if (theme.alipay or theme.wechatpay or theme.bitcoin) and not is_index %}
      <div>
        {% include 'reward.swig' %}
      </div>
    {% endif %}

    {% if theme.post_copyright.enable and not is_index %}
      <div>
        {% include 'post-copyright.swig' with { post: post } %}
      </div>
    {% endif %}

    <footer class="post-footer">
      {% if post.tags and post.tags.length and not is_index %}
        <div class="post-tags">
          {% for tag in post.tags %}
            <a href="{{ url_for(tag.path) }}" rel="tag">{{ tag.name }}</a>
          {% endfor %}
        </div>
      {% endif %}

      {% if not is_index %}
        {% if theme.rating.enable or (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) or (theme.needmoreshare2.enable and theme.needmoreshare2.postbottom.enable) %}
          <div class="post-widgets">
            {% if theme.rating.enable %}
              <div class="wp_rating">
                <div id="wpac-rating"></div>
              </div>
            {% endif %}

            {% if (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) %}
              <div class="social-like">
                {% if theme.vkontakte_api.enable and theme.vkontakte_api.like %}
                  <div class="vk_like">
                    <span id="vk_like"></span>
                  </div>
                {% endif %}

                {% if theme.facebook_sdk.enable and theme.facebook_sdk.like_button %}
                  <div class="fb_like">
                    <div class="fb-like" data-layout="button_count" data-share="true"></div>
                  </div>
                {% endif %}
              </div>
            {% endif %}

            {% if theme.needmoreshare2.enable and theme.needmoreshare2.postbottom.enable %}
              {% if (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) %}
                <span class="post-meta-divider">•</span>
              {% endif %}
              <div id="needsharebutton-postbottom">
            <span class="btn">
              <i class="fa fa-share-alt" aria-hidden="true"></i>
            </span>
              </div>
            {% endif %}
          </div>
        {% endif %}
      {% endif %}

      {% if not is_index and (post.prev or post.next) %}
        <div class="post-nav">
          <div class="post-nav-next post-nav-item">
            {% if post.next %}
              <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
                <i class="fas fa-angle-left"></i> {{ post.next.title }}
              </a>
            {% endif %}
          </div>

          <span class="post-nav-divider"></span>

          <div class="post-nav-prev post-nav-item">
            {% if post.prev %}
              <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
                {{ post.prev.title }} <i class="fas fa-angle-right"></i>
              </a>
            {% endif %}
          </div>
        </div>
      {% endif %}
    </footer>
    </div>
    {######################}
    {### END POST BLOCK ###}
    {######################}
  </article>

{% endmacro %}
