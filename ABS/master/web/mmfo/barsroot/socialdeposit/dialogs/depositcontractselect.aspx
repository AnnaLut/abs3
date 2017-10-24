<%@ Page language="c#" CodeFile="DepositContractSelect.aspx.cs" AutoEventWireup="false" Inherits="DepositContractSelect" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Друк договорів</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
		 // Друк депозитного договору
         function Print(template){
            window.showModalDialog("../DepositPrint.aspx?dpt_id="+document.getElementById("_ID").value+
            "&template="+template+"&code=" + Math.random(),null,
	        "dialogWidth:800px; dialogHeight:800px; center:yes; status:no");
	     }     
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable" id="Table1">
				<TR>
					<TD><asp:label id="lbTitle" runat="server" CssClass="InfoLabel">Друк угод</asp:label></TD>
				</TR>
				<TR>
					<TD><asp:datagrid id="gridContract" runat="server" CssClass="BaseGrid" OnItemDataBound="gridContract_ItemDataBound"></asp:datagrid></TD>
				</TR>
				<TR>
					<TD><INPUT id="_ID" type="hidden" runat="server"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
