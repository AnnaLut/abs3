<%@ Page language="c#" CodeFile="SelectCountry.aspx.cs" AutoEventWireup="false" Inherits="SelectCountry" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Вибір країни</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="../Scripts/Default.js"></script>
		<LINK href="../style.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload="focusControl('btDone');">
		<script language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" class="MainTable">
				<TR>
					<TD>
						<asp:Label id="Label1" runat="server" CssClass="InfoLabel">Виберіть із списку країну</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:DropDownList id=listCountry CssClass="BaseDropDownList" 
						runat="server" DataSource="<%# dsCountry %>" DataTextField="name" 
						DataValueField="country">
						</asp:DropDownList>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<INPUT id="btDone" class="AcceptButton" type="button" onclick="Exit()" value="Вибрати"
							tabIndex="1" name="btDone">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
