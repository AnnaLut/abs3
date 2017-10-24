<%@ Page Language="C#" AutoEventWireup="true" CodeFile="total_currency.aspx.cs" Inherits="customerlist_total_curr" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Підсумки по валютам</title>
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.js"></script>

    <script type="text/javascript">
        function ShowProgress() {
            var loading = $(".loading");
            loading.show();
            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
            loading.css({ top: top, left: left });
        }
    </script>

    <style type="text/css">
    .modalBackground
    {
        background-color:beige;
        filter: alpha(opacity=90);
        opacity: 0.7;
    }
    .modalPopup
    {
        background-color: #FFFFFF;
        border-width: 1px;
        border-style: solid;
        border-color: black;
        padding-top: 10px;
        padding-left: 10px;
        width: 300px;
        height: 140px;
    }
    .loading
    {
        display: none;
    }

</style>

</head>
<body>
    <form id="frm_total_currency" runat="server">
        <div style="margin: 10px 10px 40px 4px"><h2>Підсумки</h2></div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
            </asp:ScriptManager>
                       
            <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panel1" TargetControlID="btnShow"
                CancelControlID="btnClose" BackgroundCssClass="modalBackground">
            </cc1:ModalPopupExtender>
            <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup" align="center" style = "display:block">
                <div style="margin: 5px 15px 5px 5px">
                    <asp:Label ID="lblbankDate" runat="server" Text="Виберіть дату банківського дня"></asp:Label>
                </div>
                
                
                <asp:TextBox ID="txtDate" runat="server" ReadOnly="true"></asp:TextBox>
                <asp:ImageButton ID="imgPopup" ImageUrl="/Common/Images/calendar.png" ImageAlign="Bottom"
                    runat="server" />          

                <cc1:CalendarExtender ID="txtDateExtender" PopupButtonID="imgPopup" runat="server" TargetControlID="txtDate"
                    Format="dd.MM.yyyy">
                </cc1:CalendarExtender>
                
                <div style="margin: 30px 5px 5px 5px">
                    <asp:Button ID="btnGo" runat="server" Text="Продовжити" OnClientClick="ShowProgress()" OnClick="btnGo_Click" />
                    <asp:Button ID="btnClose" runat="server" Text="Відмінити" />                  
                </div>

                <div class="loading">
                    <img src="/Common/Images/loader.gif" alt="Завантаження..." />
                </div>

            </asp:Panel>

        </div>
        <asp:Panel runat="server" ID="pnGrid" GroupingText="">
            
            <div style="margin: 15px 15px 15px 3px">
                <asp:LinkButton ID="btnShow" runat="server">Вибрати іншу дату банківського дня</asp:LinkButton>
                <%--<asp:LinkButton ID="btnShow" runat="server" ToolTip="Вибрати іншу дату банківського дня" Width="45px">
                    <img src="/Common/Images/calendar_change.png" />
                </asp:LinkButton>--%>
            </div>

            <table>
                <tr>
                    <td><asp:Label ID="lblSelectedBankDate" runat="server" Text=""></asp:Label></td>       
                </tr>
                <tr>
                    <td style="vertical-align: top">
                        <BarsEx:BarsSqlDataSourceEx ID="dsMainTT" runat="server" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
                        <BarsEx:BarsGridViewEx  ID="gvMainTT" RefreshImageUrl="" runat="server" AllowPaging="True" AllowSorting="True" JavascriptSelectionType="None" DataKeyNames="LCV"
                            DataSourceID="dsMainTT" CssClass="barsGridView" ShowPageSizeBox="true"
                            AutoGenerateColumns="False" DateMask="dd/MM/yyyy"
                            OnRowDataBound="gvMainTT_RowDataBound" OnDataBound="gvMainTT_DataBound" OnPageIndexChanging="gvMainTT_PageIndexChanging" PageSize="20">
                            <Columns>
                                <asp:BoundField DataField="LCV" HeaderText="Валюта" SortExpression="LCV" />
                                <asp:BoundField DataField="ISDF" DataFormatString="{0:F2}" HeaderText="Вхідний залишок ДЕБЕТ" SortExpression="ISDF" />
                                <asp:BoundField DataField="ISKF" DataFormatString="{0:F2}" HeaderText="Вхідний залишок КРЕДИТ" SortExpression="ISKF" />
                                <asp:BoundField DataField="DOS" DataFormatString="{0:F2}" HeaderText="Дт. оборот" SortExpression="DOS" />
                                <asp:BoundField DataField="KOS" DataFormatString="{0:F2}" HeaderText="Кт. оборот" SortExpression="KOS" />
                                <asp:BoundField DataField="OSTCD" DataFormatString="{0:F2}" HeaderText="Вихідний залишок ДЕБЕТ" SortExpression="OSTCD" />
                                <asp:BoundField DataField="OSTCK" DataFormatString="{0:F2}" HeaderText="Вихідний залишок КРЕДИТ" SortExpression="OSTCK" />
                                <asp:BoundField DataField="RAT" DataFormatString="{0:F4}" HeaderText="Середньозважена ставка" SortExpression="RAT" />
                            </Columns>
                        </BarsEx:BarsGridViewEx>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
