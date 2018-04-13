<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestScan.aspx.cs" Inherits="TEST_TestScan" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagPrefix="uc1" TagName="TextBoxScanner" %>
<%@ Register Src="~/credit/usercontrols/ByteImage.ascx" TagPrefix="uc1" TagName="ByteImage" %>
<%@ Register Src="~/UserControls/ByteImageCutter.ascx" TagPrefix="bars" TagName="ByteImageCutter" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
</head>
<body>

	<div id="progressDialog" title="Сканування почнеться через декілька секунд...">
		<div id="progressbar"></div>
	</div>
	
	
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <asp:Label ID="Label1" runat="server" Text="Сканування:"></asp:Label> 
            <uc1:textboxscanner runat="server" id="textBoxScanner" IsRequired="True"/>
            <%--<uc1:textboxscanner runat="server" id="textBoxScanner1" IsRequired="True" />--%>
            <%--<asp:Label id = "lbl" runat="server" Text=""></asp:Label>--%>
            
            <%--<asp:Button id = "Button1" runat="server" Text="" ></asp:Button>--%>
            <%--<bars:ByteImageCutter runat="server" ID="bicCutPhoto" Width="500" Height="400" />--%>
            <br/>
        </div>
        <br/>
        <br/>
        <%--<uc1:ByteImage runat="server" id="ByteImage" ShowPager="true"/>--%>
        
    </div>
    </form>
</body>
</html>