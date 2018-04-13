<%@ Page language="c#" CodeFile="DepositAddSum.aspx.cs" AutoEventWireup="true" Inherits="DepositAddSum"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1" %>
<%@ Register TagPrefix="ead" Src="~/UserControls/EADoc.ascx" TagName="EADoc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Поповнення рахунку</title>
		<meta content="False" name="vs_snapToGrid"/>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
        <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>
        <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
        <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/AccCk.js"></script>		
		<script type="text/javascript" language="javascript">
		function AddListener4Enter(){
			AddListeners("textContractAddSum_t",
		    'onkeydown', TreatEnterAsTab);
		}
		</script>
		<script type="text/javascript" language="javascript">
		<!--			
			CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
		</script>
	    <style type="text/css">
            .style1
            {
                width: 203px;
            }
        </style>
	</head>
	<body onload="focusControl('textContractAddSum_t');">
		<form id="Form1" method="post" runat="server">
			<table id="MainTable" class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:65%">
									<asp:label id="lbInfo" Text="Поповнення вкладу №" meta:resourcekey="lbInfo12" CssClass="InfoHeader" runat="server" />
								</td>
								<td align="left">
									<asp:textbox id="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server" CssClass="HeaderText" ReadOnly="True" ToolTip="№ депозита"></asp:textbox>
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
						<table class="InnerTable" id="ContractTable">
							<tr>
								<td>
									<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
								</td>
							</tr>
							<tr>
								<td>
									<asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" CssClass="InfoText" BorderStyle="Inset" ReadOnly="True"
										ToolTip="Вкладчик" MaxLength="70"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td>
									<asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" ToolTip="Паспортные данные" ReadOnly="True" BorderStyle="Inset"
										MaxLength="70" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td>
									<table id="tbDateR" class="InnerTable">
										<tr>
											<td style="width:20%">
												<asp:label id="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoText">Дата рождения</asp:label>
											</td>
											<td>
												<igtxt:webdatetimeedit id="DateR" runat="server" ToolTip="Дата рождения" ReadOnly="True" BorderStyle="Inset"
													HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                                                </igtxt:webdatetimeedit>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table class="InnerTable">
										<tr>
											<td style="width:20%">
												<asp:label id="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoText">Вид договора</asp:label>
											</td>
											<td>
												<asp:textbox id="textContractTypeName" meta:resourcekey="textContractTypeName" runat="server" CssClass="InfoText" ToolTip="Вид договора"
													ReadOnly="True" BorderStyle="Inset"></asp:textbox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
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
											<td style="width:25%">
												<asp:label id="lbDepositCurrency" meta:resourcekey="lbDepositCurrency" runat="server" CssClass="InfoText">Валюта дог.</asp:label>
											</td>
											<td style="width:20%">
												<asp:textbox id="textDepositCurrency" meta:resourcekey="textDepositCurrency" runat="server" CssClass="InfoText" BorderStyle="Inset"
													ReadOnly="True" ToolTip="Валюта договора"></asp:textbox>
											</td>
											<td style="width:5%"></td>
											<td style="width:25%">
												<asp:label id="lbMinSum" meta:resourcekey="lbMinSum2" runat="server" CssClass="InfoText">Мин. сумма пополнения</asp:label>
											</td>
											<td style="width:5%">
												<asp:textbox id="textMinSumCurrency" meta:resourcekey="textMinSumCurrency"  runat="server" CssClass="InfoText" BorderStyle="Inset" ReadOnly="True"
													ToolTip="Валюта"></asp:textbox>
											</td>
											<td class="style1">
												<igtxt:webnumericedit id="textMinAddSum" runat="server" CssClass="InfoDateSum" BorderStyle="Inset" ReadOnly="True"
													ToolTip="Минимальная сумма вклада" MaxLength="38" ValueText="0" MinDecimalPlaces="Two" DataMode="Decimal"></igtxt:webnumericedit>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbIntRate" meta:resourcekey="lbIntRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:label>
											</td>
											<td>
												<igtxt:webnumericedit id="textIntRate" runat="server" CssClass="InfoDateSum" BorderStyle="Inset" ReadOnly="True"
													ToolTip="Текущая процентная ставка" MaxLength="10" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"></igtxt:webnumericedit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbAddSum" meta:resourcekey="lbAddSum" runat="server" CssClass="InfoText">Сумма пополнения</asp:label>
											</td>
											<td>
												<asp:textbox id="textContractCurrency" meta:resourcekey="textContractCurrency" runat="server" CssClass="InfoText" BorderStyle="Inset"
													ReadOnly="True" ToolTip="Валюта"></asp:textbox>
											</td>
											<td class="style1">
												<igtxt:webnumericedit id="textContractAddSum" runat="server" CssClass="InfoDateSum" BorderStyle="Inset"
													ToolTip="Сумма пополнения" MinDecimalPlaces="Two" MinValue="0" DataMode="Decimal" tabIndex="1">
                                                </igtxt:webnumericedit>
											</td>
										</tr>
										<tr>
											<td>
												<asp:label id="lbDptStartDate" meta:resourcekey="lbDptStartDate" CssClass="InfoText" runat="server">Дата начала договора</asp:label>
											</td>
											<td>
												<igtxt:WebDateTimeEdit id="dtStartContract" runat="server" ToolTip="Дата завершения договора" ReadOnly="True"
													DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum" HorizontalAlign="Center"></igtxt:WebDateTimeEdit>
											</td>
											<td></td>
											<td>
												<asp:label id="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:label>
											</td>
											<td colspan="2">
												<igtxt:WebDateTimeEdit id="dtEndContract" runat="server" ToolTip="Дата завершения договора" ReadOnly="True"
													DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum" HorizontalAlign="Center"></igtxt:WebDateTimeEdit>
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
                                    <table style='text-align:right' class="InnerTable" id="metalParameters" runat="server" visible="false">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" style='text-align:left' runat="server" CssClass="InfoLabel">Інформація про злитки</asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:100%">
                                                <asp:GridView ID="gvAddSum" CssClass="barsGridView" Width="600px" runat="server" AutoGenerateColumns="False" DataSourceID="dsDptMetalAddSum"
                                                    DataKeyNames="BAR_ID" OnDataBound="gvAddSum_DataBound">
                                                    <Columns>
                                                        <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" />
                                                        <asp:BoundField DataField="BAR_ID" HeaderText="*" SortExpression="BAR_ID" />
                                                        <asp:BoundField DataField="BARS_COUNT" HeaderText="Кількість<BR>злитків" SortExpression="BARS_COUNT" HtmlEncode="false"/>
                                                        <asp:BoundField DataField="BAR_NOMINAL" HeaderText="Номінал<BR>злитку" SortExpression="BAR_NOMINAL" HtmlEncode="false"/>
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
                                                <asp:FormView ID="fvAddSum" runat="server" DataSourceID="dsDepositMetalBars_Edit" Width="600px" 
                                                    onitemdeleted="fvAddSum_ItemDeleted" 
                                                    oniteminserted="fvAddSum_ItemInserted"
                                                    onitemupdated="fvAddSum_ItemUpdated">
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
                                                                    <asp:TextBox id="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'>
                                                                    </asp:TextBox>
                                                                </td>
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
                                                                    <asp:TextBox id="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'>
                                                                    </asp:TextBox>
                                                                </td>
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
                                                                    <asp:TextBox ID="NaznTextBox" runat="server" Text="999.9">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="NaznTextBox"
                                                                        ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt">
                                                                    </asp:RequiredFieldValidator>
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
                                                <asp:ObjectDataSource ID="dsDptMetalAddSum" runat="server" SelectMethod="SelectBars"
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
                                                <asp:ObjectDataSource ID="dsDepositMetalBars_Edit" runat="server" TypeName="Bars.Metals.DepositMetals"
                                                    DeleteMethod="DeleteBar" InsertMethod="InsertBar" SelectMethod="SelectBar" UpdateMethod="UpdateBar">
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
                                                        <asp:ControlParameter ControlID="gvAddSum" Name="BAR_ID" PropertyName="SelectedValue"
                                                            Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
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
                                    <table class="InnerTable" id="ButtonTable">
                                        <tr>
                                            <td style="width:30%" align="left" >
                                                <asp:Button ID="btnAdd" runat="server" Text="Поповнити" tabindex="2"
                                                    class="AcceptButton" meta:resourcekey="btAdd" onclick="btnAdd_Click"/>
                                            </td>
                                            <td style="width:40%" align="center">
                                                <ead:EADoc ID="eadFinmonQuestionnaire" runat="server" EAStructID="401"
                                                    TitleText="Опитувальний лист фінмоніторингу" 
                                                    OnBeforePrint="eadFinmonQuestionnaire_BeforePrint"                                                     
                                                    OnDocSigned="eadFinmonQuestionnaire_DocSigned" />
                                            </td>
                                            <td style="width:30%" align="right">
                                                <asp:Button ID="btFirstPayment" runat="server" Text="Первинний внесок" tabindex="5"
                                                    class="AcceptButton" meta:resourcekey="btFirstPayment" onclick="btFirstPayment_Click"/>
                                            </td>
                                        </tr>
                                    </table>
								</td>
							</tr>
							<tr>
								<td>
								    <input id="ContractAddSumGrams" runat="server" type="hidden" />
                                    <input id="Nls_B" type="hidden" runat="server"/>
                                    <input id="dpt_id" type="hidden" runat="server"/> 
									<input id="Nls_A" type="hidden" runat="server"/>
                                    <input id="TT" type="hidden" runat="server"/> 
									<input id="Kv_B" type="hidden" runat="server"/>
                                    <input id="RNK" type="hidden" runat="server"/>
									<input id="AfterPay" type="hidden" runat="server"/>
                                    <input id="BPAY_4_cent" type="hidden" runat="server"/>
                                    <input id="dest_url" type="hidden" runat="server"/>
                                    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" AllowCustomErrorsRedirect="False">
                                        <Scripts>
                                        </Scripts>
                                    </asp:ScriptManager>
                                    <script language="javascript" type="text/javascript">
                                        if (typeof(Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
                                    </script>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositAccCk.inc"-->
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
			</form>
	</body>
</html>
