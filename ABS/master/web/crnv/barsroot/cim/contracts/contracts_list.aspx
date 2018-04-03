<%@ Page Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true"
    CodeFile="contracts_list.aspx.cs" Inherits="cim_contracts_other_contracts_list"
    Title="Список контрактів" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:Panel runat="server" ID="pnFilter" GroupingText="Фільтр по контрактам">
        <Bars:BarsSqlDataSourceEx ID="dsContrType" runat="server" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsSqlDataSourceEx ID="dsContrVal" runat="server" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsSqlDataSourceEx ID="dsContrStatus" runat="server" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <table>
            <tr>
                <td>
                    <span>Тип:</span>
                </td>
                <td>
                    <span>Валюта:</span>
                </td>
                <td>
                    <span>Статус:</span>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="ddContrType" runat="server" AutoPostBack="true" DataSourceID="dsContrType"
                        DataMember="DefaultView" DataValueField="contr_type_id" DataTextField="contr_type_name">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddContrVal" runat="server" AutoPostBack="true" DataSourceID="dsContrVal"
                        DataValueField="kv" DataTextField="name">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList ID="ddContrStatus" runat="server" AutoPostBack="true" DataSourceID="dsContrStatus"
                        DataValueField="status_id" DataTextField="status_name">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel runat="server" ID="pnActions" GroupingText="Дії на виділеним рядком">
        <table>
            <tr>
                <td>
                    <input type="button" value="Створити" style="width: 100px" title="Створити новий контракт"
                        onclick="curr_module.AddContract()" />
                    <input type="button" value="Картка" style="width: 100px" title="Переглянути картку контракту"
                        onclick="curr_module.ShowContractCard()" />
                    <input type="button" value="Стан" style="width: 100px" disabled="disabled" title="Переглянути стан контракту"
                        onclick="curr_module.ShowContractState()" />
                    <input type="button" value="Клієнт" style="width: 100px" title="Переглянути картку клієнта"
                        onclick="curr_module.ShowClientCard()" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:ObjectDataSource ID="odsVCimContracts" runat="server" SelectMethod="SelectContracts"
        TypeName="cim.VCimAllContracts" SortParameterName="SortExpression" EnablePaging="True">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddContrType" DbType="Decimal" PropertyName="SelectedValue"
                Name="contr_type" />
            <asp:ControlParameter ControlID="ddContrVal" DbType="Decimal" PropertyName="SelectedValue"
                Name="contr_kv" />
            <asp:ControlParameter ControlID="ddContrStatus" DbType="Decimal" PropertyName="SelectedValue"
                Name="contr_status" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div style="overflow: auto; padding: 10px 0 10px 0">
        <Bars:BarsGridViewEx ID="gvVCimContracts" runat="server" AutoGenerateColumns="False" ShowExportExcelButton="true"
            DataSourceID="odsVCimContracts" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
            AutoSelectFirstRow="true" AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow"
            DataKeyNames="CONTR_ID" ShowPageSizeBox="true" OnRowDataBound="gvVCimContracts_RowDataBound">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton runat="server" CausesValidation="false" ID="imgDelete" Width="16px"
                            ToolTip='<%# ((Convert.ToInt32(Eval("STATUS_ID")) != 1)?("Закрити/видалити контракт"):("Відновити закритий контракт")) %>'
                            OnClientClick='<%# "curr_module.CloseContract(" + Eval("CONTR_ID") + "," + Eval("STATUS_ID") + ");return false;" %>'
                            Visible='<%# (Convert.ToInt32(Eval("STATUS_ID")) == 10)?(false):(true) %>' ImageUrl='<%# "/Common/Images/default/16/" + ((Convert.ToInt32(Eval("STATUS_ID")) != 1)?("cancel_blue.png"):("document_ok.png")) %>'>
                        </asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CONTR_ID" HeaderText="Ід. контракту" SortExpression="CONTR_ID">
                </asp:BoundField>
                <asp:BoundField DataField="CONTR_TYPE_NAME" HeaderText="Тип контракту" SortExpression="CONTR_TYPE_NAME">
                </asp:BoundField>
                <asp:BoundField DataField="STATUS_NAME" HeaderText="Статус" SortExpression="STATUS_NAME">
                </asp:BoundField>
                <asp:BoundField DataField="NUM" HeaderText="№ контракту" SortExpression="NUM"></asp:BoundField>
                <asp:BoundField DataField="RNK" HeaderText="РНК клієнта" SortExpression="RNK"></asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="Ід. код клієнта" SortExpression="OKPO">
                </asp:BoundField>
                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" SortExpression="NMK">
                </asp:BoundField>
                <asp:BoundField DataField="OPEN_DATE" HeaderText="Дата відкриття" SortExpression="OPEN_DATE"
                    DataFormatString="{0:dd.MM.yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CLOSE_DATE" HeaderText="Дата закінчення" SortExpression="CLOSE_DATE"
                    DataFormatString="{0:dd.MM.yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="BENEF_NAME" HeaderText="Назва контрагента" SortExpression="BENEF_NAME">
                </asp:BoundField>
                <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Країна контрагента" SortExpression="COUNTRY_NAME">
                </asp:BoundField>
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" SortExpression="COMMENTS">
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div id="dialogContractInfo" class="contractInfoClass" style="display: none; text-align: left">
        <table cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <span id="lbContractId" style="font-style: italic;"></span>
                    <br />
                    <span id="lbContractType" style="font-style: italic;"></span>
                    <br />
                    <span id="lbContractNum" style="font-style: italic;"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <a id="lnCreateNew">Створити новий контракт</a><br />
                    <a id="lnShowContractCard">Картка контракту</a><br />
                    <a id="lnShowContractState">Стан контракту</a><br />
                    <a id="lnShowClientCard">Картка клієнта</a><br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
