<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cash_open.aspx.cs" Inherits="admin_cash_open"
    Theme="default" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb"
    TagPrefix="bec" %>
<%@ Register Src="../credit/usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Відкриття каси</title>
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .group_title
        {
            text-align: center;
            font-weight: bold;
            font-style: italic;
        }
        .parameter_title
        {
            text-align: right;
            padding-right: 5px;
        }
        .parameter_value
        {
            text-align: left;
        }
        .button_send_container
        {
            text-align: right;
            padding-top: 5px;
        }
        .checkbox_activate
        {
            border-bottom: solid 1px gray;
        }
        .checkbox_activate_container
        {
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Відкриття каси"></asp:Label>
    </div>
    <div style="text-align: center; padding: 10px 0px 10px 10px">
        <table border="0" cellpadding="3" cellspacing="0" style="text-align: left" style="width: 80%">
            <tr>
                <td>
                    <asp:Panel ID="pnlOsts" runat="server" GroupingText="Вхідні залишки">
                        <asp:UpdatePanel ID="upGv" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:ObjectDataSource ID="odsVCashsnapshot" runat="server" SelectMethod="SelectVCashsnapshot"
                                    TypeName="ibank.core.VCashsnapshot" SortParameterName="SortExpression" EnablePaging="true"
                                    MaximumRowsParameterName="maximumRows" StartRowIndexParameterName="startRowIndex">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="SHIFT" Name="SHIFT" PropertyName="Value" Type="Decimal" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <Bars:BarsGridViewEx ID="gvVCashsnapshot" runat="server" AutoGenerateColumns="False"
                                    CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                                    CssClass="barsGridView" DataSourceID="odsVCashsnapshot" DateMask="dd.MM.yyyy"
                                    ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/filter.png"
                                    MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                                    ShowPageSizeBox="true" AllowSorting="True" AllowPaging="True" PageSize="10">
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="NLS" HeaderText="Рахунок" SortExpression="NLS" />
                                        <asp:BoundField DataField="NMS" HeaderText="Найменування" SortExpression="NMS" />
                                        <asp:BoundField DataField="OSTF" HeaderText="Залишок" SortExpression="OSTF">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="KV" HeaderText="Валюта" SortExpression="KV">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle CssClass="normalRow"></RowStyle>
                                </Bars:BarsGridViewEx>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlShift" runat="server" GroupingText="Відкриття зміни">
                        <asp:UpdatePanel ID="upShift" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table border="0" cellpadding="3" cellspacing="0" style="text-align: left">
                                    <tr>
                                        <td style="text-align: right">
                                            <asp:Label ID="lbOprDateTitle" runat="server" Text="Операційна дата :"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbOprDate" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right">
                                            <asp:Label ID="lbCurShiftTitle" runat="server" Text="Поточна відкрита зміна :"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lbCurShift" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td style="text-align: right">
                                            <asp:Label ID="SHIFTTite" runat="server" Text="Відкриваємо зміну : "></asp:Label>
                                        </td>
                                        <td>
                                            <bec:TextBoxNumb ID="SHIFT" runat="server" Enabled="false" Width="75" />
                                        </td>
                                        <td style="padding-right: 10px">
                                            <asp:Button ID="btOpen" runat="server" Text="Відкрити" OnClick="btOpen_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdateProgress ID="uppShift" runat="server" AssociatedUpdatePanelID="upShift">
        <ProgressTemplate>
            <bec:loading ID="ldngShift" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="uppGv" runat="server" AssociatedUpdatePanelID="upGv">
        <ProgressTemplate>
            <bec:loading ID="ldngGv" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    </form>
</body>
</html>
