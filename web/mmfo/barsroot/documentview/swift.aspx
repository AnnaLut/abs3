<%@ Page Language="C#" AutoEventWireup="true" CodeFile="swift.aspx.cs" Inherits="Swift" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Свіфт</title>
    <link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <%--<pre id="edMain" runat="server"></pre>--%>
        <textarea rows="12" cols="80" style="height:400px" id="edMain" readonly="readonly" runat="server"></textarea>
    </form>
</body>
</html>
