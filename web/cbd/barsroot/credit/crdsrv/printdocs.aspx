<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="printdocs.aspx.cs" Inherits="credit_crdsrv_printdocs" Title="Печать документов по заявке №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectCrdsrvBidTemplates"
            TypeName="credit.VWcsCrdsrvBidTemplates">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="dataTable">
            <col class="questionTitle" />
            <asp:ListView ID="lv" runat="server" DataSourceID="ods" OnItemCommand="lv_ItemCommand"
                OnItemDataBound="lv_ItemDataBound" EnableModelValidation="True">
                <LayoutTemplate>
                    <tr id="itemPlaceholder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="row" runat="server">
                        <td>
                            <asp:Label ID="TEMPLATE_NAME" runat="server" Text='<%# Eval("TEMPLATE_NAME") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:ImageButton ID="ibPrint" runat="server" ToolTip="Печать" CausesValidation="false"
                                ImageUrl="/Common/Images/default/16/print.png" CommandName="Print" CommandArgument='<%# Eval("TEMPLATE_ID") + ";" + Eval("WS_NUM") + ";" + Eval("DOCEXP_TYPE_ID") %>'
                                Enabled='<%# (Decimal)Eval("ENABLED") == 1 ? true : false %>' />
                        </td>
                        <td>
                            <bec:TextBoxScanner ID="sc" runat="server" SupposedQuestionID='<%# Eval("SCAN_QID") %>'
                                WS_ID='<%# Eval("WS_ID") %>' WS_NUM='<%# Eval("WS_NUM") %>' IsRequired='<%# (Decimal)Eval("IS_SCAN_REQUIRED") == 1 %>'
                                OnDocumentScaned="sc_DocumentScaned" Enabled='<%# (Decimal)Eval("ENABLED") == 1 ? true : false %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <tr>
                <td class="nextButtonContainer" colspan="3">
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
