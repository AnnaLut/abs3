<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="infoqueries.aspx.cs" Inherits="credit_infoqueries" Title="Информационные запросы заявки №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/credit/master.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidProcessedInfoqueries"
            TypeName="credit.VWcsBidInfoqueries">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ListView ID="lv" runat="server" DataSourceID="ods" EnableModelValidation="True"
            OnItemDataBound="lv_ItemDataBound">
            <LayoutTemplate>
                <table border="0" cellpadding="3" cellspacing="0" style="width: 99%">
                    <tr id="Tr2" runat="server">
                        <td id="Td1" runat="server">
                            <asp:ImageButton ID="ibShowHideAll" runat="server" ImageUrl="/Common/Images/default/16/win_max_all.png"
                                OnClientClick="ShowHideAll(this); return false;" />
                        </td>
                        <td id="Td2" runat="server" colspan="2" style="font-size: 7pt">
                            <asp:Label ID="lbShowHideAll" runat="server" Text="Применить ко всем" meta:resourcekey="lbShowHideAllResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr id="itemPlaceholder" runat="server" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr id="row" runat="server">
                    <td class="buttonContainer" runat="server">
                        <asp:ImageButton ID="ibShowHide" ImageUrl="/Common/Images/default/16/win_max.gif"
                            OnClientClick="ShowHide(this); return false;" grpid='<%# Eval("IQUERY_ID") + "_" + Eval("SRV_HIERARCHY") %>'
                            grpvisible="0" runat="server" />
                    </td>
                    <td colspan="2" class="groupTitle" runat="server">
                        <asp:Label ID="GROUP_NAME" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="rowMANUALText" runat="server" grpid='<%# Eval("IQUERY_ID") + "_" + Eval("SRV_HIERARCHY") %>'
                    grpvisible="0" class="rowHidden" visible='<%# (String)Eval("TYPE_ID") == "MANUAL" ? true : false %>'>
                    <td class="buttonContainer" style="padding-bottom: 30px" runat="server">
                    </td>
                    <td colspan="2" align="center" style="padding-bottom: 30px" runat="server">
                        <div style="text-align: left">
                            <%# (String)Eval("IQUERY_TEXT") %>
                        </div>
                    </td>
                </tr>
                <asp:ListView ID="lvItems" runat="server" DataSource='<%# (new credit.VWcsInfoqueryQuestions()).SelectInfoqueryQuestions((String)Eval("IQUERY_ID")) %>'
                    OnItemDataBound="lvItems_ItemDataBound" EnableModelValidation="True">
                    <LayoutTemplate>
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr id="row" runat="server" grpid='<%# Eval("IQUERY_ID") + "_" + DataBinder.Eval(((System.Web.UI.WebControls.ListViewDataItem)Container.Parent.Parent.Parent).DataItem, "SRV_HIERARCHY") %>'
                            grpvisible="0" class="rowHidden">
                            <td class="buttonContainer" runat="server">
                            </td>
                            <td class="questionTitle" runat="server">
                                <asp:Label ID="QUESTION_NAME" runat="server" Text='<%# (String)Eval("QUESTION_NAME") + " :" %>'></asp:Label>
                            </td>
                            <td class="questionValue" id="tdQuestionValue" runat="server">
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
