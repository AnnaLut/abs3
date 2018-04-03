<%@ Page language="c#" Inherits="barsweb.References.RefList"  enableViewState="False" uiCulture="uk" CodeFile="RefList.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Справочники</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="References.css" type="text/css" rel="Stylesheet"/>
		<script language="javascript">
		      function subMenu(id)
		      {
					var img = document.getElementById('i_'+id);
					var obj = document.getElementById('o_'+id);
		            if(obj.style.display == 'none'){
						obj.style.display = '';			
						//img.src="images/uparrows.gif";
		            }
		            else {
						obj.style.display = 'none';
						//img.src="images/downarrows.gif";
					}	
		      }
		</script>
	</HEAD>
	<body>
		<form id="FormRefList" method="post" runat="server">
			<TABLE id="TableMain" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD vAlign="bottom" align="left"><asp:label id="LabelReferences" meta:resourcekey="LabelReferences" runat="server" Font-Bold="True" EnableViewState="False">СПРАВОЧНИКИ</asp:label></TD>
				</TR>
				<TR>
					<TD align="left"><asp:PlaceHolder id="listRef" runat="server" EnableViewState="False"></asp:PlaceHolder></TD>
				</TR>
				<TR>
					<TD align="left" height="100%"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
