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
		<xsl:variable name="a">
			<article>
				<title>Archived news</title>
				<section>
				    <title>Archived news</title>
				<xsl:for-each select="article/section">
					<xsl:variable name="url" select="concat('/', $dir, '/', replace(lower-case(string(normalize-space(title))), '\s', '-'), '-' , ($total - position()) + 1, '.html')"/>
						<section>
							<title><ulink url="{$url}"><xsl:value-of select="string(title)"/></ulink></title>
							<subtitle><xsl:value-of select="string(subtitle)"/></subtitle>
						</section>
					</xsl:for-each>
				</section>
			</article>
		</xsl:variable>

		<xsl:apply-templates select="$a" mode="import"/>
	</xsl:template>

	<xsl:template match="article" mode="import">
		<xsl:apply-imports/>		
	</xsl:template>
</xsl:stylesheet>
