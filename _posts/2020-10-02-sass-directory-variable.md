---
title:  That I can use a SASS variable to denote a directory path for cleaner font declarations
date:   2020-10-02 18:45:00 -0500
categories:
    - sass
---


For whatever reason, I've decided that I want to store and link to my own copy of fonts downloaded via [Google Fonts](https://fonts.google.com/) (rather than linking to Google's online versions). So I've put them in my [assets/fonts](https://github.com/dannguyen/til/tree/master/assets/fonts) subdirectory, and wrote my [_fonts.scss](https://github.com/dannguyen/til/blob/0a771dd568c359fe13c5128419eff782d8ee2952/_sass/mystyles/_fonts.scss#L6) like so:

```sass
@font-face {
    font-family: "Roboto";
    src: url("/assets/fonts/Roboto/Roboto-Regular.ttf") format('truetype');
    font-weight: 400;
    font-style: normal;
}

@font-face {
    font-family: "Roboto";
    src: url("/assets/fonts/Roboto/Roboto-Italic.ttf") format('truetype');
    font-weight: 400;
    font-style: italic;
}
```

Unfortunately, because I'm currently hosting my TIL blog on Github pages from a subdirectory – i.e. `dannguyen.github.io/til` as opposed to `til.dannguyen.github.io` – my font references are 404ing because they are aimed at `dannguyen.github.io/assets/fonts` as opposed to the relative subdirectory of `dannguyen.github.io/til/assets/fonts`.

Since this is a site built by Jekyll, I have the option of [using Liquid filters and my site configuration](https://jekyllrb.com/docs/assets/) to set the font directory, e.g. something like `{{'assets/fonts' | relative_url}}`, which lets Jekyll do the work of figuring out the relative path of my site if I end up changing its online domain.

(First, I have to move my font sass stuff out of the `_sass/` subdirectory and into `assets/css/main.scss`, since Jekyll is "unaware" of my `_sass/` pre-processed subdirectory...)

Putting that Liquid filter in the `url()` calls of `main.scss` looks like this:

```sass
@font-face {
    font-family: "Roboto";
    src: url("{{ '/assets/fonts/Roboto/Roboto-Regular.ttf' | relative_url }}") format('truetype');
    font-weight: 400;
    font-style: normal;
}

@font-face {
    font-family: "Roboto";
    src: url("{{ '/assets/fonts/Roboto/Roboto-Italic.ttf' | relative_url }}") format('truetype');
    font-weight: 400;
    font-style: italic;
}
```

...which honestly, isn't *that* ugly? But the repetition of the messy mix of syntax bothers me, so I wondered if there were a way to interpolate a SASS variable as part of a string parameter (e.g. what's provided to `url()`), something like:

```
$fonts_dir: {{"/assets/fonts" | relative_url }};

    src: url("$fonts_dir/Roboto/Roboto-Regular.ttf") format('truetype');
```

And it turns out, the answer is the "Pretty much, yes": – big thanks to this [blog post from Caffeine Creations](https://caffeinecreations.ca/blog/sass-variable-for-image-path/), which was near the top of the Google results for "sass set directory variable":

```sass
$fonts_dir: {{"/assets/fonts" | relative_url }};

@font-face {
    font-family: "Roboto";
    src: url(#{$fonts_dir}/Roboto/Roboto-Regular.ttf) format('truetype');
    font-weight: 400;
    font-style: normal;
}

@font-face {
    font-family: "Roboto";
    src: url(#{$fonts_dir}/Roboto/Roboto-Italic.ttf) format('truetype');
    font-weight: 400;
    font-style: italic;
}
```

Nice! I used to be much better at [Sass](https://sass-lang.com/) when I built Rails apps. But I never specialized in the language beyond understanding it enough to better organize my style sheets and settings. If I hadn't already downloaded the [Sass source from Bootstrap](https://getbootstrap.com/docs/4.0/getting-started/download/#source-files) to include and tweak for my TIL blog, I probably wouldn't have remembered that Sass variables even *existed*!





