<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositBFRowCorrection.aspx.cs" AutoEventWireup="true" Inherits="DepositBFRowCorrection"  enableViewState="True"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Коректування банківського файлу</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<base target="_self" />
		<meta content="C#" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../style/dpt.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="../js/ck.js"></script>
	</head>
	<body>
		<script type="text/javascript" language="javascript">
			document.onkeydown = function(){if(event.keyCode==27) window.close();}
		</script>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle17" runat="server" CssClass="InfoHeader">Редактирование записей файла зачислений</asp:label></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td style="width:5%"><asp:label id="lbNLSs" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td style="width:15%"><asp:label id="lbNLS" meta:resourcekey="lbNLS" runat="server" CssClass="InfoText">Счет</asp:label></td>
								<td style="width:40%"><asp:textbox id="textNLS" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td style="width:30%"><asp:requiredfieldvalidator id="vNLS" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textNLS" ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbBranchCodes" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbBranchCode" meta:resourcekey="lbBranchCode" runat="server" CssClass="InfoText">Код отделения</asp:label></td>
								<td><asp:textbox id="textBranchCode" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vBranchCode" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textBranchCode"
										ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbDptCodes" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbDptCode" meta:resourcekey="lbDptCode" runat="server" CssClass="InfoText">Код вклада</asp:label></td>
								<td><asp:textbox id="textDptCode" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vDptCode" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textDptCode"
										ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td><asp:label id="lbSums" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbSum" meta:resourcekey="lbSum3" runat="server" CssClass="InfoText">Сумма</asp:label></td>
								<td><igtxt:webnumericedit id="Sum" runat="server" CssClass="InfoDateSum" MinDecimalPlaces="SameAsDecimalPlaces"
										DataMode="Decimal" MaxLength="10"></igtxt:webnumericedit></td>
								<td></td>
							</tr>
							<tr>
								<td><asp:label id="lbFios" runat="server" CssClass="InfoText" ForeColor="Red">*</asp:label></td>
								<td><asp:label id="lbFIO" meta:resourcekey="lbFIO2" runat="server" CssClass="InfoText">ФИО</asp:label></td>
								<td><asp:textbox id="textFIO" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td><asp:requiredfieldvalidator id="vFIO" meta:resourcekey="NeedToFill" runat="server" CssClass="Validator" ControlToValidate="textFIO" ErrorMessage="Необходимо заполнить"></asp:requiredfieldvalidator></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbPasp" meta:resourcekey="lbPasp" runat="server" CssClass="InfoText">Паспортные данные</asp:label></td>
								<td><asp:textbox id="textPasp" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437"></asp:textbox></td>
								<td></td>
							</tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbBranch" runat="server" CssClass="InfoText" meta:resourcekey="lbBranch">Отделение</asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddBranch" runat="server" CssClass="BaseDropDownList">
                                    </asp:DropDownList></td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbAgency" runat="server" CssClass="InfoText" meta:resourcekey="lbAgency">Орган соц. обезпечения</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textAgency" runat="server" CssClass="InfoText" Enabled="False"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
							<tr>
								<td></td>
								<td><asp:label id="lbRef" meta:resourcekey="lbRef" runat="server" CssClass="InfoText">Референс</asp:label></td>
								<td><asp:textbox id="textRef" runat="server" CssClass="InfoText" DESIGNTIMEDRAGDROP="437" Enabled="False"></asp:textbox></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbIncorrect" meta:resourcekey="lbIncorrect" runat="server" CssClass="InfoText">Некоректный</asp:label></td>
								<td><input id="ckIncorrect" disabled="disabled" type="checkbox" name="Checkbox1" runat="server"/></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbClosed" meta:resourcekey="lbClosed" runat="server" CssClass="InfoText">Счет закрыт</asp:label></td>
								<td><input id="ckClosed" disabled="disabled" type="checkbox" name="Checkbox1" runat="server"/></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td><asp:label id="lbExcluded" meta:resourcekey="lbExcluded" runat="server" CssClass="InfoText">Счет исключен</asp:label></td>
								<td><input id="ckExcluded" type="checkbox" runat="server"/></td>
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:50%"><asp:button id="btAccept" meta:resourcekey="btAccept" runat="server" CssClass="AcceptButton" Text="Обновить"></asp:button></td>
								<td align="left" style="width:50%"><input meta:resourcekey="btClose" runat="server" class="AcceptButton" onclick="window.close();" type="button" value="Закрыть"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="../Inc/DepositCk.inc"-->
			<!-- #include virtual="../Inc/DepositJs.inc"-->
			<script type="text/javascript" language="javascript">
				document.getElementById("textBranchCode").attachEvent("onkeydown",doNum);
				document.getElementById("textDptCode").attachEvent("onkeydown",doNum);				
			    document.getElementById("textFIO").attachEvent("onkeydown",doAlpha);				
				document.getElementById("textPasp").attachEvent("onkeydown",doNumAlpha);								
				document.getElementById("textNLS").attachEvent("onkeydown",doNumAlpha);
			</script>
    </form>
    </body>
</html>
