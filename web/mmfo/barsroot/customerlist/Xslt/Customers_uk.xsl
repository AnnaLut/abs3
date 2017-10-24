<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:template match="/">
    <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
      <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('RNK')</xsl:text>
          </xsl:attribute>
          <xsl:text>Реєстр. Номер</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('ND')</xsl:text>
          </xsl:attribute>
          <xsl:text>Номер документа</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OKPO')</xsl:text>
          </xsl:attribute>
          <xsl:text>ЕДРПОУ \ іден. код</xsl:text>
        </TD>
        <TD width="10%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NAME')</xsl:text>
          </xsl:attribute>
          <xsl:text>Тип контрагента</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('B')</xsl:text>
          </xsl:attribute>
          <xsl:text>Підпр.</xsl:text>
        </TD>
        <TD width="50%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NMK')</xsl:text>
          </xsl:attribute>
          <xsl:text>Найменування</xsl:text>
        </TD>
        <TD width="10%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('dat_on')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата реєстрації</xsl:text>
        </TD>
        <TD width="10%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('dat_off')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата закриття</xsl:text>
        </TD>
        <TD width="10%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('branch')</xsl:text>
          </xsl:attribute>
          <xsl:text>Код безбаланс. відділення</xsl:text>
        </TD>
        <TD width="10%">
          <xsl:text>Статус реквізитів</xsl:text>
        </TD>
      </TR>
      <xsl:for-each select="//Table">
        <xsl:variable name="id" select="RNK" />
        <xsl:variable name="dat_on" select="DAT_ON!=''" />
        <xsl:variable name="year">
          <xsl:value-of select="substring(DAT_ON, 1, 4)" />
        </xsl:variable>
        <xsl:variable name="month">
          <xsl:value-of select="substring(DAT_ON, 6, 2)" />
        </xsl:variable>
        <xsl:variable name="day">
          <xsl:value-of select="substring(DAT_ON, 9, 2)" />
        </xsl:variable>
        <TR>
          <xsl:if test="DAT_OFF!=''">
            <xsl:attribute name="style">color:#8080FF</xsl:attribute>
          </xsl:if>
          <xsl:if test="(DAT_ON!='')=true">
            <xsl:attribute name="style">color:#9933FF</xsl:attribute>
          </xsl:if>
          <xsl:attribute name="onclick">
            <xsl:text>HidePopupMenu();SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>)</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="oncontextmenu">
            <xsl:text>ShowPopupMenu();SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>);return false</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="ondblclick">
            <xsl:text>fnRedirPer()</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="concat('r_',position())" />
          </xsl:attribute>
          <xsl:attribute name="DAT_OFF">
            <xsl:value-of select="DAT_OFF" />
          </xsl:attribute>
          <xsl:attribute name="DAT_ON">
            <xsl:value-of select="DAT_ON" />
          </xsl:attribute>
          <xsl:attribute name="BR_OWN">
            <xsl:value-of select="BRANCH_OWNER" />
          </xsl:attribute>
          <TD>
            <xsl:value-of select="RNK" />
          </TD>
          <TD>
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="ND" />
          </TD>
          <TD>
            <xsl:value-of select="OKPO" />
          </TD>
          <TD>
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="NAME" />
          </TD>
          <TD align="center" style="font-weight:bold;">
            <xsl:value-of select="B" />
          </TD>
          <TD style="color:Navy;">
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="NMK" />
          </TD>
          <TD align="center">
            <xsl:if test="(DAT_ON != '') or  (DAT_ON != null)">
              <xsl:value-of select="concat($day, '/'$month, '/', $year)" />
            </xsl:if>
          </TD>
          <TD align="center">
            <xsl:value-of select="DAT_OFF" />
          </TD>
          <TD align="left">
            <xsl:value-of select="BRANCH" />
          </TD>
          <TD align="left">
            <xsl:value-of select="REQ_STATUS" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>