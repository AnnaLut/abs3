<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loading.ascx.cs" Inherits="controls_loading1" %>

<div class="overlay"></div>
<div class="loading">
    <asp:Label ID="lbStatus" runat="server" Text="Завантаження..." 
        Font-Bold="true" />
    <div>
        <asp:Image ID="imgLoading" runat="server" 
            ImageUrl="/Common\Images\loader.gif" />
    </div>
</div>
