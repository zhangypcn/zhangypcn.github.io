{# 文末版权声明 #}
{% if page.copyright %}
  <div>    
    {% if not is_index %}
      <ul class="my-post-copyright">
        <li class="my-post-copyright-link">
          <strong>本文作者：</strong>
          <a href="/" title="欢迎访问 {{ theme.author }} 的个人博客">{{ theme.author }}</a>
        </li>

        {#<li class="my-post-copyright-link">
          <strong>本文标题：</strong>
          <a href="{{ url_for(post.permalink) }}" title="{{ post.title }}">{{ post.title }}</a>
        </li>#}

        <li class="my-post-copyright-link">
          <strong>本文链接：</strong>
          <a href="{{ url_for(post.permalink) }}" title="{{ post.title }}">{{ post.permalink }}</a>
        </li>

        {#<li class="my-post-copyright-date">
          <strong>发布时间：</strong>{{ post.date.format("YYYY年M月D日 | HH时MM分") }}
        </li>#}  

        <li class="my-post-copyright-license">
          <strong>版权声明： </strong>
          本文为 {{theme.author}} 原创，采用 <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/" rel="license" target="_blank"><i class="fa fa-creative-commons"></i> BY-NC-SA 4.0协议</a>，转载请注明出处，并保留以上声明信息！
        </li>
      </ul>
    {% endif %}
  </div>
{% endif %}
