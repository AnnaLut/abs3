﻿<%@ Page Language="c#" CodeFile="DepositEditAccount.aspx.cs" AutoEventWireup="true" Inherits="DepositEditAccount" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Депозитний модуль: Зміна рахунків виплати</title>
    <link href="style/dpt.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="javascript" src="js/js.js"></script>
    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
    <script type="text/javascript" language="javascript" src="js/AccCk.js"></script>
    <script type="text/javascript" language="javascript">
        function AddListener4Enter() {
            AddListeners("textBankAccount,textBankMFO,textIntRcpName,textIntRcpOKPO,textAccountNumber,textRestRcpMFO,textRestRcpOKPO,textRestRcpName",
		    'onkeydown', TreatEnterAsTab);
        }
    </script>
    <script type="text/javascript" language="javascript">
        CrossAddEventListener(window, 'onload', AddListener4Enter);
    </script>
    <script type="text/javascript" language="javascript">
        function AfterPageLoad()
        {
            // document.getElementById('textBankMFO').fireEvent('onblur');
            // document.getElementById('textRestRcpMFO').fireEvent('onblur');

            document.getElementById('textRestRcpMFO').readOnly = true;
            document.getElementById('textAccountNumber').readOnly = true;
            document.getElementById('textRestRcpName').readOnly = true;
            document.getElementById('textRestRcpOKPO').readOnly = true;

            if (document.getElementById('textBankAccount'))
            {
                document.getElementById('textBankMFO').readOnly = true;
                document.getElementById('textBankAccount').readOnly = true;
                document.getElementById('textIntRcpName').readOnly = true;
                document.getElementById('textIntRcpOKPO').readOnly = true;
            }

            // focusControl('btnDeposit');
        }
    </script>
</head>
<body onload="AfterPageLoad();">
    <form id="Form1" method="post" runat="server">
        <table class="MainTable" id="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbInfo" Text="Зміна рахунків виплати" runat="server" CssClass="InfoHeader" />
                </td>
            </tr>
            <tr>
                <td>
                    <table id="ContractTable" class="InnerTable">
                        <tr>
                            <td>
                                <asp:Label ID="lbClientInfo" meta:resourcekey="lbClientInfo2" CssClass="InfoLabel"
                                    runat="server">Вкладчик</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="textClientName" meta:resourcekey="textClientName3" runat="server"
                                    CssClass="InfoText" MaxLength="70" ToolTip="Вкладчик" TabIndex="100" ReadOnly="True" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="textContractType" meta:resourcekey="textContractTypeName" runat="server"
                                    CssClass="InfoText" BorderStyle="Inset" ToolTip="Вид депозитного договору" TabIndex="101" ReadOnly="True" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tbInt" class="InnerTable">
                                    <tr>
                                        <td colspan="6">
                                            <asp:Label ID="lbPercentInfo" meta:resourcekey="lbPercentInfo" runat="server" CssClass="InfoLabel">Выплата процентов</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbBankAccount" meta:resourcekey="lbAccNum" CssClass="InfoText" runat="server">Номер счета</asp:Label>
                                        </td>
                                        <td style="width: 25%">
                                            <asp:TextBox ID="textBankAccount" meta:resourcekey="textNLS" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="14" ToolTip="Номер счета" TabIndex="2"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%">
                                            <input id="btPercent" runat="server" class="HelpButton" type="button" value="?" title="Вибір рахунка"
                                                onclick="SearchAccounts('ALL', 'textBankAccount', 'textBankMFO', 'textIntRcpOKPO', 'textIntRcpName');" />
                                            <input id="btPercent0" runat="server" class="HelpButton" type="button" value="X" title="Сброс"
                                                onclick="CleanRetPercentAccounts()" /></td>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbBankMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО банка</asp:Label>
                                        </td>
                                        <td style="width: 15%">
                                            <asp:TextBox ID="textBankMFO" meta:resourcekey="textMFO" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="12" ToolTip="МФО банка" TabIndex="1"></asp:TextBox>
                                        </td>
                                        <td  style="width: 10%"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbIntRcpName" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textIntRcpName" meta:resourcekey="textNMK" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="35" ToolTip="Получатель" TabIndex="4"></asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbIntRcpOKPO" meta:resourcekey="lbIntRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textIntRcpOKPO" meta:resourcekey="textIntRcpOKPO" runat="server"
                                                CssClass="InfoText" BorderStyle="Inset" MaxLength="10" ToolTip="Код ОКПО" TabIndex="3"></asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbIntCardNumber" meta:resourcekey="lbIntCardN" runat="server" CssClass="InfoText">Номер картки</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textIntCardNumber" meta:resourcekey="textIntCardN" runat="server"
                                                CssClass="InfoText" BorderStyle="Inset" MaxLength="16" ToolTip="Номер картки"
                                                TabIndex="5"></asp:TextBox>
                                        </td>
                                        <td colspan="4"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tbRest" class="InnerTable">
                                    <tr>
                                        <td colspan="6">
                                            <asp:Label ID="lbRestInfo" meta:resourcekey="lbRestInfo" CssClass="InfoLabel" runat="server">Возврат депозита</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbAccount" meta:resourcekey="lbAccNum" runat="server" CssClass="InfoText">Номер счета</asp:Label>
                                        </td>
                                        <td style="width: 25%">
                                            <asp:TextBox ID="textAccountNumber" meta:resourcekey="textNLS" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="14" ToolTip="Номер счета" TabIndex="6"></asp:TextBox>
                                        </td>
                                        <td style="width: 10%">
                                            <input id="btDeposit" type="button" value="?" class="HelpButton" runat="server" title="Вибір рахунка"
                                                onclick="SearchAccounts('ALL', 'textAccountNumber', 'textRestRcpMFO', 'textRestRcpOKPO', 'textRestRcpName');" />
                                            <input id="btDeposit0" type="button" value="Х" class="HelpButton" runat="server" title="Сброс рахунка"
                                                onclick="CleanRetDepositAccounts()" /></td>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbRestRcpMFO" meta:resourcekey="lbMFO" runat="server" CssClass="InfoText">МФО банка</asp:Label>
                                        </td>
                                        <td style="width: 15%">
                                            <asp:TextBox ID="textRestRcpMFO" meta:resourcekey="textMFO" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="12" ToolTip="МФО банка" TabIndex="5"></asp:TextBox>
                                        </td>
                                        <td  style="width: 10%"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbRestRcpName" meta:resourcekey="lbNMK2" runat="server" CssClass="InfoText">Получатель</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textRestRcpName" meta:resourcekey="textNMK" runat="server" CssClass="InfoText"
                                                BorderStyle="Inset" MaxLength="35" ToolTip="Получатель" TabIndex="9"></asp:TextBox>
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Label ID="lbRestRcpOKPO" meta:resourcekey="lbIntRcpOKPO" runat="server" CssClass="InfoText">Код ОКПО</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textRestRcpOKPO" meta:resourcekey="textIntRcpOKPO" runat="server"
                                                CssClass="InfoText" BorderStyle="Inset" MaxLength="10" ToolTip="Код ОКПО" TabIndex="8">
                                            </asp:TextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lbDptCardNumber" Text="Номер картки" meta:resourcekey="lbDptCardN" runat="server" CssClass="InfoText" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="textDptCardNumber" meta:resourcekey="textDptCardN" runat="server"
                                                TabIndex="10" CssClass="InfoText" BorderStyle="Inset" MaxLength="16" ToolTip="Номер картки" />
                                        </td>
                                        <td colspan="4"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input id="NMK" type="hidden" runat="server" />
                                <input id="OKPO" type="hidden" runat="server" />
                                <input id="rnk" type="hidden" runat="server" />
                                <input id="cur_id" type="hidden" runat="server" />
                                <input id="MFO" type="hidden" runat="server" />
                                <input id="err_n" type="hidden" runat="server" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="InnerTable">
                                    <tr>
                                        <td align="left" style="width: 50%">
                                            <input id="btPay" meta:resourcekey="btPay2" type="button" value="Изменить" runat="server"
                                                tabindex="12" class="AcceptButton" />
                                        </td>
                                        <td align="right" style="width: 50%">
                                            <asp:Button ID="btnBack" Text="Назад" runat="server" CausesValidation="false"
                                                TabIndex="13" CssClass="AcceptButton" OnClick="btnBack_Click" />
                                        </td>
                                    </tr>
                                </table>
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
