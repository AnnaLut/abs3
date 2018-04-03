<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RBLFlag.ascx.cs" Inherits="Bars.UserControls.RBLFlag" %>
<asp:RadioButtonList ID="rbl" runat="server" RepeatDirection="Horizontal" 
    RepeatLayout="Flow" meta:resourcekey="rblResource1">
    <asp:ListItem Value="1" meta:resourcekey="ListItemResource1">Так</asp:ListItem>
    <asp:ListItem Value="0" meta:resourcekey="ListItemResource2">Ні</asp:ListItem>
</asp:RadioButtonList>
