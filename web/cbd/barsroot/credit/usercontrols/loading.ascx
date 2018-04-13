<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loading.ascx.cs" Inherits="controls_loading" %>
<div class="overlay"></div>
<div class="loading">
    <asp:Label ID="lbStatus" runat="server" Text="Подождите, идет загрузка..." 
        meta:resourcekey="lbStatus"></asp:Label>
    <div>
        <asp:Image ID="img" runat="server" SkinID="imgLoading" />
    </div>
</div>
