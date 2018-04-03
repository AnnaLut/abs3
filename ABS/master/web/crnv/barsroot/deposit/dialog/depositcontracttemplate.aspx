<%@ Page language="c#" CodeFile="DepositContractTemplate.aspx.cs" AutoEventWireup="true" Inherits="DepositContractTemplate" meta:resourcekey="PageResource1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Вибір шаблонів договорів</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="../style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript">
		    var arr = new Array();		
		    function Sel(id)
		    {
			    event.srcElement.checked?arr[id]=id:arr[id]=null;	
		    }
		    function returnRes()
		    {
			    window.returnValue = arr;
			    window.close();
		    }
		</script>
	</head>
	<body>
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="Table1">
				<tr>
					<td>
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle14" CssClass="InfoLabel" runat="server">Выберите шаблоны для формирования договора</asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid id="gridTemplates" runat="server" CssClass="BaseGrid" meta:resourcekey="gridTemplatesResource1"></asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input class="AcceptButton" runat="server" id="btSelect" meta:resourcekey="btSelect" type="button" value="Выбрать" onclick="returnRes();"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
