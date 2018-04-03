<%@ Page language="c#" CodeFile="SearchResults.aspx.cs" AutoEventWireup="true" Inherits="SearchResults" enableViewState="True" debug="False" %>

<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Пошук клієнта</title>
		<base target="_self" />
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="C#" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textClientName,textClientCode,textClientDate_t,textClientNumber,textClientSerial,listSearchClient",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</head>
	<body onload="CheckNFill();focusControl('textClientName');">
		<form id="Form1" method="post" runat="server">
			<asp:ScriptManager ID="ScriptManager" EnablePartialRendering="true" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="uPanel" UpdateMode="Conditional" runat="server">
                <ContentTemplate>
			    <table id="MainTable" class="MainTable">
				    <tr>
					    <td>
						    <table id="InfoTable" class="InnerTable">
							    <tr>
								    <td width="30%">
									    <asp:Label CssClass="InfoText" id="lbNMK" meta:resourcekey="lbNMK" runat="server">ФИО</asp:Label>
								    </td>
								    <td>
									    <asp:textbox id="textClientName" meta:resourcekey="textClientName2" CssClass="InfoText" runat="server" ToolTip="Имя клиента" MaxLength="35"
										    tabIndex="1"></asp:textbox>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <asp:Label id="lbId" meta:resourcekey="lbId" CssClass="InfoText" runat="server">Идентификационный код</asp:Label>
								    </td>
								    <td>
									    <asp:textbox id="textClientCode" meta:resourcekey="textClientCode2" runat="server" CssClass="InfoText" ToolTip="Идентификационный код"
										    MaxLength="10" tabIndex="2"></asp:textbox>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <asp:Label id="lbBirthDate" meta:resourcekey="lbBirthDate2" CssClass="InfoText" runat="server">Дата рождения</asp:Label>
								    </td>
								    <td>
									    <igtxt:webdatetimeedit id="textClientDate" runat="server" CssClass="InfoDateSum" ToolTip="Дата рождения"
										    BorderStyle="Inset" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" tabIndex="3" HorizontalAlign="Center"></igtxt:webdatetimeedit>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <asp:Label id="lbDocSerial" meta:resourcekey="lbDocSerial2" CssClass="InfoText" runat="server">Серия документа</asp:Label>
								    </td> 
								    <td>
									    <asp:textbox id="textClientSerial" meta:resourcekey="textClientSerial" runat="server" CssClass="InfoText" ToolTip="Серия документа"
										    MaxLength="10" tabIndex="4"></asp:textbox>
								    </td>
							    </tr>
							    <tr>
								    <td>
									    <asp:Label id="lbDocNumber" meta:resourcekey="lbDocNumber2" CssClass="InfoText" runat="server">Номер документа</asp:Label>
								    </td>
								    <td>
									    <asp:textbox id="textClientNumber" meta:resourcekey="textClientNumber" runat="server" CssClass="InfoText" ToolTip="Номер документа"
										    MaxLength="20" tabIndex="5"></asp:textbox>
								    </td>
							    </tr>
						    </table>
					    </td>
				    </tr>
				    <tr>
					    <td>
						    <input id="isPostBack" type="hidden" name="isPostBack" runat="server"/>
					    </td>
				    </tr>
				    <tr>
					    <td align="center">
						    <asp:button id="btSearch" meta:resourcekey="btSearch2" runat="server" Text="Поиск" tabIndex="6" CssClass="AcceptButton"></asp:button>
					    </td>
				    </tr>
				    <tr>
					    <td align="center">
						    <asp:Label id="lbTitle" meta:resourcekey="lbTitle3" runat="server" CssClass="InfoText">Выберите соответствующую запись из найденных</asp:Label>
					    </td>
				    </tr>
				    <tr>
					    <td>
						    <asp:dropdownlist id=listSearchClient runat="server" CssClass="BaseDropDownList"
						    DataSource="<%# fClients %>" DataValueField="RNK" tabIndex=7>
						    </asp:dropdownlist>
					    </td>
				    </tr>
				    <tr>
					    <td align="center">
						    <input runat="server" id="btSubmit" meta:resourcekey="btSubmit" onclick="SearchResultsExit()" type="button" value="Выбрать" tabIndex="8"
							    class="AcceptButton"/>
					    </td>
				    </tr>
			    </table>
                <asp:UpdateProgress ID="updateProgressBars" runat="server" 
                    AssociatedUpdatePanelID="uPanel">
                        <ProgressTemplate>
                            <uc1:loading ID="sync_loading" runat="server" />
                            </ProgressTemplate>
                </asp:UpdateProgress>                            
                </ContentTemplate>
            </asp:UpdatePanel>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
		<script type="text/javascript" language="javascript">
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("textClientNumber").attachEvent("onkeydown",doNum);
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
		</script>
	</body>
</html>
