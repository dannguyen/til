---
title: Full Index
layout: default
permalink: /fullindex
---


{% for cat in site.categories %}
{% assign category = cat[0] %}
{% assign category_slug = category | slugify %}
{% assign posts = cat.last %}

<section class="sec">
    <h2 class="category-title" name="{{category_slug}}" id="{{category_slug}}">
        <a class="link-unstyled" href="#{{category_slug}}">
            {{category}}
        </a>
    </h2>

    <ul class="list-unstyled">
        {% for post in posts %}
          <li>
            <span class="created_at" datetime="{{ post.date | date: '%Y-%m-%d' }}">
                [{{ post.date | date: '%Y-%m-%d' }}]
            </span>

            <a href="{{ post.url }}">{{ post.title }} </a>
          </li>
        {% endfor %}
    </ul>
</section>
{% endfor %}
