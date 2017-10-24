<%@ Page Language="C#" AutoEventWireup="true" CodeFile="export_dbf.aspx.cs" Inherits="cbirep_export_dbf" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Експорт каталогізованих запитів в DBF</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="frm_exp_to_dbf" runat="server">
        <div>
        </div>
        <asp:Panel runat="server" ID="pnZAPROS" GroupingText="Доступні для користувача каталогізовані запити">

                        <BarsEx:BarsSqlDataSourceEx ID="dsMainZapros" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx ID="gvMainZapros" runat="server" AllowPaging="True" AllowSorting="True"
                            DataSourceID="dsMainZapros" CssClass="barsGridView" ShowPageSizeBox="true"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="ServerSelect" OnRowClicked="gvMainZapros_RowClicked" OnDataBound="gvMainZapros_DataBound"
                            OnRowDataBound="gvMainZapros_RowDataBound"
                            PagerSettings-PageIndex="0" Width="100%"
                            PageSize="10">
                            <SelectedRowStyle CssClass="selectedRow" />
                            <Columns>
                                <asp:BoundField DataField="KODZ" HeaderText="Код запиту" />
                                <asp:BoundField DataField="NAME" HeaderText="Найменування" />
                            </Columns>
                        </BarsEx:BarsGridViewEx>

                        <asp:Button runat="server" ID="btRun" Text="Сформувати" OnClick="btRun_Click" />

        </asp:Panel>
        <asp:Panel runat="server" ID="pnData" GroupingText="Сформовані файли">
            <BarsEx:BarsSqlDataSourceEx ID="dsMainData" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
            <BarsEx:BarsGridViewEx ID="gvMainData" runat="server" AllowPaging="True" AllowSorting="True"
                DataSourceID="dsMainData" CssClass="barsGridView" ShowPageSizeBox="true"
                AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
                OnRowDataBound="gvMainData_RowDataBound"
                PagerSettings-PageIndex="0"
                PageSize="10">
                <SelectedRowStyle CssClass="selectedRow" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" />
                    <asp:BoundField DataField="CREATING_DATE" HeaderText="Дата створення" ItemStyle-HorizontalAlign="Center"/>
                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btDownload" Text="Завантажити dbf файл" OnCommand="btDownload_Command" CommandName="SAVE" CommandArgument='<%#Eval("ID")%>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btDownloadTxt" Text="Завантажити txt файл" OnCommand="btDownloadTxt_Command" CommandName="SaveTxt" CommandArgument='<%#Eval("ID")%>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btDEL" Text="Видалити" OnCommand="btDownload_Command" CommandName="DEL" CommandArgument='<%#Eval("ID")%>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </BarsEx:BarsGridViewEx>
        </asp:Panel>
    </form>
</body>
</html>
