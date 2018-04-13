<%@ Page Title="Картка контракту" Language="C#" MasterPageFile="~/cim/default.master"
    AutoEventWireup="true" CodeFile="contract_card.aspx.cs" Inherits="cim_contracts_other_contract_card" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsContrType" ProviderName="barsroot.core"
        SelectCommand="select null contr_type_id, null contr_type_name from dual union all select contr_type_id,contr_type_name from cim_contract_types">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditorType" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_creditor_type">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditType" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_type">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditTerm" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_term">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditPrepay" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_prepay">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditPercent" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_percent">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsTrDeadline" ProviderName="barsroot.core"
        SelectCommand="select deadline, comments from cim_contract_deadlines">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsTrSpecs" ProviderName="barsroot.core"
        SelectCommand="select spec_id, spec_name from cim_contract_specs">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsCreditBorrower" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id, name from cim_credit_borrower">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsTrSubjects" ProviderName="barsroot.core"
        SelectCommand="select null subject_id, null subject_name from dual union all select subject_id, subject_name from cim_contract_subjects">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsBranches" ProviderName="barsroot.core"
        SelectCommand="select branch, branch || ' - ' || name name from branch where branch like sys_context('bars_context', 'user_branch_mask') order by 1">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx runat="server" ID="dsKv" ProviderName="barsroot.core" SelectCommand="select null kv, null name from dual union all select kv, kv || ' - ' ||name name from tabval where d_close is null order by kv nulls first">
    </bars:BarsSqlDataSourceEx>
    <div id="tabs" style="display: none">
        <ul>
            <li><a href="#tabMainContr">Основні реквізити</a></li>
            <li><a href="#tabImpExpContr">Додаткові реквізити торгового контракту</a></li>
            <li><a href="#tabCreditContr">Додаткові реквізити кредитного контракту</a></li>
            <li><a href="#tabOthersContr">Додаткові реквізити контракту</a></li>
            <li><a href="#tabCreditContrExportReq">Реквізити заявки для НБУ</a></li>
            <li><a href="#tabCreditExportFile">Реєстрація в НБУ</a></li>
        </ul>
        <div id="tabMainContr">
            <asp:Panel runat="server" ID="pnMainReq" GroupingText="Базові реквізити">
                <table>
                    <tr>
                        <td>Тип контракту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddContrType" DataSourceID="dsContrType" DataTextField="CONTR_TYPE_NAME"
                                DataValueField="CONTR_TYPE_ID" ToolTip="Вкажіть тип контракту" class="required">
                            </asp:DropDownList>
                        </td>
                        <td>Статус контракту
                        </td>
                        <td>
                            <span id="lbStatus" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Номер контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbConractNum" maxlength="60" style="width: 80px" class="required" title="Вкажіть номер контракту" />
                            Дод. номер
                            <input type="text" id="tbConractSubNum" maxlength="20" style="width: 60px" title="Вкажіть додатковий номер контракту" />
                        </td>
                        <td>Внутрішній код контракту
                        </td>
                        <td>
                            <span id="lbConractId" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Дата відкриття
                        </td>
                        <td class="field">
                            <input type="text" id="tbDateOpen" name="tbDateOpen" class="required ctrl-date" maxlength="10"
                                title="Вкажіть дату відкриття контракту" style="text-align: center; width: 80px" />
                        </td>
                        <td>Дата закінчення
                        </td>
                        <td class="field">
                            <input type="text" id="tbDateClose" class="ctrl-date" title="Вкажіть дату закінчення контракту" style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Коментар
                        </td>
                        <td colspan="3">
                            <textarea cols="84" rows="3" id="tbComments" title="Вкажіть коментар до контракту"></textarea>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnSum" GroupingText="Сума та валюта контракту">
                <table>
                    <tr>
                        <td>Валюта контракту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddKv" DataSourceID="dsKv" DataTextField="NAME"
                                DataValueField="KV" ToolTip="Вкажіть валюту контракту" class="required">
                            </asp:DropDownList>
                        </td>
                        <td>Сума контракту
                        </td>
                        <td class="field">
                            <bars:NumericEdit runat="server" ID="tbSum" ToolTip="Вкажіть суму контракту"></bars:NumericEdit>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnClient" GroupingText="Контрагент">
                <table>
                    <tr>
                        <td>ОКПО контрагента
                        </td>
                        <td class="field">
                            <input type="text" id="tbClientOkpo" name="tbClientOkpo" maxlength="10" class="required"
                                title="Вкажіть ОКПО контрагента" />
                            <input type="button" id="btSelClientByOkpo" value="..." title="Вибрати з довідника з фільтром по ОКПО"
                                style="height: 21px; vertical-align: bottom" />
                        </td>
                        <td>Внутрішній код(rnk)
                        </td>
                        <td class="field">
                            <input type="text" id="tbClientRnk" name="tbClientRnk" class="required numeric" title="Вкажіть внутрішній код контрагента" />
                            <input type="button" id="btSelClient" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                        </td>
                    </tr>
                    <tr>
                        <td>Найменування (коротке)
                        </td>
                        <td colspan="3">
                            <span id="lbNmkK" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Найменування
                        </td>
                        <td colspan="3">
                            <span id="lbNmk" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Вид економ. діяльності
                        </td>
                        <td colspan="3">
                            <span id="lbVedName" class="roValue"></span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnBenef" GroupingText="Бенефіціар (клієнт-нерезидент)">
                <table>
                    <tr>
                        <td>Код бенефіціара
                        </td>
                        <td class="field">
                            <input type="text" id="tbBenefId" name="tbBenefId" class="required numeric" title="Вкажіть код бенефіціара" />
                            <input type="button" id="btSelectBenef" value="..." title="Вибрати з довідника" style="height: 20px; vertical-align: bottom" />
                        </td>
                        <td>Найменування
                        </td>
                        <td>
                            <span id="lbBenefName" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Країна (код)
                        </td>
                        <td>
                            <span id="lbCountryName" class="roValue"></span>
                            (<span id="lbCountryId" class="roValue"></span>)
                        </td>
                        <td>Адреса
                        </td>
                        <td class="field">
                            <span id="lbBenefAddress" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>BIC-код банку нерезидента
                        </td>
                        <td class="field">
                            <input type="text" id="tbBenefBicCode" name="tbBenefBicCode" title="Вкажіть код бенефіціара" />
                            <input type="button" id="btSelectBenefBicCode" value="..." title="Вибрати з довідника" style="height: 20px; vertical-align: bottom" />
                        </td>
                        <td>Найменування банку
                        </td>
                        <td>
                            <span id="lbBenefBankName" class="roValue"></span>
                        </td>
                        <td>
                            <span id="lbBenefBankB010"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>Коментар
                        </td>
                        <td colspan="3">
                            <span id="lbBenefComment" class="roValue"></span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table>
                <tr>
                    <td>
                        <asp:Panel runat="server" ID="pnOwnerUser" GroupingText="Користувач, за яким закріплено контракт">
                            <table>
                                <tr>
                                    <td>Код користувача
                                    </td>
                                    <td>
                                        <span id="lbOwnerUserId" class="roValue"></span>
                                    </td>
                                    <td>
                                        <input type="button" id="btSetOwner" value="Закріпити за собою" title="Закріпити за собою даний контракт" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>ПІБ
                                    </td>
                                    <td>
                                        <span id="lbIOwnerName" class="roValue"></span>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                    <td style="vertical-align: top">
                        <asp:Panel runat="server" ID="pnBranch" GroupingText="Відділення, за яким закріплено контракт">
                            <table>
                                <tr>
                                    <td>Відділення
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" DataSourceID="dsBranches" ID="ddBranch" DataTextField="NAME" DataValueField="BRANCH" />
                                    </td>
                                    <td>
                                        <input type="button" id="btChangeBranch" value="Змінити відділення" />
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
        <div id="tabImpExpContr">
            <asp:Panel runat="server" ID="pnInpExp" GroupingText="Реквізити торгового контракту">
                <table>
                    <tr>
                        <td>Контрольний строк</td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddTrDeadline" DataSourceID="dsTrDeadline"
                                DataTextField="DEADLINE" DataValueField="DEADLINE" ToolTip="Вкажіть контрольний строк">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Спеціалізація</td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddTrSpecs" DataSourceID="dsTrSpecs"
                                DataTextField="SPEC_NAME" DataValueField="SPEC_ID" ToolTip="Вкажіть спеціалізацію">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Предмет контракту</td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddTrSubjects" DataSourceID="dsTrSubjects"
                                DataTextField="SUBJECT_NAME" DataValueField="SUBJECT_ID" ToolTip="Вкажіть предмет контракту">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trWithoutActs" style="display:none">
                        <td>Робота без актів цінової експертизи</td>
                        <td class="field">
                            <input type="checkbox" id="cbTrWithoutActs" />
                        </td>
                    </tr>
                    <tr>
                        <td>Детальна інформація </td>
                        <td class="field">
                            <textarea cols="84" rows="3" id="tbTrComments"></textarea>
                        </td>
                    </tr>

                </table>
            </asp:Panel>
        </div>
        <div id="tabCreditContr">
            <asp:Panel runat="server" ID="pnPercent" GroupingText="Процентні ставки">
                <table>
                    <tr>
                        <td>Максимальна процентна ставка НБУ
                        </td>
                        <td class="field" colspan="3">
                            <input type="text" id="tbCrdNbuPercent" name="tbCrdNbuPercent" title="Вкажіть максимальну процентна ставку НБУ"
                                class="numeric" />
                        </td>
                    </tr>
                    <tr>
                        <td>Тип макс. проц. ставки НБУ
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditPercent" DataSourceID="dsCreditPercent"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть тип максимальної процентної ставки НБУ">
                            </asp:DropDownList>
                        </td>
                        <td>Ліміт заборгованості
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdLimit" name="tbCrdLimit" title="Вкажіть ліміт заборгованості"
                                class="numeric" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnCreditor" GroupingText="Кредитові реквізити">
                <table>
                    <tr>
                        <td>Тип кредитора
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditorType" DataSourceID="dsCreditorType"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть тип кредитора">
                            </asp:DropDownList>
                        </td>
                        <td>Тип кредиту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditType" DataSourceID="dsCreditType" DataTextField="NAME"
                                DataValueField="ID" ToolTip="Вкажіть тип кредиту" Width="300px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Строковість кредиту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditTerm" DataSourceID="dsCreditTerm" DataTextField="NAME"
                                DataValueField="ID" ToolTip="Вкажіть cтроковість кредиту">
                            </asp:DropDownList>
                        </td>
                        <td>Вид позичальника
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditBorrower" DataSourceID="dsCreditBorrower"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть вид позичальника">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Можливість дострокового погашення
                        </td>
                        <td class="field" colspan="3">
                            <asp:DropDownList runat="server" ID="ddCreditPrepay" DataSourceID="dsCreditPrepay"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть можливість дострокового погашення">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnF503" GroupingText="Реквізити звіту Ф503">
                <table>
                    <tr>
                        <td>Код підстави подання звіту</td>
                        <td>
                            <select id="ddF503Reason">
                                <option value=""></option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Код стану розрахунків за кредитом</td>
                        <td>
                            <select id="ddF503State">
                                <option value=""></option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Примітка</td>
                        <td>
                            <input id="tbF503Note" style="width: 600px" maxlength="108" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnF504" GroupingText="Реквізити звіту Ф504">
                <table>
                    <tr>
                        <td>Код підстави подання звіту</td>
                        <td>
                            <select id="ddF504Reason">
                                <option value=""></option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Примітка</td>
                        <td>
                            <input id="tbF504Note" style="width: 600px" maxlength="108" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div id="tabOthersContr">
        </div>
        <div id="tabCreditContrExportReq">
            <asp:Panel runat="server" ID="pnExport" GroupingText="Реквізити договору">
                <table>
                    <tr>
                        <td>Назва договору
                        </td>
                        <td colspan="3" class="field">
                            <input type="text" id="tbCrdName" maxlength="64" style="width: 400px" title="Вкажіть назву договору" />
                        </td>
                    </tr>
                    <tr>
                        <td>Реєстраційний серверний номер
                        </td>
                        <td class="field" colspan="3">
                            <input type="text" id="tbCrdDocKey" name="tbCrdDocKey" class="numeric" title="Вкажіть реєстраційний серверний номер (заповнюється при змінах)" />
                        </td>
                    </tr>
                    <tr>
                        <td>Дата реєстрації контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdAgreeDate" name="tbCrdAgreeDate" maxlength="10" title="Вкажіть дату реєстрації контракту (заповнюється при змінах)"
                                style="text-align: center; width: 80px" />
                        </td>
                        <td>Номер реєстрації контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdAgreeNum" name="tbCrdAgreeNum" maxlength="32" title="Вкажіть номер реєстрації контракту (заповнюється при змінах)" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <fieldset id="pnLongTermAgree">
                <legend>Параметри довгострокового контракту </legend>
                <table>
                    <tr>
                        <td style="vertical-align: top">Додаткові угоди
                        </td>
                        <td colspan="3" class="field">
                            <textarea rows="2" cols="84" id="tbCrdAddAgree" title="Вкажіть додаткові угоди"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Додаткова інформація про макс. ставку НБУ
                        </td>
                        <td class="field" colspan="3">
                            <input type="text" id="tbPencentNbuInfo" maxlength="128" style="width: 436px" title="Вкажіть додаткову інформацію про максимальну процентну ставку НБУ" />
                        </td>
                    </tr>
                    <tr>
                        <td>Кінцева дата індивідуального строку дії реєстрації контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdIndEndDate" name="tbCrdIndEndDate" maxlength="10" title="Вкажіть кінцеву дату індивідуального строку дії реєстрації контракту"
                                style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Зареєстровані зміни до контракту
                        </td>
                        <td colspan="3" class="field">
                            <textarea rows="2" cols="84" id="tbCrdPrevReestrAttr" title="Зареєстровані зміни до контракту"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top">Інформація про короткостроковий контракт
                            <br />
                            <span style="font-style: italic">(заповнюється при перереєстрації з<br />
                                короткострокового у довгостроковий)</span>
                        </td>
                        <td class="field">
                            <textarea rows="2" cols="84" id="tbCrdParentChData" title="Вкажіть інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>Строк дії реєстрації контракту
                            <br />
                            <span style="font-style: italic">(заповнюється при продовженні строку)</span>
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdEndingDate" name="tbCrdEndingDate" maxlength="10" title="Вкажіть cтрок дії реєстрації контракту (заповнюється при продовженні строку)"
                                style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset id="pnShortTermAgree">
                <legend>Параметри короткострокового контракту</legend>
                <table>
                    <tr>
                        <td>Тип кредитної операції
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditOperType"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть тип кредитної операції">
                            </asp:DropDownList>
                        </td>
                        <td>Дата факт. здійснення операції
                        </td>
                        <td>
                            <input type="text" id="tbCrdOperDate" name="tbCrdOperDate" maxlength="10" title="Вкажіть дату факт. здійснення операції"
                                style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Маржа плаваючої ставки за основною сумою боргу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdMargin" class="numeric" title="Вкажіть маржу плаваючої ставки" />
                        </td>
                        <td>Номер траншу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshNum" maxlength="32" title="Вкажіть номер траншу" />
                        </td>
                    </tr>
                    <tr>
                        <td>Обсяг траншу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshSum" class="numeric" title="Вкажіть обсяг траншу" />
                        </td>
                        <td>Валюта траншу
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCrdTranshCurr" DataSourceID="dsKv" DataTextField="NAME"
                                DataValueField="KV" ToolTip="Вкажіть валюту траншу">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Процентна ставку за траншем
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshRatName" title="Вкажіть процентну ставку за траншем" />
                        </td>
                        <td>Фактичний розмір ставки за траншем
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshRat" class="numeric" title="Вкажіть фактичний розмір ставки за траншем" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="tabCreditExportFile">
            <div id="divApproveNbu">
                <fieldset id="pnApproveNbu">
                    <legend>Підтвердження реєстрації</legend>
                    <table>
                        <tr>
                            <td>Реєстраційний серверний номер
                            </td>
                            <td class="field">
                                <input type="text" id="tbApproveCrdDocKey" name="tbApproveCrdDocKey" class="numeric"
                                    title="Вкажіть реєстраційний серверний номер (заповнюється при змінах)" />
                            </td>
                        </tr>
                        <tr class="trApproveNew">
                            <td>Дата реєстрації контракту
                            </td>
                            <td class="field">
                                <input type="text" id="tbApproveCrdDate" name="tbApproveCrdDate" style="text-align: center; width: 80px"
                                    maxlength="10" title="Вкажіть дату реєстрації контракту (заповнюється при змінах)" />
                            </td>
                        </tr>
                        <tr class="trApproveNew">
                            <td>Номер реєстрації контракту
                            </td>
                            <td class="field">
                                <input type="text" id="tbApproveCrdNum" name="tbApproveCrdNum" maxlength="32" title="Вкажіть номер реєстрації контракту (заповнюється при змінах)" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="button" id="btApproveNbu" value="Підтвердити реєстрацію" style="width: 200px" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset id="pnDiscardNbu">
                    <legend>Відхилення реестрації</legend>
                    <table>
                        <tr>
                            <td>
                                <input type="button" id="btDiscardNbu" value="Відхилити реєстрацію" style="width: 200px" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
            <div id="divPrepareNbu">
                <fieldset>
                    <legend>Формування файлу для АРМу НБУ</legend>
                    <fieldset id="pnAddFiles">
                        <legend>Додаткові файли</legend>
                        <table>
                            <tr>
                                <td>Повідомлення про договір
                                </td>
                                <td class="field">
                                    <asp:FileUpload ID="fuAgreeDoc" runat="server" Width="300px" ToolTip="Вкажіть файл з повідомленням про договір" />
                                </td>
                                <td style="font-size: 7pt">* розмір файлу не повинен перевищувати 8 Мб
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr id="trOldBankConract">
                                <td style="white-space: nowrap">
                                    <input type="checkbox" id="cbOldBankConract" /><label for="cbOldBankConract">Контракт
                                        передано з іншого банку</label>
                                    <input type="checkbox" id="cbOldDepConract" /><label for="cbOldDepConract">Контракт
                                        передано з іншого підрозділу банку</label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <fieldset id="pnOldBankConract">
                                        <table>
                                            <tr id="trLetterDoc">
                                                <td>Лист-обгрунтування
                                                </td>
                                                <td class="field">
                                                    <asp:FileUpload ID="fuLetterDoc" runat="server" Width="300px" ToolTip="Вкажіть файл з листом обгрунтування" />
                                                    <asp:HiddenField runat="server" ID="hCreditTerm" />
                                                </td>
                                                <td style="font-size: 7pt">* розмір файлу не повинен перевищувати 8 Мб
                                                </td>
                                            </tr>
                                            <tr id="trOldBankMfo">
                                                <td>МФО попереднього уповноваженого банку
                                                </td>
                                                <td class="field" colspan="2">
                                                    <asp:TextBox runat="server" ID="tbOldBankMfo" ToolTip="Вкажіть попереднє МФО уповноваженого банку"
                                                        CssClass="numeric" MaxLength="6"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trOldOblCode">
                                                <td>Код області попереднього уповноваженого банку
                                                </td>
                                                <td class="field" colspan="2">
                                                    <asp:TextBox runat="server" ID="tbOldOblCode" ToolTip="Вкажіть код області за місцезнаходженням попереднього уповноваженого банку"
                                                        CssClass="numeric"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Код попереднього обслуговуючого банку або його підрозділу
                                                </td>
                                                <td class="field" colspan="2">
                                                    <asp:TextBox runat="server" ID="tbOldBankCode" ToolTip="Вкажіть код попереднього обслуговуючого банку або його підрозділу"
                                                        MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Код області попереднього обслуговуючого банку
                                                </td>
                                                <td class="field" colspan="2">
                                                    <asp:TextBox runat="server" ID="tbOldBankOblCode" ToolTip="Вкажіть код області попереднього обслуговуючого банку"
                                                        CssClass="numeric" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Реєстраційний серверний номер
                                                </td>
                                                <td class="field" colspan="2">
                                                    <input type="text" runat="server" id="tbOldApproveCrdDocKey" name="tbOldApproveCrdDocKey"
                                                        class="numeric" title="Вкажіть реєстраційний серверний номер (заповнюється при змінах)" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Дата реєстрації контракту
                                                </td>
                                                <td class="field" colspan="2">
                                                    <input type="text" runat="server" id="tbOldApproveCrdDate" name="tbOldApproveCrdDate"
                                                        style="text-align: center; width: 80px" maxlength="10" title="Вкажіть дату реєстрації контракту (заповнюється при змінах)" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Номер реєстрації контракту
                                                </td>
                                                <td class="field" colspan="2">
                                                    <input type="text" runat="server" id="tbOldApproveCrdNum" name="tbOldApproveCrdNum"
                                                        maxlength="32" title="Вкажіть номер реєстрації контракту (заповнюється при змінах)" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <asp:Button ID="btFormFile" Text="Сформувати файл" Width="200px" OnClick="btFormFile_Click" OnClientClick=""
                        runat="server" />
                </fieldset>
            </div>
        </div>
    </div>
    <div style="white-space: nowrap; margin-top: 10px">
        <div style="float: left">
            <button type="button" id="btRefresh">Перечитати</button>
        </div>
        <div style="float: right">
            <button type="button" id="btSave">Зберегти</button>
            <button type="button" id="btCancel">Відмінити</button>
        </div>
    </div>
    <div class="error" style="float: left; clear: left">
    </div>
</asp:Content>
