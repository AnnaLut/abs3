<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DpuOutcome.aspx.cs" Inherits="DpuOutcome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Підсумки депозитного портфелю депозитів ЮО за період</title>

    <link href="/barsroot/Content/Themes/Kendo/app.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="/barsroot/Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    
    <style>
        .demo-section {
            overflow: auto;
        }
        .metrotable {
            width: 100%;
            border-collapse: collapse;
        }
                
        .metrotable > thead > tr > th 
        {
            font-size: 1.3em;
            padding-top: 0;
            padding-bottom: 5px;
        }
    </style>

    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/kendo/kendo.all.min.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.config.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.ui.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/bars/bars.extension.js"></script>

    <script type="text/javascript" src="/barsroot/udeposit_admin/dpuoutcome.js"></script>

</head>
<body>
    <form id="frmOutcome" runat="server">
    <div>
        <div id="d1">
            <table style="width: 100%">
                <tr>
                    <td style="width: 50%;">

                    </td>
                    <td  style="width: 50%;">
                        <div class="demo-section k-content">
                            <table id="section" class="metrotable">
                                <thead>
                                    <tr>
                                        <th>Order</th>
                                        <th>State</th>
                                        <th>Title</th>
                                        <th>Code</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="4"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <script id="template" type="text/x-kendo-template">
                            <tr>
                                <td>#= order #</td>
                                <td>#= state #</td>
                                <td>#= title #</td>
                                <td>#= code #</td>
                            </tr>
                        </script>
                    </td>
                </tr>
            </table>
        </div>
        <div id="d2">

        </div>
    </div>
    </form>
</body>
</html>
