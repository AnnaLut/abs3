<%@ Page Language="C#" AutoEventWireup="true" CodeFile="codetype.aspx.cs" Inherits="finmon_codetype" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Код виду фінансової операції</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    var vCloseValue = new Object();
    vCloseValue.code = getUrlVars()["code"];
    window.returnValue = vCloseValue;

    function getUrlVars() {
        var vars = {};
        var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (m, key, value) {
            vars[key] = value;
        });
        return vars;
    }

    function Close(code) {
        var vReturnValue = new Object();
        vReturnValue.code = code;
        window.returnValue = vReturnValue;
        window.close();
    }

    function OpenK_dfm01(type, ref) {
        if (ref == "a") {
            var option = "center:{yes};dialogheight:600px;dialogwidth:555px;resizable:1;status:no";
        }
        if (ref == "b") {
            var option = "center:{yes};dialogheight:600px;dialogwidth:900px;resizable:1;status:no";
        }
        if (ref == "c") {
            var option = "center:{yes};dialogheight:600px;dialogwidth:550px;resizable:1;status:no";
        }
        if (ref == "d") {
            var option = "center:{yes};dialogheight:600px;dialogwidth:800px;resizable:1;status:no";
        }
        if (ref == "e") {
            var option = "center:{yes};dialogheight:600px;dialogwidth:500px;resizable:1;status:no";
        }
        var K_Dfm01Return = window.showModalDialog('/barsroot/finmon/refkdfm01' + ref + '.aspx', window, option);

        if (K_Dfm01Return.code != -1) {
            if (ref == "a") {
                if (type == "provided") {
                    document.getElementById('<%=tbClaclProvidedCode.ClientID%>').value = K_Dfm01Return.code;
                }
                if (type == "received") {
                    document.getElementById('<%=tbClaclReceivCode.ClientID%>').value = K_Dfm01Return.code;
                }
            }
            if (ref == "b") {
                if (type == "provided") {
                    document.getElementById('<%=tbAssetProvidedCode.ClientID%>').value = K_Dfm01Return.code;
                }
                if (type == "received") {
                    document.getElementById('<%=tbAssetReceivCode.ClientID%>').value = K_Dfm01Return.code;
                }
            }
            if (ref == "c") {
                if (type == "provided") {
                    document.getElementById('<%=tbLocationProvided.ClientID%>').value = K_Dfm01Return.code;
                }
                if (type == "received") {
                    document.getElementById('<%=tbLocationReceiv.ClientID%>').value = K_Dfm01Return.code;
                }
            }
            if (ref == "d") {
                if (type == "provided") {
                    document.getElementById('<%=tbObjectProvided.ClientID%>').value = K_Dfm01Return.code;
                }
                if (type == "received") {
                    document.getElementById('<%=tbObjectReceiv.ClientID%>').value = K_Dfm01Return.code;
                }
            }
            if (ref == "e") {
                document.getElementById('<%=tbNls.ClientID%>').value = K_Dfm01Return.code;

            }
        }
    }
</script>
<body bgcolor="#f0f0f0">
    <form id="formFinMonFilter" runat="server">
        <p></p>
        <b></b>
        <div>
            <asp:Label ID="lbCpode" runat="server" Text="Код виду фінансової операції"></asp:Label>
            <Bars2:BarsTextBox ID="tbCode" runat="server" Enabled="false" Width="310px"></Bars2:BarsTextBox>
        </div>
        <asp:Panel ID="pnCalculationForm" runat="server" GroupingText="Форма розрахунку:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbClaclProvided" runat="server" Text="що надається"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbClaclProvidedCode" MaxLength="1" runat="server" Width="50px" OnTextChanged="tbClaclProvidedCode_TextChanged" AutoPostBack="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbClaclProvidedName" Enabled="false" runat="server" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibClaclProvidedCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('provided','a')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbClaclReceiv" runat="server" Text="що отримується"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbClaclReceivCode" MaxLength="1" runat="server" Width="50px" OnTextChanged="tbClaclReceivCode_TextChanged" AutoPostBack="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbClaclReceivName" runat="server" Enabled="false" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibClaclReceivCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('received','a')" />
                    </td>
                </tr>
            </table>
        </asp:Panel>

        <asp:Panel ID="pnAsset" runat="server" GroupingText="Вид активу:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbAssetProvided" runat="server" Text="що надається"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbAssetProvidedCode" MaxLength="1" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbAssetProvidedCode_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbAssetProvidedName" Enabled="false" runat="server" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibAssetProvidedCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('provided','b')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbAssetReceiv" runat="server" Text="що отримується"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbAssetReceivCode" MaxLength="1" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbAssetReceivName_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbAssetReceivName" runat="server" Enabled="false" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibAssetReceivCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('received','b')" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnLocation" runat="server" GroupingText="Місцезнаходження об`єкта:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbLocationProvided" runat="server" Text="що надається"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbLocationProvided" MaxLength="1" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbLocationProvided_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbLocationNameProvided" Enabled="false" runat="server" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibLocationProvided" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('provided','c')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbLocationReceiv" runat="server" Text="що отримується"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbLocationReceiv" MaxLength="1" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbLocationReceiv_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbLocationNameReceiv" runat="server" Enabled="false" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="inLocationReceiv" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('received','c')" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnObject" runat="server" GroupingText="Об`єкт операції:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbObjectProvided" runat="server" Text="що надається"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbObjectProvided" MaxLength="4" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbObjectProvided_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbObjectNameProvided" Enabled="false" runat="server" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibObjectProvided" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('provided','d')" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbObjectReceiv" runat="server" Text="що отримується"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbObjectReceiv" MaxLength="4" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbObjectReceiv_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbObjectNameReceiv" runat="server" Enabled="false" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibObjectReceiv" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('received','d')" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnNls" runat="server" GroupingText="Відкриття або закриття рахунку:">
            <table>
                <tr>
                    <td style="width: 155px" align="right">
                        <Bars2:BarsTextBox ID="tbNls" MaxLength="1" runat="server" Width="50px" AutoPostBack="true" OnTextChanged="tbNls_TextChanged"></Bars2:BarsTextBox>
                    </td>
                    <td align="right" style="width: 315px">
                        <Bars2:BarsTextBox ID="tbNlsName" Enabled="false" runat="server" Width="310px"></Bars2:BarsTextBox>
                    </td>
                    <td align="left" style="width: 30px">
                        <bars:ImageTextButton ID="ibNls" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenK_dfm01('received','e')" />
                    </td>
                </tr>

            </table>
        </asp:Panel>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
        <table width="100%">
            <tr>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="btOK" runat="server" Text="Зберегти" ImageUrl="/common/images/default/16/ok.png" OnClick="btOK_Click" />
                </td>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="btCancel" runat="server" Text="Відмінити" ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
