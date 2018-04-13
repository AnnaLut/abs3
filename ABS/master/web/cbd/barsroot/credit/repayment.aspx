<%@ Page Language="C#" AutoEventWireup="true" CodeFile="repayment.aspx.cs" Inherits="credit_repayment"
    meta:resourcekey="PageResource1" Theme="default"%>

<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Погашення кредиту готівкою в т.ч. 2620</title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
        function ShowPayDialog(url) {
            ProgressMode(true);
            var rnd = Math.random();
            var result = window.showModalDialog(url + '&rnd=' + rnd, window, 'dialogHeight:600px; dialogWidth:600px');
            ProgressMode(false);

            window.location.replace('/barsroot/credit/repayment.aspx');
        }
        function ProgressMode(flag) {
            var val = (flag ? 'block' : 'none');
            document.getElementById('Progress').style.display = val;
        }
    </script>

    <script language="javascript" type="text/javascript" src="jscript/JScript.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Погашення кредиту готівкою в т.ч. 2620" meta:resourcekey="lbPageTitleResource1"></asp:Label>
    </div>
    <div style="padding: 10px 0px 10px 10px">
        <table border="0" cellpadding="5" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbCC_ID" runat="server" Text="№ договора : " meta:resourcekey="lbCC_IDResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxString ID="tbsCC_ID" runat="server" IsRequired="True" MaxLength="20"
                        meta:resourcekey="tbsCC_IDResource1" ValidationGroup="Search"></bec:TextBoxString>
                </td>
                <td>
                    <asp:Label ID="lbDAT1" runat="server" Text="Дата уклад. договору : " meta:resourcekey="lbDAT1Resource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDate ID="tbdDAT1" runat="server" IsRequired="True" MaxValue='<%# DateTime.Now.AddDays(2) %>'
                        ValidationGroup="Search"></bec:TextBoxDate>
                </td>
                <td>
                    <asp:ImageButton ID="ibSearch" runat="server" AlternateText="Искать" ImageUrl="/Common/Images/default/16/find.png"
                        ToolTip="Искать" OnClick="ibSearch_Click" meta:resourcekey="ibSearchResource1"
                        CausesValidation="true" ValidationGroup="Search" />
                </td>
                <td style="padding-left: 10px; font-style: italic">
                    <asp:Label ID="lbFIO" runat="server" Text='<%# rp.NMK %>'></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvEdits" runat="server" visible='<%# rp.HasData %>' style="padding: 10px 0px 10px 10px;
        border-top: solid 1px #94ABD9;">
        <table border="0" cellpadding="5" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbP" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbP, rp.NAMEV_SN8) %>'></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="tbdPeny" runat="server" IsRequired="True" Enabled='<%# rp.SP > 0 %>'
                        Value='<%# rp.SP %>' MaxValue='<%# rp.SP %>' meta:resourcekey="tbdPenyResource1"
                        ValidationGroup="Pay" OnValueChanged="tbdPeny_ValueChanged" CausesValidation="True">
                    </bec:TextBoxDecimal>
                </td>
                <td>
                    <asp:Label ID="lbE" runat="server" Visible='<%# rp.KV_SN8 != 980 %>' Text='<%# string.Format(Resources.credit.GlobalResource.lbE, "Гривня України", this.GetEquivalent(tbdPeny.Value, rp.KV_SN8).Value.ToString(this.sFormatingString)) %>'></asp:Label>
                </td>
            </tr>
            <tr id="tdCommision" runat="server" visible='<%# (rp.SK1 > 0 && (rp.KV != rp.KV_KOM || rp.KV_KOM != 980)) %>'>
                <td>
                    <asp:Label ID="lbSK" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbSK, rp.NAMEV_KOM) %>'></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="tbdCommission" runat="server" IsRequired="True" Enabled='<%# rp.SK1 > 0 && (tbdPeny.Value >= rp.SP || rp.nPayType == 0)%>'
                        Value='<%# (tbdPeny.Value < rp.SP && rp.nPayType == 1 ? 0 : (ddlPaymentType.SelectedValue == "0" ? rp.SK : rp.SK1)) %>' MaxValue='<%# rp.SK1 %>'
                        ValidationGroup="Pay" OnValueChanged="tbdCommission_ValueChanged" CausesValidation="True">
                    </bec:TextBoxDecimal>
                </td>
                <td>
                    <asp:Label ID="lbE1" runat="server" Visible='<%# rp.KV_KOM != 980 %>' Text='<%# string.Format(Resources.credit.GlobalResource.lbE, "Гривна України", this.GetEquivalent(tbdCommission.Value, rp.KV_KOM).Value.ToString(this.sFormatingString)) %>'></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbS" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbS, rp.NAMEV) %>'></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="tbdSumm" runat="server" MaxValue='<%# rp.S1 %>' IsRequired="True"
                        Value='<%# (((tbdPeny.Value < rp.SP || tbdCommission.Value < rp.SK) && rp.nPayType == 1) ? 0 : (ddlPaymentType.SelectedValue == "0" ? rp.S : rp.S1)) %>'
                        Enabled='<%# (tbdPeny.Value >= rp.SP && tbdCommission.Value >= rp.SK) || rp.nPayType == 0 %>'
                        meta:resourcekey="tbdSummResource1" ValidationGroup="Pay"></bec:TextBoxDecimal>
                </td>
                <td>
                    <asp:DropDownList ID="ddlPaymentType" runat="server" Width="150px" meta:resourcekey="ddlPaymentTypeResource1"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentType_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="0" meta:resourcekey="ListItemResource1">Текущий</asp:ListItem>
                        <asp:ListItem Value="1" meta:resourcekey="ListItemResource2">Остаточный</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btPay" meta:resourcekey="btPayResource1" Text="Оплатить" runat="server"
                        OnClick="btPay_Click" OnClientClick="if (!confirm('Произвести оплату?')) return false;"
                        CausesValidation="true" ValidationGroup="Pay" />
                </td>
            </tr>
        </table>
    </div>
    <div id="dvLabels" runat="server" visible='<%# rp.HasData %>' style="padding: 20px 0px 10px 10px;
        border-top: solid 1px #94ABD9;">
        <asp:Label ID="lbPeny" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbPeny, rp.NAMEV, (rp.SP.HasValue ? rp.SP.Value.ToString(this.sFormatingString) : "") ) %>'></asp:Label>
        <br />
        <asp:Label ID="lbBody" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbBody, rp.NAMEV, (ddlPaymentType.SelectedValue == "0" ? (rp.SS.HasValue ? rp.SS.Value.ToString(this.sFormatingString) : "") : (rp.SS1.HasValue ? rp.SS1.Value.ToString(this.sFormatingString) : "")), (rp.SSP.HasValue ? rp.SSP.Value.ToString(this.sFormatingString) : "0.00")) %>'></asp:Label>
        <br />
        <asp:Label ID="lbPercents" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbPercents, rp.NAMEV, (ddlPaymentType.SelectedValue == "0" ? (rp.SN.HasValue ? rp.SN.Value.ToString(this.sFormatingString) : "") : (rp.SN1.HasValue ? rp.SN1.Value.ToString(this.sFormatingString) : "")), (rp.SSPN.HasValue ? rp.SSPN.Value.ToString(this.sFormatingString) : "0.00")) %>'></asp:Label>
        <br />
        <asp:Label ID="lbCommission" runat="server" Text='<%# string.Format(Resources.credit.GlobalResource.lbCommission, rp.NAMEV_KOM, (ddlPaymentType.SelectedValue == "0" ? (rp.SK.HasValue ? rp.SK.Value.ToString(this.sFormatingString) : "") : (rp.SK1.HasValue ? rp.SK1.Value.ToString(this.sFormatingString) : "")), (rp.SSPK.HasValue ? rp.SSPK.Value.ToString(this.sFormatingString) : "0.00")) %>'></asp:Label>
    </div>
    <div id="Progress" style="display: none">
        <bec:loading ID="lProgress" runat="server" />
    </div>
    <div id="dvAddInfo" visible='<%# rp.HasData %>' runat="server" style="padding: 20px 0px 10px 10px;
        border-top: solid 1px #94ABD9;">
        <%# rp.sAddInfo%>
    </div>
    </form>
</body>
</html>
