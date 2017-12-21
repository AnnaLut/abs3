<%@ Page Language="C#" AutoEventWireup="true" CodeFile="export_docs.aspx.cs" Inherits="corp2_export_docs" %>

<!DOCTYPE html>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Друк документів по валютним платежам</title>
    <link href="/Common/CSS/BarsGridView.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/jquery/jquery.1.8.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/jquery/custom.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/barsroot/cim/style/cim.css?v1.1" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
    <script type="text/javascript" src="/Common/jquery/jquery.ui.datepicker-uk.js"></script>
    <script type="text/javascript" src="script/export_docs.js"></script>
</head>
<body>
    <form id="formExportCorp2Docs" runat="server">
        <ajax:ToolkitScriptManager ID="MainScriptManager" runat="server" AllowCustomErrorsRedirect="false"
            OnAsyncPostBackError="MainScriptManager_AsyncPostBackError" EnablePartialRendering="true"
            EnablePageMethods="true">
            <Services>
            </Services>
        </ajax:ToolkitScriptManager>
        <div id="divTitle" runat="server">
            <asp:Label CssClass="titleLabel" ID="lbPageTitle" runat="server">Друк документів по документами в іноземній валюті, що надійшли засобами СДО</asp:Label>
        </div>
        <table>
            <tr>
                <td colspan="2">
                    <asp:Panel runat="server" ID="pnInterval" GroupingText="Інтервал">
                        <table>
                            <tr>
                                <td>&nbsp;з&nbsp;</td>
                                <td class="nw">
                                    <asp:TextBox runat="server" ID="tbStartDate" Width="80px" CssClass="ctrl-date" MaxLength="10"></asp:TextBox></td>
                                <td>&nbsp;по&nbsp;
                                </td>
                                <td class="nw">
                                    <asp:TextBox runat="server" ID="tbFinishDate" Width="80px" CssClass="ctrl-date" MaxLength="10"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>Референс:</td>
                <td>
                    <asp:TextBox id="tbRef" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                        ControlToValidate="tbRef" runat="server"
                        ErrorMessage="Дозволяються тільки цифри"
                        ValidationExpression="\d+">
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>Валюта:</td>
                <td>
                    <asp:TextBox id="tbKv" runat="server" Width="40px" MaxLength="3"></asp:TextBox>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                        ControlToValidate="tbKv" runat="server"
                        ErrorMessage="Дозволяються тільки цифри"
                        ValidationExpression="\d+">
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>Користувач(id):</td>
                <td>
                    <asp:TextBox id="tbUserId" runat="server"></asp:TextBox>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator3"
                        ControlToValidate="tbUserId" runat="server"
                        ErrorMessage="Дозволяються тільки цифри"
                        ValidationExpression="\d+">
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>Рахунок:</td>
                <td>
                    <asp:TextBox id="tbNls" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="text-align:right">
                    <asp:Button ID="btExport" runat="server" OnClick="btExport_Click" Text="Сформувати" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label runat="server" ID="lbInfo"></asp:Label></td>
            </tr>
        </table>
    </form>
</body>
</html>
