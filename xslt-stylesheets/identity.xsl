<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  
  <xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>

  <xsl:preserve-space elements=""/>
  <xsl:strip-space elements=""/>
  
  <!-- identity transformation -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- cutting a whole branch -->
  <xsl:template match="/root/meta"/>

  <!-- skipping an element, but apply templates to children -->
  <xsl:template match="skip">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- expanding an element -->
  <xsl:template match="section">
    <xsl:copy>
      <subsection>
	<xsl:apply-templates/>
      </subsection>
    </xsl:copy>
  </xsl:template>

  <!-- applying templates to the first child of an element only -->
  <xsl:template match="choice">
    <xsl:apply-templates select="*[1]"/>
  </xsl:template>

  <!-- relocating an element -->
  <xsl:template match="chapter[following-sibling::chapter[1][relocate]]"><!-- matching the path of relocation relative to the element to be relocated, read: chapter that has as the first following sibling namend "chapter" which has a child namend "relocate" -->
    <xsl:copy>
      <xsl:apply-templates/>
      <xsl:apply-templates select="following-sibling::chapter[1]/relocate/*"/>
    </xsl:copy>
  </xsl:template>

  <!-- now the old relocate element has to be excluded from the identity transformation to avoid duplication -->
  <xsl:template match="relocate"/>

  <!-- collapsing elements to attributes -->
  <xsl:template match="reading">
    <xsl:copy>
      <xsl:attribute name="wit">
	<xsl:value-of select="witness"/>
      </xsl:attribute>
      <xsl:apply-templates select="text()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
