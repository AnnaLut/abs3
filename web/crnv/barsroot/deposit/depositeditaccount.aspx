<%@ Page language="c#" CodeFile="DepositEditAccount.aspx.cs" AutoEventWireup="true" Inherits="DepositEditAccount"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Зміна рахунків виплати</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/AccCk.js"></script>				
		<script type="text/javascript" language="javascript">		
		function AddListener4Enter(){
			AddListeners("textBankAccount,textBankMFO,textIntRcpName,textIntRcpOKPO,textAccountNumber,textRestRcpMFO,textRestRcpOKPO,textRestRcpName",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</head>
	<body onload="document.getElementById('textBankMFO').fireEvent('onblur');document.getElementById('textRestRcpMFO').fireEvent('onblur'); focusControl('textBankMFO');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="MainTable">
				<tr>
					<td align="center"><asp:label CssClass="InfoHeader" id="lbInfo" runat="server"> Перечисление</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<table id="ContractTable" class="InnerTable">
							<tr>
								<td><asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" CssClass="InfoLabel" runat="server">Вкладчик</asp:label></td>
							</tr>
							<tr>
								<td><asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" CssClass="InfoText" MaxLength="70" ToolTip="Вкладчик"
										tabIndex="100" ReadOnly="True"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:label id="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:label></td>
							</tr>
							<tr>
								<td><asp:textbox id="textContractType" meta:resourcekey="textContractTypeName"  runat="server" CssClass="InfoText" ReadOnly="True" BorderStyle="Inset"
										ToolTip="Вид договора" tabIndex="101"></asp:textbox></td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td>
									<table id="tbInt" class="InnerTable">
										<tr>
											<td colSpan="5">
												<asp:label id="lbPercentInfo" meta:resourcekey="lbPercentInfo" runat="server" CssClass="InfoLabel">Выплата процентов</asp:label></td>
										</tr>
										<tr>
											<td style="width:20%">
                                                <asp:label id="lbBankAccount" meta:resourcekey="lbAccNum" CssClass="InfoText" runat="server">Номер счета</asp:label></td>
											<td style="width:25%">
												<asp:textbox id="textBankAccount" meta:resourcekey="textNLS" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="14"
													ToolTip="Номер счета" tabIndex="2"></asp:textbox></td>
											<td style="width:10%">
												<input class="HelpButton" type="button" value="?" onclick="OpenCardAcc('textBankAccount','textBankMFO','textIntRcpOKPO','textIntRcpName');"
													id="btPercent" name="Button1" runat="server"/>
											</td>
											<td style="width:20%">
                                                <asp:label id="lbBankMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО банка</asp:label></td>
											<td style="width:25%">
                                                <asp:textbox id="textBankMFO" meta:resourcekey="textMFO" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="12"
													ToolTip="МФО банка" tabIndex="1"></asp:textbox></td>
										</tr>
										<tr>
											<td>
                                                <asp:label id="lbIntRcpName" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:label></td>
											<td>
                                                <asp:textbox id="textIntRcpName" meta:resourcekey="textNMK" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="35"
													ToolTip="Получатель" tabIndex="4"></asp:textbox></td>
											<td></td>
											<td>
                                                <asp:label id="lbIntRcpOKPO" meta:resourcekey="lbIntRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:label></td>
											<td>
                                                <asp:textbox id="textIntRcpOKPO" meta:resourcekey="textIntRcpOKPO" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="10"
													ToolTip="Код ОКПО" tabIndex="3"></asp:textbox></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td></td>
							</tr>
							<tr>
								<td>
									<table id="tbRest" class="InnerTable">
										<tr>
											<td colspan="5">
												<asp:label id="lbRestInfo" meta:resourcekey="lbRestInfo" CssClass="InfoLabel" runat="server">Возврат депозита</asp:label>
											</td>
										</tr>
										<tr>
											<td style="width:20%">
												<asp:label id="lbAccount" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:label></td>
											<td style="width:25%">
                                                <asp:textbox id="textAccountNumber" meta:resourcekey="textNLS" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="14"
													ToolTip="Номер счета" tabIndex="6"></asp:textbox></td>
											<td style="width:10%">
												<input class="HelpButton" type="button" value="?" onclick="OpenCardAcc('textAccountNumber','textRestRcpMFO','textRestRcpOKPO','textRestRcpName');"
													id="btDeposit" name="Button2" runat="server"/>
											</td>
											<td style="width:20%">
                                                <asp:label id="lbRestRcpMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО банка</asp:label></td>
											<td style="width:25%">
                                                <asp:textbox id="textRestRcpMFO" meta:resourcekey="textMFO" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="12"
													ToolTip="МФО банка" tabIndex="5"></asp:textbox></td>
										</tr>
										<tr>
											<td>
                                                <asp:label id="lbRestRcpName" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:label></td>
											<td>
                                                <asp:textbox id="textRestRcpName" meta:resourcekey="textNMK" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="35"
													ToolTip="Получатель" tabIndex="8"></asp:textbox></td>
											<td></td>
											<td>
                                                <asp:label id="lbRestRcpOKPO" meta:resourcekey="lbIntRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:label></td>
											<td>
                                                <asp:textbox id="textRestRcpOKPO" meta:resourcekey="textIntRcpOKPO" runat="server" CssClass="InfoText" BorderStyle="Inset" MaxLength="10"
													ToolTip="Код ОКПО" tabIndex="7"></asp:textbox></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<input id="NMK" type="hidden" runat="server"/> <input id="OKPO" type="hidden" runat="server"/><input id="rnk" type="hidden" runat="server"/>
									<input id="cur_id" type="hidden" runat="server"/>
									<input id="MFO" type="hidden" runat="server"/><input id="err_n" type="hidden" runat="server" value="0"/>
								</td>
							</tr>
							<tr>
								<td align="left"><input id="btPay" meta:resourcekey="btPay2" type="button" value="Изменить" runat="server" tabIndex="9" class="AcceptButton"/></td>
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
