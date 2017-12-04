<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reqinfo.aspx.cs" Inherits="pcur_reqinfo" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Пошук заявок на виплату коштів</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>
<body bgcolor="#f0f0f0">
    <form id="formfindReq" runat="server" style="vertical-align: central">
        <asp:Panel ID="pnFilter" runat="server" GroupingText="Параметри пошуку заявки:" Style="margin-left: 10px; margin-right: 10px">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbReqId" runat="server" Text="ID заявки"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbReqlId" runat="server" MaxLength="38" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" MinValue="0"></Bars2:BarsNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRnk" runat="server" Text="РНК"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsNumericTextBox ID="tbRnk" runat="server" MaxLength="38" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator="" MinValue="0"></Bars2:BarsNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbCustCode" runat="server" Text="ІНН"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbInn" runat="server" MaxLength="14"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnFind" runat="server" ImageUrl="/common/images/default/16/find.png" Text="Пошук" OnClick="btFind_Click" Width="100%" ToolTip="Пошук заявки по введеним параметрам" BorderStyle="None"/>    
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnButtons" runat="server" GroupingText="Доступні дії:" Style="margin-left: 10px; margin-right: 10px">
            <bars:ImageTextButton ID="btNext" runat="server" ImageUrl="/common/images/default/16/gear_preferences.png" Text="Далі" OnClick="btNext_Click"/>
        </asp:Panel>
        <br />
        <BarsEX:BarsSqlDataSourceEx ID="odsFmDocs" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
        <div id="dvGridTitle" runat="server">
            <asp:Label ID="lbGvTitle" runat="server" Text="Заявки" Font-Size="Medium" Style="margin-left: 10px; margin-right: 10px"></asp:Label>
        </div>
        <BarsEX:BarsGridViewEx ID="gv" runat="server" PagerSettings-PageButtonCount="10"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            CssClass="barsGridView" DateMask="dd/MM/yyyy" DataKeyNames="ID"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            HoverRowCssClass="headerRow"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID заявки" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="RNK" HeaderText="РНК" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="FIO" HeaderText="ПІБ" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="INN" HeaderText="ІНН" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="DOC_TYPE_NAME" HeaderText="Документ" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="STATE_NAME" HeaderText="Стан" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="BDATE" HeaderText="Дата народження" ItemStyle-HorizontalAlign="Center" dataformatstring="{0:dd/MM/yyyy}"></asp:BoundField>
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
    </form>
</body>
</html>
