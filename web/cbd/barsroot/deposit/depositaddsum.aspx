<%@ Page Language="c#" CodeFile="DepositAddSum.aspx.cs" AutoEventWireup="true" Inherits="DepositAddSum" %>

<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Депозитний модуль: Поповнення рахунку</title>
    <meta content="False" name="vs_snapToGrid" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="js/js.js"></script>
    <script type="text/javascript" language="javascript" src="js/AccCk.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
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
        .style1 {
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
                            <td align="right" style="width: 65%">
                                <asp:Label ID="lbInfo" meta:resourcekey="lbInfo12" CssClass="InfoHeader" runat="server">Пополнение депозита №</asp:Label>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server" CssClass="HeaderText" ReadOnly="True" ToolTip="№ депозита"></asp:TextBox>
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
                                <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3" runat="server" CssClass="InfoText" BorderStyle="Inset" ReadOnly="True"
                                    ToolTip="Вкладчик" MaxLength="70"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="textClientPasp" meta:resourcekey="textClientPasp2" runat="server" ToolTip="Паспортные данные" ReadOnly="True" BorderStyle="Inset"
                                    MaxLength="70" CssClass="InfoText"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tbDateR" class="InnerTable">
                                    <tr>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoText">Дата рождения</asp:Label>
                                        </td>
                                        <td>
                                            <igtxt:WebDateTimeEdit ID="DateR" runat="server" ToolTip="Дата рождения" ReadOnly="True" BorderStyle="Inset"
                                                HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                                            </igtxt:WebDateTimeEdit>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoText">Вид договора</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textContractTypeName" meta:resourcekey="textContractTypeName" runat="server" CssClass="InfoText" ToolTip="Вид договора"
                                                ReadOnly="True" BorderStyle="Inset"></asp:TextBox>
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
                                <asp:Label ID="lbDepositParam" meta:resourcekey="lbDepositParam" runat="server" CssClass="InfoLabel">Параметры вклада</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="InnerTable">
                                    <tr>
                                        <td style="width: 25%">
                                            <asp:Label ID="lbDepositCurrency" meta:resourcekey="lbDepositCurrency" runat="server" CssClass="InfoText">Валюта дог.</asp:Label>
                                        </td>
                                        <td style="width: 20%">
                                            <asp:TextBox ID="textDepositCurrency" meta:resourcekey="textDepositCurrency" runat="server" CssClass="InfoText" BorderStyle="Inset"
                                                ReadOnly="True" ToolTip="Валюта договора"></asp:TextBox>
                                        </td>
                                        <td style="width: 5%"></td>
                                        <td style="width: 25%">
                                            <asp:Label ID="lbMinSum" meta:resourcekey="lbMinSum2" runat="server" CssClass="InfoText">Мин. сумма пополнения</asp:Label>
                                        </td>
                                        <td style="width: 5%">
                                            <asp:TextBox ID="textMinSumCurrency" meta:resourcekey="textMinSumCurrency" runat="server" CssClass="InfoText" BorderStyle="Inset" ReadOnly="True"
                                                ToolTip="Валюта"></asp:TextBox>
                                        </td>
                                        <td class="style1">
                                            <igtxt:WebNumericEdit ID="textMinAddSum" runat="server" CssClass="InfoDateSum" BorderStyle="Inset" ReadOnly="True"
                                                ToolTip="Минимальная сумма вклада" MaxLength="38" ValueText="0" MinDecimalPlaces="Two" DataMode="Decimal">
                                            </igtxt:WebNumericEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbIntRate" meta:resourcekey="lbIntRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:Label>
                                        </td>
                                        <td>
                                            <igtxt:WebNumericEdit ID="textIntRate" runat="server" CssClass="InfoDateSum" BorderStyle="Inset" ReadOnly="True"
                                                ToolTip="Текущая процентная ставка" MaxLength="10" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal">
                                            </igtxt:WebNumericEdit>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbAddSum" meta:resourcekey="lbAddSum" runat="server" CssClass="InfoText">Сумма пополнения</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textContractCurrency" meta:resourcekey="textContractCurrency" runat="server" CssClass="InfoText" BorderStyle="Inset"
                                                ReadOnly="True" ToolTip="Валюта"></asp:TextBox>
                                        </td>
                                        <td class="style1">
                                            <igtxt:WebNumericEdit ID="textContractAddSum" runat="server" CssClass="InfoDateSum" BorderStyle="Inset"
                                                ToolTip="Сумма пополнения" MinDecimalPlaces="Two" MinValue="0" DataMode="Decimal" TabIndex="1">
                                            </igtxt:WebNumericEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbDptStartDate" meta:resourcekey="lbDptStartDate" CssClass="InfoText" runat="server">Дата начала договора</asp:Label>
                                        </td>
                                        <td>
                                            <igtxt:WebDateTimeEdit ID="dtStartContract" runat="server" ToolTip="Дата завершения договора" ReadOnly="True"
                                                DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum" HorizontalAlign="Center">
                                            </igtxt:WebDateTimeEdit>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <igtxt:WebDateTimeEdit ID="dtEndContract" runat="server" ToolTip="Дата завершения договора" ReadOnly="True"
                                                DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum" HorizontalAlign="Center">
                                            </igtxt:WebDateTimeEdit>
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
                                <table style='text-align: right' class="InnerTable" id="metalParameters" runat="server" visible="false">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" Style='text-align: left' runat="server" CssClass="InfoLabel" Text="Інформація про злитки" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100%">
                                            <asp:GridView ID="gvAddSum" CssClass="barsGridView" Width="600px" runat="server" AutoGenerateColumns="False" 
                                                DataSourceID="dsDptMetalAddSum" DataKeyNames="BAR_ID" OnDataBound="gvAddSum_DataBound">
                                                <Columns>
                                                    <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" />
                                                    <asp:BoundField DataField="BAR_ID" HeaderText="*" SortExpression="BAR_ID" />
                                                    <asp:BoundField DataField="BARS_COUNT" HeaderText="Кількість<BR>злитків" SortExpression="BARS_COUNT" HtmlEncode="false" />
                                                    <asp:BoundField DataField="BAR_NOMINAL" HeaderText="Номінал<BR>злитку" SortExpression="BAR_NOMINAL" HtmlEncode="false" />
                                                    <asp:BoundField DataField="BAR_PROBA" HeaderText="Проба" SortExpression="BAR_PROBA" />
                                                    <asp:BoundField DataField="INGOT_WEIGHT" HeaderText="Вага<BR>зилитку" SortExpression="INGOT_WEIGHT" HtmlEncode="false" />
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    Дані відсутні
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:FormView ID="fvAddSum" runat="server" BorderStyle="Solid" BorderWidth="1px" Width="600px"
                                                DataSourceID="dsDepositMetalBars_Edit" DataKeyNames="BAR_ID"
                                                OnItemDeleted="fvAddSum_ItemDeleted"
                                                OnItemInserted="fvAddSum_ItemInserted"
                                                OnItemUpdated="fvAddSum_ItemUpdated">
                                                <InsertItemTemplate>
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="width: 40%">
                                                                *Кількість злитків: &nbsp;
                                                            </td>
                                                            <td style="width: 30%">
                                                                <asp:TextBox ID="COUNT_I" runat="server" MaxLength="5" Width="70px"
                                                                    Text='<%# Bind("BARS_COUNT") %>' Style="text-align: right" />
                                                            </td>
                                                            <td style="width: 30%">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="COUNT_I"
                                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                *Номінал злитку: &nbsp;
                                                            </td>
                                                            <td>
                                                                <cc1:NumericEdit ID="NOMINAL_I" runat="server" MaxLength="5" Width="70px"
                                                                    Text='<%# Bind("BAR_NOMINAL") %>' Presiction="1" />
                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="NOMINAL_I"
                                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                *Проба: &nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <cc1:NumericEdit ID="PROBA_I" runat="server" MaxLength="5" Width="70px"
                                                                    Text='<%# Bind("BAR_PROBA") %>' Presiction="1" OnPreRender="PROBA_I_PreRender">
                                                                </cc1:NumericEdit>
                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="PROBA_I"
                                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td colspan="2">
                                                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True"
                                                                    CommandName="Insert" Text="Додати" />
                                                                &nbsp;
                                                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
                                                                        CommandName="Cancel" Text="Відмінити" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="width: 40%">
                                                                ID:
                                                            </td>
                                                            <td style="width: 60%">
                                                                <asp:Label ID="lbID" runat="server" Text='<%# Eval("BAR_ID") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 40%">
                                                                Кількість злитків:
                                                            </td>
                                                            <td style="width: 60%">
                                                                <asp:Label ID="SkLabel" runat="server" Text='<%# Eval("BARS_COUNT") %>'></asp:Label><br />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 40%">
                                                                Номінал злитку:
                                                            </td>
                                                            <td style="width: 60%">
                                                                <asp:Label ID="SLabel" runat="server" Text='<%# Eval("BAR_NOMINAL") %>' />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 40%">
                                                                Проба:
                                                            </td>
                                                            <td style="width: 60%">
                                                                <asp:Label ID="NaznLabel" runat="server" Text='<%# Eval("BAR_PROBA") %>' />
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
                                                            <td style="width: 40%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Кількість злитків:
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="COUNT_U" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BARS_COUNT") %>'></asp:TextBox>
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
                                                                <cc1:NumericEdit ID="NOMINAL_U" runat="server" MaxLength="5" Width="70px"
                                                                    Text='<%# Bind("BAR_NOMINAL") %>' Presiction="1" />
                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NOMINAL_U"
                                                                    ErrorMessage="Необхідно заповнити" Font-Names="Arial" Font-Size="8pt"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Проба:
                                                            </td>
                                                            <td>
                                                                <cc1:NumericEdit ID="PROBA_U" runat="server" MaxLength="5" Width="70px"
                                                                    Text='<%# Bind("BAR_PROBA") %>' Presiction="1">
                                                                </cc1:NumericEdit>
                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="PROBA_U"
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
                                                <EmptyDataTemplate>
                                                    <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                        Text="Додати">
                                                    </asp:LinkButton>
                                                </EmptyDataTemplate>
                                                <FooterTemplate>
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="width: 40%">
                                                                <asp:Label ID="lbTotalNominal" Text="Загальний номінал злитків: &nbsp;" runat="server" />
                                                            </td>
                                                            <td style="width: 20%" align="left">
                                                                <asp:TextBox ID="TOTAL_NOMINAL" runat="server" BackColor="LightGray" ReadOnly="true"
                                                                    Text='<%# Convert.ToString(Bars.Metals.DepositMetals.Sum()) %>'
                                                                    Width="70px" Style="text-align: right" />
                                                            </td>
                                                            <td style="width: 40%"></td>
                                                        </tr>
                                                    </table>
                                                </FooterTemplate>
                                                <FooterStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="LightGray" />
                                            </asp:FormView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ObjectDataSource ID="dsDptMetalAddSum" runat="server" SelectMethod="SelectBars"
                                                TypeName="Bars.Metals.DepositMetals" DataObjectTypeName="Bars.Metals.DepositMetals">
                                                <UpdateParameters>
                                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                                </UpdateParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                                </InsertParameters>
                                            </asp:ObjectDataSource>
                                            <asp:ObjectDataSource ID="dsDepositMetalBars_Edit" runat="server" TypeName="Bars.Metals.DepositMetals"
                                                InsertMethod="InsertBar" SelectMethod="SelectBar"
                                                UpdateMethod="UpdateBar" DeleteMethod="DeleteBar">
                                                <DeleteParameters>
                                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                </DeleteParameters>
                                                <UpdateParameters>
                                                    <asp:Parameter Name="BAR_ID" Type="Int32" />
                                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
                                                </UpdateParameters>
                                                <InsertParameters>
                                                    <asp:Parameter Name="BARS_COUNT" Type="Int32" />
                                                    <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" />
                                                    <asp:ControlParameter Name="CURRENCY" Type="Int32" ControlID="Kv_B" PropertyName="Value" />
                                                    <asp:Parameter Name="BAR_PROBA" Type="Decimal" />
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
                                <input id="btAdd" meta:resourcekey="btAdd" class="AcceptButton" tabindex="2"
                                    type="button" value="Пополнить" runat="server" onclick="AddSum();" />
                                <!-- onclick ="CheckSum('textMinAddSum','textContractAddSum',true);AddSum();" -->
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="ContractAddSumGrams" runat="server" type="hidden" />
                                <input id="Nls_B" type="hidden" runat="server" />
                                <input id="dpt_id" type="hidden" runat="server" />
                                <input id="Nls_A" type="hidden" runat="server" />
                                <input id="TT" type="hidden" runat="server" />
                                <input id="Kv_B" type="hidden" runat="server" />
                                <input id="RNK" type="hidden" runat="server" />
                                <input id="AfterPay" type="hidden" runat="server" />
                                <input id="BPAY_4_cent" type="hidden" runat="server" />
                                <input id="dest_url" type="hidden" runat="server" />
                                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" AllowCustomErrorsRedirect="False">
                                    <Scripts>
                                        <asp:ScriptReference Path="js/js.js" />
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
        <!-- #include virtual="Inc/DepositAccCk.inc"-->
        <!-- #include virtual="Inc/DepositJs.inc"-->
    </form>
</body>
</html>
