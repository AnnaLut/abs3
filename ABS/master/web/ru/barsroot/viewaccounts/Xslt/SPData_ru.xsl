<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!--PSEM= Наименование спецпараметра;VALUE=Значение-->
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="60%">
<xsl:attribute name="onclick"><xsl:text>Sort('PSEM')</xsl:text></xsl:attribute>
<xsl:text>Наименование спецпараметра</xsl:text></TD>
<TD width="30%">
<xsl:attribute name="onclick"><xsl:text>Sort('VALUE')</xsl:text></xsl:attribute>
<xsl:text>Значение</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('HREF')</xsl:text></xsl:attribute>
</TD></TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="normalize-space(SPID)" />
<TR>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="opt"><xsl:value-of select="OPT" /></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>Edit('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('PSEM_',position())" /></xsl:attribute>
<xsl:value-of select="PSEM" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('VALUE_',position())" /></xsl:attribute>
<xsl:value-of select="VALUE" />
</TD>
<TD align="center">
<xsl:attribute name="id"><xsl:value-of select="concat('HREF_',position())" /></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="PNSI" /></xsl:attribute>
<xsl:value-of disable-output-escaping="yes" select="HREF" />
</TD></TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>