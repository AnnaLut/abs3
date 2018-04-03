<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LabelTooltip.ascx.cs"
    Inherits="Bars.UserControls.LabelTooltip" %>
<!-- trigger element. a regular workable link -->
<asp:Label ID="lb" runat="server"></asp:Label>
<!-- tooltip element -->
<div id="dvTooltip" runat="server" class="tooltip">
    <div id="dvBody" runat="server" class="body" />
    <div class="footer">
        <img id="imgCopy2cb" runat="server" src="/Common/Images/default/24/copy.png" alt="Копіювати у буфер"
            class="img_copy" />
    </div>
</div>
