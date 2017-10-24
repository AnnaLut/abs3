<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" width="100%" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; border-collapse: collapse">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold">
<TD width="25%" title="Дата"><xsl:text>Дата</xsl:text></TD>

<TD width="75%" title="Операції"><xsl:text>Опис</xsl:text></TD>

</TR>
<xsl:for-each select="//Table">
<TR>
<TD align="left"><xsl:value-of select="DAT" /></TD>
<TD align="left"><xsl:value-of select="INF" /></TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>