<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tab_linked_custs_seal_img.aspx.cs" Inherits="clientregister_tab_linked_custs_seal_img" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Образ печати</title>
    <script language="javascript" type="text/jscript">
        function ReturnValue()
        {
            window.returnValue = document.getElementById('imdSeal').srcid;
            window.close(); 
            
            return false;           
        }
    </script>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <table border="0" cellpadding="3px" cellspacing="0">
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Image ID="imdSeal" Width="300px" Height="300px" BorderColor="#94abd9" BorderStyle="solid" BorderWidth="1px" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding: 10px 10% 2px 10%">
                        <hr style="color: #94abd9" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 10px; padding-top: 5px"><asp:FileUpload ID="fuLoad" runat="server" ToolTip="Выберете файл для загрузки" /></td>
                    <td style="padding-bottom: 10px; padding-top: 5px"><asp:Button ID="btSave" runat="server" Text="Загрузить" EnableTheming="True" ToolTip="Сохранить файл образа" Width="75px" OnClick="btSave_Click" /></td>
                </tr>
                <tr>
                    <td colspan="2" style="padding: 10px 10% 2px 10%">
                        <hr style="color: #94abd9" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Button ID="btOk" runat="server" Text="Ok" OnClientClick="return ReturnValue()" Width="50px" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
