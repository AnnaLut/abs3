<%@ Page language="c#" CodeFile="DepositAgreementPrint.aspx.cs" AutoEventWireup="false" Inherits="DepositAgreementPrint"  enableViewState="False"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Друк додаткових угод</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
		<script>
		function FOCUS() {
			if (!document.getElementById('btForm').disabled)
				focusControl('btForm');
			else if (!document.getElementById('btPrint').disabled)
				focusControl('btPrint');
		}
		</script>
	</HEAD>
	<body onload="FOCUS();">
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD align="center" colSpan="2">
					    <asp:label id="lbTitle" runat="server" CssClass="InfoLabel">Друк додаткової угоди</asp:label>
					</TD>
				</TR>
				<TR>
					<TD colSpan="2"></TD>
				</TR>
				<TR>
					<TD width="30%"><asp:label id="lbDpt" runat="server" CssClass="InfoText">Соціальний договір №</asp:label></TD>
					<TD><asp:textbox id="textDptNum" runat="server" ReadOnly="True" CssClass="InfoText"></asp:textbox></TD>
				</TR>
				<TR>
					<TD><asp:label id="lbAgrType" runat="server" CssClass="InfoText">Тип дод. угоди</asp:label></TD>
					<TD><asp:textbox id="textAgrType" runat="server" ReadOnly="True" CssClass="InfoText"></asp:textbox></TD>
				</TR>
				<TR>
					<TD><asp:label id="Label1" runat="server" CssClass="InfoText">Дата формування</asp:label></TD>
					<TD><igtxt:webdatetimeedit id="dtDate" runat="server" ReadOnly="True" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"
							HorizontalAlign="Center" BorderStyle="Inset" CssClass="InfoDateSum"></igtxt:webdatetimeedit></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD><INPUT id="textAgrId" type="hidden" runat="server"> <INPUT id="textAgrNum" type="hidden" runat="server">
						<INPUT id="template" type="hidden" runat="server"><INPUT id="textDptId" type="hidden" runat="server">
					</TD>
				</TR>
				<TR>
					<TD><asp:button id="btForm" tabIndex="1" runat="server" Text="Формувати текст" CssClass="AcceptButton"></asp:button></TD>
					<TD><INPUT class="AcceptButton" id="btPrint" disabled tabIndex="2" type="button" value="Друк"
							runat="server">
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD><asp:button id="btNextAgr" tabIndex="3" runat="server" Text="Наступна" Visible="False"
							CssClass="AcceptButton"></asp:button>
				    </TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
