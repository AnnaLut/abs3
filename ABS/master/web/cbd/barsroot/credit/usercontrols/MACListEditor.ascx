<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MACListEditor.ascx.cs"
    Inherits="credit_usercontrols_MACListEditor" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.WcsMacListItems"
    OnSelecting="ods_Selecting">
    <SelectParameters>
        <asp:Parameter Name="MAC_ID" Type="String" Direction="Input" />
    </SelectParameters>
</Bars:BarsObjectDataSource>
<table border="0" cellpadding="3" cellspacing="0">
    <tr>
        <td>
            <asp:ListBox ID="lb" runat="server" DataSourceID="ods" DataTextField="TEXT" DataValueField="ORD"
                Height="150px" Width="200px" AutoPostBack="True" 
                ondatabound="lb_DataBound" onselectedindexchanged="lb_SelectedIndexChanged"></asp:ListBox>
        </td>
        <td valign="middle" align="center" style="width: 50px">
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td>
                        <asp:ImageButton ID="ibUp" runat="server" ImageUrl="/Common/Images/default/16/arrow_up.png"
                            ToolTip="Переместить вверх" CausesValidation="False" OnClick="ibUp_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ImageButton ID="ibDown" runat="server" ImageUrl="/Common/Images/default/16/arrow_down.png"
                            ToolTip="Переместить вниз" CausesValidation="False" OnClick="ibDown_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ImageButton ID="idDelete" runat="server" ImageUrl="/Common/Images/default/16/cancel.png"
                            ToolTip="Удалить" CausesValidation="False" OnClick="idDelete_Click" Width="16px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                            ToolTip="Добавить новый" OnClick="ibNew_Click" CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </td>
        <td valign="top">
            <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" Height="150px"
                Width="300px" HorizontalAlign="Left">
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: 100%">
                    <tr>
                        <td class="titleCell" style="width: 20%">
                            <asp:Label ID="ORDTitle" runat="server" Text='Порядок :' />
                        </td>
                        <td>
                            <asp:Label ID="ORDLabel" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TEXTTitle" runat="server" Text='Текст :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="TEXTTextBox" runat="server" IsRequired="True" MaxLength="255" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                            <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
