<%@ Page Language="C#" AutoEventWireup="true" CodeFile="balans.aspx.cs" Inherits="Balans" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Баланс-Счет-Документ</title>
    <LINK href="Style.css" type="text/css" rel="stylesheet">
    <LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="Scripts\sBalans.js"></script>
    <script language="JavaScript" src="Scripts\Common.js"></script>
    <script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
    <script language="JavaScript" src="\Common\Script\Localization.js"></script>
</head>
<body>
    <form id="form1" runat="server">
      <table width="100%">
            <tr>
                <td align="center" style="width: 1028px; height: 20px;">
                    <asp:Label ID="Label1" runat="server" Text="Состояние БАЛАНСА (экв.)" Font-Bold="True" meta:resourcekey="Label1Resource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 1028px; height: 24px;">
                    <select style="width: 150px" id="ddFDat" onclick="dlgFDat()">
                        <option value=''></option>
                    </select>
                    <img src="/Common/Images/REFRESH.gif" onclick="PopulateTable()" title="Перечитать" id="IMG1" runat="server" meta:resourcekey="IMG1">
                    <img src="/Common/Images/FILTER_.gif" onclick="fnFilter()" title="Фильтр" id="IMG2" runat="server" meta:resourcekey="IMG2">
                    <INPUT id="cbTobo" onclick="SetTobo()"
						tabIndex="1" type="checkbox" CHECKED runat="server">
					<DIV id="DIV1" runat="server" class="simpleTextStyle" style="DISPLAY: inline">По отделению</DIV>
                    <select style="width: 250px" id="ddTobo" onclick="dlgTobo()">
                        <option value=''></option>
                    </select>
                 </td>
            </tr>
            <tr>
                <td style="height: 20px; width: 1028px;">
                    <div class="webservice" id="webService" showProgress="true">
                    </div>
                </td>
            </tr>
        </table>
        <!-- #include file="/Common/Include/Localization.inc"-->
		<!-- #include file="/Common/Include/WebGrid2005.inc"-->  
        <!--<asp:HiddenField ID="TestControl" runat="server" meta:resourcekey="TestControl" /> -->
    </form>
</body>
</html>
