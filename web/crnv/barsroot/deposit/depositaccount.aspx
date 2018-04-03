<%@ Page language="c#" CodeFile="DepositAccount.aspx.cs" AutoEventWireup="true" Inherits="DepositAccount" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Рахунки виплати</title>
		<meta content="False" name="vs_snapToGrid"/>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/AccCk.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			if (document.getElementById('textBankMFO') != null)
				AddListeners("textBankAccount,textBankMFO,textIntRcpName,textIntRcpOKPO,textAccountNumber,textRestRcpMFO,textRestRcpOKPO,textRestRcpName",
				'onkeydown', TreatEnterAsTab);
			else 
				AddListeners("textAccountNumber,textRestRcpMFO,textRestRcpOKPO,textRestRcpName",
				'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript"  language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
		<script language="javascript" type="text/javascript" >
		function SetPOS() {
			if (document.getElementById('textBankMFO') != null)
				focusControl('textBankMFO');
			else if (!document.getElementById('textRestRcpMFO').disabled)
				focusControl('textRestRcpMFO');
		}
		</script>
	</head>
	<body onload="SetPOS();">
		<form id="Form2asas" method="post" runat="server">
			<table class="MainTable" id="ContractTable">
				<tr>
					<td align="center"><asp:label id="lbInfo" meta:resourcekey="lbInfo10" runat="server" CssClass="InfoHeader">Счета выплаты</asp:label></td>
				</tr>
				<tr>
					<td><asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label></td>
				</tr>
				<tr>
					<td><asp:textbox id="textClientName" meta:resourcekey="textClientName3" tabIndex="1000" runat="server" CssClass="InfoText" ToolTip="Вкладчик"
							MaxLength="70" BorderStyle="Inset" ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td><asp:label id="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:label></td>
				</tr>
				<tr>
					<td><asp:textbox id="textContractType" tabIndex="1001" runat="server" CssClass="InfoText" ToolTip="Вид договора"
							BorderStyle="Inset" ReadOnly="True"></asp:textbox></td>
				</tr>
				<tr>
					<td><asp:label id="lbPercentInfo" runat="server" CssClass="InfoLabel">Выплата процентов</asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td style="width:20%"><asp:label id="lbBankAccount" runat="server" CssClass="InfoText">Номер счета</asp:label></td>
								<td style="width:25%"><asp:textbox id="textBankAccount" tabIndex="2" runat="server" CssClass="InfoText" ToolTip="Номер счета"
										MaxLength="14" BorderStyle="Inset"></asp:textbox></td>
								<td style="width:10%"></td>
								<td style="width:20%"><asp:label id="lbBankMFO" runat="server" CssClass="InfoText">МФО банка</asp:label></td>
								<td style="width:25%"><asp:textbox id="textBankMFO" tabIndex="1" runat="server" CssClass="InfoText" ToolTip="МФО банка"
										MaxLength="12" BorderStyle="Inset"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:label id="lbIntRcpName" runat="server" CssClass="InfoText">Получатель</asp:label></td>
								<td><asp:textbox id="textIntRcpName" tabIndex="4" runat="server" CssClass="InfoText" ToolTip="Получатель"
										MaxLength="35" BorderStyle="Inset"></asp:textbox></td>
								<td></td>
								<td><asp:label id="lbIntRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:label></td>
								<td><asp:textbox id="textIntRcpOKPO" tabIndex="3" runat="server" CssClass="InfoText" ToolTip="Код ОКПО"
										MaxLength="10" BorderStyle="Inset"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td><asp:label id="lbRestInfo" runat="server" CssClass="InfoLabel">Возврат депозита</asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td style="width:20%"><asp:label id="lbAccount" runat="server" CssClass="InfoText">Номер счета</asp:label></td>
								<td style="width:25%"><asp:textbox id="textAccountNumber" tabIndex="7" runat="server" CssClass="InfoText" ToolTip="Номер счета"
										MaxLength="14" BorderStyle="Inset"></asp:textbox></td>
								<td style="width:10%"></td>
								<td style="width:20%"><asp:label id="lbRestRcpMFO" runat="server" CssClass="InfoText">МФО банка</asp:label></td>
								<td style="width:25%"><asp:textbox id="textRestRcpMFO" tabIndex="6" runat="server" CssClass="InfoText" ToolTip="МФО банка"
										MaxLength="12" BorderStyle="Inset"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:label id="lbRestRcpName" runat="server" CssClass="InfoText">Получатель</asp:label></td>
								<td><asp:textbox id="textRestRcpName" tabIndex="9" runat="server" CssClass="InfoText" ToolTip="Получатель"
										MaxLength="35" BorderStyle="Inset"></asp:textbox></td>
								<td></td>
								<td><asp:label id="lbRestRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:label></td>
								<td><asp:textbox id="textRestRcpOKPO" tabIndex="8" runat="server" CssClass="InfoText" ToolTip="Код ОКПО"
										MaxLength="10" BorderStyle="Inset"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbDptField" runat="server">
							<tr>
								<td colSpan="3"><asp:label id="lbDopRec" runat="server" CssClass="InfoLabel">Дополнительные реквизиты вклада</asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td><input id="NMK" type="hidden" runat="server"/> <input id="OKPO" type="hidden" runat="server"/>
						<input id="MFO" type="hidden" runat="server"/> <input id="dpt_controls" type="hidden" name="Hidden1" runat="server"><input id="mand_field" type="hidden" name="Hidden1" runat="server"/></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="ButtonTable">
							<tr>
								<td style="width:20%">
									<input class="DirectionButton" id="btnBack" tabIndex="101" type="button" value="Назад"
										runat="server"/>
								</td>
								<td>
									<input class="DirectionButton" id="btNext" tabIndex="100" type="button" value="Открыть депозит"
										runat="server"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositAccCk.inc"-->
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
