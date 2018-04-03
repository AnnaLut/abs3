<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <!--REF=Референс;TT=ОП;USERID=Исполнитель;ND=Номер документа;NLSA=Счет-А;S=Сумма;o.KV=Вал;VDAT=Дата вал;S2=Сумма(вал В);o.KV2=Вал(В);MFOB=МФО-В;NLSB=Счет-В;DK=Д/К;SK=СКП;DATD=Дата документа;NAZN=Назначение;TOBO=Безб.отд-->
  <xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
  <xsl:template match="/">
    <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; border-collapse: collapse;cursor:hand">
      <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold; CURSOR: hand">

        <TD style="padding:0">
          <input id="mainChBox" type="checkbox" style="margin:0px;" onclick="selAllCheckbox(this);" />
        </TD>
          
        <TD width="70px" title="Референс документа">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('REF')</xsl:text>
          </xsl:attribute>
          <xsl:text>Реф</xsl:text>
        </TD>

        <TD width="20px" title="Исполнитель">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('USERID')</xsl:text>
          </xsl:attribute>
          <xsl:text>Исп</xsl:text>
        </TD>

        <TD width="100px" title="Номер документа">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('ND')</xsl:text>
          </xsl:attribute>
          <xsl:text>№ док</xsl:text>
        </TD>

        <TD width="100px" title="Счет-А">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NLSA')</xsl:text>
          </xsl:attribute>
          <xsl:text>Счет-А</xsl:text>
        </TD>

        <TD title="Сумма в валюте отправителя">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('S')</xsl:text>
          </xsl:attribute>
          <xsl:text>Сумма</xsl:text>
        </TD>

        <TD width="40px" title="Валюта отправителя">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('LCV')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вал</xsl:text>
        </TD>

        <TD width="70px" title="Дата валютирования">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.VDAT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата вал.</xsl:text>
        </TD>

        <TD title="Сумма в валюте получателя">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('S2')</xsl:text>
          </xsl:attribute>
          <xsl:text>Сумма(вал В)</xsl:text>
        </TD>

        <TD width="40px" title="Валюта получателя">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('LCV2')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вал(В)</xsl:text>
        </TD>

        <TD width="100px" title="МФО получателя">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('MFOB')</xsl:text>
          </xsl:attribute>
          <xsl:text>МФО(В)</xsl:text>
        </TD>

        <TD width="100px" title="Счет-В">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NLSB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Счет-В</xsl:text>
        </TD>

        <TD width="20px">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DK')</xsl:text>
          </xsl:attribute>
          <xsl:text>Д/К</xsl:text>
        </TD>

        <TD width="40px">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('SK')</xsl:text>
          </xsl:attribute>
          <xsl:text>СКП</xsl:text>
        </TD>

        <TD width="70px" title="Дата документа">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.DATD')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата док.</xsl:text>
        </TD>

        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NAZN')</xsl:text>
          </xsl:attribute>
          <xsl:text>Назначение платежа</xsl:text>
        </TD>

        <TD width="40px" title="Код операции">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('TT')</xsl:text>
          </xsl:attribute>
          <xsl:text>ОП</xsl:text>
        </TD>

        <TD width="70px" title="Код безбалансового отделения">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('TOBO')</xsl:text>
          </xsl:attribute>
          <xsl:text>Код безб.отд.</xsl:text>
        </TD>
      </TR>
      <xsl:for-each select="//Table">
        <xsl:variable name="id" select="REF" />
        <TR>
          <xsl:if test="SOS=1">
            <xsl:attribute name="style">color: #008000</xsl:attribute>
          </xsl:if>
          <xsl:if test="SOS=5">
            <xsl:attribute name="style">color: #000000</xsl:attribute>
          </xsl:if>
          <xsl:if test="SOS=-1">
            <xsl:attribute name="style">color: #FF0000</xsl:attribute>
          </xsl:if>
          <xsl:if test="SOS=-2">
            <xsl:attribute name="style">color: #FF0000</xsl:attribute>
          </xsl:if>
          <xsl:if test="SOS=0">
            <xsl:attribute name="style">color: #008080; BACKGROUND-COLOR: #E6FFFF</xsl:attribute>
          </xsl:if>
          <xsl:if test="SOS=3">
            <xsl:attribute name="style">color: #0000FF</xsl:attribute>
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
          <xsl:attribute name="id">
            <xsl:value-of select="concat('r_',position())" />
          </xsl:attribute>
          <xsl:attribute name="tt">
            <xsl:value-of select="TT" />
          </xsl:attribute>

          <xsl:attribute name="onmouseover">
            <xsl:text>setup_tooltip('</xsl:text>
            <xsl:value-of select="concat('r_',position())" />
            <xsl:text>', '7', '14.02.2009', 'Поточний рахунок Сошко Є.В.', '300205', '29953213353521', '2620005682162', 'Ярова Л.В.', '300205', '23242352353521', '26201243242351', '102.57', 'гривень', 'Перевод денежек на покупку жевачек и прочие безрассудства'); </xsl:text>
          </xsl:attribute>

          <TD style="padding:0">
            <input id="mainChBox" type="checkbox" style="margin:0px;" onclick="editArrayForPrint(this);" >
              <xsl:attribute name="data-ref">
                <xsl:value-of select="REF" />
              </xsl:attribute>
            </input>
          </TD>
          
          <TD align="right" title="Открыть карточку документа" style="CURSOR: hand; COLOR: blue; TEXT-DECORATION: underline">
            <xsl:attribute name="onclick">
              <xsl:text>OpenDoc('</xsl:text>
              <xsl:value-of select="REF" />
              <xsl:text>')</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="REF" />
          </TD>
          <TD align="center">
            <xsl:value-of select="USERID" />
          </TD>
          <TD align="left">
            <xsl:value-of select="ND" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NLSA" />
          </TD>
          <TD align="right">
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="format-number(S_,'###### ##0.00##','ua')" />
          </TD>
          <TD align="center">
            <xsl:value-of select="LCV" />
          </TD>
          <TD align="center">
            <xsl:if test="SOS=-1">
              <xsl:attribute name="style">BACKGROUND-COLOR: #E6FFE6</xsl:attribute>
            </xsl:if>
            <xsl:if test="SOS=-2">
              <xsl:attribute name="style">BACKGROUND-COLOR: #E6FFE6</xsl:attribute>
            </xsl:if>
            <xsl:if test="SOS=0">
              <xsl:attribute name="style">BACKGROUND-COLOR: #E6FFE6</xsl:attribute>
            </xsl:if>
            <xsl:if test="SOS=3">
              <xsl:attribute name="style">BACKGROUND-COLOR: #E6FFE6</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="VDAT" />
          </TD>
          <TD align="right">
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="format-number(S2_,'###### ##0.00##','ua')" />
          </TD>
          <TD align="center">
            <xsl:value-of select="LCV2" />
          </TD>
          <TD align="left">
            <xsl:value-of select="MFOB" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NLSB" />
          </TD>
          <TD align="center">
            <xsl:value-of select="DK" />
          </TD>
          <TD align="center">
            <xsl:value-of select="SK" />
          </TD>
          <TD align="center">
            <xsl:value-of select="DATD" />
          </TD>
          <TD align="left">
            <xsl:attribute name="title">
              <xsl:value-of select="NAZN" />
            </xsl:attribute>
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="substring(NAZN,0,25)" />
          </TD>
          <TD align="center">
            <xsl:value-of select="TT" />
          </TD>
          <TD align="left">
            <xsl:value-of select="TOBO" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>