<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safevisit.aspx.cs" Inherits="safe_deposit_safevisit" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Журнал відвідувань</title>
    <script type="text/javascript" src="js/JScript.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>        
    <link type="text/css" rel="stylesheet" href="style/style.css" />
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td style='width:1%'>
                    <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                        onclientclick="location.replace('safeportfolio.aspx'); return;" 
                                tooltip="До портфеля депозитних сейфів" TabIndex="3" EnabledAfter="0" 
                                ></cc1:imagetextbutton>
                </td>                
                <td colspan="7" align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Депозитні сейфи: Журнал відвідувань</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width:10%">
                    <asp:Label ID="lbNSK" runat="server" CssClass="InfoText95" Text="Скринька" meta:resourcekey="lbNSKResource1"></asp:Label></td>
                <td style="width:5%">
                    <asp:TextBox ID="N_SK" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="N_SKResource1"></asp:TextBox>
                </td>
                <td style="width:5%">
                </td>
                <td style="width:10%">
                    <asp:Label ID="lbND" runat="server" CssClass="InfoText95" Text="Договір №" meta:resourcekey="lbNDResource1"></asp:Label>
                </td>
                <td style="width:5%">
                    <asp:TextBox ID="ND" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="NDResource2"></asp:TextBox>
                </td>
                <td style="width:5%">
                </td>                
                <td style="width:10%">
                    <asp:Label ID="lbClient" runat="server" CssClass="InfoText95" Text="Клієнт" meta:resourcekey="lbClientResource1"></asp:Label>
                </td>
                <td style="width:50%">
                    <asp:TextBox ID="Name" runat="server" CssClass="InfoText95" ReadOnly="True" meta:resourcekey="NameResource1"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="8">
                    <bars:barsgridview id="gvVisit" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="BaseGrid" DataSourceID="dsVisit" DateMask="dd/MM/yyyy" ShowPageSizeBox="True" meta:resourcekey="gvVisitResource1">
                        <Columns>
                            <asp:BoundField DataField="DATIN_DATE" HeaderText="Дата входу (dd/MM/yyyy)" SortExpression="DATIN_DATE" meta:resourcekey="BoundFieldResource1" />
                            <asp:BoundField DataField="DATIN_TIME" HeaderText="Час входу (hh:mi)" SortExpression="DATIN_TIME" meta:resourcekey="BoundFieldResource2" />
                            <asp:BoundField DataField="DATOUT_DATE" HeaderText="Дата виходу(dd/mm/yyyy)" SortExpression="DATOUT_DATE" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField DataField="DATOUT_TIME" HeaderText="Час виходу (hh:mi)" SortExpression="DATOUT_TIME" meta:resourcekey="BoundFieldResource4" />
                        </Columns>
                    </bars:barsgridview>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsVisit" runat="server" OldValuesParameterFormatString="old{0}"></bars:barssqldatasource>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
