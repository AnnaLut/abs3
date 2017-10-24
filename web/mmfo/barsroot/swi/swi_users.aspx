<%@ Page Language="C#" AutoEventWireup="true" CodeFile="swi_users.aspx.cs" Inherits="swi_swi_users" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Вибір користувача</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>
<body>
    <form id="frm_users" runat="server">
    <div>
        
    </div>
           <br>
            Вибір користувача
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
                            <asp:BoundField DataField="FIO" HeaderText="ПІБ" />
                        </Columns>
                    </BarsEx:BarsGridViewEx>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                   <asp:Button runat="server" ID ="btRun" Text="Виконати" OnClick="btRun_Click"/>
                </td>
                <td>
                    <asp:Button runat="server" ID="btClose" Text="Закрити" OnClick="btClose_Click"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
