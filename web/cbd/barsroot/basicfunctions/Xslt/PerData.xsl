<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!--BDAT=Дата;IR=Ставка индивидуальная;OP=Формула (+,-,*,/);[BR:NAME:ddName]=Базовая ставка-->
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" rules="all" bordercolor="Black" border="1" id="dGrid" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('BDAT')</xsl:text></xsl:attribute>
<xsl:text>Дата</xsl:text></TD>
<TD width="35%">
<xsl:attribute name="onclick"><xsl:text>Sort('IR')</xsl:text></xsl:attribute>
<xsl:text>Ставка индивидуальная</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('OP')</xsl:text></xsl:attribute>
<xsl:text>Формула</xsl:text></TD>
<TD width="40%">
<xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
<xsl:text>Базовая ставка</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="ID" />
<TR>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>Edit('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('BDAT_',position())" /></xsl:attribute>
<xsl:value-of select="BDAT" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('IR_',position())" /></xsl:attribute>
<xsl:value-of select="IR" />
</TD>
<TD align="center">
<xsl:attribute name="id"><xsl:value-of select="concat('OP_',position())" /></xsl:attribute>
<xsl:value-of select="OP" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('ddName_',position())" /></xsl:attribute>
<xsl:attribute name="value"><xsl:value-of select="BR" /></xsl:attribute>
<xsl:value-of select="NAME" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>