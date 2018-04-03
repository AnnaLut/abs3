<%@ Page Title="Картка контракту" Language="C#" MasterPageFile="~/cim/default.master"
    AutoEventWireup="true" CodeFile="contract_card.aspx.cs" Inherits="cim_contracts_other_contract_card" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsContrType" ProviderName="barsroot.core"
        SelectCommand="select null contr_type_id, null contr_type_name from dual union all select contr_type_id,contr_type_name from cim_contract_types">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditorType" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_creditor_type">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditType" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_type">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditPeriod" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_period">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditTerm" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_term">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditMethod" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_method">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditPrepay" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_prepay">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditPercent" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_percent">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsCreditOperType" ProviderName="barsroot.core"
        SelectCommand="select null id, null name from dual union all select id,name from cim_credit_opertype">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx runat="server" ID="dsKv" ProviderName="barsroot.core" SelectCommand="select null kv, null name from dual union all select kv, kv || ' - ' ||name name from tabval where d_close is null order by kv nulls first">
    </Bars:BarsSqlDataSourceEx>
    <div id="tabs" style="display: none">
        <ul>
            <li><a href="#tabMainContr">Основні реквізити</a></li>
            <li><a href="#tabExportContr">Додаткові реквізити экспортного контракту</a></li>
            <li><a href="#tabImportContr">Додаткові реквізити імпортного контракту</a></li>
            <li><a href="#tabCreditContr">Додаткові реквізити кредитного контракту</a></li>
            <li><a href="#tabOthersContr">Додаткові реквізити контракту</a></li>
            <li><a href="#tabCreditContrExportReq">Реквізити заявки для НБУ</a></li>
            <li><a href="#tabCreditExportFile">Реєстрація в НБУ</a></li>
        </ul>
        <div id="tabMainContr">
            <asp:Panel runat="server" ID="pnMainReq" GroupingText="Базові реквізити">
                <table>
                    <tr>
                        <td>
                            Тип контракту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddContrType" DataSourceID="dsContrType" DataTextField="CONTR_TYPE_NAME"
                                DataValueField="CONTR_TYPE_ID" ToolTip="Вкажіть тип контракту" class="required">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Статус контракту
                        </td>
                        <td>
                            <span id="lbStatus" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Номер контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbConractNum" maxlength="60" class="required" title="Вкажіть номер контракту" />
                        </td>
                        <td>
                            Внутрішній код контракту
                        </td>
                        <td>
                            <span id="lbConractId" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Дата відкриття
                        </td>
                        <td class="field">
                            <input type="text" id="tbDateOpen" name="tbDateOpen" maxlength="10" class="required"
                                title="Вкажіть дату відкриття контракту" style="text-align: center; width: 80px" />
                        </td>
                        <td>
                            Дата закінчення
                        </td>
                        <td class="field">
                            <input type="text" id="tbDateClose" title="Вкажіть дату закінчення контракту" style="text-align: center;
                                width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Коментар
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
                        <td>
                            Валюта контракту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddKv" DataSourceID="dsKv" DataTextField="NAME"
                                DataValueField="KV" ToolTip="Вкажіть валюту контракту" class="required">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Сума контракту
                        </td>
                        <td class="field">
                            <Bars:NumericEdit runat="server" ID="tbSum" ToolTip="Вкажіть суму контракту"></Bars:NumericEdit>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnClient" GroupingText="Контрагент">
                <table>
                    <tr>
                        <td>
                            ОКПО контрагента
                        </td>
                        <td class="field">
                            <input type="text" id="tbClientOkpo" name="tbClientOkpo" maxlength="10" class="required"
                                title="Вкажіть ОКПО контрагента" />
                            <input type="button" id="btSelClientByOkpo" value="..." title="Вибрати з довідника з фільтром по ОКПО"
                                style="height: 21px; vertical-align: bottom" />
                        </td>
                        <td>
                            Внутрішній код(rnk)
                        </td>
                        <td class="field">
                            <input type="text" id="tbClientRnk" name="tbClientRnk" class="required" title="Вкажіть внутрішній код контрагента" />
                            <input type="button" id="btSelClient" value="..." title="Вибрати з довідника" style="height: 21px;
                                vertical-align: bottom" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Найменування
                        </td>
                        <td>
                            <span id="lbNmk" class="roValue"></span>
                        </td>
                        <td>
                            Найменування (коротке)
                        </td>
                        <td>
                            <span id="lbNmkK" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Номер договору
                        </td>
                        <td>
                            <span id="lbNd" class="roValue"></span>
                        </td>
                        <td>
                            Вид економічної діяльності
                        </td>
                        <td>
                            <span id="lbVedName" class="roValue"></span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnBenef" GroupingText="Бенефіціар (клієнт-нерезидент)">
                <table>
                    <tr>
                        <td>
                            Код бенефіціара
                        </td>
                        <td class="field">
                            <input type="text" id="tbBenefId" name="tbBenefId" class="required" title="Вкажіть код бенефіціара" />
                            <input type="button" id="btSelectBenef" value="..." title="Вибрати з довідника" style="height: 20px;
                                vertical-align: bottom" />
                        </td>
                        <td>
                            Найменування
                        </td>
                        <td>
                            <span id="lbBenefName" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Країна
                        </td>
                        <td>
                            <span id="lbCountryName" class="roValue"></span>
                        </td>
                        <td>
                            Адреса
                        </td>
                        <td class="field">
                            <span id="lbBenefAddress" class="roValue"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Коментар
                        </td>
                        <td colspan="3">
                            <span id="lbBenefComment" class="roValue"></span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div id="tabExportContr">
        </div>
        <div id="tabImportContr">
        </div>
        <div id="tabCreditContr">
            <asp:Panel runat="server" ID="pnPercent" GroupingText="Процентні ставки">
                <table>
                    <tr>
                        <td>
                            Максимальна процентна ставка НБУ
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdNbuPercent" name="tbCrdNbuPercent" title="Вкажіть максимальну процентна ставку НБУ"
                                class="numeric" />
                        </td>
                        <td style="visibility:hidden">
                            Процентна ставка (по замовчуванню)
                        </td>
                        <td class="field" style="visibility:hidden">
                            <input type="text" id="tbCrdDefPercent" name="tbCrdDefPercent" title="Вкажіть процентну ставку"
                                class="numeric" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Тип макс. проц. ставки НБУ
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditPercent" DataSourceID="dsCreditPercent"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть максимальну процентну ставку НБУ">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Ліміт заборгованості
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
                        <td>
                            Тип кредитора
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditorType" DataSourceID="dsCreditorType"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть тип кредитора">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Тип кредиту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditType" DataSourceID="dsCreditType" DataTextField="NAME"
                                DataValueField="ID" ToolTip="Вкажіть тип кредиту" Width="300px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Періодичність погашення
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditPeriod" DataSourceID="dsCreditPeriod"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть періодичність погашення">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Строковість кредиту
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditTerm" DataSourceID="dsCreditTerm" DataTextField="NAME"
                                DataValueField="ID" ToolTip="Вкажіть cтроковість кредиту">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Метод нарахування відсотків
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditMethod" DataSourceID="dsCreditMethod"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть метод нарахування відсотків">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Можливість дострокового погашення
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditPrepay" DataSourceID="dsCreditPrepay"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть можливість дострокового погашення">
                            </asp:DropDownList>
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
                        <td>
                            Назва договору
                        </td>
                        <td colspan="3" class="field">
                            <input type="text" id="tbCrdName" maxlength="64" style="width: 400px" title="Вкажіть назву договору" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Реєстраційний серверний номер
                        </td>
                        <td class="field" colspan="3">
                            <input type="text" id="tbCrdDocKey" name="tbCrdDocKey" class="numeric" title="Вкажіть реєстраційний серверний номер (заповнюється при змінах)" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Дата реєстрації контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdAgreeDate" name="tbCrdAgreeDate" maxlength="10" title="Вкажіть дату реєстрації контракту (заповнюється при змінах)"
                                style="text-align: center; width: 80px" />
                        </td>
                        <td>
                            Номер реєстрації контракту
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
                        <td style="vertical-align: top">
                            Додаткові угоди
                        </td>
                        <td colspan="3" class="field">
                            <textarea rows="2" cols="84" id="tbCrdAddAgree" title="Вкажіть додаткові угоди"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Додаткова інформація про макс. ставку НБУ
                        </td>
                        <td class="field" colspan="3">
                            <input type="text" id="tbPencentNbuInfo" maxlength="128" style="width: 300px" title="Вкажіть додаткову інформацію про максимальну процентну ставку НБУ" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Кінцева дата індивідуального строку дії реєстрації контракту
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdIndEndDate" name="tbCrdIndEndDate" maxlength="10" title="Вкажіть кінцеву дату індивідуального строку дії реєстрації контракту"
                                style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top">
                            Інформація про короткостроковий контракт
                            <br /><span style="font-style:italic">(заповнюється при перереєстрації з<br />короткострокового у довгостроковий)</span>
                        </td>
                        <td class="field">
                            <textarea rows="2" cols="84" id="tbCrdParentChData" title="Вкажіть інформація про короткостроковий контракт (заповнюється при перереєстрації з короткострокового у довгостроковий)"></textarea>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Строк дії реєстрації контракту
                            <br /><span style="font-style:italic"> (заповнюється при продовженні строку)</span>
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
                        <td>
                            Тип кредитної операції
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCreditOperType" DataSourceID="dsCreditOperType"
                                DataTextField="NAME" DataValueField="ID" ToolTip="Вкажіть тип кредитної операції">
                            </asp:DropDownList>
                        </td>
                        <td>
                            Дата факт. здійснення операції
                        </td>
                        <td>
                            <input type="text" id="tbCrdOperDate" name="tbCrdOperDate" maxlength="10" title="Вкажіть дату факт. здійснення операції"
                                style="text-align: center; width: 80px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Маржа плаваючої ставки за основною сумою боргу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdMargin" class="numeric" title="Вкажіть маржу плаваючої ставки" />
                        </td>
                        <td>
                            Номер траншу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshNum" maxlength="32" title="Вкажіть номер траншу" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Обсяг траншу
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshSum" class="numeric" title="Вкажіть обсяг траншу" />
                        </td>
                        <td>
                            Валюта траншу
                        </td>
                        <td class="field">
                            <asp:DropDownList runat="server" ID="ddCrdTranshCurr" DataSourceID="dsKv" DataTextField="NAME"
                                DataValueField="KV" ToolTip="Вкажіть валюту траншу">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Процентна ставку за траншем
                        </td>
                        <td class="field">
                            <input type="text" id="tbCrdTranshRatName" title="Вкажіть процентну ставку за траншем" />
                        </td>
                        <td>
                            Фактичний розмір ставки за траншем
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
                            <td>
                                Реєстраційний серверний номер
                            </td>
                            <td class="field">
                                <input type="text" id="tbApproveCrdDocKey" name="tbApproveCrdDocKey" class="numeric"
                                    title="Вкажіть реєстраційний серверний номер (заповнюється при змінах)" />
                            </td>
                        </tr>
                        <tr class="trApproveNew">
                            <td>
                                Дата реєстрації контракту
                            </td>
                            <td class="field">
                                <input type="text" id="tbApproveCrdDate" name="tbApproveCrdDate" style="text-align: center;
                                    width: 80px" maxlength="10" title="Вкажіть дату реєстрації контракту (заповнюється при змінах)" />
                            </td>
                        </tr>
                        <tr class="trApproveNew">
                            <td>
                                Номер реєстрації контракту
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
                                <td>
                                    Повідомлення про договір
                                </td>
                                <td class="field">
                                    <asp:FileUpload ID="fuAgreeDoc" runat="server" Width="300px" ToolTip="Вкажіть файл з повідомленням про договір" />
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
                                                <td>
                                                    Лист-обгрунтування
                                                </td>
                                                <td class="field">
                                                    <asp:FileUpload ID="fuLetterDoc" runat="server" Width="300px" ToolTip="Вкажіть файл з листом обгрунтування" />
                                                    <asp:HiddenField runat="server" ID="hCreditTerm" />
                                                </td>
                                            </tr>
                                            <tr id="trOldBankMfo">
                                                <td>
                                                    МФО попереднього уповноваженого банку
                                                </td>
                                                <td class="field">
                                                    <asp:TextBox runat="server" ID="tbOldBankMfo" ToolTip="Вкажіть попереднє МФО уповноваженого банку"
                                                        CssClass="numeric" MaxLength="6"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr id="trOldOblCode">
                                                <td>
                                                    Код області попереднього уповноваженого банку
                                                </td>
                                                <td class="field">
                                                    <asp:TextBox runat="server" ID="tbOldOblCode" ToolTip="Вкажіть код області за місцезнаходженням попереднього уповноваженого банку"
                                                        CssClass="numeric"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Код попереднього обслуговуючого банку або його підрозділу
                                                </td>
                                                <td class="field">
                                                    <asp:TextBox runat="server" ID="tbOldBankCode" ToolTip="Вкажіть код попереднього обслуговуючого банку або його підрозділу"
                                                        MaxLength="20"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Код області попереднього обслуговуючого банку
                                                </td>
                                                <td class="field">
                                                    <asp:TextBox runat="server" ID="tbOldBankOblCode" ToolTip="Вкажіть код області попереднього обслуговуючого банку"
                                                        CssClass="numeric" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    <asp:Button ID="btFormFile" Text="Сформувати файл" Width="200px" OnClick="btFormFile_Click"
                        runat="server" />
                </fieldset>
            </div>
        </div>
    </div>
    <div style="white-space: nowrap; margin-top: 10px">
        <div style="float: left">
            <input type="button" id="btRefresh" value="Перечитати" /></div>
        <div style="float: right">
            <input type="button" id="btSave" value="Зберегти" />
            <input type="button" id="btCancel" value="Відмінити" />
        </div>
    </div>
    <div class="error" style="float: left; clear: left">
    </div>
</asp:Content>
