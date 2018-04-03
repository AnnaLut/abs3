<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="grt_scancopy.aspx.cs" Inherits="credit_manager_grt_scancopy" Title="Сканирование документов обеспечения {0} - {1} заявки №{2}"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidGrtScancopyQuests"
            TypeName="credit.VWcsBidGrtScancopyQuests">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                <asp:QueryStringParameter Name="GARANTEE_ID" QueryStringField="garantee_id" Type="String"
                    Size="100" />
                <asp:QueryStringParameter Name="GARANTEE_NUM" QueryStringField="garantee_num" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table class="dataTable">
            <tr>
                <td id="tdContainer" runat="server">
                    <asp:DataList ID="dl" runat="server" DataSourceID="ods" 
                        OnItemDataBound="dl_ItemDataBound" meta:resourcekey="dlResource1">
                        <ItemTemplate>
                            </td>
                            <td class="questionTitle">
                                <asp:Label ID="lbTitle" runat="server" 
                                    Text='<%# Eval("QUESTION_NAME") + " : " %>' 
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
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" 
                        meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
