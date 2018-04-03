<%@ Page language="c#" CodeFile="folder.aspx.cs" AutoEventWireup="false" Inherits="CommunalPayment.Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Просмотр пачки</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>
		<script language="JavaScript" src="Scripts/Folder.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
	</HEAD>
	<body onfocus="fnFocus()">
		<table cellSpacing="0" cellPadding="0" border="0">
			<tr>
				<td><IMG runat="server" meta:resourcekey="btSelectAll" class="out" id="btClear" alt="Выделить все(Ctrl+Alt+A)" onclick="fnSelAll()" src="/Common/Images/CHEKIN.gif"
						width="16">
				<td>&nbsp;<label runat="server" meta:resourcekey="lbP" class="BarsLabel" style="COLOR: maroon">Пачка:</label>
				</td>
				<td><label class="BarsLabel" id="pName" style="COLOR: navy"></label></td>
			</tr>
		</table>
		<div class="webservice" id="webService" showProgress="true"></div>
		<div align=center>
		<INPUT class="bt" runat="server" id="btSave" meta:resourcekey="btSave" style="WIDTH: 80px; HEIGHT: 18px" onclick="Applay()" type="button"
				value="Принять" name="btSave">&nbsp;&nbsp;
		<INPUT class="bt" runat="server" meta:resourcekey="btCancel" style="WIDTH: 80px; HEIGHT: 18px" onclick="Close()" type="button" value="Отмена">
		</div>
		<input type="hidden" runat="server" id="titleFolder" meta:resourcekey="titleFolder" value="Просмотр пачки" />
		<input type="hidden" runat="server" id="Mes28" meta:resourcekey="Mes28" value="Не задан код пачки!" />
		<!-- #include virtual="/Common/Include/Localization.inc"-->
		<!-- #include virtual="/Common/Include/WebGrid2005.inc"-->
	</body>
	<script language="javascript">
		window.document.title = LocalizedString('titleFolder');
	</script>
</HTML>
