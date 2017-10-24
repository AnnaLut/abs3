<%@ Page Language="C#" AutoEventWireup="true" CodeFile="import_rates.aspx.cs" Inherits="sberutls_import_rates" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title title="Завантаження курсів валют"> </title>
     <style type="text/css">
        .title {
            border-bottom-color: #CCD7ED;
            border-bottom: 1px solid;
            margin-bottom: 20px;
            font-size: 12pt;
            color: #1C4B75;
        }

        #lblRes {
            width: 300px;
        }

        #lblRes0 {
            width: 300px;
        }

        #lblResOk {
            width: 340px;
        }

        #lblResBad {
            width: 314px;
        }
    </style>
</head>
<body>
    
    <form id="form2" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <br>
                             Завантаження курсів валют #99*.*, *.VAL, *.BMT
                        </br>
                    </td>
                </tr>
            </table>
        </div>
    <div>
        <table>
    <tr>
        <br>
            Файл:
        </br>
        <td>
                <asp:FileUpload ID="fileUpload" runat="server" EnableViewState="false"/>
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
    </div>
    </form>
</body>
</html>
