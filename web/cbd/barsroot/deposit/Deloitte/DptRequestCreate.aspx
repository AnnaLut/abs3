<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptRequestCreate.aspx.cs" Inherits="DptClientRequestCreate" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxScanner.ascx" TagPrefix="bars" TagName="TextBoxScanner" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: формування запиту на доступ через БЕК-офіс</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/ListView.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
    <!-- JavaScript -->
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textClientName,textClientCode,textClientDate,textClientSerial,textClientNumber,textDepositNum",
		    'onkeydown', TreatEnterAsTab);
        }
        function focusControl(id) {
            var control = document.getElementById(id);
            if ((control == null) || (control.readonly) || (control.disabled) || (control.style.display == "none") ||
                (control.offsetHeight == 0 && control.offsetWidth == 0)) {
                return;
            }
            else {
                control.focus();
            }
        }
        function AfterPageLoad() {
            document.getElementById("textClientName").attachEvent("onkeydown", doAlpha);
            document.getElementById("textClientCode").attachEvent("onkeydown", doNum);
            document.getElementById("textClientNumber").attachEvent("onkeydown", doNum);
            document.getElementById('tbTrusteeName').readOnly = true;
            focusControl("textClientName");
        }
        function AfterCreate() {
            document.getElementById('btCreateRequest').disabled = 'disabled';
        }
    </script>
    <script type="text/javascript" language="javascript">
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 25%;
            height: 30px;
        }
        .auto-style2 {
            width: 30%;
            height: 30px;
        }
        .auto-style3 {
            width: 15%;
            height: 30px;
        }
        .auto-style4 {
            width: 27%;
            height: 30px;
        }
        .auto-style5 {
            width: 3%;
            height: 30px;
        }
    </style>
</head>
<body onload="AfterPageLoad();">
    <form id="form1" runat="server">
    <bars:BarsSqlDataSourceEx ID="dsTrusteeType" runat="server" ProviderName="barsroot.core" />
    <bars:BarsSqlDataSourceEx ID="dsContracts" runat="server" ProviderName="barsroot.core"
        AllowPaging="true" />
    <bars:BarsSqlDataSourceEx ID="dsExistingRequests" runat="server" ProviderName="barsroot.core" />
    <ajx:ToolkitScriptManager ID="sm" runat="server" />
    <div style="width: 100%">
        <table class="MainTable" width="100%">
            <tr>
                <td align="center">
                    <asp:Label ID="lbPageTitle" runat="server" Text="Формування запиту на доступ через «БЕК-офіс»"
                        CssClass="InfoHeader" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnTrustee" runat="server" GroupingText="Клієнт">
                        <table class="InnerTable" width="100%" cellpadding="3">
                            <tr>
                                <td align="right" style="width: 25%">
                                    <asp:Label ID="lbTrusteeName" Text="ПІБ клієнта: " runat="server" CssClass="InfoLabel"
                                        meta:resourcekey="lbTrusteeName" Style="text-align: right" />
                                </td>
                                <td style="width: 30%">
                                    <asp:TextBox ID="tbTrusteeName" runat="server" CssClass="InfoText" meta:resourcekey="tbTrusteeName"
                                        TabIndex="1" ToolTip="Назва клієнта третьої особи" ReadOnly="True"></asp:TextBox>
                                </td>
                                <td align="right" style="width: 15%">
                                    <asp:Label ID="lbTrusteeType" Text="Тип клієнта: " runat="server" CssClass="InfoLabel"
                                        meta:resourcekey="lbTrusteeName" Style="text-align: right" />
                                </td>
                                <td style="width: 27%">
                                    <asp:DropDownList ID="ddTrusteeType" runat="server" CssClass="BaseDropDownList" TabIndex="2"
                                        ToolTip="Тип клієнта третьої особи" ForeColor="Red" Font-Bold="true"
                                        OnSelectedIndexChanged="ddTrusteeType_SelectedIndexChanged" AutoPostBack="true" />
                                </td>
                                <td style="width: 3%">
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnRequstType" runat="server" GroupingText="Тип запиту">
                        <table class="InnerTable" width="100%">
                            <tr>
                                <td style="width: 10%">
                                </td>
                                <td style="width: 40%">
                                    <asp:RadioButton ID="rbClientCard" Text="&nbsp; Запит на доступ до Картки Клієнта"
                                        OnCheckedChanged="rbClientCard_CheckedChanged" AutoPostBack="true" runat="server"
                                        GroupName="RequestType" />
                                </td>
                                <td style="width: 10%">
                                </td>
                                <td style="width: 40%">
                                    <asp:RadioButton ID="rbContracts" Text="&nbsp; Запит на доступ до Депозитів" OnCheckedChanged="rbContracts_CheckedChanged"
                                        AutoPostBack="true" runat="server" GroupName="RequestType" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnSearch" runat="server" GroupingText="Умови пошуку договорів">
                        <table class="InnerTable" width="100%" cellpadding="3">
                            <tr>
                                <td align="right" class="auto-style1">
                                    <asp:Label ID="lbClientName" Text="Вкладник: &nbsp;" meta:resourcekey="lbClientName"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td class="auto-style2">
                                    <asp:TextBox ID="textClientName" meta:resourcekey="textClientName" runat="server"
                                        MaxLength="35" TabIndex="3" ToolTip="ПІБ вкладника" CssClass="InfoText"></asp:TextBox>
                                </td>
                                <td align="right" class="auto-style3">
                                    <asp:Label ID="lbDocSerial" Text="Серія документу: &nbsp;" meta:resourcekey="lbDocSerial"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td class="auto-style4">
                                    <asp:TextBox ID="textClientSerial" meta:resourcekey="textClientSerial" runat="server"
                                        MaxLength="10" TabIndex="6" ToolTip="Серія ідентифікуючого документу клієнта"
                                        CssClass="InfoText40"></asp:TextBox>
                                </td>
                                <td class="auto-style5">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbClientOKPO" Text="Ідентифікаційний код: &nbsp;" meta:resourcekey="lbClientOKPO"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textClientCode" meta:resourcekey="textClientCode" runat="server"
                                        MaxLength="10" TabIndex="4" ToolTip="Індивідуальний податковий номер клієнта"
                                        Width="50%" CssClass="InfoText" />
                                    <asp:CustomValidator ID="validatorClientCode" runat="server" ControlToValidate="textClientCode"
                                        ClientValidationFunction="checkClientCode" ValidateEmptyText="True" Display="None"
                                        ValidationGroup="SearchParams" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbDocNumber" Text="Номер документу: &nbsp;" meta:resourcekey="lbDocNumber"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textClientNumber" meta:resourcekey="textClientNumber" runat="server"
                                        MaxLength="10" TabIndex="7" ToolTip="Номер ідентифікуючого документу клієнта"
                                        CssClass="InfoText"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbBirthDate" Text="Дата народження: &nbsp;" meta:resourcekey="lbBirthDate"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textClientDate" runat="server" ToolTip="Дата народження клієнта"
                                        TabIndex="5" CssClass="InfoDate" />
                                    <ajx:MaskedEditExtender ID="meeClientDate" TargetControlID="textClientDate" runat="server"
                                        Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB" UserDateFormat="DayMonthYear"
                                        InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbDepositNumber" Text="Номер вкладу: &nbsp;" meta:resourcekey="lbDepositNumber"
                                        runat="server" CssClass="InfoText"  />
                                </td>
                                <td>
                                    <asp:TextBox ID="textDepositNum" meta:resourcekey="textDepositNum" runat="server"
                                        CssClass="InfoText" MaxLength="35" TabIndex="8" ToolTip="Номер договору вкладу"
                                         />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbNLS" Text="Номер рахунку: &nbsp;" meta:resourcekey="lbNLS"
                                        runat="server" CssClass="InfoText" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textNLS" meta:resourcekey="textNLS" runat="server"
                                        CssClass="InfoText" MaxLength="35" TabIndex="8" ToolTip="Номер рахунку вкладу"
                                         />
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btSearchContracts" runat="server" class="AcceptButton" TabIndex="10"
                                        Text="Пошук" OnClick="btSearchContracts_Click" CausesValidation="true" ValidationGroup="SearchParams" />
                                </td>
                                <td colspan="2">
                                    <asp:ValidationSummary ID="validateInputFields" HeaderText="Незаповненні поля!" runat="server"
                                        ShowMessageBox="true" ShowSummary="false" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <!-- OnPageIndexChanging="gvContracts_PageIndexChanging" -->
                        <bars:BarsGridViewEx ID="gvContracts" DataSourceID="dsContracts" runat="server" CssClass="barsGridView"
                            Width="100%" AllowSorting="false" AutoGenerateColumns="False" ShowCaption="false"
                            TabIndex="11" DateMask="dd/MM/yyyy" CellPadding="2" AllowPaging="false" ShowPageSizeBox="false"
                            PageSize="15" JavascriptSelectionType="MultiSelect" DataKeyNames="DPT_ID,DPT_NUM,NMK,OKPO,BIRTHDATE,DOC_SER,DOC_NUM">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSelect" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DPT_ID" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="№<BR>договору"
                                    HtmlEncode="False" HeaderStyle-Width="120px" ItemStyle-Wrap="true"></asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="TYPE_NAME" SortExpression="TYPE_NAME"
                                    HeaderText="Тип вкладу" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DATZ" SortExpression="DATZ" HeaderText="Дата<BR>відкриття"
                                    DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>закінчення"
                                    DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="NLS" SortExpression="NLS" HeaderText="№<BR>рахунку">
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="LCV" SortExpression="LCV" HeaderText="Вал.">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HtmlEncode="False" DataField="BRANCH_ID" SortExpression="BRANCH_ID"
                                    HeaderText="Код<BR>бранчу">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="NMK" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="OKPO" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="BIRTHDATE" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="DOC_SER" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="DOC_NUM" Visible="false"></asp:BoundField>
                                <asp:TemplateField HeaderText="Частка спадку<BR>Сума доручення" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <bwc:NumericEdit ID="nmAmount" runat="server" Width="90px" MaxLength="10" Visible='<%# (TrusteeType == "V" ? false : true) %>'
                                            Presiction='<%# (TrusteeType == "H" ? 4 : 2) %>'>
                                        </bwc:NumericEdit>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Отримання<BR>виписок" ItemStyle-HorizontalAlign="Center" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbPrint" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Отримання<BR>депозиту" ItemStyle-HorizontalAlign="Center" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbMoney" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дострокове<BR>розірвання" ItemStyle-HorizontalAlign="Center" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbEarlyTermination" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Укладання<BR>дод.угод" ItemStyle-HorizontalAlign="Center" Visible="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbAgreements" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </bars:BarsGridViewEx>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnRequestParams" runat="server" GroupingText="Параметри запиту">
                        <table id="tbRequestParams" runat="server" class="InnerTable" width="100%" cellpadding="5">
                            <tr>
                                <td align="right" style="width: 30%">
                                    <asp:Label ID="lbCertifNum" runat="server" CssClass="InfoText" Text="Номер нотаріального документу:" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbCertifNum" runat="server" MaxLength="30" meta:resourcekey="textClientName"
                                        TabIndex="12" ToolTip="Серія та номер документу" Width="150px" CssClass="InfoText" />
                                    <asp:RequiredFieldValidator ID="validatorCertifNum" ControlToValidate="tbCertifNum"
                                        ValidationGroup="Certificate" ErrorMessage="Не вказано номер документу!" runat="server"
                                        Display="None" CssClass="Validator" SetFocusOnError="true">&nbsp;*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" style="width: 25%">
                                    <asp:Label ID="lbCertifDate" runat="server" CssClass="InfoText" Text="Дата нотаріального документу:"></asp:Label>
                                </td>
                                <td style="width: 15%">
                                    <bwc:DateEdit ID="dtCertifDate" runat="server" Width="80px" TabIndex="13" MinDate="01/01/1950" />
                                    <asp:RequiredFieldValidator ID="validatorCertifDate" ControlToValidate="dtCertifDate"
                                        ValidationGroup="Certificate" ErrorMessage="Не вказано дату документу!" runat="server"
                                        Display="None" CssClass="Validator" SetFocusOnError="true">&nbsp;*</asp:RequiredFieldValidator>
                                </td>
                                <td style="width: 5%">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbRequestDates" runat="server" Text="Дата початку дії: &nbsp;" CssClass="InfoText"></asp:Label>
                                </td>
                                <td style="width: 15%">
                                    <bwc:DateEdit ID="dtDateStart" runat="server" Width="80px" TabIndex="14" MinDate="01/01/2010" />
                                    <asp:RequiredFieldValidator ID="validatorDateStart" ControlToValidate="dtDateStart"
                                        ValidationGroup="Certificate" ErrorMessage="Не вказано дату початку!" runat="server"
                                        Display="Dynamic" CssClass="Validator" SetFocusOnError="true">&nbsp;*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbDateFinish" runat="server" CssClass="InfoText" Text="Дата завершення дії: &nbsp;" />
                                </td>
                                <td>
                                    <bwc:DateEdit ID="dtDateFinish" runat="server" Width="80px" TabIndex="15" MinDate="01/01/2010" />
                                    <asp:RequiredFieldValidator ID="validatorDateFinish" ControlToValidate="dtDateFinish"
                                        ValidationGroup="Certificate" ErrorMessage="Не вказано дату завершення!" runat="server"
                                        Display="Dynamic" CssClass="Validator" SetFocusOnError="true">&nbsp;*</asp:RequiredFieldValidator>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:CompareValidator ID="CompareValidatorDate1" Type="Date" runat="server" CssClass="InfoText"
                                        Display="None" ControlToCompare="dtCertifDate" ControlToValidate="dtDateStart"
                                        Operator="GreaterThanEqual" ValidationGroup="Certificate" ErrorMessage="Дата початку дії має бути більшою за дату видачі!" />
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:CompareValidator ID="CompareValidatorDate2" Type="Date" runat="server" CssClass="InfoText"
                                        Display="None" ControlToCompare="dtDateStart" ControlToValidate="dtDateFinish"
                                        Operator="GreaterThanEqual" ValidationGroup="Certificate" ErrorMessage="Дата початку дії має бути меншою за дату завершення дії!" />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" style="border-bottom: 1px solid #D5DFE5; height: 5px">
                                    <asp:ValidationSummary ID="Summary" runat="server" ShowMessageBox="true" ShowSummary="false"
                                        ValidationGroup="Certificate" HeaderText="Невірно вказані параметри запиту!" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbPrintRequest" Text="Друк заяви на доступ: &nbsp;" runat="server"
                                        CssClass="InfoText" />
                                </td>
                                <td colspan="4">
                                    <asp:ImageButton ID="PrintRequest" runat="server" AlternateText="Друкувати документ"
                                        ImageUrl="/Common/Images/default/24/printer.png" OnClick="btPrintRequest_Click"
                                        ValidationGroup="Certificate" CausesValidation="true" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbAccessApplication" Text="Сканування заяви на доступ: &nbsp;" runat="server"
                                        CssClass="InfoText" />
                                </td>
                                <td colspan="4">
                                    <bars:TextBoxScanner runat="server" ID="scAccessApplication" IsRequired="true" ReadOnly="true"
                                        ValidationGroup="Send" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbWarrant" Text="Сканування документу: &nbsp;" runat="server" CssClass="InfoText" />
                                </td>
                                <td colspan="4">
                                    <bars:TextBoxScanner runat="server" ID="scWarrant" IsRequired="true" ReadOnly="true"
                                        ValidationGroup="Send" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbSignsCard" Text="Сканування картки підписів: &nbsp;" runat="server"
                                        CssClass="InfoText" />
                                </td>
                                <td colspan="4">
                                    <bars:TextBoxScanner runat="server" ID="scSignsCard" IsRequired="true" ReadOnly="true"
                                        ValidationGroup="Send" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbPrintSignsCard" Text="Друк картки підписів: &nbsp;" runat="server"
                                        CssClass="InfoText" />
                                </td>
                                <td colspan="4">
                                    <asp:ImageButton ID="PrintSignsCard" runat="server" AlternateText="Друкувати документ"
                                        ImageUrl="/Common/Images/default/24/printer.png" OnClick="btPrintSign_Click"
                                         />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable" width="100%">
                        <tr>
                            <td align="center" style="width: 25%">
                                <asp:Button ID="btnReturn" runat="server" CssClass="AcceptButton" Text="Повернутись"
                                    OnClick="btnReturn_Click" CausesValidation="false" />
                            </td>
                            <td align="center" style="width: 25%">
                            </td>
                            <td align="center" style="width: 25%">
                                <asp:Button ID="btSelectContract" runat="server" TabIndex="10" class="AcceptButton"
                                    Text="Завершити вибір" OnClick="btSelectContract_Click" CausesValidation="true"
                                    ValidationGroup="Contract" />
                            </td>
                            <td align="center" style="width: 25%">
                                <asp:Button ID="btCreateRequest" runat="server" CssClass="AcceptButton" TabIndex="18"
                                    Text="Сформувати запит на доступ" OnClick="btCreateRequest_Click" CausesValidation="true" 
                                    ValidationGroup="Send" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:ListView ID="lvExistingRequests" runat="server" DataSourceID="dsExistingRequests"
                        OnItemDataBound="ExistingRequests_ItemDataBound">
                        <LayoutTemplate>
                            <table class="tbl_style1" width="98%" border="1px">
                                <thead>
                                    <tr>
                                        <th align="center" colspan="5">
                                            <asp:Label ID="lbExistingRequests" runat="server" Text="Наявні запити по клієнту:"
                                                Font-Size="Medium" Font-Bold="true" />
                                        </th>
                                    </tr>
                                    <tr>
                                        <th align="center">
                                            <asp:Label ID="lbReqID" runat="server" Text="Номер запиту" />
                                        </th>
                                        <th align="center">
                                            <asp:Label ID="lbReqDate" runat="server" Text="Дата запиту" />
                                        </th>
                                        <th align="center">
                                            <asp:Label ID="lbReqParams" runat="server" Text="Параметри запиту" />
                                        </th>
                                        <th align="center">
                                            <asp:Label ID="lbReqTrusteeType" runat="server" Text="Тип клієнта<BR>(3-ї особи)" />
                                        </th>
                                        <th align="center">
                                            <asp:Label ID="lbReqState" runat="server" Text="Статус запиту" />
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                    </tr>
                                </tbody>
                            </table>
                            <asp:DataPager runat="server" ID="dpRequests" PageSize="10">
                                <Fields>
                                    <asp:NumericPagerField ButtonCount="3" />
                                </Fields>
                            </asp:DataPager>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td align="center" style="width: 10%">
                                    <asp:LinkButton ID="lbtItemReqID" runat="server" Text='<%# Eval("REQ_ID") %>' CausesValidation="false"
                                        ToolTip="Перегляд картки депозитного договору" CommandName="ShowReqParams" CommandArgument='<%# Eval("REQ_ID") %>'
                                        OnCommand="ExistingRequests_Command" />
                                </td>
                                <td align="center" style="width: 10%">
                                    <asp:Label ID="lbItemReqDate" runat="server" Text='<%# Eval("REQ_BDATE","{0:dd/MM/yyyy}") %>' />
                                </td>
                                <td align="left" style="width: 50%">
                                    <asp:Label ID="lbItemParams" runat="server" Text='<%# Eval("REQUEST") %>' />
                                </td>
                                <td align="center" style="width: 15%">
                                    <asp:Label ID="lbItemReqTrusteeType" runat="server" Text='<%# Eval("TRUSTEE_TYPE_NAME") %>' />
                                </td>
                                <td align="center" style="width: 15%">
                                    <asp:Label ID="lbItemReqStateName" runat="server" Text='<%# Eval("REQ_STATE_NAME") %>' />
                                </td>
                                <td style="display: none">
                                    <asp:Label ID="lbItemReqStateCode" runat="server" Text='<%# Eval("REQ_STATE_CODE") %>'
                                        Visible="false" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <EmptyItemTemplate>
                            <table class="tbl_style1" width="100%">
                                <tr>
                                    <td>
                                        No records available.
                                    </td>
                                </tr>
                            </table>
                        </EmptyItemTemplate>
                        <EmptyDataTemplate>
                            Запитів не знайдено!</EmptyDataTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
