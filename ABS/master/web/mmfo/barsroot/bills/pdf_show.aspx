<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pdf_show.aspx.cs" Inherits="credit_usercontrols_dialogs_pdf_show" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagPrefix="bars" TagName="ByteImage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <bars:ByteImage runat="server" ID="BImg" ShowLabel="true" ShowPager="true" ShowView="false" Type="Original" Width="500px" Visible="false" />
    </div>
    </form>
</body>
</html>
<%--<div></div>--%>
