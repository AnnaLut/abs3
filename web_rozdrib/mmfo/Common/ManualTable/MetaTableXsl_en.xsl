<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<xsl:variable name="col_count" select="count(//HEADER)" />
<xsl:for-each select="//TABNAME">
<div align="center" style="color:green;White;font-family:Verdana;font-size:8pt;"><xsl:text>Reference book:</xsl:text><xsl:value-of select="name" /></div>
</xsl:for-each>
<TABLE id="dGridMeta" cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<xsl:attribute name="onkeydown"><xsl:text>KeyPress();</xsl:text></xsl:attribute>
<TR id="header_row" align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<xsl:for-each select="//HEADER">
<TD>
<xsl:attribute name="onclick"><xsl:text>Sort('COL</xsl:text><xsl:value-of select="position()" />
<xsl:text>')</xsl:text></xsl:attribute>
<xsl:value-of select="head" /></TD>
</xsl:for-each>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="position()" />
<TR>
    <xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
    <xsl:attribute name="onclick"><xsl:text>ReturnResult('</xsl:text><xsl:value-of select="COL1"/><xsl:text>','</xsl:text><xsl:value-of select="COL2"/><xsl:text>','</xsl:text><xsl:value-of select="COL3"/><xsl:text>','</xsl:text><xsl:value-of select="COL4"/><xsl:text>','</xsl:text><xsl:value-of select="COL5"/><xsl:text>')</xsl:text></xsl:attribute>
    <xsl:attribute name="ondblclick"><xsl:text>ReturnResult('</xsl:text><xsl:value-of select="COL1"/><xsl:text>','</xsl:text><xsl:value-of select="COL2"/><xsl:text>','</xsl:text><xsl:value-of select="COL3"/><xsl:text>','</xsl:text><xsl:value-of select="COL4"/><xsl:text>','</xsl:text><xsl:value-of select="COL5"/><xsl:text>')</xsl:text></xsl:attribute>
    <xsl:attribute name="oncontextmenu"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false;</xsl:text></xsl:attribute>
	<xsl:if test="$col_count>=1">
	<TD noWrap="true"><xsl:attribute name="style">color:red</xsl:attribute>
	<xsl:value-of select="COL1" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=2">
	<TD noWrap="true"><xsl:attribute name="style">color:navy</xsl:attribute>
	<xsl:value-of select="COL2" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=3">
	<TD noWrap="true"><xsl:value-of select="COL3" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=4">
	<TD noWrap="true"><xsl:value-of select="COL4" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=5">
	<TD noWrap="true"><xsl:value-of select="COL5" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=6">
	<TD noWrap="true"><xsl:value-of select="COL6" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=7">
	<TD noWrap="true"><xsl:value-of select="COL7" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=8">
	<TD noWrap="true"><xsl:value-of select="COL8" /></TD>
	</xsl:if>
	<xsl:if test="$col_count>=9">
	<TD noWrap="true"><xsl:value-of select="COL9" /></TD>
	</xsl:if>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>
