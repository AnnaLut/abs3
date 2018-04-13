<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptRequestProcessing.aspx.cs" Inherits="deposit_DptRequestProcessing" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Обробка запитів на доступ</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <Bars:BarsSqlDataSourceEx ID="dsRequests" runat="server" ProviderName="barsroot.core" AllowPaging="true" >
    </Bars:BarsSqlDataSourceEx>
    <div>
    <table class="MainTable" width="100%">
        <tr>
            <td align="center">
                <asp:label id="lbPageTitle" Text="Обробка запитів на доступ через «БЕК-офіс»" runat="server" CssClass="InfoHeader" />
            </td>
        </tr>
        <tr>
            <td>
                <Bars:BarsGridViewEx ID="gvRequests" CssClass="BaseGridView" runat="server" DataSourceID="dsRequests"
                    style="width:100%" PageSize="15" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    DateMask="dd/MM/yyyy" ShowPageSizeBox="True" ShowExportExcelButton="false" >
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="hlMain" runat="server" Text="Вибрати" NavigateUrl='<%#"DptRequestParameters.aspx?req_id=" + Eval("REQ_ID") %>'></asp:HyperLink>
                        </ItemTemplate>    
                    </asp:TemplateField>
                    <asp:BoundField HtmlEncode="False" DataField="REQ_ID" SortExpression="REQ_ID" HeaderText="Номер<BR>запиту" >
                        <ItemStyle HorizontalAlign="Center" ></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="REQ_CRDATE" SortExpression="REQ_CRDATE" HeaderText="Дата<BR>формування" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" >
                        <ItemStyle HorizontalAlign="Center" ></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="TRUSTEE_NAME" SortExpression="TRUSTEE_NAME" HeaderText="ПІБ<BR>клієнта">
                        <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="TRUSTEE_TYPE_NAME" SortExpression="TRUSTEE_TYPE_NAME" HeaderText="Тип<BR>третьої особи">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="REQ_BRANCH" SortExpression="REQ_BRANCH" HeaderText="Код підрозділу<BR>(ініціатора запиту)">
                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                    </asp:BoundField>
                </Columns>
                </Bars:BarsGridViewEx>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
