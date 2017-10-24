<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
  <xsl:template match="/">
    <TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color: White; border-color: Black; font-family: Verdana; font-size: 8pt; border-collapse: collapse;cursor:hand">
      <TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold; CURSOR: hand">

        <TD width="20px" title="Mark all documents">
          <xsl:attribute name="onclick">
            <xsl:text>SelectAll()</xsl:text>
          </xsl:attribute>
          <IMG alt="Mark all documents" src="Images/SelectAll.gif"></IMG>
        </TD>

        <TD width="70px" title="References of document">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.REF')</xsl:text>
          </xsl:attribute>
          <xsl:text>Ref</xsl:text>
        </TD>

        <TD width="40px" title="Operation code">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.TT')</xsl:text>
          </xsl:attribute>
          <xsl:text>OP</xsl:text>
        </TD>

        <TD width="100px" title="Number of document">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.ND')</xsl:text>
          </xsl:attribute>
          <xsl:text>№ doc</xsl:text>
        </TD>

        <TD width="100px" title="Account-А">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.NLSA')</xsl:text>
          </xsl:attribute>
          <xsl:text>Acc-А</xsl:text>
        </TD>

        <TD width="100px" title="Account-В">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.NLSB')</xsl:text>
          </xsl:attribute>
          <xsl:text>Acc-В</xsl:text>
        </TD>

        <TD width="100px" title="MFO of recipient">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.MFOB')</xsl:text>
          </xsl:attribute>
          <xsl:text>MFO(В)</xsl:text>
        </TD>

        <TD width="20px">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.DK')</xsl:text>
          </xsl:attribute>
          <xsl:text>D/K</xsl:text>
        </TD>

        <TD title="A sum is in currency of sender">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.S_')</xsl:text>
          </xsl:attribute>
          <xsl:text>Sum</xsl:text>
        </TD>

        <TD width="40px" title="Currency of sender">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.LCV1')</xsl:text>
          </xsl:attribute>
          <xsl:text>Cur</xsl:text>
        </TD>

        <TD>
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.NAZN')</xsl:text>
          </xsl:attribute>
          <xsl:text>Setting of payment</xsl:text>
        </TD>

        <TD title="A sum is in currency of recipient">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.S2_')</xsl:text>
          </xsl:attribute>
          <xsl:text>Sum(cur В)</xsl:text>
        </TD>

        <TD width="40px" title="Currency of recipient">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.LCV2')</xsl:text>
          </xsl:attribute>
          <xsl:text>Cur(В)</xsl:text>
        </TD>

        <TD width="70px" title="Date of currency transaction">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.VDAT')</xsl:text>
          </xsl:attribute>
          <xsl:text>Date tr.</xsl:text>
        </TD>

        <TD width="40px">
          <xsl:attribute name="onclick">
            <xsl:text>Sort('a.SK')</xsl:text>
          </xsl:attribute>
          <xsl:text>SCP</xsl:text>
        </TD>
      </TR>
      <xsl:for-each select="//Table">
        <xsl:variable name="id" select="REF" />
        <TR>
          <xsl:if test="COLOR1=1">
            <xsl:attribute name="style">BACKGROUND: #E6E6E6</xsl:attribute>
          </xsl:if>
          <xsl:if test="COLOR1=-1">
            <xsl:attribute name="style">BACKGROUND: #E6FFE6</xsl:attribute>
          </xsl:if>
          <xsl:if test="2&lt;=DK">
            <xsl:attribute name="style">BACKGROUND: #E6FFFF</xsl:attribute>
          </xsl:if>

          <xsl:attribute name="onclick">
            <xsl:text>showToolTip('</xsl:text>
            <xsl:value-of select="concat('r_',position())" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="ND" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="VDAT" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select='translate(NAM_A, "&apos;", "`")' />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="MFOA" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="ID_A" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="NLSA" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select='translate(NAM_B, "&apos;", "`")' />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="MFOB" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select='translate(NB_B, "&apos;", "`")' />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="ID_B" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="NLSB" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="format-number(S_,'###### ##0.00##','ua')" />
            <xsl:text>', '</xsl:text>
            <xsl:value-of select="LCV1" />
            <xsl:text>', '</xsl:text>
			<xsl:value-of select='translate(NAZN, "&apos;", "`")' />
            <xsl:text>'); </xsl:text>
            <xsl:text>HidePopupMenu();SelectRow('</xsl:text>
            <xsl:value-of select="$id"/>
            <xsl:text>',</xsl:text>
            <xsl:value-of select="position()"/>
            <xsl:text>); </xsl:text>
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

          <TD align="center">
            <INPUT type="checkbox" style='WIDTH: 15px; HEIGHT: 15px'>
              <xsl:attribute name="id">
                <xsl:text>chkb_</xsl:text>
                <xsl:value-of select="REF"/>
              </xsl:attribute>
              <xsl:attribute name="name">
                <xsl:text>cnkbox</xsl:text>
              </xsl:attribute>
            </INPUT>
          </TD>
          <TD align="right">
            <a href='#'>
              <xsl:attribute name="onclick">
                <xsl:text>ShowDocCard(</xsl:text>
                <xsl:value-of select="REF" />
                <xsl:text>)</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="REF" />
            </a>
          </TD>
          <TD align="center">
            <xsl:value-of select="TT" />
          </TD>
          <TD align="left">
            <xsl:value-of select="ND" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NLSA" />
          </TD>
          <TD align="left">
            <xsl:value-of select="NLSB" />
          </TD>
          <TD align="left">
            <xsl:value-of select="MFOB" />
          </TD>
          <TD align="right">
            <xsl:attribute name="id">
              <xsl:text>sum_</xsl:text>
              <xsl:value-of select="REF"/>
            </xsl:attribute>
            <xsl:if test="COLOR2!=''">
              <xsl:if test="COLOR2&lt;40">
                <xsl:attribute name="style">COLOR: blue</xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:if test="COLOR2!=''">
              <xsl:if test="40&lt;COLOR2">
                <xsl:attribute name="style">COLOR: red</xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="format-number(S_,'###### ##0.00##','ua')" />
          </TD>
          <TD align="center">
            <xsl:value-of select="LCV1" />
          </TD>
          <TD align="center">
            <xsl:value-of select="SK" />
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
          <TD align="right">
            <xsl:if test="COLOR2!=''">
              <xsl:if test="COLOR2&lt;40">
                <xsl:attribute name="style">COLOR: blue</xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:if test="COLOR2!=''">
              <xsl:if test="40&lt;COLOR2">
                <xsl:attribute name="style">COLOR: red</xsl:attribute>
              </xsl:if>
            </xsl:if>
            <xsl:attribute name="nowrap">
              <xsl:text>true</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="format-number(S2_,'###### ##0.00##','ua')" />
          </TD>
          <TD align="center">
            <xsl:value-of select="LCV2" />
          </TD>
          <TD align="center">
            <xsl:value-of select="VDAT" />
          </TD>
          <TD align="center">
            <xsl:value-of select="DK" />
          </TD>
        </TR>
      </xsl:for-each>
    </TABLE>
  </xsl:template>
</xsl:stylesheet>