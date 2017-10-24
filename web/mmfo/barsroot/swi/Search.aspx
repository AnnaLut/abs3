<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="swi_Search" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Пошук повідомлень</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>

<body>
    <form id="frm_search" runat="server">
    <div>
    
    </div>
         <asp:Panel runat="server" ID="pnInfo" GroupingText="Пошук повідомлення:" Style="margin-left: 10px; margin-right: 10px">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lbText" runat="server" Text="Містить слова:"></asp:Label>
                        </td>
                        <td id="tdFio" runat="server">
                            <bars:BarsTextBox ID="tbText" runat="server" Width="280">
                            </bars:BarsTextBox>
                        </td>
                        </tr>
                    </table>
             </asp:Panel>
                  <br />
                    <table>
                        <tr>
                            <td></td>
                            <td></td>
                            <td style="text-align: right; width: 100%;">
                                <asp:Button ID="bt_refresh" runat="server" TabIndex="3" ToolTip="Знайти по заданим параметрам" OnClick="btRefresh_Click"
                                    Text="Пошук" />
                            </td>
                        </tr>
                    </table>
          
         <br />
        <hr style="margin-left: 10px; margin-right: 10px" />
        <BarsEx:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEx:BarsSqlDataSourceEx>
        <BarsEx:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="True" AllowSorting="True"
            DataSourceID="dsMain" CssClass="barsGridView" DataKeyNames="swref" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="None"
            PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                  <asp:TemplateField HeaderText="Референс" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlRef" runat="server" Target="_self" NavigateUrl='<%#String.Format("/barsroot/documentview/view_swift.aspx?swref={0}",Eval("SWREF")) %>'>
                            <asp:Label ID="lbRef" runat="server" Text='<%#String.Format("{0}",Eval("SWREF")) %>'></asp:Label>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="IO_IND" HeaderText="Вх./Вих."  ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="MT" HeaderText="Тип"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="TRN" HeaderText="SWIFT реф." />
                <asp:BoundField DataField="SENDER" HeaderText="Відправник" />
                <asp:BoundField DataField="RECEIVER" HeaderText="Отримувач" />
                <asp:BoundField DataField="CURRENCY" HeaderText="Валюта"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="AMOUNT" DataFormatString="{0:### ### ##0.00}" HeaderText="Сума" />
                <asp:BoundField DataField="DATE_REC" HeaderText="Дата запису"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="DATE_PAY" HeaderText="Дата оплати"   ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="VDATE" HeaderText="Дата валютування"   ItemStyle-HorizontalAlign="Center"/>
                 <asp:TemplateField HeaderText="Референс АБС" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlRefABS" runat="server" Target="_self" NavigateUrl='<%#String.Format("/barsroot/documentview/default.aspx?ref={0}",Eval("REF")) %>'>
                            <asp:Label ID="lbRefABS" runat="server" Text='<%#String.Format("{0}",Eval("REF")) %>'></asp:Label>
                        </asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </BarsEx:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
