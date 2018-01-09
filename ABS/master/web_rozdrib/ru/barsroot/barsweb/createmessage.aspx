<%@ Page Language="C#" AutoEventWireup="true" CodeFile="createmessage.aspx.cs" Inherits="barsweb_createmessage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
 <title>Создание сообщений</title>
 <link href="/Common/Css/AjaxCSS.css" type="text/css" rel="stylesheet">
<base target=_self></base>    
<script language=javascript>
   function addUser(ctrl,id)
   {
        if(ctrl.checked)
            document.all.tbUsers.value += id + ";";
        else 
            document.all.tbUsers.value = document.all.tbUsers.value.replace(id+";","");
   }
   function selectAll()
   {
      var i=0;  
      document.all.tbUsers.value = "";
      while(document.getElementById("listUsers_"+i))
      {
        document.getElementById("listUsers_"+i).checked = document.getElementById("cbAll").checked;
        document.getElementById("listUsers_"+i).fireEvent("onclick");
        i++;
      }
   }
   function validateForm()
   {
        if(document.all.tbUsers.value == "" && !document.all.cbAdmin.checked){
            alert("Укажите получателей.");
            return false;
        }
        if(document.all.tbMessage.value == "")
        {
            alert("Укажите текст сообщения.");
            return false;
        }
        return true;
   }
</script>
</head>
<body bottomMargin="0" bgColor="#f0f0f0" leftMargin="0" topMargin="0" rightMargin="0">
    <form id="formMessaging" runat="server">
    <div align=center>
        <asp:Label ID="lbTitle" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt"
            Text="Создать сообщение"></asp:Label>
            </div>
        <table  cellpadding="1" cellspacing="0" bordercolor="#CCD7ED" border=1 style="border-color:#CCD7ED;border-style:solid;border-width:1px">
            <tr>
                <td colspan="2">
                </td>
                <td rowspan="1" style="overflow: visible" valign="top">
                    <asp:Label ID="lbListUsers" runat="server" Font-Bold="True" Font-Italic="True" Font-Names="Verdana"
                        Font-Size="10pt" Text="Список пользователей:" Width="325px" style="text-align:center"></asp:Label></td>
            </tr>
            <tr>
                <td  align="right" style="width: 1px">
                    <asp:Label ID="lbReceiver" runat="server" Text="Кому:" Font-Bold="True" Font-Italic="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="tbUsers" runat="server" Width="280px" TextMode="MultiLine" Font-Names="Verdana" Font-Size="8pt" Rows="3" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
                <td rowspan="4" valign="top" style="overflow:visible">
                    <asp:Panel ID="Panel" runat="server" BorderStyle="Solid" BorderWidth="1px" Height="152px"
                        ScrollBars="Vertical" Width="320px">
                        <asp:CheckBoxList ID="listUsers" runat="server" BackColor="White" CellPadding="0"
                            CellSpacing="0" Font-Bold="False" Font-Italic="True" Font-Names="Verdana" Font-Size="8pt" Width="300px">
                        </asp:CheckBoxList></asp:Panel>
                    <asp:CheckBox ID="cbAll" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="8pt" Text="Выделить всех" />
                    <br />
                    <asp:CheckBox ID="cbAdmin" runat="server" Font-Names="Verdana" Font-Size="8pt" Text="Отправить копию сообщения администртртору." /></td>
            </tr>
            <tr>
                <td align="right" style="width: 1px">
                    <asp:Label ID="lbMessage" runat="server" Text="Текст сообщения:" Font-Bold="True" Font-Italic="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="tbMessage" runat="server" BackColor="Info" Rows="6" TextMode="MultiLine"
                        Width="280px" Font-Names="Verdana" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox></td>
            </tr>
            <tr>
                <td align=right style="width: 1px">
                    <asp:Label ID="lbTerm" runat="server" Font-Bold="True" Font-Italic="True" Font-Names="Verdana"
                        Font-Size="10pt" Text="Срок ожидания:"></asp:Label></td>
                <td >
                    <asp:TextBox ID="tbLifeTime" runat="server" Width="40px" style="text-align:center">1</asp:TextBox>
                    &nbsp;&nbsp;
                    <asp:DropDownList ID="ddTerm" runat="server">
                        <asp:ListItem Value="0">Минут</asp:ListItem>
                        <asp:ListItem Selected="True" Value="1">Часов</asp:ListItem>
                        <asp:ListItem Value="2">Дней</asp:ListItem>
                        <asp:ListItem>Месяцев</asp:ListItem>
                    </asp:DropDownList><br />
        </td>
            </tr>
            <tr>
                <td style="width: 1px;">
                </td>
                <td>
                    <asp:Button ID="btSend" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11pt"
                        Text="Отправить" OnClick="btSend_Click" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
