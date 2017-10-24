<%@ Page language="c#" CodeFile="accextract.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.AccExtract"  enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Рух по рахунку</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="Scripts\Common.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript">
			function checkPrintBtn() 
			{
				if(document.all.hPrintFlag.value != '1')
				{
					document.all.btPrintHtml.style.visibility = "hidden";
					document.all.btPrintRtf.style.visibility = "hidden";
				}
				// Локализация
				LocalizeHtmlTitle("btPrintHtml");
                LocalizeHtmlTitle("btPrintRtf");
			}
		</script>
	</HEAD>
	<body onload="checkPrintBtn()">
		<form id="Form1" method="post" runat="server">
			<TABLE id="tb_main" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD align="center">
						<table width="100%">
							<tr>
								<td align="center">
									<DIV class="TitleText" id="Title1" meta:resourcekey="Title1" style="DISPLAY: inline;" runat="server">Выписка по счету № </DIV>
									<DIV class="TitleText" id="TitleNLS" style="DISPLAY: inline;" runat="server">Label</div>
                                    <DIV class="TitleText" id="Title2" meta:resourcekey="Title2" style="DISPLAY: inline;" runat="server"> за </div>
                                    <DIV class="TitleText" id="TitleDate" style="DISPLAY: inline;" runat="server">Label</div>
								</td>
								<TD noWrap width="1"><img src="/Common/Images/Print.gif" title="Печать выписки по счету(html формат)" style='visibility:hidden' onclick="printExtract(0)"
										id="btPrintHtml"></TD>
								<td noWrap width="1"><img src="/Common/Images/word_2005.gif" title="Печать выписки по счету(rtf формат)" style='visibility:hidden' onclick="printExtract(1)"
										id="btPrintRtf"></td>
							</tr>
						</table>
					</TD>
				</TR>
				<TR>
					<TD style="HEIGHT: 90px" align="center">
						<TABLE id="tbHeader" style="BORDER-RIGHT: graytext thin solid; BORDER-TOP: graytext thin solid; VERTICAL-ALIGN: sub; BORDER-LEFT: graytext thin solid; BORDER-BOTTOM: graytext thin solid; TEXT-ALIGN: center; TEXT-DECORATION: none"
							borderColor="graytext" cellSpacing="1" cellPadding="1" width="100%" align="center"
							border="0">
							<TR>
								<TD style="FONT-SIZE: 18pt; WIDTH: 103px; HEIGHT: 19px"><FONT size="3">
										<DIV class="UnderLinedText" id="lbDos" meta:resourcekey="lbDos" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
											ms_positioning="FlowLayout">Дебет
										</DIV>
									</FONT>
								</TD>
								<TD>
									<DIV class="UnderLinedText" id="lbKos" meta:resourcekey="lbKos" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>Кредит</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 19px">
									<DIV class="UnderLinedText" id="lbComm" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">---------</DIV>
								</TD>
								<TD style="HEIGHT: 19px">
									<DIV class="UnderLinedText" id="lbValueDat" meta:resourcekey="lbValueDat" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">Дата валютирования</DIV>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 103px; HEIGHT: 23px" nowrap="noWrap">
									<DIV class="SimpleText" id="lbVhodDeb" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 23px" nowrap="noWrap">
									<DIV class="SimpleText" id="lbVhodKred" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 23px; TEXT-ALIGN: center">
									<DIV class="SimpleText" id="lbVhodSald" meta:resourcekey="lbVhodSald" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>Входящее сальдо</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 23px">
									<DIV class="SimpleText" id="lbVhodDat" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 103px; HEIGHT: 22px" nowrap="noWrap">
									<DIV class="SimpleText" id="lbSumDeb" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 22px" nowrap="noWrap">
									<DIV class="SimpleText" id="lbSumKred" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD style="HEIGHT: 22px">
									<DIV class="SimpleText" id="lbSumFactObor" meta:resourcekey="lbSumFactObor" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										Сумма фактических оборотов
									</DIV>
								</TD>
								<TD style="HEIGHT: 22px"></TD>
							</TR>
							<TR>
								<TD style="WIDTH: 103px" nowrap="noWrap">
									<DIV class="SimpleText" id="lbIshodDeb" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD nowrap="noWrap">
									<DIV class="SimpleText" id="lbIshodKred" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
								<TD>
									<DIV class="SimpleText" id="lbIshodSald" meta:resourcekey="lbIshodSald" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">Исходящее сальдо</DIV>
								</TD>
								<TD>
									<DIV class="SimpleText" id="lbIshodDat" style="DISPLAY: inline; HEIGHT: 15px" runat="server"
										ms_positioning="FlowLayout">
										<P>&nbsp;Нет данных</P>
									</DIV>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD colSpan="1"><div style="height:450px;OVERFLOW:auto;WIDTH:expression(document.body.clientWidth-12)"><asp:datagrid id="gridAccExtract" runat="server" BorderStyle="Solid" BorderColor="Black" BorderWidth="1px"
							Width="100%" EnableViewState="False" AutoGenerateColumns="False" PageSize="1" EnableTheming="True" BackColor="White" CellPadding="0" CellSpacing="1">
							<ItemStyle Font-Size="10pt" HorizontalAlign="Center" CssClass="BodyCell" Font-Names="Verdana"></ItemStyle>
							<HeaderStyle HorizontalAlign="Center" ForeColor="White" VerticalAlign="Middle" BackColor="Gray" Font-Names="Verdana" Font-Size="10pt"></HeaderStyle>
							<Columns>
								<asp:BoundColumn DataField="REF" HeaderText="Референс"></asp:BoundColumn>
								<asp:BoundColumn DataField="TT" HeaderText="Код оп."></asp:BoundColumn>
                                <asp:BoundColumn DataField="NAM_B" HeaderText="Корреспондирующий счет">
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                                    <HeaderStyle Width="20%" />
                                </asp:BoundColumn>
								<asp:BoundColumn DataField="DOS" HeaderText="Дебет" DataFormatString="{0:### ### ### ### ##0.00##}">
									<ItemStyle HorizontalAlign="Right" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False"></ItemStyle>
                                    <HeaderStyle Width="10%" />
								</asp:BoundColumn>
								<asp:BoundColumn DataField="KOS" HeaderText="Кредит" DataFormatString="{0:### ### ### ### ##0.00##}">
									<ItemStyle HorizontalAlign="Right" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False"></ItemStyle>
                                    <HeaderStyle Width="10%" />
								</asp:BoundColumn>
								<asp:BoundColumn DataField="COMM" HeaderText="Коммент.">
									<ItemStyle HorizontalAlign="Left" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="True"></ItemStyle>
                                    <HeaderStyle Width="40%"  />
								</asp:BoundColumn>
								<asp:BoundColumn DataField="PDAT" HeaderText="Дат. поступления">
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Width="10%" />
                                </asp:BoundColumn>
								<asp:BoundColumn DataField="SOS" HeaderText="SOS" Visible="False"></asp:BoundColumn>
								<asp:BoundColumn DataField="TT" HeaderText="ОП" Visible="False"></asp:BoundColumn>
                                <asp:BoundColumn DataField="ND" HeaderText="Номер документа" Visible="False">
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" HorizontalAlign="Left" />
                                    <HeaderStyle Width="10%" />
                                </asp:BoundColumn>
							</Columns>
							<PagerStyle NextPageText="&gt;&gt;" PrevPageText="&lt;&lt;"></PagerStyle>
						</asp:datagrid></div>
                        <asp:PlaceHolder ID="phLoc" runat="server"></asp:PlaceHolder>
                    </TD>
				</TR>
			</TABLE>
			<input type="hidden" id="hPrintFlag" runat="server" NAME="hPrintFlag">
            <input type="hidden" id="forbtPrintHtml" meta:resourcekey="forbtPrintHtml2" runat="server" value="Печать выписки по счету (html формат)">
            <input type="hidden" id="forbtPrintRtf" meta:resourcekey="forbtPrintRtf2" runat="server" value="Печать выписки по счету (rtf формат)">
		</form>
	</body>
</HTML>
