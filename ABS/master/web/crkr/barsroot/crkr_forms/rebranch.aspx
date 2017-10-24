<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rebranch.aspx.cs" Inherits="crkr_forms_rebranch" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="frm_rebranch" runat="server">
        <div>
        </div>
        <BarsEx:BarsSqlDataSourceEx ID="sdsBranchFrom" runat="server" SelectCommand="select branch, name from branch order by branch" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsSqlDataSourceEx ID="sdsBranchTo" runat="server" SelectCommand="select branch, name from branch order by branch" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <asp:Panel runat="server" ID="pnBranch" GroupingText="Вибір бранчів">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbFrom" runat="server" Text="Виконати з Бранчу "></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlFrom" runat="server" DataSourceID="sdsBranchFrom" DataValueField="BRANCH" DataTextField="NAME" Width="300"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbTo" Text="На Бранч"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlTo" runat="server" DataSourceID="sdsBranchTo" DataValueField="BRANCH" DataTextField="NAME" Width="300"></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <table>
            <tr>

                <td style="text-align: right; width: 100%;">
                    <asp:Button ID="bt_refresh" runat="server" TabIndex="3" Style="float: left" ToolTip="Виконати перепривязку вкладів" OnClick="bt_refresh_Click"
                        Text="Виконати" />
                </td>
            </tr>
        </table>
        <hr />
        <asp:Label ID="lbMess" runat="server"></asp:Label>
    </form>
</body>
</html>
