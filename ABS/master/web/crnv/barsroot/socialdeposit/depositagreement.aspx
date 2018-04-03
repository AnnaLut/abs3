<%@ Page language="c#" CodeFile="DepositAgreement.aspx.cs" AutoEventWireup="false" Inherits="DepositAgreement" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Формування додаткових угод</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
	</HEAD>
	<body onload="focusControl('btForm');">
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD>
						<TABLE class="InnerTable">
							<TR>
								<TD align="right" width="70%">
									<asp:label id="lbTitle" runat="server" CssClass="InfoLabel">Оформлення дод. угод по соціальному договору №</asp:label>
								</TD>
								<TD align="left">
									<INPUT id="dpt_num" readOnly class="HeaderText" type="text" runat="server" NAME="dptid" maxLength="0">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<asp:label id="lbAvailable" runat="server" CssClass="InfoLabel">Допустимі додаткові угоди:</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:datagrid id="gridAddAgreement" runat="server" HorizontalAlign="Left" AutoGenerateColumns="False"
							EnableViewState="False" CssClass="BaseGrid">
							<Columns>
								<asp:BoundColumn Visible="False" DataField="id">
									<HeaderStyle Wrap="False"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="name" HeaderText="Назва"></asp:BoundColumn>
								<asp:BoundColumn DataField="description" HeaderText="Опис"></asp:BoundColumn>
							</Columns>
						</asp:datagrid></TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="btForm" type="button" value="Формувати" class="AcceptButton" runat="server"
							tabIndex="1" onserverclick="btForm_ServerClick">
					</TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<asp:label id="lbCurDopAgr" CssClass="InfoLabel" runat="server">Існуючі додаткові угоди</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:datagrid id="gridCurAgreement" runat="server" HorizontalAlign="Left" AutoGenerateColumns="False"
							EnableViewState="False" CssClass="BaseGrid">
							<Columns>
								<asp:BoundColumn DataField="adds" HeaderText="№">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="version" HeaderText="Версія">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="agr_id"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Назва">
									<HeaderStyle Width="35%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 особа">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="18%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="txt" Visible="False"></asp:BoundColumn>
                                <asp:BoundColumn DataField="TRUST_ID" Visible="False"></asp:BoundColumn>
							</Columns>
						</asp:datagrid>
					</TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="btShow" class="AcceptButton" onclick="if (show_ck())printAgreement();" type="button"
							value="Друк" name="Button1" tabIndex="2" runat="server" disabled="disabled">
                        <INPUT id="btFormText" class="AcceptButton" type="button"
							value="Формувати текст" tabIndex="2" runat="server" disabled="disabled" onserverclick="btFormText_ServerClick"></TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="agr_id" type="hidden" runat="server"> 
						<INPUT id="name" type="hidden" runat="server">
						<INPUT id="ccdoc_id" type="hidden" runat="server"> 
						<INPUT id="ccdoc_ads" type="hidden" runat="server">
						<INPUT id="ccdoc_agr_id" type="hidden" runat="server">
						<INPUT id="dptid" type="hidden" runat="server"> 
						<INPUT id="trustid" type="hidden" runat="server"> 
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
