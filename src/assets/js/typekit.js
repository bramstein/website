(function () {
  var typekit = document.createElement('script');
  typekit.src = 'https://use.typekit.net/sta3bzx.js';
  typekit.async = true;
  typekit.onload = function () {
    setTimeout(function () {
      Typekit.load();
    }, 0);
  };

  document.head.appendChild(typekit);

  window['_gaq'] = window['_gaq'] || [];
  window['_gaq'].push(['_setAccount', 'UA-10076742-1']);
  window['_gaq'].push(['_trackPageview']);

  var ga = document.createElement('script');
  ga.async = true;
  ga.src = 'https://ssl.google-analytics.com/ga.js';

  document.head.appendChild(ga);
}());
