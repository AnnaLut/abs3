<%@ Page Title="Довідники" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="references.aspx.cs" Inherits="cim_tools_references" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:Panel runat="server" ID="pnRefList">
        <asp:Table runat="server" ID="tabRefList">
        </asp:Table>
    </asp:Panel>
</asp:Content>

