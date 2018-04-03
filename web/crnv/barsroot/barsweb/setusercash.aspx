<%@ Page language="c#" Inherits="barsweb.SetUserCash"  enableViewState="True" debug="False" CodeFile="setusercash.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SetUserCash</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="custom.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="FormMain" method="post" runat="server">
			<TABLE id="CenteringTable" height="100%" width="100%">
				<TR>
					<TD height="20%" vAlign="top" align="right">
						<asp:Label id="LabelCurrentCash" meta:resourcekey="LabelCurrentCash" runat="server" Font-Size="X-Small" EnableViewState="False">Активная касса</asp:Label>
						&nbsp;
						<asp:TextBox id="textCurrentCash" runat="server" Font-Size="X-Small" EnableViewState="False"
							Wrap="False" CssClass="centerme" ReadOnly="True" Width="136px"></asp:TextBox>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="HeadTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD style="FONT-WEIGHT: bold" align="center">
									<asp:Label id="LabelSetupCash" meta:resourcekey="LabelSetupCash" runat="server" EnableViewState="False">Установка активной кассы</asp:Label></TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="SelectTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD>
									<asp:Label id="LabelChoose" meta:resourcekey="LabelChoose" runat="server" EnableViewState="False">Выберите счет</asp:Label>&nbsp;&nbsp;</TD>
								<TD>
									<asp:DropDownList id="listNLS" runat="server" Width="160px" AutoPostBack="True" onload="listNLS_Load" onselectedindexchanged="listNLS_SelectedIndexChanged"></asp:DropDownList></TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="MainTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD></TD>
								<TD>
									<asp:DataGrid id="dg" runat="server" EnableViewState="False" AutoGenerateColumns="False" CellPadding="3"
										BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" BackColor="White" Font-Size="X-Small">
										<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#669999"></SelectedItemStyle>
										<ItemStyle ForeColor="#000066"></ItemStyle>
										<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#006699"></HeaderStyle>
										<FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
										<Columns>
											<asp:BoundColumn DataField="kv" HeaderText="Валюта">
												<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
												<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
											</asp:BoundColumn>
											<asp:BoundColumn DataField="nls" HeaderText="Лицевой">
												<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
												<ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
											</asp:BoundColumn>
											<asp:BoundColumn DataField="nms" HeaderText="Наименование">
												<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
												<ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
											</asp:BoundColumn>
										</Columns>
										<PagerStyle HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></PagerStyle>
									</asp:DataGrid></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD height="80%"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
