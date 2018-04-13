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
        <bars:BarsSqlDataSourceEx ID="dsContrType" runat="server" ProviderName="barsroot.core">
        </bars:BarsSqlDataSourceEx>
        <bars:BarsSqlDataSourceEx ID="dsContrVal" runat="server" ProviderName="barsroot.core">
        </bars:BarsSqlDataSourceEx>
        <bars:BarsSqlDataSourceEx ID="dsContrStatus" runat="server" ProviderName="barsroot.core">
        </bars:BarsSqlDataSourceEx>
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
                <td>
                    <asp:CheckBox runat="server" ID="cbFilterByOwner" Text="Тільки свої" ToolTip="Показати лише закріплені за даним користувачем контракти" AutoPostBack="true" />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbFilterByOkpo" Text="Тільки контракти даного клієнта" ToolTip="Показати лише контракти даного клієнта" Checked="true" Visible="false" AutoPostBack="true" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <fieldset>
        <legend>Дії над виділеним рядком</legend>
        <div>
            <table>
                <tr runat="server" id="trActions">
                    <td>
                        <button type="button" class="btn-add-ico" style="width: 100px" title="Створити новий контракт"
                            onclick="curr_module.AddContract()" >Створити</button>
                    </td>
                    <td>
                        <input type="button" value="Картка" style="width: 100px" title="Переглянути картку контракту"
                            onclick="curr_module.ShowContractCard()" />
                    </td>
                    <td>
                        <input type="button" value="Стан" style="width: 100px" title="Переглянути стан контракту"
                            onclick="curr_module.ShowContractState()" />
                    </td>
                    <td>
                        <input type="button" value="Клієнт" style="width: 100px" title="Переглянути картку клієнта"
                            onclick="curr_module.ShowClientCard()" />
                    </td>
                    <td>
                        <input type="button" value="Санкції" style="width: 100px" title="Перевірка санкцій по контракту"
                            onclick="curr_module.CheckSanctions()" />
                    </td>
                    <td>
                        <input type="button" value="Ліцензії" style="width: 100px" title="Перегляд ліцензій по контракту"
                            onclick="curr_module.ShowLicenses()" />
                    </td>
                </tr>
                <tr runat="server" id="trSelect" visible="false">
                    <td>
                        <input type="button" value="Вибрати контракт" title="Вибрати контракт"
                            onclick="curr_module.ReturnClientId()" />
                    </td>
                    <td>
                        <input type="button" value="Стан" style="width: 100px" title="Переглянути стан контракту"
                            onclick="curr_module.ShowContractState()" />
                    </td>
                    <td>
                        <input type="button" value="Санкції" style="width: 100px" title="Перевірка санкцій по контракту"
                            onclick="curr_module.CheckSanctions()" />
                    </td>
                </tr>
                    
            </table>
        </div>
    </fieldset>
    <asp:ObjectDataSource ID="odsVCimContracts" runat="server" SelectMethod="SelectContracts"
        TypeName="cim.VCimAllContracts" SortParameterName="SortExpression" EnablePaging="True">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddContrType" Type="Decimal" PropertyName="SelectedValue"
                Name="contr_type" />
            <asp:ControlParameter ControlID="ddContrVal" Type="Decimal" PropertyName="SelectedValue"
                Name="contr_kv" />
            <asp:ControlParameter ControlID="ddContrStatus" Type="Decimal" PropertyName="SelectedValue"
                Name="contr_status" />
            <asp:ControlParameter ControlID="cbFilterByOwner" Type="Boolean" PropertyName="Checked"
                Name="owner_flag" />
            <asp:ControlParameter ControlID="cbFilterByOkpo" Type="Boolean" PropertyName="Checked"
                Name="client_flag" />
            <asp:QueryStringParameter Name="direct" DbType="Decimal" QueryStringField="direct" />
            <asp:QueryStringParameter Name="okpo" DbType="String" QueryStringField="okpo" />
            <asp:QueryStringParameter Name="payflag" DbType="String" QueryStringField="payflag" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div style="overflow: scroll; padding: 10px 0 10px 0;">
        <bars:BarsGridViewEx ID="gvVCimContracts" runat="server" AutoGenerateColumns="False"
            ShowExportExcelButton="true" DataSourceID="odsVCimContracts" CaptionType="Cool" PageSize="20"
            CaptionAlign="Left" AllowSorting="True" AutoSelectFirstRow="true" AllowPaging="True"
            ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="" ShowFilter="True"
            ShowPageSizeBox="true" OnRowDataBound="gvVCimContracts_RowDataBound">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton runat="server" CausesValidation="false" ID="imgDelete" Width="16px"
                            ToolTip='<%# ((Convert.ToInt32(Eval("STATUS_ID")) != 1)?("Закрити контракт"):("Видалити контракт")) %>'
                            OnClientClick='<%# "curr_module.CloseContract(" + Eval("CONTR_ID") + "," + Eval("STATUS_ID") + ");return false;" %>'
                            Visible='<%# (Convert.ToInt32(Eval("STATUS_ID")) == 10 || (Convert.ToInt32(Eval("STATUS_ID")) == 1 && Convert.ToInt32(Eval("CAN_DELETE")) == 0))?(false):(true) %>' ImageUrl="/Common/Images/default/16/cancel_blue.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton runat="server" CausesValidation="false" ID="imgResurrect" Width="16px"
                            ToolTip="Відновити закритий контракт"
                            OnClientClick='<%# "curr_module.ResurrectContract(" + Eval("CONTR_ID") + ");return false;" %>'
                            Visible='<%# (Convert.ToInt32(Eval("STATUS_ID")) != 1)?(false):(true) %>' ImageUrl="/Common/Images/default/16/document_ok.png"></asp:ImageButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CONTR_TYPE_NAME" HeaderText="Тип контракту" SortExpression="CONTR_TYPE_NAME">
                    <ItemStyle />
                </asp:BoundField>
                <asp:BoundField DataField="STATUS_NAME" HeaderText="Статус" SortExpression="STATUS_NAME"></asp:BoundField>
                <asp:BoundField DataField="NUM" HeaderText="№ контракту" SortExpression="NUM"></asp:BoundField>
                <asp:BoundField DataField="SUBNUM" HeaderText="Дод. №" SortExpression="SUBNUM"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="S" HeaderText="Сума" SortExpression="S" DataFormatString="{0:N}">
                    <ItemStyle HorizontalAlign="Right" Font-Bold="true"  />
                </asp:BoundField>
                <asp:BoundField DataField="OPEN_DATE" HeaderText="Дата відкриття" SortExpression="OPEN_DATE"
                    DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CLOSE_DATE" HeaderText="Дата закінчення" SortExpression="CLOSE_DATE"
                    DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="Ід. код клієнта" SortExpression="OKPO"></asp:BoundField>
                <asp:BoundField DataField="NMK" HeaderText="Назва клієнта" SortExpression="NMK"></asp:BoundField>
                <asp:BoundField DataField="BENEF_NAME" HeaderText="Назва контрагента" SortExpression="BENEF_NAME"></asp:BoundField>
                <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Країна контрагента" SortExpression="COUNTRY_NAME"></asp:BoundField>
                <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" SortExpression="COMMENTS"></asp:BoundField>
                <asp:BoundField DataField="RNK" HeaderText="РНК клієнта" SortExpression="RNK"></asp:BoundField>
                <asp:BoundField DataField="CONTR_ID" HeaderText="Ід. контракту" SortExpression="CONTR_ID"></asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
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
                    <a id="lnCheckSanctions">Санкції по контракту</a><br />
                </td>
            </tr>
        </table>
    </div>

    <table id="jtab"></table>
    <div id="jpager"></div>
</asp:Content>
