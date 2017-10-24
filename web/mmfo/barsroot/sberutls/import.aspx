<%@ Page Language="C#" AutoEventWireup="true" CodeFile="import.aspx.cs" Inherits="sberutls_import" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet"/>
    <style type="text/css">
        .title {
	        border-bottom-color: #CCD7ED;
	        border-bottom: 1px solid ;
	        margin-bottom: 20px;
	        font-size: 12pt;
	        color: #1C4B75;
    }
        #lblRes
        {
            width: 300px;
        }
        #lblRes0
        {
            width: 300px;
        }
        #lblResOk
        {
            width: 340px;
        }
        #lblResBad
        {
            width: 314px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td class="title">
                    <div style="font-size:12pt;" runat="server" id="divCaption"></div>
                </td>
            </tr>
          
            <tr>
                <td>
                    <br />
                    Файл: <asp:FileUpload ID="fileUpload" runat="server" EnableViewState="false" Width="609px" />
                </td>
            </tr>
            <tr>
                <td align="left" style="height: 35px">
                    <div style="padding-top:10px; padding-bottom:10px;">
                        <asp:Button ID="btnLoad" runat="server" Text="Завантажити" OnClick="btnLoad_Click" 
                        OnClientClick="if(!fileUpload.value){alert('Потрiбно вибрати файл'); return false;}tbMessage.value='';if (document.getElementById('lblResOk')) resTd.removeChild(document.getElementById('lblResOk'));if (document.getElementById('lblResBad')) resTd.removeChild(document.getElementById('lblResBad'));" />
                    </div>
                    <div align="left">Протокол:</div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 982px">
                    <asp:TextBox ID="tbMessage" runat="server" ReadOnly="True" Rows="10" TextMode="MultiLine"
                        Width="99%"></asp:TextBox></td>
            </tr>
            <tr>
            <td>
                <asp:Button ID="btnGetLog" runat="server" Text="Зберегти протокол" OnClick="btnGetLog_Click" />
            </td>
            </tr>
            <tr>
            <td id="resTd">
                <br />
                <input type="text" runat="server" id="lblResOk" value="Файл успiшно оброблено" 
                    style="background-color: #99FFCC" visible="False" readonly="readonly" />
                <input type="text" runat="server" id="lblResBad" value="Файл вiдбраковано" 
                    style="background-color: #FF6666" visible="False" readonly="readonly" /></td>
            </tr>     
            <tr>
                <td>
                <hr />
                <div runat="server" id="divDllinfo" style="font-size:7pt;"></div>
                </td>
            </tr>       
        </table>
    </form>
</body>
</html>
