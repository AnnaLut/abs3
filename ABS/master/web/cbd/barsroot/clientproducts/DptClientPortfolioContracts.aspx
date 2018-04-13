<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptClientPortfolioContracts.aspx.cs"
    Inherits="deposit_DptClientPortfolioContracts" %>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Портфель договорів клієнта</title>
    <link href="/barsroot/deposit/style/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="frmPortfolioContracts" runat="server">
    <ajax:ToolkitScriptManager ID="SM" runat="server" EnablePageMethods="true">
    </ajax:ToolkitScriptManager>
    <div style="width: 100%">
        <table class="MainTable" width="100%">
            <tr>
                <td align="center" colspan="4">
                    <asp:Label ID="lbPageTitle" runat="server" Text="Портфель договорів клієнта" CssClass="InfoHeader" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Panel ID="pnTrustee" runat="server" GroupingText="Клієнт">
                        <table class="InnerTable" width="100%">
                            <tr>
                                <td align="center" style="width: 17%" rowspan="2">
                                    <asp:Button ID="btnClientCard" runat="server" CssClass="DirectionButton" Text="Картка Клієнта"
                                        OnClick="btnClientCard_Click" />
                                </td>
                                <td align="right" style="width: 20%">
                                    <asp:Label ID="lbClientName" runat="server" CssClass="InfoLabel" Style="text-align: right"
                                        meta:resourcekey="lbClientName">ПІБ клієнта:</asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="textClientName" meta:resourcekey="textClientName" TabIndex="1" Width="99%"
                                        runat="server" ToolTip="Назва клієнта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbClienCode" runat="server" CssClass="InfoLabel" Style="text-align: right"
                                        meta:resourcekey="lbClienCode">ІПН клієнта:</asp:Label>
                                </td>
                                <td align="left" style="width: 20%">
                                    <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode" TabIndex="2" Width="70%"
                                        runat="server" ToolTip="Індивідуальний податковий номер клієнта" ReadOnly="True"
                                        CssClass="InfoText"></asp:TextBox>
                                </td>
                                <td align="right" style="width: 30%">
                                    <asp:Label ID="lbClienBirthday" runat="server" CssClass="InfoLabel" meta:resourcekey="lbClienBirthday">Дата народження клієнта:</asp:Label>
                                </td>
                                <td style="width: 13%">
                                    <igtxt:WebDateTimeEdit ID="dtClienBirthday" TabIndex="3" runat="server" ToolTip="Дата народження клієнта"
                                        MinValue="1900-01-01" HorizontalAlign="Center" HideEnterKey="True" DisplayModeFormat="dd/MM/yyyy"
                                        EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                                    </igtxt:WebDateTimeEdit>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <Bars:BarsSqlDataSourceEx ID="dsDepositMain" AllowPaging="true"  PageSize="15" ProviderName="barsroot.core"
                        runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
                <td>
                    <Bars:BarsSqlDataSourceEx ID="dsDepositTrustee" AllowPaging="true" PageSize="15"
                        ProviderName="barsroot.core" runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
                <td>
                    <Bars:BarsSqlDataSourceEx ID="dsDepositHeritor" AllowPaging="true" PageSize="15"
                        ProviderName="barsroot.core" runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
                <td>
                    <Bars:BarsSqlDataSourceEx ID="dsDepositBeneficiary" AllowPaging="true" PageSize="15"
                        ProviderName="barsroot.core" runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
                 <td>
                    <Bars:BarsSqlDataSourceEx ID="dsDepositChildren" AllowPaging="true" PageSize="15"
                        ProviderName="barsroot.core" runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
            </tr>
            <tr>
                <td>
                    <Bars:BarsSqlDataSourceEx ID="dsCards" AllowPaging="true" PageSize="15" ProviderName="barsroot.core"
                        runat="server">
                    </Bars:BarsSqlDataSourceEx>
                </td>
            </tr>
        </table>
        <ajax:TabContainer ID="TabMainContainer" runat="server" TabStripPlacement="Top" OnActiveTabChanged="MainTabChanged_Click" AutoPostBack ="true"
            CssClass="ajax__tab_xp" Width="100%" Height="510" ActiveTabIndex="0">
            <ajax:TabPanel ID="TabDeposit" HeaderText="Депозити" runat="server">
                <ContentTemplate>
                    <ajax:TabContainer ID="TabDepositContainer" runat="server" ActiveTabIndex="0" Width="99.5%" OnActiveTabChanged="DepositTabChanged_Click" AutoPostBack ="true"
                        Height="450px">
                        <ajax:TabPanel runat="server" ID="TabContractMain" HeaderText="КЛІЄНТА">
                            <ContentTemplate>
                                <table class="InnerTable" width="100%" cellpadding="3">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                            <asp:Button ID="btSelectContract" runat="server" class="AcceptButton" Text="Вибрати договір"
                                                OnClick="SelectContract_Click" />
                                        </td>
                                        <td align="right" style="width: 50%">
                                            <asp:Button ID="btCreateContract" runat="server" class="AcceptButton" Text="Новий договір"
                                                OnClick="btCreateContract_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" valign="top">
                                            <Bars:BarsGridViewEx ID="gvDepositMain" DataSourceID="dsDepositMain" runat="server"
                                                CssClass="barsGridView" Style="width: 100%" AllowPaging="True" PageSize="15"
                                                ShowPageSizeBox="false" AutoGenerateColumns="False" AllowSorting="true" ShowCaption="false"
                                                JavascriptSelectionType="SingleRow" DataKeyNames="DPT_ID,DPT_LOCK,ARCHDOC_ID"
                                                OnRowDataBound="gv_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="DPT_ID" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору">
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="TYPE_NAME" SortExpression="TYPE_NAME"
                                                        HeaderText="Тип вкладу">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OSTC" SortExpression="OSTC" HeaderText="Залишок">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OST_INT" SortExpression="OST_INT" HeaderText="Залишок<BR>%%">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DPT_LOCK" Visible="false" />
                                                    <asp:BoundField DataField="ARCHDOC_ID" Visible="false" />
                                                </Columns>
                                            </Bars:BarsGridViewEx>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                        <ajax:TabPanel runat="server" ID="TabContractTrustee" HeaderText="ДОВІРЕНІ">
                            <ContentTemplate>
                                <table class="InnerTable" width="100%" cellpadding="3">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                            <asp:Button ID="btSelectTrusteeContract" runat="server" class="AcceptButton" Text="Вибрати договір"
                                                OnClick="SelectContract_Click" />
                                        </td>
                                        <td align="right" style="width: 50%">
                                            <asp:Button ID="btCreateTrusteeContract" runat="server" class="AcceptButton" Text="Новий договір"
                                                OnClick="btCreateTrusteeContract_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" valign="top">
                                            <Bars:BarsGridViewEx ID="gvDepositTrustee" CssClass="barsGridView" runat="server"
                                                DataSourceID="dsDepositTrustee" Style="width: 100%" PageSize="15" AllowPaging="True"
                                                AllowSorting="false" AutoGenerateColumns="False" ShowPageSizeBox="false" ShowCaption="false"
                                                ShowExportExcelButton="false" JavascriptSelectionType="SingleRow" DataKeyNames="DPT_ID,DPT_LOCK,ARCHDOC_ID"
                                                OnRowDataBound="gv_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="DPT_ID" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору">
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NMK" SortExpression="NMK" HeaderText="ПІБ<BR>Власника">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DPT_LOCK" Visible="false" />
                                                    <asp:BoundField DataField="ARCHDOC_ID" Visible="false" />
                                                </Columns>
                                            </Bars:BarsGridViewEx>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                        <ajax:TabPanel runat="server" ID="TabContractHeritage" HeaderText="УСПАДКОВАНІ">
                            <ContentTemplate>
                                <table class="InnerTable" width="100%" cellpadding="3">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                        </td>
                                        <td align="right" style="width: 50%">
                                            <asp:Button ID="btnPayoutHeritage" runat="server" class="AcceptButton" Text="Виплата спадщини"
                                                OnClick="btnPayoutHeritage_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" valign="top">
                                            <Bars:BarsGridViewEx ID="gvHeritage" DataSourceID="dsDepositHeritor" runat="server"
                                                CssClass="barsGridView" Style="width: 100%" AllowPaging="True" PageSize="15"
                                                ShowPageSizeBox="False" AutoGenerateColumns="False" DateMask="dd/MM/yyyy" AllowSorting="false"
                                                ShowCaption="False" JavascriptSelectionType="SingleRow" DataKeyNames="DPT_ID,DPT_LOCK,ARCHDOC_ID,DAT_END,INHERIT_SHARE">
                                                <Columns>
                                                    <asp:BoundField DataField="DPT_ID" Visible="false"></asp:BoundField>
                                                    <asp:BoundField DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору"
                                                        HtmlEncode="False"></asp:BoundField>
                                                    <asp:BoundField DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                                        HtmlEncode="False" DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="TYPE_NAME" SortExpression="TYPE_NAME"
                                                        HeaderText="Тип вкладу">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NMK" SortExpression="NMK" HeaderText="ПІБ<BR>Власника">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OST_DEP" SortExpression="OST_DEP" HeaderText="Залишок">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OST_INT" SortExpression="OST_INT" HeaderText="Залишок<BR>%%">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="INHERIT_SHARE" SortExpression="INHERIT_SHARE"
                                                        HeaderText="Частка<BR>спадку">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DPT_LOCK" Visible="False" />
                                                    <asp:BoundField DataField="ARCHDOC_ID" Visible="False" />
                                                </Columns>
                                            </Bars:BarsGridViewEx>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                        <ajax:TabPanel runat="server" ID="TabContractBeneficiary" HeaderText="НА БЕНЕФІЦІАРА">
                            <ContentTemplate>
                                <table class="InnerTable" width="100%" cellpadding="3">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                        </td>
                                        <td align="right" style="width: 50%">
                                            <asp:Button ID="btnGetOwnership" runat="server" class="AcceptButton" Text="Вступ в право власності"
                                                OnClick="btnGetOwnership_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" valign="top">
                                            <Bars:BarsGridViewEx ID="gvDepositBeneficiary" DataSourceID="dsDepositBeneficiary"
                                                runat="server" CssClass="barsGridView" Style="width: 100%" AllowPaging="True"
                                                PageSize="15" ShowPageSizeBox="False" AutoGenerateColumns="False" DateMask="dd/MM/yyyy"
                                                AllowSorting="false" ShowCaption="False" JavascriptSelectionType="SingleRow"
                                                DataKeyNames="DPT_ID,DPT_LOCK,ARCHDOC_ID,TRUSTEE_ID">
                                                <Columns>
                                                    <asp:BoundField DataField="DPT_ID" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору">
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="TYPE_NAME" SortExpression="TYPE_NAME"
                                                        HeaderText="Тип вкладу">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NMK" SortExpression="NMK" HeaderText="ПІБ<BR>Вносителя">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OST_DEP" SortExpression="OST_DEP" HeaderText="Залишок"
                                                        DataFormatString="{0:### ### ##0.00}">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="OST_INT" SortExpression="OST_INT" HeaderText="Залишок<BR>%%"
                                                        DataFormatString="{0:### ### ##0.00}">
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DPT_LOCK" Visible="false" />
                                                    <asp:BoundField DataField="ARCHDOC_ID" Visible="false" />
                                                    <asp:BoundField DataField="TRUSTEE_ID" Visible="false" />
                                                </Columns>
                                            </Bars:BarsGridViewEx>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                        <ajax:TabPanel runat="server" ID="TabContractChildren" HeaderText="НА МАЛОЛІТНІХ ОСІБ">
                            <ContentTemplate>
                                <table class="InnerTable" width="100%" cellpadding="3">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                            <asp:Button ID="SetChild" runat="server" class="AcceptButton" Text="Передача малолітній особі"
                                                OnClick="btnSetChild_Click" />
                                        </td>
                                      <td align="right" style="width: 50%">
                                            <asp:Button ID="SetManager" runat="server" class="AcceptButton" Text="Вибір розпорядника"
                                                OnClick="btnSetManager_Click" Visible ="false" />
                                        </td>
                                    
                                            <td align="right" style="width: 50%">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" valign="top">
                                            <Bars:BarsGridViewEx ID="gvDepositChildren" CssClass="barsGridView" runat="server"
                                                DataSourceID="dsDepositChildren" Style="width: 100%" PageSize="15" AllowPaging="True" AutoGenerateColumns="False" ShowPageSizeBox="False" ShowCaption="False" JavascriptSelectionType="SingleRow" DataKeyNames="DPT_ID,DPT_LOCK,ARCHDOC_ID,RNK_M,RNK_C"
                                                OnRowDataBound="gv_RowDataBound" CaptionText="" DateMask="dd.MM.yyyy" HoverRowCssClass="hoverRow" MetaTableName="">
                                                <NewRowStyle CssClass="" />
                                                <AlternatingRowStyle CssClass="alternateRow" />
                                                <Columns>
                                                    <asp:BoundField DataField="DPT_ID" Visible="False"></asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору">
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NMK" SortExpression="NMK" HeaderText="ПІБ<BR>Власника">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення"
                                                        DataFormatString="{0:dd/MM/yyyy}">
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="DPT_LOCK" Visible="False" />
                                                    <asp:BoundField DataField="ARCHDOC_ID" Visible="False" />
                                                </Columns>
                                                <EditRowStyle CssClass="editRow" />
                                                <FooterStyle CssClass="footerRow" />
                                                <HeaderStyle CssClass="headerRow" />
                                                <PagerStyle CssClass="pagerRow" />
                                                <RowStyle CssClass="normalRow" />
                                                <SelectedRowStyle CssClass="selectedRow" />
                                            </Bars:BarsGridViewEx>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </ajax:TabPanel>
                    </ajax:TabContainer>
                    <table width="100%">
                        <tr>
                            <td style="width:25%" align="center">
                                <asp:Label ID="lb_LegendEBP" runat="server" Text="Договір ЕБП" Font-Bold="True"/>
                            </td>
                            <td style="width:25%" align="center">
                                <asp:Label ID="lb_LegendLock" runat="server" Text="Договір заблокований"
                                    ForeColor="Red" Font-Bold="True"/>
                            </td>
                            <td style="width:25%" align="center">
                                <asp:Label ID="lb_LegendOld" runat="server" Text="Договір не ЕБП"
                                    ForeColor="Green" Font-Bold="True" />
                            </td>
                            <td style="width:25%" align="center">
                                <asp:Label ID="lb_LegendNotSign" runat="server" Text="Договір не підписаний клієнтом"
                                    ForeColor="Yellow" Font-Bold="True" />
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </ajax:TabPanel>
            <ajax:TabPanel ID="TabBPK" HeaderText="Карткові рахунки" runat="server" Visible="true">
                <ContentTemplate>
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="left" style="width: 50%">
                                <asp:Button ID="btnShowAccount" runat="server" class="AcceptButton" Text="Картка рахунку"
                                    OnClick="btnShowAccount_Click" />
                                <asp:Button ID="bntPrint" runat="server" class="AcceptButton" OnClick="bntPrint_Click" Text="Друк договорів" />
                                <asp:Button ID="btnCreateCard" runat="server" class="AcceptButton" OnClick="btnCreateCard_Click" Text="Новий договір" />
                            </td>
                            <td align="left" style="width: 50%">
                                &nbsp;</td>
                            <td align="right" style="width: 50%">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" valign="top">
                                <Bars:BarsGridViewEx ID="gvCards" DataSourceID="dsCards" runat="server"
                                    CssClass="barsGridView" Style="width: 100%" AllowPaging="True" PageSize="15"
                                    ShowPageSizeBox="False" AutoGenerateColumns="False" DateMask="dd/MM/yyyy" 
                                    AllowSorting="True" ShowCaption="False"
                                    JavascriptSelectionType="SingleRow" DataKeyNames="ACC_ACC,DOC_ID" CaptionText="" HoverRowCssClass="hoverRow" MetaTableName="" ShowExportExcelButton="True">
                                    <NewRowStyle CssClass="" />
                                    <AlternatingRowStyle CssClass="alternateRow" />
                                    <Columns>
                                        <asp:BoundField DataField="ACC_ACC" Visible="False"></asp:BoundField>
                                        <asp:BoundField DataField="ND" HtmlEncode="False" HeaderText="№<BR>договору" SortExpression="ND">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_TIPNAME" HtmlEncode="False" HeaderText="Субпродукт" SortExpression="ACC_TIPNAME" >
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CARD_CODE" HtmlEncode="False" HeaderText="Тип картки" SortExpression="CARD_CODE" >
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_NLS" HtmlEncode="False" HeaderText="№<BR>рахунку" SortExpression="ACC_NLS" >
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_LCV" HtmlEncode="False" HeaderText="Вал." SortExpression="ACC_LCV">
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_OB22" HtmlEncode="False" HeaderText="ОБ22" SortExpression="ACC_OB22" >
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_OST"  HtmlEncode="False" HeaderText="Залишок"
                                            DataFormatString="{0:### ### ##0.00}">
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACC_DAOS" HtmlEncode="False" HeaderText="Дата<BR>відкриття" SortExpression="ACC_DAOS"
                                            DataFormatString="{0:dd/MM/yyyy}">
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BRANCH" HtmlEncode="False" HeaderText="Код<BR>Відділення" SortExpression="BRANCH" >
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DOC_ID" Visible="False"></asp:BoundField>
                                    </Columns>
                                    <EditRowStyle CssClass="editRow" />
                                    <FooterStyle CssClass="footerRow" />
                                    <HeaderStyle CssClass="headerRow" />
                                    <PagerStyle CssClass="pagerRow" />
                                    <RowStyle CssClass="normalRow" />
                                    <SelectedRowStyle CssClass="selectedRow" />
                                </Bars:BarsGridViewEx>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </ajax:TabPanel>
        </ajax:TabContainer>
    </div>
    </form>
</body>
</html>
