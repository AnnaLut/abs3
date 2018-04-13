<%@ Page language="c#" CodeFile="DepositContractTemplate.aspx.cs" AutoEventWireup="false" Inherits="DepositContractTemplate"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Вибір шаблонів договорів</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
		var arr = new Array();		
		function Sel(id)
		{
		 	event.srcElement.checked?arr[id]=id:arr[id]=null;	
		}
		function returnRes()
		{
		    for (key in arr)
		    window.returnValue = arr;
			window.close();
		}
		</script>
	</HEAD>
	<body>
		<script language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable" id="Table1">
				<TR>
					<TD>
						<asp:Label id="lbTitle" CssClass="InfoLabel" runat="server">Виберіть шаблони для формування договору</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:DataGrid id="gridTemplates" runat="server" CssClass="BaseGrid" OnItemDataBound="gridTemplates_ItemDataBound"></asp:DataGrid>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<INPUT class="AcceptButton" id="btSelect" type="button" value="Вибрати" onclick="returnRes();">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
