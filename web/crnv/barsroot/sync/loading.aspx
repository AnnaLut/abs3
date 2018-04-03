<%@ Page Language="C#" AutoEventWireup="true" CodeFile="loading.aspx.cs" Inherits="sync_loading" %>

<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Завантаження</title>
    <link href="style.css" type="text/css" rel="stylesheet" /> 
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <uc1:loading ID="loading1" runat="server" />
    
    </div>
    </form>
</body>
</html>
