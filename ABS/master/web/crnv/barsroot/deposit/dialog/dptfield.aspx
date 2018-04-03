<%@ Page language="c#" CodeFile="DptField.aspx.cs" AutoEventWireup="true" Inherits="DptField" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Додаткові реквізити вкладу</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="../style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable" id="tbDptField" runat="server">
							<tr>
								<td colspan="3" align="center">
									<asp:Label id="lbTitle" meta:resourcekey="lbTitle16" runat="server" CssClass="InfoLabel">Доп. реквизиты вклада № %s</asp:Label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Button id="btUpdate" meta:resourcekey="btUpdate" runat="server" Text="Обновить" CssClass="AcceptButton"></asp:Button>
					</td>
				</tr>
				<tr>
					<td>
						<input id="dpt_controls" type="hidden" runat="server" />
						<input id="mand_field" type="hidden" runat="server" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
