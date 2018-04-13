<%@ Page Title="Індивідуальні ліцензії Мінекономіки" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="licenses.aspx.cs" Inherits="cim_contracts_licenses" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">

    <bars:BarsSqlDataSourceEx runat="server" ID="dsLicenseType" ProviderName="barsroot.core"
        SelectCommand="select type_id,type_name from cim_license_type">
    </bars:BarsSqlDataSourceEx>
    <asp:ObjectDataSource ID="odsVCimLicenses" runat="server" SelectMethod="SelectLicense"
        TypeName="cim.VCimLicense" SortParameterName="SortExpression" EnablePaging="True">
        <SelectParameters>
            <asp:QueryStringParameter Name="okpo" DbType="String" QueryStringField="taxcode" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <table>
        <tr>
            <td>
                <input id="btAddLicense" type="button" value="Створити" style="width: 100px" title="Створити нову ліцензію"
                    onclick="curr_module.EditLicense($(this), true)" />
            </td>
        </tr>
    </table>
    <asp:Panel runat="server" ID="pnLicenses" GroupingText="Ліцензії">
        <div style="overflow: auto">
            <bars:BarsGridViewEx ID="gvCimLicenses" runat="server" AutoGenerateColumns="False"
                DataSourceID="odsVCimLicenses"
                ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="NUM"
                ShowPageSizeBox="true" OnRowDataBound="gvCimLicenses_RowDataBound">
                <Columns>
                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <img id="imgDelete" runat="server" src="/Common/Images/default/16/cancel_blue.png" alt="" title="Видалити" onclick="curr_module.DeleteLicense($(this))" />
                        </ItemTemplate>
                        <ItemStyle Width="18px" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <img id="imgEdit" runat="server" src="/Common/Images/default/16/document.png" alt="" title="Редагувати" onclick="curr_module.EditLicense($(this))" />
                        </ItemTemplate>
                        <ItemStyle Width="18px" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <img id="imgLink" runat="server" src="/barsroot/cim/style/img/row_check_p.png" alt="" title="Прив'язані платежі" onclick="curr_module.LinkLicense($(this))" />
                        </ItemTemplate>
                        <ItemStyle Width="18px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="NUM" HeaderText="№ ліцензії" SortExpression="NUM">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="type_txt" HeaderText="Тип" SortExpression="type_txt"></asp:BoundField>
                    <asp:BoundField DataField="kv" HeaderText="Валюта" SortExpression="kv">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="s" HeaderText="Сума" SortExpression="s" DataFormatString="{0:F}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="s_doc" HeaderText="Сума пов’язаних платежів" SortExpression="s_doc" DataFormatString="{0:F}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="begin_date" HeaderText="Дата ліцензії" SortExpression="begin_date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="end_date" HeaderText="Дата закінчення ліцензії" SortExpression="end_date" DataFormatString="{0:dd/MM/yyyy}">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="comments" HeaderText="Примітка" SortExpression="comments"></asp:BoundField>
                </Columns>
            </bars:BarsGridViewEx>
        </div>
    </asp:Panel>
    <div id="dialogLicenseInfo" style="display: none; text-align: left">
        <table>
            <tr>
                <td>№ ліцензії
                </td>
                <td class="field">
                    <input type="text" id="tbLicenseNum" name="tbLicenseNum" title="Вкажіть № ліцензії" />
                </td>
            </tr>
            <tr>
                <td>Тип
                </td>
                <td class="field">
                    <asp:DropDownList runat="server" ID="ddLicenseType" DataSourceID="dsLicenseType" DataTextField="TYPE_NAME"
                        DataValueField="TYPE_ID" ToolTip="Вкажіть тип ліцензії">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>Валюта
                </td>
                <td class="field">
                    <input type="text" id="tbLicenseKv" title="Вкажіть валюту" class="numeric" maxlength="3" style="width: 25px" />
                </td>
            </tr>
            <tr>
                <td>Сума
                </td>
                <td class="field">
                    <input type="text" id="tbLicenseSum" title="Вкажіть сумму" class="numeric" />
                </td>
            </tr>
            <tr>
                <td>Дата ліцензії
                </td>
                <td class="field" style="white-space: nowrap">
                    <input type="text" id="tbBeginDate" class="datepick" name="tbBeginDate" title="Вкажіть дату ліцензії"
                        style="text-align: center; width: 80px" />
                </td>
            </tr>
            <tr>
                <td>Дата закінчення ліцензії
                </td>
                <td class="field" style="white-space: nowrap">
                    <input type="text" id="tbEndDate" class="datepick" name="tbEndDate" title="Вкажіть дату закінчення ліцензії"
                        style="text-align: center; width: 80px" />
                </td>
            </tr>
            <tr>
                <td>Коментар
                </td>
                <td>
                    <input type="text" id="tbLicenseComment" style="width: 300px" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="dvLicenseErr" style="float: left; color: Red;">
                    </div>
                </td>
            </tr>
        </table>
    </div>
     <div style="float: right; padding-top: 10px" runat="server" id="dvBack">
        <button id="btCancel" type="button" class="btn-back-ico" onclick="curr_module.GoBack();">Повернутися</button>
    </div>
</asp:Content>

