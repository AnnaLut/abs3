<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" EnableEventValidation="false"
    CodeFile="createnotice.aspx.cs" Inherits="admin_CreateNotice" EnableViewState="true" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Створення оголошення</title>
    <style type="text/css">
        .grid td
        {
            padding: 3px 3px 3px 3px;
        }
        .grid th
        {
            padding: 3px 3px 3px 3px;
        }
    </style>
</head>
<body style="font-size: 8pt;">
    <form id="formNotice" runat="server">
    <div>
        <table style="width: 100%">
            <tr>
                <td style="padding-bottom: 20px; padding-top: 20px; width: 764px;">
                    <div style="border-bottom: 1px solid gray; font-size: 12pt;">
                        Нове оголошення:</div>
                </td>
            </tr>
            <tr>
                <td style="width: 764px">
                    <asp:Label ID="lblTitle" runat="server" Text="Заголовок"></asp:Label>
                    <br />
                    <asp:TextBox ID="tbTitle" runat="server" Rows="1" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblText" runat="server" Text="Текст"></asp:Label>
                    <br />
                    <asp:TextBox ID="tbText" runat="server" Rows="5" TextMode="MultiLine" Width="100%"></asp:TextBox>
                    <br />
                    <asp:Button ID="btnNew" runat="server" Text="Додати" OnClick="btnNew_Click" />
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 20px; padding-top: 20px; width: 764px;">
                    <div style="border-bottom: 1px solid gray; font-size: 12pt;">
                        Iснуючi оголошення:</div>
                </td>
            </tr>
            <tr>
                <td style="width: 764px">
                    <Bars:BarsSqlDataSource ID="sdsBoards" ProviderName="barsroot.core" SelectCommand="select id, to_char(msg_date,'dd.MM.yyyy HH24:MI:SS') msg_date, msg_title, msg_text from  bars_board order by id desc"
                        DeleteCommand="delete from bars_board where id=:id" InsertCommand="insert into bars_board set msg_title=:msg_title,msg_text=:msg_text"
                        UpdateCommand="update bars_board set msg_title=:msg_title, msg_text=:msg_text where id=:id"
                        runat="server">
                    </Bars:BarsSqlDataSource>
                    <Bars:BarsGridView ID="gvBoards" runat="server" CssClass="grid" AutoGenerateColumns="False"
                        DataKeyNames="id" DataSourceID="sdsBoards" Width="100%" OnRowCommand="gvBoards_RowCommand"
                        OnRowUpdating="gvBoards_RowUpdating" OnRowDeleting="gvBoards_RowDeleting" OnPreRender="gvBoards_PreRender">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:ImageButton ID="imgUpdate" runat="server" CommandName="Update" ToolTip="Зберегти зміни"
                                        AlternateText="Зберегти" ImageUrl="/Common/Images/default/16/save.png" 
                                        Width="16px" Height="16px">
                                    </asp:ImageButton>
                                    <asp:ImageButton ID="imgCancel" runat="server" CommandName="Cancel" ToolTip="Відмінити"
                                        AlternateText="Відмінити" ImageUrl="/Common/Images/default/16/cancel.png" 
                                        Width="16px" CausesValidation="False">
                                    </asp:ImageButton>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit" ToolTip="Змінити стрічку"
                                        AlternateText="Змінити" ImageUrl="/Common/Images/default/16/open.png" Width="16px">
                                    </asp:ImageButton>
                                    <asp:ImageButton ID="imgDelete" runat="server" CommandName="Delete" ToolTip="Видалити стрічку"
                                        AlternateText="Видалити" ImageUrl="/Common/Images/default/16/cancel.png" Width="16px">
                                    </asp:ImageButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="ID" HeaderText="Код" ReadOnly="True">
                                <ItemStyle Width="10px"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="MSG_DATE" HeaderText="Дата" ReadOnly="True">
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Заголовок">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbMSG_TITLE" runat="server" Width="100%" Text='<%# Bind("MSG_TITLE") %>'
                                        TextMode="MultiLine" Rows="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMSG_TITLE" runat="server" 
                                        ControlToValidate="tbMSG_TITLE" ErrorMessage="Заповніть поле">Заповніть поле</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMSG_TITLE" runat="server" Text='<%# Bind("MSG_TITLE") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Текст оголошення">
                                <EditItemTemplate>
                                    <asp:TextBox ID="tbMSG_TEXT" runat="server" Width="100%" Text='<%# Bind("MSG_TEXT") %>'
                                        TextMode="MultiLine" Rows="5"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvMSG_TEXT" runat="server" 
                                        ControlToValidate="tbMSG_TEXT" ErrorMessage="Заповніть поле">Заповніть поле</asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbMSG_TEXT" runat="server" Text='<%# Bind("MSG_TEXT") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="60%"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                    </Bars:BarsGridView>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
