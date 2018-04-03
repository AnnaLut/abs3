<%@ Page language="c#" CodeFile="DepositProlongation.aspx.cs" AutoEventWireup="true" Inherits="DepositProlongation" %>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Пролонгація</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	</head>
	<body onload="focusControl('btProlongate');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="mainTable" cellSpacing="1">
				<tr>
					<td align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle11" runat="server" CssClass="InfoHeader" Text="Пролонгация депозитного договора № %S"></asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="Table1">
							<tr>
								<td colSpan="2"><asp:label id="lbCustomer" meta:resourcekey="lbCustomer" runat="server" CssClass="InfoLabel">Вкладчик</asp:label></td>
							</tr>
							<tr>
								<td colSpan="2"><asp:textbox id="textClientName" meta:resourcekey="textClientName" runat="server" CssClass="InfoText" ToolTip="ФИО" ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td colSpan="2"><asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" CssClass="InfoText" ToolTip="Паспортные данные"
										ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td width="25%"><asp:label id="lbBirthDate" meta:resourcekey="lbBirthDate" runat="server" CssClass="InfoText">Дата рождения</asp:label></td>
								<td><igtxt:webdatetimeedit id="clientBirthDay" runat="server" CssClass="InfoDateSum" ToolTip="Дата рождения"
										ReadOnly="True" BorderStyle="Inset" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"></igtxt:webdatetimeedit></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbDepositParams">
							<tr>
								<td colSpan="4"><asp:label id="lbDpt" meta:resourcekey="lbDpt2" runat="server" CssClass="InfoLabel">Депозит</asp:label></td>
							</tr>
							<tr>
								<td colSpan="1" rowSpan="1"><asp:label id="lbDptType" meta:resourcekey="lbDptType4" runat="server" CssClass="InfoText">Тип депозита</asp:label></td>
								<td colSpan="3"><asp:textbox id="textDptType" meta:resourcekey="textDptType2" runat="server" CssClass="InfoText" ToolTip="Тип депозита" ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td style="HEIGHT: 25px" width="25%"><asp:label id="lbDptSum" meta:resourcekey="lbDptSum" runat="server" CssClass="InfoText">Сумма на депозитном счете</asp:label></td>
								<td style="HEIGHT: 25px" width="25%"><igtxt:webnumericedit id="textDptSum" runat="server" CssClass="InfoDateSum" ToolTip="Сумма на депозитном счету"
										ReadOnly="True" BorderStyle="Inset" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"></igtxt:webnumericedit></td>
								<td style="HEIGHT: 25px" width="25%"><asp:label id="lbDptCur" meta:resourcekey="lbDptCur2" runat="server" CssClass="InfoText">Валюта депозитного счета</asp:label></td>
								<td style="HEIGHT: 25px" width="25%"><asp:textbox id="textDptCur" meta:resourcekey="textDptCur2" runat="server" CssClass="InfoDateSum" ToolTip="Валюта депозитного договора"
										ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td width="25%"><asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum2" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:label></td>
								<td width="25%"><igtxt:webnumericedit id="textPercentSum" runat="server" CssClass="InfoDateSum" ToolTip="Сумма на счету процентов"
										ReadOnly="True" BorderStyle="Inset" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"></igtxt:webnumericedit></td>
								<td width="25%"><asp:label id="lbPercentRate" meta:resourcekey="lbPercentRate2" runat="server" CssClass="InfoText">Процентная ставка</asp:label></td>
								<td width="25%"><igtxt:webnumericedit id="textRate" runat="server" CssClass="InfoDateSum" ToolTip="Сумма на счету процентов"
										ReadOnly="True" BorderStyle="Inset" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"></igtxt:webnumericedit></td>
							</tr>
							<tr>
								<td width="25%"><asp:label id="lbDptStartDate" meta:resourcekey="lbDptStartDate" runat="server" CssClass="InfoText">Дата начала договора</asp:label></td>
								<td width="25%"><igtxt:webdatetimeedit id="textDptStartDate" runat="server" CssClass="InfoDateSum" ToolTip="Дата начала депозитного договора"
										ReadOnly="True" BorderStyle="Inset" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" HorizontalAlign="Center"></igtxt:webdatetimeedit></td>
								<td width="25%"><asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата окончания договора</asp:label></td>
								<td width="25%"><igtxt:webdatetimeedit id="textDptEndDate" runat="server" CssClass="InfoDateSum" ToolTip="Дата окончания депозитного договора"
										ReadOnly="True" BorderStyle="Inset" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" HorizontalAlign="Center"></igtxt:webdatetimeedit></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbPercent">
							<tr>
								<td><asp:label id="lbDptPercent" meta:resourcekey="lbDptPercent" runat="server" CssClass="InfoLabel">Вибор действия с процентами</asp:label></td>
							</tr>
							<tr>
								<td>
									<input id="rb_capital" tabIndex="0" type="radio" CHECKED value="Radio1" name="RadioGroup"
										runat="server" onclick="document.getElementById('rb').value = 1;">
									<LABEL runat="server" class="RadioText" id="cap" meta:resourcekey="cap" tabIndex="0" for="rb_capital">Капитализация</LABEL>
								</td>
							</tr>
							<tr>
								<td>
									<input id="rb_pay" tabIndex="0" type="radio" value="Radio1" name="RadioGroup" runat="server"
										onclick="document.getElementById('rb').value = 2;">
									<LABEL runat="server" class="RadioText" id="pay" meta:resourcekey="pay" tabIndex="0" for="rb_pay">Выплата</LABEL></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="Table2">
							<tr>
								<td colSpan="4"><asp:label id="lbDptDates" meta:resourcekey="lbDptDates" runat="server" CssClass="InfoLabel">Новые даты договора</asp:label></td>
							</tr>
							<tr>
								<td width="25%"><asp:label id="lbNewDptStartDate" meta:resourcekey="lbNewDptStartDate" runat="server" CssClass="InfoText">Новая дата начала договора</asp:label></td>
								<td width="25%"><igtxt:webdatetimeedit id="textNewDptStartDate" runat="server" CssClass="InfoDateSum" ToolTip="Новая дата начала депозитного договора"
										ReadOnly="True" BorderStyle="Inset" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" HorizontalAlign="Center"></igtxt:webdatetimeedit></td>
								<td width="25%"><asp:label id="lbNewDptEndDate" meta:resourcekey="lbNewDptEndDate" runat="server" CssClass="InfoText">Новая дата окончания договора</asp:label></td>
								<td width="25%"><igtxt:webdatetimeedit id="textNewDptEndDate" runat="server" CssClass="InfoDateSum" ToolTip="Новая дата окончания депозитного договора"
										ReadOnly="True" BorderStyle="Inset" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" HorizontalAlign="Center"></igtxt:webdatetimeedit></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><input class="AcceptButton" id="btProlongate" meta:resourcekey="btProlongate" tabIndex="1" type="button" value="Пролонгировать"
							name="Button1" runat="server"><input id="Templates" type="hidden" name="Hidden1" runat="server"><input id="vidd" type="hidden" name="Hidden1" runat="server"><input id="rb" type="hidden" value="1" name="Hidden1" runat="server"></td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
