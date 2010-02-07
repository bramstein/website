<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output 
		indent="yes"
		method="html" 
		encoding="utf-8"/>
		
	<!--<xsl:strip-space elements="*"/>-->
	

	<xsl:template match="article" mode="#all">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title><xsl:value-of select="title/text()"/> - bramstein.com</title>
				<link rel="alternate" type="application/rss+xml" title="RSS Feed for www.bramstein.com" href="/rss.xml" />
				<link rel="stylesheet" href="/undohtml.css" />
				<link rel="stylesheet" href="/main.css" />
				<xsl:comment><![CDATA[[if lte IE 6]>
		<script type="text/javascript" src="/supersleight.min.js"></script>
		<![endif]]]></xsl:comment>
				<xsl:comment><![CDATA[[if IE 7]>
		<link rel="stylesheet" href="/ie.css" />
		<![endif]]]></xsl:comment>
			</head>
			<body>
				<div id="header">
					<img id="logo" alt="bramstein logo" width="85" height="14" src="/images/logo_small.png"/>
					<ul>
						<xsl:choose>
							<xsl:when test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">
								<li><a class="here" href="/">Home</a></li>
							</xsl:when>
							<xsl:otherwise>
								<li><a href="/">Home</a></li>
							</xsl:otherwise>
						</xsl:choose>

						<xsl:choose>
							<xsl:when test="contains(document-uri(/), '/projects/')">
								<li><a title="Programming and design projects" class="here" href="/projects/">Projects</a></li>
							</xsl:when>
							<xsl:otherwise>
								<li><a title="Programming and design projects" href="/projects/">Projects</a></li>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(document-uri(/), '/articles/')">
								<li><a title="Articles on programming" class="here" href="/articles/">Articles</a></li>
							</xsl:when>
							<xsl:otherwise>
								<li><a title="Articles on programming" href="/articles/">Articles</a></li>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="contains(document-uri(/), '/about/')">
								<li><a class="last here" title="About Bram Stein" href="/about/">About</a></li>
							</xsl:when>
							<xsl:otherwise>
								<li><a class="last" title="About Bram Stein" href="/about/">About</a></li>
							</xsl:otherwise>
						</xsl:choose>
					</ul>
				</div>
				<xsl:choose>
					<xsl:when test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">
						<div id="subheader">
						</div>
					</xsl:when>
					<xsl:otherwise>
						<div id="subheader-small">
						</div>
					</xsl:otherwise>
				</xsl:choose>
				<div id="content">
					<xsl:choose>
					<xsl:when test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">

						<xsl:for-each-group select="*[position() lt 15]" group-adjacent="local-name()">
							<xsl:choose>
								<xsl:when test="current-grouping-key() eq 'sidebar'">
									<div class="sidebar">
										<xsl:for-each select="current-group()">
											<xsl:apply-templates select="child::node()"/>
										</xsl:for-each>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="current-group()"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
						<div class="section archive">
							<p><a href="/news/">Archived news</a></p>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each-group select="*" group-adjacent="local-name()">
							<xsl:choose>
								<xsl:when test="current-grouping-key() eq 'sidebar'">
									<div class="sidebar">
										<xsl:for-each select="current-group()">
											<xsl:apply-templates select="child::node()"/>
										</xsl:for-each>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="current-group()"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each-group>
					</xsl:otherwise>
					</xsl:choose>
				</div>
				<xsl:choose>
					<xsl:when test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">
						<div id="footer-small">
						</div>
					</xsl:when>
					<xsl:otherwise>
				      <div id="footer">
						<div class="columns">
							<div class="left-column">
								<h2>Project updates</h2>
								<p><a href="/projects/column/"><em>jQuery column selector</em> ― A plugin for the jQuery JavaScript library which adds a table column cell selector</a>.</p>
								<p><a href="/projects/jlayout/"><em>jLayout</em> ― The jLayout JavaScript library provides layout algorithms for laying out components and containers</a>.</p>
								<p><a href="/projects/junify/"><em>JUnify</em> ― JUnify is a JavaScript library for performing unification on objects and arrays</a>.</p>
								<p><a href="/projects/xsltjson/"><em>XSLTJSON</em> ― XSLTJSON is an <abbr>XSLT</abbr> 2.0 stylesheet to transform
						               arbitrary <abbr>XML</abbr> to JavaScript Object Notation
						               (<abbr>JSON</abbr>)</a>.</p>
								
								<p><a href="/projects/jsizes/"><em>JSizes</em> ― A small plugin for the jQuery JavaScript library which adds support for various size related <abbr>CSS</abbr> properties</a>.</p>
							</div>
							<div class="right-column">
								<h2>Latest articles</h2>
								<ul>
									<li><p><a href="/articles/advanced-pattern-matching.html">Advanced pattern matching in JavaScript</a></p></li>
					               <li>
					                  
					                  <p><a href="/articles/extracting-object-values.html">Extracting
					                        values from JavaScript objects</a></p>
					               </li>
					               <li>
					                  
					                  <p><a href="/articles/pattern-matching.html">Pattern matching
					                        in JavaScript</a></p>
					               </li>

									<li><p><a href="/articles/gettingstarted.html">GUI - Getting started</a></p></li>
									<li><p><a href="/articles/fontengine.html">GUI - Writing your own font engine</a></p></li>
									<li><p><a href="/articles/selection.html">GUI - How selection works</a></p></li>
								</ul>
							</div>
						</div>
					  </div>

				</xsl:otherwise>
			</xsl:choose>
			<div id="footer-navigation">
				<p>Copyright 2008-2010, Bram Stein. All rights reserved.</p>
				<ul>
					<li><a href="/">Home</a></li>
					<li><a href="/projects/">Projects</a></li>
					<li><a href="/articles/">Articles</a></li>
					<li><a href="/about/">About</a></li>
				</ul>
			</div>

			<script type="text/javascript">
			<![CDATA[
				var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
				document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
			]]>
			</script>
			<script type="text/javascript">
			<![CDATA[
			try {
				var pageTracker = _gat._getTracker("UA-10076742-1");
				pageTracker._trackPageview();
			} catch(err) {
			}
			]]>
			</script>

			<xsl:if test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">
				<script type="text/javascript" src="http://twitter.com/javascripts/blogger.js"></script>
				<script type="text/javascript" src="http://twitter.com/statuses/user_timeline/bram_stein.json?callback=twitterCallback2&amp;count=5"></script>	
			</xsl:if>
<!--
			<script type="text/javascript">
				<![CDATA[
				(function() {
					var links = document.getElementsByTagName('a');
					var query = '?';
					for(var i = 0; i < links.length; i++) {
						if(links[i].href.indexOf('#disqus_thread') >= 0) {
							query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
						}
					}
					document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/bramstein/get_num_replies.js' + query + '"></' + 'script>');
				})();
				]]>
			</script>
-->
			</body>
		</html>
	</xsl:template>

	<xsl:template match="cdata">
		<xsl:copy-of select="./*"/>
	</xsl:template>

	<xsl:template match="imagedata">
		<img alt="" src="{@fileref}"/>
	</xsl:template>

	<xsl:template match="articleinfo">
	</xsl:template>
	
	<xsl:template match="abstract">
		<div class="sidebar">
			<h3>Abstract</h3>
			<xsl:apply-templates select="*"/>
		</div>
	</xsl:template>
	
	<xsl:template match="section">
		<div class="section">
			<xsl:for-each-group select="*" group-adjacent="local-name()">
				<xsl:choose>
					<xsl:when test="current-group()[1]/local-name() eq 'sidebar'">
						<div class="sidebar">
							<xsl:for-each select="current-group()">
								<xsl:apply-templates select="child::node()"/>
							</xsl:for-each>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="current-group()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each-group>
		</div>
	</xsl:template>
	
	<xsl:template match="title">
		<xsl:variable name="depth" select="count(ancestor-or-self::section) + (if (exists(parent::sidebar)) then 3 else 1)"/>
		<xsl:element name="h{ if($depth lt 7) then $depth else '6'}">
	
			<xsl:apply-templates select="child::node()"/>
			
		</xsl:element>
	</xsl:template>

	<xsl:template match="subtitle">
		<xsl:variable name="parent-position"><xsl:number count="section"/></xsl:variable>
		<xsl:variable name="total"><xsl:value-of select="count(ancestor-or-self::article/section)"/></xsl:variable>
		<p class="subtitle"><xsl:apply-templates select="child::node()"/>
			<!--
			<xsl:if test="not(contains(document-uri(/), '/projects/')) and not(contains(document-uri(/), '/articles/')) and not(contains(document-uri(/), '/about/'))">
				<xsl:text>, </xsl:text>
				<a href="/news/{concat(replace(lower-case(string(normalize-space(preceding-sibling::title))), '\s', '-'), '-' , ($total - $parent-position) + 1)}.html#disqus_thread">View comments</a>
			</xsl:if>
			-->
		</p>
	</xsl:template>
	
	<xsl:template match="para">
		<xsl:for-each select="footnote">
			<xsl:variable name="p"><xsl:number level="any"/></xsl:variable>
			<div class="footnote">
				<!--
				<p></p>
				<xsl:apply-templates select="child::node()"/>
				-->
				<xsl:for-each select="para">
					<xsl:choose>
						<xsl:when test="position() eq 1">
							<p>
								<a name="#{$p}"><xsl:value-of select="$p"/></a>)<xsl:text> </xsl:text>
								<xsl:apply-templates select="child::node()"/>
							</p>
						</xsl:when>
						<xsl:otherwise>
							<p>
								<xsl:apply-templates select="child::node()"/>
							</p>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</div>
		</xsl:for-each>
		<p>
			<xsl:apply-templates select="child::node()"/>
		</p>
	</xsl:template>

	<xsl:template match="footnote">
		<xsl:variable name="p"><xsl:number level="any"/></xsl:variable>
		<sup><a href="#{$p}"><xsl:value-of select="$p"/></a></sup>
		<!--
		<div class="footnote">
			<sup><a name="#{@id}"><xsl:value-of select="$p"/></a></sup>
			<xsl:apply-templates select="para/child::node()"/>
		</div>
		-->
	</xsl:template>

	<xsl:template match="thead">
		<thead>
			<xsl:apply-templates mode="head"/>
		</thead>
	</xsl:template>

	<xsl:template match="tbody">
		<tbody>
			<xsl:apply-templates mode="body"/>
		</tbody>
	</xsl:template>

	<xsl:template match="row" mode="head">
		<tr>
			<xsl:apply-templates mode="head"/>
		</tr>
	</xsl:template>

	<xsl:template match="row" mode="body">
		<tr>
			<xsl:apply-templates mode="body"/>
		</tr>
	</xsl:template>

	<xsl:template match="entry" mode="head">
		<th>
			<xsl:apply-templates/>
		</th>
	</xsl:template>

	<xsl:template match="entry" mode="body">
		<td>
			<xsl:apply-templates/>
		</td>
	</xsl:template>

	<xsl:template match="table">
		<div class="table">
			<table>
				<caption><xsl:value-of select="title/text()"/></caption>
				<xsl:apply-templates select="tgroup/thead"/>
				<xsl:apply-templates select="tgroup/tbody"/>
			</table>
		</div>
	</xsl:template>

	<xsl:template match="footnoteref">
		<sup><a href="#{@linkend}">num</a></sup>
	</xsl:template>	

	<xsl:template match="note">
		<div class="note">
			<xsl:apply-templates select="child::node()"/>
		</div>
	</xsl:template>
	
	<xsl:template match="acronym">
		<abbr><xsl:value-of select="."/></abbr>
	</xsl:template>
	
	<xsl:template match="ulink">
		<a href="{@url}"><xsl:value-of select="."/></a>
	</xsl:template>
	
	<xsl:template match="literal">
		<code class="literal">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="filename">
		<code class="filename">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="classname">
		<code class="classname">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="methodname">
		<code class="methodname">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="varname">
		<code class="varname">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="constant">
		<code class="constant">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="interfacename">
		<code class="interfacename">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>

	<xsl:template match="property">
		<code class="property">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="function">
		<code class="function">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>

	<xsl:template match="type">
		<code class="type">
			<xsl:value-of select="."/>
		</code>
	</xsl:template>
	
	<xsl:template match="example">
		<div class="example">
			<xsl:if test="title">
				<p class="caption"><xsl:value-of select="title/text()"/></p>
			</xsl:if>
			<xsl:if test="exists(@id)">
				<a name="#{@id}"/>
			</xsl:if>
			<xsl:apply-templates select="programlisting|graphic"/>
		</div>
	</xsl:template>
	
	
	<xsl:template match="xref">
		<xsl:variable name="linkend" select="@linkend"/>
		<xsl:variable name="target" select="//*[@id eq $linkend]"/>
		<xsl:for-each select="$target">
			“<a>
				<xsl:attribute name="href">#<xsl:value-of select="@id"/></xsl:attribute>
				<xsl:if test="exists(title)">
					<xsl:text/><xsl:value-of select="title/text()"/><xsl:text/>
				</xsl:if>
			</a>”
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="graphic">
		<div class="image">
			<img alt="" src="{@fileref}"/>
		</div>
	</xsl:template>
	
	<xsl:template match="blockquote">
		<blockquote>
			<xsl:apply-templates select="child::node()"/>
		</blockquote>
	</xsl:template>
	
	<xsl:template match="programlisting">
		<pre>
			<code class="programlisting prettyprint">
				<xsl:value-of select="."/>
			</code>
		</pre>
	</xsl:template>
	
	<xsl:template match="emphasis">
		<em><xsl:value-of select="."/></em>
	</xsl:template>
	
	<xsl:template match="itemizedlist">
		<ul>
			<xsl:if test="@id">
				<xsl:attribute name="id" select="@id"/>
			</xsl:if>
			<xsl:apply-templates select="listitem"/>
		</ul>
	</xsl:template>
	
	<xsl:template match="orderedlist">
		<ol>
			<xsl:apply-templates select="listitem"/>
		</ol>
	</xsl:template>
	
	<xsl:template match="listitem">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template match="variablelist">
		<dl>
			<xsl:apply-templates/>
		</dl>
	</xsl:template>

	<xsl:template match="code">
		<code>
			<xsl:apply-templates/>
		</code>
	</xsl:template>

	<xsl:template match="varlistentry">
		<dt><xsl:apply-templates select="term"/></dt>
		<dd><xsl:apply-templates select="listitem/child::node()"/></dd>
	</xsl:template>
	
</xsl:stylesheet>
