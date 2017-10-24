<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositbonusconfirm.aspx.cs" Inherits="deposit_depositbonusconfirm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: підтвердження бонусів</title>
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
                        Text="Запити на бонуси для депозитних договорів" CssClass="InfoLabel"></asp:Label>               
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
                    EnableModelValidation="True" HoverRowCssClass="hoverRow"
                    onrowcommand="gvBonuses_RowCommand">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server"
                                    CommandArgument='<%#Convert.ToString(Eval("DPT_ID"))%>'
                                    CommandName="DETAILS" Text="Деталі" Width="100px"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DPT_ID" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_ID" HeaderText="Ідент. договору" />
                        <asp:BoundField DataField="DPT_NUM" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_NUM" HeaderText="Номер договору" />
                        <asp:BoundField DataField="DPT_DAT" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_DAT" HeaderText="Дата договору" />
                        <asp:BoundField DataField="DPT_RATE" ItemStyle-HorizontalAlign="Right" SortExpression="DPT_RATE" HeaderText="Поточна відсоткова ставка" />
                        <asp:BoundField DataField="CUST_ID" ItemStyle-HorizontalAlign="Center" SortExpression="CUST_ID" HeaderText="Рег. № клієнта" />
                        <asp:BoundField DataField="CUST_NAME" ItemStyle-HorizontalAlign="Left" SortExpression="CUST_NAME" HeaderText="ПІБ клієнта" />
                        <asp:BoundField DataField="CUST_CODE" ItemStyle-HorizontalAlign="Center" SortExpression="CUST_CODE" HeaderText="Ідент. код" />
                        <asp:BoundField DataField="TYPE_ID" ItemStyle-HorizontalAlign="Center" SortExpression="TYPE_ID" HeaderText="Ідент. виду вклада" />
                        <asp:BoundField DataField="TYPE_NAME" ItemStyle-HorizontalAlign="Left" SortExpression="TYPE_NAME" HeaderText="Назва виду вклада" />
                        <asp:BoundField DataField="TYPE_CODE" ItemStyle-HorizontalAlign="Center" SortExpression="TYPE_CODE" HeaderText="Код виду вклада" />
                        <asp:BoundField DataField="BRANCH_ID" ItemStyle-HorizontalAlign="Center" SortExpression="BRANCH_ID" HeaderText="Відділення" />
                        <asp:BoundField DataField="BRANCH_NAME" ItemStyle-HorizontalAlign="Left" SortExpression="BRANCH_NAME" HeaderText="Назва відділення" />
                    </Columns>
                </Bars:BarsGridViewEx>
                <Bars:BarsSqlDataSourceEx ID="dsBonuses" ProviderName="barsroot.core" runat="server">
                </Bars:BarsSqlDataSourceEx>
                <div style="height:20px"></div>                
                <div style="height:20px; text-align:center">
                    <asp:Label ID="lbDetails" runat="server" 
                        Text="Деталі запитів на бонуси для депозитних договорів" CssClass="InfoLabel"></asp:Label>
                </div>
                <Bars:BarsGridViewEx ID="gvBonusDetails" runat="server"
                    AutoGenerateColumns="False" CssClass="barsGridView" DataKeyNames="DPT_ID" DataSourceID="dsBonusDetails"
                    ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"                     
                    ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png" 
                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"                                 
                    MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                    RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png" 
                    CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png" 
                    EnableModelValidation="True" HoverRowCssClass="hoverRow" onrowcommand="gvBonusDetails_RowCommand">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="btAccept" runat="server"
                                    CommandArgument='<%#Convert.ToString(Eval("DPT_ID"))+":"+Convert.ToString(Eval("BONUS_ID"))%>'
                                    CommandName="ACCEPT" Text="Візувати" Width="100px"
                                    Enabled='<%#Convert.ToString(Eval("REQ_STATEID")) == "NULL"%>' />
                                <br /><asp:Button ID="btDecline" runat="server"
                                    CommandArgument='<%#Convert.ToString(Eval("DPT_ID"))+":"+Convert.ToString(Eval("BONUS_ID"))%>'
                                    CommandName="DECLINE" Text="Сторнувати" Width="100px"
                                    Enabled='<%#Convert.ToString(Eval("REQ_STATEID")) == "NULL"%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DPT_ID" ItemStyle-HorizontalAlign="Center" SortExpression="DPT_ID" HeaderText="Ідент. договору" />
                        <asp:BoundField DataField="BONUS_ID" ItemStyle-HorizontalAlign="Center" SortExpression="BONUS_ID" HeaderText="Ідент. бонуса" />
                        <asp:BoundField DataField="BONUS_NAME" ItemStyle-HorizontalAlign="Left" SortExpression="BONUS_NAME" HeaderText="Назва бонуса" />
                        <asp:BoundField DataField="BONUSVAL_PLAN" ItemStyle-HorizontalAlign="Right" SortExpression="BONUSVAL_PLAN" HeaderText="Розрахунковий бонус" />
                        <asp:BoundField DataField="REQ_STATEID" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_STATEID" HeaderText="Код статуса запита" />
                        <asp:BoundField DataField="REQ_STATENAME" ItemStyle-HorizontalAlign="Left" SortExpression="REQ_STATENAME" HeaderText="Статус запита" />
                        <asp:BoundField DataField="REQ_AUTO" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_AUTO" HeaderText="Автоматично" />
                        <asp:BoundField DataField="REQ_CONFIRM" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_CONFIRM" HeaderText="Потребує підтвердження" />
                        <asp:BoundField DataField="REQ_DATE" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_DATE" HeaderText="Дата формування" />
                        <asp:BoundField DataField="REQ_USERID" ItemStyle-HorizontalAlign="Center" SortExpression="REQ_USERID" HeaderText="Код користувача ініціатора" />
                        <asp:BoundField DataField="REQ_USERNAME" ItemStyle-HorizontalAlign="Left" SortExpression="REQ_USERNAME" HeaderText="ПІБ користувача ініціатора" />
                    </Columns>
                </Bars:BarsGridViewEx>
                <Bars:BarsSqlDataSourceEx ID="dsBonusDetails" ProviderName="barsroot.core" runat="server">
                </Bars:BarsSqlDataSourceEx>                    
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
