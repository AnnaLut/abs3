<%@ Page language="c#" Inherits="barsweb.SetToboCookie" CodeFile="settobocookie.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Установка текущего ТОБО</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body>
		<form id="FormToboCookie" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" height="100%">
				<tr height="30%">
					<td></td>
				</tr>
				<tr>
					<td meta:resourcekey="tdReg" runat="server" style="FONT-SIZE: 12pt; COLOR: red; FONT-FAMILY: Arial" align="center">Необходимо 
						зарегистрировать данный компьютер в одном из доступных Вам отделений!
					</td>
				</tr>
				<tr>
					<td style="HEIGHT: 200px" vAlign="middle" align="center"><SELECT id="lsb_ToboData" style="WIDTH: 400px" size="10" runat="server">
							<OPTION></OPTION>
						</SELECT></td>
				</tr>
				<tr>
					<td vAlign="middle" align="center"><input id="bt_Ok" meta:resourcekey="bt_Ok" style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; WIDTH: 145px; COLOR: darkgreen; FONT-FAMILY: Arial; HEIGHT: 24px"
							type="button" value="Выбрать" runat="server"></td>
				</tr>
				<tr height="70%">
					<td></td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
