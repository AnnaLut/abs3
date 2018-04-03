<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dynamic.aspx.cs" Inherits="barsweb_dynamic" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width:99%">
            <tr>                
                <td colspan="3" style="text-align:center">
                    <asp:Label ID="lbTitle" runat="server">Сторнування документів по валютообмінних операціях</asp:Label></td>
            </tr>
            <tr>
                <td colspan="3"></td>
            </tr>            
            <tr>
                <td id="param1_desc" runat="server" style="width:40%; text-align:right">
                    <asp:Label ID="lbParam1" runat="server" Text="Референс документа"></asp:Label></td>
                <td id="param1_ctrl" runat="server" style="width:20%"></td>
                <td style="width:40%"></td>
            </tr>
            <tr>
                <td id="param2_desc" runat="server" style="width:40%; text-align:right">
                    <asp:Label ID="lbParam2" runat="server" Text=""></asp:Label></td>
                <td id="param2_ctrl" runat="server" style="width:20%"></td>
                <td style="width:40%"></td>
            </tr>
            <tr>
                <td id="param3_desc" runat="server" style="width: 40%; text-align:right">
                    <asp:Label ID="lbParam3" runat="server" Text=""></asp:Label></td>
                <td id="param3_ctrl" runat="server" style="width: 20%">
                </td>
                <td style="width: 40%">
                </td>
            </tr>
            <tr>
                <td runat="server" style="width: 40%; text-align: right">
                </td>
                <td runat="server" style="width: 20%">
                </td>
                <td style="width: 40%">
                </td>
            </tr>
            <tr>
                <td colspan="3" style="text-align:center">
                    &nbsp;<asp:Button ID="btExec" runat="server" Text="Виконати" OnClick="btExec_Click" />
                </td>
            </tr>                        
        </table>
    </form>
</body>
</html>
