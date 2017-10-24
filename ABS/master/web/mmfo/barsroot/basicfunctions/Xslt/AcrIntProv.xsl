<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ISP')</xsl:text>
	</xsl:attribute>
<xsl:text>Исп</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ID')</xsl:text>
	</xsl:attribute>
<xsl:text>Код</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('TT')</xsl:text>
	</xsl:attribute>
<xsl:text>ОП</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('DK')</xsl:text>
	</xsl:attribute>
<xsl:text>Дб/ Кр</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NLSA')</xsl:text>
	</xsl:attribute>
<xsl:text>Счет А</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('KVA')</xsl:text>
	</xsl:attribute>
<xsl:text>Вал А</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NLSB')</xsl:text>
	</xsl:attribute>
<xsl:text>Счет Б</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('KVB')</xsl:text>
	</xsl:attribute>
<xsl:text>Вал Б</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ACRD')</xsl:text>
	</xsl:attribute>
<xsl:text>%% в номинале</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ACRDQ')</xsl:text>
	</xsl:attribute>
<xsl:text>Сумма вал-А</xsl:text>
</TD>
<TD width="30%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NAZN')</xsl:text>
	</xsl:attribute>
<xsl:text>Назначение платежа</xsl:text>
</TD>

</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="RID" />
<TR>
<xsl:attribute name="onclick"><xsl:text>HidePopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>ShowPopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="acc"><xsl:value-of select="ACC" /></xsl:attribute>
<xsl:attribute name="acrd"><xsl:value-of select="ACRDR" /></xsl:attribute>
<xsl:attribute name="nazn"><xsl:value-of select="NAZN" /></xsl:attribute>

<TD noWrap="true" align="center"><xsl:value-of select="ISP" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="ID" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="TT" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="DK" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="NLSA" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="KVA" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="NLSB" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="KVB" /></TD>
<TD noWrap="true" align="right">
	<xsl:choose>
		<xsl:when test="ACRD&gt;0">
			<xsl:attribute name="style">color:navy</xsl:attribute>
			<xsl:value-of select="format-number(ACRD,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="ACRD&lt;0">
			<xsl:attribute name="style">color:red</xsl:attribute>
			<xsl:value-of select="format-number(-ACRD,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="ACRD=0">
			<xsl:value-of select="format-number(ACRD,'##### #### ##0.00','ua')" />
		</xsl:when>
	</xsl:choose>
</TD>
<TD noWrap="true" align="right">
	<xsl:choose>
		<xsl:when test="ACRDQ&gt;0">
			<xsl:value-of select="format-number(ACRDQ,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="ACRDQ&lt;0">
			<xsl:value-of select="format-number(-ACRDQ,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="ACRDQ=0">
			<xsl:value-of select="format-number(ACRDQ,'##### #### ##0.00','ua')" />
		</xsl:when>
	</xsl:choose>
</TD>
<TD noWrap="true"><xsl:value-of select="NAZN" /></TD>

</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>