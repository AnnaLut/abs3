<%@ Page language="c#" CodeFile="DepositAgreementPrint.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementPrint"  enableViewState="False"%>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register assembly="Bars.Web.Controls.2" namespace="UnityBars.WebControls" tagprefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк додаткових угод</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript">
		function FOCUS() {
			if (!document.getElementById('btForm').disabled)
				focusControl('btForm');
			else if (!document.getElementById('btPrint').disabled)
				focusControl('btPrint');
		}
		</script>
	</head>
	<body onload="FOCUS();">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center" colspan="2">
                        <asp:label id="lbTitle" meta:resourcekey="lbTitle6" runat="server" CssClass="InfoLabel">Печать доп.соглашения</asp:label></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td style="width:30%"><asp:label id="lbDpt" meta:resourcekey="lbDpt" runat="server" CssClass="InfoText" Text="Депозитный договор №"></asp:label></td>
					<td><asp:textbox id="textDptNum" runat="server" ReadOnly="True" CssClass="InfoText25"></asp:textbox></td>
				</tr>
				<tr>
					<td><asp:label id="lbAgrType" meta:resourcekey="lbAgrType" runat="server" CssClass="InfoText">Тип доп. соглашения</asp:label></td>
					<td><asp:textbox id="textAgrType" runat="server" ReadOnly="True" CssClass="InfoText"></asp:textbox></td>
				</tr>
				<tr>
					<td>
                        <asp:label id="Label1" meta:resourcekey="Label1_4" runat="server" CssClass="InfoText">Дата заключения</asp:label>
					</td>
					<td><igtxt:webdatetimeedit id="dtDate" runat="server" ReadOnly="True" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"
							HorizontalAlign="Center" BorderStyle="Inset" CssClass="InfoDateSum"></igtxt:webdatetimeedit></td>
				</tr>
                <tr id="trDover1" runat="server" visible="false" >
                    <td class="td_title">
                        <asp:Label ID="Label2" runat="server" CssClass="InfoText" Text="Термін дії довіреності"></asp:Label>
                    </td>
                    <td>
                        <table class="InnerTable">
                            <tr>
                                <td style="width:10%">
                                    <asp:Label ID="Label3" runat="server" CssClass="InfoText" Text="з"></asp:Label>
                                </td>
                                <td style="width:20%">
                                    <cc1:DateEdit ID="dtBegin" runat="server"></cc1:DateEdit>
                                </td>
                                <td style="width:10%"></td>
                                <td style="width:10%">
                                    <asp:Label ID="Label4" runat="server" CssClass="InfoText" Text="по"></asp:Label>
                                </td>
                                <td style="width:50%">
                                    <cc1:DateEdit ID="dtEnd" runat="server"></cc1:DateEdit>
                                </td>
                            </tr>
                        </table>                        
                    </td>
                </tr>
                <tr>
					<td>
                        <input id="textAgrId" type="hidden" runat="server"/>
                        <input id="textAgrNum" type="hidden" runat="server"/>
						<input id="template" type="hidden" runat="server"/>
                        <input id="dpt_id" type="hidden" runat="server"/>
					</td>
					<td>
					    <asp:CompareValidator ID="CompareValidator1" runat="server" 
                            ControlToCompare="dtBegin" ControlToValidate="dtEnd" 
                            ErrorMessage="Дата початку має бути меншою за дату завершення, або дата завершення має бути порожньою" 
                            Operator="GreaterThanEqual" Type="Date">
					    </asp:CompareValidator>
					</td>
				</tr>
				<tr id="trDover4" runat="server" visible="false">
                    <td class="td_title">
                        <asp:Label ID="lbAlowedOperations" runat="server" CssClass="InfoText" Text="Дозволенні операції" />
                    </td>
                    <td>
                        <asp:CheckBoxList ID="cblAlowedOperations" runat="server" TabIndex="104">
                            <asp:ListItem Text="Отримання виписок за рахунком" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Отримання вкладу (депозиту) відсотків в останній день дії договору" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Дострокове повернення вкладу (депозиту)" Value="2"></asp:ListItem>
                        </asp:CheckBoxList>
                    </td>
                </tr>
				<tr>
                    <td colspan="2">
                        <table class="InnerTable" width="100%" >
                            <tr>
                                <td style="width:25%" align="left">
                                    <asp:button id="btForm" meta:resourcekey="btForm2" tabIndex="1" runat="server" 
                                        Text="Формировать текст" CssClass="AcceptButton"></asp:button>
                                </td>
					            <td style="width:25%" align="center">
                                    <input  id="btPrint" meta:resourcekey="btPrint" disabled="disabled" tabIndex="2" runat="server"
                                        type="button" value="Печать" class="AcceptButton" />
					            </td>
                                <td style="width:25%" align="center">
                                </td>
                                <td style="width:25%" align="right">
                                    <asp:button id="btNextAgr" meta:resourcekey="btNextAgr" tabIndex="3" runat="server" Text="Следующее" 
                                        Visible="False" ToolTip="Следующее доп. соглашение на текущий договор" CssClass="AcceptButton" />
                                </td>
				            </tr>
                        </table>
                    </td>
                </tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
