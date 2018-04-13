<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!--NAME= Name of tariff-commission;TAR=Tariff in cop;PR=Commission (%);SMIN=Minimum in cop;SMAX=Maximum in cop;BDAT=Began the act. of tar. date(dd/mm/yyyy);EDAT=Expiration of act. of tar. date(dd/mm/yyyy)-->
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" rules="all" bordercolor="Black" border="1" id="dGrid" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="1%">
<xsl:attribute name="onclick"><xsl:text>Sort('KOD')</xsl:text></xsl:attribute>
<xsl:text>Kod</xsl:text></TD>
<TD width="39%" id="tdRatesName">
<xsl:attribute name="onclick"><xsl:text>Sort('NAME')</xsl:text></xsl:attribute>
<xsl:text>Name of tariff-commission</xsl:text></TD>
<TD width="5%">
<xsl:attribute name="onclick"><xsl:text>Sort('LCV')</xsl:text></xsl:attribute>
<xsl:text>Base currency</xsl:text></TD>
<TD width="5%">
<xsl:attribute name="onclick"><xsl:text>Sort('TAR')</xsl:text></xsl:attribute>
<xsl:text>Tariff in cop</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('PR')</xsl:text></xsl:attribute>
<xsl:text>Commission (%)</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('SMIN')</xsl:text></xsl:attribute>
<xsl:text>Minimum in cop</xsl:text></TD>
<TD width="10%">
<xsl:attribute name="onclick"><xsl:text>Sort('SMAX')</xsl:text></xsl:attribute>
<xsl:text>Maximum in cop</xsl:text></TD>
<TD width="10%">
<xsl:text>Began the act. of tar. date</xsl:text></TD>
<TD width="10%">
<xsl:text>Expiration of act. of tar. date</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="normalize-space(KOD)" />
<TR>
<xsl:attribute name="onclick"><xsl:text>SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="ondblclick"><xsl:text>Edit('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('KOD_',position())" /></xsl:attribute>
<xsl:value-of select="KOD" />
</TD>
<TD>
<xsl:attribute name="id"><xsl:value-of select="concat('NAME_',position())" /></xsl:attribute>
<xsl:value-of select="NAME" />
</TD>
<TD align="center">
<xsl:attribute name="id"><xsl:value-of select="concat('LCV_',position())" /></xsl:attribute>
<xsl:value-of select="LCV" />
</TD>
<TD align="right">
<xsl:attribute name="id"><xsl:value-of select="concat('TAR_',position())" /></xsl:attribute>
<xsl:value-of select="format-number(TAR,'########0.####','ua')" />
</TD>
<TD align="right">
<xsl:attribute name="id"><xsl:value-of select="concat('PR_',position())" /></xsl:attribute>
<xsl:value-of select="format-number(PR,'########0.####','ua')" />
</TD>
<TD align="right">
<xsl:attribute name="id"><xsl:value-of select="concat('SMIN_',position())" /></xsl:attribute>
<xsl:value-of select="format-number(SMIN,'########0.####','ua')" />
</TD>
<TD align="right">
<xsl:attribute name="id"><xsl:value-of select="concat('SMAX_',position())" /></xsl:attribute>
<xsl:value-of select="format-number(SMAX,'########0.####','ua')" />
</TD>
<TD  align="center">
<xsl:attribute name="id"><xsl:value-of select="concat('BDAT_',position())" /></xsl:attribute>
<xsl:value-of select="BDAT" />
</TD>
<TD  align="center">
<xsl:attribute name="id"><xsl:value-of select="concat('EDAT_',position())" /></xsl:attribute>
<xsl:value-of select="EDAT" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>