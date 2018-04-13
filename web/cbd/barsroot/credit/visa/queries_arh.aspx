<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="queries_arh.aspx.cs" Inherits="credit_crdsrv_queries_arh" Title="Архив заявок ({0})"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="odsOurBranch" runat="server" SelectMethod="Select" TypeName="credit.OurBranch">
        </asp:ObjectDataSource>
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td class="sectionTitle">
                    <asp:Label ID="SearchTitle" runat="server" Text="Пошук" meta:resourcekey="SearchTitleResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr valign="top">
                            <td>
                                <asp:Panel ID="pnlPersonal" runat="server" GroupingText="Персональні дані" meta:resourcekey="pnlPersonalResource1">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalInnTitle" runat="server" Text="Идентификационный код клиента :"
                                                    meta:resourcekey="PersonalInnTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PersonalInn" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalFioTitle" runat="server" Text="ФИО клиента (маска %) :" meta:resourcekey="PersonalFioTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PersonalFio" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalBDayTitle" runat="server" Text="Дата рождения клиента :" meta:resourcekey="PersonalBDayTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDate ID="PersonalBDay" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalWorkInnTitle" runat="server" Text="ЄДРПОУ работодателя :"
                                                    meta:resourcekey="PersonalWorkInnTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PersonalWorkInn" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalWorkNameTitle" runat="server" Text="Наименование работодателя :"
                                                    meta:resourcekey="PersonalWorkNameTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PersonalWorkName" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Panel ID="pnlCredit" runat="server" GroupingText="Дані кредиту" meta:resourcekey="pnlCreditResource1">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditSubproductTitle" runat="server" Text="Субпродукт :" meta:resourcekey="CreditSubproductTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:ObjectDataSource ID="odsVWcsSubproducts" runat="server" SelectMethod="SelectAllSubproducts"
                                                    TypeName="credit.VWcsSubproducts" />
                                                <bec:DDLList ID="CreditSubproduct" runat="server" DataSourceID="odsVWcsSubproducts"
                                                    DataTextField="SUBPRODUCT_NAME" DataValueField="SUBPRODUCT_ID" IsRequired="false"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditPropertyCostTitle" runat="server" Text="Сотимость товара :"
                                                    meta:resourcekey="CreditPropertyCostTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="CreditPropertyCost" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditOwmFoundsTitle" runat="server" Text="Сумма собственных средств :"
                                                    meta:resourcekey="CreditOwmFoundsTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="CreditOwmFounds" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditSumTitle" runat="server" Text="Сумма кредита :" meta:resourcekey="CreditSumTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDecimal ID="CreditSum" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditTermTitle" runat="server" Text="Срок кредита :" meta:resourcekey="CreditTermTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="CreditTerm" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CreditGuaranteeTitle" runat="server" Text="Обеспечение :" meta:resourcekey="CreditGuaranteeTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:ObjectDataSource ID="odsVWcsGarantees" runat="server" SelectMethod="Select"
                                                    TypeName="credit.VWcsGarantees"></asp:ObjectDataSource>
                                                <asp:ListBox ID="CreditGuarantee" runat="server" Rows="3" SelectionMode="Multiple"
                                                    ValidationGroup="Search" DataSourceID="odsVWcsGarantees" DataTextField="GARANTEE_NAME"
                                                    DataValueField="GARANTEE_ID" Width="200px" AppendDataBoundItems="True" meta:resourcekey="CreditGuaranteeResource1">
                                                    <asp:ListItem Value="ALL" meta:resourcekey="ListItemResource1">Все</asp:ListItem>
                                                </asp:ListBox>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Panel ID="pnlBid" runat="server" GroupingText="Дані про заявку" meta:resourcekey="pnlBidResource1">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="BidIdTitle" runat="server" Text="№ заявки :" meta:resourcekey="BidIdTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="BidId" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="BidDateTitle" runat="server" Text="Дата создания заявки :" meta:resourcekey="BidDateTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <table border="0" cellpadding="1" cellspacing="0">
                                                    <tr>
                                                        <td style="white-space: nowrap">
                                                            <asp:Label ID="BidDateTitleFrom" runat="server" Width="30px" Text="c : " meta:resourcekey="BidDateTitleFromResource1"></asp:Label>
                                                            <bec:TextBoxDate ID="BidDateFrom" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="white-space: nowrap">
                                                            <asp:Label ID="BidDateTitleTo" runat="server" Width="30px" Text="до : " meta:resourcekey="BidDateTitleToResource1"></asp:Label>
                                                            <bec:TextBoxDate ID="BidDateTo" runat="server" IsRequired="False" ValidationGroup="Search" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="BidStateTitle" runat="server" Text="Статус заявки :" meta:resourcekey="BidStateTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:ListBox ID="BidState" runat="server" Rows="3" SelectionMode="Multiple" ValidationGroup="Search"
                                                    Width="200px" meta:resourcekey="BidStateResource1">
                                                    <asp:ListItem Value="ALL" meta:resourcekey="ListItemResource2">Все</asp:ListItem>
                                                    <asp:ListItem Value="PROC" meta:resourcekey="ListItemResource3">Обрботка</asp:ListItem>
                                                    <asp:ListItem Value="DONE" meta:resourcekey="ListItemResource4">Выдано</asp:ListItem>
                                                    <asp:ListItem Value="DENY" meta:resourcekey="ListItemResource5">Отказано</asp:ListItem>
                                                    <asp:ListItem Value="ERR" meta:resourcekey="ListItemResource6">Системная ошибка</asp:ListItem>
                                                </asp:ListBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalBranchTitle" runat="server" Text="Код отделения :" meta:resourcekey="PersonalBranchTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="PersonalBranch" runat="server" DataSourceID="odsOurBranch" DataTextField="BRANCH"
                                                    DataValueField="BRANCH" IsRequired="false" Width="200" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="PersonalMgrFioTitle" runat="server" Text="ФИО менеджера (маска %) :"
                                                    meta:resourcekey="PersonalMgrFioTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="PersonalMgrFio" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Panel ID="pnlProc" runat="server" GroupingText="Дані про обробку" meta:resourcekey="pnlProcResource1">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="CHECK_DATTitle" runat="server" Text="Дата :" meta:resourcekey="CHECK_DATTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxDate ID="CHECK_DAT" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CHECK_BRANCHTitle" runat="server" Text="Код отделения :" meta:resourcekey="CHECK_BRANCHTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:DDLList ID="CHECK_BRANCH" runat="server" DataSourceID="odsOurBranch" DataTextField="BRANCH"
                                                    DataValueField="BRANCH" IsRequired="false" Width="200" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CHECK_USER_FIOTitle" runat="server" Text="ФИО співробітника (маска %) :"
                                                    meta:resourcekey="CHECK_USER_FIOTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="CHECK_USER_FIO" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="4">
                                <asp:Button ID="btSearch" runat="server" Text="Применить" SkinID="bSearch" OnClick="btSearch_Click"
                                    meta:resourcekey="btSearchResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectVisaBidsArchive"
                        TypeName="credit.VWcsVisaBidsArchive" SortParameterName="SortExpression" EnablePaging="True">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="srvhr" Name="SRV_HIERARCHY" Type="String" />
                            <asp:QueryStringParameter QueryStringField="type" Name="Type" Type="String" />
                            <asp:ControlParameter ControlID="PersonalInn" Name="PersonalInn" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="PersonalFio" Name="PersonalFio" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="PersonalBDay" Name="PersonalBDay" PropertyName="Value"
                                Type="DateTime" />
                            <asp:ControlParameter ControlID="PersonalWorkInn" Name="PersonalWorkInn" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="PersonalWorkName" Name="PersonalWorkName" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="BidId" Name="BidId" PropertyName="Value" Type="Decimal" />
                            <asp:ControlParameter ControlID="BidDateFrom" Name="BidDateFrom" PropertyName="Value"
                                Type="DateTime" />
                            <asp:ControlParameter ControlID="BidDateTo" Name="BidDateTo" PropertyName="Value"
                                Type="DateTime" />
                            <asp:Parameter Name="BidState" Type="String" />
                            <asp:ControlParameter ControlID="PersonalBranch" Name="PersonalBranch" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="PersonalMgrFio" Name="PersonalMgrFio" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="CreditSubproduct" Name="CreditSubproduct" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="CreditPropertyCost" Name="CreditPropertyCost" PropertyName="Value"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="CreditOwmFounds" Name="CreditOwmFounds" PropertyName="Value"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="CreditSum" Name="CreditSum" PropertyName="Value"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="CreditTerm" Name="CreditTerm" PropertyName="Value"
                                Type="Decimal" />
                            <asp:Parameter Name="CreditGuarantee" Type="String" />
                            <asp:ControlParameter ControlID="CHECK_DAT" Name="CHECK_DAT" PropertyName="Value"
                                Type="DateTime" />
                            <asp:ControlParameter ControlID="CHECK_BRANCH" Name="CHECK_BRANCH" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="CHECK_USER_FIO" Name="CHECK_USER_FIO" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                        ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                        CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                        FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                        AllowSorting="True" AllowPaging="True" PageSize="30" ShowFooter="True" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                        EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowExportExcelButton="True"
                        meta:resourcekey="gvResource1">
                        <PagerSettings Mode="Numeric" PageButtonCount="3" />
                        <FooterStyle CssClass="footerRow"></FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="BID_ID" DataNavigateUrlFormatString="/barsroot/credit/visa/bid_card_arh.aspx?bid_id={0}"
                                DataTextField="BID_ID" DataTextFormatString="{0}" HeaderText="№ заявки" SortExpression="BID_ID"
                                meta:resourcekey="HyperLinkFieldResource1">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:HyperLinkField>
                            <asp:TemplateField HeaderText="Субпродукт" SortExpression="SUBPRODUCT_ID" meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>' ToolTip='<%# Bind("SUBPRODUCT_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CRT_DATE" HeaderText="Дата заявки" SortExpression="CRT_DATE"
                                DataFormatString="{0:d}" meta:resourcekey="BoundFieldResource1">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FIO" HeaderText="ПІБ клієнта" SortExpression="FIO" meta:resourcekey="BoundFieldResource2">
                            </asp:BoundField>
                            <asp:BoundField DataField="INN" HeaderText="Ідент. код клієнта" SortExpression="INN"
                                meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField DataField="SUMM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сума кредиту"
                                SortExpression="SUMM" meta:resourcekey="BoundFieldResource4">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TERM" DataFormatString="{0:F0}" HeaderText="Термін кредиту"
                                SortExpression="TERM" meta:resourcekey="BoundFieldResource5" />
                            <asp:BoundField DataField="GARANTEES" HeaderText="Забезпечення" SortExpression="GARANTEES"
                                meta:resourcekey="BoundFieldResource6"></asp:BoundField>
                            <asp:BoundField DataField="MGR_FIO" HeaderText="ПІБ менеджера" SortExpression="MGR_FIO"
                                meta:resourcekey="BoundFieldResource7" />
                            <asp:TemplateField HeaderText="Відділення" SortExpression="BRANCH" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("BRANCH") %>' ToolTip='<%# Eval("BRANCH_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Статус" SortExpression="STATES" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <Bars:LabelTooltip ID="Label3" runat="server" Text='<%# Eval("STATES") %>' TextLength="30"
                                        UseTextForTooltip="true" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CHECKOUT_DAT" DataFormatString="{0:d}" HeaderText="Начало обработки"
                                SortExpression="CHECKOUT_DAT" meta:resourcekey="BoundFieldResource8" />
                            <asp:BoundField DataField="CHECKIN_DAT" DataFormatString="{0:d}" HeaderText="Конец обработки"
                                SortExpression="CHECKIN_DAT" meta:resourcekey="BoundFieldResource9" />
                            <asp:TemplateField HeaderText="Ид. користувача" SortExpression="CHECKOUT_USER_ID"
                                meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("CHECKOUT_USER_ID") %>' ToolTip='<%# Eval("CHECKOUT_USER_FIO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="normalRow"></RowStyle>
                    </Bars:BarsGridViewEx>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
