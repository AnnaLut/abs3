<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositContract.aspx.cs" AutoEventWireup="false" Inherits="DepositContract" enableViewState="True"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Картка депозиту</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language="javascript" src="/Common/Script/cross.js"></script>
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
		<style type="text/css">.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }</style>
		<script language="javascript">
		window.attachEvent("onload",HideImgs);
		function HideImgs()
		{
		  if(document.all.textAccounts && document.all.textAccounts.value != "")
		     document.all.imgAcc.style.visibility = 'visible';
          if(document.all.textIntAccount && document.all.textIntAccount.value != "")
		     document.all.imgInt.style.visibility = 'visible';   
		}
		function AddListener4Enter(){
			AddListeners("textContractNumber,listContractType,listSocOrgan,textTechAcc,textComment",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</HEAD>
	<body onload="webService.useService('SocialService.asmx?wsdl','Soc');">
		<form id="DepositContractForm" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD>
						<TABLE class="InnerTable">
							<TR>
								<TD align="right" width="55%">
									<asp:label id="lbInfo" runat="server" CssClass="InfoHeader">Договір №</asp:label>
								</TD>
								<TD align="left">
									<asp:textbox id="textContractNumber" tabIndex="1" runat="server" ToolTip="Номер договору" MaxLength="10"
										CssClass="HeaderText" ReadOnly="True"></asp:textbox>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:label id="lbClientInfo" runat="server" CssClass="InfoLabel">Вкладник</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:textbox id="textClientName" tabIndex="100" runat="server" CssClass="InfoText" MaxLength="70"
							ToolTip="Вкладник" ReadOnly="True"></asp:textbox>
					</TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<TABLE class="InnerTable">
                            <tr>
                                <td width="20%">
                                    <asp:label id="lbSocOrgan" runat="server" CssClass="InfoLabel">Орган соціального захисту</asp:label></td>
                                <td width="80%">
                                    <asp:dropdownlist id="listSocOrgan" tabIndex="2" runat="server" CssClass="BaseDropDownList" DataTextField="agency_name" 
										DataValueField="agency_id" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="listSocOrgan_SelectedIndexChanged">
                                    </asp:DropDownList></td>
                            </tr>
							<TR>
								<TD width="20%">
									<asp:label id="lbContractType" runat="server" CssClass="InfoLabel">Вид договору</asp:label>
								</TD>
								<TD width="80%">
									<asp:dropdownlist id=listContractType tabIndex=3 runat="server" CssClass="BaseDropDownList" DataTextField="type_name" 
										DataValueField="type_id" AutoPostBack="True" Width="100%" ToolTip="Вид договору">
									</asp:dropdownlist>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:label id="lbDepositParam" runat="server" CssClass="InfoLabel">Параметри договору</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE class="InnerTable">
							<TR>
								<TD width="20%">
                                    </TD>
								<TD width="79%" colspan="3">
                                    </TD>
                                <td width="1%">
                                </td>
							</TR>
                            <tr>
                                <td width="20%">
									<asp:label id="lbDepositCurrency" runat="server" CssClass="InfoText">Валюта дог.</asp:label></td>
                                <td width="25%">
									<asp:textbox id="textDepositCurrency" tabIndex="101" runat="server" ToolTip="Валюта договору"
										ReadOnly="True" CssClass="InfoText" Width="150px"></asp:textbox></td>
                                <td width="20%">
                                </td>
                                <td width="34%">
                                </td>
                                <td width="1%">
                                </td>
                            </tr>
							<TR>
								<TD>
									<asp:label id="lbBasePercent" runat="server" CssClass="InfoText">Баз. % ставка</asp:label>
								</TD>
								<TD>
									<igtxt:webnumericedit id="textBasePercent" tabIndex="102" runat="server" MaxLength="10" ToolTip="Базовая процентная ставка"
										ReadOnly="True" DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum"></igtxt:webnumericedit>
								</TD>
                                <td>
                                    <asp:Label ID="lbTechAcc" runat="server" CssClass="InfoText">№ технічного карткового рахунку</asp:Label></td>
								<TD align="left">
                                    <asp:TextBox ID="textTechAcc" runat="server" CssClass="InfoText" MaxLength="14"
                                        TabIndex="4" ToolTip="Номер рахунку" Width="100%"></asp:TextBox></TD>
                                <td align="left">
                                </td>
							</TR>
                            <tr>
                                <td>
                                    <asp:Label ID="lbNumPens" runat="server" CssClass="InfoText">Номер пенсійної справи</asp:Label></td>
                                <td>
                                    <asp:TextBox ID="textNumPens" runat="server" CssClass="InfoText" TabIndex="7" ToolTip="Валюта договора"
                                        Width="150px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="lbAccount" runat="server" CssClass="InfoText">Поточний/звітний рахунок</asp:Label></td>
                                <td align="left">
                                    <asp:TextBox ID="textAccounts" runat="server" CssClass="InfoText" MaxLength="14" TabIndex="5"
                                        ToolTip="Поточний рахунок" Width="100%" ReadOnly="True"></asp:TextBox></td>
                                <td align="left">
                                <img src="/Common/Images/history.gif" id=imgAcc onclick="showHistory(document.all.account_id.value)" style="visibility:hidden"></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbIntAccount" runat="server" CssClass="InfoText">Рахунок нарахованих відсотків</asp:Label></td>
                                <td align="left">
                                    <asp:TextBox ID="textIntAccount" runat="server" CssClass="InfoText" MaxLength="14"
                                        ReadOnly="True" TabIndex="6" ToolTip="Рахунок нарах. відсотків" Width="100%"></asp:TextBox></td>
                                <td align="left">
                                <img id=imgInt src="/Common/Images/history.gif" onclick="showHistory(document.all.interest_id.value)" style="visibility:hidden"></td>
                            </tr>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:label id="lbDepositDates" runat="server" CssClass="InfoLabel">Дати договору</asp:label>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE class="InnerTable">
							<TR>
								<TD width="10%">
                                    <asp:label id="lbDepositOpenDate" runat="server" CssClass="InfoText">Відкриття договору</asp:label></TD>
								<TD width="15%">
                                    <igtxt:webdatetimeedit id="dtContractBegin" tabIndex="110" runat="server" ToolTip="Дата начала договора"
										ReadOnly="True" HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
										CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</TD>
								<TD width="10%">
                                    <asp:label id="lbDepositDate" runat="server" CssClass="InfoText">Закриття договору</asp:label></TD>
								<TD width="15%">
                                    <igtxt:webdatetimeedit id="dtContractEnd" tabIndex="5" runat="server" ToolTip="Дата заключения договора" MinValue="1900-01-01"
										ReadOnly=true HorizontalAlign="Center" HideEnterKey="True" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
										CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</TD>
                                <td width="10%">
                                </td>
							</TR>
						</TABLE>
                        </TD>
				</TR>
                <tr>
                    <td>
						<asp:label id="lbComment" runat="server" CssClass="InfoText">Коментар</asp:label></td>
                </tr>
                <tr>
                    <td>
						<asp:textbox id="textComment" tabIndex="7" runat="server" MaxLength="200" ToolTip="Коментар"
							TextMode="MultiLine" CssClass="InfoText"></asp:textbox></td>
                </tr>
                <tr>
                    <td>
                        </td>
                </tr>
				<TR>
					<TD>
						<TABLE class="InnerTable">
							<TR>
								<TD style="width:1%">
                                    <INPUT id="btnSubmit" type="button" value="Зареєструвати договір" class="DirectionButton" runat="server"
										onclick="if (ckForm())" tabIndex="9" onserverclick="btnSubmit_ServerClick">
								</TD>
								<TD style="width:1%">
                                    <INPUT id="btFormDocs" type="button" value="Формувати документи" class="DirectionButton" runat="server"
										onclick="if (GetTemplates())" tabIndex="10" onserverclick="btFormDocs_ServerClick" visible="false"></TD>
								<TD style="width:1%">
                                    <INPUT type=button id=btPrintDocs value="Друкувати документи" class="DirectionButton" onclick="ShowPrintDialog()" runat=server visible="false" tabindex="11"></TD>
							    <td style="width:100%">							    
							        <INPUT id="btAddAgreement" type="button" value="Додаткова угода" class="DirectionButton" runat="server"
										onclick="AddAgreement()" tabIndex="12" visible="false">
							    </td>
							</TR>
							<tr>
							    <td>
                                    <INPUT id="btAddAgreements" type="button" value="Перегляд дод. угод" class="DirectionButton" runat="server"
										tabIndex="14" onserverclick="btAddAgreements_ServerClick"></td>
							    <td>
                                    <asp:Button ID="btReport" runat="server" CssClass="DirectionButton" 
                                        onclick="btReport_Click" Text="Виписка" />
                                </td>
							    <td>
                                    <INPUT id="btnClose" type="button" value="Закрити договір" class="DirectionButton" runat="server"
										tabIndex="15" onserverclick="btnClose_ServerClick" visible="false">
							    </td>
                                <td>
                                    <INPUT id=btSurvey type=button runat=server onclick="ShowSurvey()" class="DirectionButton" value="Заповнити анкету" visible="false" tabindex="16">
                                </td>							    
							</tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
									<div style="OVERFLOW: scroll; HEIGHT: 200px">
										<asp:datagrid id=dataGrid runat="server" CssClass="BaseGrid" DataSource="<%# dataSet %>">
										</asp:datagrid>
									</div>                                
                                </td>
                            </tr>
						</TABLE>
						<input type=hidden runat=server id=rnk>
						<input type=hidden runat=server id=contract_id>
				        <input type=hidden runat=server id=trustee_id>
				        <input type=hidden runat=server id=templates_ids>
				        <input type=hidden runat=server id=account_id>
				        <input type=hidden runat=server id=interest_id>
				        <input type=hidden runat=server id="socType">				        
					</TD>
				</TR>
			</TABLE>
		</form>
	    <div class="webservice" id="webService" showProgress="true"/>
	</body>
</HTML>
