<%@ Register TagPrefix="igtxt1" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositSearch.aspx.cs" AutoEventWireup="false" Inherits="DepositSearch"  enableViewState="False"%>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Пошук</title>
		<meta name="vs_showGrid" content="True">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
		<script language="javascript" src="/Common/Script/cross.js"></script>
		<script language="javascript" src="Scripts/Default.js"></script>
		<script language="javascript">
		    function RedirectToContact()
		    {
		      if(document.getElementById('dptid').value == "")
		      {
		            alert("Не вибрано договір.");
		            return false;
		      }
		      return true;
		    }
		</script>
	</HEAD>
	<body onload="focusControl('textDepositId');">
		<form id="Form1" method="post" runat="server">
			<TABLE id="mainTable" class="MainTable">
				<TR>
					<TD align="center">
						<asp:label id="lbSearchInfo" runat="server" CssClass="InfoHeader">Пошук рахунків пенсіонерів та безробітних</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE class="InnerTable" id="tbParams">
							<TR>
								<TD width="20%">
                                    <asp:label id="Label4" runat="server" CssClass="InfoText">Номер вкладу</asp:label></TD>
								<TD width="25%">
                                    <asp:TextBox id="textDepositNum" tabIndex="1" runat="server" CssClass="InfoText" MaxLength="48"
										ToolTip="Номер вкладу"></asp:TextBox></TD>
								<TD width="10%"></TD>
								<TD width="25%">
									<asp:label id="lbClientName" runat="server" CssClass="InfoText">Вкладник</asp:label>
								</TD>
								<TD>
									<asp:TextBox id="textClientName" runat="server" ToolTip="ПІБ вкладника" MaxLength="35" tabIndex="5"
										CssClass="InfoText"></asp:TextBox>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:label id="lbDepositId" CssClass="InfoText" runat="server">Ідентифікатор вкладу</asp:label></TD>
								<TD>
									<asp:TextBox id="textDepositId" runat="server" ToolTip="Ідентифікатор вкладу" MaxLength="12"
										tabIndex="2" CssClass="InfoText"></asp:TextBox></TD>
								<TD></TD>
								<TD>
									<asp:label id="lbClientOKPO" runat="server" CssClass="InfoText">Ідентифікаційний код</asp:label></TD>
								<TD>
									<asp:TextBox id="textClientCode" runat="server" ToolTip="Ідентифікаційний код" MaxLength="10"
										tabIndex="6" CssClass="InfoText"></asp:TextBox></TD>
							</TR>
							<TR>
								<TD>
									<asp:label id="lbClientId" runat="server" CssClass="InfoText">Номер контрагента</asp:label>
								</TD>
								<TD>
									<asp:TextBox id="textClientId" runat="server" ToolTip="Номер контрагента" MaxLength="12" tabIndex="3"
										CssClass="InfoText"></asp:TextBox>
								</TD>
								<TD></TD>
								<TD>
									<asp:label id="lbBirthDate" runat="server" CssClass="InfoText">Дата народження</asp:label>
								</TD>
								<TD>
									<igtxt1:WebDateTimeEdit id="bDate" runat="server" ToolTip="Дата рождения" MaxValue="2100-01-01" MinValue="1800-01-01"
										HorizontalAlign="Center" BorderStyle="Inset" tabIndex="7" CssClass="InfoDateSum"></igtxt1:WebDateTimeEdit>
								</TD>
							</TR>
							<TR>
								<TD>
									<asp:label id="lbDepositAccount" runat="server" CssClass="InfoText">Номер рахунка</asp:label>
								</TD>
								<TD>
									<asp:TextBox id="textAccount" runat="server" ToolTip="Номер рахунка" MaxLength="14" tabIndex="4"
										CssClass="InfoText"></asp:TextBox>
								</TD>
								<TD></TD>
								<TD>
									<asp:label id="lbDocSerial" runat="server" CssClass="InfoText">Серія документа</asp:label>
								</TD>
								<TD>
									<asp:TextBox id="DocSerial" runat="server" ToolTip="Серія документа" MaxLength="10" tabIndex="8"
										CssClass="InfoText"></asp:TextBox>
								</TD>
							</TR>
							<TR>
								<TD>
                                    <asp:Label ID="lbCond" runat="server" CssClass="InfoText">Режими пошуку</asp:Label></TD>
								<TD>
                                    <asp:DropDownList ID="listConditions" runat="server" CssClass="BaseDropDownList">
                                        <asp:ListItem Value="1">Діючі рахунки</asp:ListItem>
                                        <asp:ListItem Value="2">Діючі карткові рахунки</asp:ListItem>
                                        <asp:ListItem Value="3">Діючі поточні рахунки</asp:ListItem>
                                        <asp:ListItem Value="4">Діючі рахунки підрозділу</asp:ListItem>
                                        <asp:ListItem Value="5">Закриті рахунки</asp:ListItem>
                                        <asp:ListItem Value="6">Всі рахунки</asp:ListItem>
                                    </asp:DropDownList></TD>
								<TD></TD>
								<TD>
									<asp:label id="lbDocNumber" runat="server" CssClass="InfoText">Номер документа</asp:label>
								</TD>
								<TD>
									<asp:TextBox id="DocNumber" runat="server" ToolTip="Номер документа" MaxLength="10" tabIndex="9"
										CssClass="InfoText"></asp:TextBox>
								</TD>
							</TR>
                            <tr>
                                <td>
                                </td>
                                <td><asp:DropDownList ID="listBranches" runat="server" CssClass="BaseDropDownList" DataTextField="name" DataValueField="branch" Visible="False">
                                </asp:DropDownList></td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE id="tbl_Hint" class="InnerTable">
							<TR>
								<TD width="40%">
									<INPUT id="btSearch" class="AcceptButton" type="button" value="Пошук" runat="server" tabIndex="10" onserverclick="btSearch_ServerClick">
								</TD>
								<TD width="15%">
                                    &nbsp;</TD>
								<TD width="40%">
									<INPUT id="btSelect" class="AcceptButton" type="button" value="Вибрати" runat="server"
										tabIndex="11" onclick="if (RedirectToContact())" onserverclick="btSelect_ServerClick">
								</TD>
								<TD>
                                    &nbsp;
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
                        <bars:barsgridview id="gridSearch" runat="server" allowpaging="True" allowsorting="True"
                            autogeneratecolumns="False" cssclass="baseGrid" datasourceid="dsSearch" datemask="dd/MM/yyyy"
                            onrowdatabound="gridSearch_RowDataBound" showpagesizebox="True">
<PagerSettings PageButtonCount="5"></PagerSettings>
                            <columns>
<asp:BoundField DataField="CONTRACT_NUMBER" SortExpression="CONTRACT_NUMBER" HeaderText="№"></asp:BoundField>
<asp:BoundField DataField="CONTRACT_ID" SortExpression="CONTRACT_ID" HeaderText="Сист. №"></asp:BoundField>
<asp:BoundField DataField="PENSION_NUM" SortExpression="PENSION_NUM" HeaderText="№ пенс. справи"></asp:BoundField>
<asp:BoundField DataField="NLS" SortExpression="NLS" HeaderText="Рахунок"></asp:BoundField>
<asp:BoundField DataField="CURRENCY_ID" SortExpression="CURRENCY_ID" HeaderText="Валюта"></asp:BoundField>
<asp:BoundField DataField="ACC_TYPE" SortExpression="ACC_TYPE" HeaderText="Тип"></asp:BoundField>
<asp:BoundField DataField="DATE_ON" SortExpression="DATE_ON" HeaderText="Дата відкриття"></asp:BoundField>
<asp:BoundField DataField="DATE_OFF" SortExpression="DATE_OFF" HeaderText="Дата закриття"></asp:BoundField>
<asp:BoundField DataField="SAL" SortExpression="SAL" HeaderText="Залишок"></asp:BoundField>
<asp:BoundField DataField="RATE" SortExpression="RATE" HeaderText="% ставка"></asp:BoundField>
<asp:BoundField DataField="CUSTOMER_NAME" SortExpression="CUSTOMER_NAME" HeaderText="ПІБ"></asp:BoundField>
<asp:BoundField DataField="BRANCH_ID" SortExpression="BRANCH_ID" HeaderText="Підрозділ"></asp:BoundField>
<asp:BoundField DataField="AGENCY_NAME" SortExpression="AGENCY_NAME" HeaderText="Район отр. пенсії"></asp:BoundField>
</columns>
</bars:barsgridview>
					</TD>
				</TR>
                <tr>
                    <td>
									<INPUT id="dptid" type="hidden" runat="server" value="null">
									<INPUT id="branchid" type="hidden" runat="server">
									<INPUT id="cash" type="hidden" runat="server">
                                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsSearch" runat="server"></bars:barssqldatasource></td>
                </tr>
			</TABLE>
		</form>
		<script language="javascript">
				document.getElementById("textDepositId").attachEvent("onkeydown",doNum);
				//document.getElementById("textDepositNum").attachEvent("onkeydown",doNum);
				document.getElementById("textClientId").attachEvent("onkeydown",doNum);
				document.getElementById("textAccount").attachEvent("onkeydown",doNumAlpha);
				document.getElementById("textClientCode").attachEvent("onkeydown",doNum);
				document.getElementById("DocNumber").attachEvent("onkeydown",doNum);
				
				document.getElementById("textClientName").attachEvent("onkeydown",doAlpha);
		</script>
	</body>
</HTML>
