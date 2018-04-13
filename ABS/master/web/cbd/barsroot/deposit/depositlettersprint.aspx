<%@ Page language="c#" CodeFile="DepositLettersPrint.aspx.cs" AutoEventWireup="true" Inherits="DepositLettersPrint" %>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк листів та повідомлень</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" type="text/javascript" src="js/js.js"></script>
		<script language="javascript" type="text/javascript" src="js/cr.js"></script>
		<script language="javascript" type="text/javascript">
			var l_arr   = new Array();			
		</script>
		<meta http-equiv="Pragma" content="no-cache"/>
	</head>
	<body onload="focusControl('textClientName');">
		<form id="Form1" method="post" runat="server">
			<span oncontextmenu="return false;" ondragstart="return false"/>
			<table class="MainTable">
				<tr>
					<td align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle2" runat="server" CssClass="InfoHeader">Печать писем и уведомлений</asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="25%"><asp:label id="lbName" meta:resourcekey="lbName" runat="server" CssClass="InfoText">Имя вкладчика</asp:label></td>
								<td width="15%"></td>
								<td width="60%"><asp:textbox id="textClientName" tabIndex="1" runat="server" CssClass="InfoText"></asp:textbox></td>
							</tr>
							<tr>
								<td><asp:label id="lbDptType" meta:resourcekey="lbDptType" runat="server" CssClass="InfoText">Тип договора</asp:label></td>
								<td><input id="ckUse" onpropertychange="EnableDptType();" tabIndex="2" type="checkbox" CHECKED
										runat="server"> <label runat="server" meta:resourcekey="forckUse" class="BaseCheckBox" for="ckUse">Исп.</label>
								</td>
								<td><asp:dropdownlist id=listDepositType tabIndex=3 runat="server" CssClass="BaseDropDownList" DataValueField="dpt_type" DataTextField="dpt_name" DataSource="<%# dsContractType %>"></asp:dropdownlist></td>
							</tr>
							<tr>
								<td>
								    <asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate" runat="server" CssClass="InfoText">Дата завершения</asp:label>
								</td>
								<td>
								    <asp:dropdownlist id="listOper" tabIndex="4" runat="server" CssClass="BaseDropDownList">
										<asp:ListItem Value="-10">-</asp:ListItem>
										<asp:ListItem Value="-2">&gt;</asp:ListItem>
										<asp:ListItem Value="-1">&gt;=</asp:ListItem>
										<asp:ListItem Value="0">=</asp:ListItem>
										<asp:ListItem Value="1">&lt;=</asp:ListItem>
										<asp:ListItem Value="2">&lt;</asp:ListItem>
										<asp:ListItem Value="10">isNULL</asp:ListItem>
									</asp:dropdownlist></td>
								<td style="HEIGHT: 10px"><igtxt:webdatetimeedit id="dtDptEndDate" tabIndex="5" runat="server" CssClass="InfoDateSum" EditModeFormat="dd/MM/yyyy"
										DisplayModeFormat="dd/MM/yyyy" Enabled="False"></igtxt:webdatetimeedit></td>
							</tr>
							<tr>
								<td><asp:button id="btSearch" meta:resourcekey="btSearch" tabIndex="6" runat="server" CssClass="AcceptButton" Text="Поиск"></asp:button></td>
								<td align="right"><IMG class="Img" id="ckAll" runat="server"  meta:resourcekey="ckAll" onclick="check()" alt="Отметить\Снять выделение" src="/Common/Images/apply.gif"></td>
								<td><input id="dpts" type="hidden" name="Hidden1" runat="server"><input id="clientNames" type="hidden" runat="server"></td>
							</tr>
							<tr>
								<td colSpan="3">
									<div style="OVERFLOW: scroll; HEIGHT: 400px"><asp:datagrid id=gridDeposit runat="server" CssClass="BaseGrid" DataSource="<%# dsResults %>" EnableViewState="False">
										</asp:datagrid></div>
								</td>
							</tr>
						</table>
						<input class="AcceptButton" id="btPrint" meta:resourcekey="btPrint" tabIndex="10000" type="button" value="Печать"
							runat="server">
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</table>
            <!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
