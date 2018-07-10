    <%@ Page Language="C#" AutoEventWireup="true" CodeFile="createAct.aspx.cs" Inherits="safe_deposit_dialog_createsafe" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <base target="_self" />
    <title>Депозитні сейфи: Параметри акту державних установ</title>
    <link type="text/css" rel="stylesheet" href="../style/style.css" />         
</head>
<body>
    <form id="formCreateAct" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                        meta:resourcekey="lbTitle">Параметри акту державних установ</asp:Label>                
                </td>
            </tr>
                        <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td style='width:1%'>
                                <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                                            tooltip="До друку договорів" TabIndex="3" EnabledAfter="0" OnClick="btBack_Click" 
                                            ></cc1:imagetextbutton>
                            </td>
                            <td style="width:100%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbType" runat="server" CssClass="InfoText95" meta:resourcekey="lbSize"
                        Style="text-align: center">Вид сейфу</asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="listSafeTypes" runat="server" CssClass="BaseDropDownList" TabIndex="2" meta:resourcekey="listSafeSizeResource1">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="vType" runat="server" ControlToValidate="listSafeTypes"
                        CssClass="Validator" ErrorMessage="необхідно заповнити" SetFocusOnError="True" meta:resourcekey="vTypeResource1"></asp:RequiredFieldValidator>
                </td>
            </tr>   
            <tr>
                <td style="width:30%">
                    <asp:Label ID="lbDateFrom" runat="server" CssClass="InfoText95" Style="text-align: center">Дата з</asp:Label>
                </td>
                <td style="width:40%">
                    <cc1:DateEdit ID="DAT_FROM" runat="server" TabIndex="12" Date="" MaxDate="2099-12-31"  MinDate=""></cc1:DateEdit> 
                </td>
                <td style="width:40%">
                    <asp:RequiredFieldValidator ID="vDAT_FROM" runat="server" ControlToValidate="DAT_FROM"
                        CssClass="Validator" ErrorMessage="необхідно заповнити" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>         
            <tr>
                <td style="width:30%">
                    <asp:Label ID="lbDateTo" runat="server" CssClass="InfoText95" Style="text-align: center">Дата по</asp:Label>
                </td>
                <td style="width:40%">
                    <cc1:DateEdit ID="DAT_TO" runat="server" TabIndex="12" Date="" MaxDate="2099-12-31"  MinDate=""></cc1:DateEdit> 
                </td>
                <td style="width:40%">
                    <asp:RequiredFieldValidator ID="vDAT_TO" runat="server" ControlToValidate="DAT_TO"
                        CssClass="Validator" ErrorMessage="необхідно заповнити" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
            </tr>           
            <tr>
                <td colspan="3" align="center">
                    <cc1:ImageTextButton ID="btCreateAct" runat="server" CssClass="AcceptButton" ImageUrl="/Common\Images\default\16\ok.png"
                        TabIndex="4" Text="Створити акт" OnClick="btCreateAct_Click" EnabledAfter="0"  />
                </td>
            </tr>            
            </table>
    </form>
</body>
</html>
