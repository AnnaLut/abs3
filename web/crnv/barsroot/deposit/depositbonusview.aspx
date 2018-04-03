<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositbonusview.aspx.cs" Inherits="deposit_depositbonusconfirm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Архів бонусів</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet"/>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server"
            EnablePageMethods="true">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="sync_update_panel"  UpdateMode="Conditional" runat="server">
            <ContentTemplate>         
                <div style="height:20px; text-align:center">
                    <asp:Label ID="lbTitle" runat="server" 
                        Text="Архів запитів на бонуси" CssClass="InfoLabel"></asp:Label>               
                </div>
                <div style="height:20px"></div>
                <Bars:BarsGridViewEx ID="gvBonuses" runat="server" 
                    ShowFilter="True" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png" 
                    CssClass="barsGridView" DataKeyNames="DPT_ID" DataSourceID="dsBonuses" 
                    ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png" 
                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"                                 
                    MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                    RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"                     
                    CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png" 
                    EnableModelValidation="True" HoverRowCssClass="hoverRow">
                    <Columns>
                        <asp:BoundField DataField="DPT_ID" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_ID" HeaderText="Ід. договору" />
                        <asp:BoundField DataField="DPT_NUM" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_NUM" HeaderText="№ договору" />
                        <asp:BoundField DataField="DPT_DAT" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_DAT" HeaderText="Дата договору" />
                        <asp:BoundField DataField="BONUS_NAME" ItemStyle-HorizontalAlign="Left" SortExpression="BONUS_NAME" HeaderText="Назва бонусу" />
                        <asp:BoundField DataField="BONUS_VALUE_FACT" ItemStyle-HorizontalAlign="Right" SortExpression="BONUS_VALUE_FACT" HeaderText="Бонус" />
                        <asp:BoundField DataField="REC_STATENAME" ItemStyle-HorizontalAlign="Center" SortExpression="REC_STATENAME" HeaderText="Статус" />
                        <asp:BoundField DataField="REQ_DATE" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_DATE" HeaderText="Дата створення" />
                        <asp:BoundField DataField="REC_USERNAME" ItemStyle-HorizontalAlign="Left" SortExpression="REC_USERNAME" HeaderText="Створив" />
                        <asp:BoundField DataField="PRC_USERNAME" ItemStyle-HorizontalAlign="Left" SortExpression="PRC_USERNAME" HeaderText="Підтвердив" />
                        <asp:BoundField DataField="BRANCH" ItemStyle-HorizontalAlign="Left" SortExpression="BRANCH" HeaderText="Відділення" />
                    </Columns>
                </Bars:BarsGridViewEx>
                <Bars:BarsSqlDataSourceEx ID="dsBonuses" ProviderName="barsroot.core" runat="server">
                </Bars:BarsSqlDataSourceEx>
                <div style="height:20px"></div>                
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
