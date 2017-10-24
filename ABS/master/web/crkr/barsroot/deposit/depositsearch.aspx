<%@ Register TagPrefix="igtbl1" Namespace="Infragistics.WebUI.UltraWebGrid" Assembly="Infragistics.WebUI.UltraWebGrid.v3, Version=3.0.20041.11, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register TagPrefix="igtxt1" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositSearch.aspx.cs" AutoEventWireup="true" Inherits="DepositSearch"%>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Пошук депозиту</title>
		<meta name="vs_showGrid" content="True"/>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body onload="focusControl('textDepositId');">
		<form id="Form1" method="post" runat="server">
			<table id="mainTable" class="MainTable">
				<tr>
					<td align="center">
						<asp:label id="lbSearchInfo" runat="server" CssClass="InfoHeader">Поиск депозитного договора</asp:label> <!--key="lbSearchInfo"-->
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbParams">
							<tr>
								<td style="width:20%">
                                    <asp:label id="lbDepositNumber" meta:resourcekey="lbDepositNumber" runat="server" CssClass="InfoText">Номер вклада</asp:label></td>
								<td style="width:25%">
                                    <asp:TextBox id="textDepositNum" meta:resourcekey="textDepositNum" tabIndex="2" runat="server" CssClass="InfoText" MaxLength="48"
										ToolTip="Номер вклада"></asp:TextBox></td>
								<td style="width:10%"></td>
								<td style="width:25%">
									<asp:label id="lbClientName" meta:resourcekey="lbClientName" runat="server" CssClass="InfoText">Вкладчик</asp:label>
								</td>
								<td style="width:20%">
									<asp:TextBox id="textClientName" meta:resourcekey="textClientName" runat="server" ToolTip="ФИО вкладчика" MaxLength="35" tabIndex="5"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositId" meta:resourcekey="lbDepositId" CssClass="InfoText" runat="server"> Идентификатор вклада</asp:label></td>
								<td>
									<asp:TextBox id="textDepositId" meta:resourcekey="textDepositId" runat="server" ToolTip="Идентификатор вклада" MaxLength="12"
										tabIndex="2" CssClass="InfoText"></asp:TextBox></td>
								<td></td>
								<td>
									<asp:label id="lbClientOKPO" meta:resourcekey="lbClientOKPO" runat="server" CssClass="InfoText">Идентификационный код</asp:label></td>
								<td>
									<asp:TextBox id="textClientCode" meta:resourcekey="textClientCode" runat="server" ToolTip="Идентификационный код" MaxLength="10"
										tabIndex="6" CssClass="InfoText"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbClientId" meta:resourcekey="lbClientId" runat="server" CssClass="InfoText">Номер контрагента</asp:label>
								</td>
								<td>
									<asp:TextBox id="textClientId" meta:resourcekey="textClientId" runat="server" ToolTip="Номер контрагента" MaxLength="12" tabIndex="3"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbBirthDate" meta:resourcekey="lbBirthDate" runat="server" CssClass="InfoText">Дата рождения</asp:label>
								</td>
								<td>
									<igtxt1:WebDateTimeEdit id="bDate" runat="server" ToolTip="Дата рождения" MaxValue="2100-01-01" MinValue="1800-01-01"
										HorizontalAlign="Center" BorderStyle="Inset" tabIndex="7" CssClass="InfoDateSum"></igtxt1:WebDateTimeEdit>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositAccount" meta:resourcekey="lbDepositAccount" runat="server" CssClass="InfoText">Номер счета</asp:label>
								</td>
								<td>
									<asp:TextBox id="textAccount" meta:resourcekey="textAccount" runat="server" ToolTip="Номер счета" MaxLength="14" tabIndex="4"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbDocSerial" meta:resourcekey="lbDocSerial" runat="server" CssClass="InfoText">Серия документа</asp:label>
								</td>
								<td>
									<asp:TextBox id="DocSerial" meta:resourcekey="DocSerial" runat="server" ToolTip="Серия документа" MaxLength="10" tabIndex="8"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td></td>
								<td></td>
								<td>
									<asp:label id="lbDocNumber" meta:resourcekey="lbDocNumber" runat="server" CssClass="InfoText">Номер документа</asp:label>
								</td>
								<td>
									<asp:TextBox id="DocNumber" meta:resourcekey="DocNumber" runat="server" ToolTip="Номер документа" MaxLength="10" tabIndex="9"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table id="tbl_Hint" class="InnerTable">
							<tr>
								<td style="width:40%">
									<input id="btSearch" class="AcceptButton" type="button" value="Поиск" runat="server" tabindex="10" />
								</td>
								<td style="width:15%">
                                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsSearch" runat="server" OldValuesParameterFormatString="original_{0}">
                                    </Bars:barssqldatasource>
                                </td>
								<td style="width:40%">
									<input id="btSelect" meta:resourcekey="btSelect" class="AcceptButton" type="button" value="Выбрать" 
                                        runat="server" tabindex="11" />
								</td>
								<td style="width:5%">
									<input id="dptid" type="hidden" runat="server" value="null" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
                        <Bars:BarsGridView ID="gvSearch" CssClass="BaseGrid" runat="server" AllowPaging="True" AllowSorting="True" 
                            AutoGenerateColumns="False" DataSourceID="dsSearch" DateMask="dd/MM/yyyy" MergePagerCells="True" 
                            OnRowDataBound="gvSearch_RowDataBound" ShowPageSizeBox="True" CellPadding="2">
                            <Columns>
                                <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору"></asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="D_ID" SortExpression="D_ID" HeaderText="Сист. №">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="TYPE_NAME" SortExpression="TYPE_NAME" HeaderText="Тип вкладу">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>заверш.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="RNK" SortExpression="RNK" HeaderText="РНК">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="OKPO" SortExpression="OKPO" HeaderText="Ід. код">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="NMK" SortExpression="NMK" HeaderText="ПІБ<BR>вкладника">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунка">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="OSTC" SortExpression="OSTC" HeaderText="Залишок">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="P_OSTC" SortExpression="P_OSTC" HeaderText="Зал. %%">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="INT_KOS" SortExpression="INT_KOS" HeaderText="Нар. %%">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="INT_DOS" SortExpression="INT_DOS" HeaderText="Випл. %%">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="GridViewPager" />
                        </Bars:BarsGridView>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
		<script type="text/javascript" language="javascript">
				document.getElementById("textDepositId").attachEvent("onkeydown",doNum);
				document.getElementById("textClientId").attachEvent("onkeydown",doNum);
				document.getElementById("textAccount").attachEvent("onkeydown",doNumAlpha);
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("DocNumber").attachEvent("onkeydown",doNum);				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
		</script>
	</body>
</html>
