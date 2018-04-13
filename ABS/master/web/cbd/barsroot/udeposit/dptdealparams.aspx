<%@ Page Language="c#" Inherits="barsroot.udeposit.DptDealParams" EnableViewState="False" CodeFile="dptdealparams.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Параметри депозитного договору</title>
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
    <script type="text/javascript" language="jscript" src="/Common/Script/cross.js"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/DptDealParams.js?v1.7.73"></script>
    <script type="text/javascript" language="javascript" src="/Common/WebEdit/RadInput.js"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.1"></script>
    <style type="text/css">
        .auto-style1 {
            height: 125px;
        }
    </style>
</head>
<body onkeydown="fnHotKey()">
    <form id="DptDealParamsForm" method="post" runat="server">
    <table width="100%" align="left" border="0" id="mainTable" style="visibility: visible">
        <tr>
            <td>
                <div style="background-color: lightgrey">
                    <table id="T" cellspacing="0" cellpadding="0" border="2">
                        <tr>
                            <td>
                                <button id="btSave" title="Зберегти" type="button" tabindex="1000" onclick="fnSave()"
                                    style="border: none; vertical-align: top">
                                    <img class="outset" src="/Common/Images/SAVE.gif" alt=""/>
                                </button>
                                &nbsp;
                                <img class="outset" id="btRefresh" title="Перечитати" alt=""
                                    onclick="fnClear()" src="/Common/Images/REFRESH.gif" />
                            </td>
                            <td>
                                &nbsp;
                                <img class="outset" id="btPassport" title="Паспорт клієнта" alt=""
                                    onclick="fnShowPass()" src="/Common/Images/CUSTCORP.gif" />
                                <img class="outset" id="btSos" title="Поточний стан договору" alt=""
                                    onclick="fnShowState()" height="16" src="/Common/Images/DOCVIEW.gif" />
                            </td>
                            <td>
                                &nbsp;
                                <img class="outset" id="btAccounts" title="Таблична форма рахунків депозиту" onclick="fnTabForm()"
                                    src="/Common/Images/DETAILS.gif" height="16" alt="Рахунки" />
                                <img class="outset" id="btPrint" title="Друк договору" onclick="fnPrint(false)" 
                                    src="/Common/Images/PRINT.gif" width="16" alt="Друк" />
                                <img class="outset" id="imgWord" title="Друк договору в Word" onclick="fnPrint(true)"
                                    src="/Common/Images/word_2005.gif" width="16" alt="Word" />
                                <img class="outset" id="btChilds" title="Відкрити дод. угоду" onclick="fnDopSogl()"
                                    src="/Common/Images/CHILDS.gif" width="16" alt="Відкрити" />
                                <img class="outset" id="btDubl" title="Пролонгація договору" onclick="fnPrepareProlongation()" 
                                    src="/Common/Images/prolong.bmp" width="16" height="16" alt="Пролонгація"/>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                                <img class="outset" id="btExit" title="Закрити" onclick="fnClose()"
                                    src="/Common/Images/DISCARD.gif" width="16" height="16" alt="Закрити" />
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <table cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Label ID="lbTitleDeal" runat="server" Font-Bold="True" Font-Size="12pt" Font-Names="Verdana"
                                ForeColor="Navy">Депозитний договір</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="white-space: nowrap; width: 10%">
                            <span class="BarsLabel" id="lbCntDubl" style="color: Navy">К-ть прол.:</span>
                            <input id="tbCntDubl" type="text" style="color: Navy; width: 40px; text-align:right"
                            readonly="readonly" class="BarsTextBoxRO"/>
                        </td>
                        <td align="right" style="white-space: nowrap; width: 10%">
                            <span class="BarsLabel" style="color: Navy">№ рахунку:</span>
                            <input id="tbNls" type="text" style="color: Navy; font-weight: bold" 
                                readonly="readonly" class="BarsTextBoxRO"  />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <table>
                    <tr>
                        <td valign="top">
                            <asp:Panel ID="pnClient" runat="server" GroupingText="Клієнт">
                                <table>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbRnk">Рег.№:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBoxRO" id="tbRnk" title="Рег.№ клієнта'" style="width: 60px"
                                                readonly="readonly" type="text" size="2" onchange="fnGetCustomer()" />
                                        </td>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbOkpo">ОКПО:</span>
                                            <input class="BarsTextBoxRO" id="tbOkpo" title="Код ОКПО клиента" readonly="readonly" type="text" />
                                        </td>
                                        <td rowspan="2">
                                            <button style="height: 50px; width: 100%" id="btClient" onclick="fnClient()" title="Пошук клієнта ">
                                                <img alt="Пошук клієнта" id="btClientImg" src="/Common/Images/SEARCH.gif" />
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 69px" align="right">
                                            <span class="BarsLabel" id="lbNms">Клієнт:</span>
                                        </td>
                                        <td colspan="2">
                                            <input class="BarsTextBoxRO" id="tbNmk" title="Найменування клієнта" style="width: 362px"
                                                readonly="readonly" type="text" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 70px" align="right">
                                            <span class="BarsLabel" id="lbAdres">Адреса:</span>
                                        </td>
                                        <td colspan="2" nowrap="nowrap">
                                            <input class="BarsTextBoxRO" id="tbAdres" title="Адреса клієнта" style="width: 320px"
                                                readonly="readonly" type="text" name="Text7" />
                                            <span class="BarsLabel" id="Span1" style="width: 40px">K013:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBoxRO" id="tbK013" title="Параметр K013" style="width: 30px;
                                                text-align: center" readonly="readonly" type="text" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td valign="top">
                            <asp:Panel ID="pnDealType" runat="server" GroupingText="Вид договору">
                                <table>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbProduct">Продукт:</span>
                                        </td>
                                        <td colspan="2">
                                            <asp:DropDownList ID="ddProduct" DataTextField="TYPE_NAME" DataValueField="TYPE_ID"
                                                runat="server" Width="354px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <span class="BarsLabel" id="lbVal">Валюта:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBoxRO" id="tbIso" title="Валюта договора" style="width: 50px; text-align: center"
                                                readonly="readonly" type="text" size="1" name="tbIso"/>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddKv" DataTextField="NAME" DataValueField="KV" runat="server" Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbVidDog">Вид договору:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBoxRO" id="tbVidD" title="Код виду договору" style="width: 50px;
                                                text-align: center" readonly="readonly" type="text" size="1" name="tbVidD"/>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddVidD" onclick="getFilteredVidd(this)" runat="server" Width="300px">
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td style="vertical-align: top">
                            <asp:Panel ID="pnParams" runat="server" GroupingText="Параметри">
                                <table>
                                    <tr>
                                        <td style="white-space: nowrap; text-align: right">
                                            <span class="BarsLabel" id="lbNDog">№ договору:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbND" title="№ договору" tabindex="1" type="text"
                                                onchange="fnCheckNd()" style="width: 213px; text-align:center" name="tbND" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap; text-align: right">
                                            <span class="BarsLabel" id="lbSum">Сума:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbSum" tabindex="2" onchange="SetProcs()" title="Сума договору"
                                                style="text-align: right; width: 213px" type="text" name="tbSum" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" style="text-align: right">
                                            <span class="BarsLabel" id="lbMinSum">Незнижувальний залишок:</span>
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbMinSum" title="Незнижуваний залишок" style="width: 213px;
                                                text-align: right" type="text" tabindex="3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap; text-align: right">
                                            <span class="BarsLabel" id="Span3">Періодичність виплати %%:</span>
                                        </td>
                                        <td style="white-space: nowrap" align="left">
                                            <input id="tbFreqV" type="text" title="Код періодичності виплати %%" name="tbFreqV" 
                                                style="width: 35px; text-align: center" readonly="readonly" class="BarsTextBoxRO" />
                                            <asp:DropDownList ID="ddFreqV" onclick="cmb_dlg(this,document.all.tbFreqV)" runat="server"
                                                Width="180px">
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="white-space: nowrap; text-align: right">
                                            <span class="BarsLabel" id="Span2">Штраф при достр. розторг.:</span>
                                        </td>
                                        <td>
                                            <input id="tbStop" type="text" title="Код штрафу за дострокове розсторгнення договору"
                                                style="width: 35px; text-align: center" readonly="readonly" class="BarsTextBoxRO"  />
                                            <asp:DropDownList ID="ddStop" runat="server"
                                                Width="180px">
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td style="vertical-align: top">
                            <asp:Panel ID="pnDates" runat="server" GroupingText="Дати">
                                <table>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbDatZ" style="color: green">Оформлення:</span>
                                        </td>
                                        <td>
                                            <input id="tbDatZ" type="hidden" /><input id="tbDatZ_Value" type="hidden" name="tbDatZ" /><input
                                                id="tbDatZ_TextBox" title="Дата заключення договору" style="width: 110px; text-align: center"
                                                type="text" maxlength="10" tabindex="9" class="BarsTextBox" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbDatN" style="color: purple">Початку:</span>
                                        </td>
                                        <td>
                                            <input id="tbDatN" type="hidden" /><input id="tbDatN_Value" type="hidden" name="tbDatN" /><input
                                                id="tbDatN_TextBox" title="Дата початку договору" style="width: 110px; text-align: center"
                                                type="text" maxlength="10" tabindex="10" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbDatO" style="color: blue">Завершення:</span>
                                        </td>
                                        <td>
                                            <input id="tbDatO" type="hidden" /><input id="tbDatO_Value" type="hidden" name="tbDatO" /><input
                                                id="tbDatO_TextBox" title="Дата завершення договору" style="width: 110px; text-align: center"
                                                type="text" maxlength="10" tabindex="11" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbDatV" style="color: red">Повернення:</span>
                                        </td>
                                        <td>
                                            <input id="tbDatV" type="hidden" /><input id="tbDatV_Value" type="hidden" name="tbDatV" /><input
                                                id="tbDatV_TextBox" title="Дата повернення" style="width: 110px; text-align: center"
                                                type="text" maxlength="10" tabindex="12" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" align="right">
                                            <span class="BarsLabel" id="lbKtDay" style="color: Olive">К-cть днів:</span>
                                        </td>
                                        <td>
                                            <input id="tbKtDay" title="Кількість днів" style="width: 110px; text-align: center"
                                                type="text" maxlength="10" readonly="readonly" class="BarsTextBoxRO" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td style="vertical-align: top">
                            <asp:Panel ID="pnAcrRate" runat="server" GroupingText="%% ставка">
                                <table>
                                    <tr>
                                        <td colspan="3">
                                            <input id="cbCompProc" type="checkbox" onclick="fnCompProc()" />
                                            <label class="BarsLabel" for="cbCompProc">капіталізація відсотків</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <input id="cbRatePerson" checked="checked" onclick="fnRatePerson(this)" type="checkbox" /><label
                                                for="cbRatePerson">індивідуальна</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img id="btCalcRate" title="Розрахувати індивідуальну %% ставку" onclick="SetProcs()"
                                                src="/Common/Images/A_PROC.gif" class="outset" align="top" alt="Розрахувати ставку" />
                                        </td>
                                        <td style="white-space: nowrap">
                                            <input class="BarsTextBox" id="tbIr" onblur="if (checkNumber(this)) CheckRate();" title="Індивидуальна % ставка"
                                                style="width: 60px; text-align: right" type="text" name="tbIr" tabindex="20" />
                                        </td>
                                        <td align="left">
                                            <input id="tbBrDat" type="hidden" /><input id="tbBrDat_Value" type="hidden" name="tbBrDat" /><input
                                                id="tbBrDat_TextBox" class="BarsTextBox" title="Дата установки ставки" style="width: 100px;
                                                text-align: center" type="text" maxlength="10" tabindex="21" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input id="cbRateBase" onclick="fnRateBase(this)" type="checkbox" />
                                            <label for="cbRateBase">базова</label>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddOp" runat="server" Enabled="False" CssClass="BarsTextBoxRO" 
                                                Width="130px">
                                                <asp:ListItem Value="0" Text="" />
                                                <asp:ListItem Value="1" Text="+" />
                                                <asp:ListItem Value="2" Text="-" />
                                                <asp:ListItem Value="3" Text="*" />
                                                <asp:ListItem Value="4" Text="/" />
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddBaseRates" runat="server" Enabled="False" CssClass="BarsTextBoxRO" 
                                                onclick="cmb_dlg(this)" Width="220px" >
                                                <asp:ListItem></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnPayProc" runat="server" GroupingText="Виплата процентів">
                                <table>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span4">МФО:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span10">Назва банку:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span5">Рахунок:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span11">ЄДРПОУ:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span6">Отримувач:</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input class="BarsTextBox" id="tbMfoP" title="МФО для переказу %%" style="width: 50px;
                                                text-align: center" type="text" maxlength="6" onchange="fnGetMfo(this)" tabindex="30" />
                                        </td>
                                        <td>
                                            <input class="BarsTextBoxRO" id="tbNbP" readonly="readonly" title="Банк для перерахування %%"
                                                style="width: 240px" type="text" />
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbNlsP" title="Рахунок для перерахування %%" maxlength="15"
                                                style="width: 160px" type="text" onchange="fnGetNls(this)" tabindex="31" />
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbOkpoP" title="Код ЭДРПОУ" maxlength="10" style="width: 90px"
                                                type="text" tabindex="31" />
                                        </td>
                                        <td>
                                            <input class="BarsTextBox" id="tbNmsP" title="Отримувач %%" style="width: 350px"
                                                type="text" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnPayDep" runat="server" GroupingText="Повернення депозиту">
                                <table>
                                    <tr>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span7">МФО:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span12">Назва банку:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span8">Рахунок:</span>
                                        </td>
                                        <td style="white-space: nowrap">
                                            <span class="BarsLabel" id="Span9">Отримувач:</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input class="BarsTextBox" id="tbMfoD" title="МФО для перерахування депозиту" style="width: 50px;
                                                text-align: center;" type="text" maxlength="6" onchange="fnGetMfo(this)" tabindex="32" />
                                        </td>
                                        <td>
                                            <input id="tbNbD" class="BarsTextBoxRO" readonly="readonly" style="width: 240px" 
                                                title="Банк для перерахування депозиту" type="text" />
                                        </td>
                                        <td>
                                            <input id="tbNlsD" class="BarsTextBox" maxlength="15" onchange="fnGetNls(this)" style="width: 160px"
                                                tabindex="33" title="Рахунок для перерахування депозиту" type="text" />
                                        </td>
                                        <td>
                                            <input id="tbNmsD" class="BarsTextBox" name="tbNmsD" style="width: 390px" title="Отримувач депозиту"
                                                type="text" />
                                        </td>
                                        <td>
                                            <button id="btClAcc" onclick="fnClientAccounst()" style="width: 40px" title="Поточні рахунки клієнта">
                                                <img alt="Поточні рахунки клієнта" id="Img1" src="/Common/Images/BROWSE.gif" onclick="fnClientAccounst()" />
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnComments" runat="server" GroupingText="Коментар">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="tbComments" runat="server" Width="900px" ToolTip="Коментар" Rows="2"
                                                TextMode="MultiLine" BackColor="Info" TabIndex="100" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
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
