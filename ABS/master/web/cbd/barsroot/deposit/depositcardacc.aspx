<%@ Page language="c#" CodeFile="DepositCardAcc.aspx.cs" AutoEventWireup="true" Inherits="DepositCardAcc" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Вибір карткового рахунку</title>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	</head>
	<body>
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="tb_Main">
				<tr>
					<td align="center">
						<asp:label id="lbTitle" Text="Доступные карточные счета" meta:resourcekey="lbTitle12" runat="server" CssClass="InfoLabel" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid CssClass="BaseGrid" id="gridCardAcc" runat="server"></asp:DataGrid>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
