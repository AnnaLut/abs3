<%@ Page language="c#" Inherits="BarsWeb.CheckInner.StornoReason" CodeFile="stornoreason.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Причина сторнирования</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript">
			function PutVal(msg)
			{
				window.returnValue = msg;
				window.close();
			}
		</script>
	</HEAD>
	<body bottomMargin="2" leftMargin="2" topMargin="2" rightMargin="2">
		<form id="Form1" method="post" runat="server">
			<table width="100%" height="100%">
				<tr>
					<td align="center" valign="center">
						<table id="Reason" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial" cellSpacing="0" borderColorDark="#ffffff"
							cellPadding="0" borderColorLight="black" border="1" runat="server">
							<tr style="COLOR: white; BACKGROUND-COLOR: gray; TEXT-ALIGN: center">
								<td runat="server" meta:resourcekey="kCode" class="cellStyle">Код</td>
								<td runat="server" meta:resourcekey="kReason" class="cellStyle">Причина</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" runat="server" id="titleStornoReason" meta:resourcekey="titleStornoReason" value="Причина сторнирования" />
			<script language="javascript">
			window.document.title = LocalizedString('titleStornoReason');
			</script>
		</form>
	</body>
</HTML>
