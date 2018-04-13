<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositChangeFrequency.aspx.cs" Inherits="barsroot_deposit_DepositChangeFrequency" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="bars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Зміна періодичності виплати відсотків</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <bars:BarsSqlDataSourceEx ID="dsFreq" runat="server" ProviderName="barsroot.core" />
    <div>
    <table class="MainTable" width="100%">
        <tr>
            <td align="center" style="width: 100%">
                <asp:label id="lbPageTitle" Text=" Зміна періодичності виплати відсотків" runat="server" CssClass="InfoHeader" />
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable" width="100%">
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <table class="InnerTable">
                                <tr>
                                    <td style="width:40%" align="right">
                                        <asp:Label ID="lbDepositID" meta:resourcekey="lbDpt_id" runat="server" CssClass="InfoLabel"
                                            Text="Депозитний договір № "/>
                                        &nbsp;
                                    </td>
                                    <td style="width:40%" align="left">
                                        &nbsp;
                                        <asp:TextBox ID="tbDepositID" runat="server" ReadOnly="True" CssClass="InfoText25"
                                            style="text-align:center; background-color:lightgray" >
                                        </asp:TextBox>
                                    </td>
                                    <td style="width:20%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td style="width:20%" align="right">
                            <asp:label id="lbCurrency" Text="Валюта депозиту:" runat="server" CssClass="InfoLabel">
                            </asp:label>
                        </td>
                        <td style="width:5%">
                             <asp:TextBox ID="tbCurrencyID" runat="server" CssClass="InfoText95 " TabIndex="1" 
                                  ToolTip="Код валюти депозитного договору" ReadOnly="True" 
                                  style="text-align:center; background-color:lightgray" >
                             </asp:TextBox>
                        </td>
                        <td style="width:45%">
                            <asp:TextBox ID="tbCurrencyNAME" runat="server" CssClass="InfoText" TabIndex="2" 
                                 ToolTip="Назва валюти депозитного договору" ReadOnly="True">
                             </asp:TextBox>
                        </td>
                        <td style="width:30%">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:label id="lbProduct" Text="Депозитний продукт:" runat="server" CssClass="InfoLabel">
                            </asp:label>
                        </td>
                        <td>
                             <asp:TextBox ID="tbProductID" runat="server" CssClass="InfoText95" TabIndex="3" 
                                  ToolTip="Код продукту депозитного договору" ReadOnly="True"
                                  style="text-align:center;  background-color:lightgray" >
                             </asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="tbProductNAME" runat="server" CssClass="InfoText" TabIndex="4" 
                                 ToolTip="Назва продукту депозитного договору" ReadOnly="True" >
                             </asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:label id="lbType" Text="Вид депозиту:" runat="server" CssClass="InfoLabel">
                            </asp:label>
                        </td>
                        <td>
                             <asp:TextBox ID="tbTypeID" runat="server" CssClass="InfoText95" TabIndex="5" 
                                 ToolTip="Код виду депозитного договору" ReadOnly="True" 
                                 style="text-align:center; background-color:lightgray" >
                             </asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="tbTypeNAME" runat="server" CssClass="InfoText" TabIndex="6" 
                                 ToolTip="Назва виду депозитного договору" ReadOnly="True">
                             </asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:label id="lbFrequency" Text="Періодичність виплати:" runat="server" CssClass="InfoLabel">
                            </asp:label>
                        </td>
                        <td>
                             <asp:TextBox ID="tbFrequencyID" runat="server" CssClass="InfoText95" TabIndex="7" 
                                 ToolTip="Код код періодичності виплати відсотків" ReadOnly="True" 
                                 style="text-align:center; background-color:lightgray">
                             </asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="listFrequency" TabIndex="8" runat="server" CssClass="BaseDropDownList"
                                DataSourceID="dsFreq" DataTextField="freq_name" DataValueField="freq_id"
                                AutoPostBack="True" OnSelectedIndexChanged="listFrequency_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:CompareValidator ID="CompareFrequency" runat="server" ValidationGroup="FrequencyValidation"
                                ControlToValidate ="tbFrequencyID" Operator="NotEqual"
                                ErrorMessage="* Періодичність виплати Не змінено!" CssClass="Validator" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
             <td>
                <table class="InnerTable" width="100%">
                    <tr>
                        <td style="width:25%" align="center">
                            <asp:Button ID="btnReturn" runat="server" CssClass="AcceptButton" Text="Повернутись"
                                    OnClick="btnReturn_Click" CausesValidation="false" />
                        </td>
                        <td style="width:30%">
                        </td>
                        <td style="width:25%" align="right">
                            <asp:Button ID="btnNext" runat="server" CssClass="AcceptButton" Text="Продовжити"
                                    OnClick="btnNext_Click" CausesValidation="true"  ValidationGroup="FrequencyValidation" />
                        </td>
                        <td style="width:20%">
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
