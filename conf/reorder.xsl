<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">

	<xsl:template match="para[following-sibling::*[1]/self::graphic]">
		<xsl:copy-of select="following-sibling::graphic[1]"/>
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="graphic[preceding-sibling::*[1]/self::para]">
	</xsl:template>

 <xsl:template match="node()|@*">
   <xsl:copy>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
   </xsl:copy>
 </xsl:template>
<!--
<xsl:template match="lastName[following-sibling::*[1]/self::firstName]">
  <xsl:copy-of select="following-sibling::firstName[1]"/>
  <xsl:copy-of select="."/>
</xsl:template>
<xsl:template match="firstName[preceding-sibling::*[1]/self::lastName]">
</xsl:template>
-->
</xsl:stylesheet>
