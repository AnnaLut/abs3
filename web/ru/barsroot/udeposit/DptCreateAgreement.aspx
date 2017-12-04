<%@ Page Language="C#" CodeFile="DptCreateAgreement.aspx.cs" Inherits="barsroot.udeposit.DptCreateAgreement" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="brs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Заключення/Перегляд Додаткових Угод про зміну умов депозитного договору</title>
    
    <link href="Styles.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" language="JavaScript" src="Scripts/DptCreateAgreement.js?v1.0.1"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.1"></script>
    <script type="text/javascript" language="jscript" src="/Common/Script/cross.js"></script>
</head>
<body>
    <form id="frmCreateAgreement" runat="server">
    <div class="webservice" id="webService" showprogress="true">
    <table width="600px">
        <caption class="BarsLabel">ДУ про зміну умов договору</caption>
        <tr>
            <td align="center" style="color:red">Сторінка знаходиться в розробці!!!</td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td align="right" style="width:50%">
                            <span class="BarsLabel" id="lbAgreementNumber">Додаткова угода №</span>
                        </td>
                        <td align="left" style="width:50%">
                            <input id="tbAgreementNumber" type="text" class="BarsTextBoxRO" style="width: 200px; text-align:center" 
                                tabindex="1" title="Номер додаткової угоди" maxlength="35" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <span class="BarsLabel" id="lbAgreementDate">Дата початку дії додаткової угоди</span>
                        </td>
                        <td align="left">
                             <input id="tbAgreementDate" type="text" class="BarsTextBoxRO" readonly="readonly" style="width: 100px" 
                                tabindex="2" title="Дата початку дії додаткової угоди" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>                
                <asp:Panel ID="pnAgreementParams" GroupingText="Реквізити ДУ" runat="server">
                    <table width="100%">
                        <tr>
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbAgreementType">Вид додаткової угоди:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <input id="tbAgreementTypeId" type="text" readonly="readonly"
                                    class="BarsTextBoxRO" style="width:40px; text-align:center" 
                                    tabindex="3" title="Ідентифікатор виду додаткової угоди" />
                                <asp:DropDownList ID="ddAgreementTypes" DataTextField="NAME" DataValueField="ID"
                                    TabIndex="4" onclick="getSelectedType(this)" 
                                    runat="server" Width="335px" CssClass="BarsTextBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="rowAgreementAmount">
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbNewAmount">Сума договору:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <bars:NumericEdit ID="tbNewAmount" runat="server" Presiction="2"
                                    ToolTip="Нова сума договору"></bars:NumericEdit>
                            </td>
                        </tr>
                        <tr id="rowAgreementDate">
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbNewDateEnd">Дата завершення:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <bars:DateEdit ID="tbNewDateEnd" runat="server" Width="90px" MaxLength="10" 
                                    ToolTip="Нова дата завершення договору"></bars:DateEdit>
                            </td>
                        </tr>
                        <tr id="rowAgreementRate">
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbRate">Відсоткова ставка:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <bars:NumericEdit ID="tbRate" runat="server" MaxLength="6" Presiction="3"></bars:NumericEdit>
                            </td>
                        </tr>
                        <tr id="rowAgreementFreq">
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbFreq">Виплата відсотків:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <input id="tbFreqTypeID" type="text" readonly="readonly"
                                    class="BarsTextBoxRO" style="width:40px; text-align:center" 
                                    tabindex="8" title="Ідентифікатор виду додаткової угоди" />
                                <asp:DropDownList ID="ddFreqTypes" DataTextField="NAME" DataValueField="FREQ"
                                    TabIndex="9" onclick="getSelectedFreq(this)" runat="server" Width="335px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="rowAgreementPenalty">
                            <td align="right" style="width:200px">
                                <span class="BarsLabel" id="lbPenalty">Штраф:</span>
                            </td>
                            <td align="left" style="width:390px; white-space:nowrap">
                                <input id="tbPenaltyId" type="text" readonly="readonly"
                                    class="BarsTextBoxRO" style="width:40px; text-align:center" 
                                    tabindex="10" title="Ідентифікатор виду додаткової угоди" />
                                <asp:DropDownList ID="ddPenaltyTypes" DataTextField="NAME" DataValueField="ID"
                                    TabIndex="11" onclick="getSelectedPenalty(this)" runat="server" Width="335px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="rowReceiver">
                            <td colspan="2" style="width:596px">
                                <asp:Panel ID="pnReceiver" GroupingText="Реквізити отримувача" runat="server" Font-Size="Small">
                                    <table width="100%">
                                        <tr>
                                            <td align="right" style="width:200px">
                                                <span class="BarsLabel" id="lbReceiverBank">Банк отримувача:</span>
                                            </td>
                                            <td align="left" style="width:390px; white-space:nowrap">
                                                <input id="tbReceiverBankCode" class="BarsTextBox" style="width:60px; text-align:center" 
                                                    tabindex="12" title="Код банку отримувача" type="text" 
                                                    onchange="fnCheckBankCode(this)" maxlength="6"/>
                                                <input id="tbReceiverBankName" class="BarsTextBoxRO" readonly="readonly" style="width:310px"
                                                    tabindex="13" title="Назва банку отримувача" type="text"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <span class="BarsLabel" id="lbReceiverAccount">Рахунок отримувача:</span>
                                            </td>
                                            <td align="left" style="white-space:nowrap">
                                                <input id="tbReceiverAccount" class="BarsTextBox" style="width: 150px" 
                                                    tabindex="14" title="Номер рахунку отримувача" type="text" 
                                                    onchange="fnCheckAccount(this)" maxlength="14"/>
                                                <img id="btShowReceiverAccounts" title="Поточні рахунки клієнта" alt="Поточні рахунки клієнта"
                                                    height="16" width="16" class="outset"
                                                    onclick="fnClientAccounst()" src="/Common/Images/BROWSE.gif" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <span class="BarsLabel" id="lbReceiverName">Назва отримувача:</span>
                                            </td>
                                            <td align="left" style="white-space:nowrap">
                                                <input id="tbReceiverkName" class="BarsTextBox" style="width:380px" 
                                                    tabindex="16" title="Назва отримувача" type="text" maxlength="35"/>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <brs:BarsGridViewEx ID="gvAgreements" DataSourceID="dsAgreements" runat="server"
                    Style="width: 100%; font-size: 9pt; font-family:Verdana; cursor:pointer; border-collapse:collapse"
                    CellPadding="2" CellSpacing="0" BorderColor="Black" BorderWidth="1"
                    AllowPaging="True" PageSize="7" ShowPageSizeBox="false" 
                    AutoGenerateColumns="False" AllowSorting="true" ShowCaption="false"
                    JavascriptSelectionType="SingleRow" DataKeyNames="AGRMNT_ID,AGRMNT_STATE"
                    OnRowDataBound="gv_RowDataBound">
                    <Columns>
                        <asp:BoundField HtmlEncode="False" DataField="AGRMNT_ID" HeaderText="Ід."
                            ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HtmlEncode="False" DataField="AGRMNT_NUMBER" HeaderText="Номер" 
                            ItemStyle-Width="110px" ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField HtmlEncode="False" DataField="AGRMNT_BDATE" HeaderText="Дата"
                            ItemStyle-Width="90" ItemStyle-HorizontalAlign="Center" 
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField HtmlEncode="False" DataField="AGRMNT_TYPE_NAME" HeaderText="Тип угоди"
                            ItemStyle-Width="275" ItemStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="AGRMNT_STATE" Visible="false" />
                    </Columns>
                </brs:BarsGridViewEx>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td align="center" style="width:33%">
                            <input id="btCreate" type="button" style="width: 190px; color:green; font-weight: bold"
                                tabindex="18" onclick="fnCreate()" value="Створити" title="Створити додаткову угоду" />
                        </td>
                        <td align="center" style="width:34%">
                            <input id="btPrint" type="button" style="width: 190px; color:blue; font-weight: bold"
                                tabindex="19" onclick="fnPrint()" value="Друк" title="Друк додаткової угоди" />
                        </td>
                        <td align="center" style="width:33%">
                            <input id="btExit" type="button" style="width: 190px; color:red; font-weight: bold"
                                tabindex="20" onclick="fnExit()" value="Вихід" title="Вихід без збереження змін" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tfoot valign="bottom">
            <tr>
                <td style="font-size:small">2.54 від 25.04.2016</td>
            </tr>
        </tfoot>
    </table>
    </div>
        <brs:BarsSqlDataSourceEx ID="dsAgreements" AllowPaging="true"  PageSize="7" ProviderName="barsroot.core"
            runat="server">
        </brs:BarsSqlDataSourceEx>
    </form>
</body>
</html>
