<%@ Page Title="Акредитовані СК {0}" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="partners.aspx.cs" Inherits="ins_partners" %>
<%@ MasterType VirtualPath="~/ins/ins_master.master" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div class="content_container">
        <div class="gridview_container">
            <bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core">
                <SelectParameters>
                    <asp:QueryStringParameter Name="p_custid" QueryStringField="custtype" Type="Int32" Direction="Input" />
                </SelectParameters>
            </bars:BarsSqlDataSourceEx>
            <bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                CssClass="barsGridView" DataSourceID="sds" DateMask="dd.MM.yyyy" EnableModelValidation="True"
                ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                ShowExportExcelButton="True" AllowSorting="True" DataKeyNames="PARTNER_ID" AutoSelectFirstRow="true"
                JavascriptSelectionType="ServerSelect">
                <NewRowStyle CssClass=""></NewRowStyle>
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="PARTNER_ID" HeaderText="Ід." SortExpression="PARTNER_ID"></asp:BoundField>
                    <asp:BoundField DataField="NAME" HeaderText="Найменування" SortExpression="NAME"></asp:BoundField>
                    <asp:TemplateField HeaderText="Найменування (контрагент)" SortExpression="NAME_FULL">
                        <ItemTemplate>
                            <bars:LabelTooltip ID="NAME_FULL" runat="server" Text='<%# Eval("NAME_FULL") %>'
                                UseTextForTooltip="false" ToolTip='<%# String.Format("{0} ({1}), ІПН: {2}, тел.: {3}, МФО: {4}, рах.: {5}, адреса: {6}", Eval("NAME_FULL"), Eval("NAME_SHORT"), Eval("INN"), Eval("TEL"), Eval("MFO"), Eval("NLS"), Eval("ADR")) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CUSNAME" HeaderText="Тип (контрагент)" SortExpression="CUSNAME" Visible="false"></asp:BoundField>
                    <asp:BoundField DataField="INN" HeaderText="ЄДРПОУ" SortExpression="INN"></asp:BoundField>
                    <asp:BoundField DataField="AGR_NO" HeaderText="№ договору" SortExpression="AGR_NO"></asp:BoundField>
                    <asp:BoundField DataField="AGR_SDATE" DataFormatString="{0:d}" HeaderText="Початок дії"
                        SortExpression="AGR_SDATE">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="AGR_EDATE" DataFormatString="{0:d}" HeaderText="Кінець дії"
                        SortExpression="AGR_EDATE">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TARIFF_NAME" HeaderText="Тариф" SortExpression="TARIFF_NAME"></asp:BoundField>
                    <asp:BoundField DataField="FEE_NAME" HeaderText="Комісія" SortExpression="FEE_NAME"></asp:BoundField>
                    <asp:BoundField DataField="LIMIT_NAME" HeaderText="Ліміт" SortExpression="LIMIT_NAME"></asp:BoundField>
                    <asp:TemplateField HeaderText="Активно" SortExpression="ACTIVE">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbActive" runat="server" Enabled="false" Checked='<%# (Decimal?)Eval("ACTIVE") == 1 ? true : false %>' />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
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
        <div class="formview_container">
            <bars:BarsObjectDataSource ID="ods_fv" runat="server" SelectMethod="SelectPartner"
                TypeName="Bars.Ins.VInsPartners" DataObjectTypeName="Bars.Ins.VInsPartnersRecord"
                InsertMethod="Insert" UpdateMethod="Update" DeleteMethod="Delete">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gv" Name="PARTNER_ID" PropertyName="SelectedValue"
                        Type="Decimal" />
                </SelectParameters>
            </bars:BarsObjectDataSource>
            <bars:BarsObjectDataSource ID="odsPartnerTypes" runat="server" SelectMethod="SelectPartnerTypes"
                TypeName="Bars.Ins.VInsPartnerTypes" DataObjectTypeName="Bars.Ins.VInsPartnerTypesRecord"
                UpdateMethod="Update">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gv" Name="PARTNER_ID" PropertyName="SelectedValue"
                        Type="Decimal" />
                </SelectParameters>
            </bars:BarsObjectDataSource>
            <bars:BarsObjectDataSource ID="ods_tariffs" runat="server" SelectMethod="SelectTariffs"
                TypeName="Bars.Ins.VInsTariffs" DataObjectTypeName="Bars.Ins.VInsTariffsRecord">
            </bars:BarsObjectDataSource>
            <bars:BarsObjectDataSource ID="ods_fees" runat="server" SelectMethod="SelectFees"
                TypeName="Bars.Ins.VInsFees" DataObjectTypeName="Bars.Ins.VInsFeesRecord">
            </bars:BarsObjectDataSource>
            <bars:BarsObjectDataSource ID="ods_limits" runat="server" SelectMethod="SelectLimits"
                TypeName="Bars.Ins.VInsLimits" DataObjectTypeName="Bars.Ins.VInsLimitsRecord">
            </bars:BarsObjectDataSource>
            <asp:FormView ID="fv" runat="server" DataKeyNames="PARTNER_ID,CUSTID" DataSourceID="ods_fv"
                EnableModelValidation="True" OnItemInserting="fv_ItemInserting" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
                Width="100%" OnItemUpdating="fv_ItemUpdating">
                <ItemTemplate>
                    <div class="template_container">
                        <table id="tblPartners" border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="PARTNERTitle" runat="server" Text="Ід. / Найменування: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="PARTNER" runat="server" Text='<%# String.Format("{0} / {1}", Eval("PARTNER_ID"), Eval("NAME"))  %>' />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="ACTIVETitle" runat="server" Text="Активно: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:RBLFlag ID="ACTIVE" runat="server" Enabled="false" Value='<%# Eval("ACTIVE") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="RNKTitle" runat="server" Text="РНК (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="RNK" runat="server" Text='<%# Eval("RNK") %>' />
                                                    <asp:LinkButton ID="lbBranchRnk" runat="server" Text="(По відділеннях)"
                                                        OnClientClick='<%# String.Format("return ShowBranchRnk({0}); ", Eval("PARTNER_ID")) %>'></asp:LinkButton>
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="AGR_NOTitle" runat="server" Text="Номер договору: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="AGR_NO" runat="server" Text='<%# Eval("AGR_NO") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="NAMETitle" runat="server" Text="Назва (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="NAME" runat="server" Text='<%# String.Format("{0} ({1})", Eval("NAME_FULL"), Eval("NAME_SHORT"))%>' />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="AGR_DATETitle" runat="server" Text="Дата договору: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="AGR_DATE" runat="server" Text='<%# String.Format("з {0:d} по {1:d}", Eval("AGR_SDATE"), Eval("AGR_EDATE")) %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="INNTitle" runat="server" Text="ЄДРПОУ (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="INN" runat="server" Text='<%# Eval("INN") %>' />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="TARIFFTitle" runat="server" Text="Тариф: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="TARIFF" runat="server" Text='<%# String.IsNullOrEmpty((String)Eval("TARIFF_ID")) ? "" : String.Format("{0} - {1}", Eval("TARIFF_ID"), Eval("TARIFF_NAME")) %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="MFONLSTitle" runat="server" Text="МФО / № рах (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="MFONLS" runat="server" Text='<%# String.IsNullOrEmpty((String)Eval("MFO")) && String.IsNullOrEmpty((String)Eval("NLS")) ? "" : String.Format("{0} / {1}", Eval("MFO"), Eval("NLS")) %>' />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="FEETitle" runat="server" Text="Комісія: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="FEE" runat="server" Text='<%# String.IsNullOrEmpty((String)Eval("FEE_ID")) ? "" : String.Format("{0} - {1}", Eval("FEE_ID"), Eval("FEE_NAME")) %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="TELADRTitle" runat="server" Text="Тел., адреса (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="TELADR" runat="server" Text='<%# String.Format("тел.: {0}, адреса: {1}", Eval("TEL"), Eval("ADR")) %>' />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="LIMITTitle" runat="server" Text="Ліміт: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="LIMIT" runat="server" Text='<%# String.IsNullOrEmpty((String)Eval("LIMIT_ID")) ? "" : String.Format("{0} - {1}", Eval("LIMIT_ID"), Eval("LIMIT_NAME")) %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="Label1" runat="server" Text="Тип (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CUSNAME") %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlTypes" runat="server" GroupingText="Типи">
                                        <asp:ListView ID="lvPartnerTypes" runat="server" DataKeyNames="PARTNER_ID,TYPE_ID" DataSourceID="odsPartnerTypes">
                                            <LayoutTemplate>
                                                <table class="tbl_style1">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                <asp:Label ID="ACTIVE" runat="server" Text="Акт." />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="TYPE_NAME" runat="server" Text="Найменування" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="TARIFF_NAME" runat="server" Text="Тариф" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="FEE_NAME" runat="server" Text="Комісія" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="LIMIT_NAME" runat="server" Text="Ліміт" />
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr runat="server" id="itemPlaceholder">
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr id="tr" runat="server">
                                                    <td align="center">
                                                        <asp:CheckBox ID="ACTIVE" runat="server" Enabled="false" Checked='<%# (Decimal?)Eval("ACTIVE") == 1 ? true : false %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="TYPE_NAME" runat="server" Text='<%# Eval("TYPE_NAME") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="TARIFF_NAME" runat="server" Text='<%# Eval("TARIFF_NAME") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="FEE_NAME" runat="server" Text='<%# Eval("FEE_NAME") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="LIMIT_NAME" runat="server" Text='<%# Eval("LIMIT_NAME") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="buttons_container2">
                                    <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                        ImageUrl="/common/images/default/16/edit.png" ToolTip="Редагувати" />
                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                        ImageUrl="/common/images/default/16/new.png" ToolTip="Додати нову" />
                                    <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                        ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" OnClientClick="if( confirm('Видалити СК?')) return true; else return false" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </ItemTemplate>
                <EditItemTemplate>
                    <div class="template_container">
                        <table id="tblPartners" border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметри">
                                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="PARTNERTitle" runat="server" Text="Найменування: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                                        Width="200px" ValidationGroup="Partner" TabIndex="101" />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="ACTIVETitle" runat="server" Text="Активно: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:RBLFlag ID="ACTIVE" runat="server" Value='<%# Bind("ACTIVE") %>' IsRequired="true"
                                                        ValidationGroup="Partner" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="RNKTitle" runat="server" Text="РНК (контрагент): " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:TextBoxRefer ID="RNK" runat="server" TAB_NAME="V_INS_CORPS" KEY_FIELD="RNK"
                                                        SEMANTIC_FIELD="NAME_FULL" SHOW_FIELDS="NAME_SHORT,INN,TEL,MFO,NLS,ADR" IsRequired="false"
                                                        ValidationGroup="Partner" Width="200" Value='<%# Bind("RNK") %>' TabIndex="102" />
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="AGR_NOTitle" runat="server" Text="Номер договору: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:TextBoxString ID="AGR_NO" runat="server" Value='<%# Bind("AGR_NO") %>' IsRequired="false"
                                                        ValidationGroup="Partner" TabIndex="111" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="RNKBr" runat="server" Text="РНК СК у відділеннях: " />
                                                </td>
                                                <td class="stl2">
                                                    <asp:LinkButton ID="lbBranchRnk" runat="server" Text="(По відділеннях)"
                                                         OnClientClick='<%# String.Format("return ShowBranchRnk({0}); ", Eval("PARTNER_ID")) %>'></asp:LinkButton>
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="AGR_SDATETitle" runat="server" Text="Дата договору З: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:TextBoxDate ID="AGR_SDATE" runat="server" Value='<%# Bind("AGR_SDATE") %>'
                                                        IsRequired="false" ValidationGroup="Partner" TabIndex="112" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="TARIFFTitle" runat="server" Text="Тариф: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:DDLList ID="TARIFF" runat="server" DataSourceID="ods_tariffs" DataTextField="NAME"
                                                        DataValueField="TARIFF_ID" SelectedValue='<%# Bind("TARIFF_ID") %>' TabIndex="103" IsRequired="false"
                                                        ValidationGroup="Partner">
                                                    </bars:DDLList>
                                                    <asp:LinkButton ID="lbTARIFF" runat="server" Text="(Редагувати)"
                                                        TabIndex="104" OnClientClick="return ShowTariffs(this); " OnClick="lbTARIFF_Click"></asp:LinkButton>
                                                </td>
                                                <td class="stl1">
                                                    <asp:Label ID="AGR_EDATETitle" runat="server" Text="Дата договору ПО: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:TextBoxDate ID="AGR_EDATE" runat="server" Value='<%# Bind("AGR_EDATE") %>'
                                                        IsRequired="false" ValidationGroup="Partner" TabIndex="113" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="FEETitle" runat="server" Text="Комісія: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:DDLList ID="FEE" runat="server" DataSourceID="ods_fees" DataTextField="NAME"
                                                        DataValueField="FEE_ID" SelectedValue='<%# Bind("FEE_ID") %>' TabIndex="105"
                                                        ValidationGroup="Partner">
                                                    </bars:DDLList>
                                                    <asp:LinkButton ID="lbFEE" runat="server" Text="(Редагувати)"
                                                        TabIndex="106" OnClientClick="return ShowFees(this); " OnClick="lbFEE_Click"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="stl1">
                                                    <asp:Label ID="LIMITTitle" runat="server" Text="Ліміт: " />
                                                </td>
                                                <td class="stl2">
                                                    <bars:DDLList ID="LIMIT" runat="server" DataSourceID="ods_limits" DataTextField="NAME"
                                                        DataValueField="LIMIT_ID" SelectedValue='<%# Bind("LIMIT_ID") %>' TabIndex="107"
                                                        ValidationGroup="Partner">
                                                    </bars:DDLList>
                                                    <asp:LinkButton ID="lbLIMIT" runat="server" Text="(Редагувати)"
                                                        TabIndex="108" OnClientClick="return ShowLimits(this); " OnClick="lbLIMIT_Click"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="pnlTypes" runat="server" GroupingText="Типи">
                                        <asp:ListView ID="lvPartnerTypes" runat="server" DataKeyNames="PARTNER_ID,TYPE_ID" DataSourceID="odsPartnerTypes">
                                            <LayoutTemplate>
                                                <table class="tbl_style1">
                                                    <thead>
                                                        <tr>
                                                            <th>
                                                                <asp:Label ID="ACTIVE" runat="server" Text="Акт." />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="TYPE_NAME" runat="server" Text="Найменування" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="TARIFF_NAME" runat="server" Text="Тариф" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="FEE_NAME" runat="server" Text="Комісія" />
                                                            </th>
                                                            <th>
                                                                <asp:Label ID="LIMIT_NAME" runat="server" Text="Ліміт" />
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr runat="server" id="itemPlaceholder">
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr id="tr" runat="server">
                                                    <td align="center">
                                                        <bars:RBLFlag ID="ACTIVE" runat="server" Value='<%# Bind("ACTIVE") %>' IsRequired="true" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="TYPE_NAME" runat="server" Text='<%# Eval("TYPE_NAME") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="TARIFF" runat="server" DataSourceID="ods_tariffs" DataTextField="NAME"
                                                            DataValueField="TARIFF_ID" SelectedValue='<%# Bind("TARIFF_ID") %>' ValidationGroup="PartnerType"
                                                            TabIndex="201">
                                                        </bars:DDLList>
                                                        <asp:LinkButton ID="lbTARIFF" runat="server" Text="(Редагувати)"
                                                            OnClientClick="return ShowTariffs(this); " OnClick="lbTARIFF_Click"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="FEE" runat="server" DataSourceID="ods_fees" DataTextField="NAME"
                                                            DataValueField="FEE_ID" SelectedValue='<%# Bind("FEE_ID") %>' ValidationGroup="PartnerType"
                                                            TabIndex="202">
                                                        </bars:DDLList>
                                                        <asp:LinkButton ID="lbFEE" runat="server" Text="(Редагувати)"
                                                            OnClientClick="return ShowFees(this); " OnClick="lbFEE_Click" TabIndex="203"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <bars:DDLList ID="LIMIT" runat="server" DataSourceID="ods_limits" DataTextField="NAME"
                                                            DataValueField="LIMIT_ID" SelectedValue='<%# Bind("LIMIT_ID") %>' ValidationGroup="PartnerType"
                                                            TabIndex="204">
                                                        </bars:DDLList>
                                                        <asp:LinkButton ID="lbLIMIT" runat="server" Text="(Редагувати)"
                                                            OnClientClick="return ShowLimits(this); " OnClick="lbLIMIT_Click" TabIndex="205"></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </asp:Panel>
                                </td>
                            </tr>
                            <tr>
                                <td class="buttons_container2">
                                    <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Partner"
                                        CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти"
                                        TabIndex="999" />
                                    <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                        ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="1000" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <div class="template_container">
                        <table id="tblPartners" border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="PARTNERTitle" runat="server" Text="Найменування: " />
                                </td>
                                <td class="stl2">
                                    <bars:TextBoxString ID="NAME" runat="server" Value='<%# Bind("NAME") %>' IsRequired="true"
                                        Width="200px" ValidationGroup="Partner" TabIndex="301" />
                                </td>
                                <td class="stl1">
                                    <asp:Label ID="ACTIVETitle" runat="server" Text="Активно: " />
                                </td>
                                <td class="stl2">
                                    <bars:RBLFlag ID="ACTIVE" runat="server" Value='<%# Bind("ACTIVE") %>' IsRequired="true"
                                        ValidationGroup="Partner" />
                                </td>
                            </tr>
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="RNKTitle" runat="server" Text="РНК (контрагент): " />
                                </td>
                                <td class="stl2">
                                    <table border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <bars:TextBoxRefer ID="RNK" runat="server" TAB_NAME="V_INS_CORPS" KEY_FIELD="RNK"
                                                    SEMANTIC_FIELD="NAME_FULL" SHOW_FIELDS="NAME_SHORT,INN,TEL,MFO,NLS,ADR" IsRequired="false"
                                                    Width="200" Value='<%# Bind("RNK") %>' ValidationGroup="Partner" TabIndex="302" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="stl1">
                                    <asp:Label ID="AGR_NOTitle" runat="server" Text="Номер договору: " />
                                </td>
                                <td class="stl2">
                                    <bars:TextBoxString ID="AGR_NO" runat="server" Value='<%# Bind("AGR_NO") %>' IsRequired="false"
                                        ValidationGroup="Partner" TabIndex="311" />
                                </td>
                            </tr>
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="RNKBr" runat="server" Text="РНК СК у відділеннях: " Visible="false" />
                                </td>
                                <td class="stl2">
                                    <asp:LinkButton ID="lbBranchRnk" runat="server" Text="(По відділеннях)" Visible="false"
                                         OnClientClick='<%# String.Format("return ShowBranchRnk({0}); ", Eval("PARTNER_ID")) %>'></asp:LinkButton>
                                </td>
                                <td class="stl1">
                                    <asp:Label ID="AGR_SDATETitle" runat="server" Text="Дата договору З: " />
                                </td>
                                <td class="stl2">
                                    <bars:TextBoxDate ID="AGR_SDATE" runat="server" Value='<%# Bind("AGR_SDATE") %>'
                                        IsRequired="false" ValidationGroup="Partner" TabIndex="312" />
                                </td>
                            </tr>
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="TARIFFTitle" runat="server" Text="Тариф: " />
                                </td>
                                <td class="stl2">
                                    <bars:DDLList ID="TARIFF" runat="server" DataSourceID="ods_tariffs" DataTextField="NAME"
                                        DataValueField="TARIFF_ID" SelectedValue='<%# Bind("TARIFF_ID") %>' TabIndex="303">
                                    </bars:DDLList>
                                    <asp:LinkButton ID="lbTARIFF" runat="server" Text="(Редагувати)"
                                        TabIndex="304" OnClientClick="return ShowTariffs(this); " OnClick="lbTARIFF_Click"></asp:LinkButton>
                                </td>
                                <td class="stl1">
                                    <asp:Label ID="AGR_EDATETitle" runat="server" Text="Дата договору ПО: " />
                                </td>
                                <td class="stl2">
                                    <bars:TextBoxDate ID="AGR_EDATE" runat="server" Value='<%# Bind("AGR_EDATE") %>'
                                        IsRequired="false" ValidationGroup="Partner" TabIndex="313" />
                                </td>
                            </tr>
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="FEETitle" runat="server" Text="Комісія: " />
                                </td>
                                <td class="stl2">
                                    <bars:DDLList ID="FEE" runat="server" DataSourceID="ods_fees" DataTextField="NAME"
                                        DataValueField="FEE_ID" SelectedValue='<%# Bind("FEE_ID") %>' TabIndex="305">
                                    </bars:DDLList>
                                    <asp:LinkButton ID="lbFEE" runat="server" Text="(Редагувати)"
                                        TabIndex="306" OnClientClick="return ShowFees(this); " OnClick="lbFEE_Click"></asp:LinkButton>
                                </td>
                                <td class="stl1"></td>
                                <td class="stl2"></td>
                            </tr>
                            <tr>
                                <td class="stl1">
                                    <asp:Label ID="LIMITTitle" runat="server" Text="Ліміт: " />
                                </td>
                                <td class="stl2">
                                    <bars:DDLList ID="LIMIT" runat="server" DataSourceID="ods_limits" DataTextField="NAME"
                                        DataValueField="LIMIT_ID" SelectedValue='<%# Bind("LIMIT_ID") %>' TabIndex="314">
                                    </bars:DDLList>
                                    <asp:LinkButton ID="lbLIMIT" runat="server" Text="(Редагувати)"
                                        TabIndex="315" OnClientClick="return ShowLimits(this); " OnClick="lbLIMIT_Click"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" class="buttons_container2">
                                    <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Partner"
                                        CommandName="Insert" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти"
                                        TabIndex="316" />
                                    <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                        ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" TabIndex="317" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </InsertItemTemplate>
                <EmptyDataTemplate>
                    <div class="template_container">
                        <table id="tblPartners" border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td class="buttons_container2">
                                    <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                        ImageUrl="/common/images/default/16/new.png" ToolTip="Додати нову" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </EmptyDataTemplate>
            </asp:FormView>
        </div>
    </div>
</asp:Content>
