<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="change_user.aspx.cs" Inherits="credit_crdsrv_change_user" Title="Переназначение исполнителя по заявке"
    Theme="default" MaintainScrollPositionOnPostback="true" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
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
                                                <asp:Label ID="InnTitle" runat="server" Text="Идентификационный код клиента :" meta:resourcekey="InnTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="Inn" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="FioTitle" runat="server" Text="ФИО клиента (маска %) :" meta:resourcekey="FioTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="Fio" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Panel ID="pnlMgr" runat="server" GroupingText="Данные исполнителя" meta:resourcekey="pnlMgrResource1">
                                    <table border="0" cellpadding="1" cellspacing="0">
                                        <tr>
                                            <td>
                                                <asp:Label ID="UserBranchTitle" runat="server" Text="Код отделения :" meta:resourcekey="UserBranchTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:ObjectDataSource ID="odsOurBranch" runat="server" SelectMethod="Select" TypeName="credit.OurBranch">
                                                </asp:ObjectDataSource>
                                                <bec:DDLList ID="UserBranch" runat="server" DataSourceID="odsOurBranch" DataTextField="BRANCH"
                                                    DataValueField="BRANCH" IsRequired="false" Width="200" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="UserIDTitle" runat="server" Text="Ид. пользователя :" meta:resourcekey="UserIDTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxNumb ID="UserID" runat="server" IsRequired="False" ValidationGroup="Search" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="UserFioTitle" runat="server" Text="ФИО пользователя (маска %) :" meta:resourcekey="UserFioTitleResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <bec:TextBoxString ID="UserFio" runat="server" IsRequired="False" ValidationGroup="Search"
                                                    Width="200" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="3">
                                <asp:Button ID="btSearch" runat="server" Text="Применить" SkinID="bSearch" OnClick="btSearch_Click"
                                    ValidationGroup="Search" meta:resourcekey="btSearchResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectCrdsrvChangeBids"
                        TypeName="credit.VWcsCrdsrvChangeBids" SortParameterName="SortExpression" EnablePaging="True"
                        MaximumRowsParameterName="maximumRows" StartRowIndexParameterName="startRowIndex">
                        <SelectParameters>
                            <asp:QueryStringParameter QueryStringField="srvhr" Name="SRV_HIERARCHY" Type="String" />
                            <asp:ControlParameter ControlID="BidId" Name="BidId" PropertyName="Value" Type="Decimal" />
                            <asp:ControlParameter ControlID="Inn" Name="Inn" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="Fio" Name="Fio" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="UserBranch" Name="UserBranch" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="UserID" Name="UserID" PropertyName="Value" Type="Decimal" />
                            <asp:ControlParameter ControlID="UserFio" Name="UserFio" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                        ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                        CssClass="barsGridView" DataSourceID="ods" DataKeyNames="BID_ID" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
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
                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb" runat="server" meta:resourcekey="cbResource1" />
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="cbAll" runat="server" AutoPostBack="True" OnCheckedChanged="cbAll_CheckedChanged"
                                        meta:resourcekey="cbAllResource1" />
                                </HeaderTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="BID_ID" HeaderText="№ заявки" SortExpression="BID_ID"
                                meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                            <asp:TemplateField HeaderText="Субпродукт" SortExpression="SUBPRODUCT_ID" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>' ToolTip='<%# Bind("SUBPRODUCT_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CRT_DATE" HeaderText="Дата заявки" SortExpression="CRT_DATE"
                                DataFormatString="{0:d}" meta:resourcekey="BoundFieldResource2">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FIO" HeaderText="ПІБ клієнта" SortExpression="FIO" meta:resourcekey="BoundFieldResource3">
                            </asp:BoundField>
                            <asp:BoundField DataField="INN" HeaderText="Ідент. код клієнта" SortExpression="INN"
                                meta:resourcekey="BoundFieldResource4" />
                            <asp:BoundField DataField="SUMM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сума кредиту"
                                SortExpression="SUMM" meta:resourcekey="BoundFieldResource5">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TERM" DataFormatString="{0:F0}" HeaderText="Термін кредиту"
                                SortExpression="TERM" meta:resourcekey="BoundFieldResource6" />
                            <asp:BoundField DataField="GARANTEES" HeaderText="Забезпечення" SortExpression="GARANTEES"
                                meta:resourcekey="BoundFieldResource7"></asp:BoundField>
                            <asp:BoundField DataField="MGR_FIO" HeaderText="ПІБ менеджера" SortExpression="MGR_FIO"
                                meta:resourcekey="BoundFieldResource8" />
                            <asp:TemplateField HeaderText="Відділення" SortExpression="BRANCH" meta:resourcekey="TemplateFieldResource3">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("BRANCH") %>' ToolTip='<%# Eval("BRANCH_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Статус" SortExpression="STATES" meta:resourcekey="TemplateFieldResource4">
                                <ItemTemplate>
                                    <Bars:LabelTooltip ID="Label3" runat="server" Text='<%# Eval("STATES") %>' TextLength="30"
                                        UseTextForTooltip="true" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Виконавець" SortExpression="CHECKOUT_USER_FIO" meta:resourcekey="TemplateFieldResource5">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text=<%# Convert.ToString(Eval("CHECKOUT_USER_FIO")).Substring(0, Convert.ToString(Eval("CHECKOUT_USER_FIO")).IndexOf(' ')) %>
                                        ToolTip='<%# Eval("CHECKOUT_USER_FIO") + "(" + Eval("CHECKOUT_USER_ID") + ")" %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CHECKOUT_USER_BRANCH" HeaderText="Відділення виконавця"
                                SortExpression="CHECKOUT_USER_BRANCH" meta:resourcekey="BoundFieldResource9" />
                        </Columns>
                        <RowStyle CssClass="normalRow"></RowStyle>
                    </Bars:BarsGridViewEx>
                </td>
            </tr>
            <tr>
                <td style="height: 10px">
                </td>
            </tr>
            <tr>
                <td class="sectionTitle">
                    <asp:Label ID="ChangeTitle" runat="server" Text="Переназначение" meta:resourcekey="ChangeTitleResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr valign="top">
                            <td>
                                <asp:ObjectDataSource ID="odsStaff" runat="server" SelectMethod="SelectStaff" TypeName="credit.VWcsStaff">
                                </asp:ObjectDataSource>
                                <Bars:BarsGridViewEx ID="gvStaff" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                                    CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                                    CssClass="barsGridView" DataSourceID="odsStaff" DataKeyNames="ID" DateMask="dd.MM.yyyy"
                                    EnableModelValidation="True" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    HoverRowCssClass="hoverRow" JavascriptSelectionType="ServerSelect" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    MetaTableName="" PageSize="5" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                                    ShowExportExcelButton="True" ShowFilter="True" ShowCaption="False" ShowPageSizeBox="False"
                                    meta:resourcekey="gvStaffResource1">
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="ID" HeaderText="Код" SortExpression="ID" meta:resourcekey="BoundFieldResource10">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FIO" HeaderText="ФИО" SortExpression="FIO" meta:resourcekey="BoundFieldResource11">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LOGNAME" HeaderText="Логин" SortExpression="LOGNAME" meta:resourcekey="BoundFieldResource12">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BRANCH" HeaderText="Отделение" SortExpression="BRANCH"
                                            meta:resourcekey="BoundFieldResource13"></asp:BoundField>
                                    </Columns>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <RowStyle CssClass="normalRow"></RowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                </Bars:BarsGridViewEx>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="3">
                                <asp:Button ID="btChange" runat="server" Text="Переназначить" ToolTip="Переназначить на выбраного пользователя"
                                    SkinID="sButton" OnClick="btChange_Click" ValidationGroup="Change" meta:resourcekey="btChangeResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
