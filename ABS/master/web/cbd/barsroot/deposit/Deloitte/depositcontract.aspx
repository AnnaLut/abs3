<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>

<%@ Page Language="c#" CodeFile="DepositContract.aspx.cs" AutoEventWireup="true"
    Inherits="DepositContract" EnableViewState="True" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- ver. 03/09/2013 -->
    <title>Депозитний модуль: Вибір типу депозитного договору</title>
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.5"></script>
    <link href="/barsroot/deposit/style/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textContractNumber,ckTechAcc,listContractType,textContractSum_t,checkboxIsCash,dtContract, textComment",
		    'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
		<!--
        CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="fmDepositContract" method="post" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <bars:BarsSqlDataSourceEx ID="dsType" runat="server" ProviderName="barsroot.core" />
    <bars:BarsSqlDataSourceEx ID="dsCurrency" runat="server" ProviderName="barsroot.core" />
    <bars:BarsSqlDataSourceEx ID="dsContractType" runat="server" ProviderName="barsroot.core" />
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
                                ToolTip="Номер договора" MaxLength="10" CssClass="HeaderText" ReadOnly="True" />
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
                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3"
                    runat="server" CssClass="InfoText" MaxLength="70" ToolTip="Вкладчик" ReadOnly="True" />
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td width="20%">
                            <asp:Label ID="lbTypes" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTypes">Тип договору</asp:Label>
                        </td>
                        <td width="5%">
                            <asp:TextBox ID="tbTypeCode" runat="server" ReadOnly="True" ToolTip="Код депозитного продукту" CssClass="InfoText" />
                        </td>
                        <td width="75%">
                            <asp:DropDownList ID="listTypes" TabIndex="1" runat="server" CssClass="BaseDropDownList"
                                DataSourceID="dsType" DataTextField="type_name" DataValueField="type_id"
                                AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listTypes_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDepositCurrency" Text="Валюта договору" meta:resourcekey="lbDepositCurrency"
                                runat="server" CssClass="InfoLabel" />
                        </td>
                        <td>
                            <asp:TextBox ID="tbCurrencyCode" runat="server" ReadOnly="True" ToolTip="Код валюти депозиту" CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="listCurrency" TabIndex="2" runat="server" CssClass="BaseDropDownList"
                                DataSourceID="dsCurrency" DataTextField="Currency_name" DataValueField="Currency_code"
                                AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listCurrency_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbContractType" Text="Вид договору" meta:resourcekey="lbContractType"
                                runat="server" CssClass="InfoLabel" />
                        </td>
                        <td>
                            <asp:TextBox ID="tbContractType" runat="server" ReadOnly="True" ToolTip="Код виду депозиту" CssClass="InfoText" />
                        </td>
                        <td>
                            <asp:DropDownList ID="listContractType" TabIndex="3" runat="server" CssClass="BaseDropDownList"
                                DataSourceID="dsContractType" DataTextField="type_name" DataValueField="vidd"
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
                            <asp:Label ID="lbBasePercent" Text="Баз. % ставка" meta:resourcekey="lbBasePercent"
                                runat="server" CssClass="InfoText" />
                        </td>
                        <td width="15%">
                            <cc1:NumericEdit ID="textBasePercent" runat="server" CssClass="InfoDateSum" ReadOnly="True"></cc1:NumericEdit>
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td width="25%">
                            <asp:Label ID="lbMinSum" meta:resourcekey="lbMinSum" runat="server" CssClass="InfoText">Минимальная сумма</asp:Label>
                        </td>
                        <td width="5%">
                            <asp:TextBox ID="textMinSumCurrency" meta:resourcekey="textMinSumCurrency"
                                runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td width="15%">
                            <cc1:NumericEdit ID="textMinSum" runat="server" CssClass="InfoDateSum" onblur="GetRate()"
                                ReadOnly="True"></cc1:NumericEdit>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbForecastPercent" runat="server" CssClass="InfoText" Text="Прогнозируемая сумма процентов"
                                meta:resourcekey="lbForecastPercent" />
                        </td>
                        <td>
                            <cc1:NumericEdit ID="ForecastPercent" runat="server" CssClass="InfoDateSum" onblur="GetRate()"
                                ReadOnly="True"></cc1:NumericEdit>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbContractSum" meta:resourcekey="lbContractSum" runat="server" CssClass="InfoText">Сумма вклада</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="textContractCurrency" meta:resourcekey="textContractCurrency"
                                runat="server" ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                        <td>
                            <cc1:NumericEdit ID="textContractSum" onblur="GetRate()" runat="server" CssClass="InfoDateSum"
                                TabIndex="4"></cc1:NumericEdit>
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
                        <td colspan="2">
                            <asp:CheckBox ID="checkboxIsCash" meta:resourcekey="checkboxIsCash" TabIndex="5"
                                runat="server" Text="Наличными" Checked="True" CssClass="BaseCheckBox"></asp:CheckBox>
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
                                            DataSourceID="dsDepositMetalBars" DataKeyNames="BAR_ID" OnDataBound="gvBars_DataBound">
                                            <Columns>
                                                <asp:CommandField ShowSelectButton="True" SelectText="Вибрати" />
                                                <asp:BoundField DataField="BAR_ID" HeaderText="*" SortExpression="BAR_ID" />
                                                <asp:BoundField DataField="BARS_COUNT" HeaderText="Кількість<BR>злитків" SortExpression="BARS_COUNT"
                                                    HtmlEncode="false" />
                                                <asp:BoundField DataField="BAR_NOMINAL" HeaderText="Номінал<BR>злитку" SortExpression="BAR_NOMINAL"
                                                    HtmlEncode="false" />
                                                <asp:BoundField DataField="BAR_PROBA" HeaderText="Проба" SortExpression="BAR_PROBA" />
                                                <asp:BoundField DataField="INGOT_WEIGHT" HeaderText="Вага<BR>зилитку" SortExpression="INGOT_WEIGHT"
                                                    HtmlEncode="false" />
                                            </Columns>
                                            <EmptyDataTemplate>
                                                Дані відсутні
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:FormView ID="fvBars" runat="server" DataSourceID="dsDepositMetalBars_Edit" Width="600px"
                                            OnItemDeleted="fvBars_ItemDeleted" OnItemInserted="fvBars_ItemInserted" OnItemUpdated="fvBars_ItemUpdated">
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
                                                            <asp:TextBox ID="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'></asp:TextBox>
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
                                            <FooterTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 45%">
                                                            Загальний номінал злитків:
                                                            <td style="width: 5%">
                                                                <asp:TextBox ID="TOTAL_NOMINAL" runat="server" BackColor="LightGray" ReadOnly="true"
                                                                    Text='<%# Convert.ToString(Bars.Metals.DepositMetals.Sum()) %>' Width="50">
                                                                </asp:TextBox>
                                                            </td>
                                                            <td style="width: 50%">
                                                            </td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                            <InsertItemTemplate>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 30%">
                                                            *Кількість злитків:
                                                        </td>
                                                        <td style="width: 30%">
                                                            <asp:TextBox ID="COUNT_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BARS_COUNT") %>'></asp:TextBox>
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
                                                            <asp:TextBox ID="NOMINAL_I" runat="server" MaxLength="5" CssClass="InfoText" Text='<%# Bind("BAR_NOMINAL") %>'></asp:TextBox>
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
                                                            <asp:TextBox ID="PROBA_I" runat="server" Text='<%# Bind("BAR_PROBA") %>'></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="PROBA_I"
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
                                        <asp:ObjectDataSource ID="dsDepositMetalBars_Edit" TypeName="Bars.Metals.DepositMetals"
                                            runat="server" InsertMethod="InsertBar" SelectMethod="SelectBar" UpdateMethod="UpdateBar"
                                            DeleteMethod="DeleteBar">
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
                                                <asp:ControlParameter Name="CURRENCY" Type="Int32" ControlID="tbCurrencyCode" PropertyName="Text" />
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
                            <asp:CheckBox ID="cbOnBeneficiary" meta:resourcekey="cbOnBeneficiary" runat="server"
                                TabIndex="6" Text="&nbsp;Вклад на бенефіціара" Font-Bold="true" CssClass="BaseCheckBox" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <asp:CheckBox ID="cbOnChildren" meta:resourcekey="cbOnChildren" runat="server" 
                                TabIndex="6" Text="&nbsp;Вклад на користь малолітної особи" Font-Bold="true" CssClass="BaseCheckBox" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <asp:CheckBox ID="cbOnOwner" meta:resourcekey="cbOnOwner" runat="server" 
                                TabIndex="6" Text="&nbsp;Вклад на ім'я малолітної особи" Font-Bold="true" CssClass="BaseCheckBox" onclick="searchOwner(this.form)" />
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
                        <td width="20%">
                            <asp:TextBox ID="dtContract" runat="server" CssClass="InfoDate"
                                ToolTip="Дата заключення договору" ReadOnly="true" />
                            <ajax:MaskedEditExtender ID="meeClientDate" runat="server"
                                TargetControlID="dtContract" 
                                Mask="99/99/9999" 
                                MaskType="Date"
                                Century="2000"
                                CultureName="en-GB"
                                UserDateFormat="DayMonthYear" 
                                InputDirection="LeftToRight"
                                OnFocusCssClass="MaskedEditFocus" />
                            <asp:CompareValidator ID="DateValidator" runat="server"
                                Type="Date" 
                                ControlToValidate="dtContract"
                                Operator="DataTypeCheck"
                                ErrorMessage="Неправильний формат дати!" />
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
                            <igtxt:WebDateTimeEdit ID="dtContractBegin" runat="server" ToolTip="Дата начала договора"
                                ReadOnly="True" MinValue="1900-01-01" HorizontalAlign="Center" HideEnterKey="True"
                                DisplayModeFormat="dd/MM/yyyy" EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                            </igtxt:WebDateTimeEdit>
                        </td>
                        <td>
                            <asp:Label ID="lbDepositCloseDate" meta:resourcekey="lbDepositCloseDate" runat="server"
                                CssClass="InfoText">Завершения</asp:Label>
                        </td>
                        <td>
                            <igtxt:WebDateTimeEdit ID="dtContractEnd" runat="server" ToolTip="Дата завершения договора"
                                ReadOnly="True" HorizontalAlign="Center" HideEnterKey="True" DisplayModeFormat="dd/MM/yyyy"
                                EditModeFormat="dd/MM/yyyy" CssClass="InfoDateSum">
                            </igtxt:WebDateTimeEdit>
                        </td>
                        <td>
                        </td>
                        <td>
                            <asp:Label ID="lbDuration" Text="Длительность" meta:resourcekey="lbDuration" runat="server"
                                CssClass="InfoText" />
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
                            <input id="btnSubmit" meta:resourcekey="btnSubmit" tabindex="10" type="button" value="Далее"
                                runat="server" class="DirectionButton" onclick="if (ckForm());" />
                        </td>
                    </tr>
                    <tr>
                        <td width="1%">
                            &nbsp;</td>
                        <td width="99%">
                            <input type="hidden" runat="server" id="nb" />
                            <input type="hidden" runat="server" id="kv" />
                            <input type="hidden" runat="server" id="denom" />
                            <input type="hidden" runat="server" id="term_ext" />
                            <input type="hidden" runat="server" id="ContractSumGrams" value="0" />
                            <input id="RNK" type="hidden" runat="server" />
                            <input id="RNK_TR" type="hidden" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
    <!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
    <script language="javascript" type="text/javascript">
        if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();
    </script>
    </form>
    <script type="text/javascript" language="javascript">
        document.getElementById("textContractNumber").attachEvent("onkeydown", doNum);
        document.getElementById("textDurationDays").attachEvent("onkeydown", doNum);
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
