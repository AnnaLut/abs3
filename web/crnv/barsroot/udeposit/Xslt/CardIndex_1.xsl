<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
  <xsl:template match="/">
    <TABLE style="cursor:hand" id="tableDepositLines">
      <TR>
        <TH width="2.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('KV')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Валюта</xsl:text>
          </xsl:attribute>
          <xsl:text>Вал</xsl:text>
        </TH>
        <TH width="10%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NLS')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Лицевой счет</xsl:text>
          </xsl:attribute>
          <xsl:text>Лиц. счет</xsl:text>
        </TH>
        <TH width="15%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NMS')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Наименование счета</xsl:text>
          </xsl:attribute>
          <xsl:text>Наименование</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTC')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Фактический остаток</xsl:text>
          </xsl:attribute>
          <xsl:text>Факт. ост.</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OSTB')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Плановый остаток</xsl:text>
          </xsl:attribute>
          <xsl:text>План. ост.</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('OST8')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Остаток "дочерних"</xsl:text>
          </xsl:attribute>
          <xsl:text>Ост. "доч."</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('REF1')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Референс документа</xsl:text>
          </xsl:attribute>
          <xsl:text>Референс</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('FDAT')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Дата платежа</xsl:text>
          </xsl:attribute>
          <xsl:text>Дата</xsl:text>
        </TH>
        <TH width="7.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('S')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Сумма платежа</xsl:text>
          </xsl:attribute>
          <xsl:text>Сумма</xsl:text>
        </TH>
        <TH width="27.5%">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('NAZN')</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>Назначение платежа</xsl:text>
          </xsl:attribute>
          <xsl:text>Назначение</xsl:text>
        </TH>     
      </TR>
      <xsl:for-each select="//Table">
        <xsl:variable name="id" select="DPU_ID" />
        <TR>
          <xsl:attribute name="onclick">
            <xsl:text>SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>);fnPopulateSecondTable(selectedRow.acc);</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="concat('r_',position())" />
          </xsl:attribute>
          <xsl:attribute name="acc">
            <xsl:value-of select="ACC" />
          </xsl:attribute>
          <xsl:attribute name="ref1">
            <xsl:value-of select="REF1" />
          </xsl:attribute>
          <xsl:attribute name="kv">
            <xsl:value-of select="KV" />
          </xsl:attribute>
          <xsl:attribute name="nls">
            <xsl:value-of select="NLS" />
          </xsl:attribute>
          <xsl:attribute name="sum">
            <xsl:value-of select="format-number(S,'##### #### ##0.00','ua')" />
          </xsl:attribute>
          <xsl:attribute name="sk">
            <xsl:value-of select="SK" />
          </xsl:attribute>
          <xsl:attribute name="vdat">
            <xsl:value-of select="FDAT" />
          </xsl:attribute>

          <TD align="center">
            <xsl:value-of select="KV" />
          </TD>
          <TD align="center">
            <xsl:value-of select="NLS" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NMS" />
          </TD>
          <TD align="right">
            <xsl:value-of select="format-number(OSTC,'##### #### ##0.00','ua')" />
          </TD>
          <TD align="right">
            <xsl:value-of select="format-number(OSTB,'##### #### ##0.00','ua')" />
          </TD>
          <TD align="right">
            <xsl:value-of select="format-number(OST8,'##### #### ##0.00','ua')" />
          </TD>
          <TD align="center">
            <xsl:value-of select="REF1" />
          </TD>
          <TD align="center">
            <xsl:value-of select="FDAT" />
          </TD>
          <TD align="right">
            <xsl:value-of select="format-number(S,'##### #### ##0.00','ua')" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NAZN" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>
