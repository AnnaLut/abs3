<%@ Page Title="Повідомлення про заборгованість" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="debt_notice.aspx.cs" Inherits="cim_tools_debt_notice" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>


<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:Panel runat="server" ID="pnBranch" GroupingText="Дані про установу">
        <table>
            <tr>
                <td style="white-space: nowrap">Назва установи
                </td>
                <td style="white-space: nowrap">
                    <asp:Label runat="server" Font-Bold="true" ID="lbBranchName"></asp:Label>
                </td>
                <td align="right" style="width: 100%;">
                    <asp:Button runat="server" ID="btGenFile" Text="Сформувати файл" OnClick="btGenFile_Click" />
                </td>
            </tr>
            <tr>
                <td style="white-space: nowrap">Адреса установи
                </td>
                <td style="white-space: nowrap">
                    <asp:Label runat="server" Font-Bold="true" ID="lbBranchAdr"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Label runat="server" ID="lbError" ForeColor="Red"></asp:Label>
    <asp:Panel runat="server" ID="pnFiler" GroupingText="Список заборогованостей">
        <table>
            <tr>
                <td style="vertical-align: middle">
                    <input type="button" id="btAddDebt" runat="server" style="margin: 5px 5px 5px 10px" onclick="curr_module.AddDebt($(this), true)" value="Добавити" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btApprove" Text="Підтвердити виділені" OnClick="btApprove_OnClick"/>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbSend" Text="Показати відправлені" AutoPostBack="true" OnCheckedChanged="cbSend_CheckedChanged" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbSubBranch" Text="Показати підпорядковані" AutoPostBack="true" OnCheckedChanged="cbSend_CheckedChanged" />
                </td>
                <td></td>
            </tr>
        </table>
        <bars:BarsSqlDataSourceEx runat="server" ID="dsDebtNotice" ProviderName="barsroot.core">
        </bars:BarsSqlDataSourceEx>
        <bars:BarsGridViewEx ID="gvDebtNotice" runat="server" AutoGenerateColumns="False"
            DataSourceID="dsDebtNotice"
            ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True" DataKeyNames="ID"
            AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow"
            ShowPageSizeBox="true" OnRowDataBound="gvDebtNotice_RowDataBound">
            <Columns>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <img src="/Common/Images/default/16/document.png" alt="Редагувати" runat="server" onclick="curr_module.EditDebt($(this))" />
                    </ItemTemplate>
                    <ItemStyle Width="18px" />
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <img src="/Common/Images/default/16/cancel_blue.png" alt="Видалити" onclick="curr_module.DeleteDebt($(this))" />
                    </ItemTemplate>
                    <ItemStyle Width="18px" />
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <HeaderTemplate>
                        <span>Підтвер.</span> 
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ToolTip='<%# Eval("ID") %>'  CssClass='<%# (Convert.ToString(Eval("APPROVE")) == "1") ? (""):("cssNeedApprive") %>' Checked='<%# Convert.ToString(Eval("APPROVE")) == "1" %>' Enabled='<%# Convert.ToString(Eval("APPROVE")) != "1" %>' />
                    </ItemTemplate>
                    <ItemStyle Width="18px" />
                </asp:TemplateField>
                <asp:BoundField DataField="BRANCH" HeaderText="Код установи" SortExpression="BRANCH"></asp:BoundField>
                <asp:BoundField DataField="NAME_BANK" HeaderText="Назва установи" SortExpression="NAME_BANK"></asp:BoundField>
                <asp:BoundField DataField="ADR_BANK" HeaderText="Адреса установи" SortExpression="ADR_BANK"></asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="Код ОКПО" SortExpression="OKPO"></asp:BoundField>
                <asp:BoundField DataField="NAME_KL" HeaderText="Найменування клієнта" SortExpression="NAME_KL"></asp:BoundField>
                <asp:BoundField DataField="ADR_KL" HeaderText="Адрес клієнта " SortExpression="ADR_KL"></asp:BoundField>
                <asp:BoundField DataField="NOM_DOG" HeaderText="Номер договору" SortExpression="NOM_DOG"></asp:BoundField>
                <asp:BoundField DataField="DATE_DOG" HeaderText="Дата договору" SortExpression="DATE_DOG"></asp:BoundField>
                <asp:BoundField DataField="DATE_PLAT" HeaderText="Дата платежу" SortExpression="DATE_PLAT"></asp:BoundField>
                <asp:BoundField DataField="FILE_NAME" HeaderText="Файл" SortExpression="FILE_NAME"></asp:BoundField>
            </Columns>
        </bars:BarsGridViewEx>
    </asp:Panel>

    <div id="dialogDebtInfo" style="display: none; text-align: left">
        <asp:Panel runat="server" ID="pnBranchInfo" GroupingText="Уповноважений банк">
            <table>
                <tr>
                    <td>Назва установи
                    </td>
                    <td class="field">
                        <span id="lbNameBank" class="roValue"></span>
                    </td>
                </tr>
                <tr>
                    <td>Адреса установи
                    </td>
                    <td class="field">
                        <span id="lbAdrBank" class="roValue"></span>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnClient" GroupingText="Клієнт">
            <table>
                <tr>
                    <td>ОКПО клієнта
                    </td>
                    <td class="field">
                        <input type="text" id="tbClientOkpo" name="tbClientOkpo" maxlength="10" class="required numeric"
                            title="Вкажіть ОКПО контрагента" />
                        <input type="button" id="btSelClientByOkpo" value="..." title="Вибрати з довідника з фільтром по ОКПО"
                            style="height: 21px; vertical-align: bottom" />
                    </td>
                    <td>Внутрішній код(rnk)
                    </td>
                    <td class="field">
                        <input type="text" id="tbClientRnk" name="tbClientRnk" class="required" title="Вкажіть внутрішній код контрагента" />
                        <input type="button" id="btSelClient" value="..." title="Вибрати з довідника" style="height: 21px; vertical-align: bottom" />
                    </td>
                </tr>
                <tr>
                    <td>Найменування
                    </td>
                    <td>
                        <span id="lbClientName" class="roValue"></span>
                    </td>
                    <td>Адреса
                    </td>
                    <td>
                        <span id="lbClientAdr" class="roValue"></span>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnNum" GroupingText="Договір">
            <table>
                <tr>
                    <td>Номер договору
                    </td>
                    <td>
                        <input type="text" id="tbContrNum" name="tbContrNum" title="Вкажіть номер договору" />
                    </td>
                </tr>
                <tr>
                    <td>Дата договору
                    </td>
                    <td class="field" style="white-space: nowrap">
                        <input type="text" id="tbContrDate" class="datepick" name="tbContrDate" title="Вкажіть дату договору"
                            style="text-align: center; width: 80px" />
                    </td>
                </tr>
                <tr>
                    <td>Дата платежу/МД
                    </td>
                    <td class="field" style="white-space: nowrap">
                        <input type="text" id="tbPayDate" class="datepick" name="tbPayDate" title="Вкажіть дату платежу/МД"
                            style="text-align: center; width: 80px" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
</asp:Content>

