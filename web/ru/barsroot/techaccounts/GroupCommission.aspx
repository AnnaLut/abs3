<%@ Page Language="C#" AutoEventWireup="true" CodeFile="groupcommission.aspx.cs" Inherits="GroupCommission" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Комісія по безготівкових поповненнях</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>     
    <script type="text/javascript">
        var refs2pay = new Array();
    </script>   
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Безготівкове поповнення технічного рахунку"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td>
                                <asp:Label ID="Label2" runat="server" CssClass="InfoLabel" Text="Безготівкові поповнення по яких не були взяті комісії"></asp:Label></td>
                        </tr>
                        <tr>
                            <td>
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width:25%">
                                            <input id="btCheck" class="DirectionButton" type="button" value="Вибрати"
                                             onclick="CheckAll()" />
                                        </td>
                                        <td style="width:25%">
                                            <input id="btPay" class="DirectionButton" type="button" value="Оплатити"
                                             onclick="PayCommissionAll()" />
                                         </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <Bars:BarsGridView ID="gridTechAccCredit" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" CssClass="BaseGrid" DataSourceID="dsTechAccCredit"
                                    DateMask="dd/MM/yyyy" OnRowDataBound="gridTechAccCredit_RowDataBound" TabIndex="4" ShowPageSizeBox="True">
                                    <PagerSettings PageButtonCount="5" />
                                    <Columns>
                                        <asp:BoundField DataField="TAKE" HtmlEncode="False" >
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="REF" HtmlEncode="False">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DREF" HeaderText="Референс" HtmlEncode="False" SortExpression="DREF" />
                                        <asp:BoundField DataField="NLS" HeaderText="Номер рахунку" HtmlEncode="False" SortExpression="NLS">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SUM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сума"
                                            HtmlEncode="False" SortExpression="SUM">
                                            <itemstyle horizontalalign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LCV" HeaderText="Валюта" HtmlEncode="False" SortExpression="LCV">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DAT" HeaderText="Дата" HtmlEncode="False" SortExpression="DAT">
                                            <itemstyle horizontalalign="Center" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" HtmlEncode="False" SortExpression="NAZN">
                                            <itemstyle horizontalalign="Left" />
                                        </asp:BoundField>
                                    </Columns>
                                </Bars:BarsGridView>
                            </td>
                        </tr>                        
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" CssClass="InfoLabel" Text="Безготівкові поповнення по яких взяті комісії"></asp:Label></td>
            </tr>
            <tr>
                <td><Bars:BarsGridView ID="gridPaidDocs" runat="server" AllowPaging="True" AllowSorting="True"
                                    AutoGenerateColumns="False" CssClass="BaseGrid" DataSourceID="dsPaid"
                                    DateMask="dd/MM/yyyy" TabIndex="4" ShowPageSizeBox="True">
                    <PagerSettings PageButtonCount="5" />
                    <Columns>
                        <asp:BoundField DataField="REFL" HtmlEncode="False" HeaderText="Реф. комісії" SortExpression="REFL" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="REF" HtmlEncode="False" HeaderText="Реф. документу" SortExpression="REF">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NLS" HeaderText="Номер рахунку" HtmlEncode="False" SortExpression="NLS">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сума"
                                            HtmlEncode="False" SortExpression="SUM">
                            <itemstyle horizontalalign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LCV" HeaderText="Валюта" HtmlEncode="False" SortExpression="LCV">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DAT" HeaderText="Дата" HtmlEncode="False" SortExpression="DAT">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NAZN" HeaderText="Призначення" HtmlEncode="False" SortExpression="NAZN">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                    </Columns>
                </Bars:BarsGridView>
                </td>
            </tr>
            <tr>
                <td>
                    <Bars:barssqldatasource  ProviderName="barsroot.core" ID="dsTechAccCredit" runat="server">
                                </Bars:barssqldatasource><Bars:barssqldatasource ProviderName="barsroot.core" ID="dsPaid" runat="server">
                                </Bars:barssqldatasource>
                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
                        <Scripts>
                            <asp:ScriptReference Path="JScript.js" />
                        </Scripts>
                    </asp:ScriptManager>
                    <input id="clientIDs" runat="server" type="hidden" />
                </td>
            </tr>
        </table>
    
    </div>
    </form>
        <script language="javascript" type="text/javascript">
        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
</body>
</html>
