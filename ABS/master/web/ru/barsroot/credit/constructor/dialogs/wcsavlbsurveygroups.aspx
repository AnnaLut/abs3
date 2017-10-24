<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsavlbsurveygroups.aspx.cs"
    Inherits="credit_constructor_dialogs_wcsavlbsurveygroups" Theme="default"
    MasterPageFile="~/credit/constructor/master.master" Title="Доступные для клонирования групы"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" AllowPaging="False" ProviderName="barsroot.core"
            SelectCommand="select s.survey_id, s.survey_name, sg.group_id, sg.group_name, sg.quest_cnt from v_wcs_surveys s, v_wcs_survey_groups sg where s.survey_id = sg.survey_id and sg.survey_id != :SURVEY_ID">
            <SelectParameters>
                <asp:QueryStringParameter Name="SURVEY_ID" QueryStringField="survey_id" Type="String" />
            </SelectParameters>
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="sds" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="SURVEY_ID,GROUP_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow"
            ShowExportExcelButton="True">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="SURVEY_NAME" HeaderText="Анкета" SortExpression="SURVEY_NAME" />
                <asp:BoundField DataField="GROUP_NAME" HeaderText="Група" SortExpression="GROUP_NAME" />
                <asp:BoundField DataField="QUEST_CNT" HeaderText="Кол-во вопросов" SortExpression="QUEST_CNT" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
            <tr>
                <td class="actionButtonsContainer" colspan="2">
                    <asp:ImageButton ID="ibAdd" runat="server" ImageUrl="/Common/Images/default/16/ok.png"
                        ToolTip="Добавить" OnClick="ibAdd_Click" />
                    <asp:ImageButton ID="ibClose" runat="server" CausesValidation="False" SkinID="ibCancel"
                        OnClientClick="CloseDialog(null);" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
