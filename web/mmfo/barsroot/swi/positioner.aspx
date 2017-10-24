<%@ Page Language="C#" AutoEventWireup="true" CodeFile="positioner.aspx.cs" Inherits="swi_positioner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Позиціонер банку</title>
    <script type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" src="../Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="../Scripts/Bars/bars.config.js"></script>
    <script type="text/javascript" src="../Scripts/Bars/bars.extension.js"></script>
    <script>
        $(document).ready(function () {
            // todo: remove it!
            window.location.href = bars.config.urlContent("/swift/positioner");
        });
    </script>

</head>
<body></body>
</html>
