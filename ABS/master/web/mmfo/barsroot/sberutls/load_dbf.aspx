<%@ Page Language="C#" AutoEventWireup="true" CodeFile="load_dbf.aspx.cs" Inherits="sberutls_load_dbf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title title="Завантаження DBF-таблиць"></title>
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

    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <br>ЗАВАНТАЖЕННЯ DBF-таблиць
                        </br>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <hr />
            <table>
                
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbNameFile" Text="Кодування вхідного файлу"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbEncodeInpuFileDos" Text="DOS"></asp:Label>
                        <asp:RadioButton runat="server" ID="rbEncodeInpuFileDos" GroupName="InputFile" Checked="true" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbEncodeInpuFileWin" Text="WIN"></asp:Label>
                        <asp:RadioButton runat="server" ID="rbEncodeInpuFileWin" GroupName="InputFile" />
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbNameData" Text="Кодування даних для вставки"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbEncodeInpuDataDos" Text="DOS"></asp:Label>
                        <asp:RadioButton runat="server" ID="rbEncodeInpuDataDos" GroupName="InputData" />
                    </td>
                    <td>
                        <asp:Label runat="server" ID="lbEncodeInpuDataWin" Text="WIN"></asp:Label>
                        <asp:RadioButton runat="server" ID="rbEncodeInpuDataWin" GroupName="InputData" Checked="true" />
                    </td>

                </tr>
                 
            </table>
           <hr />
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lb1" Text="Перестворити таблицю"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton runat="server" ID="rb1" GroupName="Table" Checked="true"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lb0" Text="Створити ім'я+час, якщо така існує"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton runat="server" ID="rb0" GroupName="Table"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lb2" Text="Видалити дані з таблиці"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton runat="server" ID="rb2" GroupName="Table"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lb3" Text="Нічого не робити, якщо така існує"></asp:Label>
                    </td>
                    <td>
                        <asp:RadioButton runat="server" ID="rb3" GroupName="Table"/>
                    </td>
                </tr>
            </table>
            <hr/>
            <table>
                <tr>
                    <br>Файл:
                    </br>
                    <td>
                        <asp:FileUpload ID="fileUpload" runat="server" EnableViewState="false" />
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <br />
                        <asp:Button ID="btnLoad" runat="server" Text="Завантажити"
                            OnClick="btnLoad_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divMsg" style="color: Red" runat="server"></div>
                        <div id="divMsgOk" style="color: Green" runat="server"></div>
                    </td>

                </tr>
            </table>
        </div>
    </form>
</body>
</html>
