<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositClosePayIt.aspx.cs" AutoEventWireup="true" Inherits="DepositClosePayIt"  enableViewState="True"%>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<TITLE>Депозитний модуль: Дострокове розторгнення</TITLE>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js?v.1.2"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/AccCk.js"></script>				
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textMFO,textOKPO,textNLS,textNMK",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->		
		</script>
		<script type="text/javascript" language="javascript">
		function FOCUS() {
			if (!document.getElementById('SumToPay_t').disabled)
				focusControl('SumToPay_t');
			else if (!document.getElementById('textMFO').disabled)
				focusControl('textMFO');
			else if (!document.getElementById('textNLS').disabled)
				focusControl('textNLS');				
			else if (!document.getElementById('btCancel').disabled)
				focusControl('btCancel');				
		}
		</script>
		<script type="text/javascript" language="javascript">
		function enableSum() {
			var elem = ig_csom.getElementById("SumToPay_t");
						
			if (document.getElementById("ckFullPay").checked == true)
			{
				var sum = igedit_getById("SumToPay");
				var maxSUM = igedit_getById("MaxSum");
				sum.setNumber(maxSUM.getNumber()); 
				elem.disabled = true;
			}
			else
				elem.disabled = false;
		}
		</script>
	</head>
	<body onload="FOCUS();">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center" colSpan="3">
					    <table class="InnerTable">
						    <tr>
							    <td align="right" width="60%">
								    <asp:label id="lbDepositClose" meta:resourcekey="lbDepositClose2" runat="server" CssClass="InfoHeader"> Выплата депозита №</asp:label>
							    </td>
							    <td align="left">
								    <asp:textbox id="textDepositNumber" runat="server" ReadOnly="True" CssClass="HeaderText"></asp:textbox>
							    </td>
						    </tr>
						    <tr>
							    <td colspan="2" align="center">
								    <asp:label id="Label1" meta:resourcekey="Label1_3" runat="server" CssClass="InfoHeader">до завершения срока</asp:label>
							    </td>
						    </tr>
					    </table>
					</td>
				</tr>
				<tr>
					<td align="center" colSpan="3">
					    <table class="InnerTable">
						    <tr>
							    <td colSpan="2">
								    <asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td colSpan="2">
								    <asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" ReadOnly="True" BorderStyle="Inset" MaxLength="70"
									    ToolTip="Вкладчик" CssClass="InfoText"></asp:textbox>
							    </td>
						    </tr>
						    <tr>
							    <td colSpan="2">
								    <asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" ReadOnly="True" BorderStyle="Inset" MaxLength="70"
									    ToolTip="Паспортные данные" CssClass="InfoText"></asp:textbox>
							    </td>
						    </tr>
					    </table>
					    <table class="InnerTable">
						    <tr>
							    <td width="30%">
								    <asp:label id="lbDateR" Text="Дата народження" meta:resourcekey="lbDateR"  runat="server" CssClass="InfoLabel" />
							    </td>
							    <td>
                                    <asp:TextBox ID="DateR" runat="server"  ReadOnly="true" CssClass="InfoDateSum" ToolTip="Дата народження клієнта" />

							    </td>
						    </tr>
					    </table>
					</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td>
					    <table class="InnerTable">
						    <tr>
							    <td align="center" colSpan="5">
								    <asp:label id="lbDepInfo" meta:resourcekey="lbDepInfo" runat="server" CssClass="InfoLabel">Параметры депозитного договора</asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width="30%">
								    <asp:label id="lbDptType" meta:resourcekey="lbDptType3" runat="server" CssClass="InfoText">Тип депозитного договора</asp:label>
							    </td>
							    <td colSpan="4">
								    <asp:textbox id="DepositType" meta:resourcekey="DepositType" runat="server" ReadOnly="True" ToolTip="Тип депозитного договора"
									    CssClass="InfoText"></asp:textbox>
							    </td>
						    </tr>
						    <tr>
							    <td width="30%">
								    <asp:label id="lbDepositSum" meta:resourcekey="lbDepositSum2" runat="server" CssClass="InfoText">Сумма на депозитном счете</asp:label>
							    </td>
							    <td width="15%">
								    <igtxt:webnumericedit id="DepositSum" runat="server" ReadOnly="True" ToolTip="Сумма на депозитном счету"
									    MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
							    </td>
							    <td width="10%"></td>
							    <td width="30%">
								    <asp:label id="lbDptAccCur" meta:resourcekey="lbDptAccCur" runat="server" CssClass="InfoText">Валюта депозитного счёта</asp:label>
							    </td>
							    <td width="15%">
								    <asp:textbox id="dptCurrency" meta:resourcekey="dptCurrency" runat="server" ReadOnly="True" ToolTip="Валюта депозитного договора"
									    CssClass="InfoText"></asp:textbox>
							    </td>
						    </tr>
						    <tr>
							    <td>
								    <asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum3" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:label>
							    </td>
							    <td>
								    <igtxt:webnumericedit id="PercentSum" runat="server" ReadOnly="True" ToolTip="Сумма на счету процентов"
									    MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
							    </td>
							    <td></td>
							    <td>
								    <asp:label id="lbPercentRate" meta:resourcekey="lbPercentRate" runat="server" CssClass="InfoText">Номинальная процентная ставка</asp:label>
							    </td>
							    <td>
								    <igtxt:webnumericedit id="PercentRate" runat="server" ReadOnly="True" ToolTip="Номинальная процентная ставка"
									    MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
							    </td>
						    </tr>
					    </table>
					</td>
				</tr>				
				<tr>
					<td colSpan="3">
						<table id="tbShtraf" runat="server" class="InnerTable">
							<tr>
								<td colspan="2" align="center">
									<asp:label id="lbReturnParams" meta:resourcekey="lbReturnParams" runat="server" CssClass="InfoLabel">Параметры снятия вклада</asp:label>
								</td>
							</tr>
							<tr>
								<td width="85%">
									<asp:label id="lbShtrafRate" meta:resourcekey="lbShtrafRate" runat="server" CssClass="InfoText">Штрафная процентная ставка</asp:label>
								</td>
								<td>
									<igtxt:webnumericedit id="ShtrafRate" runat="server" ReadOnly="True" ToolTip="Штрафная процентная ставка"
										MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbAllPercent" meta:resourcekey="lbAllPercent" runat="server" CssClass="InfoText">Общая начисленная сумма процентов по вкладу до штрафования</asp:label>
								</td>
								<td>
									<igtxt:webnumericedit id="allPercentSum" runat="server" ReadOnly="True" ToolTip="Общая сумма процентов"
										MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbPercentSumWithShtraf" meta:resourcekey="lbPercentSumWithShtraf" runat="server" CssClass="InfoText">Общая сумма процентов по вкладу с учётом штрафной процентной ставки</asp:label>
								</td>
								<td>
									<igtxt:webnumericedit id="ShtrafPercentSum" runat="server" ReadOnly="True" ToolTip="Сумма процентов по вкладу с учётом штрафной процентной ставки"
										MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbFullShtraf" meta:resourcekey="lbFullShtraf" runat="server" CssClass="InfoText">Cумма штрафа</asp:label>
								</td>
								<td>
									<igtxt:webnumericedit id="ShtrafSum" runat="server" ReadOnly="True" ToolTip="Общая сумма штрафа" MinValue="0"
										DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbKomissionSum" meta:resourcekey="lbKomissionSum" runat="server" CssClass="InfoText">Сумма комисии за досрочное расторжение (гривня)</asp:label>
								</td>
								<td>
									<igtxt:webnumericedit id="KomissionSum" runat="server" ReadOnly="True" ToolTip="Сумма комисии за досрочное расторжение"
										MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</td>
							</tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbIncasso" runat="server" CssClass="InfoText"
                                    Text="Комісія за безготівкове поповнення вкладу"></asp:Label></td>
                                <td>
                                    <cc1:numericedit id="InCassoSum" runat="server" cssclass="InfoDateSum" ReadOnly="True"></cc1:numericedit>
                                </td>
                            </tr>
                                <tr>
                                    <td>
                                        <div class="screen_action">							
                                            <input id="btPrint" meta:resourcekey="btPrint3" runat="server" class="AcceptButton" type="button" onclick="window.print();" 
                                                value="Печать штрафа" />
                                        </div>                                                
                                    </td>
                                    <td>
                                    </td>
                                </tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="3">
					    <table class="InnerTable">
						    <tr>
							    <td align="center" colSpan="3">
								    <asp:label id="lbPayParams" meta:resourcekey="lbPayParams" runat="server" CssClass="InfoLabel">Параметры выплаты</asp:label>
							    </td>
						    </tr>
						    <tr>
							    <td width="30%">
								    <asp:label id="lbSumToPay" meta:resourcekey="lbSumToPay" runat="server" CssClass="InfoText">Сумма к выплате</asp:label>
							    </td>
							    <td width="15%">
								    <igtxt:webnumericedit id="SumToPay" runat="server" ToolTip="Сумма к выплате" MinValue="0" DataMode="Decimal"
									    MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
							    </td>
							    <td>
								    <asp:checkbox id="ckFullPay" meta:resourcekey="ckFullPay" runat="server" Text="Полный возврат" CssClass="InfoText"></asp:checkbox>
							    </td>
						    </tr>
						    <tr>
							    <td>
								    <asp:label id="lbMaxSum" meta:resourcekey="lbMaxSum" runat="server" CssClass="InfoText">Максимальная доступная сумма</asp:label>
							    </td>
							    <td>
								    <igtxt:webnumericedit id="MaxSum" runat="server" ReadOnly="True" ToolTip="Максимально доступная сумма"
									    MinValue="0" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
							    </td>
							    <td>
								    <input id="textDtEnd" type="hidden" runat="server">
							    </td>
						    </tr>
					    </table>
					</td>
				</tr>
				<tr>
					<td colSpan="3">
					    <div class="screen_action">
						    <table class="InnerTable">
							    <tr>
								    <td align="center" colSpan="5">
									    <asp:label id="lbPayAccounts" meta:resourcekey="lbPayAccounts" runat="server" CssClass="InfoLabel">Счета выплаты</asp:label>
								    </td>
							    </tr>
							    <tr>
								    <td width="30%">
									    <asp:label id="lbAccNum" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:label>
								    </td>
								    <td width="15%">
									    <asp:textbox id="textNLS" meta:resourcekey="textNLS" tabIndex="2" runat="server" ToolTip="Номер счета" MaxLength="14" CssClass="InfoText"></asp:textbox>
								    </td>
								    <td width="10%">
                                    	<input id="btSetAcc" disabled="disabled" tabindex="8" type="button" 
                                            value="Рахунок виплати" runat="server" onclick="get_Nlsb();" class="AcceptButton"/></td>
								    <td width="30%">
									    <asp:label id="lbMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО Банка</asp:label>
								    </td>
								    <td>
									    <asp:textbox id="textMFO" meta:resourcekey="textMFO" tabIndex="1" runat="server" ToolTip="МФО Банка" MaxLength="12" CssClass="InfoText"></asp:textbox>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <asp:label id="lbNMK" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:label>
								    </td>
								    <td>
									    <asp:textbox id="textNMK" meta:resourcekey="textNMK" tabIndex="4" runat="server" ToolTip="Получатель" MaxLength="35" CssClass="InfoText"></asp:textbox>
								    </td>
								    <td></td>
								    <td>
									    <asp:label id="lbOKPO" meta:resourcekey="lbOKPO" runat="server" CssClass="InfoText">ОКПО получателя</asp:label>
								    </td>
								    <td>
									    <asp:textbox id="textOKPO" meta:resourcekey="textOKPO" tabIndex="3" runat="server" ToolTip="ОКПО получателя" MaxLength="10"
										    CssClass="InfoText"></asp:textbox>
								    </td>
							    </tr>
						    </table>
                        </div>						    
					</td>
				</tr>
				<tr>
					<td colSpan="3">
					    <div class="screen_action">
						    <table class="InnerTable">
							    <tr>
								    <td width="30%">
									    <input id="btShtraf" meta:resourcekey="btShtraf" tabIndex="5" type="button" value="Штрафовать" runat="server" class="AcceptButton">
								    </td>
								    <td width="30%">
									    <asp:button id="btNoShtraf" meta:resourcekey="btNoShtraf" tabIndex="6" runat="server" ToolTip="Разорвать договор без штрафных санкций"
										    Text="Без штрафа" Visible="False" CssClass="AcceptButton"></asp:button>
								    </td>
								    <td>
									    <asp:button id="btCancel" meta:resourcekey="btCancel2"  tabIndex="7" runat="server" ToolTip="Отменить расторжение" Text="Отменить"
										    CssClass="AcceptButton"></asp:button>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <input id="btPay" meta:resourcekey="btPay" disabled tabIndex="8" type="button" value="Выплата" runat="server" class="AcceptButton">
								    </td>
								    <td>
								        <input id="btSurvey" style="visibility:hidden" tabIndex="8" type="button" value="Заповнити анкету" runat="server" class="AcceptButton"
								            onclick="OpenSurvey('/barsroot/Survey/Survey.aspx?par=SURVPENY&rnk=' + document.getElementById('rnk').value);">
								    </td>
								    <td>
									    <asp:button id="btPayPercent" meta:resourcekey="btPayPercent2" tabIndex="9" runat="server" ToolTip="Проценты" Text="Проценты"
										    Enabled="False" CssClass="AcceptButton"></asp:button>
								    </td>
							    </tr>
						    </table>
                        </div>						    
					</td>
				</tr>
				<tr>
					<td colSpan="3">
						<input id="MFO" type="hidden" runat="server" NAME="MFO"/><input id="Kv" type="hidden" runat="server"/>
						<input id="Nls_A" type="hidden" runat="server" NAME="Nls_A"/><input id="kvk" type="hidden" runat="server"/> 
						<input id="flv" type="hidden" runat="server" NAME="flv"/><input id="fli" type="hidden" runat="server"/> 
						<input id="SUM" type="hidden" runat="server" NAME="SUM"/><input id="tt" type="hidden" runat="server"/>
						<input id="p_nls" type="hidden" runat="server" NAME="p_nls"/> <input id="AfterPay" type="hidden" runat="server"/>
						<input id="CrossRat" type="hidden" runat="server" NAME="CrossRat"/> <input id="to_be_called_for" type="hidden" runat="server"/>
						<input id="dpf_oper" type="hidden" runat="server"/><input id="rnk" type="hidden" runat="server"/>
						<input id="dpt_id" type="hidden" runat="server"/><input id="bpp_4_cent" type="hidden" runat="server"/>
                        <input id="ISCASH" type="hidden" runat="server"/><input id="perc_dpt_acc" type="hidden" runat="server"/>
                        <input id="denom" type="hidden" runat="server"/><input id="BeforePay" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositAccCk.inc"-->
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
