<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' /> 

  <xsl:template match="/">
  <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
    <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
      <TD width="5%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('SB')</xsl:text>
        </xsl:attribute>
        <xsl:text>SB</xsl:text>
      </TD>
      <TD width="5%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('NBS')</xsl:text>
        </xsl:attribute>
        <xsl:text>BA</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('DOSR')</xsl:text>
        </xsl:attribute>
        <xsl:text>DEBIT Turns (real)</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('KOSR')</xsl:text>
        </xsl:attribute>
        <xsl:text>CREDIT Turns (real)</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('DOS')</xsl:text>
        </xsl:attribute>
        <xsl:text>DEBIT Turns</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('KOS')</xsl:text>
        </xsl:attribute>
        <xsl:text>CREDIT Turns</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('ISD')</xsl:text>
        </xsl:attribute>
        <xsl:text>DEBIT Outword</xsl:text>
      </TD>
      <TD width="3%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('ISK')</xsl:text>
        </xsl:attribute>
        <xsl:text>CREDIT Outword</xsl:text>
      </TD>
      <TD width="50%">
        <xsl:attribute name="onclick">
          <xsl:text>Sort('NAME')</xsl:text>
        </xsl:attribute>
        <xsl:text>BA name</xsl:text>
      </TD>
    </TR>
    
    <xsl:for-each select="//Table">
      <xsl:variable name="id" select="NBS" />
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
          <xsl:text>fnByIsp()</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="oncontextmenu">
          <xsl:text>ShowPopupMenu();SelectRow('</xsl:text>
          <xsl:value-of select="$id"/>
          <xsl:text>',</xsl:text>
          <xsl:value-of select="position()"/>
          <xsl:text>);return false</xsl:text>
        </xsl:attribute>
        <TD>
          <xsl:value-of select="SB" />
        </TD>
        <TD>
          <xsl:value-of select="NBS" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(DOSR,'##### #### ##0.00','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(KOS,'##### #### ##0.00','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(DOS,'##### #### ##0.00','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(KOS,'##### #### ##0.00','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(ISD,'##### #### ##0.00','ua')" />
        </TD>
        <TD align="right" noWrap="true">
          <xsl:value-of select="format-number(ISK,'##### #### ##0.00','ua')" />
        </TD>
        <TD noWrap="true">
          <xsl:value-of select="NAME" />
        </TD>
      </TR>
    </xsl:for-each>
    <TR style="background-color:Gray;color:White;">
      <TD></TD>
      <TD id="sB" style="color:navy"></TD>
      <TD align="right" noWrap="true" id="iB_Dosr"></TD>
      <TD align="right" noWrap="true" id="iB_Kosr"></TD>
      <TD align="right" noWrap="true" id="iB_Dos"></TD>
      <TD align="right" noWrap="true" id="iB_Kos"></TD>
      <TD align="right" noWrap="true" id="iB_OstD"></TD>
      <TD align="right" noWrap="true" id="iB_OstK"></TD>
      <TD></TD>
   </TR>
    <TR style="background-color:Gray;color:White;">
      <TD></TD>
      <TD id="sM" style="color:navy"></TD>
      <TD align="right" noWrap="true" id="iM_Dosr"></TD>
      <TD align="right" noWrap="true" id="iM_Kosr"></TD>
      <TD align="right" noWrap="true" id="iM_Dos"></TD>
      <TD align="right" noWrap="true" id="iM_Kos"></TD>
      <TD align="right" noWrap="true" id="iM_OstD"></TD>
      <TD align="right" noWrap="true" id="iM_OstK"></TD>
      <TD></TD>
    </TR>
    <TR style="background-color:Gray;color:White;">
      <TD></TD>
      <TD id="sV" style="color:navy"></TD>
      <TD align="right" noWrap="true" id="iV_Dosr"></TD>
      <TD align="right" noWrap="true" id="iV_Kosr"></TD>
      <TD align="right" noWrap="true" id="iV_Dos"></TD>
      <TD align="right" noWrap="true" id="iV_Kos"></TD>
      <TD align="right" noWrap="true" id="iV_OstD"></TD>
      <TD align="right" noWrap="true" id="iV_OstK"></TD>
      <TD></TD>
    </TR>
  </TABLE>
</xsl:template>

</xsl:stylesheet> 

