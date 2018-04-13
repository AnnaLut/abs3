<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safeattorney.aspx.cs" Inherits="safe_deposit_Attorney" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Портфель</title>
    <script type="text/javascript" src="js/JScript.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>        
    <link type="text/css" rel="stylesheet" href="style/style.css" />
	<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        .auto-style1 {
            width: 15%;
            height: 23px;
        }
        .auto-style2 {
            width: 20%;
            height: 23px;
        }
        .auto-style3 {
            width: 30%;
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="attorney" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" 
                    meta:resourcekey="lbTitle">Депозитні сейфи: Довіреності</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td colspan="5">
                            <table id="buttonTable" class="InnerTable">
                                <tr>
                                    <td style="width:1%">
                                        <cc1:imagetextbutton id="btNew" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\new.png" ToolTip="Додати довіреність" TabIndex="2" OnClientClick="return AddAttorney('add')" EnabledAfter="0" meta:resourcekey="btNewResource1"></cc1:imagetextbutton>
                                        </td>
                                    <td style="width:1%">
                                        <cc1:ImageTextButton ID="btEdit" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\visa.png" OnClientClick="return AddAttorney('edit')" TabIndex="3" ToolTip="Редагувати довіреність" EnabledAfter="0" meta:resourcekey="btEditResource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator1" runat="server" BorderWidth="1px" meta:resourcekey="Separator1Resource1" />
                                    </td>
                                    <td style="width:1%">
                                        <cc1:imagetextbutton id="btBack" runat="server" ButtonStyle="Image" ImageUrl="/Common\Images\default\16\arrow_left.png" ToolTip="Назад до картки сейфу" TabIndex="4" EnabledAfter="0" meta:resourcekey="btOpenResource1" OnClick="btBack_Click"></cc1:imagetextbutton>
                                    </td>
                                    <td style="width:1%">
                                        <cc1:Separator ID="Separator2" runat="server" BorderWidth="1px" meta:resourcekey="Separator2Resource1" />
                                    </td>
                                    
                                    <td style="width:100%"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Label style="text-align:center" ID="lbRef" runat="server" CssClass="InfoText" 
                                meta:resourcekey="lbRef" Text="Реф.  договору"></asp:Label>
                        </td>
                        <td class="auto-style1">
                            <asp:Label ID="lbNum" runat="server" CssClass="InfoText" meta:resourcekey="lbNum"
                                Style="text-align: center">№ договору</asp:Label>
                        </td>
                        <td class="auto-style2">
                      <asp:Label ID="lbNmk" runat="server" CssClass="InfoText" meta:resourcekey="lbNmk"
                                Style="text-align: center">Ким зайнятий</asp:Label></td>
                        <td class="auto-style2">
                                <asp:Label ID="lbSafeNum" runat="server" CssClass="InfoText" meta:resourcekey="lbSafeNum"
                                Style="text-align: center" Text="№ сейфа"></asp:Label></td>
                    <td class="auto-style3">
                            </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="REF" runat="server" CssClass="InfoText95" TabIndex="20" meta:resourcekey="REFResource1" Enabled="False"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="NUM" runat="server" CssClass="InfoText95" TabIndex="21" meta:resourcekey="NUMResource1" Enabled="False"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="PERSON" runat="server" CssClass="InfoText95" TabIndex="24" meta:resourcekey="PERSONResource1" Enabled="False"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="SAFENUM" runat="server" CssClass="InfoText95" TabIndex="25" meta:resourcekey="SAFENUMResource1" Enabled="False"></asp:TextBox></td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <Bars:BarsGridViewEx ID="gridSafeDepositAttorney" style='width:100%; cursor:hand' runat="server" 
                                DataSourceID="dsSafeDepositAttorney"
                                AutoGenerateColumns="False" CssClass="barsGridView" AllowPaging="True" 
                                AllowSorting="True" ShowPageSizeBox="true" EnableViewState="true" 
                                onrowdatabound="gridSafeDepositAttorney_RowDataBound" >
                                <Columns>
                                    <asp:BoundField DataField="RNK" SortExpression="RNK" HeaderText="№ сейфа"></asp:BoundField>
                                    <asp:BoundField DataField="NMK" SortExpression="NMK" HeaderText="ПІБ"></asp:BoundField>
                                    <asp:BoundField DataField="DATE_FROM" SortExpression="DATE_FROM" HeaderText="Дата початку"></asp:BoundField>
                                    <asp:BoundField DataField="DATE_TO" SortExpression="DATE_TO" HeaderText="Дата завершення"></asp:BoundField>
                                    <asp:BoundField DataField="CANCEL_DATE" SortExpression="CANCEL_DATE" HeaderText="Дата закриття"></asp:BoundField>
                                 </Columns>
                                <FooterStyle CssClass="footerRow" />
                                <HeaderStyle CssClass="headerRow" />
                                <EditRowStyle CssClass="editRow" />
                                <PagerStyle CssClass="pagerRow" />
                                <SelectedRowStyle CssClass="selectedRow" />
                                <AlternatingRowStyle CssClass="alternateRow" />
                                <RowStyle CssClass="normalRow" />
                            </Bars:BarsGridViewEx>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <bars:barssqldatasourceex ProviderName="barsroot.core" id="dsSafeDepositAttorney" runat="server"></bars:barssqldatasourceex>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <input type="hidden" runat="server" id="SAFE_ID" /><input type="hidden" runat="server" id="DPT_ID" />
                            <input type="hidden" runat="server" id="BANKDATE" /><input type="hidden" runat="server" id="FIO" />
                            <input type="hidden" runat="server" id="hSAFENUM" /><input type="hidden" runat="server" id="RNK" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
           
    </form>
    <script type="text/javascript">
        var oldonload = window.onload;
        window.onload = function () {
            if (oldonload) oldonload();
            focusControl('btBack');
        }
    </script>
</body>
</html>
