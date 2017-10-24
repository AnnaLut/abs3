<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QueryAnswer.aspx.cs" Inherits="QueryAnswer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Існуючі запити</title>
    <link href="Style/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="Script/script.js"></script>	
    <script type="text/vbscript"   language="vbscript" src="Script/base.vbs"></script>	    
    <script type="text/javascript" language="javascript" src="Script/base.js"></script>	    
	<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>	
	<link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" language="javascript" src="/Common/WebGrid/Grid.js"></script>
	<script type="text/javascript" language="javascript">var isPostBack = false;</script>
</head>
<body onload="GetQueries()">
    <form id="form1" runat="server">
    <table id="tbMain" class="MainTable">   
    <tr>    
        <td align="center">
            <asp:Label ID="lbTitle" runat="server" Text="Запити у системі" CssClass="HeaderText"></asp:Label>
        </td>
    </tr> 
        <tr>
            <td>
                <img ID="btRefresh" Title="Перечитати" style="CURSOR:hand" src="/Common/Images/REFRESH.gif"
							onclick="ReInitGrid()" height="18">                        
            </td>
        </tr>
    </table>
    <div style="OVERFLOW: scroll;  ; WIDTH: expression(document.body.clientWidth-10)" 
        class="webservice" id="webService" showProgress="true"></div>
    </form>
</body>
</html>
