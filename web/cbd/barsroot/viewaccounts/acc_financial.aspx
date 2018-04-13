<%@ Page Language="c#" CodeFile="acc_financial.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Acc_Financial" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script language="javascript" src="/Common/Script/Localization.js" type="text/javascript"></script>
    <script language="JavaScript" src="/Common/WebEdit/NumericEdit.js" type="text/javascript"></script>
    <script language="JavaScript" src="Scripts/Common.js" type="text/javascript"></script>
    <script language="JavaScript" src="Scripts/Financial.js?v1.4" type="text/javascript"></script>
</head>
<body scroll="no">
    <table style="width: 100%">
        <tr>
            <td height="1">
                <div id="Panel" class="BarsPanel">
                    <table id="T3" cellspacing="1" cellpadding="1" style="width: 100%" border="0">
                        <tr>
                            <td align="right">
                                <span runat="server" id="lbLimit" meta:resourcekey="lbLimit" class="BarsLabel">Лимит
                                    овердрафта:</span>
                            </td>
                            <td colspan="2">
                                <input id="tbLimitOs" class="BarsTBI_RO2" style="width: 344px" onchange="SaveLim(this)"
                                    onblur="fnValidate(this)" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <span runat="server" id="Span1" class="BarsLabel">Мінімальний залишок:</span>
                            </td>
                            <td colspan="2">
                                <input id="tbLimitMinus" class="BarsTBI_RO2" style="width: 344px" onchange="SaveLim(this)"
                                    onblur="fnValidate(this)" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <span runat="server" id="lbMaxLim" meta:resourcekey="lbMaxLim" class="BarsLabel">Max
                                    остаток на счете:</span>
                            </td>
                            <td style="width: 40px">
                                <input id="tbMaxLimSign" class="BarsTBI_RO" style="width: 40px" readonly="readonly" />
                            </td>
                            <td>
                                <input id="tbMaxLimOs" class="BarsTBI_RO2" style="width: 300px" onchange="SaveOstx(this)"
                                    onblur="fnValidate(this)" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 258px">
                                <span runat="server" id="lbDapp" meta:resourcekey="lbDapp" class="BarsLabel">Дата последней
                                    операции:</span>
                            </td>
                            <td colspan="2">
                                <input id="tbDapp" class="BarsTBI_RO3" style="width: 140px" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 258px" align="right">
                                <span runat="server" id="lbVidBlkD" meta:resourcekey="lbVidBlkD" class="BarsLabel">Блокировка
                                    по Дебету:</span>
                            </td>
                            <td colspan="2">
                                <select id="ddVidBlkD" onclick="d_dlg(this)" style="width: 300px">
                                    <option value="" selected></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <span runat="server" id="lbVidBlkK" meta:resourcekey="lbVidBlkK" class="BarsLabel">Блокировка
                                    по Кредиту:</span>
                            </td>
                            <td colspan="2">
                                <select id="ddVidBlkK" onclick="d_dlg(this)" style="width: 300px">
                                    <option value="" selected></option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="Panel1" class="BarsPanel">
                    <p>
                        <span id="lbNominal" class="BarsLabel"></span>
                        <table id="T1" cellspacing="1" cellpadding="1" style="width: 100%" border="0">
                            <tr>
                                <td align="right" style="width: 258px">
                                    <span runat="server" id="lbDos" meta:resourcekey="lbOb" class="BarsLabel">Обороты:</span>
                                </td>
                                <td align="center">
                                    <span runat="server" id="lbDDos" meta:resourcekey="lbD" class="BarsLabel">Д</span>
                                </td>
                                <td>
                                    <input id="tbDos" class="BarsTBI_RO1" style="width: 300px" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="center">
                                    <span runat="server" id="lbKos" meta:resourcekey="lbK" class="BarsLabel">К</span>
                                </td>
                                <td>
                                    <input id="tbKos" class="BarsTBI_RO1" style="width: 300px" readonly>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="height: 25px">
                                    <span runat="server" id="lbOstc" meta:resourcekey="lbOstq" class="BarsLabel">Остаток:</span>
                                </td>
                                <td align="center" style="width: 40px; height: 25px;">
                                    <input id="tbSignIv" class="BarsTBI_RO" style="width: 40px" readonly>
                                </td>
                                <td style="height: 25px">
                                    <input id="tbOstc" class="BarsTBI_RO1" style="width: 300px" readonly>
                                </td>
                            </tr>
                        </table>
                    </p>
                </div>
                <div id="PanelEqv" class="BarsPanel">
                    <span id="lbEqv" class="BarsLabel"></span>
                    <table id="T2" cellspacing="1" cellpadding="1" style="width: 100%" border="0">
                        <tr>
                            <td align="right" style="width: 258px">
                                <span runat="server" id="lbOb" meta:resourcekey="lbOb" class="BarsLabel">Обороты:</span>
                            </td>
                            <td align="center">
                                <span runat="server" id="lbD" meta:resourcekey="lbD" class="BarsLabel">Д</span>
                            </td>
                            <td>
                                <input id="tbDosq" class="BarsTBI_RO1" style="width: 300px" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td align="center">
                                <span runat="server" id="lbK" meta:resourcekey="lbK" class="BarsLabel">К</span>
                            </td>
                            <td>
                                <input id="tbKosq" class="BarsTBI_RO1" style="width: 300px" readonly>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <span runat="server" id="lbOstq" meta:resourcekey="lbOstq" class="BarsLabel">Остаток:</span>
                            </td>
                            <td style="width: 40px">
                                <input id="tbSignIvQ" class="BarsTBI_RO" style="width: 40px" readonly>
                            </td>
                            <td>
                                <input id="tbOstq" class="BarsTBI_RO1" style="width: 300px" readonly>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
    <script>        fnLoadFinancial();</script>
</body>
</html>
