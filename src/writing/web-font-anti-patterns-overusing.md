---
template: content.html
title: "Web Font Anti-Pattern: Overusing web fonts"
classes: writing
collection: [writing, news]
date: 2015-10-08
---

# Web Font Anti-Pattern: Overusing web fonts
<p class="subtitle">October 8, 2015</p>

<p class=intro>This is my favourite [web font anti-pattern](web-font-anti-patterns.html) and one I often commit myself; why are you using web fonts for __that__? I get it. Web fonts are great. I love them too, but they are overused.</p>

Don’t use web fonts if you don’t need them. They’re not the right answer for everything. If you find yourself wrapping each letter or word in a span element — stop. You should probably use <abbr>SVG</abbr>.

There is a fine line between type and lettering, and web browsers are not great at the latter. <abbr>SVG</abbr> on the other hand is a great fit for lettering. It’ll give you absolute control over kerning, tracking, position, gradients, masking, and colour. As an added bonus, the resulting <abbr>SVG</abbr> file size will be smaller than loading several fonts.

![example image](/assets/images/web-fonts-vs-lettering.png)
<p class=caption>Do you really need to use web fonts for a headline like this? Maybe <abbr>SVG</abbr> is a better choice.</p>

Using web fonts for lettering becomes especially problematic in responsive designs. If you use web fonts you’ll need to adjust the positioning and size of each span at each breakpoint. This quickly becomes tedious. If you’re using <abbr>SVG</abbr> you can easily scale and switch between <abbr>SVG</abbr> files.

Web fonts are meant for body text and headlines. Text that can be selected and copied. It’s perfectly fine to do lettering and illustrations in SVG. If you’re worried about accessibility (you should be!) SVG has [several ways](http://www.sitepoint.com/tips-accessible-svg/) to increase accessibility.

<p class=info>This article is part one of an ongoing series on web font anti-patterns. Read the [introduction](web-font-anti-patterns.html),  [part 1](web-font-anti-patterns-overusing.html), [part 2](web-font-anti-patterns-inlining.html), and [part 3](web-font-anti-patterns-subsetting.html).</p>


