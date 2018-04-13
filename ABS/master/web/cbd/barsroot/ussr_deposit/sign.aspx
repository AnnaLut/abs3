<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sign.aspx.cs" Inherits="ussr_deposit_Default2" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>Компенсаційні вклади</title>
		<script type="text/javascript" language="javascript" src="js/func.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/sign.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/Sign.js"></script>
		<link href="css/dpt.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="frmVisa" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                        Text="Підпис проводок" meta:resourcekey="lbTitleResource1"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable" runat="server" id="tblAllDocs">
                    </table>
                </td>
            </tr>
            <tr>
                <td runat="server" id="tdDUMP">
                    <input type="hidden" runat="server" id="SIGNLNG" />                    
                    <input type="hidden" runat="server" id="DOCKEY" />                    
                    <input type="hidden" runat="server" id="BDATE" />                    
                    <input type="hidden" runat="server" id="SEPNUM" />                    
                    <input type="hidden" runat="server" id="SIGNTYPE" />                    
                    <input type="hidden" runat="server" id="VISASIGN" />                    
                    <input type="hidden" runat="server" id="INTSIGN" />                    
                    <input type="hidden" runat="server" id="REGNCODE" />                    
                </td>
            </tr>
            <tr>
                <td>
                    <cc1:imagetextbutton id="btPay" runat="server" buttonstyle="Text" onclick="btPay_Click"
                        text="Оплатити" EnabledAfter="0" meta:resourcekey="btPayResource1" ToolTip="Оплатити"></cc1:imagetextbutton>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
