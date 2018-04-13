<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="bid_card.aspx.cs" Inherits="credit_manager_bid_card" Title="Карточка заявки №"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBid" TypeName="credit.VWcsBids">
        <SelectParameters>
            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Size="100" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="fv" runat="server" DataSourceID="ods" DataKeyNames="BID_ID" EnableModelValidation="True"
        OnItemCommand="fv_ItemCommand" meta:resourcekey="fvResource1">
        <ItemTemplate>
            <table border="0" cellpadding="3" cellspacing="0">
                <col style="vertical-align: top" />
                <col style="vertical-align: top" />
                <tr>
                    <td>
                        <asp:Panel ID="pnlClient" runat="server" GroupingText="Базовая информация про клиента"
                            meta:resourcekey="pnlClientResource1">
                            <table class="dataTable">
                                <colgroup>
                                    <col class="titleCell" />
                                    <tr>
                                        <td>
                                            <asp:Label ID="RNKTitle" runat="server" Text="РНК :" />
                                        </td>
                                        <td>
                                            <asp:Label ID="RNK" runat="server" Text='<%# Bind("RNK") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="FTitle" runat="server" Text="Фамилия :" meta:resourcekey="FTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="F" runat="server" Text='<%# Bind("F") %>' meta:resourcekey="FResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="ITitle" runat="server" Text="Имя :" meta:resourcekey="ITitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="I" runat="server" Text='<%# Bind("I") %>' meta:resourcekey="IResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="OTitle" runat="server" Text="Отчество :" meta:resourcekey="OTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="O" runat="server" Text='<%# Bind("O") %>' meta:resourcekey="OResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="INNTitle" runat="server" Text="Идентификационный код клиента :" meta:resourcekey="INNTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="INN" runat="server" Text='<%# Bind("INN") %>' meta:resourcekey="INNResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="BDATETitle" runat="server" Text="Дата рождения :" meta:resourcekey="BDATETitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="BDATE" runat="server" Text='<%# Bind("BDATE", "{0:d}") %>' meta:resourcekey="BDATEResource1" />
                                        </td>
                                    </tr>
                                </colgroup>
                            </table>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pnlStates" runat="server" GroupingText="Статусы заявки" meta:resourcekey="pnlStatesResource1">
                            <table class="dataTable">
                                <tr>
                                    <td>
                                        <Bars:BarsObjectDataSource ID="odsVWcsBidStates" runat="server" SelectMethod="SelectDispBidStates"
                                            TypeName="credit.VWcsBidStates" SortParameterName="SortExpression">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Size="100" Type="Decimal" />
                                            </SelectParameters>
                                        </Bars:BarsObjectDataSource>
                                        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                                            CssClass="barsGridView" DataSourceID="odsVWcsBidStates" DateMask="dd.MM.yyyy"
                                            EnableModelValidation="True" HoverRowCssClass="hoverRow" MetaTableName="" ShowExportExcelButton="True"
                                            ShowPageSizeBox="False" meta:resourcekey="gvResource1">
                                            <NewRowStyle CssClass="" />
                                            <AlternatingRowStyle CssClass="alternateRow" />
                                            <Columns>
                                                <asp:BoundField DataField="STATE_NAME" HeaderText="Состояние" SortExpression="STATE_NAME"
                                                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                                <asp:BoundField DataField="CHECKOUT_DAT" HeaderText="Дата/Время" SortExpression="CHECKOUT_DAT"
                                                    DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" meta:resourcekey="BoundFieldResource2">
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="CHECKOUT_USER_F" HeaderText="Пользователь" SortExpression="CHECKOUT_USER_F"
                                                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Комментарий" SortExpression="USER_COMMENT" meta:resourcekey="BoundFieldResource4">
                                                    <ItemTemplate>
                                                        <Bars:LabelTooltip ID="Label1" runat="server" Text='<%# Eval("USER_COMMENT") %>'
                                                            TextLength="30" UseTextForTooltip="true" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <EditRowStyle CssClass="editRow" />
                                            <FooterStyle CssClass="footerRow" />
                                            <HeaderStyle CssClass="headerRow" />
                                            <PagerStyle CssClass="pagerRow" />
                                            <RowStyle CssClass="normalRow" />
                                            <SelectedRowStyle CssClass="selectedRow" />
                                        </Bars:BarsGridViewEx>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right">
                                        <asp:LinkButton ID="lbStatesHistory" runat="server" Text="История статусов" CommandName="STATESHISTORY"
                                            meta:resourcekey="lbStatesHistoryResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlCredit" runat="server" GroupingText="Информация про кредит" meta:resourcekey="pnlCreditResource1">
                            <table class="dataTable">
                                <colgroup>
                                    <col class="titleCell" />
                                    <tr>
                                        <td>
                                            <asp:Label ID="SUBPRODUCTTitle" runat="server" Text="Субпродукт :" meta:resourcekey="SUBPRODUCTTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="SUBPRODUCT" runat="server" Text='<%# Eval("SUBPRODUCT_ID") %>' ToolTip='<%# Eval("SUBPRODUCT_DESC") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="SUMMTitle" runat="server" Text="Сумма кредита :" meta:resourcekey="SUMMTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="SUMM" runat="server" Text='<%# Bind("SUMM", "{0:### ### ### ##0.00}") %>'
                                                meta:resourcekey="SUMMResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="OWN_FUNDSTitle" runat="server" Text="Сумма собственных средств :"
                                                meta:resourcekey="OWN_FUNDSTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="OWN_FUNDS" runat="server" Text='<%# Bind("OWN_FUNDS", "{0:### ### ### ##0.00}") %>'
                                                meta:resourcekey="OWN_FUNDSResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="TERMTitle" runat="server" Text="Срок кредита :" meta:resourcekey="TERMTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="TERM" runat="server" Text='<%# (String)Eval("TERM") + " (міс.)" %>'
                                                meta:resourcekey="TERMResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="CREDIT_CURRENCYTitle" runat="server" Text="Валюта кредита :" meta:resourcekey="CREDIT_CURRENCYTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="CREDIT_CURRENCY" runat="server" Text='<%# Bind("CREDIT_CURRENCY") %>'
                                                meta:resourcekey="CREDIT_CURRENCYResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="SINGLE_FEETitle" runat="server" Text="Комиссия банка разовая :" meta:resourcekey="SINGLE_FEETitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="SINGLE_FEE" runat="server" Text='<%# String.Format("{0:##0.00}", (Decimal?)Eval("SINGLE_FEE")) + " (грн.)" %>'
                                                meta:resourcekey="SINGLE_FEEResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="MONTHLY_FEETitle" runat="server" Text="Комиссия банка ежемесячная :"
                                                meta:resourcekey="MONTHLY_FEETitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="MONTHLY_FEE" runat="server" Text='<%# String.Format("{0:##0.00%}", (Decimal?)Eval("MONTHLY_FEE")/100) %>'
                                                meta:resourcekey="MONTHLY_FEEResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="INTEREST_RATETitle" runat="server" Text="Процентная ставка :" meta:resourcekey="INTEREST_RATETitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="INTEREST_RATE" runat="server" Text='<%# String.Format("{0:##0.00%}", (Decimal?)Eval("INTEREST_RATE")/100) %>'
                                                meta:resourcekey="INTEREST_RATEResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="REPAYMENT_METHODTitle" runat="server" Text="Метод погашения :" meta:resourcekey="REPAYMENT_METHODTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="REPAYMENT_METHOD" runat="server" Text='<%# Bind("REPAYMENT_METHOD_TEXT") %>'
                                                meta:resourcekey="REPAYMENT_METHODResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="REPAYMENT_DAYTitle" runat="server" Text="День погашения :" meta:resourcekey="REPAYMENT_DAYTitleResource1" />
                                        </td>
                                        <td>
                                            <asp:Label ID="REPAYMENT_DAY" runat="server" Text='<%# Bind("REPAYMENT_DAY") %>'
                                                meta:resourcekey="REPAYMENT_DAYResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="INIT_PAYMENT_MTDTitle" runat="server" Text="Шлях видачі :" />
                                        </td>
                                        <td>
                                            <asp:Label ID="INIT_PAYMENT_MTD" runat="server" Text='<%# Bind("INIT_PAYMENT_MTD") %>' />
                                        </td>
                                    </tr>
                                </colgroup>
                            </table>
                        </asp:Panel>
                    </td>
                    <td>
                        <asp:Panel ID="pnlBid" runat="server" GroupingText="Данные заявки" meta:resourcekey="pnlBidResource1">
                            <table class="dataTable">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbCREDITDATA" runat="server" Text="Данные кредита" CommandName="CREDITDATA"
                                            meta:resourcekey="lbCREDITDATAResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbSCANCOPY" runat="server" Text="Сканирование документов клиента"
                                            CommandName="SCANCOPY" meta:resourcekey="lbSCANCOPYResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbAUTH" runat="server" Text="Авторизация" CommandName="AUTH"
                                            meta:resourcekey="lbAUTHResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbSURVEY" runat="server" Text="Анкета клиента" CommandName="SURVEY"
                                            meta:resourcekey="lbSURVEYResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbGARANTEE" runat="server" Text="Описание обеспечения" CommandName="GARANTEE"
                                            meta:resourcekey="lbGARANTEEResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbPARTNER" runat="server" Text="Платежные инструкции" CommandName="PARTNER"
                                            meta:resourcekey="lbPARTNERResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbCurAccount" runat="server" Text="Текущий счет" CommandName="CURACCOUNT"
                                            meta:resourcekey="lbCurAccountResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbDOCS" runat="server" Text="Печать документов" CommandName="DOCS"
                                            meta:resourcekey="lbDOCSResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbINSURANCE" runat="server" Text="Страховые договора" CommandName="INSURANCE"
                                            meta:resourcekey="lbINSURANCEResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Panel ID="pnlCommands" runat="server" GroupingText="Команды" meta:resourcekey="pnlCommandsResource1">
                            <table class="dataTable">
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbFinishDataInput" runat="server" CommandName="FinishDataInput"
                                            Text="Завершить ввод данных" meta:resourcekey="lbFinishDataInputResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbFinishDataReinput" runat="server" CommandName="FinishDataReinput"
                                            Text="Завершить доработку" meta:resourcekey="lbFinishDataReinputResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbFinishSigndocs" runat="server" CommandName="FinishSigndocs"
                                            Text="Завершить подписание договоров" meta:resourcekey="lbFinishSigndocsResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbChangeDealDate" runat="server" CommandName="ChangeDealDate"
                                            Text="Сменить дату договора" meta:resourcekey="lbChangeDealDateResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbDeny" runat="server" CommandName="Deny" Text="Отклонить заявку"
                                            meta:resourcekey="lbDenyResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbPreScoringResults" runat="server" CommandName="PreScoringResults"
                                            Text="Результаты предварительного скоринга" meta:resourcekey="lbPreScoringResultsResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbDeleteBid" runat="server" CommandName="DeleteBid" Text="Удалить заявку"
                                            meta:resourcekey="lbDeleteBidResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="lbCreateNew" runat="server" CommandName="CreateNew" Text="Создать новую заявку из предварительной"
                                            meta:resourcekey="lbCreateNewResource1"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
