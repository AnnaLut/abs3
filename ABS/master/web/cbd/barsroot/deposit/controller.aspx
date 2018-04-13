<%@ Register TagPrefix="igtbl" Namespace="Infragistics.WebUI.UltraWebGrid" Assembly="Infragistics.WebUI.UltraWebGrid.v3, Version=3.0.20041.11, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="Controller.aspx.cs" AutoEventWireup="true" Inherits="Controller" enableViewState="False"%>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Контролер - Операціоніст</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ko.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	</head>
	<body onload="focusControl('textClientName');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="mainTable">
				<tr>
					<td align="center"><asp:label id="lbController" meta:resourcekey="lbController" runat="server" CssClass="InfoHeader">Депозиты: Контролер-Операционист</asp:label></td>
				</tr>
				<tr>
					<td align="center">
						<table class="InnerTable" id="headerTable">
							<tr>
								<td style="width:1%">
								    <input class="ImgButton" id="btSearch" title="Поиск" style="BACKGROUND-IMAGE: url(/Common/Images/search.gif)"
										type="button" value=" " name="Submit1" runat="server"/>
								</td>
								<td style="width:1%">
								    <img class="Img" runat="server" id="btClearFields" meta:resourcekey="btClearFields" onclick="clearFields()" alt="Очистить поля ввода"
										src="/Common/Images/delrec.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="newClient" meta:resourcekey="newClient" onclick="addClient()" alt="Завести нового клиента" src="/Common/Images/CUSTPERS.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btUpdateClient" meta:resourcekey="btUpdateClient" onclick="editClient()" alt="Редактировать выбраного клиента"
										src="/Common/Images/ed-item.gif"/></td>
								<td style="width:1%"><input class="ImgButton" id="btReRegister" title="Перерегистрация" style="BACKGROUND-IMAGE: url(/Common/Images/UNDO.gif)"
										type="button" value=" " runat="server" onclick="if (NeedsToReRegister())"/>
								</td>
								<td style="width:100%"><input id="SEL_ROW" type="hidden" runat="server"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbFields">
                            <tr>
                                <td style="width:25%">
                                    <asp:label id="lbSearchType" runat="server" CssClass="InfoText">Тип поиска</asp:label>
                                </td>
                                <td colspan="5">
                                </td>
                            </tr>
                            <tr>
                                <td style="width:25%">
                                    <select name="ddSearchType" id="ddSearchType" class="BaseDropDownList" 
                                    runat="server" onchange="ManageFields()">
	                                    <option selected="selected" value="0">Депозиты</option>
	                                    <option value="1">Клиенты</option>
	                                </select>
                                </td>
                                <td colspan="5">
                                </td>
                            </tr>
							<tr>
								<td style="width:25%"><asp:label id="lbClientName" meta:resourcekey="lbClientName" runat="server" CssClass="InfoText">Вкладчик</asp:label></td>
								<td style="width:10%"><asp:label id="lbClientOKPO" meta:resourcekey="lbClientOKPO" runat="server" CssClass="InfoText" Text="Ид. код"></asp:label></td>
								<td style="width:10%"><asp:label id="lbRNK" meta:resourcekey="lbRNK" runat="server" CssClass="InfoText">РНК клиента</asp:label></td>
								<td style="width:25%"><asp:label id="lbDepositAccount" meta:resourcekey="lbDepositAccount" runat="server" CssClass="InfoText">Номер счета</asp:label></td>
								<td style="width:15%"><asp:label id="lbDepositId" meta:resourcekey="lbDepositNumber" runat="server" CssClass="InfoText">Номер вклада</asp:label></td>
								<td style="width:15%"><asp:label id="lbDocNumber" meta:resourcekey="lbDocNumber4" runat="server" CssClass="InfoText">Номер удост.</asp:label></td>								
							</tr>
							<tr>
								<td><asp:textbox id="textClientName" meta:resourcekey="textClientName" tabIndex="1" runat="server" ToolTip="ФИО вкладчика" MaxLength="35"
										CssClass="InfoText"></asp:textbox></td>
								<td><asp:textbox id="textClientCode" meta:resourcekey="textClientCode" tabIndex="2" runat="server" Height="24px" ToolTip="Идентификационный код"
										MaxLength="10" CssClass="InfoText"></asp:textbox></td>
								<td><asp:textbox id="RNK" meta:resourcekey="RNK" tabIndex="3" runat="server" ToolTip="РНК клиента" MaxLength="10" CssClass="InfoText"></asp:textbox></td>
								<td><asp:textbox id="textAccount" meta:resourcekey="textAccount" tabIndex="4" runat="server" ToolTip="Номер счета" MaxLength="14"
										CssClass="InfoText"></asp:textbox></td>
								<td><asp:textbox id="textDepositId" meta:resourcekey="textDepositNum" tabIndex="5" runat="server" ToolTip="Номер вклада" MaxLength="12"
										CssClass="InfoText"></asp:textbox></td>
								<td><asp:textbox id="DocNumber" meta:resourcekey="DocNumber" tabIndex="6" runat="server" ToolTip="Номер документа" MaxLength="10"
										CssClass="InfoText"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbDptButton">
							<tr>
								<td style="width:1%"><img class="Img" runat="server" id="btAddDeposit" meta:resourcekey="btAddDeposit" onclick="addDeposit()" alt="Завести депозитный договор выбраному клиенту"
										src="/Common/Images/insert.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btViewDeposit" meta:resourcekey="btViewDeposit" onclick="viewDeposit()" alt="Просмотр текущего депозита"
										src="/Common/Images/apply.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btEditAccounts" meta:resourcekey="btEditAccounts" onclick="editAccounts()" alt="Изменение счетов выплаты"
										src="/Common/Images/dollar.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btAddSum" meta:resourcekey="btAddSum" onclick="addSum()" alt="Пополнение депозита" src="/Common/Images/arrow_down.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btPercentPay" meta:resourcekey="btPercentPay" onclick="percentPay()" alt="Выплата процентов" src="/Common/Images/per_cent.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btDepositReturn" meta:resourcekey="btDepositReturn" onclick="depositReturn()" alt="Возврат депозита по завершению"
										src="/Common/Images/arrow_up.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btDepositClose" meta:resourcekey="btDepositClose" onclick="depositClose()" alt="Расторжение депозитного договора / Выплата вклада до востребования"
										src="/Common/Images/grid_del.gif"/>
								</td>
								<td style="width:1%"><img class="Img" runat="server" id="btShowHistory" meta:resourcekey="btShowHistory" onclick="depositShowHistory()" alt="Просмотр истории депозитного договора"
										src="/Common/Images/books.gif"/>
								</td>
								<td style="width:100%"><input id="bd" type="hidden" name="Hidden1" runat="server"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
                        <bars:barsgridview id="gridDeposit" runat="server" cssclass="BaseGrid" datemask="dd/MM/yyyy" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="dsDeposit" OnRowDataBound="gridDeposit_RowDataBound" ShowPageSizeBox="True">
                            <PagerSettings PageButtonCount="5" />
                            <Columns>
                                <asp:BoundField DataField="RNK" HeaderText="РНК" SortExpression="RNK" />
                                <asp:BoundField DataField="OKPO" HeaderText="Ид.код" SortExpression="OKPO" />
                                <asp:BoundField DataField="NMK" HeaderText="ФИО" SortExpression="NMK" />
                                <asp:BoundField DataField="CLOS" HeaderText="Закр." SortExpression="CLOS" />
                                <asp:BoundField DataField="DPT_ID" HeaderText="Депозит" SortExpression="DPT_ID" />
                                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
                                <asp:BoundField DataField="NLS" HeaderText="Счет" SortExpression="NLS" />
                                <asp:BoundField DataField="DATZ" HeaderText="Начало" SortExpression="DATZ" />
                                <asp:BoundField DataField="DAT_END" HeaderText="Завершение" SortExpression="DAT_END" />
                                <asp:BoundField DataField="LCV" HeaderText="Валюта" SortExpression="LCV" />
                                <asp:BoundField DataField="OSTC" HeaderText="Остаток" SortExpression="OSTC" />
                                <asp:BoundField DataField="PERC" HeaderText="%%" SortExpression="PERC" />
                            </Columns>
                        </bars:barsgridview>
						
					</td>
				</tr>
                <tr>
                    <td>
                        <bars:barssqldatasource ProviderName="barsroot.core" id="dsDeposit" runat="server"></bars:barssqldatasource>
                    </td>
                </tr>
			</table>
		</form>
		<input type='hidden' runat='server' id='titleController' meta:resourcekey='titleController' value='Депозитный модуль: Контролер-Операционист' />
		<input type="hidden" id="forbtSearch" meta:resourcekey="forbtSearch" runat="server" value="Поиск"/>
		<input type="hidden" id="forbtReRegister" meta:resourcekey="forbtReRegister" runat="server" value="Перерегистрация"/>
		<!-- #include virtual="Inc/DepositCk.inc"-->
		<!-- #include virtual="Inc/DepositJs.inc"-->
		<!-- #include virtual="Inc/DepositKo.inc"-->
		<script type="text/javascript" language="javascript">
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("RNK").attachEvent("onkeydown",doNum);				
				document.getElementById("textAccount").attachEvent("onkeydown",doNumAlpha);				
				document.getElementById("textDepositId").attachEvent("onkeydown",doNum);
				document.getElementById("DocNumber").attachEvent("onkeydown",doNum);				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);				
				// Локализация
				LocalizeHtmlTitle("btSearch");
				LocalizeHtmlTitle("btReRegister");
		</script>
	</body>
</html>
