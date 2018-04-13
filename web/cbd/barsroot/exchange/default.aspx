<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="default.aspx.cs" Inherits="_Default" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Імпорт файлів платежів</title>
</head>
<body>
    <form id="form_ab_exchange" runat="server">
    <div>
        <asp:Label ID="label_Info" runat="server" Text="Импорт файлов платежей" EnableViewState="False" Font-Bold="True" meta:resourcekey="label_InfoResource1"></asp:Label><br />
        <br />
        <asp:Panel meta:resourcekey="pnOptionsResource1" ID="pnOptions" runat="server" Font-Bold="False" Font-Size="11pt" GroupingText="Настройки импорта"
            Width="700px">
            <table>
                <tr>
                    <td style="white-space:nowrap">
        <asp:Label ID="label_check" runat="server" Font-Strikeout="False" Font-Underline="False"
            Text="Проверять наличие:" EnableViewState="False" meta:resourcekey="label_checkResource1" Font-Bold="True"></asp:Label></td>
                    <td  style="white-space:nowrap; width: 294px;">
        <asp:CheckBox ID="chk_service_line" runat="server" Text="служебной строки" meta:resourcekey="chk_service_lineResource1" />
        <asp:CheckBox ID="chk_header_line" runat="server" Text="заглавной строки" meta:resourcekey="chk_header_lineResource1" /></td>
                </tr>
                <tr>
                    <td  style="white-space:nowrap">
        <asp:Label ID="label_encoding" runat="server" Font-Underline="False" Text="Кодировка:" EnableViewState="False" meta:resourcekey="label_encodingResource1" Font-Bold="True"></asp:Label></td>
                    <td  style="white-space:nowrap; width: 294px;">
        <asp:RadioButton ID="rb_dos" runat="server" Checked="True" GroupName="encoding"
            Text="DOS" meta:resourcekey="rb_dosResource1" />&nbsp;
        <asp:RadioButton ID="rb_win" runat="server" GroupName="encoding" Text="Windows" meta:resourcekey="rb_winResource1" OnCheckedChanged="rb_win_CheckedChanged" /></td>
                </tr>
                <tr>
                    <td  style="white-space:nowrap">
        <asp:Label ID="label_linesize" runat="server" Font-Underline="False" Text="Размер строки (байт):" meta:resourcekey="label_linesizeResource1" Font-Bold="True"></asp:Label></td>
                    <td  style="white-space:nowrap; width: 294px;">
                        <asp:TextBox ID="tbLineSize" runat="server" Width="50px">593</asp:TextBox></td>
                </tr>
                <tr>
                    <td style="white-space:nowrap">
                        <asp:Label ID="label_filetype" runat="server" Font-Bold="True" Font-Underline="False" meta:resourcekey="label_filetypeResource1"
                            Text="Тип файла:"></asp:Label></td>
                    <td style="white-space:nowrap">
                        <asp:DropDownList ID="ddFileTypes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddFileTypes_SelectedIndexChanged"
                            Width="300px">
                        </asp:DropDownList></td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:FileUpload ID="fu_import" runat="server" Width="500px" meta:resourcekey="fu_importResource1" EnableViewState="False"/>
        <asp:Button ID="bt_submit" runat="server" EnableViewState="False" Height="20px" OnClick="bt_submit_Click"
            Text="Загрузить файл" meta:resourcekey="bt_submitResource1" /><br />
        <br />
        <asp:Label ID="label_error" runat="server" EnableViewState="False" ForeColor="Red"
            Text="Ошибка:" Font-Underline="True" Visible="False" meta:resourcekey="label_errorResource1"></asp:Label><br />
        <asp:TextBox ID="text_error" runat="server" Height="100%" TextMode="MultiLine" Visible="False"
            Width="100%" EnableViewState="False" Rows="10" ReadOnly="True" meta:resourcekey="text_errorResource1" ForeColor="Red"></asp:TextBox>
        <br />
    </div>
    </form>
</body>
</html>
