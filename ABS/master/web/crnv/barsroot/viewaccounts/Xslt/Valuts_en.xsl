<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="0" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="5%"><xsl:text>Perf.</xsl:text></TD>
<TD width="10%"><xsl:attribute name="onclick"><xsl:text>Sort('LCV')</xsl:text></xsl:attribute>
<xsl:text>Code Of currency</xsl:text></TD>
<TD width="85%"><xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
<xsl:text>Currency</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="KV" />
<TR>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<TD align="center">
<INPUT>
 <xsl:attribute name="type"><xsl:text>checkbox</xsl:text></xsl:attribute>
 <xsl:attribute name="value"><xsl:value-of select="KV" /></xsl:attribute>
 <xsl:attribute name="onclick"><xsl:text>GetVal(this)</xsl:text></xsl:attribute>
</INPUT>
</TD>
<TD align="center"><xsl:value-of select="LCV" /></TD>
<TD><xsl:value-of select="NAME" /></TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>