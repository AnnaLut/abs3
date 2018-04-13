<%@ Page Language="C#" AutoEventWireup="true" CodeFile="safedealprint.aspx.cs" Inherits="safe_deposit_safedealprint" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Депозитні сейфи: Друк документів</title>
    <script type="text/javascript" src="js/JScript.js"></script>
    <link type="text/css" rel="stylesheet" href="style/style.css" />   
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitle">Депозитний сейф №%s. Договір №%d.</asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td style="width:1%">
                                <cc1:imagetextbutton id="btRefresh" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\refresh.png"
                                    onclick="btRefresh_Click" tooltip="Обновить" EnabledAfter="0" meta:resourcekey="btRefreshResource1"></cc1:imagetextbutton>
                            </td>
                            <td style="width:1%">
                                <cc1:imagetextbutton id="btNew" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\new.png"
                                    tooltip="Новый" OnClientClick="if (GetNewTemplate()) return;" EnabledAfter="0" meta:resourcekey="btNewResource1"></cc1:imagetextbutton>
                            </td>
                            <td style="width:1%">
                                <cc1:imagetextbutton id="btSign" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\visa.png"
                                    tooltip="Подписать" OnClick="btSign_Click" OnClientClick="if (ckSelected()) return;" EnabledAfter="0" meta:resourcekey="btSignResource1"></cc1:imagetextbutton>
                            </td>
                            <td style='width:1%'>
                                <cc1:imagetextbutton id="btBack" runat="server" buttonstyle="Image" imageurl="/Common\Images\default\16\arrow_left.png"
                                    onclientclick="location.replace('safeportfolio.aspx'); return;" 
                                            tooltip="До портфеля депозитних сейфів" TabIndex="3" EnabledAfter="0" 
                                            ></cc1:imagetextbutton>
                            </td>
                            <td style="width:100%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td>
                                <bars:barsgridview id="gridDocs" runat="server" cssclass="BaseGrid" datasourceid="dsDeals"
                                    datemask="dd/MM/yyyy" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" ShowPageSizeBox="True" OnRowDataBound="gridDocs_RowDataBound" meta:resourcekey="gridDocsResource1">
                                    <Columns>
                                        <asp:BoundField DataField="T" HeaderText="*" HtmlEncode="False" meta:resourcekey="BoundFieldResource1" />
                                        <asp:BoundField DataField="ID" HeaderText="-" SortExpression="ID" meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="NAME" HeaderText="Шаблон" SortExpression="NAME" meta:resourcekey="BoundFieldResource3" />
                                        <asp:BoundField DataField="ADDS" HeaderText="№ доп. согл." SortExpression="ADDS" meta:resourcekey="BoundFieldResource4" />
                                        <asp:BoundField DataField="VERSION" HeaderText="Версия" SortExpression="VERSION" meta:resourcekey="BoundFieldResource5" />
                                        <asp:BoundField DataField="STATE" HeaderText="Подписан" SortExpression="STATE" meta:resourcekey="BoundFieldResource6" />
                                        <asp:BoundField DataField="FIO" HeaderText="Исполнитель" SortExpression="FIO" meta:resourcekey="BoundFieldResource7" />
                                        <asp:BoundField DataField="COMM" HeaderText="Комментарий" SortExpression="COMM" meta:resourcekey="BoundFieldResource8" />
                                    </Columns>
                                </bars:barsgridview>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsDeals" runat="server"></bars:barssqldatasource>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <input type="hidden" runat="server" id="n_sk" />
                    <input type="hidden" runat="server" id="deal_id" />
                    <input type="hidden" runat="server" id="adds" />
                    <input type="hidden" runat="server" id="template" />
                    <input type="hidden" runat="server" id="insert" />
                </td>
            </tr>                        
        </table>        
    </form>
</body>
</html>
