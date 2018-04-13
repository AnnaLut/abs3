<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rep_query.aspx.cs" Inherits="cbirep_rep_query"
    Theme="default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Заявка на формування звіту - № {0} ({1})</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <ajx:ToolkitScriptManager ID="sm" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </ajx:ToolkitScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Заявка на формування звіту - № {0} ({1})"></asp:Label>
    </div>
    <div>
        <table border="0" cellpadding="3" cellspacing="0" style="width: 99%">
            <tr>
                <td>
                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри звіту">
                        <asp:Repeater ID="rParams" runat="server" OnItemDataBound="rParams_ItemDataBound">
                            <HeaderTemplate>
                                <table border="0" cellpadding="3" cellspacing="0">
                            </HeaderTemplate>
                            <SeparatorTemplate>
                                </tr>
                                <tr>
                            </SeparatorTemplate>
                            <ItemTemplate>
                                <td>
                                    <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                                </td>
                                <td>
                                    <asp:PlaceHolder ID="phControl" runat="server"></asp:PlaceHolder>
                                </td>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table>
                            </FooterTemplate>
                        </asp:Repeater>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Button ID="btBack" runat="server" Text="Повернутися" ToolTip="Повернутися до списку звітів"
                        OnClick="btBack_Click" CausesValidation="false" />
                    <asp:Button ID="btSend" runat="server" Text="Відправити" ToolTip="Відправити заявку на друк звіту"
                        OnClick="btSend_Click" ValidationGroup="ReportParams" CausesValidation="true" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
