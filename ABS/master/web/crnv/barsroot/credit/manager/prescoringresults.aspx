<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="prescoringresults.aspx.cs" Inherits="credit_manager_prescoringresults"
    Title="Результаты предварительного скоринга по заявке №{0}" Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbKPP" runat="server" Text="Коефіцієнт платоспроможності позичальника (Кпп)"
                        meta:resourcekey="lbKPPResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="KPP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbKPS" runat="server" Text="Коефіцієнт платоспроможності сімї позичальника (Кпс)"
                        meta:resourcekey="lbKPSResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="KPS" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbCHP" runat="server" Text="Частка погашення кредиту в чистому сукупному доході позичальника (Чп)"
                        meta:resourcekey="lbCHPResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="CHP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbCR" runat="server" Text="Значення кредитного ризику" meta:resourcekey="lbCRResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="CR" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbCRISK_OBU" runat="server" Text="Внутрішній кредитний рейтинг" meta:resourcekey="lbCRISK_OBUResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxString ID="CRISK_OBU" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbCRISK_NBU" runat="server" Text="Клас Позичальника (відповідно до класифікації НБУ)"
                        meta:resourcekey="lbCRISK_NBUResource1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxString ID="CRISK_NBU" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center" style="padding-top: 10px">
                    <asp:Button ID="bOk" SkinID="bPrev" runat="server" OnClientClick="history.back(); return false;"
                        meta:resourcekey="bOkResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
