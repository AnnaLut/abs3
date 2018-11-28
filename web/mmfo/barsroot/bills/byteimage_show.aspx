<%@ Page Language="C#" AutoEventWireup="true" CodeFile="byteimage_show.aspx.cs" Inherits="dialogs_byteimage_show"
    meta:resourcekey="PageResource1" Theme="default" MasterPageFile="~/credit/master.master"
    Title="Сканкопия" Trace="false" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagPrefix="bars" TagName="ByteImage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <script language="javascript" type="text/jscript">
        // закрываем диалог
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }
    </script>
    <table border="0" cellpadding="3" cellspacing="0" width="99%" style="text-align: center">
        <tr>
            <td style="padding-top: 10px">
                <asp:ImageButton ID="ibPrint" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                    Text="Печать" ToolTip="Печать" OnClick="ibPrint_Click" meta:resourcekey="ibPrintResource1" />
                <asp:ImageButton ID="ibCancel" runat="server" ImageUrl="/Common/Images/default/24/delete2.png"
                    Text="Отмена" ToolTip="Отмена" OnClientClick="CloseDialog(null); return false;"
                    meta:resourcekey="ibCancelResource1" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: 1px solid #94ABD9">
                <bars:ByteImage runat="server" ID="BImg" ShowLabel="true" ShowPager="true" ShowView="false" Type="Original" Width="500px" />
            </td>
        </tr>
    </table>
</asp:Content>

<%--<div></div>--%>
