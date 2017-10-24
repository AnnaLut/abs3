<%@ Page Language="C#" AutoEventWireup="true" CodeFile="unlock_msg.aspx.cs" Inherits="swi_unlock_msg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Управління формуванням повідомлень</title>
    <script type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" src="../Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="../Scripts/Bars/bars.config.js"></script>
    <script type="text/javascript" src="../Scripts/Bars/bars.extension.js"></script>
    <script>
        $(document).ready(function () {
            // todo: remove it!
            var mt = bars.extension.getParamFromUrl('mt');
            window.location.href = bars.config.urlContent("/swift/unlockmsg?mt=" + mt);
        });
    </script>

</head>
<body></body>
</html>
