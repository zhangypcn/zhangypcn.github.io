{# 自定义文末版权声明：文章添加 copyright:true 可自定义是否开启版权声明 #}
{% if page.copyright %}
  <div>    
    {% if not is_index %}

      <ul class="post-copyright">
        <li class="post-copyright-author">
          <strong>{{ __('post.copyright.author') + __('symbol.colon') }}</strong>
          {{ post.author | default(config.author) }}
        </li>
        <li class="post-copyright-link">
          <strong>{{ __('post.copyright.link') + __('symbol.colon') }}</strong>
          <a href="{{ post.url | default(post.permalink) }}" title="{{ post.title }}">{{ post.url | default(post.permalink) }}</a>
        </li>
        <li class="post-copyright-license">
          <strong>{{ __('post.copyright.license_title') + __('symbol.colon') }} </strong>
          {{ __('post.copyright.license_content', theme.post_copyright.license_url, theme.post_copyright.license) }}
        </li>
      </ul>

    {% endif %}
  </div>
{% endif %}