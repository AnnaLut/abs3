<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' minus-sign=' '/>
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="1" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; width: 100%;border-collapse: collapse;">
<TR align="center" vAlign="middle" noWrap="true" cellpadding="2" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold; CURSOR: hand">

<TD title="Date of motion"><xsl:attribute name="onclick"><xsl:text>Sort('FDAT')</xsl:text></xsl:attribute>
<xsl:text>Date of motion</xsl:text></TD>

<TD title="Incoming balance"><xsl:attribute name="onclick"><xsl:text>Sort('ch_OSTF')</xsl:text></xsl:attribute>
<xsl:text>Inc. bal.</xsl:text></TD>

<TD><xsl:attribute name="onclick"><xsl:text>Sort('ch_DOS')</xsl:text></xsl:attribute>
<xsl:text>Debit</xsl:text></TD>

<TD><xsl:attribute name="onclick"><xsl:text>Sort('ch_KOS')</xsl:text></xsl:attribute>
<xsl:text>Credit</xsl:text></TD>

<TD title="Outcoming balance"><xsl:attribute name="onclick"><xsl:text>Sort('ch_OST')</xsl:text></xsl:attribute>
<xsl:text>Outc. bal.</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="concat(ACC, CH_FDAT)" />
<xsl:variable name="frmtStr" select="concat('###### ##0.',substring(DIG,2))" />
<TR>
	<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
	<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>

	<TD align="center" title="Extract on an account" style="CURSOR: hand; COLOR: blue; TEXT-DECORATION: underline"><xsl:attribute name="onclick"><xsl:text>OpenAccExtract('</xsl:text><xsl:value-of select="ACC" /><xsl:text>','</xsl:text><xsl:value-of select="CH_FDAT" /><xsl:text>')</xsl:text></xsl:attribute><xsl:value-of select="CH_FDAT" /></TD>
	<TD align="right" noWrap="true">
		<xsl:if test="CH_OSTF&gt;0"><xsl:attribute name="style">COLOR: darkblue</xsl:attribute></xsl:if>
		<xsl:if test="CH_OSTF&lt;0"><xsl:attribute name="style">COLOR: red</xsl:attribute></xsl:if>
		<xsl:value-of select="format-number(CH_OSTF div DIG, $frmtStr, 'ua')" />
	</TD>
	<TD align="right" noWrap="true">
		<xsl:value-of select="format-number(CH_DOS div DIG, $frmtStr, 'ua')" />
	</TD>
	<TD align="right" noWrap="true">
		<xsl:value-of select="format-number(CH_KOS div DIG, $frmtStr, 'ua')" />
	</TD>
	<TD align="right" noWrap="true">
		<xsl:if test="CH_OST&gt;0"><xsl:attribute name="style">COLOR: darkblue</xsl:attribute></xsl:if>
		<xsl:if test="CH_OST&lt;0"><xsl:attribute name="style">COLOR: red</xsl:attribute></xsl:if>
		<xsl:value-of select="format-number(CH_OST div DIG, $frmtStr, 'ua')" />
	</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>