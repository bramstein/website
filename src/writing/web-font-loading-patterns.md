---
template: content.html
title: Web Font Loading Patterns
classes: writing
collection: [writing, news]
date: 2016-04-13
---


# Web Font Loading Patterns
<p class="subtitle">April 13, 2016</p>

<p class=intro>Web font loading may seem complicated, but it is actually quite simple if you use these font loading patterns. Combine the patterns to create custom font loading behaviour that works in all browsers.</p>

The code examples in these patterns use [Font Face Observer](https://github.com/bramstein/fontfaceobserver), a small and simple web font loader. Font Face Observer will use the most efficient way to load a font depending on browser support, so it is a great way to load web fonts without having to worry about cross-browser compatibility.

1. [Basic font loading](#basic-font-loading)
2. [Loading groups of fonts](#loading-groups-of-fonts)
3. [Loading fonts with a timeout](#loading-fonts-with-a-timeout)
4. [Prioritised loading](#prioritised-loading)
5. [Custom font display](#custom-font-display)
6. [Optimise for caching](#optimise-for-caching)

It’s impossible to recommend a single pattern that works best for everyone. Take a close look at your site and visitors and select a font loading pattern, or a combination of patterns, that work best for you.

## Basic font loading

Font Face Observer gives you control over web font loading using a simple promise based interface. It doesn’t matter where your fonts come from: you can host them yourself, or use a web font service such as [Google Fonts](http://www.google.com/fonts), [Typekit](http://typekit.com/), [Fonts.com](https://fonts.com/), and [Webtype](http://webtype.com/).

To keep the patterns simple this article assumes you’re self-hosting web fonts. This means you should have one or multiple `@font-face` rules in your <abbr>CSS</abbr> files for the web fonts you want to load using Font Face Observer. For the sake of brevity, the `@font-face` rules won’t be included in each font loading patterns, but they should be assumed to be there.

```css
@font-face {
  font-family: Output Sans;
  src: url(output-sans.woff2) format("woff2"),
       url(output-sans.woff) format("woff");
}
```

The most basic pattern is to load one or multiple individual fonts. You can do this by creating several `FontFaceObserver` instances, one for each web font, and calling their `load` method.

```javascript
var output = new FontFaceObserver('Output Sans');
var input = new FontFaceObserver('Input Mono');

output.load().then(function () {
  console.log('Output Sans has loaded.');
});

input.load().then(function () {
  console.log('Input Mono has loaded.');
});
```

This will load each web font independently, which is useful when the fonts are unrelated and supposed to render progressively (i.e. as soon as they load). Unlike the [native font loading <abbr>API</abbr>](https://www.w3.org/TR/css-font-loading/) you don’t pass font <abbr>URL</abbr>s to Font Face Observer. It will use the `@font-face` rules already available in your <abbr>CSS</abbr> to load fonts. This allows you to load your web fonts manually using JavaScript, with a graceful degradation to basic <abbr>CSS</abbr>.

## Loading groups of fonts

You can also load multiple fonts at the same time by grouping them: they will either all load, or the entire group will fail to load. This can be useful if the fonts you’re loading belong to the same family and you want to stop the group from rendering unless all of the styles load. This will prevent the browser from generating faux styles when it doesn’t have the entire font family.

```javascript
var normal = new FontFaceObserver('Output Sans');
var italic = new FontFaceObserver('Output Sans', {
  style: 'italic'
});

Promise.all([
  normal.load(),
  italic.load()
]).then(function () {
  console.log('Output Sans family has loaded.');
});
```

You can group fonts by using `Promise.all`. When the promise is resolved all fonts will have loaded. If the promise is rejected at least one of the fonts failed to load.

Another use case for grouping fonts is to reduce reflows. If you load and render web fonts progressively the browser will need to recalculate the layout multiple times due to the difference in font metrics between the fallback and web fonts. Grouping can reduce this to a single relayout.

## Loading fonts with a timeout

Sometimes fonts take a long time to load. This can be problematic because web fonts are often used to render the main content of your site: the text. It’s not acceptable to indefinitely wait for a font to load. You can fix this by adding a timer to your font loading.

The following helper function creates timers by returning a promise that is rejected when the time has expired.

```javascript
function timer(time) {
  return new Promise(function (resolve, reject) {
    setTimeout(reject, time);
  });
}
```

By using `Promise.race` we can let font loading and the timer “race” each other. For example, if the font loads before the timer fires, the font has won and the promise will be resolved. If the timer fires before the font loads, the promise will be rejected.

```javascript
var font = new FontFaceObserver('Output Sans');

Promise.race([
  timer(1000),
  font.load()
]).then(function () {
  console.log('Output Sans has loaded.');
}).catch(function () {
  console.log('Output Sans has timed out.');
});
```

In this example a font is raced against a timer of one second. Instead of racing against a single font it is also possible to race a timer against a group of fonts. This is a simple and effective way to limit the amount of time it takes to load fonts.

## Prioritised loading

Often, only a handful of fonts are critical to render the “above the fold” content on your site. Loading these fonts first, before other more optional fonts, will improve the performance of your site. You can do this using prioritised loading.

```javascript
var primary = new FontFaceObserver('Primary');
var secondary = new FontFaceObserver('Secondary');

primary.load().then(function () {
  console.log('Primary font has loaded.')

  secondary.load().then(function () {
    console.log('Secondary font has loaded.')
  });
});
```

Prioritised loading makes the secondary font dependent on the primary font. If the primary font fails to load, the secondary font will never load. This can be a very useful property.

For example, you could use prioritised loading to load a small primary font with limited character support followed by a larger secondary font with support for more characters or styles. Because the primary font is very small it will load and render much faster. If the primary font fails to load you probably don’t want to try to load the secondary font either, because it is likely to fail as well.

This use of prioritised loading is described in more detail by Zach Leatherman in [Flash of Faux Text](http://www.zachleat.com/web/foft/) and [Web Font Anti-Patterns: Data URIs](http://www.zachleat.com/web/web-font-data-uris/).

## Custom font display
Before a browser can show a web font it needs to be downloaded over the network. This usually takes a little while, and browsers behave differently while they are downloading web fonts. Some browsers hide text while web fonts are loading, while others show fallback fonts immediately. This is commonly referred to as the Flash Of Invisible Text (<abbr>FOIT</abbr>) and the Flash Of Unstyled Text (<abbr>FOUT</abbr>).

![FOUT vs. FOIT](/assets/images/smashing-book-5-fout-foit.png)

Internet Explorer and Edge use <abbr>FOUT</abbr> and show fallback fonts until the web font has finished downloading. All other browsers use <abbr>FOIT</abbr> and hide text while web fonts are downloading.

A new <abbr>CSS</abbr> property called `font-display` ([CSS Font Rendering Controls](https://tabatkins.github.io/specs/css-font-display/)) is meant to control this behaviour. Unfortunately, it is still under development and not yet supported in any browser (it’s currently behind a flag in Chrome and Opera). However, we can implement the same behaviour in all browsers using [Font Face Observer](https://github.com/bramstein/fontfaceobserver).

You can trick browsers that use <abbr>FOIT</abbr> into rendering fallback fonts immediately by only using fully loaded web fonts in your font stack. If a web font is not in your font stack while it is being downloaded, those browsers will not attempt to hide text.

The easiest way to do this is by setting a class on your `html` element for each of the three loading state of web fonts: loading, loaded, and failed. The `fonts-loading` class is set as soon as font loading starts. The `fonts-loaded` class is added when fonts load, and the `fonts-failed` class is added when they fail to load.

```javascript
var font = new FontFaceObserver('Output Sans');
var html = document.documentElement;

html.classList.add('fonts-loading');

font.load().then(function () {
  html.classList.remove('fonts-loading');
  html.classList.add('fonts-loaded');
}).catch(function () {
  html.classList.remove('fonts-loading');
  html.classList.add('fonts-failed');
});
```

Using these three classes and some simple <abbr>CSS</abbr> you can implement <abbr>FOUT</abbr> that works across all browsers. We start by defining fallback fonts for all elements that will use web fonts. When the `fonts-loaded` class is present on the `html` element we apply the web font by changing the font stack for those elements. This will force the browser to load the web font, but because the font has already loaded it will be rendered almost instantaneously.

```css
body {
  font-family: Verdana, sans-serif;
}

.fonts-loaded body {
  font-family: Output Sans, Verdana, sans-serif;
}
```

Loading web fonts this way might remind you of progressive enhancement. This is not a coincidence. The Flash Of Unstyled Text is progressive enhancement. The default experience is rendered using fallback fonts, and then enhanced with web fonts.

Implementing <abbr>FOIT</abbr> is equally simple. When web fonts start loading you hide content that is using web fonts, and when the web fonts load you display the content again. Take care to also deal with failure. Your content should be accessible even if your web fonts fail to load.

```css
.fonts-loading body {
  visibility: hidden;
}

.fonts-loaded body,
.fonts-failed body {
  visibility: visible;
}
```

Does hiding content like this make you uncomfortable? Good. It should. Hiding content should only be used in very special circumstances, for example if there is no good fallback for your web font, or if you know the font is already cached.

## Optimise for caching

The other font loading patterns let you customise when and how fonts load. Often you want your code to behave differently if a font is already in the cache. For example, if a font is cached, there is no need to render fallback fonts first. We can accomplish this by keeping track of the cache state of web fonts using session storage.

When a font loads we set a boolean flag in the session storage. This flag will stored throughout a browse session, so it is a fairly good indicator for whether or not a file is in the browser cache.

```javascript
var font = new FontFaceObserver('Output Sans');

font.load().then(function () {
  sessionStorage.fontsLoaded = true;
}).catch(function () {
  sessionStorage.fontsLoaded = false;
});
```

You can then use this information to change your font loading strategy when the font is cached. For example you can include the following JavaScript snippet in the `head` element of your page to immediately render web fonts.

```javascript
if (sessionStorage.fontsLoaded) {
  var html = document.documentElement;

  html.classList.add('fonts-loaded');
}
```

If you’re loading fonts this way your visitors will experience <abbr>FOUT</abbr> the first time they visit your site, but subsequent pages will render web fonts immediately. This means you can have progressive enhancement and still have a good user experience without distracting your repeat visitors.
