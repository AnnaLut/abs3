<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="payment.aspx.cs" Inherits="credit_manager_payment" Theme="default"
    Title="Платежные инструкции заявки №" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table class="dataTable">
            <tr>
                <td>
                    <bars:BarsObjectDataSource ID="odsPaymentTypes" runat="server" SelectMethod="SelectBidPayments"
                        TypeName="credit.VWcsBidPayments">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                        </SelectParameters>
                    </bars:BarsObjectDataSource>
                    <asp:Panel ID="pnlPaymentTypes" runat="server" GroupingText="Типы выдачи" meta:resourcekey="pnlPaymentTypesResource1">
                        <asp:RadioButtonList ID="rblPaymentTypes" runat="server" AutoPostBack="True" DataSourceID="odsPaymentTypes"
                            DataTextField="PAYMENT_NAME" DataValueField="PAYMENT_ID" OnSelectedIndexChanged="rblPaymentTypes_SelectedIndexChanged"
                            meta:resourcekey="rblPaymentTypesResource1">
                        </asp:RadioButtonList>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlPaymentInstructions" runat="server" GroupingText="Платежные инструкции"
                        meta:resourcekey="pnlPaymentInstructionsResource1">
                        <asp:MultiView ID="mv" runat="server">
                            <asp:View ID="CURACC" runat="server">
                            </asp:View>
                            <asp:View ID="CARDACC" runat="server">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td class="titleCell">
                                            <asp:Label ID="PI_CARDACC_ACCNOTitle" runat="server" Text='Номер карточного счета :'
                                                meta:resourcekey="PI_CARDACC_ACCNOTitleResource1" />
                                        </td>
                                        <td>
                                            <!-- Доделать выбор из карточных счетов -->
                                            <bec:TextBoxRefer ID="PI_CARDACC_ACCNO" runat="server" IsRequired="True" QUESTION_ID="PI_CARDACC_ACCNO"
                                                Width="400px" ShowSemantic="true" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="PARTNER" runat="server">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <colgroup>
                                        <col class="titleCell" />
                                        <tr>
                                            <td>
                                                <asp:Label ID="PARTNER_TYPETitle" runat="server" Text="Тип :" meta:resourcekey="PARTNER_TYPETitleResource1" />
                                            </td>
                                            <td>
                                                <bars:BarsObjectDataSource ID="odsBidPtrtypes" runat="server" SelectMethod="SelectBidPtrtypes"
                                                    TypeName="credit.VWcsBidPtrtypes">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                                                    </SelectParameters>
                                                </bars:BarsObjectDataSource>
                                                <bec:DDLList ID="PARTNER_TYPE" runat="server" DataSourceID="odsBidPtrtypes" DataTextField="PTR_TYPE_NAME"
                                                    DataValueField="PTR_TYPE_ID" IsRequired="true" OnValueChanged="PARTNER_TYPE_ValueChanged" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_PARTNER_IDTitle" runat="server" Text="Торговец-партнер :" meta:resourcekey="PI_PARTNER_IDTitleResource1" />
                                            </td>
                                            <td>
                                                <bars:BarsObjectDataSource ID="odsBidPartners" runat="server" SelectMethod="SelectBidPartners"
                                                    TypeName="credit.VWcsBidPartners">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                                                        <asp:ControlParameter Name="TYPE_ID" ControlID="PARTNER_TYPE" PropertyName="SelectedValue"
                                                            Type="String" />
                                                    </SelectParameters>
                                                </bars:BarsObjectDataSource>
                                                <bec:DDLList ID="PI_PARTNER_ID" runat="server" DataSourceID="odsBidPartners" DataTextField="PARTNER_NAME"
                                                    DataValueField="PARTNER_ID" IsRequired="true" />
                                            </td>
                                        </tr>
                                    </colgroup>
                                </table>
                            </asp:View>
                            <asp:View ID="FREE" runat="server">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <colgroup>
                                        <col class="titleCell" />
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_FREE_MFOTitle" runat="server" Text="МФО :" meta:resourcekey="PI_FREE_MFOTitleResource1" />
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PI_FREE_MFO" runat="server" IsRequired="False" MinLength="6"
                                                    MaxLength="6" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_FREE_NLSTitle" runat="server" Text="Счет :" meta:resourcekey="PI_FREE_NLSTitleResource1" />
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PI_FREE_NLS" runat="server" IsRequired="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_FREE_OKPOTitle" runat="server" Text="Код :" meta:resourcekey="PI_FREE_OKPOTitleResource1" />
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PI_FREE_OKPO" runat="server" IsRequired="False" MinLength="8"
                                                    MaxLength="10" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_FREE_NAMETitle" runat="server" Text="Наименование :" meta:resourcekey="PI_FREE_NAMETitleResource1" />
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PI_FREE_NAME" runat="server" IsRequired="False" Width="300px" />
                                            </td>
                                        </tr>
                                    </colgroup>
                                </table>
                            </asp:View>
                            <asp:View ID="CASH" runat="server">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <colgroup>
                                        <col class="titleCell" />
                                        <tr>
                                            <td>
                                                <asp:Label ID="PI_CASH_BRANCHTitle" runat="server" Text="Отделение :" meta:resourcekey="PI_CASH_BRANCHTitleResource1" />
                                            </td>
                                            <td>
                                                <bec:TextBoxRefer ID="PI_CASH_BRANCH" runat="server" IsRequired="True" QUESTION_ID="PI_CASH_BRANCH"
                                                    Width="300px" />
                                            </td>
                                        </tr>
                                    </colgroup>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="nextButtonContainer" colspan="2">
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
