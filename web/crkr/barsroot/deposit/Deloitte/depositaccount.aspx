<%@ Page language="c#" CodeFile="DepositAccount.aspx.cs" AutoEventWireup="true" Inherits="DepositAccount" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagPrefix="scan" TagName="TextBoxScanner" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Рахунки виплати</title>
		<meta content="False" name="vs_snapToGrid"/>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.1"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js"></script>
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
		//	CrossAddEventListener(window, 'onload', AddListener4Enter);
		//-->
		</script>
		<script language="javascript" type="text/javascript" >
		    function AfterPageLoad()
            {
			    if (!isEmpty(document.getElementById('MFO').value))
                {
                    document.getElementById('textBankMFO').value = document.getElementById('MFO').value;
                    document.getElementById('textRestRcpMFO').value = document.getElementById('MFO').value;
                    // відсотки
                    document.getElementById('textBankMFO').readOnly = true;
                    document.getElementById('textBankAccount').readOnly = true;
                    document.getElementById('textIntRcpName').readOnly = true;
                    // депозит
                    document.getElementById('textRestRcpMFO').readOnly = true;
                    document.getElementById('textAccountNumber').readOnly = true;
                    document.getElementById('textRestRcpName').readOnly = true;
                }
                if (!isEmpty(document.getElementById('OKPO').value))
                {
                    document.getElementById('textIntRcpOKPO').value = document.getElementById('OKPO').value;
                    document.getElementById('textRestRcpOKPO').value = document.getElementById('OKPO').value;
                    document.getElementById('textIntRcpOKPO').readOnly = true;
                    document.getElementById('textRestRcpOKPO').readOnly = true;
                }
		    }
		</script>
	</head>
	<body onload="AfterPageLoad();">
		<form id="Form2asas" method="post" runat="server">
             <ajx:ToolkitScriptManager ID="sm" runat="server" />
			<table class="MainTable" id="ContractTable">
				<tr>
					<td align="center">
                        <asp:label id="lbInfo" Text="Рахунки виплати" meta:resourcekey="lbInfo10" runat="server" CssClass="InfoHeader" />
                    </td>
				</tr>
				<tr>
					<td>
                        <asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
                    </td>
				</tr>
				<tr>
					<td><asp:textbox id="textClientName" meta:resourcekey="textClientName3" tabIndex="1000" runat="server" CssClass="InfoText" ToolTip="Вкладчик"
							MaxLength="70" BorderStyle="Inset" ReadOnly="True"></asp:textbox>
                    </td>
				</tr>
				<tr>
					<td>
                        <asp:label id="lbContractType" Text="Вид договору" runat="server" 
                            meta:resourcekey="lbContractType" CssClass="InfoLabel" />
                    </td>
				</tr>
				<tr>
					<td>
                        <asp:textbox id="textContractType" tabIndex="1001" runat="server" CssClass="InfoText" ToolTip="Вид договора"
							BorderStyle="Inset" ReadOnly="True"></asp:textbox>
                    </td>
				</tr>
				<tr>
					<td>
                        <asp:label id="lbPercentInfo" Text="Виплата відсотків" runat="server" CssClass="InfoLabel" />
                    </td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>								
                                <td align="right" style="width:20%">
                                    <asp:label id="lbBankMFO" Text="МФО банку: &nbsp;" runat="server" CssClass="InfoText" />
                                </td>
								<td align="left" style="width:10%">
                                    <asp:textbox id="textBankMFO" tabIndex="1" runat="server" CssClass="InfoText" 
                                    	MaxLength="6" ToolTip="МФО банку отримувача" BorderStyle="Inset" />
                                </td>
                                <td style="width:20%"></td>
                                <td align="right" style="width:19%">
                                    <asp:label id="lbBankAccount" Text="Номер рахунку:" runat="server" CssClass="InfoText" />
                                </td>
                                <td align="right" style="width:1%">
                                    <asp:RequiredFieldValidator ID="rfvBankAccount" ControlToValidate="textBankAccount"
                                        ValidationGroup="CheckFields" ErrorMessage="Не вказано рахунок виплати відсотків!"
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                    <asp:Label ID="lbvBankAccount" runat="server" Text="*" CssClass="Required" />
                                </td>
								<td style="width:20%">                                    
                                    <asp:textbox id="textBankAccount" tabIndex="2" runat="server" CssClass="InfoText" BorderStyle="Inset"
                                        ToolTip="Номер рахунку" MaxLength="14" Width="99%" />
                                </td>
								<td style="width:10%">
                                </td>
							</tr>
							<tr>
								<td align="right">
                                    <asp:label id="lbIntRcpName" Text="Отримувач: &nbsp;" runat="server" CssClass="InfoText"/>
                                </td>
								<td colspan="2">
                                    <asp:textbox id="textIntRcpName" tabIndex="4" runat="server" CssClass="InfoText" ToolTip="Получатель"
										MaxLength="35" BorderStyle="Inset"></asp:textbox></td>
								<td align="right">
                                    <asp:label id="lbIntRcpOKPO" Text="Код ОКПО:" runat="server" CssClass="InfoText"/>
                                </td>
                                <td></td>
								<td>
                                    <asp:textbox id="textIntRcpOKPO"  tabIndex="3" runat="server" BorderStyle="Inset"
										MaxLength="10" ToolTip="Код ОКПО клієнта" Width="60%" CssClass="InfoText" />
                                </td>
                                <td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td><asp:label id="lbRestInfo" Text="Повернення депозиту" runat="server" CssClass="InfoLabel" />
                </td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
                            <tr>
								<td align="right" style="width:20%">
                                    <asp:label id="lbRestRcpMFO" Text="МФО банку: &nbsp;" runat="server" CssClass="InfoText" />
                                </td>
								<td style="width:10%">
                                    <asp:textbox id="textRestRcpMFO" tabIndex="6" runat="server" ToolTip="МФО банку"
										MaxLength="6" BorderStyle="Inset" CssClass="InfoText" />
                                </td>
								<td style="width:20%"></td>
								<td align="right" style="width:19%">
                                    <asp:label id="lbAccount" Text="Номер рахунку:" runat="server" CssClass="InfoText" />
                                </td>
                                <td align="right" style="width:1%">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="textBankAccount"
                                        ValidationGroup="CheckFields" ErrorMessage="Не вказано рахунок виплати депозиту!"
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                    <asp:Label ID="lbvAccount" runat="server" Text="*" CssClass="Required" />
                                </td>
								<td style="width:20%">
                                    <asp:textbox id="textAccountNumber" tabIndex="7" runat="server" CssClass="InfoText" BorderStyle="Inset"
									    ToolTip="Номер рахунку" MaxLength="14" Width="98%" />
                                </td>
                                <td style="width:10%">
                                    <input id="btnAccounts" onclick="showAccounts('ALL')" type="button" 
                                        runat="server" class="ImgButton" 
                                        value="?" title="Вибрати рахунок для виплати вкладу" />
                                </td>
							</tr>
							<tr>
								<td align="right">
                                    <asp:label id="lbRestRcpName" Text="Отримувач: &nbsp;" runat="server" CssClass="InfoText" />
                                </td>
								<td colspan="2">
                                    <asp:textbox id="textRestRcpName" tabIndex="9" runat="server" CssClass="InfoText"
										MaxLength="35" BorderStyle="Inset" />
                                </td>
								<td align="right">
                                    <asp:label id="lbRestRcpOKPO" Text="Код ОКПО:" runat="server" CssClass="InfoText" />
                                </td>
                                <td></td>
								<td>
                                    <asp:textbox id="textRestRcpOKPO" tabIndex="8"  runat="server" BorderStyle="Inset"
                                        ToolTip="Код ОКПО клієнта" MaxLength="10" Width="60%" CssClass="InfoText"  />
                                </td>
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
								<td colspan="3">
                                    <asp:label id="lbDopRec" Text="Дополнительные реквизиты вклада" runat="server" CssClass="InfoLabel" Visible ="False" />
                                </td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
                        <input id="RNK" type="hidden" runat="server"/>
                        <input id="NMK" type="hidden" runat="server"/>
                        <input id="OKPO" type="hidden" runat="server"/>
                        <input id="MFO" type="hidden" runat="server"/>
                        <input id="KV" type="hidden" runat="server"/>
                        <input id="dpt_controls" type="hidden" runat="server" />
                        <input id="mand_field" type="hidden" runat="server"/>
                    </td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="ButtonTable">
							<tr>
								<td style="width:25%">
									<input id="btnBack" tabindex="101" type="button" runat="server"
										value="Назад" class="AcceptButton" causesvalidation="false" />
								</td>
                                <td style="width:25%">
                                    <asp:ValidationSummary ID="Summary" runat="server" ShowMessageBox="true" ShowSummary="false"
                                        ValidationGroup="CheckFields" HeaderText="Помилка у введених даних:" />
                                </td>
                                <td style="width:25%">
                                   <scan:textboxscanner runat="server" ID="scWarrant" IsRequired="true" ReadOnly="false" Visible ="false"
                                        ValidationGroup="Send" />
                                 </td>
								<td style="width:25%">
									<input id="btNext" tabindex="100" type="button" runat="server"
										value="Відкрити договір" class="AcceptButton" 
                                        causesvalidation="true" validationgroup="CheckFields"  />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositAccCk.inc"-->
			<!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
