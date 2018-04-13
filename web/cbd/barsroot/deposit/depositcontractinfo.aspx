<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1" %>
<%@ Register TagPrefix="igtxt1" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositContractInfo.aspx.cs" AutoEventWireup="true" Inherits="DepositContractInfo" debug="True"  enableViewState="False" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
	    <base target="_self" />
		<title>Депозитний модуль: Картка депозиту</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
        <script type="text/javascript" language="javascript" src="js/js.js?v1.0"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript">
		function FOCUS() {
			if (!document.getElementById('btFirstPayment').disabled)
				focusControl('btFirstPayment');
			else if (!document.getElementById('btFormDptText').disabled)
				focusControl('btFormDptText');
			else if (!document.getElementById('btPrintContract').disabled)
				focusControl('btPrintContract');
		}
		</script>
	</head>
	<body onload="FOCUS();">
		<form id="MainForm" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:60%">
									<asp:label id="lbInfo" meta:resourcekey="lbInfo9" runat="server" CssClass="InfoHeader">Карточка вклада №</asp:label>
								</td>
								<td align="left">
									<asp:textbox id="DPT_NUM" runat="server" ReadOnly="True" CssClass="HeaderText"></asp:textbox>
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
						<table class="InnerTable">
							<tr>
								<td vAlign="top">
									<table class="InnerTable">
										<TBODY>
											<tr>
												<td>
													<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
												</td>
											</tr>
											<tr>
												<td>
													<asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Вкладчик"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="30%">
																<asp:textbox id="textDocType" meta:resourcekey="textDocType" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Тип документа"></asp:textbox>
															</td>
															<td width="20%">
																<asp:textbox id="textDocNumber" meta:resourcekey="textDocNumber2" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Номер"></asp:textbox>
															</td>
															<td width="50%">
																<asp:textbox id="textDocOrg" meta:resourcekey="textDocOrg" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Кем выдан"></asp:textbox>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td>
																<asp:textbox id="textClientAddress" meta:resourcekey="textClientAddress2" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Адрес вкладчика"></asp:textbox>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<asp:label id="lbContractInfo" meta:resourcekey="lbContractInfo" runat="server" CssClass="InfoLabel">Договор</asp:label>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbContractNumber" meta:resourcekey="lbContractNumber" runat="server" CssClass="InfoText">Номер</asp:label>
															</td>
															<td width="15%">
																<asp:textbox id="textContractNumber" meta:resourcekey="textContractNumber" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Номер договора"></asp:textbox>
															</td>
															<td width="20%"></td>
															<td width="25%">
																<asp:label id="lbContractDate" meta:resourcekey="lbContractDate" runat="server" CssClass="InfoText">от</asp:label>
															</td>
															<td width="15%">
																<igtxt:webdatetimeedit id="dtContract" runat="server" CssClass="InfoDateSum" ReadOnly="True" ToolTip="Дата заключения договора"
																	HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"></igtxt:webdatetimeedit>
															</td>
														</tr>
														<tr>
															<td>
																<asp:label id="lbContractBegin" meta:resourcekey="lbContractBegin" runat="server" CssClass="InfoText">Дата начала</asp:label>
															</td>
															<td>
																<igtxt:webdatetimeedit id="dtContractBegin" runat="server" CssClass="InfoDateSum" ReadOnly="True" ToolTip="Дата начала действия договора"
																	HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"></igtxt:webdatetimeedit>
															</td>
															<td></td>
															<td>
																<asp:label id="lbContractEnd" meta:resourcekey="lbContractEnd" runat="server" CssClass="InfoText">Дата завершения</asp:label>
															</td>
															<td>
																<igtxt:webdatetimeedit id="dtContractEnd" runat="server" CssClass="InfoDateSum" ReadOnly="True" ToolTip="Дата завершения действия договора"
																	HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"></igtxt:webdatetimeedit>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbDepositType" meta:resourcekey="lbDepositType" runat="server" CssClass="InfoText">Вид вклада</asp:label>
															</td>
															<td>
																<asp:textbox id="textDepositType" meta:resourcekey="textDepositType" runat="server" ReadOnly="True" ToolTip="Вид вклада" CssClass="InfoText"></asp:textbox>
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
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbInterestRate" meta:resourcekey="lbInterestRate" runat="server" CssClass="InfoText">Процентная ставка</asp:label>
															</td>
															<td>
																<igtxt1:webnumericedit id="textInterestRate" runat="server" ReadOnly="True" MinValue="0" DataMode="Decimal"
																	MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt1:webnumericedit>
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
													<asp:label id="lbAccountInfo" meta:resourcekey="lbAccountInfo" runat="server" CssClass="InfoLabel">Счета</asp:label>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbDepositAccount" meta:resourcekey="lbDepositAccount" runat="server" CssClass="InfoText">Основной счет</asp:label>
															</td>
															<td width="20%">
																<asp:textbox id="textDepositAccountCurrency" meta:resourcekey="textDepositAccountCurrency" runat="server" CssClass="InfoText" ReadOnly="True"
																	ToolTip="Валюта основного счёта"></asp:textbox>
															</td>
															<td width="35%">
																<asp:textbox id="textDepositAccount" meta:resourcekey="textDepositAccount" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Счет"></asp:textbox>
															</td>
															<td style="width:20%">
																<asp:textbox id="textDepositAccountRest" runat="server" CssClass="InfoDateSum" ReadOnly="True" ToolTip="Остаток"></asp:textbox>
															</td>
														</tr>
														<tr>
															<td>
																<asp:label id="lbInterestAccount" meta:resourcekey="lbInterestAccount" runat="server" CssClass="InfoText">Счет процентов</asp:label>
															</td>
															<td>
																<asp:textbox id="textIntAccountCurrency" meta:resourcekey="textIntAccountCurrency" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта счёта процентов"></asp:textbox>
															</td>
															<td>
																<asp:textbox id="textInterestAccount" meta:resourcekey="textInterestAccount" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Счет"></asp:textbox>
															</td>
															<td>
																<asp:textbox id="textInterestAccountRest" runat="server" CssClass="InfoDateSum" ReadOnly="True" ToolTip="Остаток"></asp:textbox>
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td>
													<asp:label id="lbIntTransfInfo" meta:resourcekey="lbIntTransfInfo" runat="server" CssClass="InfoLabel">Перечисление процентов</asp:label>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbIntTransfAccount" meta:resourcekey="lbIntTransfAccount" runat="server" CssClass="InfoText">Номер счета</asp:label>
															</td>
															<td width="20%">
																<asp:textbox id="textIntTransfAccount" meta:resourcekey="textIntTransfAccount" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Номер счета"
																	MaxLength="14"></asp:textbox>
															</td>
															<td width="10%"></td>
															<td width="25%">
																<asp:label id="lbIntTransfMFO" meta:resourcekey="lbIntTransfMFO" runat="server" CssClass="InfoText">МФО</asp:label>
															</td>
															<td width="20%">
																<asp:textbox id="textIntTransfMFO" meta:resourcekey="textIntTransfMFO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="МФО"
																	MaxLength="12"></asp:textbox>
															</td>
														</tr>
														<tr>
															<td>
																<asp:label id="lbIntTransfName" meta:resourcekey="lbIntTransfName" runat="server" CssClass="InfoText">Наименование</asp:label>
															</td>
															<td>
																<asp:textbox id="textIntTransfName" meta:resourcekey="textIntTransfName" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Наименование"
																	MaxLength="35"></asp:textbox>
															</td>
															<td></td>
															<td>
																<asp:label id="lbIntTransfOKPO" meta:resourcekey="lbIntTransfOKPO" runat="server" CssClass="InfoText">ОКПО</asp:label>
															</td>
															<td>
																<asp:textbox id="textIntTransfOKPO" meta:resourcekey="textIntTransfOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ОКПО"
																	MaxLength="14"></asp:textbox>
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
													<asp:label id="lbRestTransfInfo" meta:resourcekey="lbRestTransfInfo" runat="server" CssClass="InfoLabel">Перечисление капитала</asp:label>
												</td>
											</tr>
											<tr>
												<td>
													<table class="InnerTable">
														<tr>
															<td width="25%">
																<asp:label id="lbRestTransfAccount" meta:resourcekey="lbIntTransfAccount" runat="server" CssClass="InfoText">Номер счета</asp:label>
															</td>
															<td width="20%">
																<asp:textbox id="textRestTransfAccount" meta:resourcekey="textIntTransfAccount" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Номер счёта"
																	MaxLength="14"></asp:textbox>
															</td>
															<td width="10%"></td>
															<td width="25%">
																<asp:label id="lbRestTransfMFO" meta:resourcekey="lbIntTransfMFO" runat="server" CssClass="InfoText">МФО</asp:label>
															</td>
															<td width="20%">
																<asp:textbox id="textRestTransfMFO" meta:resourcekey="textIntTransfMFO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="МФО"
																	MaxLength="12"></asp:textbox>
															</td>
														</tr>
														<tr>
															<td>
																<asp:label id="lbRestTransfName" meta:resourcekey="lbIntTransfName" runat="server" CssClass="InfoText">Наименование</asp:label>
															</td>
															<td>
																<asp:textbox id="textRestTransfName" meta:resourcekey="textIntTransfName" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Наименование"
																	MaxLength="35"></asp:textbox>
															</td>
															<td></td>
															<td>
																<asp:label id="lbRestTransfOKPO" meta:resourcekey="lbIntTransfOKPO" runat="server" CssClass="InfoText">ОКПО</asp:label>
															</td>
															<td>
																<asp:textbox id="textRestTransfOKPO" meta:resourcekey="textIntTransfOKPO" runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="ОКПО"
																	MaxLength="14"></asp:textbox>
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
												            <td align="right" style="width:1%">
                                                                <img id="btSaveComment" style="cursor:hand" src="\Common\Images\SAVE.gif" onclick="SaveComment()" alt="Зберегти"/>
												            </td>
												            <td style="width:100%">
												                <asp:label id="lbContractComments" meta:resourcekey="lbContractComments" 
												                    runat="server" CssClass="InfoLabel">Комментарий</asp:label>
												            </td>
												        </tr>
												    </table>
                                                </td>
											</tr>
											<tr>
												<td>
													<asp:textbox id="textContractComments" meta:resourcekey="textContractComments" runat="server" CssClass="InfoText" ToolTip="Комментарий"
														BorderStyle="Inset" Height="40px" TextMode="MultiLine"></asp:textbox>
												</td>
											</tr>
											<tr>
												<td>
                                                    <asp:CheckBox ID="ckNonCash" runat="server" CssClass="BaseCheckBox" Enabled="False"
                                                        Text="Безналичный первичный взнос" meta:resourcekey="ckNonCash"/></td>
											</tr>
                                            <tr>
                                                <td>
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                            </tr>
											<tr>
												<td>
													<table class="InnerTable" id="ButtonTable">
														<tr>
															<td width="25%">
																<input id="btFirstPayment" meta:resourcekey="btFirstPayment" tabIndex="1" type="button" value="Первичный взнос" runat="server"
																	class="AcceptButton"></td>
															<td width="25%">
															    <input id="btBonusRates" tabIndex="2" type="button" value="Бонус к %%" runat="server" meta:resourcekey="btBonusRates"
																	class="AcceptButton" onclick="location.replace('depositbonus.aspx');"></td>
															<td width="25%">
                                                            </td>
															<td width="25%">
                                                                <input id="btSurvey" meta:resourcekey="btSurvey" runat="server" class="AcceptButton" type="button" value="Заповнити анкету" 
                                                                     onclick="OpenSurvey('/barsroot/Survey/Survey.aspx?par=SURVDPT0&rnk=' + document.getElementById('rnk').value);" tabindex="4"/></td>
														</tr>
														<tr>
															<td><input id="btFormDptText" meta:resourcekey="btFormDptText" tabIndex="6" type="button" value="Формировать текст" runat="server"
																	class="AcceptButton"></td>
															<td>
																<input id="btPrintContract" meta:resourcekey="btPrintContract" tabIndex="7" type="button" value="Просмотр текста" runat="server"
																	class="AcceptButton"></td>
															<td>
																<input id="btAddAgreement" tabIndex="8" type="button" value="Доп. соглашение" runat="server"
																	class="AcceptButton" NAME="btAddAgreement"></td>
                                                            <td>
															    <input id="btShowHistory" tabIndex="9" type="button" value="История" runat="server" meta:resourcekey="btShowHistory"
																	class="AcceptButton" onclick="location.replace('deposithistory.aspx?dpt_id='+document.getElementById('dpt_id').value+'&noext=1');"></td>
														</tr>
														<tr>
															<td>
															    <input id="btnSgnContract" meta:resourcekey="btnSgnContract" tabIndex="21" type="button" value="Подписать" runat="server"
																	class="AcceptButton" NAME="btnSgnContract"></td>
															<td>
																<asp:button id="btnNext" meta:resourcekey="btnNext" tabIndex="22" runat="server" Text="Новый договор" CssClass="AcceptButton"></asp:button></td>
															<td>
                                                            </td>
															<td>
                                                                <asp:Button ID="btReport" runat="server" CssClass="AcceptButton" 
                                                                    onclick="btReport_Click" Text="Виписка" />
                                                            </td>															
														</tr>
														<tr>
															<td>
															    <asp:Button ID="btShowClient" runat="server" CssClass="AcceptButton" CausesValidation="false"
                                                                    Text="Картка клієнта" onclick="btShowClientCard_Click" />
                                                                <!-- onclientclick="showClientExt();" -->
                                                            </td>
															<td></td>
															<td></td>
															<td></td>															
														</tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td>
                                                                <asp:Button ID="btShowAccountCard" TabIndex="42" runat="server" CssClass="AcceptButton" 
                                                                    Text="Редагувати відсоткову ставку" Visible="false" onclick="btShowAccountCard_Click" />
                                                            </td>
                                                            <td>
                                                            	<input id="btFormRate" meta:resourcekey="btFormRate" tabIndex="3" type="button" value="Формировать %% ставку" runat="server"
																	class="AcceptButton" onserverclick="btFormRate_ServerClick" />

                                                            </td>
                                                            <td>
                                                            	<input id="btRollback" tabindex="44" type="button" value="Змінити договір" runat="server" meta:resourcekey="btRollback"
																    class="AcceptButton" onclick="location.replace('depositcontract.aspx?action=rollback');" />
                                                            </td>
                                                        </tr>
													</table>
													<input id="SumC_t" type="hidden" runat="server"/><input id="rnk" type="hidden" runat="server"/>
                                                    <input id="Kv" type="hidden" runat="server"/><input id="Nls_B" type="hidden" runat="server"/>
													<input id="vidd" type="hidden" runat="server"/> <input id="Templates" type="hidden" runat="server"/>
													<input id="dpt_id" type="hidden" runat="server"/><input id="Nam_B" type="hidden" runat="server"/>
													<input id="Id_B" type="hidden" runat="server"/><input id="AfterPay" type="hidden" runat="server"/>
													<input id="TT" type="hidden" runat="server"/><input id="denom" type="hidden" runat="server"/>
                                                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                                                        <Scripts>
                                                            <asp:ScriptReference Path="js/js.js" />
                                                        </Scripts>
                                                    </asp:ScriptManager>
                                                    <script language="javascript" type="text/javascript">
                                                        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
                                                    </script>
												</td>
											</tr>
										</TBODY>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
