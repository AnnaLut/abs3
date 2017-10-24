<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="SearchResults.aspx.cs" AutoEventWireup="false" Inherits="SearchResults" enableViewState="True" debug="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Пошук клієнта</title>
		<base target="_self" />
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="/Common/Script/cross.js"></script>
		<script language="javascript" src="Scripts/Default.js"></script>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript">
		function AddListener4Enter(){
			AddListeners("textClientName,textClientCode,textClientDate_t,textClientNumber,textClientSerial,listSearchClient",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</HEAD>
	<body onload="CheckNFill();focusControl('textClientName');">
		<form id="Form1" method="post" runat="server">
			<TABLE id="MainTable" class="MainTable">
				<TR>
					<TD>
						<TABLE id="InfoTable" class="InnerTable">
							<TR>
								<TD width="30%">
									<asp:Label CssClass="InfoText" id="lbNMK" runat="server">ПІБ</asp:Label>
								</TD>
								<TD>
									<asp:textbox id="textClientName" CssClass="InfoText" runat="server" ToolTip="Имя клиента" MaxLength="35"
										tabIndex="1"></asp:textbox>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:Label id="lbId" CssClass="InfoText" runat="server">Ідентифікаційний код</asp:Label>
								</TD>
								<TD>
									<asp:textbox id="textClientCode" runat="server" CssClass="InfoText" ToolTip="Идентификационный код"
										MaxLength="10" tabIndex="2"></asp:textbox>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:Label id="lbBirthDate" CssClass="InfoText" runat="server">Дата народження</asp:Label>
								</TD>
								<TD>
									<igtxt:webdatetimeedit id="textClientDate" runat="server" CssClass="InfoDateSum" ToolTip="Дата рождения"
										BorderStyle="Inset" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy" tabIndex="3" HorizontalAlign="Center"></igtxt:webdatetimeedit>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:Label id="lbDocSerial" CssClass="InfoText" runat="server">Серія документа</asp:Label>
								</TD>
								<TD>
									<asp:textbox id="textClientSerial" runat="server" CssClass="InfoText" ToolTip="Серия документа"
										MaxLength="10" tabIndex="4"></asp:textbox>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:Label id="lbDocNumber" CssClass="InfoText" runat="server">Номер документа</asp:Label>
								</TD>
								<TD>
									<asp:textbox id="textClientNumber" runat="server" CssClass="InfoText" ToolTip="Номер документа"
										MaxLength="20" tabIndex="5"></asp:textbox>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<input id="isPostBack" type="hidden" name="isPostBack" runat="server">
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:button id="btSearch" runat="server" Text="Пошук" tabIndex="6" CssClass="AcceptButton"></asp:button>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<asp:Label id="lbTitle" runat="server" CssClass="InfoText">Виберіть відповідний запис зі знайдених</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:dropdownlist id=listSearchClient runat="server" CssClass="BaseDropDownList"
						DataSource="<%# fClients %>" DataValueField="RNK" tabIndex=7>
						</asp:dropdownlist>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<INPUT id="btSubmit" onclick="SearchResultsExit()" type="button" value="Вибрати" tabIndex="8"
							class="AcceptButton">
					</TD>
				</TR>
			</TABLE>
		</form>
		<script language="javascript">
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("textClientNumber").attachEvent("onkeydown",doNum);
				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
		</script>
	</body>
</HTML>
