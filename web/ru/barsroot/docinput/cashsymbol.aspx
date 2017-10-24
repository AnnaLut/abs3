<%@ Register TagPrefix="bars" Namespace="Bars.Grid" Assembly="Bars.Grid, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c" %>
<%@ Page language="c#" CodeFile="cashsymbol.aspx.cs" AutoEventWireup="false" Inherits="DocInput.CashSymbol"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Символи касплану</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<base target="_self">
	</HEAD>
	<body>
		<form id="FormSK" method="post" runat="server">
			<bars:BaseGrid id="gsk" runat="server" ShowFilter="False" ShowTitle="False" SetFocusOnFilter="False"
				AllowCustomPaging="True" AutoGenerateColumns="False" GridTitle="ПОМЕНЯЙ ЗАГОЛОВОК!" AllowSorting="True"
				EnableViewState="False" AllowPaging="True" PageSize="20" Width="100%">
				<Columns>
					<asp:BoundColumn DataField="sk" SortExpression="sk" ReadOnly="True" HeaderText="Код">
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="name" SortExpression="name" HeaderText="Текст">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
					</asp:BoundColumn>
				</Columns>
				<PagerStyle Mode="NumericPages"></PagerStyle>
			</bars:BaseGrid>
		</form>
	</body>
</HTML>
