---
template: content.html
title: Working
classes: working
---

<p class="intro">I've created a large collection of open source libraries for improving type and typography on the web. Some of my libraries are used on millions of websites around the world.</p>

Below is just a small selection of my most well-known open source projects. My [Github profile](https://github.com/bramstein) contains several other useful libraries and tools.

# The State Of Web Type (defunct)

The State of Web Type contains up to date browser support data for type and typographic features. I created the State of Web Type because no other browser support data site goes into the necessary detail for type and typography features.

[![State of Web Type](/assets/images/state-of-web-type-site.png)](http://stateofwebtype.com/)

The site is frequently updated with new data and entirely open source. Any additions, corrections, or comments are very welcome.

<ul class="meta">
  <li><a href="http://stateofwebtype.com/">Visit the State of Web Type</a></li>
  <li><a href="https://github.com/bramstein/stateofwebtype/">View Source Code</a></li>
  <li><a href="https://github.com/bramstein/stateofwebtype/issues/">Report an issue</a></li>
</ul>

# Font Face Observer

Font Face Observer is a small library that provides JavaScript font load events. It will detect when a web font has loaded and notify you. It is compatible with all web font services and self-hosted fonts.

[![Font Face Observer](/assets/images/fontfaceobserver.png)](https://www.fontfaceobserver.com/)

The Filament Group has an excellent article on [how to use Font Face Observer's font events](https://www.filamentgroup.com/lab/font-events.html) to efficiently load fonts. The “Professional Web Typography” book by Donny Truong also has a section on [how to use Font Face Observer](https://prowebtype.com/delivering-web-fonts/#observer).

<ul class="meta">
  <li><a href="https://fontfaceobserver.com/">Visit Font Face Observer</a></li>
  <li><a href="https://github.com/bramstein/fontfaceobserver/">View Source Code</a></li>
  <li><a href="https://github.com/bramstein/fontfaceobserver/issues/">Report an issue</a></li>
</ul>

# Type Rendering Mix

Each operating system has its own text rendering engine. Some engines render the same typeface lighter and some render it heavier. This results in your site looking differently on each operating system. Web developers often work around this by disabling sub pixel antialiasing, but this reduces the fidelity of the text.

[![Type Rendering Mix website](/assets/images/type-rendering-mix.png)](http://typerendering.com/)

Together with [Tim Brown](http://nicewebtype.com/) I developed Type Rendering Mix, which lets you apply <abbr>CSS</abbr> based on the text rendering engine and antialiasing method your browser is using. You can use it to switch to a lighter or heavier weight of your typeface based on the browser and operating system your visitors are using.

<ul class="meta">
  <li><a href="http://typerendering.com/">Visit Type Rendering Mix</a></li>
  <li><a href="https://github.com/bramstein/trmix/">View Source Code</a></li>
  <li><a href="https://github.com/bramstein/trmix/issues/">Report an issue</a></li>
</ul>

# Hypher: hyphenation engine

Hypher is a fast and small hyphenation engine written in JavaScript. It works in both the browser and Node.js and comes with hyphenation dictionaries for more than 30 languages. For jQuery users a plugin is also included.

<ul class="meta">
  <li><a href="https://github.com/bramstein/hypher/">View Source Code</a></li>
  <li><a href="https://github.com/bramstein/hypher/issues/">Report an issue</a></li>
</ul>

# Typeset

Typeset is an implementation of the Knuth and Plass line breaking algorithm in JavaScript. By manually breaking paragraphs into lines it is possible to achieve higher quality typesetting than offered by modern browsers. It also opens up the possibility of using custom text shapes as shown below.

[![Text shapes using Typeset](/assets/images/typeset.png)](https://github.com/bramstein/typeset)

While Typeset fully implements the Knuth and Plass algorithm, it should be considered a proof of concept. It is not ready for production use (and most likely will never be).

<ul class="meta">
  <li><a href="https://github.com/bramstein/typeset/">View Source Code</a></li>
  <li><a href="https://github.com/bramstein/typeset/issues/">Report an issue</a></li>
</ul>

# Treesaver: adaptive magazine layouts 

Treesaver is an in-browser reading experience that dynamically adapts to a user’s device and screen size. Using web-standard technologies present in HTML5, Treesaver enables innovative, visually appealing column-based page designs that don’t require any additional downloads: all you need is a modern web browser.

[![A news layout in Treesaver](/assets/images/treesaver.jpg)](https://github.com/treesaver/treesaver/)

Most websites display the same design to all users, no matter what browser or device they are using. Because these designs don’t take into account the screen size, users on mobile devices must often resort to frequent zooming and scrolling in order to read content. Together with [Filipe Fortes](http://fortes.com/), [Scott Kellum](http://scottkellum.com/), and [Roger Black](http://rogerblack.com/).

<ul class="meta">
  <li><a href="https://github.com/treesaver/treesaver/">View Source Code</a></li>
  <li><a href="https://github.com/treesaver/treesaver/issues/">Report an issue</a></li>
</ul>

<hr>

I've created and contributed to several other interesting projects:

* [webfontloader](https://github.com/typekit/webfontloader) — A web font loader that provides font events.
* [promis](https://github.com/bramstein/promis) — A small embeddable Promise polyfill.
* [url-template](https://github.com/bramstein/url-template) — An <abbr>URI</abbr> template implementation.
* [characterset](https://github.com/bramstein/characterset) — Manipulate and create character sets.
* [column-selector](https://github.com/bramstein/column-selector) — A jQuery table column selector plugin.
* [opentype.js](https://github.com/bramstein/opentype) — An OpenType, TrueType and <abbr>WOFF</abbr> parser.
* [xsltjson](https://github.com/bramstein/xsltjson) — Convert <abbr>XML</abbr> to <abbr>JSON</abbr> using a <abbr>XSLT</abbr> stylesheet.
* [unicode-tokenizer](https://github.com/bramstein/unicode-tokenizer) — Unicode tokenizer for line breaking.

You can view [all of my projects](https://github.com/bramstein) on my Github profile page.
