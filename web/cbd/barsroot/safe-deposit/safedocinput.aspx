<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safedocinput.aspx.cs" Inherits="safe_deposit_safedocinput" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Ввод документов</title>
    <script type="text/javascript" src="js/JScript.js"></script>
</script>


    <link type="text/css" rel="stylesheet" href="style/style.css" />   
    <style type="text/css">
        .style1
        {
            text-align: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center" colspan="4">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Депозитний сейф №%s</asp:Label></td>
            </tr>
            <tr>
                <td style="width:1%">
                    <cc1:imagetextbutton id="btPay" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\ok.png"
                        tooltip="Оплатить" OnClick="btPay_Click"  OnClientClick="if (validateParams()) return;" TabIndex="1" EnabledAfter="0" meta:resourcekey="btPayResource1"></cc1:imagetextbutton>
                </td>
                <%--OnClientClick=" if (!confirm('Проивести оплату?')) return false;"--%>
                <td style="width:1%">
                    <cc1:imagetextbutton id="btCalc" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\money_calc.png"
                        tooltip="Расчитать" Visible="false" OnClientClick="if (validateParams()) return;" OnClick="btCalc_Click" TabIndex="2" EnabledAfter="0" meta:resourcekey="btCalcResource1" ></cc1:imagetextbutton>
                </td>
                <td style="width:1%">
                    <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                        onclientclick="location.replace('safeportfolio.aspx'); return;" 
                        tooltip="До портфеля депозитних сейфів" TabIndex="3" EnabledAfter="0"></cc1:imagetextbutton>
                </td>
                <td style="width:100%" class="style1">
                                        <asp:HyperLink runat="server" ID="bt1"  
                        ImageUrl="/Common\Images\default\16\open_blue.png" 
                        ToolTip="Документы по договору" Width="25px" Height="25px" Visible="false"></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <table class="InnerTable">
                        <tr>
                            <td style="width:30%">
                                <asp:Label ID="lbTT" runat="server" CssClass="InfoText95" meta:resourcekey="lbRef"
                                    Style="text-align: center">Операция</asp:Label></td>
                            <td style="width:35%">
                                <asp:DropDownList ID="listTT" runat="server" CssClass="BaseDropDownList" OnSelectedIndexChanged="listTT_SelectedIndexChanged" AutoPostBack="True" TabIndex="10" meta:resourcekey="listTTResource1">
                                </asp:DropDownList></td>                
                            <td style="width:35%">
                            </td>                                                        
                        </tr>
                        <tr runat="server" id="rdat1">
                            <td>
                                <asp:Label ID="lbDAT1" runat="server" CssClass="InfoText95" meta:resourcekey="lbRef"
                                    Style="text-align: center"></asp:Label></td>
                            <td>
                                <cc1:DateEdit ID="DAT1" runat="server" TabIndex="11" Date="" MaxDate="2099-12-31" meta:resourcekey="DAT1Resource1" MinDate=""></cc1:DateEdit></td>                            
                            <td>
                                </td>                                                        
                        </tr>
                        <tr runat="server" id="rdat2">
                            <td>
                                <asp:Label ID="lbDAT2" runat="server" CssClass="InfoText95" meta:resourcekey="lbRef"
                                    Style="text-align: center"></asp:Label></td>
                            <td>
                                <cc1:DateEdit ID="DAT2" runat="server" TabIndex="12" 
                                 onblur="ckDate()"
                                 Date="" MaxDate="2099-12-31" meta:resourcekey="DAT2Resource1" MinDate=""></cc1:DateEdit></td>
                            <td>
                                </td>
                        </tr>
                        <tr runat="server" id="rnumpar">
                            <td>
                                <asp:Label ID="lbNUMPAR" runat="server" CssClass="InfoText95" meta:resourcekey="lbRef"
                                    Style="text-align: center"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="NUMPAR" runat="server" CssClass="InfoText95" TabIndex="13" meta:resourcekey="NUMPARResource1"></asp:TextBox></td>
                            <td>
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                    <Scripts>
                        <asp:ScriptReference Path="js/JScript.js" />                        
                    </Scripts>                        
                </asp:ScriptManager> 
                    <input type="hidden" runat="server" id="n_sk" />
                    <input type="hidden" runat="server" id="nd" />
                    <input type="hidden" runat="server" id="datEndString" value="DAT2" />
                  
                </td>
            </tr>                        
        </table>
    </form>
        <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btPay');
       }       
    </script>    
</body>
</html>
