<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" id="dGridDog" cellpadding="2" bordercolor="Black" border="1" style="background-color:white;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<xsl:attribute name="onkeydown"><xsl:text>KeyPress(107)</xsl:text></xsl:attribute>
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="1%">
<xsl:attribute name="onclick"><xsl:text>Sort('POS')</xsl:text></xsl:attribute>
<xsl:text>№ п\п</xsl:text>
</TD>
<TD width="25%">
<xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
<xsl:text>Найменування</xsl:text>
</TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="normalize-space(ND)" />
<TR>
<xsl:attribute name="value"><xsl:value-of select="ND" /></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>Enter('</xsl:text><xsl:value-of select="$id"/><xsl:text>')</xsl:text></xsl:attribute>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false;</xsl:text></xsl:attribute>

<xsl:attribute name="NLS"><xsl:value-of select="NLS" /></xsl:attribute>
<xsl:attribute name="NMS"><xsl:value-of select="NMS" /></xsl:attribute>
<xsl:attribute name="SK"><xsl:value-of select="SK" /></xsl:attribute>
<xsl:attribute name="SKN"><xsl:value-of select="SKN" /></xsl:attribute>
<xsl:attribute name="MFO"><xsl:value-of select="MFO" /></xsl:attribute>
<xsl:attribute name="OKPO"><xsl:value-of select="OKPO" /></xsl:attribute>
<xsl:attribute name="NMSB"><xsl:value-of select="NMSB" /></xsl:attribute>
<xsl:attribute name="NB"><xsl:value-of select="NB" /></xsl:attribute>
<xsl:attribute name="NLSB"><xsl:value-of select="NLSB" /></xsl:attribute>
<xsl:attribute name="NAZN"><xsl:value-of select="NAZN" /></xsl:attribute>
<xsl:attribute name="NAME"><xsl:value-of select="NAME" /></xsl:attribute>
<xsl:attribute name="TT"><xsl:value-of select="TT" /></xsl:attribute>
<xsl:attribute name="NAK"><xsl:value-of select="NAK" /></xsl:attribute>
<xsl:attribute name="GRP"><xsl:value-of select="GRP" /></xsl:attribute>
<xsl:attribute name="ACC6F"><xsl:value-of select="ACC6F" /></xsl:attribute>
<xsl:attribute name="ACC6U"><xsl:value-of select="ACC6U" /></xsl:attribute>
<xsl:attribute name="ACC3U"><xsl:value-of select="ACC3U" /></xsl:attribute>
<xsl:attribute name="VOB"><xsl:value-of select="VOB" /></xsl:attribute>
<xsl:attribute name="SUM"><xsl:value-of select="SUM" /></xsl:attribute>

<TD align="center">
	<xsl:if test="ND&lt;0"><xsl:attribute name="style">color:red</xsl:attribute></xsl:if>
	<xsl:value-of select="POS" />
</TD>
<TD noWrap="true">
	<xsl:if test="ND&lt;0"><xsl:attribute name="style">color:red</xsl:attribute></xsl:if>
	<xsl:value-of select="NAME" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>