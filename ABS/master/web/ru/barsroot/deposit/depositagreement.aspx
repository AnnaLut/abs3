<%@ Page language="c#" CodeFile="DepositAgreement.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementPage" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Формування додаткових угод</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body onload="focusControl('btForm');"> 
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:70%">
									<asp:label id="lbTitle" meta:resourcekey="lbTitle5" runat="server" CssClass="InfoLabel" Text="Оформление доп. соглашений по депозитному договору №"></asp:label>
								</td>
								<td align="left">
									<input id="dpt_num" readOnly class="HeaderText" type="text" runat="server" NAME="dptid" maxLength="0"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbAvailable" meta:resourcekey="lbAvailable" runat="server" CssClass="InfoLabel">Доступные доп. соглашения:</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:datagrid id="gridAddAgreement" runat="server" HorizontalAlign="Left" AutoGenerateColumns="False"
							EnableViewState="False" CssClass="BaseGrid">
							<Columns>
								<asp:BoundColumn Visible="False" DataField="id">
									<HeaderStyle Wrap="False"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="name" HeaderText="Наименование"></asp:BoundColumn>
								<asp:BoundColumn DataField="description" HeaderText="Описание"></asp:BoundColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
				<tr>
					<td>
						<input id="btForm" meta:resourcekey="btForm" type="button" value="Формировать" class="AcceptButton" runat="server"
							tabIndex="1"/>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbCurDopAgr" meta:resourcekey="lbCurDopAgr2" CssClass="InfoLabel" runat="server">Действующие доп. соглашения:</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:datagrid id="gridCurAgreement" runat="server" HorizontalAlign="Left" AutoGenerateColumns="False"
							EnableViewState="False" CssClass="BaseGrid">
							<Columns>
								<asp:BoundColumn DataField="adds" HeaderText="№">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="version" HeaderText="Версия">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="agr_id"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Название">
									<HeaderStyle Width="35%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 лицо">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="18%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="txt" Visible="False"></asp:BoundColumn>
                                <asp:BoundColumn DataField="agr_uid" Visible="False"></asp:BoundColumn>
                                <asp:BoundColumn DataField="status" Visible="False"></asp:BoundColumn>
							</Columns>
						</asp:datagrid>
					</td>
				</tr>
				<tr>
					<td>
                        <input id="btFormText" meta:resourcekey="btFormText" class="AcceptButton" type="button"
							value="Формировать текст" tabIndex="2" runat="server" disabled="disabled" onserverclick="btFormText_ServerClick"/>					
						<input id="btShow" meta:resourcekey="btShow2" class="AcceptButton" onclick="if (show_ck())" type="button"
							value="Печать" name="Button1" tabIndex="3" runat="server" disabled="disabled" onserverclick="btShow_ServerClick"/>														
						<input id="btStorno" meta:resourcekey="btStorno" type="button" value="Сторнировать" class="AcceptButton" runat="server"
							tabIndex="4" onserverclick="btStorno_ServerClick" disabled="disabled"/></td>
				</tr>
				<tr>
					<td>
						<input id="agr_id" type="hidden" runat="server"/> <input id="name" type="hidden" runat="server"/>
						<input id="ccdoc_id" type="hidden" runat="server"/> <input id="ccdoc_ads" type="hidden" runat="server"/>
						<input id="ccdoc_agr_id" type="hidden" runat="server"/><input id="agr_uid" type="hidden" runat="server"/>
						<input id="dpt_id" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
