<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="blkdocs_Default" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="css/Default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/GVSelection.js"></script>
</head>
<body>
    <form id="wfBlkDocs" runat="server">
    <Bars:BarsSqlDataSource id="ds" ProviderName="barsroot.core" runat="server" selectcommand="select &#13;&#10;  ref,&#13;&#10;  err_code,&#13;&#10;  err_msg,&#13;&#10;  '/barsroot/documentview/default.aspx?ref='||to_char(ref) as doc_url&#13;&#10;from v_blkdocs&#13;&#10;order by ref"></Bars:BarsSqlDataSource>
    <asp:Label ID="lblCaption" runat="server" CssClass="PageTitle" Text="Документы блокированные при оплате" meta:resourcekey="lblCaptionResource1"></asp:Label><br />
        <br />
        <div>
            <Bars:ImageTextButton ID="itbRefresh" runat="server" ImageUrl="/common/images/default/16/refresh.png"
                Text="Обновить" OnClick="itbRefresh_Click" UseSubmitBehavior="False" meta:resourcekey="itbRefreshResource1" ToolTip="Обновить" />
            <Bars:Separator ID="Separator2" runat="server" BorderWidth="1px" meta:resourcekey="Separator2Resource1" />
            <Bars:ImageTextButton ID="itbUnblock" runat="server" ImageUrl="/common/images/default/16/lock_open.png"
                Text="Разблокировать" UseSubmitBehavior="False" CommandName="DocUnBlock" OnCommand="itbUnblock_Command" meta:resourcekey="itbUnblockResource1" ToolTip="Разблокировать" />
            <Bars:Separator ID="Separator1" runat="server" BorderWidth="1px" meta:resourcekey="Separator1Resource1" />
            <Bars:ImageTextButton ID="itbStorno" runat="server" ImageUrl="/common/images/default/16/lock_delete.png"
                Text="Сторнировать" UseSubmitBehavior="False" CommandName="DocStorno" OnCommand="itbUnblock_Command" meta:resourcekey="itbStornoResource1" ToolTip="Сторнировать" />
        </div>
        <Bars:BarsGridView id="gv" runat="server" datasourceid="ds" AutoGenerateColumns="False" CssClass="gv" OnRowCreated="gv_RowCreated" DataKeyNames="ref" meta:resourcekey="gvResource1" AllowPaging="True">
            <Columns>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
<asp:CheckBox runat="server" ID="chkSelect" meta:resourcekey="chkSelectResource1"></asp:CheckBox>

                    
</ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField HeaderText="Референс документа" DataTextField="REF" DataNavigateUrlFields="DOC_URL" meta:resourcekey="HyperLinkFieldResource1">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:HyperLinkField>
                <asp:BoundField DataField="ERR_CODE" HeaderText="Код ошибки" meta:resourcekey="BoundFieldResource1">
                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="ERR_MSG" HeaderText="Описание ошибки" meta:resourcekey="BoundFieldResource2">
                    <ItemStyle Width="300px" HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="gvNormalRowStyle" />
            <HeaderStyle CssClass="gvHeaderRowStyle" height="40px" />
            <AlternatingRowStyle CssClass="gvAlternatingRowStyle" />
        </Bars:BarsGridView>
        <asp:Label ID="lblMsg1" runat="server" Visible="False" meta:resourcekey="lblMsg1Resource1"></asp:Label>
        <asp:Label ID="lblMsg2" runat="server" Visible="False" meta:resourcekey="lblMsg2Resource1"></asp:Label>
        <asp:Label ID="lblMsg3" runat="server" Visible="False" meta:resourcekey="lblMsg3Resource1"></asp:Label>
    </form>
</body>
</html>
