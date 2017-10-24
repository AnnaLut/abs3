<%@ Page Title="Коментар" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="comment.aspx.cs" Inherits="ins_comment" Trace="false"
    MaintainScrollPositionOnPostback="true" %>

<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
    <script language="javascript" type="text/javascript">
        function CloseDialog(comm) {
            var res = new Object();

            res.comm = comm;

            window.returnValue = res;
            window.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div>
        <asp:Panel ID="pnlAddAgr" runat="server" GroupingText="Коментар">
            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                <tr>
                    <td>
                        <Bars:TextBoxString ID="COMM" runat="server" TabIndex="101" Width="350px" Rows="3"
                            TextMode="MultiLine" ValidationGroup="Main" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="buttons_container">
                        <asp:Button ID="bSave" runat="server" CausesValidation="True" ValidationGroup="Main"
                            Text="Зберегти" OnClick="bSave_Click" TabIndex="102" />
                        <asp:Button ID="bCancel" runat="server" CausesValidation="false" Text="Відміна" TabIndex="103"
                            OnClientClick="CloseDialog(''); return false; " />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>
