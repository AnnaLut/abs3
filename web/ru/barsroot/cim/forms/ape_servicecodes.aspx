<%@ Page Title="Довідник класифікації послуг зовнішньоекономічної діяльності" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="ape_servicecodes.aspx.cs" Inherits="cim_forms_ape_servicecodes" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<asp:Content ID="contents_head" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="contents_body" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsServiceCodes" ProviderName="barsroot.core">
    </bars:BarsSqlDataSourceEx>
    <asp:Panel GroupingText="Пошук" runat="server" ID="pnSearch">
        <table>
            <tr>
                <td>Код класифікатора:</td>
                <td>
                    <asp:TextBox runat="server" ID="tbCode" Width="100px"></asp:TextBox>
                </td>
                <td>Найменування:</td>
                <td>
                    <asp:TextBox runat="server" ID="tbName" Width="300px"></asp:TextBox>
                </td>
                <td>
                    <asp:Button runat="server" Text="Пошук" ID="btSearch" OnClick="btSearch_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <div style="overflow: scroll; padding: 10px 10px 10px 0; margin-left: -10px">
        <bars:BarsGridViewEx ID="gvServiceCodes" runat="server" AutoGenerateColumns="False"
            DataSourceID="dsServiceCodes" PageSize="8"
            ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
            AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="CODE_ID" AutoSelectFirstRow="true"
            ShowPageSizeBox="true">
            <Columns>
                <asp:BoundField DataField="CODE_ID" HeaderText="Код класифікатора" SortExpression="CODE_ID"></asp:BoundField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label runat="server" ToolTip='<%# Eval("CODE_NAME") %>' ID="lbName" Text='<%# ((Convert.ToString(Eval("CODE_NAME")).Length > 120) ? (Convert.ToString(Eval("CODE_NAME")).Substring(0,120) + "..."):(Eval("CODE_NAME"))) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </bars:BarsGridViewEx>
    </div>
    <fieldset>
        <legend>Дії над виділеним рядком</legend>
        <div style="float: right">
            <input type="button" value="Вибрати класифікатор" title="Вибрати класифікатор" onclick="returnServiceCode()" />
        </div>
    </fieldset>
</asp:Content>

