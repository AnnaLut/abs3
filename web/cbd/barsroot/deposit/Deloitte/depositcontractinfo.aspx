<%@ Page Language="c#" CodeFile="DepositContractInfo.aspx.cs" AutoEventWireup="true"
    Inherits="DepositContractInfo" Debug="True" %>

<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@ Register Src="~/UserControls/EADocsView.ascx" TagPrefix="bars" TagName="EADocsView" %>
<%@ Register Src="~/UserControls/EADoc.ascx" TagName="EADoc" TagPrefix="ead" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <title>Депозитний модуль: Картка депозиту</title>
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js?v1.1"></script>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript">
        function FOCUS() {
            if (document.getElementById('btFirstPayment') && !document.getElementById('btFirstPayment').disabled)
                focusControl('btFirstPayment');
            else if (document.getElementById('btFormDptText') && !document.getElementById('btFormDptText').disabled)
                focusControl('btFormDptText');
            else if (document.getElementById('btPrintContract') && !document.getElementById('btPrintContract').disabled)
                focusControl('btPrintContract');
            else if (document.getElementById('btAddAgreement') && !document.getElementById('btAddAgreement').disabled)
                focusControl('btAddAgreement');
        }
    </script>
</head>
<body onload="FOCUS();">
    <form id="MainForm" method="post" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <table class="MainTable">
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td align="right" style="width: 60%">
                            <asp:Label ID="lbInfo" meta:resourcekey="lbInfo9" runat="server" CssClass="InfoHeader">Карточка вклада №</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="DPT_NUM" runat="server" ReadOnly="True" CssClass="HeaderText"></asp:TextBox>
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
                <table class="InnerTable">
                    <tr>
                        <td>
                            <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo2" runat="server" CssClass="InfoLabel">Вкладчик</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3" runat="server"
                                CssClass="InfoText" ReadOnly="True" ToolTip="Вкладчик"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 30%">
                                        <asp:TextBox ID="textDocType" meta:resourcekey="textDocType" runat="server" CssClass="InfoText"
                                            ReadOnly="True" ToolTip="Тип документа"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="textDocNumber" meta:resourcekey="textDocNumber2" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Номер"></asp:TextBox>
                                    </td>
                                    <td style="width: 50%">
                                        <asp:TextBox ID="textDocOrg" meta:resourcekey="textDocOrg" runat="server" CssClass="InfoText"
                                            ReadOnly="True" ToolTip="Кем выдан"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td>
                                        <asp:TextBox ID="textClientAddress" meta:resourcekey="textClientAddress2" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Адрес вкладчика"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbContractInfo" meta:resourcekey="lbContractInfo" runat="server" CssClass="InfoLabel">Договор</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbContractNumber" meta:resourcekey="lbContractNumber" runat="server"
                                            CssClass="InfoText">Номер</asp:Label>
                                    </td>
                                    <td style="width: 15%">
                                        <asp:TextBox ID="textContractNumber" meta:resourcekey="textContractNumber" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Номер договора"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbContractDate" meta:resourcekey="lbContractDate" runat="server" CssClass="InfoText">от</asp:Label>
                                    </td>
                                    <td style="width: 15%">
                                        <igtxt:WebDateTimeEdit ID="dtContract" runat="server" CssClass="InfoDateSum" ReadOnly="True"
                                            ToolTip="Дата заключения договора" HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy"
                                            DisplayModeFormat="dd/MM/yyyy">
                                        </igtxt:WebDateTimeEdit>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbContractBegin" meta:resourcekey="lbContractBegin" runat="server"
                                            CssClass="InfoText">Дата начала</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebDateTimeEdit ID="dtContractBegin" runat="server" CssClass="InfoDateSum"
                                            ReadOnly="True" ToolTip="Дата начала действия договора" HorizontalAlign="Center"
                                            EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy">
                                        </igtxt:WebDateTimeEdit>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbContractEnd" meta:resourcekey="lbContractEnd" runat="server" CssClass="InfoText">Дата завершения</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebDateTimeEdit ID="dtContractEnd" runat="server" CssClass="InfoDateSum" ReadOnly="True"
                                            ToolTip="Дата завершения действия договора" HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy"
                                            DisplayModeFormat="dd/MM/yyyy">
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
                                    <td style="width: 25%">
                                        <asp:Label ID="lbDepositType" meta:resourcekey="lbDepositType" runat="server" CssClass="InfoText">Вид вклада</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textDepositType" meta:resourcekey="textDepositType" runat="server"
                                            ReadOnly="True" ToolTip="Вид вклада" CssClass="InfoText" />
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
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbInterestRate" meta:resourcekey="lbInterestRate" runat="server" CssClass="InfoText">Процентная ставка</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebNumericEdit ID="textInterestRate" runat="server" ReadOnly="True" MinValue="0"
                                            DataMode="Decimal" MinDecimalPlaces="SameAsDecimalPlaces" CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
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
                            <asp:Label ID="lbAccountInfo" meta:resourcekey="lbAccountInfo" runat="server" CssClass="InfoLabel">Счета</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbDepositAccount" meta:resourcekey="lbDepositAccount" runat="server"
                                            CssClass="InfoText">Основной счет</asp:Label>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="textDepositAccountCurrency" meta:resourcekey="textDepositAccountCurrency"
                                            runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта основного счёта"></asp:TextBox>
                                    </td>
                                    <td style="width: 35%">
                                        <asp:TextBox ID="textDepositAccount" meta:resourcekey="textDepositAccount" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Счет"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="textDepositAccountRest" runat="server" CssClass="InfoDateSum" ReadOnly="True"
                                            ToolTip="Остаток"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbInterestAccount" meta:resourcekey="lbInterestAccount" runat="server"
                                            CssClass="InfoText">Счет процентов</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textIntAccountCurrency" meta:resourcekey="textIntAccountCurrency"
                                            runat="server" CssClass="InfoText" ReadOnly="True" ToolTip="Валюта счёта процентов"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textInterestAccount" meta:resourcekey="textInterestAccount" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Счет"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textInterestAccountRest" runat="server" CssClass="InfoDateSum" ReadOnly="True"
                                            ToolTip="Остаток"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbIntTransfInfo" meta:resourcekey="lbIntTransfInfo" runat="server"
                                CssClass="InfoLabel">Перечисление процентов</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbIntTransfAccount" meta:resourcekey="lbIntTransfAccount" runat="server"
                                            CssClass="InfoText">Номер счета</asp:Label>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="textIntTransfAccount" meta:resourcekey="textIntTransfAccount" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Номер счета" MaxLength="14"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td style="width: 15%">
                                        <asp:Label ID="lbIntTransfMFO" meta:resourcekey="lbIntTransfMFO" runat="server" CssClass="InfoText">МФО</asp:Label>
                                    </td>
                                    <td style="width: 15%">
                                        <asp:TextBox ID="textIntTransfMFO" meta:resourcekey="textIntTransfMFO" runat="server"
                                            CssClass="InfoText40" ReadOnly="True" ToolTip="МФО" MaxLength="12"></asp:TextBox>
                                    </td>
                                    <td style="width: 5%">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbIntTransfName" meta:resourcekey="lbIntTransfName" runat="server"
                                            CssClass="InfoText">Наименование</asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="textIntTransfName" meta:resourcekey="textIntTransfName" runat="server"
                                            CssClass="InfoText80" ReadOnly="True" ToolTip="Наименование" MaxLength="35"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbIntTransfOKPO" meta:resourcekey="lbIntTransfOKPO" runat="server"
                                            CssClass="InfoText">ОКПО</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textIntTransfOKPO" meta:resourcekey="textIntTransfOKPO" runat="server"
                                            CssClass="InfoText80" ReadOnly="True" ToolTip="ОКПО" MaxLength="14"></asp:TextBox>
                                    </td>
                                    <td>
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
                            <asp:Label ID="lbRestTransfInfo" meta:resourcekey="lbRestTransfInfo" runat="server"
                                CssClass="InfoLabel">Перечисление капитала</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Label ID="lbRestTransfAccount" meta:resourcekey="lbIntTransfAccount" runat="server"
                                            CssClass="InfoText">Номер счета</asp:Label>
                                    </td>
                                    <td style="width: 20%">
                                        <asp:TextBox ID="textRestTransfAccount" meta:resourcekey="textIntTransfAccount" runat="server"
                                            CssClass="InfoText" ReadOnly="True" ToolTip="Номер счёта" MaxLength="14"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%">
                                    </td>
                                    <td style="width: 15%">
                                        <asp:Label ID="lbRestTransfMFO" meta:resourcekey="lbIntTransfMFO" runat="server"
                                            CssClass="InfoText">МФО</asp:Label>
                                    </td>
                                    <td style="width: 15%">
                                        <asp:TextBox ID="textRestTransfMFO" meta:resourcekey="textIntTransfMFO" runat="server"
                                            CssClass="InfoText40" ReadOnly="True" ToolTip="МФО" MaxLength="12"></asp:TextBox>
                                    </td>
                                    <td style="width: 5%">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbRestTransfName" Text="Наименование" runat="server"
                                            CssClass="InfoText" meta:resourcekey="lbIntTransfName" />
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="textRestTransfName" meta:resourcekey="textIntTransfName" runat="server"
                                            CssClass="InfoText80" ReadOnly="True" ToolTip="Наименование" MaxLength="35"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbRestTransfOKPO" meta:resourcekey="lbIntTransfOKPO" runat="server"
                                            CssClass="InfoText">ОКПО</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textRestTransfOKPO" meta:resourcekey="textIntTransfOKPO" runat="server"
                                            CssClass="InfoText80" ReadOnly="True" ToolTip="ОКПО" MaxLength="14"></asp:TextBox>
                                    </td>
                                    <td>
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
                            <table class="InnerTable">
                                <tr>
                                    <td align="center" style="width: 4%">
                                        <img id="btSaveComment" style="cursor: hand" src="\Common\Images\SAVE.gif" runat="server"
                                            onclick="SaveComment()" alt="Зберегти коментар" />
                                    </td>
                                    <td style="width: 96%">
                                        <asp:Label ID="lbContractComments" Text="Коментар" meta:resourcekey="lbContractComments"
                                            runat="server" CssClass="InfoLabel" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="textContractComments" meta:resourcekey="textContractComments" runat="server"
                                CssClass="InfoText" ToolTip="Комментарий" BorderStyle="Inset" Height="40px" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td style="width: 35%">
                                        <asp:CheckBox ID="ckNonCash" runat="server" CssClass="BaseCheckBox" Enabled="False"
                                            Text="&nbsp;Безготівкове відкриття" meta:resourcekey="ckNonCash" />
                                    </td>
                                    <td style="width: 35%"></td>
                                    <td style="width: 30%"></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <ead:EADoc ID="eadPrintContract" runat="server" TitleText="Друк договору" EAStructID="212"
                                            OnBeforePrint="PrintContract_BeforePrint" OnDocSigned="PrintContract_DocSigned" />
                                    </td>
                                    <td>
                                        <ead:EADoc ID="eadFinmonQuestionnaire" runat="server" EAStructID="401" Visible="false"
                                            TitleText="Опитувальний лист ФМ" 
                                            OnBeforePrint="eadFinmonQuestionnaire_BeforePrint" 
                                            OnDocSigned="eadFinmonQuestionnaire_DocSigned" />
                                    </td>
                                    <td align="center">
                                        <bars:EADocsView runat="server" ID="EADocsView" EAStructID="2" />
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
                            <table class="InnerTable" id="ButtonTable">
                                <tr>
                                    <td style="width: 25%">
                                        <asp:Button id="btFirstPayment" runat="server" tabindex="1" meta:resourcekey="btFirstPayment"
                                            Text="Первинний внесок" CssClass="AcceptButton" onclick="btFirstPayment_Click" OnClientClick ="if (check_sign()) return false;" />
                                    </td>
                                    <td style="width: 25%">
                                        <asp:Button ID="btAddAgreement" runat="server" TabIndex="6" 
                                            Text="Додаткові угоди" CssClass="AcceptButton" OnClick="btAddAgreement_Click" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                    <td style="width: 25%">
                                        <asp:Button ID="btPercentPay" Text="Виплата відсотків" runat="server" TabIndex="3"
                                            CssClass="AcceptButton" OnClick="btPercentPay_Click" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                    <td style="width: 25%">
                                        <asp:Button ID="btnNext" meta:resourcekey="btnNext" TabIndex="19" runat="server"
                                            Text="Портфель договорів" CssClass="AcceptButton" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input id="btRreplenish" tabindex="2" type="button" value="Поповнити вклад" runat="server"
                                            onserverclick="btRreplenish_Click" class="AcceptButton" meta:resourcekey="btRreplenish" OnClientClick ="if (check_sign()) return false;"/>
                                        <!-- onclick="location.replace('DepositAddSum.aspx?dpt_id=' + document.getElementById('dpt_id').value + '&agr_id=2&fast=Y&portfolio=Y');" -->
                                    </td>
                                    <td>
                                        <asp:Button ID="btReport" TabIndex="7" runat="server" CssClass="AcceptButton" OnClick="btReport_Click"
                                            Text="Виписка" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                    <td>
                                        <asp:Button ID="btPayout" Text="Виплата/Штрафування" runat="server" TabIndex="4"
                                            CssClass="AcceptButton" OnClick="btPayout_Click" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                    <td>
                                        <asp:Button ID="btShowHistory" Text="Історія" runat="server" meta:resourcekey="btShowHistory"
                                            TabIndex="17" CssClass="AcceptButton" OnClick="btShowHistory_Click" OnClientClick ="if (check_sign()) return false;"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <input id="btSurvey" tabindex="16" meta:resourcekey="btSurvey" runat="server" class="AcceptButton"
                                            type="button" value="Заповнити анкету" onclick="OpenSurvey('/barsroot/Survey/Survey.aspx?par=SURVDPT0&rnk=' + document.getElementById('rnk').value);" />
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                            <input id="SumC_t" type="hidden" runat="server" />
                            <input id="rnk" type="hidden" runat="server" />
                            <input id="Kv" type="hidden" runat="server" /><input id="Nls_B" type="hidden" runat="server" />
                            <input id="vidd" type="hidden" runat="server" />
                            <input id="Templates" type="hidden" runat="server" />
                            <input id="dpt_id" type="hidden" runat="server" /><input id="Nam_B" type="hidden"
                                runat="server" />
                            <input id="Id_B" type="hidden" runat="server" /><input id="AfterPay" type="hidden"
                                runat="server" />
                            <input id="TT" type="hidden" runat="server" /><input id="denom" type="hidden" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
    </form>
</body>
</html>
