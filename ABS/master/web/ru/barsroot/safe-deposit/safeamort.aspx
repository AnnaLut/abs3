<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safeamort.aspx.cs" Inherits="safe_deposit_safedealdocs" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Амортизація</title>
    <script type="text/javascript" src="js/JScript.js"></script>
    <link type="text/css" rel="stylesheet" href="style/style.css" />   
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center" colspan='3'>
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Амортизація</asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width:5%">
                    <cc1:imagetextbutton id="btAmort" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\money_calc.png"
                        tooltip="Обновить" OnClick="btAmort_Click" TabIndex="1" EnabledAfter="0" meta:resourcekey="btRefreshResource1"></cc1:imagetextbutton>
                </td>
                <td style="width:5%">
                    <cc1:imagetextbutton id="btRefresh" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\refresh.png"
                        tooltip="Обновить" OnClick="btRefresh_Click" TabIndex="2" EnabledAfter="0" meta:resourcekey="btRefreshResource1"></cc1:imagetextbutton>
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
                            <td style="width:20%">
                                <asp:Label ID="lbDate" runat="server" CssClass="InfoText" 
                                     Text="Дата останньої амортизації системи"></asp:Label>
                            </td>
                            <td style="width:80%">
                                <asp:TextBox ID="AMORT_DATE" runat="server" Width="200px" CssClass="InfoText95" Enabled="False"></asp:TextBox></td>
                            </td>
                        </tr>
                    </table>
                </td>                
            </tr>
            <tr>
                <td colspan="3">
                    <table class="InnerTable">
                        <tr>
                            <td>
                                <bars:barsgridview id="gridDocs" runat="server" allowpaging="True" allowsorting="True" Visible="false"
                                    cssclass="BaseGrid" datasourceid="dsDocs" datemask="dd/MM/yyyy" showpagesizebox="True" AutoGenerateColumns="False" meta:resourcekey="gridDocsResource1">
                                    <Columns>
                                        <asp:BoundField DataField="REF" HeaderText="*" HtmlEncode="False" SortExpression="REF"/>
                                        <asp:BoundField DataField="DATD" HeaderText="Дата документа" SortExpression="DATD"/>
                                        <asp:BoundField DataField="TT" HeaderText="Код операції" SortExpression="TT"/>
                                        <asp:BoundField DataField="S" HeaderText="Сума" SortExpression="S"/>
                                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"/>
                                        <asp:BoundField DataField="SNUM" HeaderText="Номер сейфа" SortExpression="SNUM"/>
                                        <asp:BoundField DataField="BRANCH" HeaderText="Відділення" SortExpression="BRANCH"/>
                                        <asp:BoundField DataField="STATUS" HeaderText="Статус" SortExpression="STATUS"/>
                                        <asp:BoundField DataField="VISA" HeaderText="Віза" SortExpression="VISA"/>
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
                <td colspan="3">
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
