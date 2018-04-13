<%@ Page Title="Довідник бенефіціарів" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="beneficiaries.aspx.cs" Inherits="cim_contracts_beneficiaries" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">

    <bars:BarsSqlDataSourceEx runat="server" ID="dsCountries" ProviderName="barsroot.core"
        SelectCommand="select country, country || ' - '|| name name from country union all select null, null from dual order by country">
    </bars:BarsSqlDataSourceEx>

    <asp:ObjectDataSource ID="odsVCimBeneficiaries" runat="server" SelectMethod="Select"
        TypeName="cim.VCimBeneficiaries" SortParameterName="SortExpression" EnablePaging="True"></asp:ObjectDataSource>
    <div style="overflow: auto; padding: 10px 0 10px 0">
        <div runat="server" id="divMsg" style="padding-left: 10px; color: red">
        </div>
        <asp:Panel runat="server" ID="pbActions" GroupingText="Дії">
            <div style="padding-left: 10px;">
                <asp:Button runat="server" ID="btAddNew" Text="Добавити запис" OnClick="btAddNew_Click" />
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="Panel1" GroupingText="Перелік бенефіціарів">
            <bars:BarsGridViewEx ID="gvVCimBeneficiaries" runat="server" AutoGenerateColumns="false" ShowFilter="true"
                DataSourceID="odsVCimBeneficiaries" CaptionType="Cool" CaptionAlign="Left" AllowSorting="true" AutoSelectFirstRow="false"
                AllowPaging="True" ShowFooter="True" JavascriptSelectionType="ServerSelect" DataKeyNames="BENEF_ID, DELETE_DATE"
                ShowPageSizeBox="false" OnRowCommand="gvVCimBeneficiaries_RowCommand" OnRowDeleting="gvVCimBeneficiaries_RowDeleting" OnRowDataBound="gvVCimBeneficiaries_RowDataBound">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" ID="imgEdit" Width="16px" ToolTip="Редагувати запис"
                                CommandName="Select" CausesValidation="false" CommandArgument='<%# Eval("BENEF_ID") %>' Visible='<%# Eval("DELETE_DATE") == null %>'
                                ImageUrl="/Common/Images/default/16/open_blue.png"></asp:ImageButton>
                        </ItemTemplate>
                        <ItemStyle Width="18px" />
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton runat="server" CausesValidation="false" ID="imgDelete" Width="16px"
                                ToolTip="Видалити запис" CommandName="Delete" CommandArgument='<%# Eval("BENEF_ID") %>'
                                ImageUrl="/Common/Images/default/16/cancel_blue.png"></asp:ImageButton>
                        </ItemTemplate>
                        <ItemStyle Width="18px" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="BENEF_ID" HeaderText="Ід. бенефіціра" SortExpression="BENEF_ID">
                        <ItemStyle Width="100px" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BENEF_NAME" HeaderText="Найменування" SortExpression="BENEF_NAME"></asp:BoundField>
                    <asp:BoundField DataField="COUNTRY_NAME" HeaderText="Країна" SortExpression="COUNTRY_NAME"></asp:BoundField>
                    <asp:BoundField DataField="BENEF_ADR" HeaderText="Адреса бенефіціара" SortExpression="BENEF_ADR"></asp:BoundField>
                    <asp:BoundField DataField="COMMENTS" HeaderText="Коментар" SortExpression="COMMENTS"></asp:BoundField>
                    <asp:BoundField DataField="DELETE_DATE" HeaderText="Дата видалення" SortExpression="DELETE_DATE">
                        <ItemStyle Width="130px" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <RowStyle CssClass="normalRow"></RowStyle>
            </bars:BarsGridViewEx>
        </asp:Panel>
    </div>

    <asp:FormView ID="fvBeneficiar" Style="margin-left: 10px;" DataKeyNames="BENEF_ID" runat="server" DataSourceID="odsVCimBeneficiar" OnItemUpdating="fvBeneficiar_ItemUpdating" OnItemInserting="fvBeneficiar_ItemInserting">
        <EditItemTemplate>
            <asp:Panel runat="server" ID="pnBenefInfo" GroupingText="Дані про бенефіціара">
                <table class='ui-widget-content'>
                    <tr>
                        <td>Найменування :
                        </td>
                        <td>
                            <asp:TextBox ID="tbBENEF_NAME" runat="server" Text='<%# Eval("BENEF_NAME") %>' Width="400px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Країна :
                        </td>
                        <td>
                            <asp:DropDownList ID="ddCOUNTRY" DataSourceID="dsCountries" DataTextField="NAME" DataValueField="COUNTRY" runat="server" SelectedValue='<%# Eval("COUNTRY_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>Адреса :
                        </td>
                        <td>
                            <asp:TextBox ID="tbAddr" TextMode="MultiLine" runat="server" Text='<%# Eval("BENEF_ADR") %>' Width="400px" />
                        </td>
                    </tr>
                    <tr>
                        <td>Коментар :
                        </td>
                        <td>
                            <asp:TextBox ID="tbComments" TextMode="MultiLine" runat="server" Text='<%# Eval("COMMENTS") %>' Width="400px" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <asp:Button ID="btSave" runat="server" CausesValidation="true" Text="Зберегти" CommandName='<%# (fvBeneficiar.CurrentMode == FormViewMode.Insert)?("Insert"):("Update") %>' />
                            &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btCancel" runat="server" CausesValidation="false" Text="Відмінити"
                            CommandName="Cancel" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </EditItemTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="odsVCimBeneficiar" runat="server" DataObjectTypeName="cim.VCimBeneficiariesRecord"
        DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectBEneficiar"
        UpdateMethod="Update" TypeName="cim.VCimBeneficiaries">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvVCimBeneficiaries" PropertyName="SelectedValue" Name="BENEF_ID" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

