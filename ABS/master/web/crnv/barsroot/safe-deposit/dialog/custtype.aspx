<%@ Page Language="C#" AutoEventWireup="true" CodeFile="custtype.aspx.cs" Inherits="safe_deposit_dialog_custtype" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Вибір типу клієнта</title>
    <script type="text/javascript" src="../js/JScript.js"></script>
    <link type="text/css" rel="stylesheet" href="../style/style.css" />        
	<script type="text/javascript" language="javascript">
		document.onkeydown = function(){if(event.keyCode==27) window.close();}
	</script>    
</head>
<body style="width: 100%; text-align: left">
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoText" meta:resourcekey="lbTitle"
                    Style="text-align: center">Виберіть тип клієнта</asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <select id="listCustType" class="BaseDropDownList" tabindex="1" size="1">
                    <option selected="selected" value="3">Физическое лицо</option>
                    <option value="2">Юридическое лицо</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="center">
                <cc1:imagetextbutton id="btAccept" runat="server" buttonstyle="Text" onclientclick="return GetCustType()"
                    text="Вибрати" TabIndex="2" EnabledAfter="0" meta:resourcekey="btAcceptResource1" ToolTip="Вибрати"></cc1:imagetextbutton>
            </td>
        </tr>
    </table>
    </form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('listCustType');
       }       
    </script>        
</body>
</html>
