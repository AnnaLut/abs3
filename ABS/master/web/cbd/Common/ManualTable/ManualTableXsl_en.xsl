<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!--ID=Код;VAL=Описание-->
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; width: 400px; border-collapse: collapse;">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold; CURSOR: hand">
<TD width="100px" title="Code"><xsl:attribute name="onclick"><xsl:text>Sort('ID')</xsl:text></xsl:attribute>
<xsl:text>Code</xsl:text></TD>

<TD width="297px" title="Description"><xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
<xsl:text>Description</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<TR>
<xsl:attribute name="onclick"><xsl:text>ReturnResult('</xsl:text><xsl:value-of select="ID"/><xsl:text>','</xsl:text><xsl:value-of select="NAME"/><xsl:text>')</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>

<TD align="left" title="Select" style="CURSOR: hand; COLOR: blue; TEXT-DECORATION: underline"><xsl:value-of select="ID" /></TD>
<TD align="left"><xsl:value-of select="translate(NAME,'~',' ')" /></TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>