<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="scancopy.aspx.cs" Inherits="credit_manager_scancopy" Title="Сканирование документов клиента по заявке №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table class="dataTable">
            <tr>
                <td id="tdContainer" runat="server">
                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidScancopyQuestions"
                        TypeName="credit.VWcsBidScancopyQuestions">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:DataList ID="dl" runat="server" DataSourceID="ods" OnItemDataBound="dl_ItemDataBound">
                        <ItemTemplate>
                            </td>
                            <td class="questionTitle">
                                <asp:Label ID="lbTitle" runat="server" Text='<%# Eval("QUESTION_NAME") + " : " %>'
                                    meta:resourcekey="lbTitleResource1" />
                            </td>
                            <td class="questionValue">
                                <bec:TextBoxScanner ID="sc" SupposedQuestionID='<%# Eval("QUESTION_ID") %>' runat="server" />
                            </td>
                            <td>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
            <tr>
                <td class="nextButtonContainer" colspan="2">
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
