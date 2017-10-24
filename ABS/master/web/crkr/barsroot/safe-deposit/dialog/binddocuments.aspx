<%@ Page Language="C#" AutoEventWireup="true" CodeFile="binddocuments.aspx.cs" Inherits="safe_deposit_dialog_binddocuments" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target="_self" />
    <title>Депозитні сейфи: Привязка документів</title>
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
                <td style="width:25%"></td>
                <td style="width:25%">
                    <asp:Label ID="lbND" runat="server" CssClass="InfoLabel" meta:resourcekey="lbND">Договір №</asp:Label></td>
                <td style="width:25%">
                    <asp:TextBox ID="ND" runat="server" CssClass="InfoText95" Enabled="False" EnableTheming="True" meta:resourcekey="NDResource1"></asp:TextBox></td>                
                <td style="width:25%"></td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoText95" meta:resourcekey="lbTitle" Text="Введіть через кому референси документів"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:TextBox ID="REF" runat="server" CssClass="InfoText95" TabIndex="1" meta:resourcekey="REFResource1"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width:25%"></td>
                <td style="width:25%">
                    <asp:RadioButton ID="rbBind" runat="server" Checked="True" CssClass="InfoText95" GroupName="1"
                        Text="Привязати" TabIndex="2" meta:resourcekey="rbBindResource1" /></td>
                <td style="width:25%">
                    <asp:RadioButton ID="rbUnbind" runat="server" Checked="True" CssClass="InfoText95"
                        GroupName="1" Text="Відвязати" TabIndex="3" meta:resourcekey="rbUnbindResource1" /></td>
                 <td style="width:25%"></td>
            </tr>            
            <tr>
                <td align="center" colspan="4">
                    <cc1:imagetextbutton id="btSave" runat="server" imageurl="/Common\Images\default\16\save.png"
                        text="Зберегти" OnClick="btSave_Click" OnClientClick="if (ckField()) return;" TabIndex="4" EnabledAfter="0" meta:resourcekey="btSaveResource1" ToolTip="Зберегти"></cc1:imagetextbutton>
                </td>
            </tr>            
        </table>
    </form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('REF');
       }       
    </script>        
</body>
</html>
