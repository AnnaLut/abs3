<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' minus-sign=' '/>
  <xsl:template match="/">
    <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
      <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('TOBO')</xsl:text>
          </xsl:attribute>
          <xsl:text>ВідділенняDKEQ</xsl:text>
        </TD>

        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NlS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Номер рахунку</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NLSALT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Альт. номер рахунку</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NBS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Баланс. рахунок</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('LCV')</xsl:text>
          </xsl:attribute>
          <xsl:text>Валюта</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('RNK')</xsl:text>
          </xsl:attribute>
          <xsl:text>РНК клієнта</xsl:text>
        </TD>
        <TD width="40%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NMS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Найменування рахунку</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DAOS_SORT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата відкриття</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OST')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вхідний залишок Дебет</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OST')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вхідний залишок Дебет (екв.)</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OST')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вхідний залишок Кредит</xsl:text>
        </TD>
        <TD width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OST')</xsl:text>
          </xsl:attribute>
          <xsl:text>Вхідний залишок Кредит (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DOS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Обороти Дебет</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DOS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Обороти Дебет (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('KOS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Обороти Кредит</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('KOS')</xsl:text>
          </xsl:attribute>
          <xsl:text>Обороти Кредит (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTC')</xsl:text>
          </xsl:attribute>
          <xsl:text>Фактичний залишок Дебет</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTC')</xsl:text>
          </xsl:attribute>
          <xsl:text>Фактичний залишок Дебет (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTC')</xsl:text>
          </xsl:attribute>
          <xsl:text>Фактичний залишок Кредит </xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTC')</xsl:text>
          </xsl:attribute>
          <xsl:text>Фактичний залишок Кредит (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Плановий залишок Дебет</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Плановий залишок Дебет (екв.)</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Плановий залишок Кредит</xsl:text>
        </TD>
        <TD width="5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Плановий залишок Кредит (екв.)</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DAZS_SORT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата закриття</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('DAPP_SORT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата ост. руху</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('PAP')</xsl:text>
          </xsl:attribute>
          <xsl:text>Акт Пас</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OB22')</xsl:text>
          </xsl:attribute>
          <xsl:text>ОБ22</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('TIP')</xsl:text>
          </xsl:attribute>
          <xsl:text>Тип рахунку</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('INTACCN')</xsl:text>
          </xsl:attribute>
          <xsl:text>%%Ставка</xsl:text>
        </TD>
        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('MDATE_SORT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Планова дата погашення</xsl:text>
        </TD>
      </TR>
      <xsl:for-each select="//Table">
        <xsl:variable name="id" select="ACC" />
        <xsl:variable name="mode" select="MOD" />
        <xsl:variable name="blk" select="BLKD+BLKK" />
        <xsl:variable name="frmtStr" select="concat('###### ##0.',substring(DIG,2))" />
        <TR>
          <xsl:if test="$mode=2">
            <xsl:attribute name="style">color:#8080FF</xsl:attribute>
          </xsl:if>
          <xsl:attribute name="onclick">
            <xsl:text>HidePopupMenu();SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="$mode"/>
            <xsl:text>)</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="ondblclick">
            <xsl:text>fnShowHistAcc()</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="oncontextmenu">
            <xsl:text>ShowPopupMenu();SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="$mode"/>
            <xsl:text>);return false</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="concat('r_',position())" />
          </xsl:attribute>
          <TD align="center">
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:purple</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="TOBO" />
          </TD>

          <TD>
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:white;background-color:purple</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
              <xsl:value-of select="concat('NLS_',position())" />
            </xsl:attribute>
            <xsl:value-of select="NLS" />
          </TD>
          <TD>
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:white;background-color:purple</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
              <xsl:value-of select="concat('NLSALT_',position())" />
            </xsl:attribute>
            <xsl:value-of select="NLSALT" />
          </TD>
          <TD>
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:white;background-color:purple</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
              <xsl:value-of select="concat('NBS_',position())" />
            </xsl:attribute>
            <xsl:value-of select="NBS" />
          </TD>
          <TD>
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:white;background-color:purple</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
              <xsl:value-of select="concat('LCV_',position())" />
            </xsl:attribute>
            <xsl:value-of select="LCV" />
          </TD>

          <TD>
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:white;background-color:purple</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
              <xsl:value-of select="concat('RNK_',position())" />
            </xsl:attribute>
            <xsl:value-of select="RNK" />
          </TD>

          <TD noWrap="true">
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:purple</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="NMS" />
          </TD>
          <TD noWrap="true">
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:purple</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="DAOS" />
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OST&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OST&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OST div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTEQ&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTEQ&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OSTEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OST&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OST div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OST&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTEQ&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OSTEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTEQ&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:value-of select="format-number(DOS div DIG,$frmtStr,'ua')" />
          </TD>
          <TD align="right" noWrap="true">
            <xsl:value-of select="format-number(DOSEQ div DIG,$frmtStr,'ua')" />
          </TD>
          <TD align="right" noWrap="true">
            <xsl:value-of select="format-number(KOS div DIG,$frmtStr,'ua')" />
          </TD>
          <TD align="right" noWrap="true">
            <xsl:value-of select="format-number(KOSEQ div DIG,$frmtStr,'ua')" />
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTC&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTC&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OSTC div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTCEQ&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTCEQ&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OSTCEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTC&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OSTC div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTC&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTCEQ&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OSTCEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTCEQ&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTB&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTB&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OSTB div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTBEQ&gt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>Найменування рахунку
            <xsl:if test="OSTBEQ&lt;0">
              <xsl:attribute name="style">COLOR: red</xsl:attribute>
              <xsl:value-of select="format-number(OSTBEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTB&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OSTB div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTB&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD align="right" noWrap="true">
            <xsl:if test="OSTBEQ&gt;0">
              <xsl:attribute name="style">COLOR: darkblue</xsl:attribute>
              <xsl:value-of select="format-number(OSTBEQ div DIG, $frmtStr, 'ua')" />
            </xsl:if>
            <xsl:if test="OSTBEQ&lt;=0">
              <xsl:value-of select="format-number(0, $frmtStr, 'ua')" />
            </xsl:if>
          </TD>
          <TD noWrap="true">
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:purple</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="DAZS" />
          </TD>
          <TD  noWrap="true">
            <xsl:value-of select="DAPP" />
          </TD>
          <TD align="center">
            <xsl:value-of select="PAP" />
          </TD>
          <TD align="center">
            <xsl:if test="$blk>0">
              <xsl:attribute name="style">color:purple</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="OB22" />
          </TD>
          <TD align="center">
            <xsl:value-of select="TIP" />
          </TD>
          <TD align="right">
            <xsl:value-of select="INTACCN" />
          </TD>
          <TD align="center">
            <xsl:value-of select="MDATE" />
          </TD>
          <TD style="display:none;">
            <xsl:attribute name="id">
              <xsl:value-of select="concat('VID_',position())" />
            </xsl:attribute>
            <xsl:value-of select="VID" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>