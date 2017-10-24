<%@ Page Language="C#" AutoEventWireup="true" CodeFile="importsalary.aspx.cs" Inherits="sberutls_importsalary" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tcont" /> 
    <table>
        <tr>
            <td>
                <div id="salGrid" runat="server"></div>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                Файл:
                <br />
                <asp:FileUpload Width="100%" ID="fileUpload" runat="server" EnableViewState="false"  />
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btnLoad" runat="server" Text="Завантажити" 
                    onclick="btnLoad_Click" />
            </td>
        </tr>
        <tr>
                    <td>
            <div id="divMsg" style="color:Red" runat="server"></div>
            <div id="divMsgOk" style="color:Green" runat="server"></div>
            </td>

        </tr>
    </table>
    </form>
</body>
</html>
