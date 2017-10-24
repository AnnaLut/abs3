<%@ Page language="c#" CodeFile="DepositHistory.aspx.cs" AutoEventWireup="true" Inherits="DepositHistory"  enableViewState="False" %>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Перегляд історії</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript">
		function Acc(acc) {
			window.open(encodeURI("/barsroot/customerlist/showhistory.aspx?acc=" + acc + "&type=0"),null,
			"height=600,width=600,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
		}
		</script>
	</head>
	<body onload="focusControl('btShowFinancialHistory');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" width="60%">
									<asp:label id="lbInfo" meta:resourcekey="lbInfo6" runat="server" CssClass="InfoHeader">История депозита №</asp:label>
								</td>
								<td align="left">
									<asp:textbox id="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server" ReadOnly="True" ToolTip="№ депозита" Font-Bold="True"
										CssClass="HeaderText"></asp:textbox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td colSpan="3">
									<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Вкладчик"
										MaxLength="70" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Паспортные данные"
										MaxLength="70" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<table class="InnerTable">
										<tr>
											<td width="30%">
												<asp:label id="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoLabel">Дата рождения</asp:label>
											</td>
											<td>
												<igtxt:webdatetimeedit id="birthDate" runat="server" ReadOnly="True" ToolTip="Дата рождения" HorizontalAlign="Center"
													CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<asp:label id="lbDptType" meta:resourcekey="lbDptType2" runat="server" CssClass="InfoLabel">Вид договора</asp:label>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<asp:textbox id="textDptType" meta:resourcekey="textDptType" runat="server" ReadOnly="True" ToolTip="Вид договора" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<asp:label id="lbDptParams" meta:resourcekey="lbDptParams" runat="server" CssClass="InfoLabel">Параметры вклада</asp:label>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
									<table class="InnerTable">
										<tr>
											<td width="25%">
												<asp:label id="lbDptCur" meta:resourcekey="lbDptCur" CssClass="InfoText" runat="server">Валюта дог.</asp:label>
											</td>
											<td width="15%">
												<asp:textbox id="textDptCur" meta:resourcekey="textDptCur" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Валюта договора"
													CssClass="InfoText"></asp:textbox>
											</td>
											<td width="5%"></td>
											<td width="25%">
												<asp:label id="lbDepositSum" meta:resourcekey="lbDepositSum" runat="server" CssClass="InfoText">Сумма на депозитном счету</asp:label>
											</td>
											<td width="15%">
												<asp:textbox id="textDptCurISO" meta:resourcekey="textDptCurISO" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Валюта"
													CssClass="InfoText"></asp:textbox>
											</td>
											<td width="15%">
												<igtxt:webnumericedit id="dptSum" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Сумма на депозитном счету"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" MinValue="0" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbDptRate" meta:resourcekey="lbDptRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:label>
											</td>
											<td>
												<igtxt:webnumericedit id="curPercentRate" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Текущая процентная ставка"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" MinValue="0" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbPercentSum" meta:resourcekey="lbPercentSum2" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:label>
											</td>
											<td>
												<asp:textbox id="textPercentCurISO" meta:resourcekey="textPercentCurISO" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Валюта"
													CssClass="InfoText"></asp:textbox>
											</td>
											<td>
												<igtxt:webnumericedit id="percentSum" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Сумма на счету процентов"
													MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal" MinValue="0" CssClass="InfoDateSum"></igtxt:webnumericedit>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbDptStartDate" meta:resourcekey="lbDptStartDate" runat="server" CssClass="InfoText">Дата начала договора</asp:label>
											</td>
											<td>
												<igtxt:webdatetimeedit id="dtStartDate" runat="server" ReadOnly="True" ToolTip="Дата начала договора" HorizontalAlign="Center"
													CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:label>
											</td>
											<td colSpan="2">
												<igtxt:webdatetimeedit id="dtEndDate" runat="server" ReadOnly="True" ToolTip="Дата завершения договора"
													HorizontalAlign="Center" CssClass="InfoDateSum"></igtxt:webdatetimeedit>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td style="width:25%">
									<asp:button id="btShowFinancialHistory" meta:resourcekey="btShowFinancialHistory"  runat="server" ToolTip="Просмотр финансовой истории договора"
										Text="Финансовая история" tabIndex="1" CssClass="AcceptButton"></asp:button>
								</td>
								<td style="width:25%">
									<asp:button id="btAddAgreementHistory" meta:resourcekey="btAddAgreementHistory" runat="server" ToolTip="Просмотр истории доп. соглашений по договору"
										Text="История доп. соглашений" tabIndex="2" CssClass="AcceptButton"></asp:button>
								</td>
								<td style="width:50%">
                                    <asp:button id="btShowDocs" meta:resourcekey="btShowDocs" runat="server" ToolTip="Просмотр документов по договору"
										Text="Документы по договору" tabIndex="2" CssClass="AcceptButton" OnClick="btShowDocs_Click"></asp:button></td>
							</tr>
							<tr>
								<td></td>
								<td colSpan="2"></td>
							</tr>
							<tr>
								<td colSpan="3">
									<div style="OVERFLOW: scroll; HEIGHT: 200px">
										<asp:datagrid id=dataGrid runat="server" CssClass="BaseGrid" DataSource="<%# dataSet %>" OnItemDataBound="dataGrid_ItemDataBound">
										</asp:datagrid>
									</div>
								</td>
							</tr>
							<tr>
								<td colSpan="3">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" >
                                        <Scripts>
                                            <asp:ScriptReference Path="js/js.js" />
                                        </Scripts>                                    
                                    </asp:ScriptManager>
                                </td>
                                <script language="javascript" type="text/javascript">
                                    if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
                                </script>                                
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
