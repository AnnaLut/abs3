<%@ Page Title="Графік платежів СД" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="pmts_schedule.aspx.cs" Inherits="ins_pmts_schedule"
    MaintainScrollPositionOnPostback="true" %>

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
                                    <bars:LabelTooltip ID="DEAL" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="INSTitle" runat="server" Text="Страхувальник: " />
                                </td>
                                <td>
                                    <bars:LabelTooltip ID="INS" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="AGRTitle" runat="server" Text="Договір: " />
                                </td>
                                <td>
                                    <bars:LabelTooltip ID="AGR" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlPaymentsSchedule" runat="server" GroupingText="Платіжний графік">
                        <Bars:BarsObjectDataSource ID="odsPaymentsSchedule" runat="server" SelectMethod="SelectPaymentsSchedule"
                            UpdateMethod="Update" DeleteMethod="Delete" TypeName="Bars.Ins.VInsPaymentsSchedule"
                            DataObjectTypeName="Bars.Ins.VInsPaymentsScheduleRecord">
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                            </SelectParameters>
                        </Bars:BarsObjectDataSource>
                        <asp:ListView ID="lvPaymentsSchedule" runat="server" DataKeyNames="ID,DEAL_ID" DataSourceID="odsPaymentsSchedule"
                            OnItemCommand="lvPaymentsSchedule_ItemCommand" OnItemDataBound="lvPaymentsSchedule_ItemDataBound">
                            <LayoutTemplate>
                                <table class="tbl_style1" width="500px">
                                    <thead>
                                        <tr>
                                            <th>
                                            </th>
                                            <th>
                                                <asp:Label ID="PLAN_DATE" runat="server" Text="План-Дата" />
                                            </th>
                                            <th>
                                                <asp:Label ID="FACT_DATE" runat="server" Text="Факт-Дата" />
                                            </th>
                                            <th>
                                                <asp:Label ID="PLAN_SUM" runat="server" Text="План-Сума" />
                                            </th>
                                            <th>
                                                <asp:Label ID="FACT_SUM" runat="server" Text="Факт-Сума" />
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
                                    <td class="command">
                                        <Bars:LabelTooltip ID="lbPayed" runat="server" Text="Вик." ToolTip='<%# String.Format("№ док.: {0}; коментар: {1}", Eval("PMT_NUM"), Eval("PMT_COMM")) %>'
                                            Visible='<%# ((Decimal)Eval("PAYED") == 0 ? false : true) %>'></Bars:LabelTooltip>
                                        <asp:ImageButton ID="ibPay" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="/common/images/default/16/ok.png" ToolTip="Сплатити" Visible='<%# ((Decimal)Eval("PAYED") == 1 ? false : true) %>' />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="PLAN_DATE" runat="server" Text='<%# Eval("PLAN_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="FACT_DATE" runat="server" Text='<%# Eval("FACT_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="PLAN_SUM" runat="server" Text='<%# Eval("PLAN_SUM", "{0:F2}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="FACT_SUM" runat="server" Text='<%# Eval("FACT_SUM", "{0:F2}") %>'></asp:Label>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <tr id="tr" runat="server" class="edit">
                                    <td class="command">
                                        <asp:ImageButton ID="ibPay" runat="server" CausesValidation="True" ValidationGroup="Pay"
                                            CommandName="Pay" ImageUrl="/common/images/default/16/save.png" ToolTip="Сплатити" />
                                        <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="/common/images/default/16/cancel.png" ToolTip="Відміна" />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="PLAN_DATEHdr" runat="server" Text='<%# Eval("PLAN_DATE", "{0:d}") %>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <Bars:TextBoxDate ID="FACT_DATE" runat="server" Value='<%# Bind("FACT_DATE") %>'
                                            IsRequired="true" ValidationGroup="Pay" Width="100px" />
                                    </td>
                                    <td align="right">
                                        <asp:Label ID="PLAN_SUMHdr" runat="server" Text='<%# Eval("PLAN_SUM", "{0:F2}") %>'></asp:Label>
                                    </td>
                                    <td align="right">
                                        <Bars:TextBoxDecimal ID="FACT_SUM" runat="server" Value='<%# Bind("FACT_SUM") %>'
                                            IsRequired="true" ValidationGroup="Pay" Width="100px" />
                                    </td>
                                </tr>
                                <tr id="tr1" runat="server" class="edit">
                                    <td colspan="5" align="center">
                                        <table border="0" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="PMT_NUMTitle" runat="server" Text="Документ: " />
                                                </td>
                                                <td align="right">
                                                    <Bars:TextBoxString ID="PMT_NUM" runat="server" Value='<%# Bind("PMT_NUM") %>' IsRequired="true"
                                                        ValidationGroup="Pay" Width="170px" ToolTip="Номер документа" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <Bars:TextBoxString ID="PMT_COMM" runat="server" Value='<%# Bind("PMT_COMM") %>'
                                                        IsRequired="false" Rows="2" TextMode="MultiLine" Width="250px" ToolTip="Коментар" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </EditItemTemplate>
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
