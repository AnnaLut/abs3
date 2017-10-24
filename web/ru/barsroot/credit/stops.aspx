<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="stops.aspx.cs" Inherits="credit_stops" Title="Стоп-факторы заявки №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/credit/master.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidSFactors" TypeName="credit.VWcsBidStops">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ListView ID="lv" runat="server" DataSourceID="ods" EnableModelValidation="True">
            <LayoutTemplate>
                <table border="0" cellpadding="3" cellspacing="0">
                    <tr id="itemPlaceholder" runat="server" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr id="row" runat="server">
                    <td class="buttonContainer" runat="server">
                        <asp:Image ID="img" ImageUrl='<%# "/Common/Images/default/24/" + ((Decimal)Eval("FIRED") == 1 ? "forbidden.png" : "check.png") %>'
                            runat="server" />
                    </td>
                    <td class="groupTitle" runat="server">
                        <asp:Label ID="SFACTOR" runat="server" Text='<%# (String)Eval("STOP_NAME") %>' ForeColor='<%# ((Decimal)Eval("FIRED") == 1 ? System.Drawing.Color.Red : System.Drawing.Color.Green) %>'></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
