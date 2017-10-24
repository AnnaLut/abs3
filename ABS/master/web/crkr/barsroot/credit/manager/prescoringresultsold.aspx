<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="prescoringresultsold.aspx.cs" Inherits="credit_manager_prescoringresults"
    Title="Результаты предварительного скоринга по заявке №{0}" Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="1" cellpadding="3" cellspacing="0">
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
                    <asp:Label ID="lbCHP" runat="server" Text="Частка погашення кредиту в чистому сукупному доході позичальника (Чп)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="CHP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbCHPS" runat="server" Text="Частка погашення кредиту в чистому сукупному доході позичальника (Чп)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="CHPS" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDP" runat="server" Text="Наявність джерел погашення кредиту (Дп)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="DP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbP4DP" runat="server" Text="Показник сукуного чистого доходу Позичальника(Пчдп)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="P4DP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbP4DS" runat="server" Text="Показник сукуного чистого доходу сім`ї Позичальника(Пчдс)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="P4DS" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbRB" runat="server" Text="Накопичення на рахунках у банку"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="RB" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbVN" runat="server" Text="Наявність власної нерухомості (Вн)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="VN" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbPR" runat="server" Text="Наявність постійної роботи (Пр)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="PR" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbZS" runat="server" Text="Загальний стаж роботи (Зс)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="ZS" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbSM" runat="server" Text="Сімейний стан та місце проживання (См)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="SM" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbMP" runat="server" Text="Місце проживання (Мп)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="MP" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbPJ" runat="server" Text="Професійні якості (Пя)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="PJ" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbVPK" runat="server" Text="Вік позичальника на момент погашення кредиту (Впк)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="VPK" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbR" runat="server" Text="Наявність та вид рахунку в Банку (Р)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="R" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbKZB" runat="server" Text="Комбінований вид забеспечення (Кзб)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="KZB" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbS1" runat="server" Text="С1"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="S" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbS2" runat="server" Text="С2"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="S2" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbPVB" runat="server" Text="Максимальна кількість балів за обраним напрямком (PVbmax)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="PVB" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbMPK" runat="server" Text="Місячний платіж по кредиту (МПК)"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="MPK" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbPRM" runat="server" Text="Приведений показник прожиткового мінімуму на початок року"></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDecimal ID="PRM" runat="server" ReadOnly="true" />
                </td>
            </tr>
            <%//*****************************************************************// %>>
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
