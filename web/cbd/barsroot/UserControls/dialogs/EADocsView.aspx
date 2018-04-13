<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EADocsView.aspx.cs" Inherits="UserControls_dialogs_EADocsView" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Перегляд документів ЕА</title>

    <link rel="stylesheet" type="text/css" href="/Common/CSS/jquery/jquery.css" />
    <script type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#dvDocs")
              .accordion({
                  header: "> div > h3",
                  icons: false,
                  heightStyle: "content"
              })
        });

        // закрываем диалог
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }
    </script>
    <style type="text/css">
        /* Таблица */
        .tbl_style1 {
            font-family: Arial;
            font-size: 10pt;
            width: 100%;
        }

            .tbl_style1 th {
                text-align: center;
                font-weight: bold;
                background-color: grey;
                border: 1px solid grey;
                padding: 5px;
            }

            .tbl_style1 .caption {
                background-color: white;
                font-style: italic;
                font-weight: bold;
                text-align: left;
                border-left: 1px solid grey;
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                padding: 10px;
            }

            .tbl_style1 td {
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                padding: 3px;
            }

            .tbl_style1 tfoot td {
            }

            .tbl_style1 td.command_first {
                border-left: 1px solid grey;
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                text-align: center;
                width: 40px;
            }

            .tbl_style1 td.command {
                border-right: 1px solid grey;
                border-bottom: 1px solid grey;
                text-align: center;
                width: 40px;
            }

            .tbl_style1 tbody tr.edit {
                color: #039;
                border: 1px dashed #69c;
                background-image: url(/common/images/skin/pattern.png);
                background-repeat: repeat;
            }

            .tbl_style1 tbody tr.new {
                color: #039;
                border: 1px dashed #69c;
                background-image: url(/common/images/skin/pattern.png);
                background-repeat: repeat;
            }
    </style>

    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
        <table class="tbl_style1" border="0">
            <asp:ListView ID="lvDocs" runat="server">
                <LayoutTemplate>
                    <thead>
                        <tr>
                            <th class="caption" colspan="2">
                                <asp:Label ID="Caption" runat="server" Text="Документи в ЕА" />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </tbody>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr id="tr" runat="server">
                        <td class="command_first">
                            <asp:HyperLink ID="lnk" runat="server" ImageUrl="/Common/Images/default/16/save.png" ToolTip="Завантажити файл" NavigateUrl='<%# Eval("DocLink") %>' Target="_blank"></asp:HyperLink>
                        </td>
                        <td>
                            <asp:Label ID="lbDoc" runat="server" Text='<%# String.Format("{0} - {1}", Eval("Struct_Code"), Eval("Struct_Name")) %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <tr>
                <td>
                    <asp:Button ID="btDocViewed" runat="server" Text="Сканкопії перевірено" OnClientClick="CloseDialog(true); " />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
