<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safe_openattorney.aspx.cs" Inherits="safe_deposit_dialog_safe_open_attorney" meta:resourcekey="PageResource1"%>

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
	    document.onkeydown = function () { if (event.keyCode == 27) window.close(); }
	    $(document).ready(
  function () {
      $('#DATE_FROM').click(
        function () {
            $("#DATE_FROM").mask("99-99-9999");
        });
  });
	</script> 
           
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
        .auto-style4 {
            width: 201px;
        }
        .auto-style5 {
            height: 23px;
            width: 201px;
        }
        .auto-style6 {
            width: 208px;
        }
        .auto-style7 {
            height: 23px;
            width: 208px;
        }
        .auto-style8 {
            width: 27px;
        }
        .auto-style9 {
            height: 23px;
            width: 27px;
        }
        .auto-style10 {
            width: 238px;
        }
        .auto-style11 {
            height: 23px;
            width: 238px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td colspan="5" align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" Text="Додавання/редагування довіреності" meta:resourcekey="lbTitleResource1"></asp:Label></td>
            </tr>
            
            <tr>
                <td class="auto-style4">
                    <asp:Label ID="lbDealNum0" runat="server" CssClass="InfoText" Text="№ договору" meta:resourcekey="lbDealNumResource1"></asp:Label></td>
                <td class="auto-style6">
                    <asp:TextBox ID="DPT_ID" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="DPT_IDResource1"></asp:TextBox></td>
                <td class="auto-style8"></td>                
                <td class="auto-style10">
                    <asp:Label ID="lbClientType" runat="server" CssClass="InfoText" Text="Тип клієнта" meta:resourcekey="lbClientTypeResource1"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddClientType" runat="server" CssClass="BaseDropDownList" meta:resourcekey="ddClientTypeResource1">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="auto-style4">
                    </td>
                <td align="right" class="auto-style6">
                    <cc1:ImageTextButton ID="btSelectClient" runat="server" ButtonStyle="Image" EnabledAfter="0"
                        ImageUrl="/Common\Images\default\16\reference.png" meta:resourcekey="btSelectClientResource1"
                        OnClientClick="if (GetClient()) return; " TabIndex="4" ToolTip="Вибрати клієнта" />
                </td>
                <td class="auto-style8"></td>                
                <td class="auto-style10">
                    <asp:Label ID="lbRNK" runat="server" CssClass="InfoText" Text="РНК" meta:resourcekey="lbRNKResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="RNK" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="RNKResource2" Width="185px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style4"></td>
                <td class="auto-style6">
                    </td>
                <td class="auto-style8"></td>                    
                <td class="auto-style10"><asp:Label ID="lbFIO" runat="server" CssClass="InfoText" Text="ФІО клієнта" meta:resourcekey="lbFIOResource1"></asp:Label></td>
                <td>
                    <asp:TextBox ID="FIO" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="FIOResource2" Width="300px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style4">
                </td>
                <td class="auto-style6">
                    &nbsp;</td>
                <td class="auto-style8"></td>                 
                <td class="auto-style10">                
                    <asp:Label ID="lbNLS" runat="server" CssClass="InfoText" Text="Дата початку" meta:resourcekey="lbNLSResource1"></asp:Label></td>
                <td>
                    <cc1:DateEdit ID="DATE_FROM" runat="server" CssClass="InfoText95" Width="120px" meta:resourcekey="DATE_FROM">01/01/2015 </cc1:DateEdit></td>
            </tr>
             <tr>
                <td class="auto-style4">
                </td>
                <td class="auto-style6">
                </td>
                <td class="auto-style8"></td>                 
                <td class="auto-style10">
                    <asp:Label ID="lbNLS0" runat="server" CssClass="InfoText" Text="Дата завершення" meta:resourcekey="lbNLSResource1"></asp:Label>
                </td>
                <td>
                    <cc1:DateEdit ID="DATE_TO"  runat="server" CssClass="InfoText95"  Width="120px"  meta:resourcekey="DATE_TO">01/01/2015</cc1:DateEdit>
                </td>
            </tr> 
            <tr>
                <td class="auto-style4">
                </td>
                <td class="auto-style6">
                </td>
                <td class="auto-style8"></td>                 
                <td class="auto-style10">
                    <asp:Label ID="lbNLS1" runat="server" CssClass="InfoText" Text="Дата дострокового закриття" meta:resourcekey="lbNLSResource1"></asp:Label>
                </td>
                <td>
                    <cc1:DateEdit ID="CANCEL_DATE"  runat="server" CssClass="InfoText95" Width="119px" meta:resourcekey="CANCEL_DATE">01/01/2015</cc1:DateEdit>
                </td>
            </tr>
             <tr>
                <td align="center" colspan="5">
                    <cc1:ImageTextButton ID="btOK" runat="server" ImageUrl="\Common\Images\default\16\ok.png"
                        Text="Прийняти" OnClick="btOK_Click" EnabledAfter="0" meta:resourcekey="btOKResource1" ToolTip="Прийняти" />
                </td>
            </tr>
            <tr>
                <td class="auto-style5">
                </td>
                <td class="auto-style7">
                      <input type="hidden" runat="server" id="RNK_" />
                </td>
                <td class="auto-style9"></td>                 
                <td class="auto-style11">
                </td>
                <td class="auto-style1">
                </td>
            </tr>  
           
        </table>
    </form>
</body>
</html>
