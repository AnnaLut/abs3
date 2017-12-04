<%@ Page Language="C#" CodeFile="DptSwiftDetails.aspx.cs" Inherits="barsroot.udeposit.DptSwiftDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SWIFT реквізити депозитного договору</title>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="Scripts/DptSwiftDetails.js?v1.0.1"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.1"></script>
</head>
<body>
    <form id="frmSwiftDetails" runat="server">
        <table width="550px">
            <caption class="BarsLabel">SWIFT реквізити депозитного договору</caption>
            <tr>
                <td>
                    <asp:Panel ID="pnBankIntermediary" GroupingText="Банк-посередник (56)" runat="server">
                        <table width="99%">
                            <tr>
                                <td align="right" style="width: 120px">
                                    <span class="BarsLabel" id="lbBankIntermediaryName" >Назва:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBankIntermediaryName" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Назва банку-посередника" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBankIntermediaryAddress">Адреса:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBankIntermediaryAddress" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Адреса банку-посередника" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" >
                                    <span class="BarsLabel" id="lbBankIntermediaryCode">SWIFT-код:</span>
                                </td>
                                <td align="right" style="width: 120px">
                                    <input id="tbBankIntermediaryCode" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Код банку-посередника" type="text"/>
                                </td>
                                <td>
                                    <img id="btBankIntermediaryCode" title="Вибір банку-посередника" alt="Вибір банку-посередника"
                                            height="16" width="16" class="outset"
                                            onclick="fnBankSWIFTCode(this)" src="/Common/Images/BOOK.gif" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnBankBeneficiary" GroupingText="Банк-бенефіціар(57)" runat="server">
                        <table width="99%">
                            <tr>
                                <td align="right" style="width: 120px">
                                    <span class="BarsLabel" id="lbBankBeneficiaryName">Назва:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBankBeneficiaryName" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Назва банку-бенефіціара" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBankBeneficiaryAddress">Адреса:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBankBeneficiaryAddress" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Адреса банку-бенефіціара" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBankBeneficiaryCode">SWIFT-код:</span>
                                </td>
                                <td align="right" style="width: 120px">
                                    <input id="tbBankBeneficiaryCode" class="BarsTextBoxRO" readonly="readonly" style="width: 99%" 
                                        title="Код банку-бенефіціара" type="text" />
                                </td>
                                <td>
                                    <img id="btBankBeneficiaryCode" title="Вибір банку-бенефіціара" alt="Вибір банку-бенефіціара"
                                            height="16" width="16" class="outset"
                                            onclick="fnBankSWIFTCode(this)" src="/Common/Images/BOOK.gif" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBankBeneficiaryAccount">Рахунок:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBankBeneficiaryAccount" class="BarsTextBox" style="width: 150px" 
                                        title="Рахунок банку-бенефіціара в банку-посереднику" type="text" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnBeneficiary" GroupingText="Бенефіціар(59)" runat="server">
                        <table width="99%">
                            <tr>
                                <td align="right" style="width: 120px">
                                    <span class="BarsLabel" id="lbBeneficiaryName">Назва:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBeneficiaryName" class="BarsTextBoxRO" style="width: 99%" 
                                        title="Назва бенефіціара" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBeneficiaryAddress">Адреса:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBeneficiaryAddress" class="BarsTextBoxRO" style="width: 99%" 
                                        title="Адреса бенефіціара" type="text" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <span class="BarsLabel" id="lbBeneficiaryAccount">Рахунок:</span>
                                </td>
                                <td colspan="2">
                                    <input id="tbBeneficiaryAccount" class="BarsTextBox" style="width: 150px" 
                                        title="Рахунок бенефіціара" type="text" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="center" valign="middle">
                                <input id="btSave" name="btSave" type="button" style="width: 200px; color:green; font-weight:bold"
                                    tabindex="3" onclick="fnSave()" value="Зберегти" title="Зберегти зміни та вийти" />
                            </td>
                            <td align="center" valign="middle">
                                <input id="btCancel" name="btCancel" type="button" style="width: 200px; color:red; font-weight: bold"
                                    tabindex="4" onclick="fnCancel()" value="Відмінити" title="Вийти без збереження змін" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="webservice" id="webService" showprogress="true">
        </div>
    </form>
</body>
</html>
