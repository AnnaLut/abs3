<%@ Page Language="C#" MasterPageFile="~/ins/ins_master.master" AutoEventWireup="true" 
    CodeFile="partner_type_attrs.aspx.cs" Inherits="ins_partner_type_attrs" Title="Атрибути СК та типів СД {0}"
    Theme="default" meta:resourcekey="PageResource1" %>
<%@ MasterType VirtualPath="~/ins/ins_master.master" %>

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
        <SelectParameters>
            <asp:QueryStringParameter Name="p_custid" QueryStringField="custtype" Type="Int32" Direction="Input" />
        </SelectParameters>
    </bars:BarsSqlDataSourceEx>
    <bars:BarsObjectDataSource ID="ods_attrs" runat="server" SelectMethod="SelectAttrs"
        TypeName="Bars.Ins.VInsAttrs">
    </bars:BarsObjectDataSource>
    <bars:BarsObjectDataSource ID="ods_attr_types" runat="server" SelectMethod="SelectAttrTypes"
        TypeName="Bars.Ins.InsAttrTypes">
    </bars:BarsObjectDataSource>
    <bars:BarsSqlDataSourceEx ID="sds_partners" runat="server" ProviderName="barsroot.core">
        <SelectParameters>
            <asp:QueryStringParameter Name="p_custid" QueryStringField="custtype" Type="Int32" Direction="Input" />
        </SelectParameters>
    </bars:BarsSqlDataSourceEx>
    <bars:BarsObjectDataSource ID="ods_partners" runat="server" SelectMethod="SelectPartners"
        TypeName="Bars.Ins.VInsPartners">
    </bars:BarsObjectDataSource>
    <bars:BarsSqlDataSourceEx ID="sds_attr_types" runat="server" ProviderName="barsroot.core">
    </bars:BarsSqlDataSourceEx>
    <div class="content_container">
        <asp:ListView ID="lv" runat="server" DataKeyNames="ID,ATTR_ID,PARTNER_ID,TYPE_ID" DataSourceID="sds" OnItemInserting="lv_ItemInserting"
            OnItemUpdating="lv_ItemUpdating" OnItemDeleting="lv_ItemDeleting">
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
                                <asp:Label ID="ATTR_NAME" runat="server" Text="Найменування/тип атрибута" />
                            </th>
                            <th>
                                <asp:Label ID="IS_REQUIRED" runat="server" Text="Обов`язковий" />
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
                                <asp:Label ID="PARTNER_ID" runat="server" Text="СК" />
                            </th>
                            <th>
                                <asp:Label ID="TYPE_ID" runat="server" Text="Тип" />
                            </th>
                            <th>
                                <asp:Label ID="ATTR_NAME" runat="server" Text="Найменування/тип атрибута" />
                            </th>
                            <th>
                                <asp:Label ID="IS_REQUIRED" runat="server" Text="Обов`язковий" />
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
                        <asp:Label ID="PARTNER_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("PARTNER_ID"))) ? "Всі" : String.Format("{0} - {1}", Eval("PARTNER_ID"), Eval("PARTNER_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="TYPE_ID" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("TYPE_ID"))) ? "Всі" : String.Format("{0} - {1}", Eval("TYPE_ID"), Eval("TYPE_NAME")) %>' />
                    </td>
                    <td>
                        <asp:Label ID="ATTR_NAME" runat="server" Text='<%# String.IsNullOrEmpty(Convert.ToString(Eval("ATTR_NAME"))) ? "" : String.Format("{0} - {1} / {2} - {3}", Eval("ATTR_ID"), Eval("ATTR_NAME"), Eval("ATTR_TYPE_ID"), Eval("ATTR_TYPE_NAME")) %>' />
                    </td>
                    <td align="center">
                        <asp:CheckBox ID="IS_REQUIRED" runat="server" Enabled="false" Checked='<%# (Decimal?)Eval("IS_REQUIRED") == 1 ? true : false %>' />
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
                        <bars:DDLList ID="ATTR" runat="server" DataSourceID="ods_attrs" DataTextField="NAME"
                            DataValueField="ATTR_ID" SelectedValue='<%# Bind("ATTR_ID") %>' IsRequired="false" EmptyItemText="Всі">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbATTR" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowAttrs(this); " OnClick="lbATTR_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>' IsRequired="true" />
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
                        <bars:DDLList ID="ATTR" runat="server" DataSourceID="ods_attrs" DataTextField="NAME"
                            DataValueField="ATTR_ID" SelectedValue='<%# Bind("ATTR_ID") %>' IsRequired="false">
                        </bars:DDLList>
                        <asp:LinkButton ID="lbATTR" runat="server" Text="(Редагувати)"
                            OnClientClick="return ShowAttrs(this); " OnClick="lbATTR_Click"></asp:LinkButton>
                    </td>
                    <td align="center">
                        <bars:RBLFlag ID="IS_REQUIRED" runat="server" Value='<%# Bind("IS_REQUIRED") %>' IsRequired="true" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </div>
    
</asp:Content>