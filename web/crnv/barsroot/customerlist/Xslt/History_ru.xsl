<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="30%"><xsl:attribute name="onclick"><xsl:text>Sort('PAR')</xsl:text></xsl:attribute>
<xsl:text>Параметр</xsl:text>
</TD>
<TD width="20%"><xsl:attribute name="onclick"><xsl:text>Sort('h.valold')</xsl:text></xsl:attribute>
<xsl:text>Старое значение</xsl:text></TD>
<TD width="20%"><xsl:attribute name="onclick"><xsl:text>Sort('NEW')</xsl:text></xsl:attribute>
<xsl:text>Новое значение</xsl:text></TD>
<TD width="10%"><xsl:attribute name="onclick"><xsl:text>Sort('h.dat')</xsl:text></xsl:attribute>
<xsl:text>Дата изменения</xsl:text></TD>
<TD width="5%"><xsl:attribute name="onclick"><xsl:text>Sort('USR')</xsl:text></xsl:attribute>
<xsl:text>Внес изменения</xsl:text></TD>
<TD width="15%"><xsl:attribute name="onclick"><xsl:text>Sort('FIO')</xsl:text></xsl:attribute>
<xsl:text>ФИО пользователя</xsl:text></TD>
</TR>
<xsl:for-each select="//Table">
<TR>
<xsl:if test="TABNAME='ACCOUNTS'"><xsl:attribute name="style">color:navy</xsl:attribute></xsl:if>
<xsl:if test="TABNAME='SPECPARAM'"><xsl:attribute name="style">color:green</xsl:attribute></xsl:if>
<xsl:if test="TABNAME='CUSTOMER'"><xsl:attribute name="style">color:navy</xsl:attribute></xsl:if>
<TD>
<xsl:attribute name="nowrap"><xsl:text>true</xsl:text></xsl:attribute>
<xsl:value-of select="translate(PAR,'~',' ')" /></TD>
<TD>
<xsl:attribute name="nowrap"><xsl:text>true</xsl:text></xsl:attribute>
<xsl:value-of select="OLD" /></TD>
<TD>
<xsl:attribute name="nowrap"><xsl:text>true</xsl:text></xsl:attribute>
<xsl:value-of select="NEW" /></TD>
<TD align="center"><xsl:value-of select="DAT" /></TD>
<TD><xsl:value-of select="USR" /></TD>
<TD>
<xsl:attribute name="nowrap"><xsl:text>true</xsl:text></xsl:attribute>
<xsl:value-of select="FIO" />
</TD>
</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>