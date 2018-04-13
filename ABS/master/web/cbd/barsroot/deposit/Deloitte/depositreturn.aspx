<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositReturn.aspx.cs" AutoEventWireup="true" Inherits="DepositReturn"%>
<%@ Register src="~/UserControls/BPKIdentification.ascx" tagname="BPKIdentification" tagprefix="bpk" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Виплата по завершенні</title>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js"></script>				
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textMFO,textOKPO,textNLS,textNMK",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		function FOCUS() {
			if (!document.getElementById('textMFO').disabled)
				focusControl('textMFO');
			else if (!document.getElementById('textNLS').disabled)
				focusControl('textNLS');
			else if (document.getElementById('btNalPay') && !document.getElementById('btNalPay').disabled)
				focusControl('btNalPay');
			else if (document.getElementById('btPayPercent') && !document.getElementById('btPayPercent').disabled)
				focusControl('btPayPercent');
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</head>
	<body onload="FOCUS();">
		<form id="Form1" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="True">
            </asp:ScriptManager>
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" width="60%"><asp:label id="lbInfo" meta:resourcekey="lbInfo4" runat="server" CssClass="InfoHeader"> Выплата депозита №</asp:label></td>
								<td align="left"><asp:textbox id="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server" ToolTip="№ депозита" ReadOnly="True" CssClass="HeaderText"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td><asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo" runat="server" CssClass="InfoLabel">Вкладчик</asp:label></td>
							</tr>
							<tr>
								<td><asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" ToolTip="Вкладчик" ReadOnly="True" MaxLength="70"
										CssClass="InfoText"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" Font-Bold="True" ToolTip="Паспортные данные"
										ReadOnly="True" MaxLength="70" CssClass="InfoText"></asp:textbox></td>
							</tr>
							<tr>
								<td>
									<table class="InnerTable">
										<tr>
											<td width="30%"><asp:label id="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoText">Дата рождения</asp:label></td>
											<td><igtxt:webdatetimeedit id="DateR" runat="server" ToolTip="Дата рождения" ReadOnly="True" HorizontalAlign="Center"
													EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" CssClass="InfoDateSum"></igtxt:webdatetimeedit></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td><asp:label id="lbDptType" meta:resourcekey="lbDptType2" runat="server" CssClass="InfoText">Вид договора</asp:label></td>
							</tr>
							<tr>
								<td><asp:textbox id="textDptType" meta:resourcekey="textDptType" runat="server" ToolTip="Вид договора" ReadOnly="True" CssClass="InfoText"></asp:textbox></td>
							</tr>
							<tr>
								<td>
                                    <asp:label id="lbDptParams" Text="Параметры вклада" meta:resourcekey="lbDptParams" runat="server" CssClass="InfoLabel"/>
                                </td>
							</tr>
							<tr>
								<td>
									<table class="InnerTable">
										<tr>
											<td width="25%">
												<asp:label id="lbDptCur" meta:resourcekey="lbDptCur" runat="server" CssClass="InfoText">Валюта дог.</asp:label>
											</td>
											<td width="15%">
												<asp:textbox id="textDptCur" meta:resourcekey="textDptCur" runat="server" ToolTip="Валюта договора" ReadOnly="True" CssClass="InfoDateSum"></asp:textbox>
											</td>
											<td width="5%">
											</td>
											<td width="25%">
												<asp:label id="lbDepositSum" meta:resourcekey="lbDepositSum" runat="server" CssClass="InfoText">Сумма на депозитном счету</asp:label>
											</td>
											<td width="5%">
												<asp:textbox id="textDptCurISO" meta:resourcekey="textDptCurISO" runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:textbox>
											</td>
											<td width="15%">
												<igtxt:webnumericedit id="dptSum" runat="server" ToolTip="Сумма на депозитном счету" ReadOnly="True" MinValue="0"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
										</tr>
                                        <tr runat="server" id="inherit_row_d">
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td colspan="2">
                                                <asp:Label ID="lbInheritSum" runat="server" CssClass="InfoText" meta:resourcekey="lbInheritSum"
                                                    Text="Сумма депозита доступная наследнику" Font-Bold="true" />
                                            </td>
                                            <td>
                                                <igtxt:webnumericedit id="InheritDeposit" runat="server" ToolTip="Сумма на депозитном счету" ReadOnly="True" MinValue="0"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum" Font-Bold="true">
                                                </igtxt:webnumericedit>
                                            </td>
                                        </tr>
										<tr>
											<td>
												<asp:label id="lbDptRate" meta:resourcekey="lbDptRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:label>
											</td>
											<td>
												<igtxt:webnumericedit id="dptRate" runat="server" ToolTip="Текучащая процентная ставка" ReadOnly="True"
													MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum2" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:label>
											</td>
											<td>
												<asp:textbox id="textPercentCurISO" meta:resourcekey="textPercentCurISO" runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:textbox>
											</td>
											<td>
												<igtxt:webnumericedit id="dptPercentSum" runat="server" ToolTip="Сумма на счету процентов" ReadOnly="True"
													MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
										</tr>
                                        <tr runat="server" id="inherit_row_p">
                                            <td></td>
                                            <td></td>
                                            <td>
                                            </td>
                                            <td colspan="2">
                                                <asp:Label ID="lbInheritSumP" runat="server" CssClass="InfoText" meta:resourcekey="lbPercentSum"
                                                    Text="Сумма процентов доступная наследнику" Font-Bold="true" />
                                            </td>
                                            <td>
                                                <igtxt:webnumericedit id="InheritPercent" runat="server" ToolTip="Сумма на депозитном счету" ReadOnly="True" MinValue="0"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum" Font-Bold="true" >
                                                </igtxt:webnumericedit>
                                            </td>
                                        </tr>										
										<tr>
											<td>
												<asp:label id="lbDptStartDate" meta:resourcekey="lbDptStartDate" runat="server" CssClass="InfoText">Дата начала договора</asp:label>
											</td>
											<td>
												<igtxt:webdatetimeedit id="dptStartDate" runat="server" ToolTip="Дата начала договора" ReadOnly="True"
													HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
											<td>
											</td>
											<td>
												<asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:label>
											</td>
											<td colspan="2">
												<igtxt:webdatetimeedit id="dptEndDate" runat="server" ToolTip="Дата завершения договора" ReadOnly="True"
													HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
										</tr>
										<tr>
                                            <td></td>
                                        </tr>
                                        <tr>
											<td colspan="6">
												<asp:label id="lbTOPAY" meta:resourcekey="lbTOPAY" runat="server" CssClass="InfoLabel">Сумма к выплате</asp:label>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbSum" meta:resourcekey="lbSum2" runat="server" CssClass="InfoText">С депозитного счета</asp:label>
											</td>
											<td>
												<igtxt:webnumericedit id="dptDepositToPay" runat="server" ToolTip="Сумма к выплате с депозитного счета"
													ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum">
                                                </igtxt:webnumericedit>
											</td>
											<td>
											</td>
											<td>
												<asp:label id="lbPercentTopPay" meta:resourcekey="lbPercentTopPay" runat="server" CssClass="InfoText">С счета процентов</asp:label>
											</td>
											<td></td>
                                            <td>
												<igtxt:webnumericedit id="dptPercentToPay" runat="server" ToolTip="Сумма к выплате со счета процентов"
													ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" CssClass="InfoDateSum">
                                                </igtxt:webnumericedit>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table class="InnerTable">
										<tr>
											<td colspan="5">
												<asp:label id="lbPayAccount" meta:resourcekey="lbPayAccount2" runat="server" CssClass="InfoLabel">Счета выплаты</asp:label>
											</td>
										</tr>
										<tr>
											<td width="25%">
												<asp:label id="lbAccNum" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:label>
											</td>
											<td width="20%">
												<asp:textbox id="textNLS" meta:resourcekey="textNLS" tabIndex="2" runat="server" ToolTip="Номер счета" MaxLength="14" CssClass="InfoText"></asp:textbox>
											</td>
											<td width="10%">
											</td>
											<td width="25%">
												<asp:label id="lbMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО Банка</asp:label>
											</td>
											<td width="20%">
												<asp:textbox id="textMFO" meta:resourcekey="textMFO" tabIndex="1" runat="server" ToolTip="МФО Банка" MaxLength="12" CssClass="InfoText"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbNMK" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:label>
											</td>
											<td>
												<asp:textbox id="textNMK" meta:resourcekey="textNMK" tabIndex="4" runat="server" ToolTip="Получатель" CssClass="InfoText"></asp:textbox>
											</td>
											<td>
											</td>
											<td>
												<asp:label id="lbOKPO" meta:resourcekey="lbOKPO" runat="server" CssClass="InfoText">ОКПО получателя</asp:label>
											</td>
											<td>
												<asp:textbox id="textOKPO" meta:resourcekey="textOKPO" tabIndex="3" runat="server" ToolTip="ОКПО получателя" MaxLength="10"
													CssClass="InfoText"></asp:textbox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
                                    &nbsp;</td>
							</tr>
							<tr>
								<td>
									<table class="InnerTable">
										<tr>
											<td>
												<input id="btNalPay" type="button" meta:resourcekey="btNalPay" class="AcceptButton" runat="server"
													tabindex="5" value="Виплата депозиту" />
                                                <bpk:BPKIdentification id="btAuthorizationByBPK" Text="Виплата депозиту" runat="server" tabIndex="5" 
                                                    BeforeIdentifyJS="if (!CheckSum('dptSum','dptDepositToPay',false) && Valid(3)) return false;"
                                                    OnClientIdentified="btAuthorizationByBPK_ClientIdentified" CssClass="AcceptButton" />
											</td>
											<td>
												<input id="btPayPercent" meta:resourcekey="btPayPercent" disabled="disabled"  type="button"
													tabindex="6" value="Выплата процентов" runat="server" class="AcceptButton" />
											</td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<input id="Nls_A1" type="hidden" runat="server"/><input id="tt" type="hidden" runat="server"/>
									<input id="MFO" type="hidden" runat="server"/><input id="rnk" type="hidden" runat="server"/>
									<input id="Nls_A" type="hidden" runat="server" /><input id="Kv" type="hidden" runat="server"/>
                                    <input id="kvk" type="hidden" runat="server"/><input id="flv" type="hidden" runat="server"/>
									<input id="CrossRat" type="hidden" runat="server"/><input id="bpp_4_cent" type="hidden" runat="server"/>
									<input id="fli" type="hidden" runat="server"/><input id="dpf_oper" type="hidden" runat="server"/>
									<input id="dpt_id" type="hidden" runat="server"/><input id="AfterPay" type="hidden" runat="server"/>
									<input id="ISCASH" type="hidden" runat="server"/><input id="denom" type="hidden" runat="server"/>
                                    <input id="BeforePay" type="hidden" runat="server"/>
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
