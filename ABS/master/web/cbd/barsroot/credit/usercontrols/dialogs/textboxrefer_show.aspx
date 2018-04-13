<%@ Page Language="C#" AutoEventWireup="true" CodeFile="textboxrefer_show.aspx.cs"
    Inherits="credit_dialogs_textboxrefer_show" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Справочник</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <script language="javascript" type="text/jscript">
        function CloseReferDialog(key, semantic) {
            var res = new Object();

            res.key = key;
            res.semantic = semantic;

            window.returnValue = res;
            window.close();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Справочник - {0}" meta:resourcekey="lbPageTitleResource1"></asp:Label>
    </div>
    <div style="padding-top: 20px">
        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" AllowPaging="False"
            FilterStatement="" PageButtonCount="10" PagerMode="NextPrevious" PageSize="10">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="sds" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" 
            RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png" 
            Width="99%" DataKeyNames="KEY" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvResource1"
            ShowExportExcelButton="True" ShowFooter="True" AllowPaging="True" 
            PageSize="30">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <RowStyle CssClass="normalRow"></RowStyle>
            <Columns>
                <asp:TemplateField ShowHeader="False" meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <asp:ImageButton ID="ibSelect" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/ok.png"
                            OnClientClick=<%# String.Format("if(confirm('Выбрать значение {0}?')){{CloseReferDialog('{1}','{2}');return false;}}return false;", Eval("KEY"), Eval("KEY"), Convert.ToString(Eval("SEMANTIC")).Replace("'", "\\'")) %>
                            Text="Выбрать" meta:resourcekey="ibSelectResource1" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                </asp:TemplateField>
            </Columns>
        </Bars:BarsGridViewEx>
    </div>
    <div style="padding-top: 20px; padding-left: 10px; text-align: center">
        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/delete.png"
            Text="Удалить" ToolTip="Удалить выбраное значение" OnClientClick="CloseReferDialog('', '');"
            meta:resourcekey="ibDeleteResource1" />
        <asp:ImageButton ID="ibClose" runat="server" CausesValidation="False" ImageUrl="/Common/Images/default/16/cancel.png"
            Text="Отмена" ToolTip="Отмена" OnClientClick="CloseReferDialog(null, null);" meta:resourcekey="ibCloseResource1" />
    </div>
    </form>
</body>
</html>
