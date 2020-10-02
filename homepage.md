---
layout: homepage
permalink: /
---

Read: [About me and my TIL blog]({{'/about' | relative_url }})


Lorem ipsum dolor sit, amet consectetur adipisicing elit. Sapiente vitae, qui placeat sed impedit cupiditate nihil molestiae eaque deleniti reiciendis tempore aliquid quasi, mollitia eum expedita minus accusamus recusandae incidunt.


<section class="sec">
    <h2>Recent posts</h2>
    <ul class="list-unstyled">
    {% for post in site.posts limit:3 %}
        <li>
            <span class="created_at" datetime="{{ post.date | date: '%Y-%m-%d' }}">
                [{{ post.date | date: '%Y-%m-%d' }}]
            </span>
            <a href="{{ post.url | relative_url }}" class="post-title">
                    {{ post.title }}
            </a>
        </li>
    {% endfor %}
    </ul>
</section>


<section class="sec">
    <h2>By topic</h2>
    <ul>
    {% for cat in site.categories %}
        {% assign category = cat[0] %}
        {% assign slug = category | slugify %}
        <!-- {#% assign posts = cat.last %}     -->
        <li>
            <a href="{{ 'fullindex' | relative_url }}#{{slug}}">
                {{ category }}
            </a>
        </li>
    {% endfor %}
    </ul>
</section>

