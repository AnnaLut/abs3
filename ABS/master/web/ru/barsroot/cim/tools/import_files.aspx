<%@ Page Title="Імпорт файлів" Language="C#" MasterPageFile="~/cim/default.master" AutoEventWireup="true" CodeFile="import_files.aspx.cs" Inherits="cim_tools_import_files" %>

<%@ MasterType VirtualPath="~/cim/default.master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:Panel runat="server" ID="pnImportF98" GroupingText="Імпорт файлу санкцій Мінекономіки (F98)">
        <table>
            <tr>
                <td>Вкажіть файл</td>
                <td>
                    <asp:FileUpload runat="server" ID="fuF98" Width="400px" />
                </td>
                <td>
                    <asp:Button runat="server" ID="btImportF98" Text="Імпорт файлу" OnClick="btImportF98_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label runat="server" ID="lbInfo"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>

