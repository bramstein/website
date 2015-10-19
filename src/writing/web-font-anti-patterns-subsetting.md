---
template: content.html
title: "Web Font Anti-Pattern: Agressive subsetting"
classes: writing
collection: [writing, news]
date: 2015-10-13
---

# Web Font Anti-Pattern: Aggressive subsetting
<p class="subtitle">October 13, 2015</p>

<p class=intro>Subsetting is a great way to reduce the file size of your fonts. Don’t go overboard with subsetting though, there may be unexpected consequences. Subset, but subset with care.</p>

Professionally designed fonts usually contain support for multiple languages so they can be used all over the world. However, if you only write your content in a single language, you probably don’t want to pay for the extra weight these unused characters add to your page load time.

This is where subsetting comes in. It allows you to remove characters and OpenType features from a font file that you don’t need. There is an almost one to one relationship between the number of characters in a font file and its file size. If you cut the number of characters in half, you will also cut the file size of a font in half. This is a great way to optimise a font and make it load faster.

![Characters supported by an example font.](/assets/images/web-font-subsetting.png)
<p class=caption>English does not use many characters. In this font, over half of the characters can be removed for text that is exclusively written in English.</p>

Subsetting can be done using tools like [Font Squirrel’s web font generator](http://www.fontsquirrel.com/tools/webfont-generator), [command line tools](https://github.com/bramstein/homebrew-webfonttools), or through the user interfaces of web font services like [Typekit](https://typekit.com/), [Google Fonts](http://google.com/fonts/), and others.

Be very careful with subsetting because it can go very wrong. Text often contains names, place names, quotations, and loan words from other languages. If the web font subset does not contain the characters used in the page they’ll fall back to the next font in the stack. This is highly undesirable, because quite often the web font and fallback font do not match.

![Example of aggressive subsetting.](/assets/images/subsetting-gone-wrong.png)
<p class=caption>An English-only subset used for a German city name. The “ü” (u-umlaut) is rendered in a fallback font and stands out like a sore thumb. (Yes, even in this caption.)</p>

That’s not to say subsetting isn’t useful. If used carefully it can be a great way to reduce the size of your font files. Before you subset carefully analyse your existing content and think ahead to what characters and OpenType features you might use in the future.

<p class=info>This article is part one of an ongoing series on web font anti-patterns. Read the [introduction](web-font-anti-patterns.html),  [part 1](web-font-anti-patterns-overusing.html), [part 2](web-font-anti-patterns-inlining.html),  [part 3](web-font-anti-patterns-subsetting.html), and [part 4](web-font-anti-patterns-local-fonts.html).</p>