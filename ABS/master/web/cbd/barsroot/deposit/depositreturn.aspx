<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>

<%@ Page Language="c#" CodeFile="DepositReturn.aspx.cs" AutoEventWireup="true" Inherits="DepositReturn" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Виплата по завершенні</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="JavaScript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript" language="javascript" src="js/js.js"></script>
    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="js/AccCk.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textMFO,textOKPO,textNLS,textNMK", 'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        function FOCUS() {
            if (!document.getElementById('textMFO').disabled)
                focusControl('textMFO');
            else if (!document.getElementById('textNLS').disabled)
                focusControl('textNLS');
            else if (!document.getElementById('btNalPay').disabled)
                focusControl('btNalPay');
            else if (!document.getElementById('btPayPercent').disabled)
                focusControl('btPayPercent');
        }
    </script>
    <script type="text/javascript" language="javascript">
		<!--
        CrossAddEventListener(window, 'onload', AddListener4Enter);
		-->
    </script>
</head>
<body onload="FOCUS();">
    <form id="Form1" method="post" runat="server">
    <table class="MainTable">
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td align="right" width="60%">
                            <asp:Label ID="lbInfo" meta:resourcekey="lbInfo4" runat="server" CssClass="InfoHeader"> Выплата депозита №</asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="textDepositNumber" meta:resourcekey="textDepositNumber" runat="server"
                                ToolTip="№ депозита" ReadOnly="True" CssClass="HeaderText"></asp:TextBox>
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
                            <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo" runat="server" CssClass="InfoLabel">Вкладчик</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3" runat="server"
                                ToolTip="Вкладчик" ReadOnly="True" MaxLength="70" CssClass="InfoText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="textClientPasp" meta:resourcekey="textClientPasp2" runat="server"
                                Font-Bold="True" ToolTip="Паспортные данные" ReadOnly="True" MaxLength="70" CssClass="InfoText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td width="30%">
                                        <asp:Label ID="lbDateR" meta:resourcekey="lbDateR" runat="server" CssClass="InfoText">Дата рождения</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebDateTimeEdit ID="DateR" runat="server" ToolTip="Дата рождения" ReadOnly="True"
                                            HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebDateTimeEdit>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptType" meta:resourcekey="lbDptType2" runat="server" CssClass="InfoText">Вид договора</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="textDptType" meta:resourcekey="textDptType" runat="server" ToolTip="Вид договора"
                                ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbDptParams" meta:resourcekey="lbDptParams" runat="server" CssClass="InfoLabel">Параметры вклада</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td width="20%">
                                        <asp:Label ID="lbDptCur" meta:resourcekey="lbDptCur" runat="server" CssClass="InfoText">Валюта дог.</asp:Label>
                                    </td>
                                    <td width="15%">
                                        <asp:TextBox ID="textDptCur" meta:resourcekey="textDptCur" runat="server" ToolTip="Валюта договора"
                                            ReadOnly="True" CssClass="InfoDateSum"></asp:TextBox>
                                    </td>
                                    <td width="10%">
                                    </td>
                                    <td width="25%">
                                        <asp:Label ID="lbDepositSum" meta:resourcekey="lbDepositSum" runat="server" CssClass="InfoText">Сумма на депозитном счету</asp:Label>
                                    </td>
                                    <td width="5%">
                                        <asp:TextBox ID="textDptCurISO" meta:resourcekey="textDptCurISO" runat="server" ToolTip="Валюта"
                                            ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                    <td width="15%">
                                        <igtxt:WebNumericEdit ID="dptSum" runat="server" ToolTip="Сумма на депозитном счету"
                                            ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
                                    </td>
                                </tr>
                                <tr runat="server" id="inherit_row_d">
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbInheritSum" runat="server" CssClass="InfoText" meta:resourcekey="lbInheritSum"
                                            Text="Сумма депозита доступная наследнику"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <igtxt:WebNumericEdit ID="InheritDeposit" runat="server" ToolTip="Сумма на депозитном счету"
                                            ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbDptRate" meta:resourcekey="lbDptRate" runat="server" CssClass="InfoText">Тек. % ставка</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebNumericEdit ID="dptRate" runat="server" ToolTip="Текучащая процентная ставка"
                                            ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbPercentSum" meta:resourcekey="lbPercentSum2" runat="server" CssClass="InfoText">Сумма на счету процентов</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textPercentCurISO" meta:resourcekey="textPercentCurISO" runat="server"
                                            ToolTip="Валюта" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                    <td>
                                        <igtxt:WebNumericEdit ID="dptPercentSum" runat="server" ToolTip="Сумма на счету процентов"
                                            ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
                                    </td>
                                </tr>
                                <tr runat="server" id="inherit_row_p">
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbDInherit" runat="server" CssClass="InfoText" meta:resourcekey="lbPercentSum"
                                            Text="Сумма процентов доступная наследнику"></asp:Label>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <igtxt:WebNumericEdit ID="InheritPercent" runat="server" ToolTip="Сумма на депозитном счету"
                                            ReadOnly="True" MinValue="0" MinDecimalPlaces="SameAsDecimalPlaces" DataMode="Decimal"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebNumericEdit>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbDptStartDate" meta:resourcekey="lbDptStartDate" runat="server" CssClass="InfoText">Дата начала договора</asp:Label>
                                    </td>
                                    <td>
                                        <igtxt:WebDateTimeEdit ID="dptStartDate" runat="server" ToolTip="Дата начала договора"
                                            ReadOnly="True" HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebDateTimeEdit>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbDptEndDate" meta:resourcekey="lbDptEndDate2" runat="server" CssClass="InfoText">Дата завершения договора</asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <igtxt:WebDateTimeEdit ID="dptEndDate" runat="server" ToolTip="Дата завершения договора"
                                            ReadOnly="True" HorizontalAlign="Center" EditModeFormat="dd/MM/yyyy" DisplayModeFormat="dd/MM/yyyy"
                                            CssClass="InfoDateSum">
                                        </igtxt:WebDateTimeEdit>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="6" align="center">
                                        <asp:Label ID="lbTOPAY" meta:resourcekey="lbTOPAY" runat="server" CssClass="InfoLabel">Сумма к выплате</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbSum" meta:resourcekey="lbSum2" runat="server" CssClass="InfoText">С депозитного счета</asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <bwc:NumericEdit ID="dptDepositToPay" runat="server" CssClass="InfoDateSum"
                                            ToolTip="Сума до виплати з депозитного рахунку"></bwc:NumericEdit>
                                        <asp:RangeValidator ID="rvDepositToPay" runat="server" ControlToValidate ="dptDepositToPay" 
                                            EnableClientScript ="true" Type="Double" MinimumValue="0.01"
                                            Enabled="false" >
                                        </asp:RangeValidator>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbPercentTopPay" meta:resourcekey="lbPercentTopPay" runat="server"
                                            CssClass="InfoText">С счета процентов</asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <bwc:NumericEdit ID="dptPercentToPay" runat="server" CssClass="InfoDateSum" ReadOnly="true"
                                            ToolTip="Сума до виплати з рахунку відсотків"></bwc:NumericEdit>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td colspan="5">
                                        <asp:Label ID="lbPayAccount" meta:resourcekey="lbPayAccount2" runat="server" CssClass="InfoLabel">Счета выплаты</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%">
                                        <asp:Label ID="lbAccNum" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:Label>
                                    </td>
                                    <td width="20%">
                                        <asp:TextBox ID="textNLS" meta:resourcekey="textNLS" TabIndex="2" runat="server"
                                            ToolTip="Номер счета" MaxLength="14" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                    <td width="10%">
                                    </td>
                                    <td width="25%">
                                        <asp:Label ID="lbMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО Банка</asp:Label>
                                    </td>
                                    <td width="20%">
                                        <asp:TextBox ID="textMFO" meta:resourcekey="textMFO" TabIndex="1" runat="server"
                                            ToolTip="МФО Банка" MaxLength="6" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbNMK" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textNMK" meta:resourcekey="textNMK" TabIndex="4" runat="server"
                                            ToolTip="Получатель" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Label ID="lbOKPO" meta:resourcekey="lbOKPO" runat="server" CssClass="InfoText">ОКПО получателя</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="textOKPO" meta:resourcekey="textOKPO" TabIndex="3" runat="server"
                                            ToolTip="ОКПО получателя" MaxLength="10" CssClass="InfoText"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table class="InnerTable">
                                <tr>
                                    <td>
                                        <input type="button" id="btNalPay" meta:resourcekey="btNalPay" tabindex="5"
                                            value="Выплата депозита" runat="server" class="AcceptButton" />
                                    </td>
                                    <td>
                                        <input class="AcceptButton" id="btPayPercent" meta:resourcekey="btPayPercent" disabled="disabled"
                                            tabindex="6" type="button" value="Выплата процентов" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <input type="button" id="btSurvey" style="visibility: hidden" tabindex="6" class="AcceptButton"
                                            value="Заповнити анкету" runat="server" onclick="OpenSurvey('/barsroot/Survey/Survey.aspx?par=SURVCLOS&rnk=' + document.getElementById('rnk').value);" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="Nls_A1" type="hidden" runat="server" />
                            <input id="tt" type="hidden" runat="server" />
                            <input id="MFO" type="hidden" runat="server" />
                            <input id="rnk" type="hidden" runat="server" />
                            <input id="Nls_A" type="hidden" runat="server" />
                            <input id="Kv" type="hidden" runat="server" />
                            <input id="kvk" type="hidden" runat="server" />
                            <input id="flv" type="hidden" runat="server" />
                            <input id="CrossRat" type="hidden" runat="server" />
                            <input id="bpp_4_cent" type="hidden" runat="server" />
                            <input id="fli" type="hidden" runat="server" />
                            <input id="dpf_oper" type="hidden" runat="server" />
                            <input id="dpt_id" type="hidden" runat="server" />
                            <input id="AfterPay" type="hidden" runat="server" />
                            <input id="ISCASH" type="hidden" runat="server" />
                            <input id="denom" type="hidden" runat="server" />
                            <input id="BeforePay" type="hidden" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- #include virtual="Inc/DepositAccCk.inc"-->
    <!-- #include virtual="Inc/DepositCk.inc"-->
    <!-- #include virtual="Inc/DepositJs.inc"-->
    </form>
</body>
</html>
