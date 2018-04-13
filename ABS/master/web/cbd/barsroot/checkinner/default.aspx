<%@ Page language="c#" Inherits="BarsWeb.CheckInner._default"  CodeFile="default.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Выбор группы контроля</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="CSS/AppStyles.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" src="JScript/additionalFuncs.js"></script>
		<script language="javascript" src="JScript/Script.js"></script>
		<script language="javascript">
			function btSubmitClick()
			{
				if(getEl('lstb_Visa').options.length > 0)
				{				
					GetDocsList(getEl('lstb_Visa').item(getEl('lstb_Visa').selectedIndex).value)
				}
				else
				{
					alert(LocalizedString('Message0'));
				}
			}
		</script>
	</HEAD>
	<body>
		<form id="MainForm" method="post" runat="server">
			<table cellpadding="0" cellspacing="0" width="100%" height="80%">
				<tr>
					<td align="center" valign="middle">
						<table cellpadding="0" cellspacing="0" style="BORDER-RIGHT: #000000 2px solid; BORDER-TOP: #000000 2px solid; BORDER-LEFT: #000000 2px solid; WIDTH: 300px; BORDER-BOTTOM: #000000 2px solid; BACKGROUND-COLOR: whitesmoke">
							<tr>
								<td runat="server" meta:resourcekey="controlgroup"  style="FONT-WEIGHT: bold; HEIGHT: 40px; TEXT-ALIGN: center">Выбор группы 
									контроля</td>
							</tr>
							<tr>
								<td>
									<SELECT size="5" style="WIDTH: 100%" id="lstb_Visa" runat="server">
										<OPTION></OPTION>
									</SELECT>
								</td>
							</tr>
							<tr>
								<td align="center" style="PADDING-BOTTOM: 10px; PADDING-TOP: 20px">
									<INPUT class="buttonOkStyle" runat="server" id="bt_select" meta:resourcekey="bt_select" type="button" value="Выбрать" onclick="btSubmitClick()">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<input runat="server" type="hidden" id="Message0" meta:resourcekey="Message0" value="Вашему пользователю не выдана ни одна группа визирования!" />
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Введите дату(пример 22.11.1984)!" />
		<input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="Введите число!" />
		<input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="Заполните поле!" />
		<input type="hidden" runat="server" id="titleDefault" meta:resourcekey="titleDafault" value="Выбор группы контроля" />
		<script language="javascript">
		window.document.title = LocalizedString('titleDefault');
		</script>
		</form>
	</body>
</HTML>
