---
layout: homepage
permalink: /
---

Read: [About me and my TIL blog]({{'/about' | relative_url }})

**Note:** This site is obviously a work-in-progress, especially anything that has `(TK)` in it!


Lorem ipsum dolor sit, amet consectetur adipisicing elit. Sapiente vitae, qui placeat sed impedit cupiditate nihil molestiae eaque deleniti reiciendis tempore aliquid quasi, mollitia eum expedita minus accusamus recusandae incidunt.


<section class="sec recent-posts">
    <h2>What I've recently learned</h2>
    <ul class="list-unstyled list-posts">
    {% for post in site.posts limit:100 %}
        <li class="item item-post">
            <span class="created_at" datetime="{{ post.date | date: '%Y-%m-%d' }}">
                {{ post.date | date: '%Y-%m-%d' }}
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

