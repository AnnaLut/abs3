<%@ Page Language="C#" AutoEventWireup="true" CodeFile="createsafe.aspx.cs" Inherits="safe_deposit_dialog_createsafe" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target="_self" />
    <title>Депозитні сейфи: Відкриття нового сейфа</title>
    <script type="text/javascript" src="../js/JScript.js"></script>
    <script type="text/javascript" src="../js/ckscript.js"></script>
    <link type="text/css" rel="stylesheet" href="../style/style.css" />    
	<script type="text/javascript" language="javascript">
		document.onkeydown = function(){if(event.keyCode==27) window.close();}
	</script>        
</head>
<body onload="setFocus1('SAFE_ID');applyNumFunc('NLS');">
    <form id="formCreateSafe" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                        meta:resourcekey="lbTitle">Параметри нової скриньки</asp:Label>                
                </td>
            </tr>
            <tr>
                <td style="width:30%">
                    <asp:Label ID="lbSafeNum" runat="server" CssClass="InfoText95" meta:resourcekey="lbSafeNum"
                        Style="text-align: center">Сейф №</asp:Label></td>
                <td style="width:40%">
                    <asp:TextBox ID="SAFE_ID" runat="server" onblur="ckSafeId()" CssClass="InfoText95" TabIndex="1" meta:resourcekey="SAFE_IDResource1"></asp:TextBox></td>
                <td style="width:40%">
                    <asp:RequiredFieldValidator ID="vSafeId" runat="server" ControlToValidate="SAFE_ID"
                        CssClass="Validator" ErrorMessage="необходимо заполнить" SetFocusOnError="True" meta:resourcekey="vSafeIdResource1"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbSize" runat="server" CssClass="InfoText95" meta:resourcekey="lbSize"
                        Style="text-align: center">Розмір сейфа</asp:Label></td>
                <td>
                    <asp:DropDownList ID="listSafeSize" runat="server" CssClass="BaseDropDownList" TabIndex="2" meta:resourcekey="listSafeSizeResource1">
                    </asp:DropDownList></td>
                <td>
                    <asp:RequiredFieldValidator ID="vType" runat="server" ControlToValidate="listSafeSize"
                        CssClass="Validator" ErrorMessage="необходимо заполнить" SetFocusOnError="True" meta:resourcekey="vTypeResource1"></asp:RequiredFieldValidator></td>
            </tr>            
            <tr>
                <td>
                    <asp:Label ID="lbNLS" runat="server" CssClass="InfoText95" meta:resourcekey="lbNLS"
                        Style="text-align: center">Рахунок застави</asp:Label></td>
                <td>
                    <asp:TextBox ID="NLS" runat="server" onblur="if (ckNLS('NLS','MFO'));" CssClass="InfoText95" TabIndex="3" meta:resourcekey="NLSResource1"></asp:TextBox>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="vNLS" runat="server" ControlToValidate="NLS" CssClass="Validator"
                        ErrorMessage="необходимо заполнить" SetFocusOnError="True" meta:resourcekey="vNLSResource1"></asp:RequiredFieldValidator></td>
            </tr>            
            <tr>
                <td colspan="3" align="center">
                    <cc1:ImageTextButton ID="btCreateSafe" runat="server" CssClass="AcceptButton" ImageUrl="/Common\Images\default\16\ok.png"
                        TabIndex="4" Text="Відкрити скриньку" OnClick="btCreateSafe_Click" EnabledAfter="0" meta:resourcekey="btCreateSafeResource1" ToolTip="Відкрити скриньку" />
                </td>
            </tr>            
            <tr>
                <td colspan="3">
                    <input type="hidden" runat="server" id="MFO" />
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                        <Scripts>
                            <asp:ScriptReference Path="../js/JScript.js" />                        
                        </Scripts>                        
                    </asp:ScriptManager>
                </td>
            </tr>
        </table>
    </form>
    <script language="javascript" type="text/javascript">
        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('SAFE_ID');
       }       
    </script>        
</body>
</html>
