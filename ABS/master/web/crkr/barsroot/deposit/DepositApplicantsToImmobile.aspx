<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DepositApplicantsToImmobile.aspx.cs" Inherits="deposit_DepositApplicantsToImmobile" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Депозити-претенденти на визнання нерухомими (ver. 0.1)</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <Bars:BarsSqlDataSourceEx ID="dsApplicants" runat="server" ProviderName="barsroot.core" AllowPaging="true"
        SelectCommand="select * from V_DPT_APPLICANTS2IMMOBILE" />
    <div>
    <table class="MainTable" width="100%">
        <tr>
            <td align="center" colspan="4">
                <asp:label id="lbPageTitle" Text="Депозити-претенденти на визнання нерухомими" runat="server" CssClass="InfoHeader" />
            </td>
        </tr>
        <tr>
            <td colspan="4"></td>
        </tr>
        <tr>
            <td colspan="4">
                <Bars:BarsGridViewEx ID="gvApplicants" runat="server" 
                    DataSourceID="dsApplicants" CssClass="barsGridView"
                    style="width:100%" PageSize="20" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="3" DateMask="dd/MM/yyyy" ShowPageSizeBox="True" 
                    ShowExportExcelButton="false" DataKeyNames="DPT_ID" >
                <Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" >
                        <HeaderTemplate>
                            <asp:CheckBox ID="cbSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="cbSelectAll_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="cbSelect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="DPT_ID" SortExpression="DPT_ID" HeaderText="Ідентифікатор<BR>депозиту"
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DPT_NUM" SortExpression="DPT_NUM" HeaderText="Номер<BR>депозиту"
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DPT_CUR" SortExpression="DPT_CUR" HeaderText="Валюта<BR>депозиту"
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DPT_DAT" SortExpression="DPT_DAT" HeaderText="Дата<BR>заключення" DataFormatString="{0:dd/MM/yyyy}" 
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DAT_BEGIN" SortExpression="DAT_BEGIN" HeaderText="Дата<BR>початку дії" DataFormatString="{0:dd/MM/yyyy}" 
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DAT_END" SortExpression="DAT_END" HeaderText="Дата<BR>завершення" DataFormatString="{0:dd/MM/yyyy}" 
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="BRANCH" SortExpression="BRANCH" HeaderText="Код підрозділу<BR>депозитного договору"
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Left" />
                    <asp:BoundField DataField="COMMENTS" HeaderText="Коментар<BR>депозитного договору"
                        HtmlEncode="False" ItemStyle-HorizontalAlign="Left" />
                </Columns>
                </Bars:BarsGridViewEx>
            </td>
        </tr>
        <tr>
            <td style="width:25%" align="center">
            </td>
            <td style="width:25%" align="center">
            </td>
            <td style="width:25%" align="center">
            </td>
            <td style="width:25%" align="center">
                <asp:Button ID="btnImmobile" runat="server" class="AcceptButton" 
                    Text="Перенести в нерухомі" CausesValidation="false" 
                    onclick="btnImmobile_Click" />
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
