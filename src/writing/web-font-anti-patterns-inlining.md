---
template: content.html
title: "Web Font Anti-Patterns: Inlining"
classes: writing
collection: [writing, news]
date: 2015-10-08
---

# Web Font Anti-Patterns: Inlining
<p class="subtitle">October 8, 2015</p>

A very common web anti-pattern is embedding fonts in <abbr>CSS</abbr> using data <abbr>URI</abbr>s. The font file is base64 encoded and inlined directly in the stylesheet. The main benefit of inlining is that it avoids the overhead of an <abbr>HTTP</abbr> request. This is beneficial when you load multiple fonts. When all fonts are combined in the same stylesheet you only need to pay for the <abbr>HTTP</abbr> request overhead once. This may seem very attractive, but there are some serious downsides to inlining.

These downsides become visible when you look at a network timeline of the default behaviour compared to inlining. Below is an example of how a browser normally downloads web fonts. The fonts are downloaded in parallel and render as soon as they finish; `font a` is rendered first, followed by `font b`, and finally `font c`. This is progressive rendering. Fonts are rendered as soon as the finish downloading.

![Browser timeline downloading three fonts in parallel.](/assets/images/parallel-download.png)

Here is what the timeline looks like when you inline those three fonts in the same stylesheet. Instead of downloading three files in parallel the browser only downloads a single <abbr>CSS</abbr> file. This single file is much larger because it contains all three fonts and takes longer to load than three separate font files downloaded in parallel.

![Browser timeline downloading three fonts inlined in CSS.](/assets/images/inline-download.png)

Browsers can download more than one resource at a time (in fact, many browsers allow up to six connections per host). If you inline fonts you’ll miss out on the benefits of parallel downloads. It also disables progressive rendering. When you combine all the fonts on your page in a single stylesheet they will all load at the same time: when the stylesheet finishes loading.

Both of these issues affect web font perform negatively. Remember that [fonts should be downloaded with the highest priority and as soon as possible](http://localhost:3000/writing/preload-hints-for-web-fonts.html) because they block rendering. If you inline your web fonts you’ll disable parallel downloading and progressive rendering. As a result your fonts will load slower and the lack of progressive rendering reduces the perceived performance of your site.

Another big problem with inlining is that you limit yourself to a single web font format. Because the entire font file is inlined in <abbr>CSS</abbr>, adding support for another font format increases the size of the <abbr>CSS</abbr> file (essentially you would be storing and transmitting the same font once per format). You could work around this by sniffing the user agent string and guessing which web font format the browser supports, but this is a rabbit hole you don’t want to go down into. Believe me. I’ve been there — it’s not a happy place.

If you don’t want to do user agent sniffing you’re left with serving the font format with the widest browser support: <abbr>WOFF</abbr>. That’s perhaps sufficient for most websites, but you’ll miss out on the benefits of newer formats that offer much better compression rates (such as <abbr>WOFF2</abbr>).

Finally, inlining also negatively affects caching. If you need to update one of the fonts in your stylesheet you’ll need to invalidate the entire file. Your visitors will need to re-download a <abbr>CSS</abbr> file containing all the fonts even though most of them did not change. If the font files were served (and cached) as individual files only the updated font file would need to be downloaded again.

So, to sum up; unless you’re loading a lot of fonts (let’s say more than 10) inlining is a bad idea. With the introduction of <abbr>HTTP/2</abbr>, inlining is an even less attractive option. <abbr>HTTP/2</abbr> enables parallel downloads over the same connection. This has the same benefit as inlining (avoiding request overhead) but none of the downsides. Caching, font format negotiation, and progressive rendering will continue to work as expected.