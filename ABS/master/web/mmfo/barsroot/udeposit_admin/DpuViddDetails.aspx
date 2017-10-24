<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DpuViddDetails.aspx.cs" Inherits="DpuViddDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <base target="_self" />
    <title>Прараметри виду депозиту</title>
    
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />

    <style>
        .dpu-vidd {
            font-size:1em;
        }
    </style>

    <script type="text/javascript" src="/barsroot/deposit/js/ck.js"></script>
    
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <script type="text/javascript" src="/barsroot/udeposit_admin/dpuvidddetails.js?v1.1.1"></script>

</head>
<body class="dpu-vidd">
    <form id="frmDpuViddDeails" runat="server">
    <div>
        <div style="text-align:center" class="row header">
            <asp:Label ID="lbViddTitle" runat="server" Text="Прараметри виду депозиту" CssClass="InfoHeader" />
        </div>
        <div id="tabstrip">
            <ul>
                <li class="k-state-active">
                    Основні
                </li>
                <li>
                    Відсотки
                </li>
                <li>
                    Додаткові
                </li>
                <li id="tabRates">
                    Шкала ставок
                </li>
            </ul>
            <div>
                <div>
                    <asp:Panel ID="pnlDescr" runat="server" GroupingText="Опис виду депозиту">
                        <table class="InnerTable" width="100%" cellpadding="3">
                            <tr>
                                <td align="right"  style="width:27%">
                                <asp:Label ID="lbType" runat="server" Text="Тип депозиту: " CssClass="InfoLabel" />
                                </td>
                                <td align="center" style="width:7%">
                                <asp:TextBox ID="tbTypeId" TabIndex="1" runat="server" ClientIDMode="Static"
                                    style="text-align: center" CssClass="InfoText" Width="98%" />
                                </td>
                                <td align="left" colspan="2">
                                    <asp:DropDownList ID="ddlTypes" TabIndex="2" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                        DataTextField="TYPE_NAME" DataValueField="TYPE_ID" Width="98%" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbVidd" runat="server" Text="Вид депозиту: " CssClass="InfoLabel" />
                                </td>
                                <td align="center">
                                    <asp:TextBox ID="tbViddId" TabIndex="3" runat="server" ClientIDMode="Static" CssClass="InfoText"
                                        style="text-align: center" Width="98%" />
                                </td>
                                <td align="center" style="width:7%">
                                    <asp:TextBox ID="tbViddCode" TabIndex="4" MaxLength="4" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                        style="text-align: center" Width="98%" />
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="tbViddName" TabIndex="5" runat="server" CssClass="InfoText" Width="98%" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbCurrency" runat="server" Text="Валюта депозиту: " CssClass="InfoLabel" />
                                </td>
                                <td align="center">
                                    <asp:TextBox ID="tbCurrencyId" TabIndex="6" MaxLength="3" BackColor="Gainsboro" runat="server" 
                                        style="text-align: center" ClientIDMode="Static" Width="98%" CssClass="InfoText" />
                                </td>
                                <td align="center">
                                    <asp:TextBox ID="tbCurrencyCode" TabIndex="7" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                        style="width: 98%; text-align: center" ReadOnly="True" BackColor="Gainsboro" />
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlCurrencies" TabIndex="2" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                        DataTextField="CURRENCY_NAME" DataValueField="CURRENCY_ID" Width="98%" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbPeriod" runat="server" Text="Строковість депозиту: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbPeriodId" TabIndex="9" runat="server" ClientIDMode="Static"
                                        style="text-align: center" CssClass="InfoText" Width="98%" />
                                </td>
                                <td colspan="2">
                                <asp:DropDownList ID="ddlPeriods" TabIndex="2" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="PERIOD_NAME" DataValueField="PERIOD_ID" Width="98%" onclick="getNbsDep(this)">
                                </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbNbsDep" runat="server" Text="Бал. рахунок депозиту: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbNbsDepNum" TabIndex="11" MaxLength="4" runat="server"
                                        style="width:98%; text-align: center" ClientIDMode="Static" CssClass="InfoText" />
                                </td>
                                <td colspan="2">
                                    <asp:DropDownList ID="ddlNbsDepName" TabIndex="12" runat="server" ClientIDMode="Static"
                                        DataTextField="NBS_NAME" DataValueField="NBS_CODE" CssClass="BaseDropDownList" Width="98%" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lbNbsInt" runat="server" Text="Бал. рахунок відсотків: " CssClass="InfoLabel" />
                                </td>
                                <td>
                                    <asp:TextBox ID="tbNbsIntNum" TabIndex="13" MaxLength="4" runat="server"
                                        style="width:98%; text-align: center" ClientIDMode="Static" CssClass="InfoText" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="tbNbsIntName" TabIndex="14" BackColor="Gainsboro" runat="server"
                                        ClientIDMode="Static" Width="98%"  CssClass="InfoText" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="InnerTable" width="100%" cellpadding="1">
                        <tr>
                            <td align="left" style="width: 70%">        
                                <asp:Panel ID="pnlTerm" runat="server" GroupingText="Граничні терміни" HorizontalAlign="Left">
                                    <table class="InnerTable" width="100%" cellpadding="3">
                                        <tr>
                                            <td align="right" style="width:39%;">
                                                <asp:Label ID="lbTermMinMonths" runat="server" Text="Min. к-ть Місяців: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="center" style="width:10%;">
                                                <asp:TextBox ID="tbTermMinMonths" TabIndex="30" MaxLength="2" runat="server" style="text-align: center" 
                                                    ToolTip="Мінімальна к-ть місяців дії договору" ClientIDMode="Static" CssClass="InfoText" Width="98%" />
                                            </td>
                                            <td align="right" style="width:20%;">
                                                <asp:Label ID="lbTermMinDays" runat="server" Text="Днів: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="center" style="width:10%;">
                                                <asp:TextBox ID="tbTermMinDays" TabIndex="30" MaxLength="4" runat="server" style="text-align: center" 
                                                    ToolTip="Мінімальна к-ть днів дії договору" ClientIDMode="Static" CssClass="InfoText" Width="98%" />
                                            </td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:Label ID="lbTermMaxMonths" runat="server" Text="Max. к-ть Місяців: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="center">
                                                <asp:TextBox ID="tbTermMaxMonths" TabIndex="30" MaxLength="2" runat="server" style="text-align: center" 
                                                    ToolTip="Max. к-ть Місяців" ClientIDMode="Static" CssClass="InfoText" Width="98%" />
                                            </td>
                                            <td align="right">
                                                <asp:Label ID="lbTermMaxDays" runat="server" Text="Днів: " CssClass="InfoLabel" />
                                            </td>
                                            <td align="center">
                                                <asp:TextBox ID="tbTermMaxDays" TabIndex="30" MaxLength="4" runat="server" style="text-align: center" 
                                                    ToolTip="Max. к-ть Днів" ClientIDMode="Static" CssClass="InfoText" Width="98%" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                             <td align="left" style="width: 30%; height:100%;">
                                <asp:Panel ID="pnlTermType" runat="server" GroupingText="Тип терміну">
                                    <table class="InnerTable" width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbTermFixed" Text="&nbsp; Фіксований" ClientIDMode="Static"
                                                    runat="server" GroupName="TermTypes" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbTermRange" Text="&nbsp; Діапазон" ClientIDMode="Static"
                                                    runat="server" GroupName="TermTypes" />
                                             </td>
                                         </tr>
                                     </table>
                                </asp:Panel>
                                <input id="TermType" type="hidden" runat="server" value="1" />
                            </td>
                        </tr>
                    </table>
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="left" style="width: 70%">
                                <asp:Panel ID="pnlAmounts" runat="server" GroupingText="Граничні суми" HorizontalAlign="Left">
                                     <table class="InnerTable" width="100%" cellpadding="3">
                                         <tr>
                                             <td align="right" style="width:39%">
                                                 <asp:Label ID="lbMinAmount" runat="server" Text="Min. сума депозиту: " CssClass="InfoLabel" />
                                             </td>
                                             <td align="center" style="width:26%;">
                                                 <input id="tbMinAmount" tabindex="30" style="width: 98%;text-align: right;" ClientIDMode="Static"
                                                    runat="server" class="InfoText" type="text"/>
                                             </td>
                                             <td></td>
                                         </tr>
                                         <tr>
                                             <td align="right">
                                                 <asp:Label ID="lbMaxAmount" runat="server" Text="Max. сума депозиту: " CssClass="InfoLabel" />
                                             </td>
                                             <td align="center">
                                                 <input id="tbMaxAmount" tabindex="30" style="width: 98%;text-align: right;" ClientIDMode="Static"
                                                    runat="server" class="InfoText" type="text"/>
                                             </td>
                                             <td></td>
                                         </tr>
                                         <tr>
                                             <td align="right">
                                                <asp:Label ID="lbMinAmntReplenishment" runat="server" Text="Min.сума поповнення: " CssClass="InfoLabel" />
                                             </td>
                                             <td align="center">
                                                <input id="tbMinAmntReplenishment" tabindex="30" style="width: 98%;text-align: right;" ClientIDMode="Static"
                                                    runat="server" class="InfoText" type="text"/>
                                             </td>
                                             <td align="left">
                                                 <asp:CheckBox ID="cbReplenishable" TabIndex="5"
                                                     runat="server" Text="&nbsp; Поповнення" CssClass="BaseCheckBox">
                                                 </asp:CheckBox>
                                             </td>
                                         </tr>
                                     </table>
                                </asp:Panel>
                            </td>
                            <td align="left"  style="width: 30%; height:100%;" valign="top">
                                <asp:Panel ID="pnlLine" runat="server" GroupingText="Лінія" Height="100%">
                                    <table class="InnerTable" width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbStandard" Text="&nbsp; Стандарт" ClientIDMode="Static"
                                                    runat="server" GroupName="LineType" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbLine" Text="&nbsp; Деп. лінія" ClientIDMode="Static"
                                                    runat="server" GroupName="LineType" Enabled="False"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButton ID="rbLine8" Text="&nbsp; Деп. лінія на 8 класі"
                                                    runat="server" GroupName="LineType" />
                                            </td>
                                         </tr>
                                     </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div>
                <asp:Panel ID="pnlAccrualInterest" runat="server" GroupingText="Нарахування відсотків">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right" style="width:35%">
                                <asp:Label ID="lbBaseY" runat="server" Text="База нарахування відсотків: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:7%;">
                                <asp:TextBox ID="tbBaseYId" TabIndex="201" runat="server" ClientIDMode="Static"
                                    style="text-align: center" CssClass="InfoText" Width="98%" />
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlBaseY" TabIndex="202" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="BASE_NAME" DataValueField="BASE_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbCalcIntFreq" runat="server" Text="Періодичність нарахування відсотків: " CssClass="InfoLabel" />
                            </td>
                            <td align="center">
                                <asp:TextBox ID="tbClcIntFrqId" TabIndex="203" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" Width="98%" />
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlClcIntFrqs" TabIndex="204" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="FREQ_NAME" DataValueField="FREQ_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbMethod" runat="server" Text="Метод нарахування відсотків: " CssClass="InfoLabel" />
                            </td>
                            <td align="center">
                                <asp:TextBox ID="tbMethodId" TabIndex="205" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" Width="98%" />
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlMethods" TabIndex="206" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="METHOD_NAME" DataValueField="METHOD_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbBaseRate" runat="server" Text="Базова відсоткова ставка: " CssClass="InfoLabel" />
                            </td>
                            <td align="center">
                                <asp:TextBox ID="tbBaseRateId" TabIndex="207" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" Width="98%" />
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlBaseRates" TabIndex="208" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="BRATE_NAME" DataValueField="BRATE_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbOperation" runat="server" Text="Код операції нарахування %: " CssClass="InfoLabel" />
                            </td>
                            <td align="center">
                                <asp:TextBox ID="tbOperationCode" TabIndex="209" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" MaxLength="3" Width="98%" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="tbOperationName" TabIndex="210" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    ReadOnly="True" Width="98%" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlPayoutInterest" runat="server" GroupingText="Виплата відсотків">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right" style="width:35%;">
                            </td>
                            <td align="left" colspan="2">
                                <asp:CheckBox ID="cbComproc" TabIndex="211" Width="99%" runat="server" 
                                    Text="&nbsp; Капіталізація відсотків" ClientIDMode="Static" CssClass="BaseCheckBox">
                                </asp:CheckBox>
                                <input id="Comproc" type="hidden" runat="server" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbFrequency" runat="server" Text="Періодичність сплати відсотків: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:7%;">
                                <asp:TextBox ID="tbFrequencyId" TabIndex="212" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" Width="98%" ></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlFrequencies" TabIndex="213" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="FREQ_NAME" DataValueField="FREQ_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbFine" runat="server" Text="Пеня (%): " CssClass="InfoLabel" />
                            </td>
                            <td align="left" colspan="2">
                                <input id="tbFine" tabindex="214" style="text-align:center; width:20%;" ClientIDMode="Static"
                                    runat="server" class="InfoText" type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td align="left" colspan="2">
                                <asp:CheckBox ID="cbIrrevocable" TabIndex="215" Width="99%"
                                    runat="server" Text="&nbsp; Безвідкличний" ClientIDMode="Static" CssClass="BaseCheckBox">
                                    </asp:CheckBox>
                                <input id="Irrevocable" type="hidden" runat="server" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbPenalty" runat="server" Text="Дострокове вилучення: " CssClass="InfoLabel" />
                            </td>
                            <td align="center">
                                <asp:TextBox ID="tbPenaltyId" TabIndex="216" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" MaxLength="6" Width="98%"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlPenalties" TabIndex="217" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="STOP_NAME" DataValueField="STOP_ID" Width="98%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
            <div>
                <asp:Panel ID="pnlProlongation" runat="server" GroupingText="Параметри пролонгації">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right" style="width:35%">
                            </td>
                            <td colspan="2">
                                <asp:CheckBox ID="cbProlongation" TabIndex="301" ClientIDMode="Static"
                                    runat="server" Text="&nbsp; Автопролонгація" CssClass="BaseCheckBox">
                                </asp:CheckBox>
                                <input id="Prolongation" type="hidden" runat="server" value="0" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="lbExnMethod" runat="server" Text="Метод переоформлення: " CssClass="InfoLabel" />
                            </td>
                            <td align="center" style="width:7%;">
                                <asp:TextBox ID="tbExnMethodId" TabIndex="302" runat="server" ClientIDMode="Static" CssClass="InfoText" 
                                    style="text-align: center" MaxLength="6" Width="98%" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlExnMethods" TabIndex="303" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="METHOD_NAME" DataValueField="METHOD_ID" Width="99%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3"></td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="pnlTemplate" runat="server" GroupingText="Шаблон договору">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td align="right" style="width:35%">
                                <asp:TextBox ID="tbTemplateId" TabIndex="304" Width="98%" ClientIDMode="Static" CssClass="InfoText" runat="server"
                                    style="text-align: center" ToolTip="Ідентифікатор шаблон для друку договору" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTemplates" TabIndex="305" runat="server" ClientIDMode="Static" CssClass="BaseDropDownList"
                                    DataTextField="TEMPLATE_NAME" DataValueField="TEMPLATE_ID" Width="99%" >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"></td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="Panel2" runat="server" GroupingText="Коментар">
                    <table class="InnerTable" width="100%" cellpadding="3">
                        <tr>
                            <td>
                                <asp:TextBox ID="tbComment" TabIndex="307" runat="server" ClientIDMode="Static"  CssClass="InfoText"
                                    MaxLength="200" ToolTip="Коментар" TextMode="MultiLine" Width="99%" Height="100%" >
                                </asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                    </table>
                </asp:Panel>  
            </div>
            <div>
                <div id="gridRates">
                </div>
                <%--<iframe id="frameRates" style="width:100%;height:400px"></iframe>--%>
            </div>
        </div>
         <%--position: absolute;--%>
        <table class="InnerTable" cellpadding="0" style="width:100%; bottom: 0px;">
            <tr>
                <td></td>
            </tr>
            <tr>
                <td align="right" style="width:45%">
                    <asp:Button ID="btnSubmit" runat="server" Text="Зберегти"  CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Brown" Font-Bold="true" ClientIDMode="Static"
                        CausesValidation="true" OnClientClick="return validateControls();"
                        OnClick="btnSubmit_Click" />
                </td>
                <td align="center" style="width:10%"></td>
                <td align="left" style="width:45%">
                    <asp:Button ID="btnExit" runat="server" Text="Вийти" CssClass="AcceptButton"
                        Width="200px" Height="30px" ForeColor="Red" Font-Bold="true" ClientIDMode="Static"
                        CausesValidation="false" OnClientClick="closeWindow(); return false;" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <input id="HasAgrm" type="hidden" runat="server" value="0"/>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
