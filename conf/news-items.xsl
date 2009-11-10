<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="docbook.xsl"/>
	
	<xsl:output 
		indent="yes"
		method="html" 
		encoding="utf-8"/>

	<xsl:param name="dir" select="'news'"/>

	<xsl:template match="/">
		<xsl:variable name="total" select="count(article/section)"/>
		<xsl:for-each select="article/section">
			<xsl:variable name="a">
				<article>
					<xsl:copy-of select="."/>
					<section>
						<title>Comments</title>
						<cdata>
							<div id="disqus_thread"></div>
							<script type="text/javascript" src="http://disqus.com/forums/bramstein/embed.js"></script>
							<noscript><a href="http://disqus.com/forums/bramstein/?url=ref">View the discussion thread.</a></noscript>
							<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>
						</cdata>

					</section>
				</article>
			</xsl:variable>

			<xsl:result-document href="{$dir}/{concat(replace(lower-case(string(normalize-space(title))), '\s', '-'), '-' , ($total - position()) + 1)}.html">
				<xsl:apply-templates select="$a" mode="import"/>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="article" mode="import">
		<xsl:apply-imports/>		
	</xsl:template>
</xsl:stylesheet>
