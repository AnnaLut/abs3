<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DptParsingPayments.aspx.cs" Inherits="DptParsingPayments" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Картотека надходжень на рах. ген. дог. ДЮО</title>
    
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.default.min.css" rel="stylesheet" />

    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <script type="text/javascript" src="/barsroot/udeposit/Scripts/dptparsingpayments.js"></script>

</head>
<body>
    <form id="frmParsingPayments" runat="server">
    <div>
        <div>

        </div>
    </div>
    <div id="splitter"  style="height:600px;">
      <div id="TopPanel">
          <div id="TopGrid">
          </div>
      </div>
      <div id="BottomPanel">
          <div id="BottomGrid">
          </div>
      </div>
    </div>
    </form>
</body>
</html>
