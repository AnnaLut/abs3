<%@ Page language="c#" CodeFile="DepositAddSumComplete.aspx.cs" AutoEventWireup="true" Inherits="DepositAddSumComplete"  enableViewState="False"%>

<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк додаткової угоди на зміну суми вкладу.</title>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.1"></script>	
        <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.js"></script>
        <script type="text/javascript" language="javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
        <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.alerts.js"></script>
        <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.blockUI.js"></script>
        <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.custom.js"></script>
        <link href="/Common/CSS/jquery/jquery.1.8.css?v1.1" type="text/css" rel="stylesheet" />
        <link href="/Common/CSS/jquery/custom.css?v1.1" type="text/css" rel="stylesheet" />
        <link href="/Common/CSS/BarsGridView.css?v1.1" type="text/css" rel="stylesheet" />
	
	    <style type="text/css">
            .auto-style1 {
                height: 23px;
            }
            .auto-style2 {
                height: 20px;
            }
        </style>
	
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <ajax:ToolkitScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true">
        </ajax:ToolkitScriptManager>
    
			<table id="MainTable" class="MainTable">
				<tr>
					<td align="center" colspan="4">
						<asp:label CssClass="InfoHeader" id="lbInfo" meta:resourcekey="lbInfo14" runat="server">Пополнение депозита</asp:label>
					</td>
				</tr>
				<tr>
					<td colspan="4" class="auto-style1"></td>
				</tr>
				<tr>
					<td colspan="4" class="auto-style2">
						<asp:Label CssClass="InfoText" id="lbActionResult" Text="Операция пополнения для депозита № %s выполнена" 
                            meta:resourcekey="lbActionResult" runat="server" />
					</td>
				</tr>
				<tr>
					<td colspan="4"></td>
				</tr>
				<tr>
					<td align="left" style="width:25%">
						<asp:button id="btnSubmit" meta:resourcekey="btnSubmit2" CssClass="AcceptButton" runat="server" Text="Следующий" Enabled="False" />
						<input id="_ID" type="hidden" name="Hidden1" runat="server"/>
					</td>
                    <td align="center" style="width:25%">
                        <asp:Button ID="btnSignDoc" Text="Візування документів" meta:resourcekey="btnSignDoc" runat="server"
                            CssClass="AcceptButton" OnClientClick="SetVisa(); return false;" />
                    </td>
                    <td align="center" style="width:25%">
                        <asp:Button ID="btnDptContract" Text="Картка вкладу" meta:resourcekey="btnDptContract" runat="server"
                            CssClass="AcceptButton" onclick="btnDptContract_Click"  Enabled ="false"  />
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
