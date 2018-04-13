<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safe_opendeal.aspx.cs" Inherits="safe_deposit_dialog_safe_opendeal" meta:resourcekey="PageResource1"%>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target="_self" />
    <title>Депозитні сейфи: Відкриття договору</title>
    <script type="text/javascript" src="../js/JScript.js"></script>
    <script type="text/javascript" src="../js/ckscript.js"></script>
    <link type="text/css" rel="stylesheet" href="../style/style.css" />    
	<script type="text/javascript" language="javascript">
		document.onkeydown = function(){if(event.keyCode==27) window.close();}
	</script>        
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" Text="Відкриття нового договору" meta:resourcekey="lbTitleResource1"></asp:Label></td>
            </tr>
            <tr>
                <td style="width:20%">
                    <asp:Label ID="lbSafeId" runat="server" CssClass="InfoText" Text="Сейф №" meta:resourcekey="lbSafeIdResource1"></asp:Label></td>
                <td style="width:10%">
                    <asp:TextBox ID="SAFEID" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="SAFEIDResource1"></asp:TextBox></td>
                <td style="width:10%"></td>
                <td style="width:30%">
                    <asp:Label ID="lbType" runat="server" CssClass="InfoText" Text="Тип сейфа" meta:resourcekey="lbTypeResource1"></asp:Label></td>
                <td style="width:30%">
                    <asp:TextBox ID="SAFETYPE" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="SAFETYPEResource1"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbDealNum" runat="server" CssClass="InfoText" Text="№ договору" meta:resourcekey="lbDealNumResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="DEAlID" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="DEAlIDResource1"></asp:TextBox></td>
                <td></td>                
                <td>
                    <asp:Label ID="lbClientType" runat="server" CssClass="InfoText" Text="Тип клієнта" meta:resourcekey="lbClientTypeResource1"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddClientType" runat="server" CssClass="BaseDropDownList" meta:resourcekey="ddClientTypeResource1">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td>
                    </td>
                <td align="right">
                    <cc1:ImageTextButton ID="btSelectClient" runat="server" ButtonStyle="Image" EnabledAfter="0"
                        ImageUrl="/Common\Images\default\16\reference.png" meta:resourcekey="btSelectClientResource1"
                        OnClientClick="if (GetClient()) return; " TabIndex="4" ToolTip="Вибрати клієнта" />
                </td>
                <td></td>                
                <td>
                    <asp:Label ID="lbRNK" runat="server" CssClass="InfoText" Text="РНК" meta:resourcekey="lbRNKResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="RNK" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="RNKResource2"></asp:TextBox></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    </td>
                <td></td>                    
                <td><asp:Label ID="lbFIO" runat="server" CssClass="InfoText" Text="ФІО клієнта" meta:resourcekey="lbFIOResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="FIO" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="FIOResource2"></asp:TextBox></td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td></td>                 
                <td>                
                    <asp:Label ID="lbNLS" runat="server" CssClass="InfoText" Text="Рахунок приб. майб. періодів" meta:resourcekey="lbNLSResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="NLS" onblur="if (ckNLS('NLS','MFO'));" runat="server" CssClass="InfoText95" meta:resourcekey="NLSResource2"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="center" colspan="5">
                    <cc1:ImageTextButton ID="btOK" runat="server" ImageUrl="\Common\Images\default\16\ok.png"
                        Text="Прийняти" OnClick="btOK_Click" EnabledAfter="0" meta:resourcekey="btOKResource1" ToolTip="Прийняти" />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="hidden" runat="server" id="MFO" />
                    <input type="hidden" runat="server" id="RNK_" />
                </td>
                <td>
                </td>
                <td></td>                 
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
