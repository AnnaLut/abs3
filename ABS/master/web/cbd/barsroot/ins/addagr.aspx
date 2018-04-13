<%@ Page Title="Додаткова угода" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="addagr.aspx.cs" Inherits="ins_addagr" Trace="false"
    MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
    <script language="javascript" type="text/javascript">
        function CloseDialog(p_addagr_id) {
            var res = new Object();

            window.returnValue = p_addagr_id;
            window.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div>
        <asp:Panel ID="pnlAddAgr" runat="server" GroupingText="Додаткова угода">
            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                <tr>
                    <td>
                        <asp:Label ID="SERTitle" runat="server" Text="Серія:" Visible="false" />
                    </td>
                    <td>
                        <Bars:TextBoxString ID="SER" runat="server" TabIndex="101" Visible="false" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="NUMTitle" runat="server" Text="Номер:" />
                    </td>
                    <td>
                        <Bars:TextBoxString ID="NUM" runat="server" IsRequired="true" ValidationGroup="AddAgr"
                            TabIndex="102" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="SDATETitle" runat="server" Text="Дата початку дії:" />
                    </td>
                    <td>
                        <Bars:TextBoxDate ID="SDATE" runat="server" IsRequired="true" ValidationGroup="AddAgr"
                            TabIndex="103" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="buttons_container">
                        <asp:Button ID="bSave" runat="server" CausesValidation="True" ValidationGroup="AddAgr"
                            Text="Зберегти" OnClick="bSave_Click" TabIndex="104" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
