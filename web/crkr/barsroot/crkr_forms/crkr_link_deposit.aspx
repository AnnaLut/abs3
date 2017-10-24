<%@ Page Language="C#" AutoEventWireup="true" CodeFile="crkr_link_deposit.aspx.cs" Inherits="crkr_link_deposit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Потенційні вклади клієнта</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self"/>
</head>
<body>
<script>
    function myFunc(text) {
        alert(text);
    }
</script>
    <form id="formOperationList" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Потенційні вклади клієнта" />
        </div>
        <table>
            <tr>
                <td>
                    <asp:RadioButton runat="server" ID="rbPotential" Text="Потенційні претенденти" GroupName="rb" Checked="true" AutoPostBack="true" OnCheckedChanged="btRefresh_Click"/>
                    <asp:RadioButton runat="server" ID="rbAll" Text="Всі інші" GroupName="rb" AutoPostBack="true" OnCheckedChanged="btRefresh_Click"/>
                </td>
            </tr>
        </table>
        <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="ID" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            OnRowDataBound="gvMain_RowDataBound"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="Ід. рядка" />
                <asp:BoundField DataField="FIO" HeaderText="ПІБ" />
                 <asp:BoundField DataField="DOCSERIAL" HeaderText="Серія документу" />
                 <asp:BoundField DataField="DOCNUMBER" HeaderText="Номер документу" />
                 <asp:BoundField DataField="ICOD" HeaderText="ОКПО" />
                 <asp:BoundField DataField="KKNAME" HeaderText="Назва картотеки" />
                 <asp:BoundField DataField="NSC" HeaderText="Номер рахунку" />
                 <asp:BoundField DataField="LCV" HeaderText="Код валюти" />
                 <asp:BoundField DataField="DATO" HeaderText="Дата відкриття" />
                 <asp:BoundField DataField="SUM" HeaderText="Сума виплат" />
                 <asp:BoundField DataField="OST" HeaderText="Залишок" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
         <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <asp:Button runat="server" ID="btLink" Text="Прив'язати" OnClick="btLink_Click"/>

        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>