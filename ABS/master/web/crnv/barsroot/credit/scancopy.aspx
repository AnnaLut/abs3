<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="scancopy.aspx.cs" Inherits="credit_scancopy" Title="Сканированные документы по заявке №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Src="usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="odsBidScancopyQuestions" runat="server" SelectMethod="SelectBidScancopyQuestions"
            TypeName="credit.VWcsBidScancopyQuestions">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsBidGrtScancopyQuests" runat="server" SelectMethod="SelectBidGrtsScancopyQuests"
            TypeName="credit.VWcsBidGrtScancopyQuests">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsBidTemplates" runat="server" SelectMethod="SelectBidTemplates"
            TypeName="credit.VWcsBidTemplates">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <table border="0" cellpadding="3" cellspacing="0">
            <tr id="Tr2" runat="server">
                <td id="Td1" runat="server">
                    <asp:ImageButton ID="ibShowHideAll" runat="server" ImageUrl="/Common/Images/default/16/win_max_all.png"
                        OnClientClick="ShowHideAll(this); return false;" meta:resourcekey="ibShowHideAllResource1" />
                </td>
                <td id="Td2" runat="server" colspan="2" style="font-size: 7pt">
                    <asp:Label ID="lbShowHideAll" runat="server" Text="Применить ко всем" meta:resourcekey="lbShowHideAllResource1"></asp:Label>
                </td>
            </tr>
            <tr id="trClScans" runat="server">
                <td class="buttonContainer">
                    <asp:ImageButton ID="ibClScans" runat="server" ImageUrl="/Common/Images/default/16/win_max.gif"
                        OnClientClick="ShowHide(this); return false;" grpid="GRP_CL_SCANS" grpvisible="0"
                        meta:resourcekey="ibClScansResource1" />
                </td>
                <td colspan="2" class="groupTitle">
                    <asp:Label ID="lClScans" runat="server" Text="Сканкопии документов клиента" meta:resourcekey="lClScansResource1"></asp:Label>
                </td>
            </tr>
            <asp:ListView ID="lvBidScancopyQuestions" runat="server" DataSourceID="odsBidScancopyQuestions"
                OnItemDataBound="lvBidScancopyQuestions_ItemDataBound" EnableModelValidation="True">
                <LayoutTemplate>
                    <tr id="itemPlaceholder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="row" runat="server" grpid="GRP_CL_SCANS" grpvisible="0" class="rowHidden">
                        <td class="buttonContainer" runat="server">
                        </td>
                        <td runat="server">
                            <bec:ByteImage ID="bi" runat="server" Width="300px" />
                        </td>
                        <td style="width: 200px; vertical-align: top" runat="server">
                            <asp:Label ID="lb" runat="server" Text='<%# Eval("QUESTION_NAME") %>'></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <tr id="trGrtScans" runat="server">
                <td class="buttonContainer">
                    <asp:ImageButton ID="ibGrtScans" runat="server" ImageUrl="/Common/Images/default/16/win_max.gif"
                        OnClientClick="ShowHide(this); return false;" grpid="GRP_GRT_SCANS" grpvisible="0"
                        meta:resourcekey="ibGrtScansResource1" />
                </td>
                <td colspan="2" class="groupTitle">
                    <asp:Label ID="lGrtScans" runat="server" Text="Сканкопии документов обеспечения"
                        meta:resourcekey="lGrtScansResource1"></asp:Label>
                </td>
            </tr>
            <asp:ListView ID="lvBidGrtScancopyQuests" runat="server" DataSourceID="odsBidGrtScancopyQuests"
                OnItemDataBound="lvBidGrtScancopyQuests_ItemDataBound" EnableModelValidation="True">
                <LayoutTemplate>
                    <tr id="itemPlaceholder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="row" runat="server" grpid="GRP_GRT_SCANS" grpvisible="0" class="rowHidden">
                        <td class="buttonContainer" runat="server">
                        </td>
                        <td runat="server">
                            <bec:ByteImage ID="bi" runat="server" Width="300px" />
                        </td>
                        <td style="width: 200px; vertical-align: top" runat="server">
                            <asp:Label ID="lb" runat="server" Text='<%# Eval("QUESTION_NAME") %>'></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <tr id="trPrtScans" runat="server">
                <td class="buttonContainer">
                    <asp:ImageButton ID="ibPrtScans" runat="server" ImageUrl="/Common/Images/default/16/win_max.gif"
                        OnClientClick="ShowHide(this); return false;" grpid="GRP_PRT_SCANS" grpvisible="0"
                        meta:resourcekey="ibPrtScansResource1" />
                </td>
                <td colspan="2" class="groupTitle">
                    <asp:Label ID="lPrtScans" runat="server" Text="Сканкопии печатных документов" meta:resourcekey="lPrtScansResource1"></asp:Label>
                </td>
            </tr>
            <asp:ListView ID="lvBidTemplates" runat="server" DataSourceID="odsBidTemplates" EnableModelValidation="True">
                <LayoutTemplate>
                    <tr id="itemPlaceholder" runat="server" />
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="row" runat="server" grpid="GRP_PRT_SCANS" grpvisible="0" class="rowHidden">
                        <td class="buttonContainer" runat="server">
                        </td>
                        <td runat="server">
                            <bec:ByteImage ID="bi" runat="server" Value='<%# Eval("IMG") %>' Width="300px" />
                        </td>
                        <td style="width: 200px; vertical-align: top" runat="server">
                            <asp:Label ID="lb" runat="server" Text='<%# Eval("TEMPLATE_NAME") %>'></asp:Label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </table>
    </div>
</asp:Content>
