<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />

<xsl:template match="/">
  <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
    <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('NBS')</xsl:text>
        </xsl:attribute>
        <xsl:text>БС</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('VAL')</xsl:text>
        </xsl:attribute>
        <xsl:text>Валюта</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('DOS')</xsl:text>
        </xsl:attribute>
        <xsl:text>Обороты ДЕБЕТ</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('KOS')</xsl:text>
        </xsl:attribute>
        <xsl:text>Обороты КРЕДИТ</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('ISD')</xsl:text>
        </xsl:attribute>
        <xsl:text>Исходящий ДЕБЕТ</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('ISK')</xsl:text>
        </xsl:attribute>
        <xsl:text>Исходящий КРЕДИТ</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('NAME')</xsl:text>
        </xsl:attribute>
        <xsl:text>Наименование валюты</xsl:text>
      </TD>
    </TR>

    <xsl:for-each select="//Table">
      <xsl:variable name="id" select="VAL" />
      <xsl:variable name="fmtStr" select="concat('###### ##0.',substring(DIG,2))" />
      <TR>
        <xsl:attribute name="id">
          <xsl:value-of select="concat('r_',position())" />
        </xsl:attribute>
        <xsl:attribute name="onclick">
          <xsl:text>HidePopupMenu();SelectRow('</xsl:text>
          <xsl:value-of select="$id"/>
          <xsl:text>',</xsl:text>
          <xsl:value-of select="position()"/>
          <xsl:text>)</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="ondblclick">
          <xsl:text>fnByAcc()</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="oncontextmenu">
          <xsl:text>ShowPopupMenu();SelectRow('</xsl:text>
          <xsl:value-of select="$id"/>
          <xsl:text>',</xsl:text>
          <xsl:value-of select="position()"/>
          <xsl:text>);return false</xsl:text>
        </xsl:attribute>
        <TD>
          <xsl:value-of select="NBS" />
        </TD>
        <TD align="center" noWrap="true">
          <xsl:value-of select="format-number(VAL,'#0','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(DOS div DIG, $fmtStr,'ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(KOS div DIG, $fmtStr,'ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(ISD div DIG, $fmtStr,'ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(ISK div DIG, $fmtStr,'ua')" />
        </TD>
        <TD align="left" noWrap="true">
          <xsl:value-of select="NAME" />
        </TD>
      </TR>
    </xsl:for-each>
  </TABLE>
</xsl:template>

</xsl:stylesheet> 

