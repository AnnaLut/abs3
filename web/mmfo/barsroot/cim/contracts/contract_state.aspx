<%@ Page Title="Перегляд стану контракту" Language="C#" MasterPageFile="~/cim/default.master"
    AutoEventWireup="true" CodeFile="contract_state.aspx.cs" Inherits="cim_contracts_contract_state" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsPayFlag" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_payflag where id in (2,3,4,5)">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditMethod" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_credit_method">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsPaymentPeriod" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_period">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditBase" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_credit_base">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsConsider" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_consider">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditAdaptive" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_credit_adaptive order by 1">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsBorgReason" ProviderName="barsroot.core"
        SelectCommand="select id,name from cim_borg_reason order by 1">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsConclOrgan" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_conclusion_org order by 1">
    </bars:BarsSqlDataSourceEx>
    <asp:ObjectDataSource ID="odsVCimCredgraphPayment" runat="server" SelectMethod="SelectPayments"
        TypeName="cim.VCimCredgraphPayment" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsVCimCredgraphPeriod" runat="server" SelectMethod="SelectPeriods"
        TypeName="cim.VCimCredgraphPeriod" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsVCimInBoundPayments" runat="server" SelectMethod="SelectInBoundPayments"
        TypeName="cim.VCimBoundPayments" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
            <asp:Parameter Type="Decimal" Name="CONTR_TYPE" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsVCimOutBoundPayments" runat="server" SelectMethod="SelectOutBoundPayments"
        TypeName="cim.VCimBoundPayments" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
            <asp:Parameter Type="Decimal" Name="CONTR_TYPE" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsVCimInBoundAddPayments" runat="server" SelectMethod="SelectInBoundAddPayments"
        TypeName="cim.VCimBoundPayments" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="odsVCimOutBoundAddPayments" runat="server" SelectMethod="SelectOutBoundAddPayments"
        TypeName="cim.VCimBoundPayments" SortParameterName="SortExpression" EnablePaging="False">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="contr_id" Type="Decimal" Name="CONTR_ID" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <fieldset style="margin-top: -10px">
        <legend>Параметри контракту</legend>
        <div>
            <table class="headTab">
                <tr>
                    <!-- ROW1 -->
                    <td class="ctrl-td-lb">Тип контракту:</td>
                    <td class='ctrl-td-val'>
                        <asp:Label runat="server" ID="lbContrType" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb">Валюта контракту:</td>
                    <td class='ctrl-td-val ctrl-center' style="text-align: center">
                        <asp:Label runat="server" ID="lbKv" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- trade -->
                    <td class="ctrl-td-lb" runat="server" id="tdTrade11">Сума платежів:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdTrade12">
                        <asp:Label runat="server" ID="lbTradeSPL" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /trade -->

                    <!-- credit -->
                    <td class="ctrl-td-lb" runat="server" id="tdCredit11">Заг. сума надходжень:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit12">
                        <asp:Label runat="server" ID="lbTotalRevenue" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb" runat="server" id="tdCredit61">Сплата тіла кредиту :</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit62">
                        <asp:Label runat="server" ID="lbCreditTotalOutlay" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /credit -->

                    <!-- others -->
                    <td class="ctrl-td-lb" runat="server" id="tdOthers01">Сума додаткових вхідних:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdOthers02">
                        <asp:Label runat="server" ID="lbOtherSumAddIn" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /others -->
                    <td class="ctrl-td-lb">Назва клієнта:</td>
                    <td class='ctrl-td-val' colspan="3">
                        <asp:Label runat="server" ID="lbClientNameK" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <!-- ROW2 -->
                    <td class="ctrl-td-lb">№ контракту:</td>
                    <td>
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td class='ctrl-td-val ctrl-left'>
                                    <asp:Label runat="server" ID="lbConractNum" Font-Bold="true"></asp:Label></td>
                                <td class='ctrl-td-val ctrl-left'>&nbsp;<asp:Label runat="server" ID="lbConractSubNum" ToolTip="Додатковий номер" Font-Bold="true"></asp:Label></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                    <td class="ctrl-td-lb">Сума контракту:</td>
                    <td class='ctrl-td-val ctrl-right'>
                        <asp:Label runat="server" ID="lbSum" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- trade -->
                    <td class="ctrl-td-lb" runat="server" id="tdTrade21">Заборг. по платежах:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdTrade22">
                        <asp:Label runat="server" ID="lbTradeZVMD" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /trade -->

                    <!-- credit -->
                    <td class="ctrl-td-lb" runat="server" id="tdCredit71">Майбутнє надходження:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit72">
                        <asp:Label runat="server" ID="lbFutureRevenue" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb" runat="server" id="tdCredit41">Сплата %:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit42">
                        <asp:Label runat="server" ID="lbCreditInterestPaid" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /credit -->

                    <!-- others -->
                    <td class="ctrl-td-lb" runat="server" id="tdOthers03">Сума додаткових вихідних:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdOthers04">
                        <asp:Label runat="server" ID="lbOtherSumAddOut" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /others -->

                    <td class="ctrl-td-lb">Код ЄДРПОУ:</td>
                    <td class='ctrl-td-val'>
                        <asp:Label runat="server" ID="lbClientOkpo" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <!-- ROW3 -->
                    <td class="ctrl-td-lb">Дата початку:</td>
                    <td class='ctrl-td-val ctrl-center'>
                        <asp:Label runat="server" ID="lbDateOpen" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb">Дата закінчення:</td>
                    <td class='ctrl-td-val ctrl-center'>
                        <asp:Label runat="server" ID="lbDateClose" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- trade -->
                    <td class="ctrl-td-lb" id="tdTrade31" runat="server">Сума після встан. строку:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdTrade32">
                        <asp:Label runat="server" ID="lbTradeSAfter" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /trade -->

                    <!-- credit -->
                    <td class="ctrl-td-lb" runat="server" id="tdCredit51">Заборг. по тілу кредиту:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit52">
                        <asp:Label runat="server" ID="lbCreditDueBody" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb" runat="server" id="tdCredit31">Сплата дод. платежів:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit32">
                        <asp:Label runat="server" ID="lbAddPaymentsSum" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /credit -->

                    <!-- others -->
                    <td class="ctrl-td-lb" runat="server" id="tdOthers05">Сума вхідних (осн.):</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdOthers06">
                        <asp:Label runat="server" ID="lbOtherSumIn" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /others -->

                    <td class="ctrl-td-lb">Код РНК:</td>
                    <td class='ctrl-td-val ctrl-right'>
                        <asp:Label runat="server" ID="lbClientRnk" Font-Bold="true"></asp:Label>
                    </td>
                    <td></td>
                    <td class="ctrl-td-lb" style="text-align:left">Електронний архів:
                        <img alt="Електронний архів" id="imgEa" src="/Common/Images/default/16/e.png" />
                    </td>
                </tr>
                <tr>
                    <!-- ROW4 -->
                    <td class="ctrl-td-lb">Статус контракту:</td>
                    <td class='ctrl-td-val'>
                        <asp:Label runat="server" ID="lbStatus" Font-Bold="true"></asp:Label>
                    </td>

                    <!-- trade -->
                    <td class="ctrl-td-lb" runat="server" id="tdTrade41">Сума МД:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdTrade42">
                        <asp:Label runat="server" ID="lbTradeSVMD" Font-Bold="true"></asp:Label>
                    </td>
                    <td class="ctrl-td-lb" runat="server" id="tdTrade43">Заборг. по МД:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdTrade44">
                        <asp:Label runat="server" ID="lbTradeZPL" Font-Bold="true"></asp:Label>
                    </td>
                    <td runat="server" id="tdTrade45"></td>
                    <!-- /trade -->

                    <!-- credit -->
                    <td class="ctrl-td-lb" runat="server" id="tdCredit81">Нарах. % (за ставкою НБУ):</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit82">
                        <asp:Label runat="server" ID="lbCalcRateNbu" Font-Bold="true"></asp:Label>
                    </td>

                    <td class="ctrl-td-lb" runat="server" id="tdCredit21">Нараховані %:</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit22">
                        <asp:Label runat="server" ID="lbAccruedInterest" Font-Bold="true"></asp:Label>
                    </td>

                    <td class="ctrl-td-lb" runat="server" id="tdCredit101">Простроч. заборг. по %</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit102">
                        <asp:Label runat="server" ID="lbDelayScoreInterest" Font-Bold="true"></asp:Label>
                    </td>

                    <td class="ctrl-td-lb" style="white-space: nowrap" runat="server" id="tdCredit91">Простроч. заборг. по тілу</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdCredit92">
                        <asp:Label runat="server" ID="lbDelayScoreBody" Font-Bold="true"></asp:Label>
                    </td>
                    <!-- /credit -->

                    <!-- others -->
                    <td runat="server" id="tdOthers09"></td>
                    <td runat="server" id="tdOthers10"></td>

                    <td class="ctrl-td-lb" runat="server" id="tdOthers07">Сума вихідних (осн.):</td>
                    <td class='ctrl-td-val ctrl-right' runat="server" id="tdOthers08">
                        <asp:Label runat="server" ID="lbOtherSumOut" Font-Bold="true"></asp:Label>
                    </td>
                    <td runat="server" id="tdOthers11"></td>
                    <!-- /others -->

                    <td style="text-align: right">
                        <button type="button" id="btLicenses" class="btn-pin-ico" style="width: 100px; height: 22px; padding-top: 0" title="Перегляд ліцензій по контракту"  
                            onclick="curr_module.ShowLicenses()">
                            Ліцензії</button>
                    </td>
                    <td class="ctrl-td-lb">Витяг з журналу:
                        <asp:ImageButton ToolTip="вигрузка в excel" ID="btExpJournalExcel" ImageUrl="/barsroot/cim/style/img/ms-excel.gif" runat="server" OnClick="btExpJournalExcel_OnServerClick" />
                        <asp:ImageButton ToolTip="вигрузка в word" ID="btExpJournalWord" ImageUrl="/barsroot/cim/style/img/ms-word.gif" runat="server" OnClick="btExpJournalWord_OnServerClick" />
                    </td>
                </tr>
            </table>

        </div>
    </fieldset>
    <div id="tabs" style="display: none">
        <ul>
            <li><a href="#tabEmpty" style="display: none"></a></li>
            <li><a href="#tabPayments">Платежі</a></li>
            <li><a href="#tabCredGraphParams">Параметри графіка</a></li>
            <li><a href="#tabCredGraph">Графік</a></li>
            <li><a href="#tabPaymentsTrade">Платежі</a></li>
            <li><a href="#tabAddPayments">Додаткові платежі</a></li>
        </ul>
        <div id="tabEmpty" style="display: none"></div>
        <div id="tabPayments">
            <fieldset>
                <legend>Вхідні платежі</legend>
                <div>
                    <button id="btBoundInPayment" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundInPayment(0)">Прив’язати платіж</button>
                    <bars:BarsGridViewEx ID="gvVCimInBoundPayments" runat="server" AutoGenerateColumns="False" ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                        CssClass="barsGridView" DataSourceID="odsVCimInBoundPayments" DataKeyNames="BOUND_ID"
                        AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" ShowPageSizeBox="true" OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                        ToolTip='Електронний архів'
                                        OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                        ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/Common/Images/default/16/cancel_blue.png" alt="Відв'язати платіж" onclick="curr_module.UnBoundPayment($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="TYPE" HeaderText="Тип платежу" SortExpression="TYPE"></asp:BoundField>
                            <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT"
                                DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="V_PL" HeaderText="Валюта платежу" SortExpression="V_PL">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="S_VPL" HeaderText="Сума прив’язки у валюті платежу" SortExpression="S_VPL"
                                DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SK_VPL" HeaderText="Комісія" SortExpression="SK_VPL" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RATE" HeaderText="Курс" SortExpression="RATE" DataFormatString="{0:G8}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="S_VK" HeaderText="Сума прив’язки у валюті контракту" SortExpression="S_VK"
                                DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                            <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                            <asp:BoundField DataField="REF" HeaderText="Реф. платежу" SortExpression="REF">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="ui-widget">
                                <div class="ui-state-default ui-corner-all">
                                    <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                    Дані по вхідним платежам відсутні.
                                </div>
                            </div>
                        </EmptyDataTemplate>
                        <RowStyle CssClass="normalRow"></RowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    </bars:BarsGridViewEx>
                </div>
            </fieldset>
            <fieldset>
                <legend>Вихідні платежі</legend>
                <div>
                    <button id="btBoundOutPayment" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundOutPayment(0)">Прив’язати платіж</button>
                    <bars:BarsGridViewEx ID="gvVCimOutBoundPayments" runat="server" AutoGenerateColumns="False" ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                        CssClass="barsGridView" DataSourceID="odsVCimOutBoundPayments" DataKeyNames="BOUND_ID"
                        ShowFooter="True" JavascriptSelectionType="SingleRow" ShowPageSizeBox="true"
                        OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                        ToolTip='Електронний архів'
                                        OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                        ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/Common/Images/default/16/cancel_blue.png" alt="Відв'язати платіж" onclick="curr_module.UnBoundPayment($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_l.png" alt="" title="Перегляд ліцензій по платежу" onclick="curr_module.LinkPrimLicensePay($(this), false)" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="true" DataField="PAY_FLAG_NAME" HeaderText="Класифікатор" SortExpression="PAY_FLAG_NAME"></asp:BoundField>
                            <asp:BoundField DataField="TYPE" HeaderText="Тип платежу" SortExpression="TYPE"></asp:BoundField>
                            <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT"
                                DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="V_PL" HeaderText="Валюта платежу" SortExpression="V_PL"></asp:BoundField>
                            <asp:BoundField DataField="S_VPL" HeaderText="Сума прив’язки у валюті платежу" SortExpression="S_VPL"
                                DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SK_VPL" HeaderText="Комісія" SortExpression="SK_VPL" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="RATE" HeaderText="Курс" SortExpression="RATE" DataFormatString="{0:G8}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="S_VK" HeaderText="Сума прив’язки у валюті контракту" SortExpression="S_VK"
                                DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                            <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                            <asp:BoundField DataField="REF" HeaderText="Реф. платежу" SortExpression="REF">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="ui-widget">
                                <div class="ui-state-default ui-corner-all">
                                    <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                    Дані по вихідним платежам відсутні.
                                </div>
                            </div>
                        </EmptyDataTemplate>
                        <RowStyle CssClass="normalRow"></RowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                    </bars:BarsGridViewEx>
                </div>
            </fieldset>
        </div>
        <div id="tabCredGraphParams">
            <fieldset>
                <legend>Планові платежі</legend>
                <div>
                    <button id="btAddPayment" type="button" class="btn-add-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.EditPayment($(this), true)">Добавити платіж</button>
                    <div style="overflow: auto; width: 500px; margin-left: 10px; margin-bottom: 10px">
                        <asp:GridView ID="gvVCimCredgraphPayments" runat="server" AutoGenerateColumns="False" ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                            CssClass="barsGridView" DataSourceID="odsVCimCredgraphPayment" DataKeyNames="ROW_ID"
                            OnRowDataBound="gvVCimCredgraphPayments_RowDataBound">
                            <Columns>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/document.png" alt="Редагувати запис" onclick="curr_module.EditPayment($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/cancel_blue.png" alt="Видалити запис" onclick="curr_module.DeletePayment($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="DAT" HeaderText="Дата платежу" SortExpression="DAT" DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="S" HeaderText="Сума платежу" SortExpression="S" DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PAY_FLAG" HeaderText="Класифікатор платежу" SortExpression="PAY_FLAG"></asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="normalRow"></RowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        </asp:GridView>
                    </div>
                </div>
                <div id="dialogPaymentInfo" style="display: none; text-align: left">
                    <table>
                        <tr>
                            <td>Дата платежу
                            </td>
                            <td class="field">
                                <input type="text" id="tbPaymentDat" name="tbPaymentDat" title="Вкажіть дату платежу"
                                    style="text-align: center; width: 80px" />
                            </td>
                            <td style="font-size: 7pt;">формат DD/MM/YYYY
                            </td>
                        </tr>
                        <tr>
                            <td>Сума платежу
                            </td>
                            <td class="field" style="white-space: nowrap">
                                <input type="text" id="tbSum" title="Вкажіть суму платежу" class="numeric" />
                            </td>
                            <td style="font-size: 7pt;">>0 - вхідний платіж<br />
                                < 0 - вихідний платіж
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Класифікатор платежу
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddPayFlag" DataSourceID="dsPayFlag" DataTextField="NAME"
                                    DataValueField="ID" ToolTip="Вкажіть класифікатор платежу">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div id="dvPayError" style="float: left; clear: left; color: Red;">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <fieldset>
                <legend>Періоди графіку</legend>
                <div>
                    <button id="btAddPeriod" type="button" class="btn-add-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.EditPeriod($(this), true)">Добавити період</button>
                    <div style="overflow: scroll; margin-left: 10px; margin-bottom: 10px">
                        <asp:GridView ID="gvVCimCredgraphPeriods" runat="server" AutoGenerateColumns="False"
                            DataSourceID="odsVCimCredgraphPeriod" CssClass="barsGridView" DataKeyNames="ROW_ID"
                            Width="99%" OnRowDataBound="gvVCimCredgraphPeriods_RowDataBound">
                            <Columns>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/document.png" alt="Редагувати запис" onclick="curr_module.EditPeriod($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/cancel_blue.png" alt="Видалити запис" onclick="curr_module.DeletePeriod($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="END_DATE" HeaderText="Дата закінчення періоду" SortExpression="END_DATE"
                                    DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CR_METHOD" HeaderText="Медтод погашення тіла" SortExpression="CR_METHOD"></asp:BoundField>
                                <asp:BoundField DataField="PAYMENT_PERIOD" HeaderText="Періодичність погашення тіла"
                                    SortExpression="PAYMENT_PERIOD"></asp:BoundField>
                                <asp:BoundField DataField="PAYMENT_DAY" HeaderText="Дата погашення тіла"
                                    SortExpression="PAYMENT_DAY">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PAYMENT_DELAY" HeaderText="Затримка погашення тіла (міс.)"
                                    SortExpression="PAYMENT_DELAY">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ADAPTIVE" HeaderText="Розподіл тіла після дост. погашення"
                                    SortExpression="ADAPTIVE"></asp:BoundField>
                                <asp:BoundField DataField="Z" HeaderText="Залишок тіла на кінець періоду" SortExpression="Z"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PERCENT" HeaderText="Процентна ставка" SortExpression="PERCENT"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PERCENT_NBU" HeaderText="Процентна ставка НБУ" SortExpression="PERCENT_NBU"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PERCENT_BASE" HeaderText="База нарахування відсотків"
                                    SortExpression="PERCENT_BASE"></asp:BoundField>
                                <asp:BoundField DataField="PERCENT_PERIOD" HeaderText="Періодичність погашення відсотків"
                                    SortExpression="PERCENT_PERIOD"></asp:BoundField>
                                <asp:BoundField DataField="PERCENT_DAY" HeaderText="Дата погашення відсотків"
                                    SortExpression="PERCENT_DAY">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PERCENT_DELAY" HeaderText="Затримка погашення відсотків (міс.)"
                                    SortExpression="PERCENT_DELAY">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="GET_DAY" HeaderText="Врахування дня видачі кредиту при нарахуванні відсотків"
                                    SortExpression="GET_DAY"></asp:BoundField>
                                <asp:BoundField DataField="PAY_DAY" HeaderText="Врахування дня погашення кредиту при нарахуванні відсотків"
                                    SortExpression="PAY_DAY"></asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="normalRow"></RowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        </asp:GridView>
                        <br />
                    </div>
                </div>
                <div id="dialogPeriodInfo" style="display: none; text-align: left">
                    <table>
                        <tr>
                            <td>Дата закінчення періоду
                            </td>
                            <td class="field">
                                <input type="text" id="tbEndDate" name="tbEndDate" title="Вкажіть дату закінчення періоду"
                                    style="text-align: center; width: 80px" />
                                <span style="font-size: 7pt;">формат DD/MM/YYYY</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Медтод погашення тіла
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddCreditMethod" DataSourceID="dsCreditMethod"
                                    DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть медтод погашення тіла" Enabled="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Періодичність погашення тіла
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddPaymentPeriod" DataSourceID="dsPaymentPeriod"
                                    DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть періодичність погашення тіла">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Дата погашення тіла
                            </td>
                            <td class="field">
                                <input type="text" id="tbPaymentDay" title="Вкажіть дату погашення тіла (від 1 до 31)" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Затримка погашення тіла (міс.)
                            </td>
                            <td class="field">
                                <input type="text" id="tbPaymentDelay" title="Вкажіть затримку погашення тіла" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Розподіл тіла після дост. погашення
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddCreditAdaptive" DataSourceID="dsCreditAdaptive"
                                    DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть розподіл тіла після дост. погашення">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Залишок тіла на кінець періоду
                            </td>
                            <td class="field">
                                <input type="text" id="tbZ" title="Вкажіть залишок тіла на кінець періоду" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Процентна ставка
                            </td>
                            <td class="field">
                                <input type="text" id="tbPeriodPercent" title="Вкажіть процентну ставку" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Процентна ставка НБУ
                            </td>
                            <td class="field">
                                <input type="text" id="tbPeriodPercentNbu" title="Вкажіть процентну ставку НБУ" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">База нарахування відсотків
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddCreditBase" DataSourceID="dsCreditBase" DataTextField="NAME"
                                    DataValueField="ID" ToolTip="Вкажіть базу нарахування відсотків">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Періодичність погашення відсотків
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddPercentPeriod" DataSourceID="dsPaymentPeriod"
                                    DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть періодичність погашення відсотків">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>Дата погашення відсотків
                            </td>
                            <td class="field">
                                <input type="text" id="tbPercentDay" title="Вкажіть дату погашення відсотків (від 1 до 31)" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Затримка погашення відсотків (міс.)
                            </td>
                            <td class="field">
                                <input type="text" id="tbPercentDelay" title="Вкажіть затримку погашення відсотків" class="numeric" />
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Врахування дня видачі при нарах. відсотків
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddGetDay" DataSourceID="dsConsider" DataTextField="NAME"
                                    DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">Врахування дня погашення при нарах. відсотків
                            </td>
                            <td class="field">
                                <asp:DropDownList runat="server" ID="ddPayDay" DataSourceID="dsConsider" DataTextField="NAME"
                                    DataValueField="ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <div id="dvPerError" style="float: left; clear: left; color: Red">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
        </div>
        <div id="tabCredGraph">
            <asp:Button runat="server" ID="btExportGraph" Text="Вигрузка в файл" OnClick="btExportGraph_Click" />
            <div>
                <div>
                    <table class="barsGridView" style="table-layout: fixed; width: 1400px">
                        <tr>
                            <th style="width: 80px">Дата</th>
                            <th style="width: 90px">Надход ження</th>
                            <th style="width: 90px">Погашення</th>
                            <th style="width: 90px">Залишок</th>
                            <th style="width: 90px">Виплачені % </th>
                            <th style="width: 90px">Додаткові платежі</th>
                            <th style="width: 90px">% за період</th>
                            <th style="width: 90px">Нараховані %</th>
                            <th style="width: 90px">Залишок %</th>
                            <th style="width: 90px">Планові %</th>
                            <th style="width: 90px">Прострочені %</th>
                            <th style="width: 90px">Прострочена заборгованість</th>
                            <th style="width: 90px">Планові надходження</th>
                            <th style="width: 90px">Планові погашення</th>
                            <th style="width: 90px">% НБУ</th>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="overflow: scroll; height: 500px; width: 1500px">
                <asp:GridView ID="gvCredGraph" runat="server" AutoGenerateColumns="False" ShowHeader="false"
                    ShowFooter="false" DataKeyNames="DAT" CssClass="barsGridView" OnRowDataBound="gvCredGraph_RowDataBound" Style="table-layout: fixed;">
                    <Columns>
                        <asp:BoundField DataField="DAT" HeaderText="" DataFormatString="{0:dd/MM/yy}">
                            <ItemStyle HorizontalAlign="Center" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RSNT" HeaderText="Надходження" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RSPT" HeaderText="Погашення" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZT" HeaderText="Залишок" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SVP" HeaderText="Виплачені % " DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SD" HeaderText="Додаткові платежі" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SMP" HeaderText="% за період" DataFormatString="{0:F5}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SMPS" HeaderText="Нараховані %" DataFormatString="{0:F5}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZP" HeaderText="Залишок %" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SP" HeaderText="Планові %" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DP" HeaderText="Прострочені %" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DT" HeaderText="Прострочена заборгованість" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PSNT" HeaderText="Планові надходження" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PSPT" HeaderText="Планові погашення" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ZPNBU" HeaderText="% НБУ" DataFormatString="{0:F}">
                            <ItemStyle HorizontalAlign="Right" Width="90px" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="normalRow"></RowStyle>
                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                </asp:GridView>
            </div>

        </div>
        <div id="tabAddPayments">
            <fieldset>
                <legend>Вхідні додаткові платежі</legend>
                <div>
                    <button id="btBoundInAddPayment" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundInPayment(1)">Прив’язати платіж</button>
                    <div style="overflow: scroll; margin-left: 10px; margin-bottom: 10px">
                        <asp:GridView ID="gvVCimInBounAddPayments" runat="server" AutoGenerateColumns="False"
                            Width="99%" CssClass="barsGridView" DataSourceID="odsVCimInBoundAddPayments" DataKeyNames="BOUND_ID"
                            OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                            ToolTip='Електронний архів'
                                            OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                            ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/cancel_blue.png" alt="Відв'язати платіж" onclick="curr_module.UnBoundPayment($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TYPE" HeaderText="Тип платежу" SortExpression="TYPE"></asp:BoundField>
                                <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT"
                                    DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="V_PL" HeaderText="Валюта платежу" SortExpression="V_PL">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="S_VPL" HeaderText="Сума прив’язки у валюті платежу" SortExpression="S_VPL"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SK_VPL" HeaderText="Комісія" SortExpression="SK_VPL" DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RATE" HeaderText="Курс валют" SortExpression="RATE" DataFormatString="{0:G8}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="S_VK" HeaderText="Сума прив’язки у валюті контракту" SortExpression="S_VK"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                                <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                                <asp:BoundField DataField="REF" HeaderText="Реф. платежу" SortExpression="REF">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="ui-widget">
                                    <div class="ui-state-default ui-corner-all">
                                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                        Дані по вхідним додатковим платежам відсутні.
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                            <RowStyle CssClass="normalRow"></RowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        </asp:GridView>
                    </div>
                </div>
            </fieldset>
            <fieldset>
                <legend>Вихідні додаткові платежі</legend>
                <div>
                    <button id="btBoundOutAddPayment" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundOutPayment(1)">Прив’язати платіж</button>
                    <div style="overflow: scroll; margin-left: 10px; margin-bottom: 10px">
                        <asp:GridView ID="gvVCimOutBoundAddPayments" runat="server" AutoGenerateColumns="False"
                            Width="99%" CssClass="barsGridView" DataSourceID="odsVCimOutBoundAddPayments" DataKeyNames="BOUND_ID"
                            OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                            ToolTip='Електронний архів'
                                            OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                            ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/Common/Images/default/16/cancel_blue.png" alt="Відв'язати платіж" onclick="curr_module.UnBoundPayment($(this))" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/barsroot/cim/style/img/row_check_l.png" alt="" title="Перегляд ліцензій по платежу" onclick="curr_module.LinkPrimLicensePay($(this), true)" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <img src="/barsroot/cim/style/img/row_check_a.png" alt="" class="imgApeLink" title="Перегляд актів цінової експертизи по платежу" onclick="curr_module.LinkPrimApePay($(this), true)" />
                                    </ItemTemplate>
                                    <ItemStyle Width="18px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="PAY_FLAG_NAME" HeaderText="Класифікатор платежу" SortExpression="PAY_FLAG_NAME"></asp:BoundField>
                                <asp:BoundField DataField="TYPE" HeaderText="Тип платежу" SortExpression="TYPE"></asp:BoundField>
                                <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT"
                                    DataFormatString="{0:dd/MM/yyyy}">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="V_PL" HeaderText="Валюта платежу" SortExpression="V_PL"></asp:BoundField>
                                <asp:BoundField DataField="S_VPL" HeaderText="Сума прив’язки у валюті платежу" SortExpression="S_VPL"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SK_VPL" HeaderText="Комісія" SortExpression="SK_VPL" DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RATE" HeaderText="Курс валют" SortExpression="RATE" DataFormatString="{0:G8}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="S_VK" HeaderText="Сума прив’язки у валюті контракту" SortExpression="S_VK"
                                    DataFormatString="{0:N}">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                                <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                                <asp:BoundField DataField="REF" HeaderText="Реф. платежу" SortExpression="REF">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="ui-widget">
                                    <div class="ui-state-default ui-corner-all">
                                        <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                                        Дані по вихідним додатковим платежам відсутні.
                                    </div>
                                </div>
                            </EmptyDataTemplate>
                            <RowStyle CssClass="normalRow"></RowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        </asp:GridView>
                    </div>
                </div>
            </fieldset>
        </div>
        <div id="tabPaymentsTrade">
            <fieldset>
                <legend>Первинні документи</legend>
                <div>
                    <!-- GRID1 v_cim_trade_payments -->
                    <button id="btBoundPrimPay" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundPrimPay()">Прив’язати платіж</button>
                    <button runat="server" id="btExp_pl" onserverclick="btExp_OnClick" class="btn-disk-ico" style="float: right">Вигрузка в Excel</button>
                    <asp:ObjectDataSource ID="odsVCimTradePrimPayments" runat="server" SelectMethod="SelectPrimaryPayments"
                        TypeName="cim.VCimTradePayments" SortParameterName="SortExpression" EnablePaging="True">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <bars:BarsGridViewEx ID="gvCimTradePrimPayments" runat="server" AutoGenerateColumns="False" ShowFilter="true"
                        DataSourceID="odsVCimTradePrimPayments"
                        ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True" ShowExportExcelButton="false"
                        AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                        ShowPageSizeBox="true" OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                        ToolTip='Електронний архів'
                                        OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                        ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати платіж" onclick="curr_module.UnBoundPrimPay($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_d.png" alt="" title="Перегляд МД\актів по платежу" onclick="curr_module.LinkPrimPay($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_c.png" alt="" title="Перегляд висновків по платежу" onclick="curr_module.LinkPrimConclusionPay($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_l.png" alt="" title="Перегляд ліцензій по платежу" onclick="curr_module.LinkPrimLicensePay($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_a.png" alt="" class="imgApeLink" title="Перегляд актів цінової експертизи по платежу" onclick="curr_module.LinkPrimApePay($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                            <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:G8}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_pd" HeaderText="Сума МД\актів" SortExpression="s_pd" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="zs_vp" HeaderText="Неприв`язаний залишок у валюті платежу" SortExpression="zs_vp" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="zs_vk" HeaderText="Неприв`язаний залишок у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_pd_after" HeaderText="Сума МД\актів після контрольної дати" SortExpression="s_pd_after" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="service_code" HeaderText="Код послуг" SortExpression="service_code">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                            <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                            <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BORG_REASON" HeaderText="Причина заборгов." SortExpression="BORG_REASON"></asp:BoundField>
                            <asp:BoundField DataField="CREATE_DATE" HeaderText="Дата реестр. в журналі" SortExpression="CREATE_DATE" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                        </Columns>
                    </bars:BarsGridViewEx>
                    <!-- GRID2 v_cim_bound_vmd-->
                    <button id="btBoundPrimVMD" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundPrimVMD()">Прив’язати МД\акт</button>
                    <asp:ObjectDataSource ID="odsVCimBoundPrimVmd" runat="server" SelectMethod="SelectPrimaryBoundVMD"
                        TypeName="cim.VCimBoundVmd" SortParameterName="SortExpression" EnablePaging="True">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <bars:BarsGridViewEx ID="gvCimBoundPrimVmd" runat="server" AutoGenerateColumns="False"
                        DataSourceID="odsVCimBoundPrimVmd" ShowExportExcelButton="false" ShowFilter="true"
                        ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                        AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="vmd_id"
                        ShowPageSizeBox="true" OnRowDataBound="gvCimBoundVmd_RowDataBound">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                        ToolTip='Електронний архів'
                                        OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                        ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати МД" onclick="curr_module.UnBoundPrimVMD($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_p.png" alt="" title="Перегляд платежів по МД\акту" onclick="curr_module.LinkPrimVMD($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <img src="/barsroot/cim/style/img/row_check_c.png" alt="" title="Перегляд висновків по МД\акту" onclick="curr_module.LinkPrimVMDConclusion($(this))" />
                                </ItemTemplate>
                                <ItemStyle Width="18px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="DOC_TYPE" HeaderText="Тип" SortExpression="DOC_TYPE"></asp:BoundField>
                            <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num"></asp:BoundField>
                            <asp:BoundField DataField="allow_date" HeaderText="Дата дозволу" SortExpression="allow_date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vt" HeaderText="Валюта товару" SortExpression="vt">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_vt" HeaderText="Сума у валюті товару" SortExpression="s_vt" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rate_vk" HeaderText="Курс" SortExpression="rate_vk" DataFormatString="{0:G8}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_pl_vk" HeaderText="Сума пов’язаних платежів" SortExpression="s_pl_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="z_vt" HeaderText="Заборгованість по платежах у валюті товару" SortExpression="z_vt" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="z_vk" HeaderText="Заборгованість по платежах у валюті контракту" SortExpression="z_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="control_date" HeaderText="Контрольна дата " SortExpression="control_date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="s_pl_after_vk" HeaderText="Сума пов’язаних платежів після контрольної дати" SortExpression="s_pl_after_vk" DataFormatString="{0:N}">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="file_name" HeaderText="№ реєстру" SortExpression="file_name">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="file_date" HeaderText="Дата реєстру " SortExpression="file_date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="comments" HeaderText="Примітка " SortExpression="comments"></asp:BoundField>
                            <asp:BoundField DataField="contract_num" HeaderText="Номер контракту" SortExpression="contract_num">
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="contract_date" HeaderText="Дата контракту " SortExpression="contract_date" DataFormatString="{0:dd/MM/yyyy}">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vmd_id" HeaderText="Референс" SortExpression="vmd_id">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BORG_REASON" HeaderText="Причина заборгов." SortExpression="BORG_REASON"></asp:BoundField>
                            <asp:BoundField DataField="CREATE_DATE" HeaderText="Дата реестр. в журналі" SortExpression="CREATE_DATE" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>

                        </Columns>
                    </bars:BarsGridViewEx>
                </div>
            </fieldset>
            <div id="tabsTrade" style="display: none">
                <ul>
                    <li><a href="#tabTradeSecond">Вторинні документи</a></li>
                    <li><a href="#tabTradeConclusions">Висновки мінекономіки</a></li>
                    <li><a href="#tabTradeApes" id="tabLinkApes">Акти цінової експертизи</a></li>
                </ul>
                <div id="tabTradeSecond">
                    <fieldset>
                        <legend>Вторинні документи</legend>
                        <div>
                            <!-- GRID3 v_cim_trade_payments -->
                            <button id="btBoundSecondPay" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundSecondPay()">Прив’язати платіж</button>
                            <button runat="server" id="btExp_md" onserverclick="btExp_OnClick" class="btn-disk-ico" style="float: right">Вигрузка в Excel</button>
                            <asp:ObjectDataSource ID="odsVCimTradeSecondPayments" runat="server" SelectMethod="SelectSecondPayments"
                                TypeName="cim.VCimTradePayments" SortParameterName="SortExpression" EnablePaging="True">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <bars:BarsGridViewEx ID="gvCimTradeSecondPayments" runat="server" AutoGenerateColumns="False" ShowFilter="true"
                                DataSourceID="odsVCimTradeSecondPayments" ShowExportExcelButton="false"
                                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
                                ShowPageSizeBox="true" OnRowDataBound="gvVCimBoundPayments_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                                ToolTip='Електронний архів'
                                                OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                                ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати платіж" onclick="curr_module.UnBoundSecondPay($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src="/barsroot/cim/style/img/row_check_d.png" alt="" title="Перегляд МД\актів повязаних з платежем" onclick="curr_module.LinkSecondPay($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="TYPE" HeaderText="Тип" SortExpression="TYPE"></asp:BoundField>
                                    <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="v_pl" HeaderText="Валюта платежу" SortExpression="v_pl">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_vpl" HeaderText="Сума у валюті платежу" SortExpression="s_vpl" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sk_vpl" HeaderText="Комісія" SortExpression="sk_vpl" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:G8}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_pd" HeaderText="Сума МД\актів" SortExpression="s_pd" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="zs_vp" HeaderText="Неприв`язаний залишок у валюті платежу" SortExpression="zs_vp" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="zs_vk" HeaderText="Неприв`язаний залишок у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NAZN" HeaderText="Призначення" SortExpression="NAZN"></asp:BoundField>
                                    <asp:BoundField DataField="ACCOUNT" HeaderText="Рахунок" SortExpression="ACCOUNT"></asp:BoundField>
                                    <asp:BoundField DataField="REF" HeaderText="Референс" SortExpression="REF">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CREATE_DATE" HeaderText="Дата реестр. в журналі" SortExpression="CREATE_DATE" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                                </Columns>
                            </bars:BarsGridViewEx>
                            <!-- GRID4  v_cim_bound_vmd-->
                            <button id="btBoundSecondVMD" type="button" class="btn-pin-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.BoundSecondVMD()">Прив’язати МД\акт</button>

                            <asp:ObjectDataSource ID="odsVCimBoundSecondVmd" runat="server" SelectMethod="SelectSecondBoundVMD"
                                TypeName="cim.VCimBoundVmd" SortParameterName="SortExpression" EnablePaging="True">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <bars:BarsGridViewEx ID="gvCimBoundSecondVmd" runat="server" AutoGenerateColumns="False" ShowFilter="true"
                                DataSourceID="odsVCimBoundSecondVmd" ShowExportExcelButton="false"
                                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="vmd_id"
                                ShowPageSizeBox="true" OnRowDataBound="gvCimBoundVmd_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                                ToolTip='Електронний архів'
                                                OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                                ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src="/Common/Images/default/16/cancel_blue.png" alt="" title="Відв'язати МД" onclick="curr_module.UnBoundSecondVMD($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src="/barsroot/cim/style/img/row_check_p.PNG" alt="" title="Перегляд платежів, пов'язаних з МД\актом" onclick="curr_module.LinkSecondVMD($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DOC_TYPE" HeaderText="Тип" SortExpression="DOC_TYPE"></asp:BoundField>
                                    <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num"></asp:BoundField>
                                    <asp:BoundField DataField="allow_date" HeaderText="Дата дозволу" SortExpression="allow_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="vt" HeaderText="Валюта" SortExpression="vt">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_vt" HeaderText="Сума у валюті МД\акту" SortExpression="s_vt" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="rate_vk" HeaderText="Курс" SortExpression="rate_vk" DataFormatString="{0:G8}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_pl_vk" HeaderText="Сума пов’язаних платежів" SortExpression="s_pl_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Z_VT" HeaderText="Заборгованість по платежах у валюті МД\акту" SortExpression="Z_VT" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="z_vk" HeaderText="Заборгованість по платежах у валюті контракту" SortExpression="z_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="file_name" HeaderText="№ реєстру" SortExpression="file_name">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="file_date" HeaderText="Дата реєстру " SortExpression="file_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="comments" HeaderText="Примітка " SortExpression="comments"></asp:BoundField>
                                    <asp:BoundField DataField="contract_num" HeaderText="Номер контракту" SortExpression="contract_num">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="contract_date" HeaderText="Дата контракту " SortExpression="contract_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="vmd_id" HeaderText="Референс" SortExpression="vmd_id">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CREATE_DATE" HeaderText="Дата реестр. в журналі" SortExpression="CREATE_DATE" DataFormatString="{0:dd/MM/yyyy}"></asp:BoundField>
                                </Columns>
                            </bars:BarsGridViewEx>
                        </div>
                    </fieldset>
                </div>
                <div id="tabTradeConclusions">
                    <fieldset>
                        <legend>Висновки мінекономіки</legend>
                        <div>
                            <button id="btAddConclusion" type="button" class="btn-add-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.EditConclusion($(this), true)">Добавити висновок</button>
                            <!-- GRID5 v_cim_conclusion-->

                            <bars:BarsSqlDataSourceEx runat="server" ID="dsVCimConclusion" ProviderName="barsroot.core"
                                SelectCommand="select id,contr_id,org_id,org_name,out_num,out_date,kv,s,begin_date,end_date,s_doc, s-s_doc s2, create_date,create_uid, ea_url from v_cim_conclusion where contr_id=:CONTR_ID">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                                </SelectParameters>
                            </bars:BarsSqlDataSourceEx>
                            <bars:BarsGridViewEx ID="gvVCimConclusion" runat="server" AutoGenerateColumns="False"
                                DataSourceID="dsVCimConclusion"
                                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="ID"
                                ShowPageSizeBox="true" OnRowDataBound="gvVCimConclusion_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                                ToolTip='Електронний архів'
                                                OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                                ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Видалити запис" onclick="curr_module.DeleteConclusion($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img runat="server" src="/Common/Images/default/16/document.png" alt="Редагувати запис" onclick="curr_module.EditConclusion($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img runat="server" src="/barsroot/cim/style/img/row_check_p.PNG" alt="" title="Перегляд платежів, пов'язаних з висновком" onclick="curr_module.LinkConclusion($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="out_num" HeaderText="Вихідний №" SortExpression="out_num"></asp:BoundField>
                                    <asp:BoundField DataField="out_date" HeaderText="Вихідна дата" SortExpression="out_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="org_name" HeaderText="Орган" SortExpression="org_name">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_doc" HeaderText="Сума пов'язаних документів" SortExpression="s_doc" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="begin_date" HeaderText="Дата початку строку" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="end_date" HeaderText="Дата закінчення строку" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="create_date" HeaderText="Дата редагування" SortExpression="create_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="create_uid" HeaderText="Користувач" SortExpression="create_uid">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="id" HeaderText="Референс" SortExpression="id">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </bars:BarsGridViewEx>
                        </div>
                        <div id="dialogConclusionInfo" style="display: none; text-align: left">
                            <table>
                                <tr>
                                    <td>Вихідний №
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbConclNum" name="tbConclNum" title="Вкажіть вихідний №" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Вихідна дата
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbConclOutDat" class="datepick" name="tbConclOutDat" title="Вкажіть вихідну дату"
                                            style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Орган
                                    </td>
                                    <td class="field">
                                        <asp:DropDownList runat="server" ID="ddConclOrgan" DataSourceID="dsConclOrgan" DataTextField="NAME"
                                            DataValueField="ID" ToolTip="Вкажіть орган">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Валюта
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbConclKv" title="Вкажіть валюту" class="numeric" maxlength="3" style="width: 25px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Сума
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbConclSum" title="Вкажіть сумму" class="numeric" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Дата початку строку
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbConclBeginDat" class="datepick" name="tbConclBeginDat" title="Вкажіть дату початку строку"
                                            style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Дата закінчення строку
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbConclEndDat" class="datepick" name="tbConclEndDat" title="Вкажіть дату закінчення строку"
                                            style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div id="dvConclErr" style="float: left; clear: left; color: Red;">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </div>
                <div id="tabTradeApes">
                    <fieldset>
                        <legend>Акти цінової експертизи</legend>
                        <div>
                            <button id="btAddApes" type="button" class="btn-add-ico" style="margin: 5px 5px 5px 10px" onclick="curr_module.EditApe($(this), true)">Добавити акт</button>
                            <!-- GRID5 v_cim_ape-->
                            <asp:ObjectDataSource ID="odsVCimApe" runat="server" SelectMethod="SelectApes"
                                TypeName="cim.VCimApe" SortParameterName="SortExpression" EnablePaging="True">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="CONTR_ID" QueryStringField="contr_id" DbType="Decimal" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <bars:BarsGridViewEx ID="gvVCimApe" runat="server" AutoGenerateColumns="False"
                                DataSourceID="odsVCimApe"
                                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="ape_id"
                                ShowPageSizeBox="true" OnRowDataBound="gvVCimApe_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgEA" Width="16px"
                                                ToolTip='Електронний архів'
                                                OnClientClick='<%# "window.open(\"" + Eval("EA_URL") + "\")" %>'
                                                ImageUrl="/Common/Images/default/16/e.png"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img id="Img1" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Видалити запис" onclick="curr_module.DeleteApe($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img id="Img2" runat="server" src="/Common/Images/default/16/document.png" alt="Редагувати запис" onclick="curr_module.EditApe($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <img src="/barsroot/cim/style/img/row_check_p.PNG" alt="" title="Перегляд актів, пов'язаних з актом цінової експертизи" onclick="curr_module.LinkApe($(this))" />
                                        </ItemTemplate>
                                        <ItemStyle Width="18px" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="num" HeaderText="Номер" SortExpression="num">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s" HeaderText="Сума у валюті акту" SortExpression="s" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="rate" HeaderText="Курс" SortExpression="rate" DataFormatString="{0:G8}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="s_vk" HeaderText="Сума у валюті контракту" SortExpression="s_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="zs_vk" HeaderText="Залишок суми у валюті контракту" SortExpression="zs_vk" DataFormatString="{0:N}">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="begin_date" HeaderText="Дата акту" SortExpression="begin_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="end_date" HeaderText="Дата закінчення" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="comments" HeaderText="Примітка" SortExpression="comments">
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                </Columns>
                            </bars:BarsGridViewEx>
                        </div>
                        <div id="dialogApeInfo" style="display: none; text-align: left">
                            <table>
                                <tr>
                                    <td>Номер акту
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeNum" name="tbApeNum" title="Вкажіть номер акту" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Валюта
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeKv" title="Вкажіть валюту" class="numeric" maxlength="3" style="width: 25px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Сума
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeSum" title="Вкажіть суму у валюті акту" class="numeric" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Курс
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeRate" title="Вкажіть курс" class="numeric" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Сума  у валюті контракту
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeSumVK" title="Вкажіть суму у валюті контракту" class="numeric" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Дата початку дії акту
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbApeBeginDate" class="datepick" name="tbApeBeginDate" title="Вкажіть дату початку дії акту"
                                            style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Дата закінчення дії акту
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbApeEndDate" class="datepick" name="tbApeEndDate" title="Вкажіть дату закінчення дії акту"
                                            style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Примітка
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbApeComment" title="Вкажіть примітку" style="width: 300px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div id="dvApeError" style="float: left; clear: left; color: Red;">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="dialogBorgReasonInfo" style="display: none; text-align: left">
                            <table>
                                <tr>
                                    <td>Причина заборгованості
                                    </td>
                                    <td class="field">
                                        <asp:DropDownList runat="server" ID="ddBorgReason" DataSourceID="dsBorgReason" DataValueField="ID" DataTextField="NAME" Width="500px" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="dialogRegDateInfo" style="display: none; text-align: left">
                            <table>
                                <tr>
                                    <td>Дата реєстрації
                                    </td>
                                    <td class="field" style="white-space: nowrap">
                                        <input type="text" id="tbRegDate" name="tbRegDate" title="Вкажіть дату реєстрації в журналі"
                                            style="text-align: center; width: 80px" />
                                        <span id="lbHintDate">* у форматі <b>DD/MM/YYYY</b></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div id="dvRegDateError" style="float: left; clear: left; color: Red">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
    </div>
    <div style="float: right; padding-top: 10px" runat="server" id="dvBack">
        <button id="btCancel" type="button" class="btn-back-ico" onclick="curr_module.GoBack();">Повернутися</button>
    </div>
</asp:Content>
