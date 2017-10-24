<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" rules="all" bordercolor="Black" border="1" id="dGrid" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="10%">
<xsl:text>Бал. счет</xsl:text></TD>
<TD width="70%">
<xsl:text>Наименование балансового счета</xsl:text></TD>
<TD width="20%">
<xsl:text>Хар-ка</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="NBS" />
<TR>
<xsl:attribute name="onclick"><xsl:text>javascript:SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>','</xsl:text><xsl:value-of select="position()"/><xsl:text>')</xsl:text></xsl:attribute>
<TD><xsl:value-of select="NBS" /></TD>
<TD><xsl:value-of select="NAME" /></TD>
<TD><xsl:value-of select="XAR" /></TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>
