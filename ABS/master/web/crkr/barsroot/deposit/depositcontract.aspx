<%@ Page Language="c#" CodeFile="DepositContract.aspx.cs" AutoEventWireup="true"
    Inherits="DepositContract" EnableViewState="True" %>

<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc2" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- ver. 15/04/2014 --> 
    <title>Депозитний модуль: Вибір типу депозитного договору</title>
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="JavaScript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="js/js.js"></script>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textContractNumber,ckTechAcc,listContractType,textContractSum_t,checkboxIsCash,dtContract_t,textComment",
		    'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
</head>
<body>
    <form id="fmDepositContract" method="post" runat="server">
    <bars:BarsSqlDataSourceEx ID="dsCurrency" runat="server" ProviderName="barsroot.core" />
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
                            <asp:Label ID="lbInfo" meta:resourcekey="lbInfo5" runat="server" CssClass="InfoHeader">Договор №</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="textContractNumber" meta:resourcekey="textContractNumber" runat="server"
                                ToolTip="Номер договора" MaxLength="10" CssClass="HeaderText" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3" TabIndex="100"
                    runat="server" CssClass="InfoText" MaxLength="70" ToolTip="Вкладчик" ReadOnly="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr style="visibility:hidden">
                        <td width="20%">
                            <asp:Label ID="Label2" Text="Валюта договору" meta:resourcekey="lbDepositCurrency" runat="server" CssClass="InfoLabel" />
                        </td>
                        <td width="5%">
                            <asp:TextBox ID="tbCurrencyCode" runat="server" ReadOnly="True" ToolTip="Код валюти депозиту" CssClass="InfoText" />
                        </td>
                        <td width="75%">
                            <asp:DropDownList ID="listCurrency" TabIndex="2" runat="server" CssClass="BaseDropDownList"
                                DataSourceID="dsCurrency" DataTextField="Currency_name" DataValueField="Currency_code"
                                AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listCurrency_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%">
                            <asp:Label ID="lbTypes" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTypes">Тип договору</asp:Label>
                        </td>
                        <td width="5%">
                            <asp:TextBox ID="tbTypeCode" runat="server" ReadOnly="True" ToolTip="Код депозитного продукту" CssClass="InfoText" />
                        </td>
                        <td width="75%">
                            <asp:DropDownList ID="listTypes" TabIndex="2" runat="server" CssClass="BaseDropDownList"
                                DataSource="<%# dsType %>" DataTextField="type_name" DataValueField="type_id"
                                AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listTypes_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:Label>
                        </td>
                        <td>
                             <asp:TextBox ID="tbContractType" runat="server" ReadOnly="True" ToolTip="Код виду депозиту" CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="listContractType" TabIndex="2" runat="server" CssClass="BaseDropDownList"
                                DataSource="<%# dsContractType %>" DataTextField="dpt_name" DataValueField="dpt_type"
                                AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listContractType_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
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
                        <td width="25%">
                            <asp:Label ID="lbDepositCurrency" meta:resourcekey="lbDepositCurrency" runat="server"
                                CssClass="InfoText">Валюта дог.</asp:Label>
                        </td>
                        <td width="15%">
                            <asp:TextBox ID="textDepositCurrency" meta:resourcekey="textDepositCurrency" TabIndex="101"
                                runat="server" ToolTip="Валюта договора" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td width="25%">
                            <asp:Label ID="lbMinSum" meta:resourcekey="lbMinSum" runat="server" CssClass="InfoText">Минимальная сумма</asp:Label>
                        </td>
                        <td width="5%">
                            <asp:TextBox ID="textMinSumCurrency" meta:resourcekey="textMinSumCurrency" TabIndex="103"
                                runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td width="15%">
                            <cc1:NumericEdit ID="textMinSum" runat="server" CssClass="InfoDateSum" onblur="GetRate()"
                                ReadOnly="True"></cc1:NumericEdit>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbBasePercent" meta:resourcekey="lbBasePercent" runat="server" CssClass="InfoText">Баз. % ставка</asp:Label>
                        </td>
                        <td>
                            <cc1:NumericEdit ID="textBasePercent" runat="server" CssClass="InfoDateSum" ReadOnly="True"></cc1:NumericEdit>
                        </td>
                        <td align="center">
                            <asp:Label ID="lbPlus" runat="server" CssClass="InfoText" Text="+"></asp:Label>
                        </td>
                        <td>
                            <cc1:NumericEdit ID="AbsBonus" runat="server" ReadOnly="True" CssClass="InfoDateSum"></cc1:NumericEdit>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbContractSum" meta:resourcekey="lbContractSum" runat="server" CssClass="InfoText">Сумма вклада</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textContractCurrency" meta:resourcekey="textContractCurrency" TabIndex="105"
                                runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td>
                            <cc1:NumericEdit ID="textContractSum" onblur="GetRate()" runat="server" CssClass="InfoDateSum"
                                TabIndex="3" MaxLength="10" ></cc1:NumericEdit>
                        </td>
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
                            <asp:Label ID="lbForecastPercent" runat="server" CssClass="InfoText" meta:resourcekey="lbForecastPercent">Прогнозируемая сумма процентов</asp:Label>
                        </td>
                        <td>
                        </td>
                        <td>
                            <cc1:NumericEdit ID="ForecastPercent" runat="server" CssClass="InfoDateSum" onblur="GetRate()"
                                TabIndex="3" ReadOnly="True"></cc1:NumericEdit>
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
                        <td>
                        </td>
                        <td>
                        </td>
                        <td colspan="2">
                            <asp:CheckBox ID="checkboxIsCash" runat="server" Text="Готівкою" 
                                TabIndex="4" meta:resourcekey="checkboxIsCash" CssClass="BaseCheckBox"
                                OnCheckedChanged="checkboxIsCash_CheckedChanged" AutoPostBack="true" ></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <table style='text-align: right' class="InnerTable" id="metalParameters" runat="server"
                                visible="false">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" Style='text-align: left' runat="server" CssClass="InfoLabel">Інформація про злитки</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 100%">
                                        <asp:GridView ID="gvBars" CssClass="barsGridView" Width="600px" runat="server" AutoGenerateColumns="False"
                                            DataSourceID="dsDepositMetals" DataKeyNames="BAR_ID" OnDataBound="gvBars_DataBound">
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
                                        <asp:FormView ID="fvBars" runat="server" BorderStyle="Solid" BorderWidth="1px" Width="600px" 
                                            DataSourceID="dsDepositMetalBars_Edit" DataKeyNames="BAR_ID"                                            
                                            OnItemInserted="fvBars_ItemInserted"
                                            OnItemUpdated="fvBars_ItemUpdated"
                                            OnItemDeleted="fvBars_ItemDeleted" >
                                            <InsertItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 40%">
                                                            *Кількість злитків: &nbsp;
                                                        </td>
                                                        <td style="width: 30%">
                                                            <asp:TextBox ID="COUNT_I" runat="server" MaxLength="5" Width="70px"
                                                                Text='<%# Bind("BARS_COUNT") %>' style="text-align:right" />
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
                                                           <cc1:NumericEdit ID="NOMINAL_I" runat="server" MaxLength="5"  Width="70px"
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
                                                                Text='<%# Bind("BAR_PROBA") %>' Presiction="1" OnPreRender="PROBA_I_PreRender" >
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
                                                            <asp:Label ID="lb_Ingot_ID" runat="server" Text='<%# Eval("BAR_ID") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 40%">
                                                            Кількість злитків:
                                                        </td>
                                                        <td style="width: 60%">
                                                            <asp:Label ID="lb_Ingot_AMOUT" runat="server" Text='<%# Eval("BARS_COUNT") %>'></asp:Label><br />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 40%">
                                                            Номінал злитку:
                                                        </td>
                                                        <td style="width: 60%">
                                                            <asp:Label ID="lb_Ingot_NOMINAL" runat="server" Text='<%# Eval("BAR_NOMINAL") %>' />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 40%">
                                                            Проба:
                                                        </td>
                                                        <td style="width: 60%">
                                                            <asp:Label ID="lb_Ingot_FINE" runat="server" Text='<%# Eval("BAR_PROBA") %>' />
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
                                                            <cc1:NumericEdit ID="NOMINAL_U" runat="server" MaxLength="5"  Width="70px"
                                                                Text='<%# Bind("BAR_NOMINAL") %>' Presiction="1" />
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
                                                            <cc1:NumericEdit ID="PROBA_U" runat="server" MaxLength="5" Width="70px" 
                                                                Text='<%# Bind("BAR_PROBA") %>' Presiction="1" OnPreRender="PROBA_I_PreRender" >
                                                            </cc1:NumericEdit>
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
                                            <EmptyDataTemplate>
                                                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="Додати">
                                                </asp:LinkButton>
                                            </EmptyDataTemplate>
                                            <FooterTemplate>
                                                <table style="width: 100%" >
                                                    <tr>
                                                        <td style="width: 40%">
                                                            <asp:Label ID="lbTotalNominal" Text="Загальний номінал злитків: &nbsp;" runat="server" />
                                                        </td>
                                                        <td style="width: 20%" align="left">
                                                            <asp:TextBox ID="TOTAL_NOMINAL" runat="server" BackColor="LightGray" ReadOnly="true"
                                                                Text='<%# Convert.ToString(Bars.Metals.DepositMetals.Sum()) %>' 
                                                                Width="70px" style="text-align:right" />
                                                        </td>
                                                        <td style="width: 40%">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                            <FooterStyle  BorderStyle="Solid" BorderWidth="1px" BorderColor="LightGray" />
                                        </asp:FormView>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:ObjectDataSource ID="dsDepositMetals" runat="server" SelectMethod="SelectBars"
                                            TypeName="Bars.Metals.DepositMetals" DataObjectTypeName="Bars.Metals.DepositMetals">
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
                                                <asp:Parameter Name="BAR_NOMINAL" Type="Decimal" Size="5" />
                                                <asp:ControlParameter Name="CURRENCY" Type="Int32" ControlID="kv" PropertyName="Value" />
                                                <asp:Parameter Name="BAR_PROBA" Type="Decimal" Size="6" />
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
                            <asp:CheckBox ID="ckTechAcc" meta:resourcekey="ckTechAcc" TabIndex="5" runat="server"
                                Text="Открыть технический счет по вкладу" CssClass="BaseCheckBox" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbDepositDates" meta:resourcekey="lbDepositDates" runat="server" CssClass="InfoLabel">Даты договора</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td width="15%">
                            <asp:Label ID="lbDepositDate" meta:resourcekey="lbDepositDate" runat="server" CssClass="InfoText">Заключения</asp:Label>
                        </td>
                        <td width="15%">
                            <igtxt:WebDateTimeEdit ID="dtContract" TabIndex="6" runat="server" ToolTip="Дата заключения договора"
                                MinValue="1900-01-01" HorizontalAlign="Center" HideEnterKey="True" DisplayModeFormat="dd/MM/yyyy"
                                EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                            </igtxt:WebDateTimeEdit>
                        </td>
                        <td>
                        </td>
                        <td width="10%">
                        </td>
                        <td width="15%">
                        </td>
                        <td width="5%">
                        </td>
                        <td width="15%">
                        </td>
                        <td width="10%">
                            <asp:Label ID="lbMonths" meta:resourcekey="lbMonths" runat="server" CssClass="InfoText">Месяцев</asp:Label>
                        </td>
                        <td width="10%">
                            <asp:Label ID="lbDays" meta:resourcekey="lbDays" runat="server" CssClass="InfoText">Дней</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDepositOpenDate" meta:resourcekey="lbDepositOpenDate" runat="server"
                                CssClass="InfoText">Начала</asp:Label>
                        </td>
                        <td>
                            <igtxt:WebDateTimeEdit ID="dtContractBegin" TabIndex="110" runat="server" ToolTip="Дата начала договора"
                                ReadOnly="True" HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
                                CssClass="InfoDateSum">
                            </igtxt:WebDateTimeEdit>
                        </td>
                        <td style="width: 42px">
                        </td>
                        <td>
                            <asp:Label ID="lbDepositCloseDate" meta:resourcekey="lbDepositCloseDate" runat="server"
                                CssClass="InfoText">Завершения</asp:Label>
                        </td>
                        <td>
                            <igtxt:WebDateTimeEdit ID="dtContractEnd" TabIndex="111" runat="server" ToolTip="Дата завершения договора"
                                ReadOnly="True" HorizontalAlign="Center" DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy"
                                CssClass="InfoDateSum">
                            </igtxt:WebDateTimeEdit>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbDuration" meta:resourcekey="lbDuration" runat="server" CssClass="InfoText">Длительность</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textDurationMonths" runat="server" onblur="CalcEndDate()" CssClass="InfoDateSum"
                                TabIndex="7" Enabled="False" MaxLength="3"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="textDurationDays" runat="server" onblur="CalcEndDate()" CssClass="InfoDateSum"
                                TabIndex="8" Enabled="False" MaxLength="3"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lbComment" meta:resourcekey="lbComment" runat="server" CssClass="InfoText">Комментарий</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="textComment" meta:resourcekey="textComment" TabIndex="9" runat="server"
                    MaxLength="200" ToolTip="Комментарий" TextMode="MultiLine" CssClass="InfoText"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td width="1%">
                            <input id="btnBack" meta:resourcekey="btnBack" tabindex="11" type="button" value="Назад"
                                runat="server" class="DirectionButton" />
                        </td>
                        <td width="99%">
                            <input id="btnSubmit" meta:resourcekey="btnSubmit" type="button" value="Далее" class="DirectionButton"
                                runat="server" onclick="if (ckForm());" tabindex="10" />
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
        if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    </form>
    <script type="text/javascript" language="javascript">
        document.getElementById("textContractNumber").attachEvent("onkeydown", doNum);
        document.getElementById("textDurationDays").attachEvent("onkeydown", doNum);
        document.getElementById("textDurationMonths").attachEvent("onkeydown", doNum);
        
        if (document.getElementById('fvBars$COUNT_I'))
            document.getElementById('fvBars$COUNT_I').attachEvent("onkeydown", doNum);
        if (document.getElementById('fvBars$COUNT_U'))
            document.getElementById('fvBars$COUNT_U').attachEvent("onkeydown", doNum);
    </script>
</body>
</html>
