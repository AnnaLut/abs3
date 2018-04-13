<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="curaccount.aspx.cs" Inherits="credit_manager_curaccount" Theme="default"
    Title="Текущий счет заявки №{0}" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table class="dataTable">
            <tr>
                <td>
                    <asp:Panel ID="pnl" runat="server" GroupingText="Доступные текущие счета клиента"
                        meta:resourcekey="pnlResource1">
                        <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidCuraccounts"
                            TypeName="credit.VWcsBidCuraccounts">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                            </SelectParameters>
                        </Bars:BarsObjectDataSource>
                        <asp:RadioButtonList ID="rbl" runat="server" DataSourceID="ods" DataTextField="DESCR"
                            DataValueField="ACC" OnDataBound="rbl_DataBound" meta:resourcekey="rblResource1">
                        </asp:RadioButtonList>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td class="nextButtonContainer">
                    <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" meta:resourcekey="bNextResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
