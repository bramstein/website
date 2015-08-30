---
template: content.html
title: Preload Hints For Web Fonts
collection: [writing, news]
classes: writing
date: 2015-08-07
---

# Preload Hints For Web Fonts
<p class=subtitle>August 7, 2015</p>

<p class=intro>Web fonts are a popular topic in the web performance community. However, one fundamental problem is often overlooked: web fonts are lazy loaded. Can web font preload hints help us?</p>

Browsers only load web fonts when there is a <abbr>CSS</abbr> selector for a connected <abbr>DOM</abbr> node (i.e. one that is part of the document) that matches a `@font-face` rule. The browser can't know that those conditions are true until it has constructed both the <abbr>DOM</abbr> and the <abbr>CSSOM</abbr>. In order to do that it needs to download the <abbr>HTML</abbr> and all the <abbr>CSS</abbr> files.

![Web fonts do not start downloading until after both the <abbr>CSS</abbr> and <abbr>HTML</abbr> are downloaded](/assets/images/font-load-timeline.png)
<p class=caption>Downloading of web fonts wait until both the HTML and CSS files are downloaded. In this example, this increases the time to render to about 700ms.</p>

This is by design. It enables lazy loading of web fonts by only downloading a font file if it is actually used on the page. This makes sense. After all, why would you download a resource you don't need?

This may sound great, but lazy loading has one big problem: it is bad for performance. Lazy loading makes a lot of sense when you use web fonts sparingly for headlines and other display type. This is no longer the case on the modern web. Nearly 55% of all websites monitored by the [HTTP Archive](http://httparchive.org/) use web fonts. They are used to render all type on a site — headlines, body text, and even icons.

![Increase of web font usage over the past X years](/assets/images/web-font-usage.png)
<p class=caption>Increase in web font usage from 2012 to 2015. Source: [HTTP Archive](http://httparchive.org/).</p>

The average number of web fonts per site has also increased. In the early days of web font support sites used perhaps one or two web fonts for headlines. In the past couple years we've seen this number increase to an average of four to five fonts per site. This is fantastic — it has raised the typographic “bar” on the web.

Unfortunately, web fonts have become a performance bottleneck when browsers decided to hide text while fonts are downloading. This problem is exacerbated by the need to have both the <abbr>CSSOM</abbr> and <abbr>DOM</abbr> constructed before web fonts can even start downloading! This is completely unnecessary. Web developers will know whether a font is used or not. Only there is no way to tell the browser.

To solve this we need preload hints for web fonts. If we can tell the browser that we definitely need a font, it can start downloading it much earlier. This will significantly improve perceived and actual performance. Fonts that are downloaded earlier will render sooner and decrease the impact of blocking rendering (or the snap that happens when fallback fonts are replaced by web fonts).

![Web fonts do not start downloading until after both the CSS and HTML are downloaded.](/assets/images/font-load-timeline-with-preload.png)
<p class=caption>Web fonts using preload hints can start downloading at the same time as other resources linked from the head element. Preload hints cut the page load time in this example in half, to about 300ms.</p>

We’re in luck; the <abbr>W3C</abbr> is working on a [preload specification](https://w3c.github.io/preload/) that allows web developers to preload any resource using `<link>` elements. These preloading hints will also work for web fonts (though there are some [issues](https://github.com/w3c/preload/issues/28) with multiple font formats).

```
<link rel=“preload” href=“/assets/myfont.woff” as=“font”>
```

In this example, the `<link rel=“preload”>` resource hint will ask the browser to start downloading the font file as soon as possible. It also tells the browser that this is a font, so it can appropriately prioritise it in its resource queue. Preload hints will have a dramatic impact on web font performance. Browsers that support preload hints can start downloading web fonts as soon as they have seen the hint in the <abbr>HTML</abbr> file and no longer need to wait for the <abbr>CSS</abbr>.

It’s important to point out that these are hints and not demands. Browsers can — and will — ignore them in certain cases. For example, if a user is on a slow or expensive data connection it makes sense for the browser to not download web fonts. In the future browsers will hopefully offer user profiles that automatically prioritise or ignore preload hints so that you get the best user experience based on your environment.

**Update**: Ilya Grigorik pointed out the above is incorrect: if browsers see preload hints they must download the resource. You can use `<link rel=“prefetch”>` if you want the behaviour I described.

Now for the bad news: the preload specification is still a draft and currently not implemented by any browser. Other related features like the [<abbr>CSS</abbr> font loading <abbr>API</abbr>](http://www.w3.org/TR/css-font-loading/) and the [font-display property](https://tabatkins.github.io/specs/css-font-rendering/) will let web developers simulate some of the benefits of preload hints. However they can never be as good because they rely on either JavaScript or <abbr>CSS</abbr>.

We really __need__ preload hints to improve web font performance.
