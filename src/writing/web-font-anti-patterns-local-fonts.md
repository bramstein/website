---
template: content.html
title: "Web Font Anti-Pattern: Using local fonts"
classes: writing
collection: [writing, news]
date: 2015-10-19
---

# Web Font Anti-Pattern: Using local fonts
<p class="subtitle">October 19, 2015</p>

<p class=intro>Never mix locally installed fonts and web fonts in @font-face rules. Assuming two fonts are identical because they share a name is a recipe for disaster. </p>

The @font-face `src` property takes one or multiple <abbr>URL</abbr>s, which tells the browser where to find a web font. The `src` property also accepts a `local()` value which refers to a local font by name. The browser will check if the font is available under the local name and use it. If it isn’t available it’ll move on to the next `local` or `url` value until it finds either a local or web font. The syntax is pretty straightforward: add one or more local font family names before the web font.

```
@font-face {
  font-family: Neue Helvetica;
  src: local('Helvetica Neue'),
       local('Helvetica'),
       url(helvetica.woff);
}
```

At first glance this may seem like a nice performance optimisation. If the font is available locally the browser doesn’t need to download the web font and displays the local font immediately. This would indeed be a great optimisation except for one little problem. Even though a local font matches the name of a web font, there is no guarantee it is actually the same font. In fact, it most likely is not.

Apart from the obvious cases where a font is named incorrectly, there are more insidious corner cases to consider. Many web fonts differ from their “desktop” version. Web fonts are often subsets (i.e. they do not contain the same characters) or are otherwise modified for web use. Modifications can include more extensive hinting, normalised vertical metrics, removal of OpenType features, and so on. The chance that a web font is exactly the same as an installed font with the same name is very slim.

This can affect your site in many ways depending on the difference between the local and the web font. The text might be rendered differently, some characters may fall back to other fonts, OpenType features can be missing entirely, or the line height may be different. Most typefaces also evolve over time; characters may look completely different from one version of the same typeface to the next. You’ll never know what version is installed locally under the same name.

This “optimisation” is primarily used by [Google Fonts](https://www.google.com/fonts), but it’s popping up in blogs and articles every now and then. Yes, it will be faster. But it is not a good idea unless you accept your site may look wildly different depending on what fonts your users have installed. It makes more sense to load a web font and to fall back on system fonts when the web font is not available, rather than deal with the multitude of locally installed versions of a web font. Some optimisations are too good to be true.

<p class=info>This article is part one of an ongoing series on web font anti-patterns. Read the [introduction](web-font-anti-patterns.html),  [part 1](web-font-anti-patterns-overusing.html), [part 2](web-font-anti-patterns-inlining.html),  [part 3](web-font-anti-patterns-subsetting.html), and [part 4](web-font-anti-patterns-local-fonts.html).</p>
