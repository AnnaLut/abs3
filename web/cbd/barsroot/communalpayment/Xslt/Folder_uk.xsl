<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN=''/>
<xsl:template match="/">
<TABLE cellspacing="0" id="dGridFolder" cellpadding="2" bordercolor="Black" border="1" style="background-color:white;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<xsl:attribute name="onkeydown"><xsl:text>KeyPress();PressSpace()</xsl:text></xsl:attribute>
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="1%">
	<xsl:text>Вик.</xsl:text>
</TD>
<TD width="70%">
	<xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
	<xsl:text>Найменування</xsl:text>
</TD>
<TD width="29%">
	<xsl:attribute name="onclick"><xsl:text>Sort('SUM')</xsl:text></xsl:attribute>
	<xsl:text>Сума</xsl:text>
</TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="normalize-space(ND)" />
<TR>
<xsl:attribute name="value"><xsl:value-of select="ND" /></xsl:attribute>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false;</xsl:text></xsl:attribute>
<xsl:attribute name="TT"><xsl:value-of select="TT" /></xsl:attribute>
<TD align="center">
<INPUT>
 <xsl:attribute name="id"><xsl:value-of select="concat('cb_',position())" /></xsl:attribute>
 <xsl:attribute name="type"><xsl:text>checkbox</xsl:text></xsl:attribute>
</INPUT>
</TD>

<TD noWrap="true">
	<xsl:value-of select="NAME" />
</TD>
<TD align="right" noWrap="true">
<INPUT>
	<xsl:attribute name="id"><xsl:value-of select="concat('s_',position())" /></xsl:attribute>
	<xsl:attribute name="style"><xsl:text>text-align:center;width:100%;color:red;BORDER-TOP-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-LEFT-STYLE: none; BORDER-BOTTOM-STYLE: none</xsl:text></xsl:attribute>
	<xsl:attribute name="type"><xsl:text>text</xsl:text></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="format-number(SUM, '###### ##0.00##', 'ua')" /></xsl:attribute>
</INPUT>
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>