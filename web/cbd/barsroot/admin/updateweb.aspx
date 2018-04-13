<%@ Page Language="C#" AutoEventWireup="true" CodeFile="updateweb.aspx.cs" Inherits="admin_updateweb" meta:resourcekey="PageResource1" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Обновление</title>
    <script type="text/jscript" language="javascript" src="\Common\Script\Encrypt\sha1.js"></script>
    <script language="javascript" type="text/jscript">
    var _mProg;
    function fnShowProgress()
    {
	    if (_mProg == null)
	    {
		    var top = document.body.offsetHeight/2 - 15;
		    var left = document.body.offsetWidth/2 - 50;
		    var s = '<div style="position: absolute; top:'+top+'; background:white; left:'+left+'; width:101; height:33;" >'+
		    ''+
		    '</div>';
		    _mProg = document.createElement(s);
		    _mProg.innerHTML = '<img src=/Common/Images/process.gif>';
	    }
	    _mProg.style.top = document.body.offsetHeight/2 - 15;
	    _mProg.style.left = document.body.offsetWidth/2 - 50;
	    if (_mProg.parentElement == null)
	    document.body.insertAdjacentElement("beforeEnd",_mProg);
    }
    </script>
</head>
<body bgcolor="#f0f0f0">
    <form id="form1" runat="server">
    <div align="center">
        <asp:Label ID="lbTitle" runat="server" Text="Администрирование обновлений" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt" meta:resourcekey="lbTitleResource1"></asp:Label>
        </div>
        <table cellpadding="1" cellspacing="1" width="100%" border="1">
        <tr>
                <td style="height: 24px">
                    <asp:Label ID="lbCurrVersion" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="10pt" ForeColor="Navy" Text="Текущая версия:" meta:resourcekey="lbCurrVersionResource2"></asp:Label>
                    <asp:TextBox ID="tbCurrVersion" style="text-align:center" runat="server" ReadOnly="True" BorderStyle="Solid" BorderWidth="1px" Width="120px" Font-Bold="False" Height="22px" meta:resourcekey="tbCurrVersionResource1"></asp:TextBox>&nbsp;<asp:Button
                        ID="btClearReg" runat="server" OnClick="btClearReg_Click" Width="0px" />
                    <asp:Label ID="lbDateUpdate" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="10pt" ForeColor="Navy" Text="Дата текущей версии :" meta:resourcekey="lbDateUpdateResource1"></asp:Label>
                    <asp:TextBox ID="tbDateUpdate" runat="server" BorderStyle="Solid" BorderWidth="1px"
                        Font-Bold="False" Height="22px" ReadOnly="True" Style="text-align: center" Width="120px" meta:resourcekey="tbDateUpdateResource1"></asp:TextBox>
                    <asp:Button ID="btDownloadUpdate" runat="server" BorderStyle="Solid" BorderWidth="1px"
                        OnClick="btDownloadUpdate_Click" Text="Проверить обновления online" Visible="False" meta:resourcekey="btDownloadUpdateResource2" /></td>
        </tr>        
                    
            <tr>
                <td align="center">
                    <asp:Label ID="lbLelelsUpdate" runat="server" Font-Bold="True" Font-Names="Verdana"
                        Font-Size="10pt" Text="Этапы обновления:" meta:resourcekey="lbLelelsUpdateResource1"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Level1" runat="server" BorderStyle="Ridge" BorderWidth="2px"
                        Enabled="False" Width="100%" meta:resourcekey="Level1Resource2">
                        <asp:Label ID="lbLevel1" runat="server" Font-Bold="True" Text="Этап №1" Width="100%" meta:resourcekey="lbLevel1Resource1"></asp:Label>
                        &nbsp;<asp:Button ID="btCheckInteg" runat="server" BorderStyle="Solid" BorderWidth="1px" OnClick="btCheckInteg_Click" Text="Проверка целосности текущей версии" ToolTip="Проверка контрольных сумм файлов от момента последнего обновления" meta:resourcekey="btCheckIntegResource1" /></asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Level2" runat="server" BorderStyle="Ridge" BorderWidth="2px" Enabled="False" Width="100%" EnableTheming="True" meta:resourcekey="Level2Resource2">
                        <asp:Label ID="lbLevel2" runat="server" Font-Bold="True" Text="Этап №2" Width="100%" meta:resourcekey="lbLevel2Resource1"></asp:Label>
                        &nbsp;<asp:FileUpload ID="FileUpload" runat="server" Width="500px" BorderStyle="Solid" BorderWidth="1px" Height="22px" EnableTheming="True" meta:resourcekey="FileUploadResource2" />&nbsp;<br />
                        &nbsp;<asp:Label ID="lbPassword" runat="server" Font-Bold="True" Font-Names="Verdana"
                            Font-Size="10pt" Text="Пароль на архив:" Width="130px" meta:resourcekey="lbPasswordResource1"></asp:Label>
                        <asp:TextBox ID="tbPassword" runat="server" BorderStyle="Solid" BorderWidth="1px"
                            Height="22px" TextMode="Password" Width="209px" meta:resourcekey="tbPasswordResource1"></asp:TextBox>
        <asp:Button ID="btUpload" runat="server" OnClick="Upload_Click" Text="Загрузить" BorderStyle="Solid" BorderWidth="1px" Width="153px" meta:resourcekey="btUploadResource2" /></asp:Panel>
                </td>
        
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="Level3" runat="server" BorderStyle="Ridge" BorderWidth="2px" Enabled="False"
                        Height="50px" Width="100%" meta:resourcekey="Level3Resource1">
                        <asp:Label ID="lbLevel3" runat="server" Font-Bold="True" Text="Этап №3" Width="100%" meta:resourcekey="lbLevel3Resource1"></asp:Label>&nbsp;<asp:Button
                            ID="btUpdate" runat="server" BorderStyle="Solid" BorderWidth="1px" OnClick="btUpdate_Click"
                            Text="Обновить" Width="150px" meta:resourcekey="btUpdateResource2" />&nbsp;
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="height: 58px">
                    &nbsp;<asp:Label ID="lbStatus" runat="server" Font-Bold="False" Font-Size="10pt"
                        ForeColor="Navy" Text="Информация:" Width="0px" meta:resourcekey="lbStatusResource1"></asp:Label>
                    <asp:Button ID="btAdminRegen" runat="server" Height="0px" Text="Перегенерировать для даного файла" style="visibility:hidden" BorderStyle="Solid" BorderWidth="1px" OnClick="btAdminRegen_Click" meta:resourcekey="btAdminRegenResource2"  />
                    <asp:TextBox ID="tbMessage" runat="server" Rows="10" TextMode="MultiLine" Width="100%" ReadOnly="True" BackColor="Info" meta:resourcekey="tbMessageResource1"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="height: 18px" align="center">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                        Text="Откат обновления:" meta:resourcekey="Label1Resource2" ></asp:Label></td>
            </tr>
        <tr>
                <td>
                    <asp:Panel ID="pRollBack" runat="server" BorderStyle="Ridge" BorderWidth="2px" Enabled="False"
                        Height="50px" Width="100%" meta:resourcekey="pRollBackResource1">
                        &nbsp;<asp:Label ID="lbPassRollBack" runat="server" Font-Bold="True" Font-Names="Verdana"
                            Font-Size="10pt" Text="Пароль на откат:" Width="130px" meta:resourcekey="lbPassRollBackResource1"></asp:Label>
                        <asp:TextBox ID="tbPasswordRollback" runat="server" BorderStyle="Solid" BorderWidth="1px"
                            Height="22px" TextMode="Password" Width="209px" meta:resourcekey="tbPasswordRollbackResource1"></asp:TextBox>
                        <asp:Button ID="btRollBack" runat="server" BorderStyle="Solid" BorderWidth="1px" OnClick="btRollBack_Click" Text="Откат последнего обновления" Width="343px" meta:resourcekey="btRollBackResource2" /></asp:Panel>
                    <input id="hFile" runat="server" type="hidden" /></td>
        </tr>
        </table>
    </form>
</body>
</html>
