<%@ Page Language="C#" AutoEventWireup="true" CodeFile="static_layout.aspx.cs" Inherits="static_layout" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Динамічний макет - 2</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>
<body bgcolor="#f0f0f0">
    <form id="formDinamicLayouts" runat="server" style="vertical-align: central">
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <cc1:ImageTextButton ID="ibtOpen" runat="server" ToolTip="Виконати розрахунок по макету" Text="" ImageUrl="/common/images/default/16/open.png" ButtonStyle="Image" OnClick="btOpen_Click" Width="50px" />
        </asp:Panel>
        <br />
        <asp:ObjectDataSource ID="odsVStaticLayouts" runat="server" SelectMethod="Select"
            TypeName="Bars.DynamicLayout.VStaticLayout" EnablePaging="True" SortParameterName="SortExpression" />

        <BarsEX:BarsGridViewEx ID="gvDinamicLayouts" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="100" AllowPaging="True" AllowSorting="True"
            CssClass="barsGridView" DataKeyNames="DK,NAME,NLS,BS,OB,NAZN,GRP" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound" AutoGenerateCheckBoxColumn="false"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="DK" HeaderText="Д/К" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="GRP" HeaderText="№ грп" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="ID" HeaderText="№ макету" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NAME" HeaderText="Назава макету" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NLS" HeaderText="Рахунок А" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="BS" HeaderText="БалР Б" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="OB" HeaderText="ОБ22 Б" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="NAZN" HeaderText="Попередне призначення платежу" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="DATP"  HeaderText="Дата поперед. виконання" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                <asp:BoundField DataField="ALG" HeaderText="№ алг" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px"></asp:BoundField>
            </Columns>
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <SelectedRowStyle CssClass="selectedRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <PagerSettings Mode="Numeric"></PagerSettings>
            <RowStyle CssClass="normalRow" />
            <NewRowStyle CssClass="newRow" />
        </BarsEX:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="false" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
