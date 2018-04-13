<%@ Page language="c#" CodeFile="DepositTermRateEdit.aspx.cs" AutoEventWireup="true" Inherits="DepositTermRateEdit"  enableViewState="False"%>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Зміна терміну</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="tbMain" class="MainTable">
				<tr>
					<td colSpan="4" align="center">
						<asp:Label id="lbInfo" meta:resourcekey="lbInfo13" runat="server" CssClass="InfoHeader">Изменение</asp:Label>
					</td>
				</tr>
				<tr>
					<td colSpan="4"></td>
				</tr>
				<tr>
					<td colSpan="4">
						<table class="InnerTable">
							<tr>
								<td width="30%">
									<asp:Label id="lbDpt_id" meta:resourcekey="lbDpt_id" runat="server" CssClass="InfoText" Text="Депозитный договор №"></asp:Label>
								</td>
								<td>
									<asp:TextBox id="textDptNum" runat="server" ReadOnly="True" CssClass="InfoDateSum"></asp:TextBox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
                <tr>
                    <td colspan="4">
                        <table id="tbNewRate" runat="server" class="InnerTable">
                            <tr>
                                <td>
                                    <bars:barsgridview id="gridRates" runat="server" autogeneratecolumns="False" cssclass="BaseGrid"
                                        datasourceid="dsRates" datemask="dd/MM/yyyy"><Columns>
<asp:BoundField HtmlEncode="False" DataField="FORM" HeaderText="*">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQ_ID" HeaderText="Ід. запиту">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQC_OLDINT" HeaderText="Стара ставка">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQC_NEWINT" HeaderText="Нова ставка">
<ItemStyle HorizontalAlign="Right"></ItemStyle>
</asp:BoundField>
                                            <asp:BoundField DataField="REQC_BEGDATE" HeaderText="Початок дії нової ставки">
                                                <itemstyle horizontalalign="Center" />
                                            </asp:BoundField>
<asp:BoundField DataField="REQC_EXPDATE" HeaderText="Гранична дата встановлення">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQ_CRDATE" HeaderText="Дата створення запиту">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQ_CRUSER" HeaderText="Створив запит">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>
</bars:barsgridview>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsRates" runat="server"></bars:barssqldatasource>
                                    <input type="hidden" runat="server" id="hid_req_id" />
                                    <input type="hidden" runat="server" id="hid_new_rate" />
                                    <input type="hidden" runat="server" id="hid_new_date" />
                                </td>
                            </tr>                            
                        </table>
                    </td>
                </tr>
				<tr>
					<td colSpan="4">
						<table id="tbRate" runat="server" class="InnerTable">
							<tr>
								<td style="width:30%">
									<asp:Label id="lbDptCurRate" meta:resourcekey="lbDptCurRate" CssClass="InfoText" runat="server">Текущая процентная ставка</asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="CurRate" runat="server" CssClass="InfoDateSum" ReadOnly="True"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
									<asp:Label id="lbNewDptRate" meta:resourcekey="lbNewDptRate" runat="server" CssClass="InfoText">Новая процентная ставка</asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="NewRate" runat="server" CssClass="InfoDateSum" ReadOnly="True"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
                                    <asp:Label ID="lbNewDptRateDate" runat="server" CssClass="InfoText" meta:resourcekey="lbNewDptRateDate"
                                        Text="Дата начала действия"></asp:Label></td>
								<td>
                                    <asp:TextBox ID="NewRateDate" runat="server" CssClass="InfoDateSum" ReadOnly="True"></asp:TextBox>
                                 </td>
							</tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
							<tr>
								<td>
									<input id="btChangeDptRate" meta:resourcekey="btChangeDptRate" type="button" value="Изменить" runat="server" class="AcceptButton"/>
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="4">
						<table id="tbTerm" runat="server" class="InnerTable">
							<tr>
								<td style="width:30%">
									<asp:Label id="lbCurStartDate" meta:resourcekey="lbCurStartDate" runat="server" CssClass="InfoText">Дата начала действия договора</asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="CurStartDate" runat="server" CssClass="InfoDateSum" ReadOnly="True"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
									<asp:Label id="lbCurEndDate" meta:resourcekey="lbCurEndDate" runat="server" CssClass="InfoText">Текущая дата завершения договора</asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="CurEndDate" runat="server" CssClass="InfoDateSum"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
									<asp:Label id="lbNewDptDate" meta:resourcekey="lbNewDptDate" runat="server" CssClass="InfoText">Новая дата завершения догвора</asp:Label>
								</td>
								<td>
                                    <asp:TextBox ID="NewEndDate" runat="server" CssClass="InfoDateSum"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td>
									<input id="btChangeDptTerm" meta:resourcekey="btChangeDptRate" type="button" value="Изменить" class="AcceptButton" runat="server">
								</td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="4">
						<input id="text_agr_id" type="hidden" runat="server"/> 
						<input id="template_id" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
		</form>
	</body>
</html>
