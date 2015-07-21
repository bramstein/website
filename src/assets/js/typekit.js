(function () {
  var script = document.createElement('script');
  script.src = 'https://use.typekit.net/sta3bzx.js';
  script.async = true;
  script.onload = function () {
    setTimeout(function () {
      Typekit.load();
    }, 0);
  };
  document.head.appendChild(script);

  window['_gaq'] = window['_gaq'] || [];
  window['_gaq'].push(['_setAccount', 'UA-10076742-1']);
  window['_gaq'].push(['_trackPageview']);

  var ga = document.createElement('script');

  ga.type = 'text/javascript';
  ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';

  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(ga, s);
}());
