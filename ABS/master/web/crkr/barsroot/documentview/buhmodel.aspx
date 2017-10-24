<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BuhModel.aspx.cs" Inherits="BuhModel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Бух. Модель</title>
    <link href="CSS/AppCSS.css" type="text/css" rel="Stylesheet" />
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <asp:GridView ID="grdData" runat="server" AutoGenerateColumns="False" EnableViewState="False">
            <Columns>
                <asp:BoundField DataField="FDAT" HeaderText="Дата" HtmlEncode="False" DataFormatString="{0:dd.MM.yyyy}" meta:resourcekey="BoundFieldResource1" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TT" HeaderText="Опер." meta:resourcekey="BoundFieldResource2">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="NLS" HeaderText="Счет" meta:resourcekey="BoundFieldResource3" />
                <asp:BoundField DataField="KV" HeaderText="Вал." meta:resourcekey="BoundFieldResource4">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DOS" HeaderText="Дебет" DataFormatString="{0:###### ##0.00##}" HtmlEncode="False" meta:resourcekey="BoundFieldResource5">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="KOS" HeaderText="Кредит" DataFormatString="{0:###### ##0.00##}" HtmlEncode="False" meta:resourcekey="BoundFieldResource6">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField DataField="NMS" HeaderText="Наименование" meta:resourcekey="BoundFieldResource7" />
                <asp:BoundField DataField="TXT" HeaderText="Подробности" meta:resourcekey="BoundFieldResource8">
                    <ItemStyle HorizontalAlign="Left" />
                </asp:BoundField>
                <asp:BoundField DataField="BRANCH" HeaderText="Код подр." meta:resourcekey="BoundFieldResource9" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
