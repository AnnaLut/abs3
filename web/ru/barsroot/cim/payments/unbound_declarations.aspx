<%@ Page Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="unbound_declarations.aspx.cs" Inherits="cim.payments.CimPaymentsUnboundDeclarations"
    Title="Нерозібрані МД" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <table>
        <tr style="vertical-align: top">
            <td>
                <asp:Panel runat="server" ID="pnUnboundsType" GroupingText="Типи нерозібраних МД">
                    <asp:RadioButtonList runat="server" ID="cblTypesDirect" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="cblTypesDirect_SelectedIndexChanged">
                        <asp:ListItem Text="Імп." Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Експ." Value="1"></asp:ListItem>
                        <asp:ListItem Text="Всі" Value=""></asp:ListItem>
                    </asp:RadioButtonList>
                </asp:Panel>
            </td>
            <td style="text-align: right">
                <asp:Panel runat="server" ID="pnAutoBind" GroupingText="Автоприв'язка МД">
                    <table>
                        <tr>
                            <td>За період з
                            </td>
                            <td>
                                <input type="text" id="tbABindStart" runat="server" class="ctrl-date" />
                            </td>
                            <td>по
                                <input type="text" id="tbABindFinish" runat="server" class="ctrl-date" />
                            </td>
                            <td>&nbsp;ОКПО
                                <input type="text" id="tbABindOkpo" maxlength="10" style="width: 90px" />
                            </td>
                            <td>
                                <input id="btABind" type="button" onclick="curr_module.AutoBind();" value="Виконати" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pnAddFilter" GroupingText="Фільтр" Visible="false">
                    <div class="nw">
                        <asp:CheckBox runat="server" ID="cbFilterByOkpo" Text="МД по клієнту контракту" Checked="true" AutoPostBack="true" OnCheckedChanged="cbFilterByOkpo_OnCheckedChanged" />
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
                                    <div style="width: 15px; height: 15px; background-color: blue"></div>
                                </td>
                                <td colspan="2">- акти</td>
                            </tr>
                            <tr>
                                <td style="white-space: nowrap">Колір суми:
                                </td>
                                <td>
                                    <div style="font-weight: bold; color: maroon; padding: 1px; border: 1px solid gray">1.00</div>
                                </td>
                                <td>- неприв'язані</td>
                                <td>
                                    <div style="font-weight: bold; color: green; padding: 1px; border: 1px solid gray">1.00</div>
                                </td>
                                <td>- частково прив'язані</td>
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
            <span>
                <button type="button" id="btBindDecl" onclick="curr_module.DeclBind(null, 0);" style="height: 30px">Прив'язати МД</button>
                <button type="button" id="selectBind" style="height: 30px">Опції прив'язки</button>
            </span>
            <ul style="position: absolute; display: none">
                <li><a href="#" onclick="curr_module.DeclBind(null, 1);">Прив'язати МД як фантом</a></li>
            </ul>

            <input id="btBindAct" type="button" onclick="curr_module.ActBind();" value="Створити акт" style="display: none" />
            <input id="btSendToBank" type="button" onclick="curr_module.PrepareSendToBank();" value="Передача в інший банк" />
        </div>
    </fieldset>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCimTypes" ProviderName="barsroot.core"
        SelectCommand="select type_id, type_name from cim_types">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCimActTypes" ProviderName="barsroot.core"
        SelectCommand="select type_id, name from cim_act_types">
    </bars:BarsSqlDataSourceEx>

    <asp:ObjectDataSource ID="odsVCimUnboundVmd" runat="server" SelectMethod="SelectDeclarations"
        TypeName="cim.VCimUnboundVmd" SortParameterName="SortExpression" EnablePaging="True">
        <SelectParameters>
            <asp:ControlParameter ControlID="cblTypesDirect" DbType="Decimal" PropertyName="SelectedValue" Name="DIRECT" />
            <asp:ControlParameter Name="FILTER_OKPO" ControlID="cbFilterByOkpo" PropertyName="Checked" />
            <asp:QueryStringParameter Name="CUST_OKPO" QueryStringField="okpo" DbType="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div style="overflow: scroll; padding: 10px 10px 10px 0; margin-left: -10px">
        <bars:BarsGridViewEx ID="gvVCimUnboundVmd" runat="server" AutoGenerateColumns="False"
            DataSourceID="odsVCimUnboundVmd" ShowFilter="true"
            ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
            AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="VMD_ID"
            ShowPageSizeBox="true" OnRowDataBound="gvVCimUnboundVmd_RowDataBound" OnPreRender="gvVCimUnboundVmd_PreRender">
            <Columns>
                <asp:BoundField DataField="NUM" HeaderText="№" SortExpression="NUM">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="CIM_ORIGINAL" HeaderText="Стан" SortExpression="CIM_ORIGINAL" DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="ALLOW_DATE" HeaderText="Дата дозволу" SortExpression="ALLOW_DATE" DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="kv" HeaderText="Валюта" SortExpression="kv">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:N}">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="unbound_s" HeaderText="Неприв`язана сума" SortExpression="unbound_s" DataFormatString="{0:N}">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="ОКПО" SortExpression="OKPO"></asp:BoundField>
                <asp:BoundField DataField="nmk" HeaderText="Клієнт" SortExpression="nmk" ItemStyle-Wrap="True" ItemStyle-Width="200px" ItemStyle-CssClass="wr"></asp:BoundField>
                <asp:BoundField DataField="benef_name" HeaderText="Контрагент" SortExpression="benef_name" ItemStyle-Width="200px" ItemStyle-Wrap="True" ItemStyle-CssClass="wr"></asp:BoundField>
                <asp:BoundField DataField="country" HeaderText="Код країни" SortExpression="country"></asp:BoundField>
                <asp:BoundField DataField="contract_date" HeaderText="Дата контракту" SortExpression="contract_date" DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="contract_num" HeaderText="№ контракту" SortExpression="contract_num"></asp:BoundField>
                <asp:BoundField DataField="f_date" HeaderText="Дата реєстру" SortExpression="f_date" DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="f_name" HeaderText="№ реєстру" SortExpression="f_name"></asp:BoundField>
                <asp:BoundField DataField="branch" HeaderText="Підрозділ" SortExpression="branch"></asp:BoundField>
            </Columns>
        </bars:BarsGridViewEx>
    </div>
    <div id="dialogDeclInfo" style="display: none; text-align: left">
        <table class="ctrl-table">
            <tr>
                <td>
                    <span id="lbDeclId" style="font-style: italic;"></span>
                    <br />
                    <span id="lbDeclNum" style="font-style: italic;"></span>
                    <br />
                    <span id="lbDeslSum" style="font-style: italic;"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <a id="lnBindDecl">Прив'язати МД</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a id="lnBindDeclasFantom">Прив'язати МД як фантом</a><br />
                </td>
            </tr>
        </table>
    </div>
    <div id="dialogBindDecl" style="display: none; text-align: left">
        <table class="ctrl-table">
            <tr>
                <td style="vertical-align: top">
                    <fieldset>
                        <legend>МД\акт</legend>
                        <div>
                            <table>
                                <tr>
                                    <td>Напрям:</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddBDirect" DataSourceID="dsCimTypes" DataTextField="TYPE_NAME"
                                            DataValueField="TYPE_ID" ToolTip="Вкажіть напрям платежу" Enabled="false">
                                        </asp:DropDownList>
                                    </td>
                                    <td>Тип акту:</td>
                                    <td class="field">
                                        <asp:DropDownList runat="server" ID="ddBActs" DataSourceID="dsCimActTypes" DataTextField="NAME"
                                            DataValueField="TYPE_ID" ToolTip="Вкажіть тип" Enabled="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nw" id="tdAllowDate1">Дата дозволу :</td>
                                    <td class="field nw" id="tdAllowDate2">
                                        <input type="text" id="lbBAllowDate" disabled="disabled" class="ctrl-date" />
                                    </td>
                                    <%--<td class="nw ald">Дата пап. носія:</td>
                                    <td class="field nw ald">
                                        <input type="text" id="tbPaperDate" class="ctrl-date" />
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td>Вн. номер:</td>
                                    <td class="field">
                                        <span id="lbBRef" class="roValue"></span></td>
                                    <td>Номер:</td>
                                    <td class="field">
                                        <input type="text" id="lbBNum" disabled="disabled" /></td>
                                </tr>
                            </table>
                            <table>
                                <tr>
                                    <td colspan="3">
                                        <fieldset>
                                            <legend>Клієнт</legend>
                                            <table>
                                                <tr>
                                                    <td class="roValue"><span id="lbBCustNmk"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>ОКПО:
                                                    <span class="roValue" id="lbBCustOkpo"></span>
                                                    </td>
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
                                                <tr>
                                                    <td>Код країни:
                                                    <span class="roValue" id="lbBBenefCountry"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Валюта МД:</td>
                                    <td class="field">
                                        <input type="text" id="tbDocKv" disabled="disabled" style="width: 35px; text-align: center" maxlength="3" class="numeric" />
                                    </td>

                                    <td class="nw" id="tdUnSum">Неприв'язана сума:
                                        <input type="text" id="tbBUnSum" disabled="disabled" style="width: 100px; text-align: right" />
                                    </td>
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
                                    <td class="nw">Сума прив'язки у валюті МД\акту (<span id="lbBKvP" class="roValue"></span>):</td>
                                    <td class="field">
                                        <input type="text" id="tbBindDSum" class="numeric" style="width: 100px; text-align: right" />
                                        <span id="lbHintMax"></span>
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
                                        <textarea rows="2" cols="80" id="tbBComments"></textarea>
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

    <div id="dialogSendToBank" style="display: none; text-align: left">
        <table>
            <tr>
                <td>Клієнт:</td>
                <td class="field" style="white-space: nowrap" colspan="3">
                    <input type="text" id="tbClientRnk" name="tbClientRnk" readonly="readonly" class="required numeric" style="width: 80px" title="Вкажіть внутрішній код контрагента" />
                    <input type="button" id="btSelClient" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    <span id="lbClientNmk" class="roValue"></span>
                </td>
            </tr>
            <tr>
                <td>Бенефіціар:</td>
                <td class="field" style="white-space: nowrap" colspan="3">
                    <input type="text" id="tbBenefId" name="tbBenefId" readonly="readonly" class="required numeric" style="width: 80px" title="Вкажіть код бенефіціара" />
                    <input type="button" id="btSelBenef" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    <span id="lbBenefName" class="roValue"></span>
                </td>
            </tr>
            <tr>
                <td>Номер контракту:</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbContrNum" name="tbContrNum" title="Вкажіть номер контракту" />
                </td>
            </tr>
            <tr>
                <td>Дата контракту:</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbContrDate" name="tbContrDate" class="ctrl-date" title="Вкажіть дату контракту" />
                </td>
            </tr>
            <tr>
                <td>Частина суми, що передається</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbUnboundSum" title="Вкажіть частину суми, що передається" class="numeric" />
                </td>
            </tr>
            <tr>
                <td>Банк, в який передається платіж</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBBankMfo" title="Вкажіть МФО банку" maxlength="6" class="numeric" style="width: 55px" />
                    <input type="button" id="btSelBank" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    <input type="text" id="tbSBBankName" title="Вкажіть найменування банку" style="width: 300px" />
                </td>
            </tr>
            <tr>
                <td>Номер запиту</td>
                <td class="field">
                    <input type="text" id="tbSBZapNum" title="Вкажіть номер запиту" />
                </td>
                <td colspan="4" class="field">Дата запиту
                    <input type="text" id="tbSBZapDate" title="Вкажіть дата запиту" class="ctrl-date" />
                </td>
            </tr>
            <tr>
                <td>Посада керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDir" title="Вкажіть посада керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>ПІБ керівника установи</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBDirFio" title="Вкажіть ПІБ керівника установи" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>ПІБ виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerFio" title="Вкажіть ПІБ виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td>Телефон виконавця</td>
                <td colspan="3" class="field">
                    <input type="text" id="tbSBPerTel" title="Вкажіть Телефон виконавця" style="width: 200px" />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div id="dvSendToBank" style="float: left; clear: left; color: Red">
                    </div>
                </td>
            </tr>
        </table>
    </div>


    <div style="float: right; padding-top: 10px" runat="server" id="dvBack" visible="false">
        <input type="button" id="btCancel" value="Відмінити" onclick="curr_module.GoBack();" />
    </div>
</asp:Content>

