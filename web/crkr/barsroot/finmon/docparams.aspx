<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docparams.aspx.cs" Inherits="finmon_docparams" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Параметри фінансового моніторингу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    window.onunload = Close;
    function Close() {
        var vReturnValue = new Object();
        vReturnValue.close = "ok";
        window.returnValue = vReturnValue;
    }

    function OpenKdfm02() {

        var dialogRefKdfm02Return = window.showModalDialog('/barsroot/finmon/refkdfm02.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');;

        if (dialogRefKdfm02Return.code != -1) {
            document.getElementById('<%=tbKDFM02.ClientID%>').value = dialogRefKdfm02Return.code;
        }
    }

    function OpenKdfm03() {

        var dialogRefKdfm03Return = window.showModalDialog('/barsroot/finmon/refkdfm03.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:780px');;

        if (dialogRefKdfm03Return.code != -1) {
            document.getElementById('<%=tbKDFM03.ClientID%>').value = dialogRefKdfm03Return.code;
        }
    }

    function OpenRefCustA() {

        var dialogRefCustAReturn = window.showModalDialog('/barsroot/finmon/refcustomers.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:700px');;

        if (dialogRefCustAReturn.rnk != -1) {
            document.getElementById('<%=tbDailyOKPOA.ClientID%>').value = dialogRefCustAReturn.okpo;
            document.getElementById('<%=tbDailyRNKA.ClientID%>').value = dialogRefCustAReturn.rnk;
            document.getElementById('<%=tbDailyNMKA.ClientID%>').value = dialogRefCustAReturn.nmk;
        }
    }

    function OpenRefCustB() {

        var dialogRefCustBReturn = window.showModalDialog('/barsroot/finmon/refcustomers.aspx', window, 'center:{yes};dialogheight:650px;dialogwidth:700px');;

        if (dialogRefCustBReturn.rnk != -1) {
            document.getElementById('<%=tbDailyOKPOB.ClientID%>').value = dialogRefCustBReturn.okpo;
            document.getElementById('<%=tbDailyRNKB.ClientID%>').value = dialogRefCustBReturn.rnk;
            document.getElementById('<%=tbDailyNMKB.ClientID%>').value = dialogRefCustBReturn.nmk;
        }
    }

    function OpenCodeType() {

        var code = document.getElementById('<%=tbCode.ClientID%>').value;

        if (code.length != 15) {
            alert('Довжина коду виду фінансової операції має бути довжиною 15символів');
        }
        else {
            var dialogCodeTypeReturn = window.showModalDialog('/barsroot/finmon/codetype.aspx?code=' + code, window, 'center:{yes};dialogheight:600px;dialogwidth:550px');;

            if (dialogCodeTypeReturn.code != null) {
                document.getElementById('<%=tbCode.ClientID%>').value = dialogCodeTypeReturn.code;
            }
        }
    }
</script>
<body bgcolor="#f0f0f0">
    <form id="formFinMonFilter" runat="server">

        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Параметри фінансового моніторингу"></asp:Label>
        </div>
        <asp:Panel ID="pnInfo" runat="server" GroupingText="Інформація:">
            <table>
                <tr align="left">
                    <td>
                        <Bars2:BarsTextBox ID="tbMfoA" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbNLSA" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td colspan="2">
                        <Bars2:BarsTextBox ID="tbNameNLSA" runat="server" ReadOnly="true" Width="310px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <Bars2:BarsTextBox ID="tbMfoB" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbNLSB" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td colspan="2">
                        <Bars2:BarsTextBox ID="tbNameNLSB" runat="server" ReadOnly="true" Width="310px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr align="left">
                    <td>
                        <Bars2:BarsTextBox ID="tbDocDat" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbSum" runat="server" ReadOnly="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbVal" runat="server" ReadOnly="true" Width="20px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbNazn" runat="server" ReadOnly="true" Width="278px"></Bars2:BarsTextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnCharacter" runat="server" GroupingText="Ознака повідомлень:">
            <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbCompulsoryMon" runat="server" OnCheckedChanged="cbCompulsoryMon_CheckedChanged" AutoPostBack="true"/>
                    </td>
                    <td style="width: 160px">
                        <asp:Label ID="lbCompulsoryMon" runat="server" Text="Обов'язковий моніторинг"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM02" runat="server" MaxLength="4" Width="40px" EnabledStyle-HorizontalAlign="Center" OnTextChanged="tbKDFM02_TextChanged" AutoPostBack="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM02_Name" runat="server" Text="не заповнено (вн.моніторинг)" ReadOnly="true" Width="320px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibKDFM02" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenKdfm02()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSideA" runat="server" Text="Сторона А" AutoPostBack="true" OnCheckedChanged="rbSideA_CheckedChanged" />
                    </td>
                    <td colspan="3">
                        <Bars2:BarsTextBox ID="tbPlus" runat="server" Width="400px"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy2" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSideB" runat="server" Text="Сторона B" AutoPostBack="true" OnCheckedChanged="rbSideB_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="cbInternalMob" runat="server" OnCheckedChanged="cbInternalMob_CheckedChanged" AutoPostBack="true" />
                    </td>
                    <td>
                        <asp:Label ID="lbInternalMob" runat="server" Text="Внутрішній моніторинг"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM03" runat="server" MaxLength="3" Width="40px" EnabledStyle-HorizontalAlign="Center" Enabled="false" OnTextChanged="tbKDFM03_TextChanged" AutoPostBack="true"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbKDFM03Name" runat="server" ReadOnly="true" Text="не заповнено (вн.моніторинг)" Width="320px" Enabled="false"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibKDFM03" runat="server" ImageUrl="/common/images/default/16/find.png" Enabled="false" OnClientClick="OpenKdfm03()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy3" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSideA2" runat="server" Text="Сторона А" AutoPostBack="true" OnCheckedChanged="rbSideA2_CheckedChanged" />
                    </td>
                    <td colspan="3">
                        <Bars2:BarsTextBox ID="tbPlus2" runat="server" Width="400px" Enabled="false"></Bars2:BarsTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy4" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbSideB2" runat="server" Text="Сторона B" AutoPostBack="true" OnCheckedChanged="rbSideB2_CheckedChanged" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnDailyMon" runat="server" GroupingText="Режим моніторінгу клієнтів:">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy5" runat="server"></asp:Label>
                    </td>
                    <td style="width: 180px">
                        <asp:RadioButton ID="rbDailySideA" runat="server" Text="Сторона A" AutoPostBack="true" OnCheckedChanged="rbDailySideA_CheckedChanged" />
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyOKPOA" runat="server" Enabled="false" EnabledStyle-BackColor="White" Width="60px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyRNKA" runat="server" Enabled="false" EnabledStyle-BackColor="White" Width="50px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyNMKA" runat="server" Enabled="false" EnabledStyle-BackColor="White" Width="240px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibtDailySideA" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenRefCustA()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy6" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbDailySideB" runat="server" Text="Сторона B" AutoPostBack="true" OnCheckedChanged="rbDailySideB_CheckedChanged" />
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyOKPOB" runat="server" EnabledStyle-BackColor="White" Enabled="false" Width="60px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyRNKB" runat="server" EnabledStyle-BackColor="White" Enabled="false" Width="50px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbDailyNMKB" runat="server" EnabledStyle-BackColor="White" Enabled="false" Width="240px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="ibtDailySideB" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenRefCustB()" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDummy7" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton ID="rbDailyBouth" runat="server" Text="Обидва" AutoPostBack="true" OnCheckedChanged="rbDailyBouth_CheckedChanged" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table>
            <tr align="left">
                <td style="width: 180px">
                    <asp:Label ID="lbCode" runat="server" Text="Код виду фінансової операції" Width="188px"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsTextBox ID="tbCode" runat="server" EnabledStyle-HorizontalAlign="Center" MaxLength="15" Width="370px" Enabled="false"></Bars2:BarsTextBox>
                </td>
                <td>
                    <bars:ImageTextButton ID="ibtCode" runat="server" ImageUrl="/common/images/default/16/find.png" OnClientClick="OpenCodeType()" />
                </td>
            </tr>
        </table>

        <p></p>
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
