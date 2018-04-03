<%@ Page Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true"
    CodeFile="unbound_payments.aspx.cs" Inherits="cim_payments_unbound_payments"
    Title="Нерозібрані платежі" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <table>
        <tr>
            <td>
                <asp:Panel runat="server" ID="pbUnboundsType" GroupingText="Типи нерозібраних платежів" Height="60px">
                    <div class="nw">
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Вхідні" ID="rbInPays" Checked="true"
                            OnCheckedChanged="rbInPays_CheckedChanged" AutoPostBack="true" />
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Вихідні" ID="rbOutPays"
                            OnCheckedChanged="rbOutPays_CheckedChanged" AutoPostBack="true" />
                        <asp:RadioButton runat="server" GroupName="grInOut" Text="Всі" ID="rbAllPays" AutoPostBack="True"
                            OnCheckedChanged="rbAllPays_CheckedChanged" />
                    </div>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pnActions" GroupingText="Дії на виділеним рядком" Height="60px">
                    <div class="nw">
                        <asp:Button runat="server" ID="tbVisa" Text="Завізувати" OnClientClick="curr_module.DocSetVisa();return false;" />
                        <asp:Button runat="server" ID="tbBack" Text="Повернути" OnClientClick="curr_module.DocBackVisa();return false;" />
                        <asp:Button runat="server" ID="tbBind" Text="Привязати" OnClientClick="curr_module.DocBind();return false;" />
                    </div>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="odsVCimUnboundPayments" runat="server" SelectMethod="Select"
        TypeName="cim.VCimUnboundPayments" SortParameterName="SortExpression"></asp:ObjectDataSource>
    <div style="overflow: scroll; padding: 10px 10px 10px 0">
        <Bars:BarsGridViewEx ID="gvVCimUnboundPayments" runat="server" AutoGenerateColumns="False"
            DataSourceID="odsVCimUnboundPayments" CaptionText="Нерозібрані вхідні платежі"
            ShowCaption="true" CaptionType="Cool" CaptionAlign="Left" AllowSorting="True"
            AllowPaging="True" ShowFooter="True" JavascriptSelectionType="SingleRow" DataKeyNames="REF"
            ShowPageSizeBox="true" OnRowDataBound="gvVCimUnboundPayments_RowDataBound" OnPreRender="gvVCimUnboundPayments_PreRender">
            <Columns>
                <asp:BoundField DataField="REF" HeaderText="Референс платежу" SortExpression="REF">
                </asp:BoundField>
                <asp:BoundField DataField="CUST_RNK" HeaderText="Реєстраційний номер клієнта" SortExpression="CUST_RNK">
                </asp:BoundField>
                <asp:BoundField DataField="CUST_OKPO" HeaderText="ЄДРПОУ клієнта" SortExpression="CUST_OKPO">
                </asp:BoundField>
                <asp:BoundField DataField="CUST_NMK" HeaderText="Назва клієнта" SortExpression="CUST_NMK">
                </asp:BoundField>
                <asp:BoundField DataField="CUST_ND" HeaderText="№ договору з клієнтом" SortExpression="CUST_ND">
                </asp:BoundField>
                <asp:BoundField DataField="BENEF_NMK" HeaderText="Назва контрагента" SortExpression="BENEF_NMK">
                </asp:BoundField>
                <asp:BoundField DataField="NLS" HeaderText="Рахунок" SortExpression="NLS"></asp:BoundField>
                <asp:BoundField DataField="VDAT" HeaderText="Дата валютування" SortExpression="VDAT"
                    DataFormatString="{0:dd.MM.yyyy}"></asp:BoundField>
                <asp:BoundField DataField="KV" HeaderText="Валюта платежу" SortExpression="KV">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TOTAL_SUM" HeaderText="Сума платежу" DataFormatString="{0:F2}"
                    SortExpression="TOTAL_SUM"></asp:BoundField>
                <asp:BoundField DataField="UNBOUND_SUM" HeaderText="Неприв'язана частина суми" SortExpression="UNBOUND_SUM"
                    DataFormatString="{0:F2}"></asp:BoundField>
                <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" SortExpression="NAZN">
                </asp:BoundField>
                <asp:BoundField DataField="OP_TYPE" HeaderText="Тип операції" SortExpression="OP_TYPE">
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div id="dialogDocInfo" class="docInfoClass" style="display: none; text-align: left">
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
                    <a id="lnBindDoc">Привязати документ</a><br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
