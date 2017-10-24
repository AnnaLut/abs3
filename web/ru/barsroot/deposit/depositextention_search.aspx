<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositextention_search.aspx.cs" Inherits="deposit_depositextention_search" %>

<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Переоформлення</title>
	<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
	<script type="text/javascript" language="javascript" src="js/js.js"></script>
	<script type="text/javascript" language="javascript" src="js/ck.js"></script>    
</head>
<body onload="focusControl('textDepositId');">
    <form id="form1" runat="server">
			<table id="mainTable" class="MainTable">
				<tr>
					<td align="center">
						<asp:label id="lbSearchInfo" runat="server" CssClass="InfoHeader"></asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable" id="tbParams">
							<tr>
								<td style="width:20%">
                                    <asp:label id="lbDepositNumber" runat="server" CssClass="InfoText">Номер вкладу</asp:label></td>
								<td style="width:25%">
                                    <asp:TextBox id="textDepositNum" tabIndex="2" runat="server" CssClass="InfoText" MaxLength="48"
										ToolTip="Номер вклада"></asp:TextBox></td>
								<td style="width:10%"></td>
								<td style="width:25%">
									<asp:label id="lbClientName" runat="server" CssClass="InfoText">Вкладник</asp:label>
								</td>
								<td style="width:20%">
									<asp:TextBox id="textClientName" runat="server" ToolTip="ФИО вкладчика" MaxLength="35" tabIndex="5"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositId" CssClass="InfoText" runat="server">Ідентифікатор 
                                    вкладу</asp:label></td>
								<td>
									<asp:TextBox id="textDepositId" runat="server" ToolTip="Идентификатор вклада" MaxLength="12"
										tabIndex="2" CssClass="InfoText"></asp:TextBox></td>
								<td></td>
								<td>
									<asp:label id="lbClientOKPO" runat="server" CssClass="InfoText">Ідентифікаційний 
                                    код</asp:label></td>
								<td>
									<asp:TextBox id="textClientCode" runat="server" ToolTip="Идентификационный код" MaxLength="10"
										tabIndex="6" CssClass="InfoText"></asp:TextBox></td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbClientId" runat="server" CssClass="InfoText">Номер контрагента</asp:label>
								</td>
								<td>
									<asp:TextBox id="textClientId" runat="server" ToolTip="Номер контрагента" MaxLength="12" tabIndex="3"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbDocSerial" runat="server" CssClass="InfoText">Серія документу</asp:label>
								</td>
								<td>
									
									<asp:TextBox id="DocSerial" runat="server" ToolTip="Серия документа" MaxLength="10" tabIndex="8"
										CssClass="InfoText"></asp:TextBox>
									
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositAccount" runat="server" CssClass="InfoText">Номер 
                                    рахунку</asp:label>
								</td>
								<td>
									<asp:TextBox id="textAccount" runat="server" ToolTip="Номер счета" MaxLength="14" tabIndex="4"
										CssClass="InfoText"></asp:TextBox>
								</td>
								<td></td>
								<td>
									<asp:label id="lbDocNumber" runat="server" CssClass="InfoText">Номер документу</asp:label>
								</td>
								<td>
									<asp:TextBox id="DocNumber" runat="server" ToolTip="Номер документа" MaxLength="10" tabIndex="9"
										CssClass="InfoText"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td>
								</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table id="tbl_Hint" class="InnerTable">
							<tr>
								<td style="width:20%">
									<input id="btSearch" class="AcceptButton" type="button" value="Пошук" 
                                        runat="server" tabindex="10" onserverclick="btSearch_ServerClick" 
                                        causesvalidation="False"/>
								</td>
								<td style="width:5%">
                                </td>
								<td style="width:20%">
									<input id="btSelect" class="AcceptButton" type="button" runat="server"
										tabindex="11" value="Перегляд" onserverclick="btSelect_ServerClick" causesvalidation="False"/>
								</td>
								<td style="width:5%">									
								</td>
								<td style="width:20%">
                                    <input id="btSelectAll" class="AcceptButton" type="button" runat="server"
										tabindex="12" onserverclick="btSelectAll_ServerClick" causesvalidation="False"/>										
								</td>
								<td style="width:5%">									
								</td>
								<td style="width:25%">
                                    <input id="btStornoAll" class="AcceptButton" type="button" runat="server"
										tabindex="13" onserverclick="btStornoAll_ServerClick" value="Сторнувати всі вибрані" 
                                        causesvalidation="True"/>										
								</td>																
							</tr>
							<tr style="height:10px">
							    <td colspan="7"></td>
							</tr>
							<tr id="rReason" runat="server">
							    <td colspan="2">
                                    <asp:label id="lbDepositNumber0" runat="server" CssClass="InfoText">Причина 
                                    сторнування</asp:label></td>
							    <td colspan="4">
									<asp:TextBox id="textReason" runat="server" tabIndex="14"
										CssClass="InfoText" TextMode="MultiLine"></asp:TextBox>
								</td>
							    <td>
                                    <asp:RequiredFieldValidator ID="vReason" runat="server" 
                                        ControlToValidate="textReason" Display="Dynamic" 
                                        ErrorMessage="Необхідно заповнити"></asp:RequiredFieldValidator>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
				    <td>
				        <Bars:BarsGridViewEx ID="gvDeposits" runat="server" AllowPaging="True" 
                            AllowSorting="True" CaptionText="" 
                            ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                            CssClass="BaseGrid" DataSourceID="dsDeposits" DateMask="dd.MM.yyyy" 
                            ExcelImageUrl="/common/images/default/16/export_excel.png" 
                            FilterImageUrl="/common/images/default/16/filter.png" 
                            HoverRowCssClass="hoverRow" JavascriptSelectionType="MultiSelect" 
                            MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                            RefreshImageUrl="/common/images/default/16/refresh.png" ShowFooter="True" 
                            AutoGenerateColumns="False" DataKeyNames="DPT_ID">
                                <FooterStyle CssClass="footerRow"></FooterStyle>
                                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                <EditRowStyle CssClass="editRow"></EditRowStyle>
                                <PagerStyle CssClass="pagerRow"></PagerStyle>
                                <NewRowStyle CssClass=""></NewRowStyle>
                                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                            <Columns>
                                <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>                                
                                <asp:BoundField HtmlEncode="False" DataField="DPT_ID" SortExpression="DPT_ID" HeaderText="Сист. №">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="VIDD_NAME" SortExpression="VIDD_NAME" HeaderText="Тип вкладу">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DAT_BEGIN" SortExpression="DAT_BEGIN" HeaderText="Відкр.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Завер.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="CUST_ID" SortExpression="CUST_ID" HeaderText="РНК">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="CUST_IDCODE" SortExpression="CUST_IDCODE" HeaderText="Ід. код">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="CUST_NAME" SortExpression="CUST_NAME" HeaderText="ПІБ">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DPT_ACCNUM" SortExpression="DPT_ACCNUM" HeaderText="Рахунок">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DPT_CURCODE" SortExpression="DPT_CURCODE" HeaderText="Вал.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DPT_SALDO" SortExpression="DPT_SALDO" HeaderText="Залишок">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="INT_SALDO" SortExpression="INT_SALDO" HeaderText="Зал. %%">
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                                <RowStyle CssClass="normalRow"></RowStyle>
                        </Bars:BarsGridViewEx>
				    </td>
				</tr>
				<tr>
				    <td>
				        <Bars:BarsSqlDataSourceEx ID="dsDeposits" ProviderName="barsroot.core" runat="server" AllowPaging="True">
                        </Bars:BarsSqlDataSourceEx>
				    </td>
				</tr>
        </table>    
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
