<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Page language="c#" CodeFile="DepositContract.aspx.cs" AutoEventWireup="true" Inherits="DepositContract" enableViewState="True"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Вибір типу депозитного договору</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>        				
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textContractNumber,ckTechAcc,listContractType,textContractSum_t,checkboxIsCash,dtContract_t,textComment",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	</head>
	<body>
		<form id="fmDepositContract" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Path="js/js.js" />
            </Scripts>
        </asp:ScriptManager>
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" width="55%">
									<asp:label id="lbInfo" meta:resourcekey="lbInfo5" runat="server" CssClass="InfoHeader">Договор №</asp:label>
								</td>
								<td align="left">
									<asp:textbox id="textContractNumber" meta:resourcekey="textContractNumber" runat="server" ToolTip="Номер договора" MaxLength="10"
										CssClass="HeaderText" ReadOnly="True"></asp:textbox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:textbox id="textClientName" meta:resourcekey="textClientName3" tabIndex="100" runat="server" CssClass="InfoText" MaxLength="70"
							ToolTip="Вкладчик" ReadOnly="True"></asp:textbox>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
                            <tr>
                                <td width="20%">
                                    <asp:Label ID="lbTypes" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTypes">Тип договору</asp:Label></td>
                                <td width="80%"><asp:dropdownlist id=listTypes tabIndex=2 runat="server" CssClass="BaseDropDownList"
										DataSource="<%# dsType %>" DataTextField="type_name" 
										DataValueField="type_id" AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listTypes_SelectedIndexChanged" >
                                </asp:DropDownList></td>
                            </tr>
							<tr>
								<td width="20%">
									<asp:label id="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:label>
								</td>
								<td width="80%">
									<asp:dropdownlist id=listContractType tabIndex=2 runat="server" CssClass="BaseDropDownList"
										DataSource="<%# dsContractType %>" DataTextField="dpt_name" 
										DataValueField="dpt_type" AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listContractType_SelectedIndexChanged">
									</asp:dropdownlist>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbDepositParam" meta:resourcekey="lbDepositParam" runat="server" CssClass="InfoLabel">Параметры вклада</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="25%">
									<asp:label id="lbDepositCurrency" meta:resourcekey="lbDepositCurrency" runat="server" CssClass="InfoText">Валюта дог.</asp:label>
								</td>
								<td width="15%">
									<asp:textbox id="textDepositCurrency" meta:resourcekey="textDepositCurrency" tabIndex="101" runat="server" ToolTip="Валюта договора"
										ReadOnly="True" CssClass="InfoText"></asp:textbox>
								</td>
								<td></td>
								<td style="width:5%"></td>
								<td style="width:5%"></td>
								<td width="25%">
									<asp:label id="lbMinSum" meta:resourcekey="lbMinSum" runat="server" CssClass="InfoText">Минимальная сумма</asp:label>
								</td>
								<td width="5%">
									<asp:textbox id="textMinSumCurrency" meta:resourcekey="textMinSumCurrency" tabIndex="103" runat="server" ToolTip="Валюта" ReadOnly="True"
										CssClass="InfoText"></asp:textbox>
								</td>
								<td width="15%">
                                    <cc1:NumericEdit ID="textMinSum" runat="server" CssClass="InfoDateSum" 
                                        onblur="GetRate()" ReadOnly="True"></cc1:NumericEdit>
                                </td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbBasePercent" meta:resourcekey="lbBasePercent" runat="server" CssClass="InfoText">Баз. % ставка</asp:label>
								</td>
								<td>
                                    <cc1:NumericEdit ID="textBasePercent" runat="server" CssClass="InfoDateSum" ReadOnly="True"></cc1:NumericEdit></td>
								<td align="center">
                                    <asp:Label ID="lbPlus" runat="server" CssClass="InfoText"
                                        Text="+"></asp:Label></td>
								<td>
                                    <cc1:numericedit id="AbsBonus" runat="server" ReadOnly="True" CssClass="InfoDateSum"></cc1:numericedit>
                                </td>
								<td></td>
								<td>
									<asp:label id="lbContractSum" meta:resourcekey="lbContractSum" runat="server" CssClass="InfoText">Сумма вклада</asp:label>
								</td>
								<td>
									<asp:textbox id="textContractCurrency" meta:resourcekey="textContractCurrency" tabIndex="105" runat="server" ToolTip="Валюта" ReadOnly="True"
										CssClass="InfoText"></asp:textbox>
								</td>
								<td>
                                    <cc1:NumericEdit ID="textContractSum" onblur="GetRate()" runat="server" CssClass="InfoDateSum" TabIndex="3"></cc1:NumericEdit></td>
							</tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td align="center">
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Label ID="lbForecastPercent" runat="server" CssClass="InfoText" meta:resourcekey="lbForecastPercent">Прогнозируемая сумма процентов</asp:Label></td>
                                <td>
                                </td>
                                <td>
                                    <cc1:NumericEdit ID="ForecastPercent" runat="server" CssClass="InfoDateSum" onblur="GetRate()"
                                        TabIndex="3" ReadOnly="True"></cc1:NumericEdit></td>
                            </tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>								
								<td></td>
								<td colspan="2">
									<asp:checkbox id="checkboxIsCash" meta:resourcekey="checkboxIsCash" tabIndex="4" runat="server" Text="Наличными" Checked="True"
										CssClass="BaseCheckBox"></asp:checkbox>
								</td>
							</tr>
                            <tr>
                                <td colspan="8">
                                    <table style='text-align:right' class="InnerTable" id="metalParameters" runat="server" visible="false">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" style='text-align:left' runat="server" CssClass="InfoLabel">Інформація про злитки</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:100%">
                                                <asp:GridView ID="gvBars" CssClass="barsGridView" Width="600px" runat="server" AutoGenerateColumns="False" DataSourceID="dsDepositMetalBars"
                                                    DataKeyNames="BAR_ID" OnDataBound="gvBars_DataBound">
                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" />
                                                        <asp:BoundField DataField="BAR_ID" HeaderText="*" SortExpression="BAR_ID" />
                                                        <asp:BoundField DataField="BARS_COUNT" HeaderText="Кількість<BR>злитків" SortExpression="BARS_COUNT"  HtmlEncode="false"/>
                                                        <asp:BoundField DataField="BAR_NOMINAL" HeaderText="Номінал<BR>злитку" SortExpression="BAR_NOMINAL"  HtmlEncode="false" />
                                                        <asp:BoundField DataField="BAR_PROBA" HeaderText="Проба" SortExpression="BAR_PROBA" />
                                                        <asp:BoundField DataField="INGOT_WEIGHT" HeaderText="Вага<BR>зилитку" SortExpression="INGOT_WEIGHT" HtmlEncode="false"/>
                                                    </Columns>
                                                    <EmptyDataTemplate>
                                                        Дані відсутні
                                                    </EmptyDataTemplate>
                                                </asp:GridView>
                                             </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:FormView ID="fvBars" runat="server" DataSourceID="dsDepositMetalBars_Edit" 
                                                    onitemdeleted="fvBars_ItemDeleted" Width="600px" 
                                                    oniteminserted="fvBars_ItemInserted" onitemupdated="fvBars_ItemUpdated">
                                                    <ItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 40%">
                                                                    ID:
                                                                </td>
                                                                <td style="width: 60%">
                                                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("BAR_ID") %>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 40%">
                                                                    Кількість злитків:
                                                                </td>
                                                                <td style="width: 60%">
                                                                    <asp:Label ID="SkLabel" runat="server" Text='<%# Bind("BARS_COUNT") %>'></asp:Label><br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 40%">
                                                                    Номінал злитку:
                                                                </td>
                                                                <td style="width: 60%">
                                                                    <asp:Label ID="SLabel" runat="server" Text='<%# Bind("BAR_NOMINAL") %>'></asp:Label><br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 40%">
                                                                    Проба:
                                                                </td>
                                                                <td style="width: 60%">
                                                                    <asp:Label ID="NaznLabel" runat="server" Text='<%# Bind("BAR_PROBA") %>'></asp:Label><br />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                            Text="Редагувати">
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                                            Text="Видалити">
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                            Text="Додати">
                                                        </asp:LinkButton>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 30%">
                                                                    ID:
                                                                </td>
                                                                <td style="width: 30%">
                                                                    <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("BAR_ID") %>'></asp:Label><br />
                                                                </td>
                                                                <td style="width: 40%">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Кількість злитків:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox id="COUNT_U" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BARS_COUNT") %>'></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="COUNT_U"
                                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Номінал злитку:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox id="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'></asp:TextBox>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NOMINAL_I"
                                                                            ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                    </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Проба:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="NaznTextBox" runat="server" Text='<%# Bind("BAR_PROBA") %>'>
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="NaznTextBox"
                                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                            Text="Зберегти">
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                            Text="Відмінити">
                                                        </asp:LinkButton>
                                                    </EditItemTemplate>
                                                    <InsertItemTemplate>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td style="width: 30%">
                                                                    *Кількість злитків:
                                                                </td>
                                                                <td style="width: 30%">
                                                                    <asp:TextBox id="COUNT_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BARS_COUNT") %>'></asp:TextBox>
                                                                </td>
                                                                <td style="width: 40%">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="COUNT_I"
                                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    *Номінал злитку:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox id="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'></asp:TextBox>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="NOMINAL_I"
                                                                            ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                    </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    *Проба:
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="NaznTextBox" runat="server" Text="999.99">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="NaznTextBox"
                                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                            Text="Додати">
                                                        </asp:LinkButton>
                                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                            Text="Відмінити">
                                                        </asp:LinkButton>
                                                    </InsertItemTemplate>
                                                    <EmptyDataTemplate>
                                                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                            Text="Додати">
                                                        </asp:LinkButton>
                                                    </EmptyDataTemplate>
                                                </asp:FormView>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ObjectDataSource ID="dsDepositMetalBars" runat="server" SelectMethod="SelectBars"
                                                    TypeName="Bars.Metals.DepositMetals" DataObjectTypeName="Bars.Metals.DepositMetals">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                        <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                        <asp:Parameter Name="BAR_NOMINAL" Type="String" />
                                                        <asp:Parameter Name="BAR_PROBA" Type="String" />
                                                    </UpdateParameters>
                                                    <InsertParameters>
                                                        <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                        <asp:Parameter Name="BAR_NOMINAL" Type="String" />
                                                        <asp:Parameter Name="BAR_PROBA" Type="String" />
                                                    </InsertParameters>
                                                </asp:ObjectDataSource>
                                                <asp:ObjectDataSource ID="dsDepositMetalBars_Edit" runat="server" DeleteMethod="DeleteBar"
                                                    InsertMethod="InsertBar" SelectMethod="SelectBar" TypeName="Bars.Metals.DepositMetals"
                                                    UpdateMethod="UpdateBar">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                    </DeleteParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                        <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                        <asp:Parameter Name="BAR_NOMINAL" Type="String" />
                                                        <asp:Parameter Name="BAR_PROBA" Type="String" />
                                                    </UpdateParameters>
                                                    <InsertParameters>
                                                        <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                        <asp:Parameter Name="BAR_NOMINAL" Type="String" />
                                                        <asp:Parameter Name="BAR_PROBA" Type="String" />
                                                    </InsertParameters>                                                    
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="gvBars" Name="BAR_ID" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="8">
                                    <asp:checkbox id="ckTechAcc" meta:resourcekey="ckTechAcc" tabIndex="5" runat="server" Text="Открыть технический счет по вкладу" CssClass="BaseCheckBox"/>
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbDepositDates" meta:resourcekey="lbDepositDates" runat="server" CssClass="InfoLabel">Даты договора</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="15%">
									<asp:label id="lbDepositDate" meta:resourcekey="lbDepositDate" runat="server" CssClass="InfoText">Заключения</asp:label>
								</td>
								<td width="15%">
									<igtxt:webdatetimeedit id="dtContract" tabIndex="6" runat="server" ToolTip="Дата заключения договора" MinValue="1900-01-01"
										HorizontalAlign="Center" HideEnterKey="True" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
										CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</td>
								<td></td>
								<td width="10%"></td>
								<td width="15%"></td>
								<td width="5%"></td>
								<td width="15%"></td>
								<td width="10%">
									<asp:label id="lbMonths" meta:resourcekey="lbMonths" runat="server" CssClass="InfoText">Месяцев</asp:label>
								</td>
								<td width="10%">
									<asp:label id="lbDays" meta:resourcekey="lbDays" runat="server" CssClass="InfoText">Дней</asp:label>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbDepositOpenDate" meta:resourcekey="lbDepositOpenDate" runat="server" CssClass="InfoText">Начала</asp:label>
								</td>
								<td>
									<igtxt:webdatetimeedit id="dtContractBegin" tabIndex="110" runat="server" ToolTip="Дата начала договора"
										ReadOnly="True" HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
										CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</td>
								<td style="width: 42px"></td>
								<td>
									<asp:label id="lbDepositCloseDate" meta:resourcekey="lbDepositCloseDate" runat="server" CssClass="InfoText">Завершения</asp:label>
								</td>
								<td>
									<igtxt:webdatetimeedit id="dtContractEnd" tabIndex="111" runat="server" ToolTip="Дата завершения договора"
										ReadOnly="True" HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
										CssClass="InfoDateSum"></igtxt:webdatetimeedit>
								</td>
								<td></td>
								<td>
									<asp:label id="lbDuration" meta:resourcekey="lbDuration" runat="server" CssClass="InfoText">Длительность</asp:label>
								</td>
								<td>
                                    <asp:TextBox ID="textDurationMonths" runat="server" onblur="CalcEndDate()" 
                                        CssClass="InfoDateSum" TabIndex="7" Enabled="False" MaxLength="3"></asp:TextBox></td>
								<td>
                                    <asp:TextBox ID="textDurationDays" runat="server" onblur="CalcEndDate()" 
                                        CssClass="InfoDateSum" TabIndex="8" Enabled="False" MaxLength="3"></asp:TextBox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:label id="lbComment" meta:resourcekey="lbComment" runat="server" CssClass="InfoText">Комментарий</asp:label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:textbox id="textComment" meta:resourcekey="textComment" tabIndex="9" runat="server" MaxLength="200" ToolTip="Комментарий"
							TextMode="MultiLine" CssClass="InfoText"></asp:textbox>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="1%">
									<input id="btnBack" meta:resourcekey="btnBack" tabindex="11" type="button" value="Назад" runat="server" class="DirectionButton" />
								</td>
								<td width="99%">
									<input id="btnSubmit" meta:resourcekey="btnSubmit" tabindex="10" type="button" value="Далее" runat="server" class="DirectionButton"
										onclick="if (ckForm())" />
								</td>
							</tr>
                            <tr>
                                <td width="1%">
                                </td>
                                <td width="99%">
                                    <input type="hidden" runat="server" id="nb" />
                                    <input type="hidden" runat="server" id="kv" />
                                    <input type="hidden" runat="server" id="denom" />
                                    <input type="hidden" runat="server" id="term_ext" />
                                    <input type="hidden" runat="server" id="ContractSumGrams" value="0" />
                                </td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
            <script language="javascript" type="text/javascript">
                if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
            </script>			
		</form>
		<script type="text/javascript" language="javascript">
			document.getElementById("textContractNumber").attachEvent("onkeydown",doNum);
			document.getElementById("textDurationDays").attachEvent("onkeydown",doNum);
			document.getElementById("textDurationMonths").attachEvent("onkeydown", doNum);

			if (document.getElementById('fvBars$NOMINAL_I'))
			    document.getElementById('fvBars$NOMINAL_I').attachEvent("onkeydown", doNum);
			if (document.getElementById('fvBars$NOMINAL_U'))
			    document.getElementById('fvBars$NOMINAL_U').attachEvent("onkeydown", doNum);
			if (document.getElementById('fvBars$COUNT_I'))
			    document.getElementById('fvBars$COUNT_I').attachEvent("onkeydown", doNum);
			if (document.getElementById('fvBars$COUNT_U'))
			    document.getElementById('fvBars$COUNT_U').attachEvent("onkeydown", doNum);
		</script>
	</body>
</html>
