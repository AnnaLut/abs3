<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safedealdocs.aspx.cs" Inherits="safe_deposit_safedealdocs" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Перегляд документів</title>
    <script type="text/javascript" src="js/JScript.js"></script>
    <link type="text/css" rel="stylesheet" href="style/style.css" />   
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center" colspan='3'>
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Депозитний сейф №%s</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width:5%">
                    <cc1:imagetextbutton id="btRefresh" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\refresh.png"
                        tooltip="Обновить" OnClick="btRefresh_Click" TabIndex="1" EnabledAfter="0" meta:resourcekey="btRefreshResource1"></cc1:imagetextbutton>
                </td>
                <td style="width:95%">
                    <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                        onclientclick="location.replace('safeportfolio.aspx'); return;" 
                                tooltip="До портфеля депозитних сейфів" TabIndex="3" EnabledAfter="0" 
                                ></cc1:imagetextbutton>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <table class="InnerTable">
                        <tr>
                            <td>
                                <bars:barsgridview id="gridDocs" runat="server" allowpaging="True" allowsorting="True"
                                    cssclass="BaseGrid" datasourceid="dsDocs" datemask="dd/MM/yyyy" showpagesizebox="True" AutoGenerateColumns="False" meta:resourcekey="gridDocsResource1">
                                    <Columns>
                                        <asp:BoundField DataField="REF" HeaderText="*" HtmlEncode="False" SortExpression="REF" meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="DATD" HeaderText="Дата документа" SortExpression="DATD" meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="NLSA" HeaderText="Счет А" SortExpression="NLSA" meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="KVA" HeaderText="Вал. А" SortExpression="KVA" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField DataField="SA" HeaderText="Сумма А" SortExpression="SA" meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="NLSB" HeaderText="Счет Б" SortExpression="NLSB" meta:resourcekey="BoundFieldResource6" />
                                        <asp:BoundField DataField="KVB" HeaderText="Вал. Б" SortExpression="KVB" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="SB" HeaderText="Сумма Б" SortExpression="SB" meta:resourcekey="BoundFieldResource8" />
                                        <asp:BoundField DataField="NAZN" HeaderText="Назначение" SortExpression="NAZN" meta:resourcekey="BoundFieldResource9" />
                                    </Columns>
                                </bars:barsgridview>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <bars:barssqldatasource ProviderName="barsroot.core" id="dsDocs" runat="server"></bars:barssqldatasource>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <input type="hidden" runat="server" id="n_sk" />
                    <input type="hidden" runat="server" id="deal_id" />
                </td>
            </tr>                        
        </table>    
    </form>
    <script type="text/javascript">
       var oldonload = window.onload;
       window.onload = function() 
       {
           if (oldonload)   oldonload();
           focusControl('btRefresh');
       }       
    </script>        
</body>
</html>
