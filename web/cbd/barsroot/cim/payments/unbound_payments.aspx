<%@ Page Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true"
    CodeFile="unbound_payments.aspx.cs" Inherits="cim_payments_unbound_payments"
    Title="Нерозібрані платежі" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .selectedRow {
            background-color: #d3d3d3;
        }
    </style>
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCimTypes" ProviderName="barsroot.core"
        SelectCommand="select type_id, type_name from cim_types where type_id < 2">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCimPayTypes" ProviderName="barsroot.core"
        SelectCommand="select type_id, type_name from cim_payment_types order by 1">
    </bars:BarsSqlDataSourceEx>

    <table>
        <tr valign="top">
            <td>
                <asp:Panel runat="server" ID="pnUnboundsType" GroupingText="Типи нерозібраних платежів">
                    <div class="nw">
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Вхідні" ID="rbInPays" Checked="true"
                            OnCheckedChanged="rbInPays_CheckedChanged" AutoPostBack="true" />
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Вихідні" ID="rbOutPays"
                            OnCheckedChanged="rbOutPays_CheckedChanged" AutoPostBack="true" />
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Всі" ID="rbAllPays" AutoPostBack="True"
                            OnCheckedChanged="rbAllPays_CheckedChanged" />
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Пошук документу" ID="rbSearchByRef" AutoPostBack="True"
                            OnCheckedChanged="rbAllPays_CheckedChanged" />
                    </div>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pnSearchByRef" GroupingText="Вкажіть параметри пошуку" Visible="false">
                    <table style="width: 340px">
                        <tr>
                            <td colspan="2">
                                <asp:RadioButtonList runat="server" ID="rblModeSearch" OnSelectedIndexChanged="OnSelectedIndexChanged" RepeatDirection="Horizontal" AutoPostBack="true">
                                    <asp:ListItem Value="0" Selected="true">по реф.</asp:ListItem>
                                    <asp:ListItem Value="1">по даті валютування</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td style="text-align: right">
                                <asp:Button runat="server" ID="btSearchByRef" Text="Пошук" OnClick="btSearchByRef_OnClick" />
                            </td>
                        </tr>
                        <tr id="trSearchByRef" runat="server">
                            <td>Референс:</td>
                            <td>
                                <asp:TextBox runat="server" ID="tbSearchRef" CssClass="numeric" Width="90px"></asp:TextBox></td>
                        </tr>
                        <tr id="trSearchByDate" runat="server" visible="false">
                            <td colspan="3">
                                <table>
                                    <tr>
                                        <td>Дата валют.:</td>
                                        <td colspan="3">
                                            <asp:TextBox runat="server" ID="tbSearchVDat" CssClass="ctrl-date" Width="80px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Рахунок:</td>
                                        <td>
                                            <asp:TextBox runat="server" ID="tbSearchNls" Width="130px" MaxLength="14"></asp:TextBox>
                                        </td>
                                        <td>Валюта.:</td>
                                        <td>
                                            <asp:TextBox runat="server" ID="tbSearchKv" CssClass="numeric" Width="28px" MaxLength="3"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Сума:
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox runat="server" ID="tbSearchSum" CssClass="numeric" Width="130px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pnAddFilter" GroupingText="Фільтр" Visible="false">
                    <div class="nw">
                        <asp:CheckBox runat="server" ID="cbFilterByRnk" Text="Документи клієнта контракту" Checked="true" AutoPostBack="true" />
                    </div>
                </asp:Panel>
            </td>
            <td>
                <fieldset>
                    <legend>Позначення
                    </legend>
                    <div>
                        <table>
                            <tr>
                                <td style="white-space: nowrap">Колір рядка:
                                </td>
                                <td>
                                    <div style="width: 15px; height: 15px; background-color: green"></div>
                                </td>
                                <td>- платежі, що потребують візи</td>
                                <td>
                                    <div style="width: 15px; height: 15px; background-color: blue"></div>
                                </td>
                                <td>- платежі-фантоми</td>
                                <td>
                                    <div style="width: 15px; height: 15px; background-color: black"></div>
                                </td>
                                <td>- завізовані платежі</td>
                                <td>
                                    <div style="width: 15px; height: 15px; background-color: yellow"></div>
                                </td>
                                <td>- потребують довводу реквізитів</td>
                            </tr>
                            <tr>
                                <td style="white-space: nowrap">Колір суми:
                                </td>
                                <td>
                                    <div style="font-weight: bold; color: maroon; padding: 1px; border: 1px solid gray">1.00</div>
                                </td>
                                <td>- неприв'язані платежі</td>
                                <td>
                                    <div style="font-weight: bold; color: green; padding: 1px; border: 1px solid gray">1.00</div>
                                </td>
                                <td>- частково прив'язані</td>
                                <td>
                                    <div style="font-weight: normal; color: black; padding: 1px; border: 1px solid gray">1.00</div>
                                </td>
                                <td>- повністю прив'язані платежі</td>
                                
                            </tr>
                        </table>
                    </div>
                </fieldset>
            </td>
        </tr>
    </table>
    <fieldset>
        <legend>Дії на виділеним рядком</legend>
        <div>
            <input type="button" onclick="curr_module.DocCard();" value="Документ" style="height: 30px" />
            <span style="display: none">
                <button id="btVisaDoc" onclick="curr_module.DocSetVisa(); return false;" style="height: 30px">Завізувати</button>
                <button id="selectVisa" style="height: 30px">Опції візування</button>
            </span>
            <ul style="position: absolute; display: none">
                <li><a href="#" onclick="curr_module.DocSetVisa();">Візування</a></li>
                <li><a href="#" onclick="curr_module.DocSetVisaWithJ();">Візування з занесенням в журнал</a></li>
                <li id="liSendToBank"><a href="#" onclick="curr_module.DocSetVisaWithSend();">Візування з передачею в інший банк</a></li>
            </ul>
            <input type="button" id="btBackDoc" onclick="curr_module.DocBackVisa();" value="Повернути" style="height: 30px; display: none" />

            <!--input type="button" id="btBindPrimary" onclick="curr_module.DocBind(0);" value="Прив'язати(основний)" style="height: 30px" /-->

            <span style="display: none">
                <button type="button" id="btBindPrimary" onclick="curr_module.DocBind(0);" style="height: 30px">Прив'язати(основний)</button>
                <button type="button" id="selectBind" style="height: 30px">Опції прив'язки</button>
            </span>
            <ul style="position: absolute; display: none">
                <li><a href="#" onclick="curr_module.DocBind(2);">Прив'язати(основний) як фантом</a></li>
            </ul>
            <input type="button" id="btBindSecondary" onclick="curr_module.DocBind(1);" value="Прив'язати(додатковий)" style="height: 30px" />
            <input id="btBindFantom" type="button" onclick="curr_module.FantomBind();" value="Прив'язати фантом" style="height: 30px; display: none" />
            <input id="btShowRels" type="button" onclick="curr_module.ShowRels();" value="Зв'язки з контрактами" style="height: 30px;" />
        </div>
    </fieldset>
    <asp:ObjectDataSource ID="odsVCimUnboundPayments" runat="server" SelectMethod="SelectPayments"
        SortParameterName="SortExpression" EnablePaging="True">
        <SelectParameters>
            <asp:ControlParameter Name="FILTER_RNK" ControlID="cbFilterByRnk" PropertyName="Checked" />
            <asp:QueryStringParameter Name="CUST_RNK" QueryStringField="rnk" DbType="Decimal" />
            <asp:Parameter Name="DOC_DATE" DbType="String" />
            <asp:Parameter Name="DOC_NLS" DbType="String" />
            <asp:Parameter Name="DOC_KV" DbType="String" />
            <asp:Parameter Name="DOC_SUM" DbType="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div style="overflow: scroll; padding: 10px 10px 10px 0; margin-left: -10px">
        <bars:BarsGridViewEx ID="gvVCimUnboundPayments" runat="server" AutoGenerateColumns="False"
            DataSourceID="odsVCimUnboundPayments" ShowFilter="true"
            ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
            AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
            ShowPageSizeBox="true" OnRowDataBound="gvVCimUnboundPayments_RowDataBound">
            <Columns>
                <asp:BoundField DataField="PAY_TYPE_NAME" HeaderText="Тип" SortExpression="PAY_TYPE_NAME"></asp:BoundField>
                <asp:BoundField DataField="REF" HeaderText="Референс документу" SortExpression="REF">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="DIRECT_NAME" HeaderText="Напрямок" SortExpression="DIRECT_NAME"></asp:BoundField>
                <asp:BoundField DataField="VDAT" HeaderText="Планова дата валютування" SortExpression="REAL_VDAT" DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта платежу" SortExpression="KV">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TOTAL_SUM" HeaderText="Сума платежу" DataFormatString="{0:N}"
                    SortExpression="TOTAL_SUM">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="UNBOUND_SUM" HeaderText="Неприв'язана частина суми" SortExpression="UNBOUND_SUM"
                    DataFormatString="{0:N}">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="CUST_OKPO" HeaderText="ЄДРПОУ клієнта" SortExpression="CUST_OKPO"></asp:BoundField>
                <asp:BoundField DataField="CUST_NMK" HeaderText="Назва клієнта" SortExpression="CUST_NMK"></asp:BoundField>
                <asp:BoundField DataField="CUST_ND" Visible="false" HeaderText="№ договору з клієнтом" SortExpression="CUST_ND"></asp:BoundField>
                <asp:BoundField DataField="BENEF_NMK" HeaderText="Назва контрагента" SortExpression="BENEF_NMK"></asp:BoundField>
                <asp:TemplateField HeaderText="Рахунок" SortExpression="NLS">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" Text='<%# Eval("NLS") %>' OnClientClick='<%# "core$IframeBox({ url: \"/barsroot/customerlist/showhistory.aspx?acc=" + Eval("ACC") + "&type=1\", width: 1100, height: 700, title: \"Рух по рахунку " + Eval("NLS") + "(" + Eval("KV") + ")\" }); return false;" %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" SortExpression="NAZN"></asp:BoundField>
                <asp:BoundField DataField="CUST_RNK" HeaderText="Реєcтр. номер (RNK)" SortExpression="CUST_RNK"></asp:BoundField>
                <asp:BoundField DataField="OP_TYPE" HeaderText="Тип операції" SortExpression="OP_TYPE"></asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
    </div>
    <div id="dialogDocRels" style="display: none; text-align: left">
        <fieldset>
            <legend>Діючі зв'язки</legend>
            <div>
                <table id="tabRels" class="barsGridView">
                    <thead>
                        <tr>
                            <th>Номер контракту</th>
                            <th>Суб-номер</th>
                            <th>Дата контракту</th>
                            <th>Сума зв'язку</th>
                            <th>ID контракту</th>
                            <th>Дата створення</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </fieldset>
        <fieldset id="fsDelRels">
            <legend>Видалені зв'язки</legend>
            <div>
                <table id="tabDelRels" class="barsGridView">
                    <thead>
                        <tr>
                            <th>Номер контракту</th>
                            <th>Суб-номер</th>
                            <th>Дата контракту</th>
                            <th>Сума зв'язку</th>
                            <th>ID контракту</th>
                            <th>Дата видалення</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </fieldset>
        <fieldset id="fsRelsVIJ">
            <legend>Журнал</legend>
            <div>
                <input type="checkbox" disabled id="cbRelsVIJ" /><label for="cbRelsVIJ">Виконано операцію "Візування з занесенням в журнал"</label>
            </div>
        </fieldset>
    </div>

    <div id="dialogDocInfo" style="display: none; text-align: left">
        <table cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <span id="lbDocRef" style="font-style: italic;"></span>
                    <br />
                    <span id="lbPayType" style="font-style: italic;"></span>
                    <br />
                    <span id="lbTotalSum" style="font-style: italic;"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <a id="lnShowCard">Перегляд картки документу</a><br />
                    <a id="lnSignDoc">Завізувати документ</a><br />
                    <a id="lnKillDoc">Повернути документ</a><br />
                    <a id="lnBindDocMain">Прив'язати документ(основний)</a><br />
                    <a id="lnBindDocAdd">Прив'язати документ(додатковий)</a><br />
                    <a id="lnContrRels">Зв`язки з контрактами</a><br />
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogBindWithJ" style="display: none; text-align: left">
        <table>
            <tr>
                <td>Клієнт:</td>
                <td class="field">
                    <input type="text" id="tbJClientRnk" name="tbJClientRnk" readonly="readonly" class="required numeric" style="width: 80px" title="Вкажіть внутрішній код контрагента" />
                </td>
                <td>
                    <input type="button" id="btJSelClient" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                </td>
                <td>
                    <span id="lbJClientNmk" class="roValue"></span>
                </td>
            </tr>
            <tr>
                <td>Бенефіціар:</td>
                <td class="field">
                    <input type="text" id="tbJBenefId" name="tbJBenefId" readonly="readonly" class="required numeric" style="width: 80px" title="Вкажіть код бенефіціара" />
                </td>
                <td>
                    <input type="button" id="btJSelBenef" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                </td>
                <td>
                    <span id="lbJBenefName" class="roValue"></span>
                </td>
            </tr>
            <tr>
                <td>Номер контракту:</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbJContrNum" name="tbJContrNum" title="Вкажіть номер контракту" />
                </td>
            </tr>
            <tr>
                <td>Дата контракту:</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbJContrDate" name="tbJContrDate" style="text-align: center; width: 80px" title="Вкажіть дату контракту" />
                </td>
            </tr>
            <tr class="hideMode0">
                <td></td>
                <td colspan="3">
                    <input type="checkbox" id="cbJUnBind" />
                    <label for="cbJUnBind">Залишити в нерозібраних</label>
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Дата надходження коштів</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBValDate" name="tbSBValDate" title="Вкажіть дату надходження коштів" class="ctrl-date" style="text-align: center; width: 80px" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Частина суми, що передається</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBSum32A" title="Вкажіть частину суми, що передається" class="numeric" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Поле SWIFT 71F (комісія)</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBSum71F" title="Вкажіть поле SWIFT 71F" class="numeric" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Банк, в який передається платіж</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBBankMfo" title="Вкажіть МФО банку" maxlength="6" class="numeric" style="width: 55px" />
                    <input type="button" id="btSelBank" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    <input type="text" id="tbSBBankName" title="Вкажіть найменування банку" style="width: 300px" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Номер запиту</td>
                <td class="field">
                    <input type="text" id="tbSBZapNum" title="Вкажіть номер запиту" style="width: 80px" />
                </td>
                <td>Дата запиту</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBZapDate" title="Вкажіть дата запиту" class="ctrl-date" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Посада керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDir" title="Вкажіть посада керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>ПІБ керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDirFio" title="Вкажіть ПІБ керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>ПІБ виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerFio" title="Вкажіть ПІБ виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr class="hideMode1">
                <td>Телефон виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerTel" title="Вкажіть Телефон виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="dvBindJError" style="float: left; clear: left; color: Red">
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogBindDoc" style="display: none; text-align: left">
        <table cellpadding="3" cellspacing="0">
            <tr>
                <td style="vertical-align: top">
                    <fieldset>
                        <legend>Платіж</legend>
                        <div>
                            <table>
                                <tr>
                                    <td>Напрям:</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddBDirect" DataSourceID="dsCimTypes" DataTextField="TYPE_NAME"
                                            DataValueField="TYPE_ID" ToolTip="Вкажіть напрям платежу" Enabled="false">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="field">Тип платежу:
                                        <asp:DropDownList runat="server" ID="ddBType" DataSourceID="dsCimPayTypes" DataTextField="TYPE_NAME"
                                            DataValueField="TYPE_ID" ToolTip="Вкажіть тип платежу" Enabled="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Референс:</td>
                                    <td>
                                        <span id="lbBRef" class="roValue"></span></td>
                                    <td class="field">Дата валют. :
                                        <input type="text" id="lbBValDate" disabled="disabled" style="text-align: center; width: 80px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <fieldset>
                                            <legend>Клієнт</legend>
                                            <table>
                                                <tr>
                                                    <td colspan="2" class="roValue"><span id="lbBCustNmk"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>ОКПО:</td>
                                                    <td class="roValue"><span id="lbBCustOkpo"></span></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <fieldset>
                                            <legend>Контрагент</legend>
                                            <table>
                                                <tr>
                                                    <td class="roValue"><span id="lbBBenefName"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top">Призначення:</td>
                                    <td colspan="2" class="field">
                                        <textarea rows="2" cols="60" id="tbBNazn" disabled="disabled" style="width: 320px"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Валюта пл.:</td>
                                    <td class="field">
                                        <input type="text" id="tbDocKv" disabled="disabled" style="width: 35px; text-align: center" maxlength="3" class="numeric" />
                                    </td>

                                    <td class="nw" id="tdUnSum">Неприв'язана сума:
                                        <input type="text" id="tbBUnSum" disabled="disabled" style="width: 100px; text-align: right" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>Тип операції:</td>
                                    <td colspan="2" class="field">
                                        <select id="ddBOperType" style="width: 324px" class="required"></select></td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </td>
                <td style="vertical-align: top">
                    <fieldset>
                        <legend>Контракт</legend>
                        <div>
                            <table>
                                <tr>
                                    <td>Номер:
                                    </td>
                                    <td class="field" colspan="2">
                                        <span id="lbBConractNum" class="roValue"></span>
                                        &nbsp;&nbsp;(код <span id="lbBConractId" class="roValue"></span>)
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Тип контракту:
                                    </td>
                                    <td>
                                        <span id="lbBContrType" class="roValue"></span>
                                    </td>
                                    <td class="nw">Статус:
                                        <span id="lbBStatus" class="roValue"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <fieldset>
                                            <legend>Клієнт</legend>
                                            <table>
                                                <tr>
                                                    <td colspan="2" class="roValue"><span id="lbBCCNmk"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>ОКПО:</td>
                                                    <td class="roValue"><span id="lbBCCOkpo"></span></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <fieldset>
                                            <legend>Контрагент</legend>
                                            <table>
                                                <tr>
                                                    <td colspan="2" class="roValue"><span id="lbBCBNmk"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Країна:</td>
                                                    <td class="roValue"><span id="lbBCBCountry"></span></td>
                                                </tr>
                                                <tr>
                                                    <td>Адреса:</td>
                                                    <td class="roValue"><span id="lbBCBAddress"></span></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Дата відкриття:
                                    </td>
                                    <td>
                                        <span id="lbBDateOpen" class="roValue"></span>
                                    </td>

                                    <td class="nw">Дата закінч.:
                                        <span id="lbBDateClose" class="roValue"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Валюта конт.:
                                    </td>
                                    <td>
                                        <input type="text" id="lbBCKv" disabled="disabled" style="width: 30px; text-align: center" />
                                    </td>
                                    <td class="nw">Сума конт.:
                                        <input type="text" id="lbBCSum" disabled="disabled" style="width: 100px; text-align: right" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="vertical-align: top; width: 100%">
                    <fieldset>
                        <legend>Зв'язок</legend>
                        <div>
                            <table>
                                <tr>
                                    <td>Класифікатор платежу:</td>
                                    <td>
                                        <select id="ddPayFlag"></select>
                                    </td>
                                </tr>
                                <tr id="trApeServiceCode" style="display: none">
                                    <td>Класифікатор послуг зовнішньоекономічної діяльності :</td>
                                    <td class="field">
                                        <input type="text" id="tbApeServiceCode" disabled="disabled" style="width: 50px; text-align: center" />
                                        <input type="button" value="..." title="Вибрати із довідника" id="btShowServiceCodes" style="height: 22px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Сума прив'язки у валюті платежу (<span id="lbBKvP" class="roValue"></span>):</td>
                                    <td class="field">
                                        <input type="text" id="tbBindDSum" class="numeric" style="width: 100px; text-align: right" />
                                        <span id="lbHintMax"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Комісія у валюті платежу (<span id="lbBKvP2" class="roValue"></span>):</td>
                                    <td class="field">
                                        <input type="text" id="tbBindFee" class="numeric required" style="width: 100px; text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Курс:
                                    </td>
                                    <td class="field">
                                        <input type="text" id="tbBindRate" class="numeric required" style="width: 100px; text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw">Сума прив'язки у валюті контракту (<span id="lbBKvC" class="roValue"></span>):</td>
                                    <td class="field">
                                        <input type="text" id="tbBindCSum" class="required numeric" style="width: 100px; text-align: right" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Коментар:
                                    </td>
                                    <td>
                                        <textarea rows="2" cols="60" id="tbBComments"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div id="dvBindError" style="float: left; clear: left; color: Red">
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </fieldset>
                </td>
            </tr>
        </table>
    </div>
    <div style="float: right; padding-top: 10px" runat="server" id="dvBack" visible="false">
        <button id="btCancel" onclick="curr_module.GoBack();">Повернутися</button>
    </div>
</asp:Content>
