<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reconsilation_link_swt.aspx.cs" Inherits="swi_reconsilation_link_swt" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Довідник повідомлень</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>

<body>
    <form id="frm_linkSwt" runat="server">
    <div>
        <asp:Panel runat="server" ID="pnGrid" GroupingText="Повідомлення">
            <table>
                <tr>
            <td style="vertical-align:top">
                <BarsEx:BarsSqlDataSourceEx ID="dsMainDoc" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                <BarsEx:BarsGridViewEx ID="gvMainDoc" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="SWREF"
                    DataSourceID="dsMainDoc" CssClass="barsGridView" ShowPageSizeBox="true"
                    AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="SingleRow"
                    OnRowDataBound="gvMainDoc_RowDataBound"
                    PagerSettings-PageIndex="0"
                    PageSize="10">
                    <SelectedRowStyle CssClass="selectedRow" />
                      <Columns>
                          <asp:BoundField DataField="SWREF" HeaderText="Номер повідомлення(SWREF)" />
                          <asp:BoundField DataField="MT" HeaderText="MT" />
                          <asp:BoundField DataField="TRN" HeaderText="Референс SWIFT(TRN)" />
                          <asp:BoundField DataField="SENDER" HeaderText="Відправник" />
                          <asp:BoundField DataField="RECEIVER" HeaderText="Отримувач" />
                          <asp:BoundField DataField="AMOUNT" HeaderText="Сума" />
                          <asp:BoundField DataField="VDATE" HeaderText="Дата валютування" />
                        </Columns>
                </BarsEx:BarsGridViewEx>
            </td>
           </tr>  
            <tr>
            <td>
                <asp:Button runat="server" ID="btLink" Text="Обробити" OnClick="btLink_Click"/>
                <asp:Button runat="server" ID="btClose" Text="Закрити" OnClick="btClose_Click" />
             </td>
            </tr>
       
       </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
