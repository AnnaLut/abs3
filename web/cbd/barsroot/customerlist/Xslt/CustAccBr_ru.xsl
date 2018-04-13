<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' minus-sign=' '/>
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD>
	<xsl:attribute name="onclick"><xsl:text>Sort('NlS')</xsl:text></xsl:attribute>
	<xsl:text>Номер счета</xsl:text>
</TD>
<TD>
	<xsl:attribute name="onclick"><xsl:text>Sort('LCV')</xsl:text></xsl:attribute>
	<xsl:text>Вал юта</xsl:text>
	</TD>
<TD width="40%">
	<xsl:attribute name="onclick"><xsl:text>Sort('NMS')</xsl:text></xsl:attribute>
	<xsl:text>Наименование счета</xsl:text>
</TD>
<TD width="15%">
	<xsl:attribute name="onclick"><xsl:text>Sort('OST')</xsl:text></xsl:attribute>
	<xsl:text>Входящий остаток</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick"><xsl:text>Sort('DOS')</xsl:text></xsl:attribute>
	<xsl:text>Обороты Дебет</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick"><xsl:text>Sort('KOS')</xsl:text></xsl:attribute>
	<xsl:text>Обороты Кредит</xsl:text>
</TD>
<TD width="15%">
	<xsl:attribute name="onclick"><xsl:text>Sort('OSTC')</xsl:text></xsl:attribute>
	<xsl:text>Фактический остаток</xsl:text>
</TD>
<TD width="15%">
	<xsl:attribute name="onclick"><xsl:text>Sort('OSTB')</xsl:text></xsl:attribute>
	<xsl:text>Плановый остаток</xsl:text>
</TD>
<TD>
	<xsl:attribute name="onclick"><xsl:text>Sort('a.DAPP')</xsl:text></xsl:attribute>
	<xsl:text>Дата посл. движ.</xsl:text>
</TD>
<TD>
	<xsl:attribute name="onclick"><xsl:text>Sort('PAP')</xsl:text></xsl:attribute>
	<xsl:text>Акт Пас</xsl:text>
</TD>
<TD>
	<xsl:attribute name="onclick"><xsl:text>Sort('TIP')</xsl:text></xsl:attribute>
	<xsl:text>Тип счета</xsl:text>
</TD>
<TD>
  <xsl:attribute name="onclick"><xsl:text>Sort('TOBO')</xsl:text></xsl:attribute>
  <xsl:text>Код безбал. отд.</xsl:text>
</TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="ACC" />
<xsl:variable name="mode" select="MOD" />
<xsl:variable name="frmtStr" select="concat('###### ##0.',substring(DIG,2))" />
<TR>
<xsl:if test="$mode=2"><xsl:attribute name="style">color:#8080FF</xsl:attribute></xsl:if>
<xsl:attribute name="onclick"><xsl:text>HidePopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>,</xsl:text><xsl:value-of select="$mode"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>fnShowHistAcc()</xsl:text></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>ShowPopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>,</xsl:text><xsl:value-of select="$mode"/><xsl:text>);return false</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<TD><xsl:value-of select="NLS" /></TD>
<TD align="center"><xsl:value-of select="LCV" /></TD>
<TD noWrap="true">
	<xsl:value-of select="NMS" />
</TD>
<TD align="right" noWrap="true">
	<xsl:if test="OST&gt;0"><xsl:attribute name="style">COLOR: darkblue</xsl:attribute></xsl:if>
	<xsl:if test="OST&lt;0"><xsl:attribute name="style">COLOR: red</xsl:attribute></xsl:if>
	<xsl:value-of select="format-number(OST div DIG, $frmtStr, 'ua')" />	
</TD>
<TD align="right" noWrap="true">
	<xsl:value-of select="format-number(DOS div DIG,$frmtStr,'ua')" />
</TD>
<TD align="right" noWrap="true">
	<xsl:value-of select="format-number(KOS div DIG,$frmtStr,'ua')" />
</TD>
<TD align="right" noWrap="true">
	<xsl:if test="OSTC&gt;0"><xsl:attribute name="style">COLOR: darkblue</xsl:attribute></xsl:if>
	<xsl:if test="OSTC&lt;0"><xsl:attribute name="style">COLOR: red</xsl:attribute></xsl:if>
	<xsl:value-of select="format-number(OSTC div DIG, $frmtStr, 'ua')" />
</TD>
<TD align="right" noWrap="true">
	<xsl:if test="OSTB&gt;0"><xsl:attribute name="style">COLOR: darkblue</xsl:attribute></xsl:if>
	<xsl:if test="OSTB&lt;0"><xsl:attribute name="style">COLOR: red</xsl:attribute></xsl:if>
	<xsl:value-of select="format-number(OSTB div DIG, $frmtStr, 'ua')" />
</TD>
<TD  noWrap="true">
	<xsl:value-of select="DAPP" />
</TD>
<TD align="center">
	<xsl:value-of select="PAP" />
</TD>
<TD align="center">
	<xsl:value-of select="TIP" />
</TD>
<TD>
  <xsl:value-of select="TOBO" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>