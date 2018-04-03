<%@ Page Language="C#" AutoEventWireup="true" CodeFile="extraproperties.aspx.cs" Inherits="safe_deposit_dialog_ExtraProperties" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target="_self" />
    <title>Депозитні сейфи: Додаткові реквізити</title>
    <script type="text/javascript" src="../js/JScript.js"></script>
    <link type="text/css" rel="stylesheet" href="../style/style.css" />   
	<script type="text/javascript" language="javascript">
		document.onkeydown = function(){if(event.keyCode==27) window.close();}
	</script>             
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td>
                    <table id="PROP_TABLE" class="InnerTable" runat="server">
                        <tr>
                            <td align="center" colspan="3">
                                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Депозитні сейфи: Дод. реквізити договору №%s</asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <cc1:imagetextbutton id="btSave" runat="server" imageurl="/Common\Images\default\16\save.png"
                        text="Сохранить" OnClick="btSave_Click" TabIndex="1" EnabledAfter="0" meta:resourcekey="btSaveResource1" ToolTip="Сохранить"></cc1:imagetextbutton>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" id="SAFE_ID" runat="server" /><input id="fields" type="hidden" runat="server" /><input id="ND" type="hidden" runat="server" />
                </td>
            </tr>            
        </table>        
    </form>
</body>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btSave');
       }       
    </script>    
</html>
