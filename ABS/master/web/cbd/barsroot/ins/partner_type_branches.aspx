<%@ Page Title="Доступність СК у відділеннях" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="partner_type_branches.aspx.cs" Inherits="ins_partner_type_branches" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="Bars" %>
<%@ Register Src="~/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="Bars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" CancelSelectOnNullParameter="False">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsObjectDataSource ID="ods_tariffs" runat="server" SelectMethod="SelectTariffs"
        TypeName="Bars.Ins.VInsTariffs" DataObjectTypeName="Bars.Ins.VInsTariffsRecord">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="ods_fees" runat="server" SelectMethod="SelectFees"
        TypeName="Bars.Ins.VInsFees" DataObjectTypeName="Bars.Ins.VInsFeesRecord">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="ods_limits" runat="server" SelectMethod="SelectLimits"
        TypeName="Bars.Ins.VInsLimits" DataObjectTypeName="Bars.Ins.VInsLimitsRecord">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="ods_partners" runat="server" SelectMethod="SelectPartners"
        TypeName="Bars.Ins.VInsPartners">
    </bars:BarsObjectDataSource>
    <bars:BarsSqlDataSourceEx ID="sds_partners" runat="server" ProviderName="barsroot.core">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsObjectDataSource ID="ods_partner_types" runat="server" SelectMethod="SelectPartnerTypes"
        TypeName="Bars.Ins.VInsPartnerTypes" DataObjectTypeName="Bars.Ins.VInsPartnerTypesRecord">
    </bars:BarsObjectDataSource>
    <div class="content_container">
        <asp:ListView ID="lv" runat="server" DataKeyNames="ID,BRANCH,PARTNER_ID,TYPE_ID" DataSourceID="sds" OnItemInserting="lv_ItemInserting"
            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
            <LayoutTemplate>
                <table class="tbl_style2">
                    <thead>
                        <tr>
                            <th></th>
                            <th>
                                <asp:Label ID="BRANCH" runat="server" Text="Відділення" />
                            </th>
                            <th>
                                <asp:Label ID="PARTNER_ID" runat="server" Text="СК" />
                            </th>
                            <th>
                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                            </th>
                            <th>
                                <asp:Label ID="TARIFF_ID" runat="server" Text="Тариф" />
                            </th>
                            <th>
                                <asp:Label ID="FEE_ID" runat="server" Text="Комісія" />
                            </th>
                            <th>
                                <asp:Label ID="LIMIT_ID" runat="server" Text="Ліміт" />
                            </th>
                            <th>
                                <asp:Label ID="APPLY_HIER" runat="server" Text="Ієрарх." />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </tbody>
                    <tfoot id="tblPSFoot" runat="server">
                        <tr>
                            <td class="command">
                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                            </td>
                            <td colspan="7"></td>
                        </tr>
                    </tfoot>
                </table>
            </LayoutTemplate>
            <EmptyDataTemplate>
                <table class="tbl_style1">
                    <thead>
                        <tr>
                            <th></th>
                            <th>
                                <asp:Label ID="BRANCH" runat="server" Text="Відділення" />
                            </th>
                            <th>
                                <asp:Label ID="PARTNER_ID" runat="server" Text="СК" />
                            </th>
                            <th>
                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                            </th>
                            <th>
                                <asp:Label ID="TARIFF_ID" runat="server" Text="Тариф" />
                            </th>
                            <th>
                                <asp:Label ID="FEE_ID" runat="server" Text="Комісія" />
                            </th>
                            <th>
                                <asp:Label ID="LIMIT_ID" runat="server" Text="Ліміт" />
                            </th>
                            <th>
                                <asp:Label ID="APPLY_HIER" runat="server" Text="Ієрарх." />
                            </th>
                        </tr>
                    </thead>
                    <tfoot id="Tfoot1" runat="server">
                        <tr>
                            <td class="command">
                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                            </td>
                            <td colspan="7"></td>
                        </tr>
                    </tfoot>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <tr id="tr" runat="server">
                    <td class="command">
                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                            ImageUrl="/common/images/default/16/edit.png" ToolTip="Редагувати" />
                        <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                            ImageUrl="/common/images/default/16/delete.png" ToolTip="Видалити" />
                    </td>
                    <td>
                        <asp:Label ID="BRANCH" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("BRANCH"))) ? "Всі" : String.Format("{0} - {1}", Eval("BRANCH"), Eval("BRANCH_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="PARTNER_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("PARTNER_ID"))) ? "Всі" : String.Format("{0} - {1}", Eval("PARTNER_ID"), Eval("PARTNER_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="TYPE_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("TYPE_ID"))) ? "Всі" : String.Format("{0} - {1}", Eval("TYPE_ID"), Eval("TYPE_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="TARIFF_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("TARIFF_ID"))) ? "" : String.Format("{0} - {1}", Eval("TARIFF_ID"), Eval("TARIFF_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="FEE_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("FEE_ID"))) ? "" : String.Format("{0} - {1}", Eval("FEE_ID"), Eval("FEE_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="LIMIT_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("LIMIT_ID"))) ? "" : String.Format("{0} - {1}", Eval("LIMIT_ID"), Eval("LIMIT_NAME")) %>' />
                    </td>
                    <td align="center">
                        <asp:CheckBox ID="APPLY_HIER" runat="server" Enabled="false" Checked='<%# (Decimal?)Eval("APPLY_HIER") == 1 ? true : false %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr id="tr1" runat="server" class="edit">
                    <td class="command">
                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Fees"
                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                    </td>
                    <td>
                        <bars:TextBoxRefer ID="BRANCH" runat="server" TAB_NAME="BRANCH" KEY_FIELD="BRANCH"
                            SEMANTIC_FIELD="NAME" WHERE_CLAUSE="where date_closed is null" ORDERBY_CLAUSE="order by branch"
                            Width="200" Value='<%# Bind("BRANCH") %>' IsRequired="true" />
                    </td>
                    <td>
                        <bars:DDLList ID="PARTNER" runat="server" DataSourceID="ods_partners" DataTextField="NAME" OnDataBinding="PARTNER_DataBinding"
                            DataValueField="PARTNER_ID" SelectedValue='<%# Bind("PARTNER_ID") %>' IsRequired="false" EmptyItemText="Всі" OnValueChanged="PARTNER_ValueChanged" >
                        </bars:DDLList>
                    </td>
                    <td>
                        <bars:BarsObjectDataSource ID="ods_partner_types" runat="server" SelectMethod="SelectPartnerActiveTypes" TypeName="Bars.Ins.VInsPartnerTypes">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="PARTNER" PropertyName="SelectedValue" Name="PARTNER_ID" Type="Decimal" />
                            </SelectParameters>
                        </bars:BarsObjectDataSource>
                        <bars:DDLList ID="TYPE" runat="server" DataSourceID="ods_partner_types" DataTextField="TYPE_NAME"
                            DataValueField="TYPE_ID" SelectedValue='<%# Bind("TYPE_ID") %>' IsRequired="false" EmptyItemText="Всі">
                        </bars:DDLList>
                    </td>
                    <td>
                        <bars:DDLList ID="TARIFF" runat="server" DataSourceID="ods_tariffs" DataTextField="NAME"
                            DataValueField="TARIFF_ID" SelectedValue='<%# Bind("TARIFF_ID") %>' IsRequired="false">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbTARIFF" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowTariffs(this); " OnClick="lbTARIFF_Click"></asp:LinkButton>
                    </td>
                    <td>
                        <bars:DDLList ID="FEE" runat="server" DataSourceID="ods_fees" DataTextField="NAME"
                            DataValueField="FEE_ID" SelectedValue='<%# Bind("FEE_ID") %>'>
                        </bars:DDLList>
                        <asp:LinkButton ID="lbFEE" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowFees(this); " OnClick="lbFEE_Click"></asp:LinkButton>
                    </td>
                    <td>
                        <bars:DDLList ID="LIMIT" runat="server" DataSourceID="ods_limits" DataTextField="NAME"
                            DataValueField="LIMIT_ID" SelectedValue='<%# Bind("LIMIT_ID") %>'>
                        </bars:DDLList>
                        <asp:LinkButton ID="lbLIMIT" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowLimits(this); " OnClick="lbLIMIT_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="APPLY_HIER" runat="server" Value='<%# Bind("APPLY_HIER") %>' IsRequired="true" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr id="tr2" runat="server" class="new">
                    <td class="command">
                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Fees"
                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" />
                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                    </td>
                    <td>
                        <% /*bars:TextBoxRefer ID="BRANCH" runat="server" TAB_NAME="BRANCH" KEY_FIELD="BRANCH"
                            SEMANTIC_FIELD="NAME" WHERE_CLAUSE="where date_closed is null" ORDERBY_CLAUSE="order by branch"
                            Width="200" Value='<%# Bind("BRANCH") ' IsRequired="true" />*/%>
                        <% /*bars:DDLList ID="DDLList1" runat="server" DataSourceID="sds_partners" DataTextField="NAME"
                            DataValueField="PARTNER_ID"  SelectedValue='<%# Bind("PARTNER_ID")' IsRequired="false" EmptyItemText="Всі" >
                        <*/ %>
                        <asp:ListBox ID="BRANCH" runat="server" Height="200px" OnPreRender="BRANCH_LB_DataBinding" EnableViewState="true" SelectionMode="Multiple" />
                        
                    </td>
                    <td>
                        <bars:DDLList ID="PARTNER" runat="server" DataSourceID="sds_partners" DataTextField="NAME"
                            DataValueField="PARTNER_ID" SelectedValue='<%# Bind("PARTNER_ID") %>' IsRequired="false" EmptyItemText="Всі" OnValueChanged="PARTNER_ValueChanged" >
                        </bars:DDLList>
                    </td>
                    <td>
                        <% /*<bars:BarsObjectDataSource ID="ods_partner_types" runat="server" SelectMethod="SelectPartnerActiveTypes" TypeName="Bars.Ins.VInsPartnerTypes">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="PARTNER" PropertyName="SelectedValue" Name="PARTNER_ID" Type="Decimal" />
                            </SelectParameters>
                        </bars:BarsObjectDataSource>
                        <bars:DDLList ID="TYPE" runat="server" DataSourceID="ods_partner_types" DataTextField="TYPE_NAME"
                            DataValueField="TYPE_ID" SelectedValue='<%# Bind("TYPE_ID") ' IsRequired="false" EmptyItemText="Всі">
                        </bars:DDLList>*/%>
                        <asp:ListBox ID="TYPE_ID" runat="server" EnableViewState="true" SelectionMode="Multiple" />
                    </td>
                    <td>
                        <bars:DDLList ID="TARIFF" runat="server" DataSourceID="ods_tariffs" DataTextField="NAME"
                            DataValueField="TARIFF_ID" SelectedValue='<%# Bind("TARIFF_ID") %>' IsRequired="false">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbTARIFF" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowTariffs(this); " OnClick="lbTARIFF_Click"></asp:LinkButton>
                    </td>
                    <td>
                        <bars:DDLList ID="FEE" runat="server" DataSourceID="ods_fees" DataTextField="NAME"
                            DataValueField="FEE_ID" SelectedValue='<%# Bind("FEE_ID") %>'>
                        </bars:DDLList>
                        <asp:LinkButton ID="lbFEE" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowFees(this); " OnClick="lbFEE_Click"></asp:LinkButton>
                    </td>
                    <td>
                        <bars:DDLList ID="LIMIT" runat="server" DataSourceID="ods_limits" DataTextField="NAME"
                            DataValueField="LIMIT_ID" SelectedValue='<%# Bind("LIMIT_ID") %>'>
                        </bars:DDLList>
                        <asp:LinkButton ID="lbLIMIT" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowLimits(this); " OnClick="lbLIMIT_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="APPLY_HIER" runat="server" Value='<%# Bind("APPLY_HIER") %>' IsRequired="true" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
