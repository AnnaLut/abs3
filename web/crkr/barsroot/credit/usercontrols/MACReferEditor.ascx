<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MACReferEditor.ascx.cs"
    Inherits="credit_usercontrols_MACReferEditor" %>
<%@ Register Src="TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 500px;
    text-align: left">
    <tr>
        <td class="titleCell">
            <asp:Label ID="TAB_IDTitle" runat="server" Text='Идентификатор таблицы справочника :' />
        </td>
        <td>
            <bec:TextBoxNumb ID="tbTAB_ID" runat="server" IsRequired="True"></bec:TextBoxNumb>
        </td>
    </tr>
    <tr>
        <td class="titleCell">
            <asp:Label ID="KEY_FIELDLabel" runat="server" Text='Ключевое поле :' />
        </td>
        <td>
            <bec:TextBoxString ID="tbKEY_FIELD" runat="server" IsRequired="True"></bec:TextBoxString>
        </td>
    </tr>
    <tr>
        <td class="titleCell">
            <asp:Label ID="SEMANTIC_FIELDLabel" runat="server" Text='Поле семантики :' />
        </td>
        <td>
            <bec:TextBoxString ID="tbSEMANTIC_FIELD" runat="server" IsRequired="True"></bec:TextBoxString>
        </td>
    </tr>
    <tr>
        <td class="titleCell">
            <asp:Label ID="SHOW_FIELDSLabel" runat="server" Text='Поля для отображения (перечисление через запятую) :' />
        </td>
        <td>
            <bec:TextBoxString ID="tbSHOW_FIELDS" runat="server"></bec:TextBoxString>
        </td>
    </tr>
    <tr>
        <td class="titleCell">
            <asp:Label ID="WHERE_CLAUSELabel" runat="server" Text='Условие отбора (включая слово where) :' />
        </td>
        <td>
            <bec:TextBoxString ID="tbWHERE_CLAUSE" runat="server" MaxLength="4000" Rows="3" TextMode="MultiLine"
                Width="300px"></bec:TextBoxString>
        </td>
    </tr>
    <tr>
        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
            <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" />
        </td>
    </tr>
</table>
