<%@ Register TagPrefix="cc1" Namespace="Bars.Grid" Assembly="Bars.Grid, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c" %>
<%@ Page language="c#" CodeFile="MyTrans.aspx.cs" AutoEventWireup="false" Inherits="mobinet.MyTrans" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>MyTrans</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="JavaScript" src="util.js"></script>
		<LINK href="ws.css" type="text/css" rel="stylesheet">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<link href="/Common/CSS/AppCSS.css" type="text/css" rel=Stylesheet />
		<script language="javascript">
		      <!--			  
		      //-->
		</script>
	</HEAD>
	<body onbeforeunload="Dispose()" onload="Init(null)">
		<div class="webservice" id="webServiceSync"></div>
		<div class="webservice" id="webServiceAsync"></div>
		<form id="FormMyTrans" name="FormMyTrans" method="post" runat="server">
			<INPUT id="hBankRef" type="hidden" name="hBankRef"> <INPUT id="hMobiCheque" type="hidden" name="hMobiCheque">
			<TABLE id="HeadTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR>
					<TD style="FONT-WEIGHT: bold" align="left"><asp:label id="theTitle" runat="server">Свои транзакции пополнения счета за сегодня</asp:label></TD>
				</TR>
			</TABLE>
			<BR>
			<asp:datagrid id="dg" runat="server" CssClass="base_grid" Width="100%" EnableViewState="False"
				AllowSorting="True" AutoGenerateColumns="False" PageSize="20">
				<Columns>
					<asp:BoundColumn DataField="trans_span" SortExpression="trans" ReadOnly="True" HeaderText="№ тр-ции">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="act" SortExpression="act" ReadOnly="True" HeaderText="Действие">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="trans_time" SortExpression="trans_time" ReadOnly="True" HeaderText="Время тр-ции"
						DataFormatString="{0:dd.MM.yyyy HH:mm:ss}">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="phone" SortExpression="phone" ReadOnly="True" HeaderText="Телефон">
						<HeaderStyle Wrap="False" HorizontalAlign="Center" Width="120px"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="name" SortExpression="name" ReadOnly="True" HeaderText="ФИО">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Left"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="s" SortExpression="s" ReadOnly="True" HeaderText="Сумма" DataFormatString="{0:### ### ### ### ##0.00}">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Right"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="trans_status" SortExpression="trans_status" ReadOnly="True" HeaderText="Статус тр-ции">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="check_status" SortExpression="check_status" ReadOnly="True" HeaderText="Статус проверки"
						DataFormatString="{0:N0}">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="check_time" SortExpression="check_time" ReadOnly="True" HeaderText="Время проверки"
						DataFormatString="{0:dd.MM.yyyy HH:mm:ss}">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="complete_status" SortExpression="complete_status" ReadOnly="True" HeaderText="Статус подтв."
						DataFormatString="{0:N0}">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="complete_time" SortExpression="complete_time" ReadOnly="True" HeaderText="Время подтв."
						DataFormatString="{0:dd.MM.yyyy HH:mm:ss}">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="bdate" SortExpression="bdate" HeaderText="Дата валютирования" DataFormatString="{0:dd.MM.yyyy}">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:HyperLinkColumn DataNavigateUrlField="ref_url" DataTextField="ref" SortExpression="ref" HeaderText="Документ">
						<HeaderStyle Wrap="False" HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:HyperLinkColumn>
					<asp:HyperLinkColumn DataNavigateUrlField="sep_ref_url" DataTextField="sep_ref" SortExpression="sep_ref"
						HeaderText="Док-т СЭП">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:HyperLinkColumn>
					<asp:BoundColumn DataField="sep_time" SortExpression="sep_time" ReadOnly="True" HeaderText="Время СЭП"
						DataFormatString="{0:dd.MM.yyyy HH:mm:ss}">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="toboname" SortExpression="toboname" HeaderText="Отделение">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="opname" SortExpression="opname" HeaderText="Оператор">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Wrap="False"></ItemStyle>
					</asp:BoundColumn>
				</Columns>
			</asp:datagrid></form>
	</body>
</HTML>
