<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductpayments.aspx.cs"
    Inherits="credit_constructor_wcssubproductpayments" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Платежные инструкции субпродукта '{0}'" Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <Bars:BarsSqlDataSourceEx ID="sdsPaymentTypes" runat="server" SelectCommand="select * from wcs_payment_types pt order by pt.id"
        AllowPaging="False" ProviderName="barsroot.core">
    </Bars:BarsSqlDataSourceEx>
    <Bars:BarsSqlDataSourceEx ID="sdsPtrTypes" runat="server" SelectCommand="select * from wcs_partner_types pt order by pt.id"
        AllowPaging="False" ProviderName="barsroot.core">
    </Bars:BarsSqlDataSourceEx>
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td valign="top">
                    <asp:Panel ID="pnlPaymentTypes" runat="server" GroupingText="Типы выдачи">
                        <asp:CheckBoxList ID="cblPaymentTypes" runat="server" DataSourceID="sdsPaymentTypes"
                            DataTextField="NAME" DataValueField="ID" OnDataBound="cblPaymentTypes_DataBound"
                            AutoPostBack="True" Height="150px" Width="200px">
                        </asp:CheckBoxList>
                    </asp:Panel>
                </td>
                <td style="width: 25px">
                </td>
                <td valign="top">
                    <asp:Panel ID="pnlPtrTypes" runat="server" GroupingText="Типы торговцев-партнеров">
                        <asp:CheckBoxList ID="cblPtrTypes" runat="server" DataSourceID="sdsPtrTypes" DataTextField="NAME"
                            DataValueField="ID" OnDataBound="cblPtrTypes_DataBound" Height="150px" Width="200px">
                        </asp:CheckBoxList>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="right" style="padding-top: 25px">
                    <asp:Button ID="btSave" runat="server" Text="Сохранить" OnClick="btSave_Click" ValidationGroup="Params" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
