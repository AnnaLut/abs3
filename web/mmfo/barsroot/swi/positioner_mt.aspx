<%@ Page Language="C#" AutoEventWireup="true" CodeFile="positioner_mt.aspx.cs" Inherits="swi_positioner_mt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Формування повідомлення з покриттям</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self" />
    <style type="text/css">
        .hand {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="frmGenerateMT" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div>
            <asp:Panel runat="server" ID="pnMT103" GroupingText="Вихідне повідомлення(МТ103)">
                <table>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lbSenderBicN103" Text="Відправник" ForeColor="Green"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbSenderBic103" ForeColor="#003399"></asp:Label>

                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbSenderName103" ForeColor="#003399"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lbReciverBicN" Text="Отримувач" ForeColor="Green"></asp:Label>
                        </td>
                        <td>
                            <bec:TextBoxRefer ID="refReciverBic103" runat="server" TAB_NAME="SW_BANKS"
                                KEY_FIELD="BIC" SEMANTIC_FIELD="NAME" IsRequired="false"
                                OnValueChanged="refReciverBic103_ValueChanged" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="tbReciverName103" runat="server" ReadOnly="true" Rows="3" Width="230"/>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnMT202" GroupingText="Повідомлення покриття (МТ202)">
                <table>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lbSnederBicN202" Text="Відправник" ForeColor="Green"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbSenderBic202" ForeColor="#003399"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbSenderName202" ForeColor="#003399"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label runat="server" ID="lbReciverBicN202" Text="Отримувач" ForeColor="Green"></asp:Label>
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbReciverBic202" ForeColor="#003399"></asp:Label>
                            <bec:TextBoxRefer ID="refReciverBic202" runat="server" TAB_NAME="SW_BANKS"
                                KEY_FIELD="BIC" SEMANTIC_FIELD="NAME" IsRequired="false"
                                OnValueChanged="refReciverBic202_ValueChanged" />
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lbReciverName202" ForeColor="#003399"></asp:Label>
                            <bec:TextBoxString ID="tbReciverName202" runat="server" ReadOnly="true" Rows="3" Width="230"/>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table style="width: 100%">
                <tr>
                    <td style="text-align: left">
                        <asp:Button runat="server" ID="btPay" Text="Сформувати" OnClick="btPay_Click" />
                    </td>
<%--                    <td style="text-align: left">
                        <asp:Button runat="server" ID="btClose" Text="Закрити" OnClick="btClose_Click" />
                    </td>--%>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
