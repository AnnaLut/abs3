<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsgarantees.aspx.cs" Inherits="credit_constructor_wcsgarantees"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Обеспечение"
    Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../constructor/usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsGarantees"
            SortParameterName="SortExpression"></asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="GARANTEE_ID" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="GARANTEE_ID" HeaderText="Идентификатор" SortExpression="GARANTEE_ID" />
                <asp:BoundField DataField="GARANTEE_NAME" HeaderText="Наименование" SortExpression="GARANTEE_NAME" />
                <asp:BoundField DataField="SCOPY_NAME" HeaderText="Карта сканкопий" SortExpression="SCOPY_NAME" />
                <asp:BoundField DataField="SURVEY_NAME" HeaderText="Анкета" SortExpression="SURVEY_NAME" />
                <asp:BoundField DataField="INS_CNT" HeaderText="Кол-во страховок" SortExpression="INS_CNT" />
                <asp:BoundField DataField="TPL_CNT" HeaderText="Кол-во шаблонов" SortExpression="TPL_CNT" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <Bars:BarsObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsGaranteesRecord"
            SelectMethod="SelectGarantee" TypeName="credit.VWcsGarantees" UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="GARANTEE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsObjectDataSource ID="odsVWcsScancopies" runat="server" SelectMethod="Select"
            TypeName="credit.VWcsScancopies">
        </Bars:BarsObjectDataSource>
        <Bars:BarsObjectDataSource ID="odsVWcsSurveys" runat="server" SelectMethod="Select"
            TypeName="credit.VWcsSurveys">
        </Bars:BarsObjectDataSource>
        <Bars:BarsObjectDataSource ID="odsVWcsGaranteeInsurances" runat="server" SelectMethod="SelectGaranteeInsurances"
            TypeName="credit.VWcsGaranteeInsurances" DataObjectTypeName="credit.VWcsGaranteeInsurancesRecord">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="GARANTEE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" SelectCommand="select * from ins_types it where nvl(it.object_type, 'GRT') = 'GRT'"
            AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsObjectDataSource ID="odsVWcsGaranteeTemplates" runat="server" SelectMethod="SelectGaranteeTemplates"
            TypeName="credit.VWcsGaranteeTemplates">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="GARANTEE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsSqlDataSourceEx ID="sdsAVGaranteeTemplates" runat="server" SelectCommand="select t.template_id, t.template_name from v_wcs_templates t"
            AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <asp:ObjectDataSource ID="odsWcsPrintStates" runat="server" SelectMethod="SelectPrintStates"
            TypeName="credit.WcsPrintStates"></asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="GARANTEE_ID" DataSourceID="odsFV"
            OnItemUpdated="fv_ItemUpdated" CssClass="formView" EnableModelValidation="True">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="GARANTEE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="GARANTEE_ID" runat="server" Text='<%# Bind("GARANTEE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="GARANTEE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <asp:Label ID="GARANTEE_NAME" runat="server" Text='<%# Bind("GARANTEE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SCOPY_IDTitle" runat="server" Text="Карта сканкопий :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="SCOPY_ID" runat="server" DataSourceID="odsVWcsScancopies" DataValueField="SCOPY_ID"
                                DataTextField="SCOPY_NAME" SelectedValue='<%# Bind("SCOPY_ID") %>' IsRequired="false"
                                ValidationGroup="Main">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text="Анкета :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SURVEY_ID" runat="server" DataSourceID="odsVWcsSurveys" DataValueField="SURVEY_ID"
                                DataTextField="SURVEY_NAME" SelectedValue='<%# Bind("SURVEY_ID") %>' IsRequired="true"
                                ValidationGroup="Main">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                ToolTip="Сохранить" ValidationGroup="Main" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:Panel ID="pnlInsurances" runat="server" GroupingText="Страховки">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsGaranteeInsurances" DataTextField="INSURANCE_NAME"
                                                DataValueField="INSURANCE_ID" Height="200px" Width="300px" OnDataBound="lb_DataBound"
                                                AutoPostBack="True" OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                            <table border="0" cellpadding="3" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibUp" runat="server" ImageUrl="/Common/Images/default/16/arrow_up.png"
                                                            ToolTip="Переместить вверх" CausesValidation="False" OnClick="ibUp_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibDown" runat="server" ImageUrl="/Common/Images/default/16/arrow_down.png"
                                                            ToolTip="Переместить вниз" CausesValidation="False" OnClick="ibDown_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibDelete" runat="server" ImageUrl="/Common/Images/default/16/cancel.png"
                                                            ToolTip="Удалить" CausesValidation="False" OnClick="ibDelete_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                            ToolTip="Добавить новый" CausesValidation="False" OnClick="ibNew_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Тип страховки" Height="200px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="INSURANCE_IDTitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="INSURANCE_ID" runat="server" DataSourceID="sds" DataValueField="ID"
                                                                DataTextField="NAME" Width="300px" IsRequired="true" ValidationGroup="InsParams">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="titleCell">
                                                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательная :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="false" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                                            <asp:Button ID="btSave" runat="server" Text="Сохранить" ValidationGroup="InsParams"
                                                                OnClick="btSave_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:Panel ID="pnlTemplates" runat="server" GroupingText="Документы для печати">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lbTemplates" runat="server" DataSourceID="odsVWcsGaranteeTemplates"
                                                DataTextField="TEMPLATE_NAME" DataValueField="TEMPLATE_ID" Height="200px" Width="300px"
                                                OnDataBound="lbTemplates_DataBound" AutoPostBack="True" OnSelectedIndexChanged="lbTemplates_SelectedIndexChanged">
                                            </asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                            <table border="0" cellpadding="3" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibTemplatesDelete" runat="server" ImageUrl="/Common/Images/default/16/cancel.png"
                                                            ToolTip="Удалить" CausesValidation="False" OnClick="ibTemplatesDelete_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="ibTemplatesNew" runat="server" ImageUrl="/Common/Images/default/16/new.png"
                                                            ToolTip="Добавить новый" CausesValidation="False" OnClick="ibTemplatesNew_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlTemplatesParams" runat="server" GroupingText="Шаблоны" Height="200px"
                                                Width="450px" HorizontalAlign="Left">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="TEMPLATE_ID" runat="server" DataSourceID="sdsAVGaranteeTemplates"
                                                                DataValueField="TEMPLATE_ID" DataTextField="TEMPLATE_NAME" Width="300px" IsRequired="true"
                                                                ValidationGroup="TplParams">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="PRINT_STATE_IDTitle" runat="server" Text="Этап :" />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="PRINT_STATE_ID" runat="server" DataSourceID="odsWcsPrintStates"
                                                                DataValueField="ID" DataTextField="NAME" IsRequired="true" ValidationGroup="TplParams">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_SCAN_REQUIREDTitle" runat="server" Text="Обязательное сканирование :" />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_SCAN_REQUIRED" IsRequired="false" DefaultValue="true" runat="server"
                                                                ValidationGroup="TplParams" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="actionButtonsContainer" colspan="2" style="text-align: right">
                                                            <asp:Button ID="btTemplatesSave" runat="server" Text="Сохранить" ValidationGroup="TplParams"
                                                                OnClick="btTemplatesSave_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="GARANTEE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="GARANTEE_ID" runat="server" Text='<%# Bind("GARANTEE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="GARANTEE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <asp:Label ID="GARANTEE_NAME" runat="server" Text='<%# Bind("GARANTEE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SCOPY_IDTitle" runat="server" Text="Карта скнкопий :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SCOPY_ID" runat="server" DataSourceID="odsVWcsScancopies" DataValueField="SCOPY_ID"
                                DataTextField="SCOPY_NAME" SelectedValue='<%# Bind("SCOPY_ID") %>' Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text="Анкета :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SURVEY_ID" runat="server" DataSourceID="odsVWcsSurveys" DataValueField="SURVEY_ID"
                                DataTextField="SURVEY_NAME" SelectedValue='<%# Bind("SURVEY_ID") %>' Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:Panel ID="pnlInsurances" runat="server" GroupingText="Страховки">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lb" runat="server" DataSourceID="odsVWcsGaranteeInsurances" DataTextField="INSURANCE_NAME"
                                                DataValueField="INSURANCE_ID" Height="200px" Width="300px" OnDataBound="lb_DataBound"
                                                AutoPostBack="True" OnSelectedIndexChanged="lb_SelectedIndexChanged"></asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlParams" runat="server" GroupingText="Тип страховки" Height="200px"
                                                Width="450px" HorizontalAlign="Left" Enabled="false">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="INSURANCE_IDTitle" runat="server" Text='Идентификатор :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="INSURANCE_ID" runat="server" DataSourceID="sds" DataValueField="ID"
                                                                DataTextField="NAME">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязательная :' />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="false" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:Panel ID="pnlTemplates" runat="server" GroupingText="Документы для печати">
                                <table border="0" cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:ListBox ID="lbTemplates" runat="server" DataSourceID="odsVWcsGaranteeTemplates"
                                                DataTextField="TEMPLATE_NAME" DataValueField="TEMPLATE_ID" Height="200px" Width="300px"
                                                OnDataBound="lbTemplates_DataBound" AutoPostBack="True" OnSelectedIndexChanged="lbTemplates_SelectedIndexChanged">
                                            </asp:ListBox>
                                        </td>
                                        <td valign="middle" align="center" style="width: 50px">
                                        </td>
                                        <td valign="top">
                                            <asp:Panel ID="pnlTemplatesParams" runat="server" GroupingText="Шаблоны" Height="200px"
                                                Width="450px" HorizontalAlign="Left" Enabled="false">
                                                <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                                                    <col class="titleCell" />
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text='Наименование :' />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="TEMPLATE_ID" runat="server" DataSourceID="sdsAVGaranteeTemplates"
                                                                DataValueField="TEMPLATE_ID" DataTextField="TEMPLATE_NAME" Width="300px" ValidationGroup="TplParams">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="PRINT_STATE_IDTitle" runat="server" Text="Этап :" />
                                                        </td>
                                                        <td>
                                                            <bec:DDLList ID="PRINT_STATE_ID" runat="server" DataSourceID="odsWcsPrintStates"
                                                                DataValueField="ID" DataTextField="NAME" ValidationGroup="TplParams">
                                                            </bec:DDLList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="IS_SCAN_REQUIREDTitle" runat="server" Text="Обязательное сканирование :" />
                                                        </td>
                                                        <td>
                                                            <bec:RBLFlag ID="IS_SCAN_REQUIRED" IsRequired="false" DefaultValue="true" runat="server"
                                                                ValidationGroup="TplParams" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
