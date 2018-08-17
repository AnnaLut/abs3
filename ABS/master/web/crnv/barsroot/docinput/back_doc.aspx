<%@ Page Language="C#" AutoEventWireup="true" CodeFile="back_doc.aspx.cs" Inherits="sberutls_back_doc" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title title="Виконання сторнування незавізованих операцій виплати"></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <style type="text/css">
        .title {
            border-bottom-color: #CCD7ED;
            border-bottom: 1px solid;
            margin-bottom: 20px;
            font-size: 12pt;
            color: #1C4B75;
        }

        #lblRes {
            width: 300px;
        }

        #lblRes0 {
            width: 300px;
        }

        #lblResOk {
            width: 340px;
        }

        #lblResBad {
            width: 314px;
        }
        .auto-style1 {
            width: 144px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
        <div>
            <table>
                <tr>
                    <td>
                        <br>Виконання сторнування незавізованих операцій виплати
                        </br>
                    </td>
                </tr>
            </table>
        </div>
        <div>

            <hr />


            <table>
                <tr>
                    </br>
                         <tr>
                             <td class="auto-style1">
                                  <asp:Label ID="Refdoc" runat="server" Text="Референс документу : "></asp:Label>
                             </td>
                             <td>
                                  <bec:TextBoxNumb ID="REFBACK" runat="server" IsRequired="true" />
                             </td>
                             <td>     
                                  <asp:Button ID="btnLoad" runat="server" Text="Пошук"
                                   OnClick ="btnLoad_Click" />
                             </td>
                             <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbRef" runat="server" Font-Size="Medium"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:HyperLink ID="LinREF" runat="server" Target="_blank" Font-Size="Medium">[LinREF]</asp:HyperLink>  
                                            <bec:TextBoxNumb ID="hideREF" runat="server" Visible="false"/>   
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                </tr>
                <tr>
                    <td class="auto-style1">
                        &nbsp;</td>

                </tr>
            </table>
            <hr />
			 <table>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btBack" Text="Сторнувати" OnClick="btBack_Click"  OnClientClick="if (!confirm('Виконати сторно?')) return false;"
                              ToolTip="Виконати сторно" Width="100Px"/>
                    </td>
                </tr>
            </table>
            <hr />
        </div>
    </form>
</body>
</html>
