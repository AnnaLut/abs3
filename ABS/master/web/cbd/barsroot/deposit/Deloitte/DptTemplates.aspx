<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptTemplates.aspx.cs" Inherits="deposit_DptTemplates" %>

<%@ Register Src="~/UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="ead" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Шаблони для друку</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="DptTemplates" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="True">
            </asp:ScriptManager>
            <table class="MainTable">
                <tr>
                    <td align="center" colspan="2">
                        <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Шаблони для друку" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <table class="barsGridView">
                            <thead class="captionHeader">
                                <tr>
                                    <td align="center" style="width: 80%">Назва шаблону</td>
                                    <td align="center" style="width: 20%">Друк шаблону</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td align="left" style="width: 80%">
                                        <asp:Label ID="lbRow1_NAME" runat="server" Text="&nbsp; Виписка" CssClass="InfoText" />
                                    </td>
                                    <td align="left" style="width: 20%">
                                        <asp:ImageButton ID="btnRow1_PRINT" runat="server" AlternateText="Друкувати"
                                            ImageUrl="/Common/Images/default/24/printer.png" OnClick="btnPrintTemplates_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 60%">
                                        <asp:Label ID="lbRow3_NAME" runat="server" Text="&nbsp; Довідка про стан рахунку" CssClass="InfoText" />
                                    </td>
                                    <td align="left" style="width: 15%">
                                        <ead:EADoc ID="eadAccountStatus" runat="server" TitleText=" " EAStructID="333"
                                            OnBeforePrint="eadAccountStatus_BeforePrint" SignText="Отримано/підписано" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td align="center" style="width: 50%"></td>
                    <td align="center" style="width: 50%">
                        <asp:Button ID="btnBack" meta:resourcekey="btnBack" runat="server" Text="Назад"
                            CssClass="AcceptButton" OnClick="btnBack_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
