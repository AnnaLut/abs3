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
<TD width="15%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NMS')</xsl:text>
	</xsl:attribute>
<xsl:text>Наименование счета</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NLS')</xsl:text>
	</xsl:attribute>
<xsl:text>Счет</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('LCV')</xsl:text>
	</xsl:attribute>
<xsl:text>Вал осн</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('a.DATF')</xsl:text>
	</xsl:attribute>
<xsl:text>С</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('a.DATT')</xsl:text>
	</xsl:attribute>
<xsl:text>По</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('IR')</xsl:text>
	</xsl:attribute>
<xsl:text>% Ставка</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('BR')</xsl:text>
	</xsl:attribute>
<xsl:text>Базовая Ставка</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ACRD')</xsl:text>
	</xsl:attribute>
<xsl:text>%% в номинале</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('OSTS')</xsl:text>
	</xsl:attribute>
<xsl:text>% число</xsl:text>
</TD>
<TD width="10%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('OSTA')</xsl:text>
	</xsl:attribute>
<xsl:text>Текущий остаток </xsl:text>
</TD>

</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="RID" />
<TR>
<xsl:attribute name="onclick"><xsl:text>HidePopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>ShowPopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="acrd"><xsl:value-of select="ACRDR" /></xsl:attribute>
<xsl:attribute name="acc"><xsl:value-of select="ACC" /></xsl:attribute>
<xsl:attribute name="nazn"><xsl:value-of select="NAZN" /></xsl:attribute>

<TD noWrap="true" align="center"><xsl:value-of select="ISP" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="ID" /></TD>
<TD noWrap="true"><xsl:value-of select="NMS" /></TD>
<TD noWrap="true"><xsl:value-of select="NLS" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="LCV" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="FDAT" /></TD>
<TD noWrap="true" align="center"><xsl:value-of select="TDAT" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="IR" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="format-number(BR,'####0.0000','ua')" /></TD>
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
	</xsl:choose>
</TD>
<TD noWrap="true" align="right">
	<xsl:choose>
		<xsl:when test="OSTS&gt;0">
			<xsl:attribute name="style">color:navy</xsl:attribute>
			<xsl:value-of select="format-number(OSTS,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="OSTS&lt;0">
			<xsl:attribute name="style">color:red</xsl:attribute>
			<xsl:value-of select="format-number(-OSTS,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="OSTS=0">
			<xsl:value-of select="format-number(OSTS,'##### #### ##0.00','ua')" />
		</xsl:when>
	</xsl:choose>
</TD>
<TD noWrap="true" align="right">
	<xsl:choose>
		<xsl:when test="OSTA&gt;0">
			<xsl:attribute name="style">color:navy</xsl:attribute>
			<xsl:value-of select="format-number(OSTA,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="OSTA&lt;0">
			<xsl:attribute name="style">color:red</xsl:attribute>
			<xsl:value-of select="format-number(-OSTA,'##### #### ##0.00','ua')" />
		</xsl:when>
		<xsl:when test="OSTA=0">
			<xsl:value-of select="format-number(OSTA,'##### #### ##0.00','ua')" />
		</xsl:when>
	</xsl:choose>
</TD>

</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>