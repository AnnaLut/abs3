<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptRequestArchive.aspx.cs" Inherits="deposit_DptRequestArchive" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register TagPrefix="ajax" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Депозитний модуль: Архів запитів на доступ</title>
    <link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet" />
    <link href="/barsroot/deposit/style/barsgridview.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <Bars:BarsSqlDataSourceEx ID="dsReqArchive" runat="server" ProviderName="barsroot.core" AllowPaging="true" >
    </Bars:BarsSqlDataSourceEx>
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div>
    <table class="MainTable" width="100%">
        <tr>
            <td align="center">
                <asp:label id="lbPageTitle" Text="Архів запитів на доступ через «БЕК-офіс»" runat="server" CssClass="InfoHeader"/>
            </td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable" >
                    <tr>
                        <td colspan="5"></td>
                    </tr>
                    <tr>
                        <td align="right" style="width:30%">
                            <asp:Label ID="lbDateStart" runat="server" Text="Запити за період з: &nbsp;" CssClass="InfoLabel" />
                        </td>
                        <td align="center" style="width:15%">
                            <asp:TextBox ID="tbDateStart" runat="server" CssClass="InfoDateSum" />
                            <ajax:MaskedEditExtender ID="meeDateStart" TargetControlID="tbDateStart" runat="server"
                                Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus"/>
                            <ajax:CalendarExtender ID="ceDateStart" runat="server" TargetControlID="tbDateStart" 
                                Format="dd/MM/yyyy" Animated="false" />
                        </td>
                        <td align="center" style="width:10%">
                            <asp:Label ID="lbDateFinish" runat="server" Text="&nbsp; по: &nbsp;" CssClass="InfoLabel" />
                        </td>
                        <td align="center" style="width:15%">
                            <asp:TextBox ID="tbDateFinish" runat="server" CssClass="InfoDateSum" />
                            <ajax:MaskedEditExtender ID="meeDateFinish" TargetControlID="tbDateFinish" runat="server"
                                Mask="99/99/9999" MaskType="Date" Century="2000" CultureName="en-GB"
                                UserDateFormat="DayMonthYear" InputDirection="LeftToRight" OnFocusCssClass="MaskedEditFocus"/>
                            <ajax:CalendarExtender ID="ceDateFinish" runat="server" TargetControlID="tbDateFinish" 
                                Format="dd/MM/yyyy" Animated="false" PopupButtonID="ImgBntCalc" />  
                        </td>
                        <td align="right" style="width:30%">
                            <asp:Button ID="btnRequestSearch" runat="server" Text="Пошук запитів" 
                                CssClass="AcceptButton" onclick="btnRequestSearch_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <Bars:BarsGridViewEx ID="gvReqArchive" CssClass="BaseGridView" runat="server" DataSourceID="dsReqArchive"
                    style="width:100%" PageSize="15" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                    ShowPageSizeBox="True" OnRowCommand="gvReqArchive_RowCommand" 
                    DataKeyNames="STATE_CODE" OnRowDataBound="gv_RowDataBound" >
                <Columns>
                    <asp:TemplateField HeaderText="Номер<BR>запиту" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="12%" >
                        <ItemTemplate>
                            <asp:LinkButton ID="btnView" runat="server" CausesValidation="False"
                                Text='<%# Eval("REQ_ID") %>' ToolTip="Перегляд параметрів запиту" 
                                CommandName="ShowReqParams" CommandArgument='<%# Eval("REQ_ID") %>' />
                        </ItemTemplate>    
                    </asp:TemplateField>
                    <asp:BoundField DataField="REQ_CRDATE" SortExpression="REQ_CRDATE" HeaderText="Дата<BR>формування"  HtmlEncode="False"
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center" >
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="TRUSTEE_NAME" HeaderText="ПІБ<BR>клієнта" 
                        ItemStyle-HorizontalAlign="Left" >
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="TRUSTEE_TYPE_NAME" SortExpression="TRUSTEE_TYPE_NAME" HeaderText="Тип<BR>третьої особи"
                        ItemStyle-HorizontalAlign="Left" >
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="REQ_BRANCH" SortExpression="REQ_BRANCH" HeaderText="Код підрозділу<BR>(ініціатора запиту)"
                        ItemStyle-HorizontalAlign="Left" >
                    </asp:BoundField>
                    <asp:BoundField DataField="STATE_CODE" Visible="false" >
                    </asp:BoundField>
                    <asp:BoundField HtmlEncode="False" DataField="STATE_NAME" HeaderText="Статус<BR>запиту"
                        ItemStyle-HorizontalAlign="Left" >
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
