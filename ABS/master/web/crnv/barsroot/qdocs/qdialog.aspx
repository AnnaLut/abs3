<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qdialog.aspx.cs" Inherits="QDialog" 
CodeFileBaseClass="Bars.BarsPage" EnableViewState="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="css/Default.css" type="text/css" rel="Stylesheet"/>
</head>
<body>
    <form id="QDialogForm" runat="server">
        <asp:Table ID="tblDlg" runat="server" Height="100%" Width="100%" EnableViewState="False">
            <asp:TableRow ID="TableRow1" runat="server" Height="30%"> 
                <asp:TableCell ID="TableCell1" runat="server" Height="50%">
                &nbsp;<br /><br />
                </asp:TableCell>
             </asp:TableRow>
            <asp:TableRow runat="server" Height ="40%">
                <asp:TableCell runat="server" Width="20%" />
                <asp:TableCell runat="server" Width="60%" VerticalAlign="Middle">
                    <asp:Panel ID="pnl" runat="server"  GroupingText="Caption">
                    <br />
                    <asp:Literal ID="literal" runat="server">MessageText</asp:Literal>
                    <br />
                    <br />
                    <asp:PlaceHolder ID="btnHolder" runat="server">
                    </asp:PlaceHolder>
                    </asp:Panel>
                </asp:TableCell>
                <asp:TableCell runat="server" Width="20%" />
            </asp:TableRow>
        </asp:Table>
    </form>
</body>
</html>
