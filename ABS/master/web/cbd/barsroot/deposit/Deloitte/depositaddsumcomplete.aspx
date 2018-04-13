<%@ Page language="c#" CodeFile="DepositAddSumComplete.aspx.cs" AutoEventWireup="true" Inherits="DepositAddSumComplete"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк додаткової угоди на зміну суми вкладу.</title>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="MainTable" class="MainTable">
				<tr>
					<td align="center" colspan="3">
						<asp:label CssClass="InfoHeader" id="lbInfo" meta:resourcekey="lbInfo14" runat="server">Пополнение депозита</asp:label>
					</td>
				</tr>
				<tr>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td colspan="3">
						<asp:Label CssClass="InfoText" id="lbActionResult" Text="Операция пополнения для депозита № %s выполнена" 
                            meta:resourcekey="lbActionResult" runat="server" />
					</td>
				</tr>
				<tr>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td align="left" style="width:25%">
						<asp:button id="btnSubmit" meta:resourcekey="btnSubmit2" CssClass="AcceptButton" runat="server" Text="Следующий" Enabled="False" />
						<input id="_ID" type="hidden" name="Hidden1" runat="server"/>
					</td>
                    <td align="center" style="width:50%">
                        <asp:Button ID="btnSignDoc" Text="Візування документів" meta:resourcekey="btnSignDoc" runat="server"
                            onclick="btnSignDoc_Click" CssClass="AcceptButton" />
                    </td>
                    <td align="right" style="width:25%">
                        <asp:Button ID="btnContracts" Text="Портфель договорів"  runat="server" 
                            onclick="btnContracts_Click" CssClass="AcceptButton" />
                    </td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
