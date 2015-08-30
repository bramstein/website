---
template: content.html
title: "Smashing Book 5: Web Fonts Performance"
collection: [writing, news]
classes: writing
date: 2015-06-28
---

# Smashing Book 5: Web Fonts Performance
<p class="subtitle">July 28, 2015</p>

Smashing Magazine asked me to write a chapter about web fonts performance for [Smashing Book 5](http://www.smashingmagazine.com/2015/03/real-life-responsive-web-design-smashing-book-5/). I think web fonts are great, but they suffer from one big problem: by default they block rendering in almost all browsers. You may have experienced this yourself on a site using web fonts while using a slow cellular network. Staring at a blank page is no fun, especially when the content has already loaded.

![Smashing Book 5](/assets/images/smashing-book-5-pages.png)

Blocking rendering while downloading fonts is wrong and against the very idea of progressive enhancement. After all, the content is what people come for. Web fonts are an enhancement of that content. Important, but not critical. This chapter will show you how to optimise web fonts and how to load them without inconveniencing your visitors.

# Table of Contents

Below is the table of contents with a short description of each section to give you an impression of what is covered in the chapter.

## Web Fonts & Formats 

The chapter starts with a short introduction to the `@font-face` syntax, and an overview of all web font formats: <abbr>TTF</abbr>, <abbr>OTF</abbr>, <abbr>EOT</abbr>, <abbr>WOFF</abbr>, <abbr>WOFF2</abbr>, and <abbr>SVG</abbr> fonts. It covers the browser support for these formats and their benefits and downsides. Following that is a discussion of the [bulletproof @font-face syntax](http://www.paulirish.com/2009/bulletproof-font-face-implementation-syntax/) and why you should no longer use it. The section ends with a recommendation for which formats are required to cover all modern browsers and a proposal for a  simplified `@font-face` syntax.

## Font Loading

Do you want to know exactly how browsers load web fonts? This section is for you: it contains a deep-dive into font loading. You’ll find out why browsers need to construct both the DOM and CSSOM before they can start loading web fonts. It also explores how fonts are matched and under which circumstances fallback fonts are used. You’ll also learn what faux styles are and how to prevent them.

![FOUT vs. FOIT](/assets/images/smashing-book-5-fout-foit.png)

The section ends with a description of the two different approaches browsers take when loading fonts: the Flash Of Unstyled Text (<abbr>FOUT</abbr>) and the Flash Of Invisible Text (<abbr>FOIT</abbr>). The section also contains information on which browsers use <abbr>FOUT</abbr> and which use <abbr>FOIT</abbr> with a timeout (or not).

## CSS font-rendering property

The `font-rendering`<sup>*</sup> property is a proposal for a CSS property that controls how fonts are loaded. It lets you control if fonts should block rendering, or if the fallback font should be shown while loading web fonts. It also lets you customise the timeout the browser uses while loading web fonts. Even though this property has not yet been standardised (and is likely to undergo changes) it shows you what will be possible in the future.

<p class="fineprint"><sup>*</sup> The property has been renamed to `font-display` and underwent other significant changes after the book went to print. Check the latest [draft proposal](https://tabatkins.github.io/specs/css-font-rendering/) for updates.</p>

## CSS Font loading API

The [<abbr>CSS</abbr> font loading module](http://www.w3.org/TR/css-font-loading/) introduces a new JavaScript <abbr>API</abbr> to load and manipulate web fonts. In this section you’ll learn how to use the <abbr>API</abbr> to create new `@font-face` rules and insert them into the document. You can also use the <abbr>API</abbr> to query and change existing `@font-face` rules, or to preload web fonts so that they do not block rendering while loading.

The <abbr>API</abbr> is currently only supported by Chrome, Opera, and Firefox. If you want to use it right now in all browsers, you can use a [polyfill](https://github.com/bramstein/fontloader) that I’ve written.

![](/assets/images/smashing-book-5-photo.jpg)

## Basic Optimisations

Before you move on to the advanced font loading strategies in the next section you should make sure you’ve covered these basic optimisations to make your fonts load faster: using fallback fonts, caching, compression, inlining and subsetting.

It is technically not an optimisation, but sometimes the best way to make your site appear faster is to show fallback fonts before loading web fonts. You can increase the perceived performance of your site by selecting fallback fonts that closely match the metrics of your web font. This section will tell you how to structure your fallback font stacks so they work well across platforms and devices.

This section also covers efficient caching of web fonts, compression using <abbr>GZIP</abbr> and the more efficient Zopfli compression algorithm. Inlining fonts in your stylesheets might seem like an attractive option, but there are several downsides that might make you reconsider this approach.

The final “basic” optimisation is subsetting: making fonts smaller by removing characters. While this is often a dangerous operation, it can also significantly reduce the file size of your fonts. Combined with the `unicode-range` property subsetting can significantly increase your website’s performance.

## Font Loading Strategies

This section contains several strategies for getting consistent and efficient cross-browser font loading that avoids blocking rendering. It teaches you how to load fonts selectively using media queries and <abbr>CSS</abbr> classes. This can be very useful when you’re only using a font when certain conditions are true.

This section also shows you how to manually implement <abbr>FOUT</abbr> and <abbr>FOIT</abbr> using JavaScript. You can use this to make your font loading behave consistently in all browsers. Manual font loading using JavaScript is asynchronous and gives more more control over how your web fonts are cached.

If you need to load a lot of fonts, you should consider prioritised loading. By prioritising a primary group of fonts you can make your site appear to load faster and still load a lot of fonts.

![](/assets/images/smashing-book-5-photo-stack.jpg)

# Where to get the book

The book can be purchased at the [Smashing Magazine web shop](http://www.smashingmagazine.com/books/) in hardcover and eBook versions. The author (and reviewer) line-up is amazing, so I highly recommend getting a copy.

<a class="button" href="http://www.smashingmagazine.com/books/">Buy Smashing Book #5</a>

My thanks go out to my amazing reviewer [Zach Leatherman](http://www.zachleat.com/web/) -- his feedback and comments were invaluable. Many thanks as well to [Nathan Ford](http://artequalswork.com/), [Tim Brown](http://nicewebtype.com/), and Gregor Kaplan for reviewing and commenting on my early drafts.
