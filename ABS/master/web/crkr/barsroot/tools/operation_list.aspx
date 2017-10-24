<%@ Page Language="C#" AutoEventWireup="true" CodeFile="operation_list.aspx.cs" Inherits="tools_operation_list" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Реєстр операцій за день</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body>
    <form id="formOperationList" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Реєстр операцій за день" />
    </div>
    <asp:Panel runat="server" ID="pnInfo" GroupingText="Дії" Style="margin-left: 10px;
        margin-right: 10px">
        <table>
            <tr>
                <td>
                    <asp:TextBox runat="server" ID="tbBranch" Width="250px" ToolTip="Код відділення"
                        ReadOnly="true" />
                </td>
                <td>
                    <Bars:DateEdit ID="tbFDat" runat="server" Width="75px" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btRefresh" runat="server" ImageUrl="/Common/Images/default/16/refresh.png"
                        TabIndex="4" ToolTip="Оновити" OnClick="btRefresh_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btNew" runat="server" AlternateText="Наповнити даними з АБС про автоматичні операції"
                        ImageUrl="/Common/Images/default/16/new.png" TabIndex="1" OnClientClick='return confirm("Наповнити даними з АБС про \"автоматичні\" операції?")'
                        OnClick="btNew_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btSave" runat="server" ImageUrl="/Common/Images/default/16/save.png"
                        TabIndex="5" Height="16px" ToolTip="Зберегти данні" Width="16px" OnClientClick='return confirm("Зберегти данні про \"Ручні\" операції?")'
                        OnClick="btSave_Click" />
                </td>
                <td style="padding-left: 5px; padding-right: 5px; border-right: dotted 1px gray">
                    <asp:ImageButton ID="btDetails" runat="server" ImageUrl="/Common/Images/default/16/open_blue.png"
                        TabIndex="6" ToolTip="Історія вибраного показника" />
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <asp:TextBox runat="server" ID="tbBranchName" Width="500px" ToolTip="Відділення"
                        ReadOnly="true" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <div>
        <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="False" AllowSorting="False"
            CssClass="barsGridView" ShowPageSizeBox="false" AutoGenerateColumns="False" DateMask="dd/MM/yyyy"
            OnRowDataBound="gvMain_RowDataBound" JavascriptSelectionType="SingleRow">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle ForeColor="Black" >
            </SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="Кількість операцій за день">
                    <ItemTemplate>
                        <asp:TextBox runat="server" onkeydown="return doKeyDown(window.event)" onkeypress="return doKeyPress(window.event)"
                            Width="70px" Style="text-align: right" ID="tbCount" Text='<%# Convert.ToString(Eval("KOL")) %>'
                            BorderStyle="None" />
                        <asp:HiddenField runat="server" ID="hID" Value='<%# Eval("ID") %>' />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:BoundField DataField="SEK" HeaderText="№ секції" />
                <asp:BoundField DataField="GRP" HeaderText="№ групи" />
                <asp:BoundField DataField="NAME" HeaderText="Назва показника" />
                <asp:BoundField DataField="KOEF" HeaderText="Коефіцієнт" />
                <asp:BoundField DataField="RKOL" HeaderText="Розрахункове значення" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    </form>
</body>
</html>
