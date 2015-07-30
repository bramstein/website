---
template: content.html
title: "Detecting System Fonts Without Flash"
classes: writing
---

<style>
  #fonts {
    background-color: #f2f2f2;
    text-align: left;
    column-count: 1;
    -webkit-column-count: 1;
    -moz-column-count: 1;
    padding: 1.5em;
    color: #444;
  }

  @media (min-width: 600px) {
    #fonts {
      -webkit-column-count: 3;
      -moz-column-count: 3;
      column-count: 3;
    }
  }

  #fonts li {
    -webkit-column-break-inside: avoid;
    break-inside: avoid;
    display: block;
    line-height: 2.5em;
    margin: 0;
    opacity: 0.4;
  }

  #fonts li:before {
    font-family: sans-serif;
    width: 1.3em;
    display: inline-block;
    content: '✗';
    text-align: center;
    opacity: 0.7;
  }

  #fonts li.available {
    opacity: 0.9;
  }

  #fonts li.available:before {
    content: '✓';
  }
</style>

# Detecting System Fonts Without Flash
<p class="subtitle">July 30, 2015</p>

Many web-based text editors allow the user to select custom fonts through a drop down menu. These font menus often include system fonts. Unfortunately, there is no web platform <abbr>API</abbr> for retrieving a list of locally installed fonts, so many of these applications rely on a [Flash library](http://www.maratz.com/blog/archives/2006/08/18/detect-visitors-fonts-with-flash/) to detect which fonts are installed on the user’s system.

![Google Docs font menu](/assets/images/google-docs-font-menu.png)

Besides the recent security issues, there are several good reasons for not using Flash. Its market share has dropped significantly in the last couple of years. There is also a good chance that someone visiting your site will not have Flash installed (pretty much a guarantee on iOS).

So, what should you do when you want to find out which fonts are installed locally? Well, you can actually use plain JavaScript to detect if a font is available or not. Here are some of the system fonts your computer claims to support:

<ul id="fonts"></ul>
<p class=caption>The result of detecting the availability of several common system fonts on your computer. The ones marked with ✓ are available on your computer; the ones marked with ✗ are not.</p>

The example above uses [FontFaceObserver](https://github.com/bramstein/fontfaceobserver/), a small JavaScript library I wrote for detecting when a web font loads. Even though FontFaceObserver was created for web fonts, it can also be used to detect locally installed fonts.

To check if a font is available you pass its name to the `FontFaceObserver` constructor and call the `check` method. If the returned promise is resolved the font is available locally; if the promise is rejected the font is not available.

```
var observer = new FontFaceObserver(‘Georgia’);

observer.check().then(function () {
  // Georgia is available
}, function () {
  // Georgia is not available
});
```

By doing this for each font in your font menu you can warn the user if some of their choices are not available (or look different).

## How does it work?

The idea behind [FontFaceObserver](https://github.com/bramstein/fontfaceobserver/) is very simple: create a span element with a known font family, measure its width, set the target font family, and measure the width again. If there is a difference in the width, you’ll know that the font has rendered and is thus available.

![](/assets/images/font-load-detection-one.png)

In the example above we use a span element with the string `BESbwy` rendered in the generic `sans-serif` font family. The string `BESbwy` is used because it contains characters that often have different width in many fonts. The initial width of the span using the `sans-serif` font family is 130 pixels.

We then change the `font-family` property of the span to include our target font. The target font is found and the browser redraws the span. Because the target font’s metrics (the widths of each individual character) are different the span changes its width to 126 pixels. The difference between the initial width and the target width means that the font is available.

This approach has a problem though. What would happen if the font we’re trying to detect is the same as the generic `sans-serif` font family? In this case the span would stay the same width and we wouldn’t be able to detect the font. To work around this problem FontFaceObserver uses three spans, one for each of the three generic font families: `sans-serif`, `serif`, and `monospace`.

![](/assets/images/font-load-detection-three.png)

In this example the font we’re trying to detect is the same as the generic `serif` font family. If we had used a single span with we wouldn’t be able to detect this font because the initial and target width are the same for the `serif` span. Because the other two spans have different initial widths we can safely assume the font has rendered and is available for use.

## Can I use it?

So how accurate is it? It works well on platforms that are truthful about which fonts are installed. Unfortunately, some platforms lie. For example, Android only ships with three fonts: Droid Sans, Droid Serif, and Droid Sans Monospace (or in more recent versions of Android: Roboto and Noto). Its graphics subsystem [maps](https://github.com/android/platform_frameworks_base/blob/master/data/fonts/fonts.xml#L35) common font family names to locally installed fonts. This means that from the point of view of the browser those fonts actually exist, even though they are in fact aliases to the same fonts. While this is disappointing, you could argue that those aliases were chosen because they are acceptable substitutes (well, let’s hope so).

[![Fontfamily.io](/assets/images/fontfamily.io.png)](http://fontfamily.io)

Font aliases are less common on other platforms, but still exist. Zach Leatherman’s [fontfamily.io](http://fontfamily.io/) is a great tool to find out which fonts are available on which platforms. It’ll also tell you if a font is aliased or not.

So, is this a reliable way to detect locally installed fonts? It really depends on your goals. I wouldn’t recommend using this to disable items in a font menu. However, it can be a helpful tool to pop up a warning when a “web safe” font isn’t installed locally. In the end, if your web application relies on the presence of a font, it is best to use web fonts instead of local fonts. You can be certain that web fonts will be available no matter the platform.

## Credits

Remy Sharp advocates a similar technique in his blog post on “[How to detect if a font is installed](https://remysharp.com/2008/07/08/how-to-detect-if-a-font-is-installed-only-using-javascript)”. His method relies on Comic Sans as a way to detect the existence of a locally installed font. Unfortunately this is unreliable on platforms that do not have Comic Sans (of which there are many).

Lalit Patel has implemented a [similar solution](http://www.lalit.org/lab/javascript-css-font-detect/) which uses the generic monospace font family. While this is better than using Comic Sans it can report false negatives for system fonts and metric compatible fonts.

Finally, Zach Leatherman uses the same technique for detecting locally installed fonts for [fontfamily.io](http://fontfamily.io/).

<script src="/assets/js/fontfaceobserver.js"></script>
<script>
  var fonts = {
    'Arial': ['Arial', 'sans-serif'],
    'Calibri': ['Calibri', 'sans-serif'],
    'Century Gothic': ['Century Gothic', 'sans-serif'],
    'Comic Sans': ['Comic Sans', 'Comic Sans MS', 'fantasy'],
    'Consolas': ['Consolas', 'monospace'],
    'Courier': ['Courier', 'Courier New', 'monospace'],
    'Dejavu Sans': ['Dejavu Sans', 'sans-serif'],
    'Dejavu Serif': ['Dejavu Serif', 'serif'],
    'Georgia': ['Georgia', 'serif'],
    'Gill Sans': ['Gill Sans', 'sans-serif'],
    'Helvetica': ['Helvetica Neue', 'Helvetica', 'sans-serif'],
    'Impact': ['Impact', 'sans-serif'],
    'Lucida Sans': ['Lucida Sans Unicode',  'Lucida Sans', 'sans-serif'],
    'Myriad Pro': ['Myriad Pro', 'sans-serif'],
    'Open Sans': ['Open Sans', 'sans-serif'],
    'Palatino': ['Palatino', 'Palatino Linotype', 'serif'],
    'Tahoma': ['Tahoma', 'sans-serif'],
    'Times New Roman': ['Times New Roman', 'Times', 'serif'],
    'Trebuchet': ['Trebuchet MS', 'sans-serif'],
    'Verdana': ['Verdana', 'sans-serif'],
    'Zapfino': ['Zapfino', 'cursive']
  };

  var list = document.getElementById('fonts');

  Object.keys(fonts).forEach(function (family) {
    var stack = fonts[family];
    var item = document.createElement('li');

    item.classList.add('maybe');
    item.setAttribute('data-font', family);
    item.textContent = family;
    item.style.fontFamily = stack.join(', ') + ', monospace';

    list.appendChild(item);
  });

  Object.keys(fonts).forEach(function (family) {
    var stack = fonts[family];
    
    stack.pop();
    
    var observer = new FontFaceObserver(stack.join(','));
    
    observer.check(null, 1000).then(function () {
      var item = document.querySelector('[data-font="' + family + '"]');

      item.classList.add('available');
    }, function () {});
  });
</script>


