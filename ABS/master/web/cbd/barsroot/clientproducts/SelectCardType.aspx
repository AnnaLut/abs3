<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectCardType.aspx.cs" Inherits="clientproducts_SelectCardType" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <title>Way4. Вибір платіжної карти</title>
    <script language="javascript" type="text/javascript" src="js/action.js"></script>
    <script language="javascript" type="text/javascript" src="/barsroot/deposit/js/ck.js"></script>
    <link href="/barsroot/deposit/style/barsgridview.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function AfterPageLoad()
        {
            document.getElementById("textClientNameOnCard").attachEvent("onkeydown", doAlpha);
            document.getElementById("textClientSurnameOnCard").attachEvent("onkeydown", doAlpha);
            document.getElementById("textSecretWord").attachEvent("onkeydown", doAlpha);
            document.getElementById("textMonths").attachEvent("onkeydown", doNum);

            document.getElementById("textBranchCode").readOnly = true;
            document.getElementById("textBranchName").readOnly = true;
            document.getElementById('textDeliveryBranchCode').readOnly = true;
            document.getElementById('textDeliveryBranchName').readOnly = true;
        }
    </script>
</head>
<body onload="AfterPageLoad();">
    <form id="form1" runat="server">
    <Bars:BarsSqlDataSourceEx ID="dsProductGrp" runat="server" ProviderName="barsroot.core" />
    <Bars:BarsSqlDataSourceEx ID="dsProject" runat="server" ProviderName="barsroot.core" />
    <Bars:BarsSqlDataSourceEx ID="dsCurrency" runat="server" ProviderName="barsroot.core" />
    <Bars:BarsSqlDataSourceEx ID="dsProduct" runat="server" ProviderName="barsroot.core" />
    <Bars:BarsSqlDataSourceEx ID="dsCard" runat="server" ProviderName="barsroot.core" />
    <ajax:ToolkitScriptManager ID="SM" runat="server" EnablePageMethods="true" />
    <div>
        <table class="MainTable" width="100%">
            <tr>
                <td align="center" colspan="4">
                    <asp:Label ID="lbPageTitle" runat="server" Text="Реєстрація нової платіжної карти"
                        CssClass="InfoHeader" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlClient" runat="server" GroupingText="Клієнт">
                        <table id="tblClient" runat="server" class="InnerTable" width="100%">
                            <tr>
                                <td align="right" style="width: 20%">
                                    <asp:Label ID="lbClientName" runat="server" Text="ПІБ клієнта: " CssClass="InfoLabel"
                                        Style="text-align: right" meta:resourcekey="lbClientName" />
                                </td>
                                <td style="width: 1%"></td>
                                <td align="left" style="width: 44%">
                                    <asp:TextBox ID="textClientName" meta:resourcekey="textClientName" TabIndex="1" Width="98%"
                                        runat="server" ToolTip="Назва клієнта" ReadOnly="True" CssClass="InfoText" />
                                </td>
                                <td align="right" style="width: 20%">
                                    <asp:Label ID="lbClienCode" runat="server" Text="ІПН клієнта: " CssClass="InfoLabel"
                                        Style="text-align: right" meta:resourcekey="lbClienCode" />
                                </td>
                                <td align="left" style="width: 15%">
                                    <asp:TextBox ID="textClientCode" TabIndex="2" Width="96%" runat="server" ToolTip="Індивідуальний податковий номер клієнта"
                                        ReadOnly="True" CssClass="InfoText" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbClienBirthPlace" runat="server" Text="Місце народження: " CssClass="InfoLabel" />
                                </td>
                                <td></td>
                                <td>
                                    <asp:TextBox ID="textClienBirthPlace" TabIndex="3" Width="98%" runat="server" ToolTip="Місце народження клієнта"
                                        ReadOnly="True" CssClass="InfoText" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbClienBirthday" runat="server" Text="Дата народження: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textClienBirthday" TabIndex="4" runat="server" ReadOnly="True" CssClass="InfoDateSum" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbClientAddress" runat="server" Text="Адреса: " CssClass="InfoLabel" />
                                </td>
                                <td></td>
                                <td colspan="3">
                                    <asp:TextBox ID="textClientAddress" TabIndex="5" Width="99%" runat="server" ToolTip="Адреса реєстрації клієнта"
                                        ReadOnly="True" CssClass="InfoText" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbDocument" runat="server" Text="Документ: " CssClass="InfoLabel" />
                                </td>
                                <td></td>
                                <td>
                                    <asp:TextBox ID="textDocument" TabIndex="6" Width="98%" runat="server" ToolTip="Ідентифікуючий документ клієнта"
                                        ReadOnly="True" CssClass="InfoText" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbDocDate" runat="server" Text="Дата видачі: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textDocDate" TabIndex="7" runat="server" ReadOnly="True" CssClass="InfoDateSum" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlCard" runat="server" GroupingText="Картка">
                        <table id="tblCard" runat="server" class="InnerTable" width="100%">
                            <tr>
                                <td align="right" style="width: 20%">
                                    <asp:Label ID="lbGroup" Text="Група: " runat="server" CssClass="InfoLabel" Style="text-align: right" />
                                </td>
                                <td style="width: 1%">
                                </td>
                                <td align="right" style="width: 44%">
                                    <asp:DropDownList ID="listProductGrp" TabIndex="10" runat="server" CssClass="BaseDropDownList"
                                        DataSourceID="dsProductGrp" DataTextField="name" DataValueField="code" AutoPostBack="True"
                                        Width="100%" OnSelectedIndexChanged="listProductGrp_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 20%">
                                </td>
                                <td style="width: 15%">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbProject" Text="Зарплатний проект: " runat="server" CssClass="InfoLabel" Style="text-align: right" />
                                </td>
                                <td></td>
                                <td>
                                    <asp:DropDownList ID="listProject" TabIndex="11" runat="server" CssClass="BaseDropDownList"
                                        DataSourceID="dsProject" DataTextField="project_name" DataValueField="project_id"
                                        AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listProject_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbCurrency" Text="Валюта: " runat="server" CssClass="InfoLabel" />
                                </td>
                                <td></td>
                                <td>
                                    <asp:DropDownList ID="listCurrency" TabIndex="12" runat="server" CssClass="BaseDropDownList"
                                        DataSourceID="dsCurrency" DataTextField="currency_name" DataValueField="currency_code"
                                        AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listCurrency_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbProduct" Text="Продукт: " runat="server" CssClass="InfoLabel" />
                                </td>
                                <td></td>
                                <td>
                                    <asp:DropDownList ID="listProduct" TabIndex="13" runat="server" CssClass="BaseDropDownList"
                                        DataSourceID="dsProduct" DataTextField="product_name" DataValueField="product_code"
                                        AutoPostBack="True" Width="100%" OnSelectedIndexChanged="listProduct_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbCard" Text="Картка: " runat="server" CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbVCard" runat="server" Text="*" CssClass="Required" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="listCard" TabIndex="14" runat="server" CssClass="BaseDropDownList"
                                        DataSourceID="dsCard" DataTextField="sub_name" DataValueField="card_code" AutoPostBack="True"
                                        Width="100%" OnSelectedIndexChanged="listCard_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td colspan="2"></td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbMonths" Text="К-ть місяців дії: " runat="server" CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbvMonths" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvMonths" ControlToValidate="textMonths" runat="server"
                                        ValidationGroup="CheckParams" ErrorMessage="Не вказано к-ть місяців!" 
                                        Text="*" Display="None" SetFocusOnError="true" />
                                    <asp:CompareValidator ID="CompareValidatorMonths" Type="Integer" runat="server" 
                                        ControlToCompare="MaxMonths" ControlToValidate="textMonths" Operator="LessThanEqual"  
                                        ValidationGroup="CheckParams" ErrorMessage="К-ть місяців має бути менша або рівна ..."
                                        Text="*" Display="None" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textMonths" TabIndex="15" runat="server" CssClass="InfoText" 
                                        style="text-align: right" Width="20%" />
                                    <asp:TextBox ID="MaxMonths" runat="server" style="visibility:hidden" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbInstantAccount" Text="Рахунок Instant: " runat="server" CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textInstantAccount" TabIndex="16" Width="96%" runat="server" CssClass="InfoText" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlWay4" runat="server" GroupingText="Way4">
                        <table id="tblWay4" runat="server" class="InnerTable" width="100%">
                            <tr>
                                <td align="right" style="width: 20%">
                                    <asp:Label ID="lbClientNameOnCard" runat="server" Text="Ім'я на картці: " CssClass="InfoLabel" />
                                </td>
                                <td align="right" style="width: 1%">
                                    <asp:Label ID="lbvClientNameOnCard" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvClientNameOnCard" ControlToValidate="textClientNameOnCard"
                                        ValidationGroup="CheckParams" ErrorMessage="Не заповнено ім'я клієнта на картці!"
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                </td>
                                <td align="right" style="width: 24%">
                                    <asp:TextBox ID="textClientNameOnCard" TabIndex="20" runat="server" CssClass="InfoText" />
                                </td>
                                <td align="right" style="width: 25%">
                                    <asp:Label ID="lbWorkPlace" runat="server" Text="Місце роботи: " CssClass="InfoLabel" />
                                </td>
                                <td style="width: 30%">
                                    <asp:TextBox ID="textWorkPlace" TabIndex="26" runat="server" CssClass="InfoText" Width="98%" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbClientSurnameOnCard" runat="server" Text="Прізвище на картці: " CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbvClientSurnameOnCard" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvClientSurnameOnCard" ControlToValidate="textClientSurnameOnCard"
                                        ValidationGroup="CheckParams" ErrorMessage="Не заповнено прізвище клієнта на картці!"
                                        Text="*" Display="None" SetFocusOnError="true"  runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textClientSurnameOnCard" TabIndex="21" runat="server" CssClass="InfoText" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbWorkPost" runat="server" Text="Посада: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textWorkPost" TabIndex="26" runat="server" CssClass="InfoText" Width="98%" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbSecretWord" runat="server" Text="Таємне слово: " CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbvSecretWord" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvSecretWord" ControlToValidate="textSecretWord"
                                        ValidationGroup="CheckParams" ErrorMessage="Не вказано таємне слово!" 
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textSecretWord" TabIndex="22" runat="server" CssClass="InfoText" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbDateHiring" runat="server" Text="Дата прийому на роботу: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textDateHiring" TabIndex="27" runat="server" CssClass="InfoDateSum" />
                                    <ajax:MaskedEditExtender ID="meeDateHiring" TargetControlID="textDateHiring" runat="server"
                                        Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                        UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbBranch" runat="server" Text="Відділення: " CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbvBranch" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvBranch" ControlToValidate="textBranchCode"
                                        ValidationGroup="CheckParams" ErrorMessage="Не вказано відділення!" 
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textBranchCode" TabIndex="23" runat="server" CssClass="InfoText" />
                                </td>
                                <td colspan="2" style="white-space: nowrap">
                                    <input id="btnBranch" type="button" value="..." runat="server" title="Вибір відділення"
                                         tabindex="7" onclick="showBranch('Card');" />
                                    <asp:TextBox ID="textBranchName" TabIndex="28" runat="server" CssClass="InfoText" Width="92%"/>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbDeliveryBranchCode" runat="server" Text="Відділення доставки: " CssClass="InfoLabel" />
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbvDeliveryBranchCode" runat="server" Text="*" CssClass="Required" />
                                    <asp:RequiredFieldValidator ID="rfvDeliveryBranchCode" ControlToValidate="textDeliveryBranchCode"
                                        ValidationGroup="CheckParams" ErrorMessage="Не вказано відділення доставки!" 
                                        Text="*" Display="None" SetFocusOnError="true" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="textDeliveryBranchCode" TabIndex="24" runat="server" CssClass="InfoText" />
                                </td>
                                <td colspan="2" style="white-space: nowrap">
                                    <input id="btnDeliveryBranch" type="button" value="..." runat="server" title="Вибір відділення"
                                         tabindex="7" onclick="showBranch('Delivery');" />
                                    <asp:TextBox ID="textDeliveryBranchName" TabIndex="29" runat="server" Width="92%" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ValidationSummary ID="Summary" runat="server" ShowMessageBox="true" ShowSummary="false"
                         ValidationGroup="CheckParams" HeaderText="Невірно вказані параметри!" />
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable" width="100%">
                        <tr>
                            <td align="left">
                                <asp:Button ID="btnBack" runat="server" Text="Повернутися"
                                    CausesValidation="false" CssClass="AcceptButton" onclick="btnBack_Click" />
                            </td>
                            <td align="right">
                                <asp:Button ID="btnRegisterCard" Text="Реєструвати картку" runat="server" CssClass="AcceptButton"
                                    OnClick="btnRegisterCard_Click" Enabled="false" ValidationGroup="CheckParams" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
