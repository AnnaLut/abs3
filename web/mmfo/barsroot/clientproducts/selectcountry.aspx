<%@ Page language="c#" CodeFile="SelectCountry.aspx.cs" AutoEventWireup="true" Inherits="SelectCountry" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Вибір країни</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
	</head>
	<body onload="focusControl('btDone');">
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<table id="Table1" class="MainTable">
				<tr>
					<td>
						<asp:Label id="Label1" Text="Виберіть країну із списку" meta:resourcekey="Label1" runat="server" CssClass="InfoLabel" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:DropDownList id="listCountry" CssClass="BaseDropDownList" runat="server" 
						    DataSource="<%# dsCountry %>" DataTextField="name" DataValueField="country" />
					</td>
				</tr>
				<tr>
					<td align="center">
						<input id="btDone" meta:resourcekey="btDone" runat="server" class="AcceptButton" type="button" onclick="Exit()" 
                            value="Выбрать" tabindex="1" name="btDone"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
