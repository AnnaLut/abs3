<%@ Page Title="Портфель СД" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="deals.aspx.cs" Inherits="ins_deals" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/BarsReminder.ascx" TagName="BarsReminder" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div class="content_container">
        <div class="filter_container">
            <asp:Panel ID="pnlFilter" runat="server" GroupingText="Фільтр" DefaultButton="bApply">
                <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                    <tr>
                        <td>
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:Label ID="DATE_FROMTitle" runat="server" Text="Дата З: " />
                                    </td>
                                    <td>
                                        <bars:TextBoxDate ID="DATE_FROM" runat="server" IsRequired="true" ValidationGroup="Filter"
                                            TabIndex="1" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="DATE_TOTitle" runat="server" Text="Дата ПО: " />
                                    </td>
                                    <td>
                                        <bars:TextBoxDate ID="DATE_TO" runat="server" IsRequired="true" ValidationGroup="Filter"
                                            TabIndex="2" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:ListBox ID="STATUS" runat="server" TabIndex="3" Rows="3" SelectionMode="Multiple">
                                            <asp:ListItem Value="NEW" Selected="True" Text="Новий"></asp:ListItem>
                                            <asp:ListItem Value="NEW_ADD" Selected="True" Text="Новий (доопрац.)"></asp:ListItem>
                                            <asp:ListItem Value="VISA" Selected="True" Text="На візі"></asp:ListItem>
                                            <asp:ListItem Value="ON" Selected="True" Text="Діючий"></asp:ListItem>
                                            <asp:ListItem Value="OFF" Text="Закритий"></asp:ListItem>
                                            <asp:ListItem Value="STORNO" Text="Сторнований"></asp:ListItem>
                                        </asp:ListBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:Label ID="INS_RNKTitle" runat="server" Text="РНК страх.: " />
                                    </td>
                                    <td>
                                        <bars:TextBoxNumb ID="INS_RNK" runat="server" TabIndex="4" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="INS_FIOTitle" runat="server" Text="ПІБ страх.: " />
                                    </td>
                                    <td>
                                        <bars:TextBoxString ID="INS_FIO" runat="server" TabIndex="5" MinLength="3" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                <tr>
                                    <td>
                                        <asp:Label ID="NDTitle" runat="server" Text="Номер КД: " />
                                    </td>
                                    <td>
                                        <bars:TextBoxNumb ID="ND" runat="server" TabIndex="6" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" colspan="4">
                            <asp:Button ID="bApply" runat="server" Text="Застосувати" CausesValidation="true"
                                ValidationGroup="Filter" TabIndex="6" OnClick="bApply_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div class="gridview_container">
            <bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core">
            </bars:BarsSqlDataSourceEx>
            <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                DataSourceID="sds" DateMask="dd.MM.yyyy" EnableModelValidation="True" HoverRowCssClass="hoverRow"
                ShowExportExcelButton="True" AllowSorting="True" DataKeyNames="DEAL_ID" AllowPaging="True"
                ShowFooter="True" PageSize="30" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                OnRowDataBound="gv_RowDataBound">
                <NewRowStyle CssClass=""></NewRowStyle>
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:TemplateField HeaderText="№" SortExpression="DEAL_ID">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlDealCard" runat="server" Target="_self" Text='<%# Eval("DEAL_ID") %>'
                                NavigateUrl='<%# String.Format("/barsroot/ins/deal_card.aspx?deal_id={0}&type={1}&mode=view", Eval("DEAL_ID"), Request.Params.Get("type").ToLower()) %>'
                                ToolTip="Картка СД"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Події" SortExpression="TASK_TYPE_ID">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlDealTasks" runat="server" Target="_self"></asp:HyperLink>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" Height="24px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Відділення" SortExpression="BRANCH">
                        <ItemTemplate>
                            <asp:Label ID="lbBRANCH" runat="server" Text='<%# Eval("BRANCH") %>' ToolTip='<%# Eval("BRANCH_NAME") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Користувач" SortExpression="STAFF_ID">
                        <ItemTemplate>
                            <asp:Label ID="lbSTAFF" runat="server" Text='<%# Eval("STAFF_ID") %>' ToolTip='<%# (String)Eval("STAFF_LOGNAME") + " - " + (String)Eval("STAFF_FIO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CRT_DATE" HeaderText="Дата" SortExpression="CRT_DATE"
                        DataFormatString="{0:d}"></asp:BoundField>
                    <asp:BoundField DataField="PARTNER_NAME" HeaderText="СК" SortExpression="PARTNER_NAME"></asp:BoundField>
                    <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME"></asp:BoundField>
                    <asp:TemplateField HeaderText="Статус" SortExpression="STATUS_ID">
                        <ItemTemplate>
                            <asp:Label ID="lbSTATUS" runat="server" Text='<%# Eval("STATUS_ID") %>' ToolTip='<%# String.Format("{0} ({1}) - {2:dd/MM/yyyy HH:mm}", Eval("STATUS_ID"), Eval("STATUS_NAME"), Eval("STATUS_DATE")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Коментар" SortExpression="STATUS_ID">
                        <ItemTemplate>
                            <bars:LabelTooltip ID="lbtSTATUS_COMM" runat="server" Text='<%# Eval("STATUS_COMM") %>'
                                TextLength="20" UseTextForTooltip="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Страхувальник" SortExpression="INS_FIO">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlINSURER" runat="server" Text='<%# Eval("INS_FIO") %>' ToolTip='<%# String.Format("{0} (РНК: {1}; ІПН: {2}{3})", Eval("INS_FIO"), Eval("INS_RNK"), Eval("INS_INN"), (Eval("INS_DOC_NUM") == DBNull.Value ? "" : String.Format("; паспорт {0}{1}{2}", Eval("INS_DOC_SER"), Eval("INS_DOC_NUM"), (Eval("INS_DOC_ISSUER") == DBNull.Value ? "" : String.Format(" виданий {0} від {1:d}", Convert.ToString(Eval("INS_DOC_ISSUER")).Trim(), Eval("INS_DOC_DATE")))))) %>'
                                Target="_self" NavigateUrl='<%# String.Format("/barsroot/clientregister/registration.aspx?readonly=1&rnk={0}", Eval("INS_RNK")) %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SER" HeaderText="Серія" SortExpression="SER"></asp:BoundField>
                    <asp:BoundField DataField="NUM" HeaderText="Номер" SortExpression="NUM"></asp:BoundField>
                    <asp:BoundField DataField="SDATE" HeaderText="Дата початку" SortExpression="SDATE"
                        DataFormatString="{0:d}"></asp:BoundField>
                    <asp:BoundField DataField="EDATE" HeaderText="Дата кінця" SortExpression="EDATE"
                        DataFormatString="{0:d}"></asp:BoundField>
                    <asp:BoundField DataField="SUM" HeaderText="Страхова сума" SortExpression="SUM" DataFormatString="{0:### ### ### ### ##0.00}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Валюта" SortExpression="SUM_KV">
                        <ItemTemplate>
                            <asp:Label ID="lbSUM_KV" runat="server" Text='<%# Eval("SUM_KV") %>' ToolTip='<%# String.Format("{0} - {1} - {2}", Eval("SUM_KV"), Eval("SUM_KV_LCV"), Eval("SUM_KV_NAME")) %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="INSU_TARIFF" HeaderText="Тариф (%)" SortExpression="INSU_TARIFF"
                        DataFormatString="{0:##0.00}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TOTAL_INSU_SUM" HeaderText="Загальна срх. премія" SortExpression="TOTAL_INSU_SUM"
                        DataFormatString="{0:### ### ### ### ##0.00}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Об`єкт стрх." SortExpression="INS_FIO">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlINSURED" runat="server" Text='<%# String.Format("{0}: {1}", Eval("OBJECT_NAME"), ((String)Eval("OBJECT_TYPE") == "CL" ? ((Decimal)Eval("INS_RNK") == (Decimal)Eval("CL_RNK") ? "Страхувальник" : (String)Eval("CL_FIO")) : String.Format("{0} ({1})", Eval("GRT_TYPE_NAME"), Eval("GRT_GRT_NAME")))) %>'
                                ToolTip='<%# String.Format("{0}: {1}", Eval("OBJECT_NAME"), ((String)Eval("OBJECT_TYPE") == "CL" ? ((Decimal)Eval("INS_RNK") == (Decimal)Eval("CL_RNK") ? "Страхувальник" : String.Format("{0} (РНК: {1}; ІПН: {2}{3})", Eval("CL_FIO"), Eval("CL_RNK"), Eval("CL_INN"), (Eval("CL_DOC_NUM") == DBNull.Value ? "" : String.Format("; паспорт {0}{1}{2}", Eval("CL_DOC_SER"), Eval("CL_DOC_NUM"), (Eval("CL_DOC_ISSUER") == DBNull.Value ? "" : String.Format(" виданий {0} від {1:d}", Convert.ToString(Eval("CL_DOC_ISSUER")).Trim(), Eval("CL_DOC_DATE"))))))) : String.Format("{0} ({1}; №{2}; дог. №{3} від {4})", Eval("GRT_TYPE_NAME"), Eval("GRT_GRT_NAME"), Eval("GRT_ID"), Eval("GRT_DEAL_NUM"), Eval("GRT_DEAL_DATE")))) %>'
                                Target="_self" NavigateUrl='<%# (String)Eval("OBJECT_TYPE") == "CL" ? String.Format("/barsroot/clientregister/registration.aspx?readonly=1&rnk={0}", Eval("CL_RNK")) : String.Format("/barsroot/barsweb/dynform.aspx?form=frm_grt_dual&deal_id={0}", Eval("GRT_ID")) %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Номер КД" SortExpression="ND">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlND" runat="server" Text='<%# Eval("ND") %>' ToolTip='<%# String.Format("№{0}; дог. №{1} від {2:d}", Eval("ND"), Eval("ND_NUM"), Eval("ND_SDATE")) %>'
                                Target="_self"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PAY_FREQ_NAME" HeaderText="Сплата премії" SortExpression="PAY_FREQ_NAME"></asp:BoundField>
                    <asp:TemplateField HeaderText="Перезаключення" SortExpression="RENEW_NEED">
                        <ItemTemplate>
                            <asp:Label ID="lbRENEW_NEED" runat="server" Text='<%# String.Format("{0}{1}", ((Decimal)Eval("RENEW_NEED") == 1 ? "Так" : "Ні"), (Eval("RENEW_NEWID") == DBNull.Value ? "" : String.Format("; новый №{0}", Eval("RENEW_NEWID")))) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle CssClass="editRow"></EditRowStyle>
                <FooterStyle CssClass="footerRow"></FooterStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <RowStyle CssClass="normalRow"></RowStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </bars:BarsGridViewEx>
        </div>
    </div>
</asp:Content>
