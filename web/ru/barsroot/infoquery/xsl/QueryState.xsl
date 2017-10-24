<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="/">
    <TABLE cellspacing="0" cellpadding="2" width="100%" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; border-collapse: collapse;cursor:hand">
      <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold">
        <TD width="20%" title="">
          <xsl:text>*</xsl:text>
        </TD>
        <TD width="5%" title="Ідентифікатор запиту">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('QUERY_ID')</xsl:text>
          </xsl:attribute>
          <xsl:text>Ід</xsl:text>
        </TD>
        <TD width="20%" title="Тип запиту">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('QUERYTYPE_NAME')</xsl:text>
          </xsl:attribute>
          <xsl:text>Тип</xsl:text>
        </TD>
        <TD width="20%" title="Користувач, що сформував запит">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('FIO')</xsl:text>
          </xsl:attribute>
          <xsl:text>Користувач</xsl:text>
        </TD>
        <TD width="5%" title="Дата створення запиту">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DAT_S')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата створення</xsl:text>
        </TD>
        <TD width="5%" title="Дата відповіді на запит">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DAT_E')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата відповіді</xsl:text>
        </TD>
        <TD width="25%" title="Статус запиту">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('STATUS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Статус</xsl:text>
        </TD>
      </TR>
      <xsl:for-each select="//Table">
        <TR>
          <xsl:if test="QUERY_STATUS=2">
            <xsl:attribute name="style">BACKGROUND: ORANGERED</xsl:attribute>
          </xsl:if>
          <xsl:if test="QUERY_STATUS=1">
            <xsl:attribute name="style">BACKGROUND: LIGHTGREEN</xsl:attribute>
          </xsl:if>
          <xsl:attribute name="id">
            <xsl:value-of select="concat('r_',position())" />
          </xsl:attribute>
          <TD align="center" title="Переглянути відповідь на запит" 
            style="CURSOR: hand; COLOR: blue; TEXT-DECORATION: underline">
            <xsl:attribute name="onclick">
              <xsl:text>Response('</xsl:text>
                <xsl:value-of select="QUERY_ID" />
              <xsl:text>')</xsl:text>
            </xsl:attribute>
            <xsl:text>Переглянути</xsl:text>
          </TD>
          <TD align="center">
            <xsl:value-of select="QUERY_ID" />
          </TD>
          <TD align="left">
            <xsl:value-of select="QUERYTYPE_NAME" />
          </TD>
          <TD align="left">
            <xsl:value-of select="FIO" />
          </TD>
          <TD align="center">
            <xsl:value-of select="DAT_S" />
          </TD>
          <TD align="center">
            <xsl:value-of select="DAT_E" />
          </TD>
          <TD align="left">
            <xsl:value-of select="STATUS" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>