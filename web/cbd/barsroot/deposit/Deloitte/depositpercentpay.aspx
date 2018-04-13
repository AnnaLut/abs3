<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositPercentPay.aspx.cs" AutoEventWireup="true" Inherits="DepositPercentPay" aspCompat="True"%>
<%@ Register src="~/UserControls/BPKIdentification.ascx" tagname="BPKIdentification" tagprefix="bpk" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Виплата відсотків</title>
		<meta content="False" name="vs_snapToGrid"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textSum_t,textMFO,textOKPO,textNLS,textNMK",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
        <script type="text/javascript" language="javascript">
            function AfterPageLoad()
            {
		        // document.getElementById('btSearchByBPK_btnOk').onclick("if (CheckSum('textPercentSum','textSum',false) && Valid(1))");
		        focusControl('textSum_t');
            }
        </script>
	</head>
	<body style="background-attachment:fixed" onload="AfterPageLoad();">
       
		<form id="Form1" method="post" runat="server">
             <asp:ScriptManager ID="ScriptManager" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="70%" align="right">
									<asp:label id="lbInfo" meta:resourcekey="lbInfo3" runat="server" CssClass="InfoHeader">Выплата процентов по депозиту №</asp:label>
								</td>
								<td align="left">
									<asp:textbox id="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server" ReadOnly="True" ToolTip="№ депозита" CssClass="HeaderText"></asp:textbox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="ContractTable">
							<tr>
								<td colspan="3">
									<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" ReadOnly="True" ToolTip="Вкладчик" MaxLength="70"
										CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" ReadOnly="True" ToolTip="Паспортные данные" MaxLength="70"
										CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td width="30%">
									<asp:label id="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoText">Дата рождения</asp:label>
								</td>
								<td>
									<igtxt:webdatetimeedit id="DateR" runat="server" ReadOnly="True" ToolTip="Дата рождения" HorizontalAlign="Center"
										DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="3">
									<asp:label id="lbDptType" meta:resourcekey="lbDptType2" runat="server" CssClass="InfoText">Вид договора</asp:label>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<asp:textbox id="textDptType" meta:resourcekey="textDptType" runat="server" ReadOnly="True" ToolTip="Вид договора" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<asp:label id="lbDptParams" meta:resourcekey="lbDptParams" runat="server" CssClass="InfoLabel">Параметры вклада</asp:label>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table class="InnerTable">
										<tr>
											<td width="30%">
												<asp:label id="lbDptCur" meta:resourcekey="lbDptCur" runat="server" CssClass="InfoText">Валюта дог.</asp:label>
											</td>
											<td width="15%">
												<asp:textbox id="textDptCur" meta:resourcekey="textDptCur" runat="server" ReadOnly="True" ToolTip="Валюта договора" CssClass="InfoText"></asp:textbox>
											</td>
											<td width="5%"></td>
											<td width="30%">
												<asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum"  runat="server" CssClass="InfoText">Невыплаченная сумма процентов</asp:label>
											</td>
											<td width="5%">
												<asp:textbox id="textPercentCur" meta:resourcekey="textPercentCur" runat="server" ReadOnly="True" ToolTip="Валюта" CssClass="InfoText"></asp:textbox>
											</td>
											<td>
												<igtxt:webnumericedit id="textPercentSum" runat="server" ToolTip="Минимальная сумма вклада" ReadOnly="True"
													MaxLength="10" ValueText="0.00" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
										</tr>
                                        <tr runat="server" id="inherit_row">
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td>
                                                <asp:Label ID="lbInheritSum" runat="server" CssClass="InfoText" meta:resourcekey="lbInheritSum" Text="Сумма доступная наследнику"></asp:Label></td>
                                            <td></td>
                                            <td>
                                                <igtxt:WebNumericEdit id="InheritSum" runat="server" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
													ReadOnly="True" CssClass="InfoDateSum"></igtxt:WebNumericEdit>
                                            </td>
                                        </tr>
										<tr>
											<td>
												<asp:label id="lbDptRate" meta:resourcekey="lbDptRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:label>
											</td>
											<td>
												<igtxt:webnumericedit id="textDptRate" runat="server" ReadOnly="True" ToolTip="Текущая процентная ставка"
													MaxLength="10" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" ValueText="0.00" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbSum" meta:resourcekey="lbSum" runat="server" CssClass="InfoText">Сумма выплаты</asp:label>
											</td>
											<td>
												<asp:textbox id="textSumCur" meta:resourcekey="textSumCur" runat="server" ReadOnly="True" ToolTip="Валюта" CssClass="InfoText"></asp:textbox>
											</td>
											<td>
												<igtxt:WebNumericEdit id="textSum" runat="server" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
													tabIndex="1" CssClass="InfoDateSum"></igtxt:WebNumericEdit>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbDptStartDate" meta:resourcekey="lbDptStartDate" CssClass="InfoText" runat="server">Дата начала договора</asp:label>
											</td>
											<td>
												<igtxt:webdatetimeedit id="dtStartContract" runat="server" ReadOnly="True" ToolTip="Дата завершения договора"
													HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:label>
											</td>
											<td colspan="2">
												<igtxt:webdatetimeedit id="dtEndContract" runat="server" ReadOnly="True" ToolTip="Дата завершения договора"
													DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" HorizontalAlign="Center" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3"></td>
							</tr>
							<tr>
								<td colspan="3">
									<table id="tbPayAcc" runat="server" class="InnerTable">
										<tr>
											<td colspan="5">
												<asp:label id="lbPayAccount" meta:resourcekey="lbPayAccount" runat="server" CssClass="InfoLabel">Выплата</asp:label>
											</td>
										</tr>
										<tr>
											<td style="width:20%">
												<asp:label id="lbAccNum" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:label>
											</td>
											<td style="width:25%">
												<asp:textbox id="textNLS" meta:resourcekey="textNLS" runat="server"  MaxLength="14" CssClass="InfoText"
													tabIndex="3" ToolTip="Номер счета" />
											</td>
											<td width="10%"></td>
											<td width="20%">
												<asp:label id="lbMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО Банка</asp:label>
											</td>
											<td>
												<asp:textbox id="textMFO" meta:resourcekey="textMFO" runat="server" ToolTip="МФО Банка" MaxLength="12" tabIndex="2" CssClass="InfoText"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbNMK" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:label>
											</td>
											<td>
												<asp:textbox id="textNMK" meta:resourcekey="textNMK" runat="server" ToolTip="Получатель" CssClass="InfoText" tabIndex="5"></asp:textbox>
											</td>
											<td></td>
											<td>
												<asp:label id="lbOKPO" meta:resourcekey="lbOKPO" runat="server" CssClass="InfoText">ОКПО получателя</asp:label>
											</td>
											<td>
												<asp:textbox id="textOKPO" meta:resourcekey="textOKPO" runat="server" ToolTip="ОКПО получателя" CssClass="InfoText" MaxLength="10"
													tabIndex="4"></asp:textbox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input id="btPay" meta:resourcekey="btPay" type="button" value="Виплата" runat="server" tabindex="6" class="AcceptButton" />
                                    <bpk:BPKIdentification id="btAuthorizationByBPK" Text="Виплата" runat="server" tabIndex="6" Visible="false"
                                        BeforeIdentifyJS="if (!CheckSum('textPercentSum','textSum',false) && Valid(0)) return false;"
                                        OnClientIdentified="btAuthorizationByBPK_ClientIdentified" />
                                </td>
							</tr>
							<tr>
								<td colspan="3">
									<input id="PercentNls" type="hidden" runat="server"/> <input id="PercentKV" type="hidden" runat="server"/>
									<input id="MFO" type="hidden" runat="server"/> <input id="tt" type="hidden" runat="server"/>
									<input id="flv" type="hidden" runat="server"/> <input id="fli" type="hidden" runat="server"/>
                                    <input id="kvk" type="hidden" runat="server"/><input id="dpf_oper" type="hidden" runat="server"/>
									<input id="CrossRat" type="hidden" runat="server"/> <input id="dpt_id" type="hidden" runat="server"/>									
									<input id="RNK" type="hidden" runat="server"/><input id="Kv" type="hidden" runat="server"/>
									<input id="AfterPay" type="hidden" runat="server"/><input id="BeforePay" type="hidden" runat="server"/>
                                    <input id="bpp_4_cent" type="hidden" runat="server"/>
									<input id="ISCASH" type="hidden" runat="server"/><input id="denom" type="hidden" runat="server"/>
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
