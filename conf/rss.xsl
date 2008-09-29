<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE stylesheet [
<!ENTITY great
"<xsl:text disable-output-escaping='yes'>&amp;gt;</xsl:text>">
<!ENTITY less
"<xsl:text disable-output-escaping='yes'>&amp;lt;</xsl:text>">
]>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output 
		indent="yes" 
		omit-xml-declaration="no" 
		method="xml" 
		encoding="utf-8"/>

	<xsl:template match="article">
		<rss version="2.0">
			<channel>
				<title>bramstein.com</title>
				<description>News and project updates</description>
				<link>http://www.bramstein.com/</link>
			</channel>
			<xsl:apply-templates select="section"/>
		</rss>
	</xsl:template>

	<xsl:template match="ulink">
		&less;a href="<xsl:value-of select="@url"/>"&great;<xsl:value-of select="."/>&less;/a&great;
	</xsl:template>

	<xsl:template match="para">
		&less;p&great;
			<xsl:apply-templates/>
		&less;/p&great;
	</xsl:template>

	<xsl:template match="title[ulink]">
		<title><xsl:value-of select="ulink/text()"/></title>
		<link><xsl:value-of select="ulink/@url"/></link>
	</xsl:template>

	<xsl:template match="title[not(ulink)]">
		<title><xsl:value-of select="."/></title>
	</xsl:template>

	<xsl:template match="section">
		<item>
			<xsl:apply-templates select="title"/>
			<description><xsl:apply-templates select="para"/></description>
		</item>
	</xsl:template>

</xsl:stylesheet>
