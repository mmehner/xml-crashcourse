<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  
  <xsl:output method="text" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

  <xsl:preserve-space elements="p l"/>
  <xsl:strip-space elements="*"/>

   <!-- variable for line break for some simple formatting -->
  <xsl:variable name="n">
    <xsl:text>
</xsl:text>
  </xsl:variable>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

   <xsl:template match="title">
    <xsl:apply-templates/>
    <xsl:value-of select="$n"/>
  </xsl:template>

  <xsl:template match="head">
    <xsl:value-of select="$n"/>
    <xsl:apply-templates/>
    <xsl:value-of select="$n"/>
  </xsl:template>

  <xsl:template match="p">
    <xsl:value-of select="$n"/>
    <xsl:value-of select="normalize-space()"/>
    <xsl:value-of select="$n"/>
  </xsl:template>

  <xsl:template match="lg">
    <xsl:apply-templates/>
    <xsl:value-of select="$n"/>
  </xsl:template>

  <xsl:template match="l">
    <xsl:value-of select="$n"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- append notes at the end of each division -->
  <xsl:template match="div[note[@target]]"><!-- match division with child note that has a target attribute -->
    <xsl:copy>
      <xsl:apply-templates/>
      <xsl:value-of select="$n"/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="//note[@target]"/>
      <xsl:text>]</xsl:text>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="note"/>
  
</xsl:stylesheet>
