<%@ Page Language="C#" AutoEventWireup="true" CodeFile="stmt950.aspx.cs" Inherits="swi_stmt950" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Формування виписок MT950</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="frm_stmt950" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Формування виписок MT950" />
        </div>
        <asp:Panel runat="server" ID="pnSearh" GroupingText="Пошук">
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbSearh" Text="РНК"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxNumb runat="server" ID="tbRnk"/>
                    </td>
                    <td>
                        <asp:Button  runat="server" id="btSearh" Text="Пошук" OnClick="btSearh_Click"/>
                    </td>
                    
                    
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnRun" runat="server" GroupingText="Параметри формування">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbDat1" runat="server" Text="Дата З"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate ID="tbDat1" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lbDat2" runat="server" Text="Дата По"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate ID="tbDat2" runat="server" />
                    </td>
                    <td style="">
                        <asp:Button id="btRun" runat="server" Text="Формування" OnClick="btRun_Click"/>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <hr />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="RNK,BIC,STMT" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="10">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="РНК" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlRNK" runat="server" Target="_self" NavigateUrl='<%#String.Format("/barsroot/clientregister/registration.aspx?rnk={0}&readonly=1",Eval("RNK")) %>'>
                            <asp:Label ID="lbRNK" runat="server" Text='<%#String.Format("{0}",Eval("RNK")) %>'></asp:Label>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="NMK" HeaderText="Назва" />
                <asp:BoundField DataField="BIC" HeaderText="BIC-код" HeaderStyle-HorizontalAlign="Center" />
                <asp:BoundField DataField="STMT" HeaderText="Код виписки" />
                <asp:BoundField DataField="NAME" HeaderText="Назва виписки" />

            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
