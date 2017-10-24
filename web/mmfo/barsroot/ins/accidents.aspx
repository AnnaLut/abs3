<%@ Page Title="Страхові випадки" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="accidents.aspx.cs" Inherits="accidents" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div class="content_container">
        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
            <tr>
                <td>
                    <asp:Panel ID="pnlKey" runat="server" GroupingText="Ключові параметри">
                        <table border="0" cellpadding="3" cellspacing="0" class="data_table">
                            <tr>
                                <td>
                                    <asp:Label ID="DEALTitle" runat="server" Text="Ідентифікатор: " />
                                </td>
                                <td>
                                    <Bars:LabelTooltip ID="DEAL" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="INSTitle" runat="server" Text="Страхувальник: " />
                                </td>
                                <td>
                                    <Bars:LabelTooltip ID="INS" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="AGRTitle" runat="server" Text="Договір: " />
                                </td>
                                <td>
                                    <Bars:LabelTooltip ID="AGR" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlAccidents" runat="server" GroupingText="Страхові випадки">
                        <Bars:BarsObjectDataSource ID="odsAccidents" runat="server" SelectMethod="SelectAccidents"
                            InsertMethod="Insert" UpdateMethod="Update" TypeName="Bars.Ins.VInsAccidents"
                            DataObjectTypeName="Bars.Ins.VInsAccidentsRecord">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                            </SelectParameters>
                        </Bars:BarsObjectDataSource>
                        <asp:ListView ID="lvAccidents" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsAccidents"
                            OnItemInserting="lvAccidents_ItemInserting" OnItemUpdating="lvAccidents_ItemUpdating">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="550px">
                                    <thead>
                                        <tr>
                                            <th>
                                            </th>
                                            <th>
                                                <asp:Label ID="ACDT_DATE" runat="server" Text="Дата" />
                                            </th>
                                            <th>
                                                <asp:Label ID="COMM" runat="server" Text="Коментар" />
                                            </th>
                                            <th>
                                                <asp:Label ID="REFUND_SUM" runat="server" Text="Сума відш." />
                                            </th>
                                            <th>
                                                <asp:Label ID="REFUND_DATE" runat="server" Text="Дата відш." />
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
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </LayoutTemplate>
                            <EmptyDataTemplate>
                                <table class="tbl_style1" width="550px">
                                    <thead>
                                        <tr>
                                            <th>
                                            </th>
                                            <th>
                                                <asp:Label ID="ACDT_DATE" runat="server" Text="Дата" />
                                            </th>
                                            <th>
                                                <asp:Label ID="COMM" runat="server" Text="Коментар" />
                                            </th>
                                            <th>
                                                <asp:Label ID="REFUND_SUM" runat="server" Text="Сума відш." />
                                            </th>
                                            <th>
                                                <asp:Label ID="REFUND_DATE" runat="server" Text="Дата відш." />
                                            </th>
                                        </tr>
                                    </thead>
                                    <tfoot id="tblPSFoot" runat="server">
                                        <tr>
                                            <td class="command">
                                                <asp:ImageButton ID="ibAddNew" runat="server" CausesValidation="False" OnClick="ibAddNew_Click"
                                                    ImageUrl="/common/images/default/16/new.png" ToolTip="Додати" />
                                            </td>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <tr id="tr" runat="server">
                                    <td class="command">
                                        <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/common/images/default/16/open.png" ToolTip="Редагувати" />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="ACDT_DATE" runat="server" Text='<%# Eval("ACDT_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                    <td align="left">
                                        <Bars:LabelTooltip ID="FACT_DATE" runat="server" Text='<%# Eval("COMM") %>' UseTextForTooltip="true"
                                            TextLength="50"></Bars:LabelTooltip>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="REFUND_SUM" runat="server" Text='<%# Eval("REFUND_SUM", "{0:F2}") %>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="REFUND_DATE" runat="server" Text='<%# Eval("REFUND_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibUpdate" runat="server" CausesValidation="True" ValidationGroup="Update"
                                            CommandName="Update" ImageUrl="/common/images/default/16/save.png" ToolTip="Зберегти" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td>
                                        <Bars:TextBoxDate ID="ACDT_DATE" runat="server" Value='<%# Bind("ACDT_DATE") %>'
                                            IsRequired="true" ValidationGroup="Update" Width="100px" />
                                    </td>
                                    <td>
                                    </td>
                                    <td align="right">
                                        <Bars:TextBoxDecimal ID="REFUND_SUM" runat="server" Value='<%# Bind("REFUND_SUM") %>'
                                            Width="100px" />
                                    </td>
                                    <td align="center">
                                        <Bars:TextBoxDate ID="REFUND_DATE" runat="server" Value='<%# Bind("REFUND_DATE") %>'
                                            Width="100px" />
                                    </td>
                                </tr>
                                <tr id="tr1" runat="server" class="edit">
                                    <td colspan="5" align="center">
                                        <Bars:TextBoxString ID="COMM" runat="server" Value='<%# Bind("COMM") %>' IsRequired="true"
                                            ValidationGroup="Update" Rows="2" TextMode="MultiLine" Width="500px" ToolTip="Коментар" />
                                    </td>
                                </tr>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <tr id="tr" runat="server" class="new">
                                    <td class="command">
                                        <asp:ImageButton ID="ibInsert" runat="server" CausesValidation="True" ValidationGroup="Insert"
                                            CommandName="Insert" ImageUrl="/common/images/default/16/save.png" Text="Додати" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" OnClick="ibCancel_Click"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td>
                                        <Bars:TextBoxDate ID="ACDT_DATE" runat="server" Value='<%# Bind("ACDT_DATE") %>'
                                            IsRequired="true" ValidationGroup="Insert" Width="100px" />
                                    </td>
                                    <td>
                                    </td>
                                    <td align="right">
                                        <Bars:TextBoxDecimal ID="REFUND_SUM" runat="server" Value='<%# Bind("REFUND_SUM") %>'
                                            Width="100px" />
                                    </td>
                                    <td align="center">
                                        <Bars:TextBoxDate ID="REFUND_DATE" runat="server" Value='<%# Bind("REFUND_DATE") %>'
                                            Width="100px" />
                                    </td>
                                </tr>
                                <tr id="tr1" runat="server" class="edit">
                                    <td colspan="5" align="center">
                                        <Bars:TextBoxString ID="COMM" runat="server" Value='<%# Bind("COMM") %>' IsRequired="true"
                                            ValidationGroup="Insert" Rows="2" TextMode="MultiLine" Width="500px" ToolTip="Коментар" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                        </asp:ListView>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:LinkButton ID="lbBack" runat="server" Text="Назад" OnClick="lbBack_Click"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
