<%@ Page Language="C#" AutoEventWireup="true" CodeFile="balansacc.aspx.cs" Inherits="BalansAcc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <LINK href="Style.css" type="text/css" rel="stylesheet">
    <LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="Scripts\sBalansAcc.js"></script>
    <script language="JavaScript" src="Scripts\Common.js"></script>
    <script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
    <script language="JavaScript" src="\Common\Script\Localization.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%">
            <tr>
                <td align="center" style="width: 764px; height: 20px">
                    <asp:Label ID="Label1" runat="server" Text="Состояние Счетов (ном.)" Font-Bold="True" meta:resourcekey="Label1Resource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 1028px; height: 24px;">
                    <img src="/Common/Images/REFRESH.gif" onclick="InitGrid()" title="Перечитати" >
                    <img src="/Common/Images/FILTER_.gif" onclick="ShowModalFilter()" title="Фільтр" >
                 </td>
            </tr>
            <tr>
                <td style="width: 764px; height: 20px">
                    <div class="webservice" id="webService" showProgress="true"></div>
                </td>
            </tr>
        </table>
        <!-- #include file="/Common/Include/Localization.inc"-->
		<!-- #include file="/Common/Include/WebGrid2005.inc"-->  
    </form>
</body>
</html>
