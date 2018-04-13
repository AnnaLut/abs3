<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositRateEdit.aspx.cs" AutoEventWireup="true" Inherits="DepositRateEdit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Зміна відсоткової ставки</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" width="75%"><asp:label id="lbTitle" meta:resourcekey="lbTitle18" runat="server" CssClass="InfoHeader" Text="Изменение процентной ставки по депозиту №"></asp:label></td>
								<td align="left"><asp:textbox id="textDptNum" meta:resourcekey="textDepositNumber" runat="server" CssClass="HeaderText" ToolTip="№ депозита" ReadOnly="True"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td><asp:label id="lbCustomer" meta:resourcekey="lbCustomer" runat="server" CssClass="InfoLabel">Вкладчик</asp:label></td>
							</tr>
							<tr>
								<td><asp:textbox id="textClientName" meta:resourcekey="textClientName" runat="server" CssClass="InfoText" ToolTip="ФИО вкладчика" ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2"  runat="server" CssClass="InfoText" ToolTip="Паспортные данные"
										ReadOnly="True"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="left" colSpan="5">
									<asp:label id="lbDepInfo" meta:resourcekey="lbDepInfo" runat="server" CssClass="InfoLabel">Параметры депозитного договора</asp:label></td>
							</tr>
							<tr>
								<td width="30%">
									<asp:label id="lbDptType" meta:resourcekey="lbDptType3" runat="server" CssClass="InfoText">Тип депозитного договора</asp:label></td>
								<td colSpan="4">
									<asp:textbox id="DepositType" meta:resourcekey="DepositType" runat="server" CssClass="InfoText" ToolTip="Тип депозитного договора"
										ReadOnly="True"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td width="30%">
									<asp:label id="lbDepositSum" meta:resourcekey="lbDepositSum2" runat="server" CssClass="InfoText">Сумма на депозитном счете</asp:label></td>
								<td width="15%">
									<igtxt:WebNumericEdit id="dptSum" runat="server" ReadOnly="True" MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces"
										CssClass="InfoDateSum"></igtxt:WebNumericEdit>
								</td>
								<td width="10%"></td>
								<td width="30%">
									<asp:label id="lbDptAccCur" meta:resourcekey="lbDptAccCur" runat="server" CssClass="InfoText">Валюта депозитного счёта</asp:label></td>
								<td width="15%">
									<asp:textbox id="dptCurrency" meta:resourcekey="dptCurrency" runat="server" CssClass="InfoText" ToolTip="Валюта депозитного договора"
										ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum2" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:label></td>
								<td>
									<igtxt:WebNumericEdit id="percentSum" runat="server" CssClass="InfoDateSum" ReadOnly="True" MinValue="0"
										DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces"></igtxt:WebNumericEdit></td>
								<td></td>
								<td>
									<asp:label id="lbPercentRate" meta:resourcekey="lbPercentRate" runat="server" CssClass="InfoText">Номинальная процентная ставка</asp:label></td>
								<td>
									<igtxt:WebNumericEdit id="textCurRate" runat="server" CssClass="InfoDateSum" ReadOnly="True" MinValue="0"
										DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces"></igtxt:WebNumericEdit></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="30%">
									<asp:Label id="lbNewRate" meta:resourcekey="lbNewRate" runat="server" CssClass="InfoText">Новая ставка</asp:Label>
								</td>
								<td width="15%">
									<igtxt:WebNumericEdit id="textNewRate" runat="server" CssClass="InfoDateSum" MinValue="0" DataMode="Decimal"
										MinDecimalPlaces="SameAsDecimalPlaces" ValueText="000"></igtxt:WebNumericEdit>
								</td>
								<td width="10%">
								</td>
								<td width="30%">
									<asp:Label id="lbDate" meta:resourcekey="lbDate" runat="server" CssClass="InfoText">Дата установки</asp:Label>
								</td>
								<td width="15%">
									<igtxt:WebDateTimeEdit id="dtStartDate" runat="server" CssClass="InfoDateSum" ToolTip="Дата начала действия новой процентной ставки"
										HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" Enabled="False"></igtxt:WebDateTimeEdit>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><input class="AcceptButton" id="btSet" meta:resourcekey="btSet" type="button" value="Установить" runat="server">
						<input id="dptacc" type="hidden" runat="server" name="dptacc" />
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
		</form>
	</body>
</html>
