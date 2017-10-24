<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dynmodal.aspx.cs" Inherits="barsweb_dynmodal" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 	<div style="vertical-align:middle;text-align:center;">
	    <form id="form1" runat="server">
            <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
	        <div id="tcont" />    
	        <div id="holder" runat="server" />    
	    </form>
    </div>
	<script type="text/javascript">
        function adjustDynFrame()
        {
        	var popCont = window.parent.document.getElementById('dynPopupContainer');
			
	        if (!popCont|| popCont.getAttribute("dshown"))return;
	        
	        var holder = document.getElementById('holder');

	        var popFrame = window.parent.document.getElementById('dynPopupFrame');
	        var popInner = window.parent.document.getElementById('dynPopupInner');

	        var width = Math.max(holder.scrollWidth, parseInt(popCont.style.width, 0));
	        var height = Math.max(holder.scrollHeight, parseInt(popCont.style.height, 0));

	        popCont.style.width = width + 30 + "px";
	        popCont.style.height = height + 30 + "px";
	        popFrame.style.width = popCont.style.width;
	        popFrame.style.height = popCont.style.height;

	        if (popCont.style.display == "block")
	        	popCont.setAttribute("dshown", "1");

		}
		window.onload = adjustDynFrame;

    </script>
</body>
</html>
