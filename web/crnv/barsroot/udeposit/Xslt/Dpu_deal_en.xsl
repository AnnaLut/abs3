<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:decimal-format name="ua" decimal-separator='.' grouping-separator=' ' NaN='' />
<xsl:template match="/">
<TABLE cellspacing="0" cellpadding="2" bordercolor="Black" border="1" style="background-color:White;border-color:Black;font-family:Verdana;font-size:8pt;width:100%;border-collapse:collapse;cursor:hand">
<TR align="center" style="color:White;background-color:Gray;font-family:Verdana;font-size:8pt;font-weight:bold;">
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ISP')</xsl:text>
	</xsl:attribute>
<xsl:text>Исп</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('DPU_ID')</xsl:text>
	</xsl:attribute>
<xsl:text>Реф. деп. дог.</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('DPU_GEN')</xsl:text>
	</xsl:attribute>
<xsl:text>Реф. ген. дог.</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('DPU_AD')</xsl:text>
	</xsl:attribute>
<xsl:text>№ доп. согл.</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ND')</xsl:text>
	</xsl:attribute>
<xsl:text>Номер депоз. дог.</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('RNK')</xsl:text>
	</xsl:attribute>
<xsl:text>РНК</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NMK')</xsl:text>
	</xsl:attribute>
<xsl:text>КЛИЕНТ</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ISO')</xsl:text>
	</xsl:attribute>
<xsl:text>Вал</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NLS')</xsl:text>
	</xsl:attribute>
<xsl:text>Депозитный счет</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('SUM')</xsl:text>
	</xsl:attribute>
<xsl:text>Общая сумма</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('PROC')</xsl:text>
	</xsl:attribute>
<xsl:text>% ставка</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('OST')</xsl:text>
	</xsl:attribute>
<xsl:text>Cумма на счете депозита</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('OSTN')</xsl:text>
	</xsl:attribute>
<xsl:text>Cумма начисл. %%</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('NAME')</xsl:text>
	</xsl:attribute>
<xsl:text>Вид договора</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('FREQV')</xsl:text>
	</xsl:attribute>
<xsl:text>Периодичность погашения %%</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('d.DAT_Z')</xsl:text>
	</xsl:attribute>
<xsl:text>Дата заключения договора</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('d.DAT_N')</xsl:text>
	</xsl:attribute>
<xsl:text>Дата размещения депозита</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('d.DAT_O')</xsl:text>
	</xsl:attribute>
<xsl:text>Дата окончания договора</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('d.DAT_V')</xsl:text>
	</xsl:attribute>
<xsl:text>Дата возврата депозита</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('MFOP')</xsl:text>
	</xsl:attribute>
<xsl:text>МФО перечисл. %%</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ACCP')</xsl:text>
	</xsl:attribute>
<xsl:text>Счет для перечисл. %%</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('MFOD')</xsl:text>
	</xsl:attribute>
<xsl:text>МФО возврата депозита</xsl:text>
</TD>
<TD width="5%">
	<xsl:attribute name="onclick">
		<xsl:text>Sort('ACCD')</xsl:text>
	</xsl:attribute>
<xsl:text>Счет возврата депозита</xsl:text>
</TD>

</TR>
<xsl:for-each select="//Table">
<xsl:variable name="id" select="DPU_ID" />
<TR>
<xsl:if test="DPU_AD=0"><xsl:attribute name="style">background-color:#FFFF99</xsl:attribute></xsl:if>
<xsl:if test="CLOSED=1"><xsl:attribute name="style">color:#8080FF</xsl:attribute></xsl:if>
<xsl:attribute name="onclick"><xsl:text>HidePopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>)</xsl:text></xsl:attribute>
<xsl:attribute name="oncontextmenu"><xsl:text>ShowPopupMenu();SelectRow('</xsl:text><xsl:value-of select="$id"/><xsl:text>',</xsl:text><xsl:value-of select="position()"/><xsl:text>);return false</xsl:text></xsl:attribute>
<xsl:attribute name="id"><xsl:value-of select="concat('r_',position())" /></xsl:attribute>
<xsl:attribute name="dpugen"><xsl:value-of select="DPU_GEN" /></xsl:attribute>
<xsl:attribute name="dpuadd"><xsl:value-of select="DPU_AD" /></xsl:attribute>
<xsl:attribute name="dpuclosed"><xsl:value-of select="CLOSED" /></xsl:attribute>

<TD><xsl:value-of select="ISP" /></TD>
<TD><xsl:value-of select="DPU_ID" /></TD>
<TD><xsl:value-of select="DPU_GEN" /></TD>
<TD>
	<xsl:if test="DPU_AD&gt;0"><xsl:attribute name="style">background-color:#FFFF99</xsl:attribute></xsl:if>
	<xsl:value-of select="DPU_AD" />
</TD>
<TD noWrap="true"><xsl:value-of select="ND" /></TD>
<TD><xsl:value-of select="RNK" /></TD>
<TD noWrap="true"><xsl:value-of select="NMK" /></TD>
<TD><xsl:value-of select="ISO" /></TD>
<TD noWrap="true"><xsl:value-of select="NLS" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="format-number(SUM,'##### #### ##0.00','ua')" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="format-number(PROC,'##### #### ##0.00','ua')" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="format-number(OST,'##### #### ##0.00','ua')" /></TD>
<TD noWrap="true" align="right"><xsl:value-of select="format-number(OSTN,'##### #### ##0.00','ua')" /></TD>
<TD noWrap="true"><xsl:value-of select="NAME" /></TD>
<TD noWrap="true"><xsl:value-of select="FREQV" /></TD>
<TD noWrap="true" align="center">
	<xsl:choose>
		<xsl:when test="FL_1&lt;=0"><xsl:attribute name="style">background-color:lightsalmon</xsl:attribute></xsl:when>
		<xsl:when test="FL_2&lt;=0"><xsl:attribute name="style">background-color:aqua</xsl:attribute></xsl:when>
		<xsl:when test="FL_3&lt;=0"><xsl:attribute name="style">background-color:gray</xsl:attribute></xsl:when>
	</xsl:choose>
	<xsl:value-of select="DATZ" />
</TD>
<TD noWrap="true" align="center">
	<xsl:choose>
		<xsl:when test="FL_1&lt;=0"><xsl:attribute name="style">background-color:lightsalmon</xsl:attribute></xsl:when>
		<xsl:when test="FL_2&lt;=0"><xsl:attribute name="style">background-color:aqua</xsl:attribute></xsl:when>
		<xsl:when test="FL_3&lt;=0"><xsl:attribute name="style">background-color:gray</xsl:attribute></xsl:when>
	</xsl:choose>
	<xsl:value-of select="DATN" />
</TD>
<TD noWrap="true" align="center">
	<xsl:choose>
		<xsl:when test="FL_1&lt;=0"><xsl:attribute name="style">background-color:lightsalmon</xsl:attribute></xsl:when>
		<xsl:when test="FL_2&lt;=0"><xsl:attribute name="style">background-color:aqua</xsl:attribute></xsl:when>
		<xsl:when test="FL_3&lt;=0"><xsl:attribute name="style">background-color:gray</xsl:attribute></xsl:when>
	</xsl:choose>
	<xsl:value-of select="DATO" />
</TD>
<TD noWrap="true" align="center">
	<xsl:choose>
		<xsl:when test="FL_1&lt;=0"><xsl:attribute name="style">background-color:lightsalmon</xsl:attribute></xsl:when>
		<xsl:when test="FL_2&lt;=0"><xsl:attribute name="style">background-color:aqua</xsl:attribute></xsl:when>
		<xsl:when test="FL_3&lt;=0"><xsl:attribute name="style">background-color:gray</xsl:attribute></xsl:when>
	</xsl:choose>
	<xsl:value-of select="DATV" />
</TD>
<TD noWrap="true" align="center"><xsl:value-of select="MFOP" /></TD>
<TD><xsl:value-of select="ACCP" /></TD>
<TD align="center"><xsl:value-of select="MFOD" /></TD>
<TD><xsl:value-of select="ACCD" /></TD>

</TR>
</xsl:for-each>
</TABLE>
</xsl:template>
</xsl:stylesheet>