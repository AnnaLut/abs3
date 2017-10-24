<%@ Page Title="Cканкопії СК та типів" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="partner_type_scans.aspx.cs" Inherits="ins_partner_type_scans" %>

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
    <bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core">
    </bars:BarsSqlDataSourceEx>
    <bars:BarsSqlDataSourceEx ID="sds_partners" runat="server" ProviderName="barsroot.core">
        <SelectParameters>
            <asp:QueryStringParameter Name="p_custid" QueryStringField="custtype" Type="Int32" Direction="Input" />
        </SelectParameters>
    </bars:BarsSqlDataSourceEx>
    <bars:BarsObjectDataSource ID="ods_partners" runat="server" SelectMethod="SelectPartners" TypeName="Bars.Ins.VInsPartners">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="ods_scans" runat="server" SelectMethod="SelectScans" TypeName="Bars.Ins.VInsScans">
    </bars:BarsObjectDataSource>
    <div class="content_container">
        <asp:ListView ID="lv" runat="server" DataKeyNames="ID,PARTNER_ID,TYPE_ID,SCAN_ID" DataSourceID="sds" OnItemInserting="lv_ItemInserting"
            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting" EnableModelValidation="True">
            <LayoutTemplate>
                <table class="tbl_style2">
                    <thead>
                        <tr>
                            <th></th>
                            <th>
                                <asp:Label ID="PARTNER_ID" runat="server" Text="СК" />
                            </th>
                            <th>
                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                            </th>
                            <th>
                                <asp:Label ID="SCAN_ID" runat="server" Text="Сканкопія" />
                            </th>
                            <th>
                                <asp:Label ID="IS_REQUIRED" runat="server" Text="Обов`язковість" />
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
                            <td colspan="4"></td>
                        </tr>
                    </tfoot>
                </table>
            </LayoutTemplate>
            <EmptyDataTemplate>
                <table class="tbl_style2">
                    <thead>
                        <tr>
                            <th></th>
                            <th>
                                <asp:Label ID="PARTNER_ID" runat="server" Text="СК" />
                            </th>
                            <th>
                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                            </th>
                            <th>
                                <asp:Label ID="SCAN_ID" runat="server" Text="Сканкопія" />
                            </th>
                            <th>
                                <asp:Label ID="IS_REQUIRED" runat="server" Text="Обов`язковість" />
                            </th>
                        </tr>
                    </thead>
                    <tfoot id="Tfoot1" runat="server">
                        <tr>
                            <td class="command">
                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                            </td>
                            <td colspan="4"></td>
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
                        <asp:Label ID="PARTNER_ID" runat="server" Text='<%# Eval("PARTNER_ID") == null ? "Всі" : String.Format("{0} - {1}", Eval("PARTNER_ID"), Eval("PARTNER_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="TYPE_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("TYPE_ID"))) ? "Всі" : String.Format("{0} - {1}", Eval("TYPE_ID"), Eval("TYPE_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="SCAN_ID" runat="server" Text='<%# Eval("SCAN_ID") == null ? "" : String.Format("{0} - {1}", Eval("SCAN_ID"), Eval("SCAN_NAME")) %>' />
                    </td>
                    <td align="center">
                        <asp:CheckBox ID="IS_REQUIRED" runat="server" Enabled="false" Checked='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr id="tr1" runat="server" class="edit">
                    <td class="command">
                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                    </td>
                    <td>
                        <bars:DDLList ID="PARTNER" runat="server" DataSourceID="sds_partners" DataTextField="NAME" OnDataBinding="PARTNER_DataBinding"
                            DataValueField="PARTNER_ID" SelectedValue='<%# Bind("PARTNER_ID") %>' IsRequired="false" EmptyItemText="Всі" OnValueChanged="PARTNER_ValueChanged">
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
                        <bars:DDLList ID="SCAN" runat="server" DataSourceID="ods_scans" DataTextField="NAME"
                            DataValueField="SCAN_ID" SelectedValue='<%# Bind("SCAN_ID") %>' IsRequired="true" ValidationGroup="Update">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbSCAN" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowScans(this); " OnClick="lbSCAN_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>' IsRequired="true" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr id="tr2" runat="server" class="new">
                    <td class="command">
                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" />
                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                    </td>
                    <td>
                        <bars:DDLList ID="PARTNER" runat="server" DataSourceID="sds_partners" DataTextField="NAME"
                            DataValueField="PARTNER_ID" SelectedValue='<%# Bind("PARTNER_ID") %>' IsRequired="false" EmptyItemText="Всі" OnValueChanged="PARTNER_ValueChanged">
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
                        <bars:DDLList ID="SCAN" runat="server" DataSourceID="ods_scans" DataTextField="NAME"
                            DataValueField="SCAN_ID" SelectedValue='<%# Bind("SCAN_ID") %>' IsRequired="true" ValidationGroup="Insert">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbSCAN" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowScans(this); " OnClick="lbSCAN_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>' IsRequired="true" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
