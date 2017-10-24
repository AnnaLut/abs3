<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reconsilation_tt.aspx.cs" Inherits="swi_reconsilation_tt" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Доступні операції</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>
<body>
    <form id="frm_reconsilation_tt" runat="server">
    <div>
    
    </div>
         <asp:Panel runat="server" ID="pnGrid" GroupingText="Операції">
            <table>
                <tr>
            <td style="vertical-align:top">
                <BarsEx:BarsSqlDataSourceEx ID="dsMainTT" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                <BarsEx:BarsGridViewEx ID="gvMainTT" runat="server" AllowPaging="True" AllowSorting="True" DataKeyNames="TT"
                    DataSourceID="dsMainTT" CssClass="barsGridView" ShowPageSizeBox="true"
                    AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="SingleRow"
                    OnRowDataBound="gvMainTT_RowDataBound"
                    PagerSettings-PageIndex="0"
                    PageSize="10">
                    <SelectedRowStyle CssClass="selectedRow" />
                      <Columns>
                          <asp:BoundField DataField="TT" HeaderText="Код операції" />
                          <asp:BoundField DataField="NAME" HeaderText="Назва операції" />
                        </Columns>
                </BarsEx:BarsGridViewEx>
            </td>
           </tr>  
            <tr>
            <td>
                <asp:Button runat="server" ID="btCreate" Text="Створити" OnClick="btCreate_Click"/>
                <asp:Button runat="server" ID="btClose" Text="Закрити" OnClick="btClose_Click" />
             </td>
            </tr>
       
       </table>
        </asp:Panel>
    </form>
</body>
</html>
