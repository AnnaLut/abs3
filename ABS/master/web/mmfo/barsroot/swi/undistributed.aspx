<%@ Page Language="C#" AutoEventWireup="true" CodeFile="undistributed.aspx.cs" Inherits="swi_undistributed" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Перегляд необроблених і нерозібраних SWIFT повідомлень</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="frm_undistributed" runat="server">
    <div>
    </div>
        <br>Перегляд необроблених і нерозібраних SWIFT повідомлень
        </br>
        <hr />
        <table>
            <tr>
                <td>
                    <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                    <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
                        DataSourceID="dsMain" CssClass="barsGridView" ShowPageSizeBox="true"
                        AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="SingleRow" 
                        PagerSettings-PageIndex="0" 
                        PageSize="10">
                        <SelectedRowStyle CssClass="selectedRow" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="Ід.користувача" />
                            <asp:BoundField DataField="LOGNAME" HeaderText="Логін" />
                            <asp:BoundField DataField="FIO" HeaderText="ПІБ" />
                            <asp:BoundField DataField="CNT" HeaderText="Кількість" />
                        </Columns>
                    </BarsEx:BarsGridViewEx>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:Button runat="server" ID="btChange" Text="Перерозподілити" OnClick="btChange_Click"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
