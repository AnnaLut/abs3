<%@ Page Language="c#" Inherits="barsroot.udeposit.DptDealState" CodeFile="dptdealstate.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Поточний стан договору</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/DptDealState.js?v1.9.5"></script>
    <script type="text/javascript" language="JavaScript" src="/Common/Script/BarsIe.js"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.0"></script>
</head>
<body onkeydown="fnHotKey()" bottommargin="0" leftmargin="0" topmargin="0" rightmargin="0">
    <form id="DptDealStateForm" method="post" runat="server">
    <table width="100%">
        <tr>
            <td nowrap="nowrap">
                <div style="background-color: lightgrey">
                    <table cellspacing="0" cellpadding="0" border="2">
                        <tr>
                            <td>
                                &nbsp;
                                <img class="outset" id="btDetail" title="Параметри договору" onclick="fnDetail()"
                                    src="/Common/Images/OPEN_.gif">
                                &nbsp;
                                <img class="outset" id="btRefresh" title="Перечитати" onclick="fnRefresh()" src="/Common/Images/REFRESH.gif">
                            </td>
                            <td>
                                &nbsp;
                                <img class="outset" id="btExit" title="Вихід" onclick="fnClose()" src="/Common/Images/DISCARD.gif">&nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center" nowrap="nowrap">
                <asp:Label ID="lbTitleDeal" runat="server" Font-Bold="True" Font-Size="12pt" Font-Names="Verdana"
                    ForeColor="Navy">Депозитний договір</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pbMainInfo" runat="server" BorderStyle="Groove" BorderWidth="2px">
                    <table>
                        <tr>
                            <td nowrap="nowrap" align="right">
                                <span class="BarsLabel" id="lbClient">Клієнт:</span>
                            </td>
                            <td style="width: 155px" nowrap="nowrap" >
                                <input class="BarsTextBoxRO" id="tbNmk" title="Клієнт" style="width: 270px" tabindex="0"
                                    readonly="readonly" type="text" />
                            </td>
                            <td align="right" nowrap="nowrap">
                                <span class="BarsLabel" id="lbVal">Валюта договору:</span>
                            </td>
                            <td>
                                <input class="BarsTextBoxRO" id="tbKv" title="Валюта договору" style="width: 270px"
                                    tabindex="0" readonly="readonly" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap" style="width: 109px; height: 10px" align="right">
                                <span class="BarsLabel" id="lbVidDog">Вид депозиту:</span>
                            </td>
                            <td style="width: 155px">
                                <input class="BarsTextBoxRO" id="tbVidD" title="Вид депозиту" style="width: 270px"
                                    readonly="readonly" type="text" />
                            </td>
                            <td nowrap="nowrap" align="right">
                                <span class="BarsLabel" id="lbViplProc">Виплата %%:</span>
                            </td>
                            <td>
                                <input class="BarsTextBoxRO" id="tbFreq" title="Виплата %%" style="width: 270px"
                                    tabindex="0" readonly="readonly" type="text" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td nowrap="nowrap" align="left">
                <span class="BarsLabel" id="lbNlsD" style="color: blue">Депозитний рахунок:</span>
                <input class="BarsTextBoxRO" id="tbNls" title="Депозитний рахунок" style="width: 120px"
                    tabindex="0" readonly="readonly" type="text" />
                <input class="BarsTextBoxRO" id="tbOst_Pl" title="Залишок на депозитному рахунку"
                    style="width: 100px; text-align: right" tabindex="0" readonly="readonly" type="text" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <span class="BarsLabel" id="lbNlsP" style="color: green">Рахунок нарах. %%:</span>
                <input class="BarsTextBoxRO" id="tbNlsN" title="Рахунок нарах. %%" style="width: 120px"
                    tabindex="0" readonly="readonly" type="text" />
                <input class="BarsTextBoxRO" id="tbOstN_Pl" title="Залишок на рахуноку нарах. %%"
                    style="width: 100px; text-align: right" tabindex="0" readonly="readonly" type="text" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnActions" runat="server" Height="40px" Style="padding-top: 5px" BorderStyle="Groove"
                    BorderWidth="2px" HorizontalAlign="Center">
                    <table>
                        <tr>
                            <td>
                                <input id="pb0" type="button" disabled="disabled" class="BarsButton"  style="width: 135px; color: blue" 
                                    onclick="fnRazm()" value="Розміщення" >
                            </td>
                            <td>
                                <input id="pb1" type="button"  disabled="disabled" class="BarsButton" style="width: 135px; color: purple" 
                                    onclick="fnPopol()" value="Поповнення" />
                            </td>
                            <td>
                                <input id="pb3" type="button" disabled="disabled" class="BarsButton" style="width: 135px; color: green" 
                                    onclick="fnNachis()" value="Нарахування %%" />
                            </td>
                            <td>
                                <input id="pb4" type="button" disabled="disabled" class="BarsButton"  style="width: 135px; color: teal" 
                                    onclick="fnViplat()" value="Виплата. нарах. %%" />
                            </td>
                            <td>
                                <input id="pb2" type="button"  disabled="disabled" class="BarsButton" style="width: 135px; color: maroon" 
                                    onclick="fnPogash()" value="Погашення" />
                            </td>
                            <td>
                                <input id="pb5" type="button" disabled="disabled" class="BarsButton" style="width: 135px; color: red" 
                                    onclick="fnStop()" value="Штрафування" title="Дострокове розторгнення договору">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td align="center">
                                <input id="tbDat" type="hidden" /><input id="tbDat_Value" type="hidden" name="tbDat" /><input
                                    id="tbDat_TextBox" title="Дата нарахування процентів" style="width: 110px; text-align: center"
                                    type="text" maxlength="10" tabindex="11" />
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td valign="top" align="center">
                <table>
                    <tr>
                        <td valign="top" style="width: 50%">
                            <div style="height: 320px; overflow: auto; vertical-align: top">
                                <table id="tb1" style="font-size: 8pt; border-left-color: black; border-bottom-color: black;
                                    width: 100%; cursor: hand; border-top-color: black; font-family: Verdana; border-collapse: collapse;
                                    background-color: white; border-right-color: black" bordercolor="black" cellspacing="0"
                                    cellpadding="2" border="1">
                                    <tr style="font-weight: bold; font-size: 8pt; color: white; font-family: Verdana;
                                        background-color: gray" align="center">
                                        <td>
                                            Дата
                                        </td>
                                        <td>
                                            Прихід
                                        </td>
                                        <td>
                                            Видаток
                                        </td>
                                        <td>
                                            Залишок по вкладу
                                        </td>
                                        <td>
                                            % ставка
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                        <td valign="top" width="10">
                        </td>
                        <td style="width: 50%">
                            <div style="height: 320px; overflow: auto; vertical-align: top">
                                <table id="tb2" style="font-size: 8pt; border-left-color: black; border-bottom-color: black;
                                    width: 100%; cursor: hand; border-top-color: black; font-family: Verdana; border-collapse: collapse;
                                    background-color: white; border-right-color: black" bordercolor="black" cellspacing="0"
                                    cellpadding="2" border="1">
                                    <tr style="font-weight: bold; font-size: 8pt; color: white; font-family: Verdana;
                                        background-color: gray" align="center">
                                        <td style="height: 18px">
                                            Дата
                                        </td>
                                        <td style="height: 18px">
                                            Нарах %
                                        </td>
                                        <td style="height: 18px">
                                            Виплата %
                                        </td>
                                        <td style="height: 18px">
                                            Залишок по %
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    </form>
</body>
</html>
