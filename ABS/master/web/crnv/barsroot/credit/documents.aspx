<%@ Page Language="C#" AutoEventWireup="true" CodeFile="documents.aspx.cs" Inherits="credit_documents"
    Theme="default" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Погашення кредиту готівкою</title>
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript" src="jscript/JScript.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
    </asp:ScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Друк договорів КД"></asp:Label>
    </div>
    <div style="padding: 10px 0px 10px 10px">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbCC_ID" runat="server" Text="№ договора : "></asp:Label>
                </td>
                <td>
                    <bec:TextBoxString ID="tbsCC_ID" runat="server" IsRequired="True" MaxLength="20"
                        ValidationGroup="Search"></bec:TextBoxString>
                </td>
                <td>
                    <asp:Label ID="lbDAT1" runat="server" Text="Дата закл. договора : "></asp:Label>
                </td>
                <td>
                    <bec:TextBoxDate ID="tbdDAT1" runat="server" IsRequired="True" MaxValue='<%# DateTime.Now.AddDays(2) %>'
                        ValidationGroup="Search"></bec:TextBoxDate>
                </td>
                <td>
                    <asp:ImageButton ID="ibSearch" runat="server" AlternateText="Искать" ImageUrl="/Common/Images/default/16/find.png"
                        ToolTip="Искать" OnClick="ibSearch_Click" CausesValidation="true" ValidationGroup="Search" />
                </td>
                <td style="padding-left: 10px; font-style: italic">
                    <asp:Label ID="lbFIO" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvGrid" runat="server" visible='<%# !String.IsNullOrEmpty(tbsCC_ID.Value) && tbdDAT1.Value.HasValue %>'
        style="padding: 10px 0px 10px 10px; border-top: solid 1px #94ABD9; width: 99%">
        <asp:ObjectDataSource ID="odsVCcDocs" runat="server" SelectMethod="SelectVCcDocs"
            TypeName="credit.VCcDocs">
            <SelectParameters>
                <asp:ControlParameter ControlID="tbsCC_ID" Name="CC_ID" PropertyName="Value" Type="String" />
                <asp:ControlParameter ControlID="tbdDAT1" Name="SDATE" PropertyName="Value" Type="DateTime" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gvDocs" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="/common/images/default/16/filter_delete.png" CssClass="barsGridView"
            DataSourceID="odsVCcDocs" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
            MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png" 
            ShowPageSizeBox="False" Width="99%" DataKeyNames="ND,SCHEME_ID" 
            onrowcommand="gvDocs_RowCommand">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="Друкувати">
                    <ItemTemplate>
                        <asp:ImageButton ID="ibPrint" runat="server" 
                            CommandArgument='<%# Eval("ND") + ";" + Eval("SCHEME_ID") %>' 
                            CommandName="Print" ImageUrl="/Common/Images/default/16/print.png" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="SCHEME_NAME" HeaderText="Документ" SortExpression="SCHEME_NAME" />
                <asp:BoundField DataField="VERSION" DataFormatString="{0:dd.MM.yyyy hh:mm}" HeaderText="Дата формування"
                    SortExpression="VERSION" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="COMM" HeaderText="Комментар" SortExpression="COMM" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div id="Progress" style="display: none">
        <bec:loading ID="lProgress" runat="server" />
    </div>
    </form>
</body>
</html>
