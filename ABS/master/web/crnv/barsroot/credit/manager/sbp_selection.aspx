<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="sbp_selection.aspx.cs" Inherits="credit_manager_bid_create" Title="Выбор субпродукта"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <act:TabContainer ID="tc" runat="server" ActiveTabIndex="0" meta:resourcekey="tcResource1">
            <act:TabPanel ID="tpSubproduct" runat="server" HeaderText="Выбор субпродукта" meta:resourcekey="tpSubproductResource1">
                <ContentTemplate>
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlProduct" runat="server" GroupingText="Продукт" meta:resourcekey="pnlProductResource1">
                                    <asp:ObjectDataSource ID="odsVWcsProducts" runat="server" SelectMethod="SelectProducts"
                                        TypeName="credit.VWcsProducts"></asp:ObjectDataSource>
                                    <bec:DDLList ID="PRODUCT_ID" runat="server" DataSourceID="odsVWcsProducts" DataTextField="PRODUCT_NAME"
                                        DataValueField="PRODUCT_ID" IsRequired="false" ValidationGroup="Search">
                                    </bec:DDLList>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlFilter" runat="server" GroupingText="Фильтр" meta:resourcekey="pnlFilterResource1">
                                    <table border="0" cellpadding="3" cellspacing="0">
                                        <colgroup>
                                            <col />
                                            <col />
                                            <col style="padding-left: 50px" />
                                            <col />
                                            <tr>
                                                <td>
                                                    <asp:Label ID="SearchPropertyCostTitle" runat="server" Text="Стоимость имущества :"
                                                        meta:resourcekey="SearchPropertyCostTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxDecimal ID="PropertyCost" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="SearchCreditCurrencyTitle" runat="server" Text="Валюта :" meta:resourcekey="SearchCreditCurrencyTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxRefer ID="CreditCurrency" runat="server" IsRequired="False" KEY_FIELD="LCV"
                                                        SEMANTIC_FIELD="NAME" TAB_ID="113" ValidationGroup="Search" WHERE_CLAUSE="where lcv in ('UAH', 'USD', 'EUR')" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="SearchCreditSumTitle" runat="server" Text="Сумма кредита :" meta:resourcekey="SearchCreditSumTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxDecimal ID="CreditSum" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="SearchGaranteeTitle" runat="server" Text="Обеспечение средств :" meta:resourcekey="SearchGaranteeTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:ObjectDataSource ID="odsVWcsGarantees" runat="server" SelectMethod="Select"
                                                        TypeName="credit.VWcsGarantees"></asp:ObjectDataSource>
                                                    <bec:DDLList ID="GARANTEE_ID" runat="server" DataSourceID="odsVWcsGarantees" DataTextField="GARANTEE_NAME"
                                                        DataValueField="GARANTEE_ID" IsRequired="false">
                                                    </bec:DDLList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="SearchOwnFundsTitle" runat="server" Text="Сумма собственных средств :"
                                                        meta:resourcekey="SearchOwnFundsTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxDecimal ID="OwnFunds" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                </td>
                                                <td align="right" colspan="2" rowspan="2" valign="bottom">
                                                    <asp:Button ID="btSearch" runat="server" OnClick="btSearch_Click" SkinID="bSearch"
                                                        Text="Застосувати" ValidationGroup="Search" meta:resourcekey="btSearchResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="SearchCreditTermTitle" runat="server" Text="Срок кредита (мес.) :"
                                                        meta:resourcekey="SearchCreditTermTitleResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <bec:TextBoxNumb ID="CreditTerm" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                </td>
                                            </tr>
                                        </colgroup>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div class="dataContainer">
                                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="FindMgrSbpDetails" TypeName="credit.VWcsMgrSbpDetails">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="PRODUCT_ID" ControlID="PRODUCT_ID" PropertyName="SelectedValue"
                                                Size="100" Type="String" />
                                            <asp:ControlParameter Name="PropertyCost" ControlID="PropertyCost" PropertyName="Value"
                                                Type="Decimal" />
                                            <asp:ControlParameter Name="CreditSum" ControlID="CreditSum" PropertyName="Value"
                                                Type="Decimal" />
                                            <asp:ControlParameter Name="OwnFunds" ControlID="OwnFunds" PropertyName="Value" Type="Decimal" />
                                            <asp:ControlParameter Name="CreditTerm" ControlID="CreditTerm" PropertyName="Value"
                                                Type="Decimal" />
                                            <asp:ControlParameter Name="CreditCurrency" ControlID="CreditCurrency" PropertyName="Value"
                                                Size="100" Type="String" />
                                            <asp:ControlParameter Name="GARANTEE_ID" ControlID="GARANTEE_ID" PropertyName="SelectedValue"
                                                Size="100" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <Bars:BarsGridViewEx ID="gv" runat="server" CaptionText="" CssClass="barsGridView"
                                        DateMask="dd.MM.yyyy" EnableModelValidation="True" HoverRowCssClass="hoverRow"
                                        MetaTableName="" ShowExportExcelButton="True" ShowPageSizeBox="False" AutoGenerateColumns="False"
                                        DataSourceID="ods" OnRowCommand="gv_RowCommand" DataKeyNames="SUBPRODUCT_ID"
                                        meta:resourcekey="gvResource1">
                                        <NewRowStyle CssClass=""></NewRowStyle>
                                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:TemplateField HeaderText="Код" SortExpression="SUBPRODUCT_ID" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbSelectSubproduct" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>'
                                                        ToolTip='<%# Eval("SUBPRODUCT_NAME") %>' CommandName="Select" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Условия" InsertVisible="False" ShowHeader="False"
                                                meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbPrintDetails" runat="server" Text="Печать" CommandName="PrintDetails"
                                                        CommandArgument='<%# Eval("SUBPRODUCT_ID") + ";" + Eval("PRT_TPL") %>' meta:resourcekey="lbPrintDetailsResource1"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Мин/Макс сумма" SortExpression="SUM_MIN" meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("SUM_MIN", "{0:### ### ### ##0.00}") + "/" + Eval("SUM_MAX", "{0:### ### ### ##0.00}") %>'
                                                        meta:resourcekey="Label2Resource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Мин/Макс % соб. средств" SortExpression="SUM_INITIAL_MIN"
                                                meta:resourcekey="TemplateFieldResource4">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("SUM_INITIAL_MIN", "{0:##0.00}") + "/" + Eval("SUM_INITIAL_MAX", "{0:##0.00}") + "%" %>'
                                                        meta:resourcekey="Label3Resource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Мин/Макс срок" SortExpression="TERM_MIN" meta:resourcekey="TemplateFieldResource5">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("TERM_MIN") + "/" + Eval("TERM_MAX") %>'
                                                        meta:resourcekey="Label4Resource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CURRENCY" HeaderText="Валюта" SortExpression="CURRENCY"
                                                meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Мин/Макс %" SortExpression="INTEREST_RATE_MIN" meta:resourcekey="TemplateFieldResource6">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("INTEREST_RATE_MIN", "{0:##0.00}") + "/" + Eval("INTEREST_RATE_MAX", "{0:##0.00}") + "%" %>'
                                                        meta:resourcekey="Label5Resource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="GARANTEES" HeaderText="Обеспечение" SortExpression="GARANTEES"
                                                meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Описание" SortExpression="DESCRIPTION" meta:resourcekey="TemplateFieldResource7">
                                                <ItemTemplate>
                                                    <Bars:LabelTooltip ID="Label7" runat="server" Text='<%# Eval("DESCRIPTION") %>' TextLength="50"
                                                        UseTextForTooltip="true" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                                        <FooterStyle CssClass="footerRow"></FooterStyle>
                                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                                        <RowStyle CssClass="normalRow"></RowStyle>
                                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    </Bars:BarsGridViewEx>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </act:TabPanel>
            <act:TabPanel ID="tpCalc" runat="server" HeaderText="Калькулятор" OnLoad="tpCalc_Load"
                OnPreRender="tpCalc_PreRender" meta:resourcekey="tpCalcResource1">
                <ContentTemplate>
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlSbpTitle" runat="server" GroupingText="Субпродукт" HorizontalAlign="Center"
                                    meta:resourcekey="pnlSbpTitleResource1">
                                    <asp:Label ID="lSbpTitle" runat="server" meta:resourcekey="lSbpTitleResource2"></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры" meta:resourcekey="pnlParamsResource1">
                                    <table class="dataTable">
                                        <tr>
                                            <td id="tdContainer" runat="server">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="padding-top: 10px">
                                                <asp:Button ID="bCalc" SkinID="bCalc" runat="server" OnClick="bCalc_Click" meta:resourcekey="bCalcResource1" />
                                                <asp:Button ID="bPrint" SkinID="bPrint" runat="server" OnClick="bPrint_Click" meta:resourcekey="bPrintResource1" />
                                                <asp:Button ID="bPreScoring" Text="Фин. стан" ToolTip="Перейти к вводу данных для предварительного расчета фин. состояния"
                                                    OnClick="bPreScoring_Click" runat="server" BorderWidth="0px" BorderStyle="Solid"
                                                    Font-Bold="True" BackColor="#D6E7F7" ForeColor="#046695" BorderColor="#046695"
                                                    meta:resourcekey="bPreScoringResource1" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="dataContainer">
                                                    <Bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" SelectCommand="select t.pmt_id, t.pmt_date, t.pmt_in_bal as pmt_in_bal, t.pmt_body as pmt_body, t.pmt_interest as pmt_interest, t.pmt_total as pmt_total, t.pmt_out_bal as pmt_out_bal from table(wcs_utl.get_gpk(:BID_ID)) t union select null as pmt_id, null as pmt_date, null as pmt_in_bal, sum(t.pmt_body) as pmt_body, sum(t.pmt_interest) as pmt_interest, sum(t.pmt_total) as pmt_total, null as pmt_out_bal from table(wcs_utl.get_gpk(:BID_ID)) t"
                                                        AllowPaging="False" PageButtonCount="10" PagerMode="NextPrevious" PageSize="10">
                                                        <SelectParameters>
                                                            <asp:Parameter Name="BID_ID" Type="Decimal" />
                                                        </SelectParameters>
                                                    </Bars:BarsSqlDataSourceEx>
                                                    <Bars:BarsGridViewEx ID="gvGPK" runat="server" CaptionText="" CssClass="barsGridView"
                                                        DateMask="dd.MM.yyyy" EnableModelValidation="True" HoverRowCssClass="hoverRow"
                                                        MetaTableName="" ShowExportExcelButton="True" ShowPageSizeBox="False" AutoGenerateColumns="False"
                                                        DataSourceID="sds" meta:resourcekey="gvGPKResource1">
                                                        <NewRowStyle CssClass=""></NewRowStyle>
                                                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                                        <Columns>
                                                            <asp:BoundField DataField="PMT_ID" HeaderText="Номер платежа" SortExpression="PMT_ID"
                                                                meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                            <asp:BoundField DataField="PMT_DATE" DataFormatString="{0:d}" HeaderText="Дата платежа"
                                                                SortExpression="PMT_DATE" meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                                            <asp:BoundField DataField="PMT_IN_BAL" DataFormatString="{0:### ### ### ##0.00}"
                                                                HeaderText="Остаток кредита на начало периода" SortExpression="PMT_IN_BAL" meta:resourcekey="BoundFieldResource5">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PMT_TOTAL" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сумма платежа за месяц"
                                                                SortExpression="PMT_TOTAL" meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                                                            <asp:BoundField DataField="PMT_BODY" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Тело кредита к погашению"
                                                                SortExpression="PMT_BODY" meta:resourcekey="BoundFieldResource7"></asp:BoundField>
                                                            <asp:BoundField DataField="PMT_INTEREST" DataFormatString="{0:### ### ### ##0.00}"
                                                                HeaderText="Проценты к погашению" SortExpression="PMT_INTEREST" meta:resourcekey="BoundFieldResource8">
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="PMT_OUT_BAL" DataFormatString="{0:### ### ### ##0.00}"
                                                                HeaderText="Остаток кредита на конец периода" SortExpression="PMT_OUT_BAL" meta:resourcekey="BoundFieldResource9">
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                                                        <FooterStyle CssClass="footerRow"></FooterStyle>
                                                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                                                        <RowStyle CssClass="normalRow"></RowStyle>
                                                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                                    </Bars:BarsGridViewEx>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </act:TabPanel>
        </act:TabContainer>
    </div>
</asp:Content>
