<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE id="tblVerif"  cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; border-collapse: collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold; CURSOR: hand">

<TD title="Референс документа"><xsl:attribute name="onclick"><xsl:text>Sort('a.REF')</xsl:text></xsl:attribute>
<xsl:text>Реф</xsl:text></TD>

<TD title="Номер документа"><xsl:attribute name="onclick"><xsl:text>Sort('a.ND')</xsl:text></xsl:attribute>
<xsl:text>№ док</xsl:text></TD>

<TD title="Исполнитель"><xsl:attribute name="onclick"><xsl:text>Sort('a.USERID')</xsl:text></xsl:attribute>
<xsl:text>Исп.</xsl:text></TD>

<TD width="100" title="Счет-А вериф">
<xsl:text>Счет-А вериф</xsl:text></TD>

<TD width="100" title="МФО-Б вериф">
<xsl:text>МФО-Б вериф</xsl:text></TD>

<TD width="100" title="Счет-Б вериф">
<xsl:text>Счет-Б вериф</xsl:text></TD>

<TD width="100" title="ОКПО-Б вериф">
<xsl:text>ОКПО-Б вериф</xsl:text></TD>

<TD width="120" title="Сумма верификации">
<xsl:text>Сумма вериф</xsl:text></TD>

<TD><xsl:attribute name="onclick"><xsl:text>Sort('a.NAZN')</xsl:text></xsl:attribute>
<xsl:text>Назначение платежа</xsl:text></TD>
</TR>  
  
<xsl:for-each select="//Table">
<xsl:variable name="id" select="REF" />
<TR>
<xsl:attribute name="style">COLOR: green</xsl:attribute>
<xsl:attribute name="onclick"><xsl:text>HidePopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>HideTextFields();ShowPopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="NLSA"><xsl:value-of select="NLSA" /></xsl:attribute>
<xsl:attribute name="NLSB"><xsl:value-of select="NLSB" /></xsl:attribute>
<xsl:attribute name="MFOB"><xsl:value-of select="MFOB" /></xsl:attribute>
<xsl:attribute name="ID_B"><xsl:value-of select="ID_B" /></xsl:attribute>
<xsl:attribute name="SUM"><xsl:value-of select="SUM" /></xsl:attribute>
  
<TD align="center"><xsl:value-of select="REF" /></TD>
<TD><xsl:value-of select="ND" /></TD>
<TD align="center"><xsl:value-of select="USERID" /></TD>
<TD>
  <xsl:attribute name="onclick"><xsl:text>showNlsA()</xsl:text></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="concat('c1_',position())" /></xsl:attribute>
</TD>
<TD>
  <xsl:attribute name="onclick"><xsl:text>showMfoB()</xsl:text></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="concat('c2_',position())" /></xsl:attribute>
</TD>
<TD>
  <xsl:attribute name="onclick"><xsl:text>showNlsB()</xsl:text></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="concat('c3_',position())" /></xsl:attribute>
</TD>
<TD>
  <xsl:attribute name="onclick"><xsl:text>showOkpoB()</xsl:text></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="concat('c4_',position())" /></xsl:attribute>
</TD>
<TD align="right">
  <xsl:attribute name="onclick"><xsl:text>showSum()</xsl:text></xsl:attribute>
  <xsl:attribute name="id"><xsl:value-of select="concat('c5_',position())" /></xsl:attribute>
</TD>
<TD noWrap="true"><xsl:value-of select="NAZN" /></TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>