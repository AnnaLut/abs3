<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!--FDAT=Дата события;ISP= Ид. исп.;FIO= ФИО исполнителя;TXT=Текст-->
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" rules="all" bordercolor="Black" border="1" id="dGrid" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="5%">
<xsl:attribute name="onclick"><xsl:text>Sort('ID')</xsl:text></xsl:attribute>
<xsl:text>№ п/п</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('FDAT')</xsl:text></xsl:attribute>
<xsl:text>Дата события</xsl:text></TD>
<TD width="5%">
<xsl:attribute name="onclick"><xsl:text>Sort('ISP')</xsl:text></xsl:attribute>
<xsl:text>Ид. исп.</xsl:text></TD>
<TD width="15%">
<xsl:attribute name="onclick"><xsl:text>Sort('FIO')</xsl:text></xsl:attribute>
<xsl:text>ФИО исполнителя</xsl:text></TD>
<TD width="60%">
<xsl:attribute name="onclick"><xsl:text>Sort('TXT')</xsl:text></xsl:attribute>
<xsl:text>Текст</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="normalize-space(ID)" />
<TR>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>Edit('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('ID_',position())" /></xsl:attribute>
<xsl:value-of select="ID" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('FDAT_',position())" /></xsl:attribute>
<xsl:value-of select="FDAT" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('ISP_',position())" /></xsl:attribute>
<xsl:value-of select="ISP" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('FIO_',position())" /></xsl:attribute>
<xsl:value-of select="FIO" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('TXT_',position())" /></xsl:attribute>
<xsl:value-of select="TXT" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>