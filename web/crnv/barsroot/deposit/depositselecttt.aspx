<%@ Page language="c#" CodeFile="DepositSelectTT.aspx.cs" AutoEventWireup="true" Inherits="DepositSelectTT"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Доступні операції</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body onload="focusControl('btSelect');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center">
						<asp:label id="lbInfo" runat="server" CssClass="InfoHeader">Доступные операции</asp:label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:datagrid id="gridTT" runat="server" AutoGenerateColumns="False" CssClass="BaseGrid">
							<Columns>
								<asp:BoundColumn DataField="tt" HeaderText="Код операции"></asp:BoundColumn>
								<asp:BoundColumn DataField="name" HeaderText="Наименование операции"></asp:BoundColumn>
								<asp:BoundColumn DataField="tt_cash" HeaderText="Касова"></asp:BoundColumn>
							</Columns>
						</asp:datagrid>
					</td>
				</tr>
				<tr>
					<td>
						<input id="btSelect" meta:resourcekey="btSelect" type="button" value="Выбрать" runat="server" tabIndex="1" class="AcceptButton">
					</td>
				</tr>
				<tr>
					<td>
						<input id="dpt_id" type="hidden" runat="server"> <input id="tt" type="hidden" runat="server"><input id="tt_cash" type="hidden" runat="server">
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
