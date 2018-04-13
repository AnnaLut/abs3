<%@ Page Title="Звіти" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="cim_reports_default" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="Server">
    <bars:BarsSqlDataSourceEx runat="server" ID="dsReports" ProviderName="barsroot.core"
        SelectCommand="select report_id, name, proc, template, file_type, file_name from cim_reports_list order by 1">
    </bars:BarsSqlDataSourceEx>
    <table>
        <tr valign="top">
            <td>
                <asp:Panel ID="pnReport" runat="server" GroupingText="Звітні форми">
                    <asp:DropDownList ID="ddReports" runat="server" AutoPostBack="true" AppendDataBoundItems="True" DataSourceID="dsReports" DataTextField="NAME" DataValueField="REPORT_ID">
                        <asp:ListItem Text="Виберіть звітну форму" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </asp:Panel>
            </td>
            <td>
                <asp:Panel runat="server" ID="pbParamsList" GroupingText="Параметри звіту" Visible="false">
                    <asp:PlaceHolder runat="server" ID="phParams"></asp:PlaceHolder>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td></td>
            <td style="text-align: right">
                <asp:Button ID="btFormReport" runat="server" Text="Сформувати" OnClick="btFormReport_Click" Visible="false" />
            </td>
        </tr>
    </table>
</asp:Content>
