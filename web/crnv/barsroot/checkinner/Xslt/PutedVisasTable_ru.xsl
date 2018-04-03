<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
<table style="FONT-SIZE: 10pt; FONT-FAMILY: Arial" cellSpacing="0" borderColorDark="#ffffff" cellPadding="2" borderColorLight="black" border="1" width="100%">
	<tr>
		<xsl:attribute name="style"><xsl:text>COLOR: white; BACKGROUND-COLOR: gray; TEXT-ALIGN: center</xsl:text></xsl:attribute>

		<td class="cellStyle" width="200px"><xsl:text>Группа</xsl:text></td>
		<td class="cellStyle" width="180px"><xsl:text>Отметка</xsl:text></td>
		<td class="cellStyle"><xsl:text>Исполнитель</xsl:text></td>
	</tr>
	<xsl:for-each select="//VISA">
		<tr>
			<xsl:attribute name="style"><xsl:text>COLOR: </xsl:text><xsl:value-of select="COLOR" /></xsl:attribute>

			<td align="left"><xsl:value-of select="CHECKGROUP" /></td>
			<td align="left"><xsl:value-of select="MARK" /></td>
			<td align="left"><xsl:value-of select="USERNAME" /></td>
		</tr>
	</xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>