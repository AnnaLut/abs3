<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view_swift.aspx.cs" Inherits="Swift" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SWIFT</title>
    <link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
    <style>
	    .titleLabel {
		    font-weight: bold;
		    color: #2e6e9e;
		    font-size: 11pt;
		}
    	@media print {
    	    .noprint {display:none;}
		}
    </style>
    <script type="text/javascript">
        function printDoc() {
            window.print();
        }
    </script>
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
    	<div>
            <asp:Label CssClass="titleLabel noprint" ID="lbPageTitle" runat="server">Повідомлення SWIFT #</asp:Label>
        </div>
        <table>
            <tr>
                <td style="text-align: right" class="noprint">
                    <input type="button" value="Друк" onclick="printDoc()">
                    <asp:Button runat="server" Text="Файл" ID="btExport" OnClick="btExport_Click" />
                    </td>
            </tr>
            <tr>
                <td>
                    <pre ID="edMain" runat="server"></pre>
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
