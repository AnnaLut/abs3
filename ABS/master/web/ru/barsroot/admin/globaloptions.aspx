<%@ Page Language="C#" Inherits="BarsWeb.Admin.GlobalOptions" CodeFile="globaloptions.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Базові параметри</title>
    <style>.lbClass {font-family:Verdana;font-size:10pt;font-weight:bold} </style>
    <script language=javascript>
    function doNum()
    {
	    var digit = ( (event.keyCode > 95 && event.keyCode < 106) 
	    || (event.keyCode > 47 && event.keyCode < 58) );	
	    if((event.keyCode > 8) && !digit) return false;
	    else return true;
    }
    </script>
</head>
<body bgColor="#f0f0f0">
    <form runat="server">
    <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
    <TR><TD align="center"><asp:label id="Label1" key="Label1" runat="server" Font-Bold="True" Font-Size="12pt" Font-Names="Verdana"
							ForeColor="Navy">Налаштування системи</asp:label></TD> </TR>
    <TR><TD style="border:solid 1pt black">
        <div class=lbClass style="color: white; border-top-style: groove; border-right-style: groove; border-left-style: groove; background-color: gray; border-bottom-style: groove">Безпека</div>
        <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
        <TR>
        <TD nowrap><asp:Label CssClass=lbClass ID="lbPswLength" runat="server" Text="Мінімальна довжина пароля"></asp:Label></TD>
        <TD style="width: 80px">
            <asp:TextBox ID="tbPswLength" runat="server" Width="60px"></asp:TextBox></TD>
        </TR>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label CssClass=lbClass ID="Label2" runat="server" Text="Максимально допустима довжина послідовностей"></asp:Label></td>
                <td style="width: 80px">
            <asp:TextBox ID="tbSeqLength" runat="server" Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="Label3" runat="server" CssClass="lbClass" Text="Максимальний строк дії пароля (в днях)"></asp:Label></td>
                <td style="width: 80px; height: 21px;">
                    <asp:TextBox ID="tbPswExp" runat="server" Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lbAttempts" runat="server" CssClass="lbClass" Text="Кількість спроб неправильного вводу пароля"></asp:Label></td>
                <td style="width: 80px; height: 21px">
                    <asp:TextBox ID="tbPswAttempts" runat="server" Width="60px"></asp:TextBox></td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lbTimeoutCookie" runat="server" CssClass="lbClass" Text="Час простою без блокування(в хв.)"></asp:Label></td>
                <td style="width: 80px; height: 21px">
                    <asp:TextBox ID="tbCookieTime" runat="server" Width="60px"></asp:TextBox></td>
            </tr>
        </TABLE>
        
        
        
    </TD></TR>
    <TR><TD style="height: 21px"></TD></TR>
    <TR><TD align="center">
        <asp:Button ID="btSave" runat="server" OnClick="btSave_Click" Text="Зберегти зміни" />&nbsp;
        <asp:Button ID="btRefresh" runat="server" Text="Перечитати" OnClick="btRefresh_Click" />&nbsp;
        <asp:Button ID="btGC" runat="server" Text="Очистити пам'ять" 
            onclick="btGC_Click" />
        </TD></TR>
    <TR><TD></TD></TR>
    </TABLE>
    
    </form>
    <script>
        document.getElementById("tbPswExp").attachEvent("onkeydown",doNum);
        document.getElementById("tbSeqLength").attachEvent("onkeydown",doNum);
        document.getElementById("tbPswLength").attachEvent("onkeydown",doNum);
        document.getElementById("tbPswAttempts").attachEvent("onkeydown",doNum);
    </script>
</body>
</html>
