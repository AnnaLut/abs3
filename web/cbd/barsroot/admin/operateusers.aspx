<%@ Page Language="C#" AutoEventWireup="true" CodeFile="operateusers.aspx.cs" Inherits="admin_operateusers" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Администрирование пользователей</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>    
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="title" style="padding-bottom: 10px" runat="server" meta:resourcekey="tdTitle">Существующие пользователи</td>
                </tr>
                <tr>
                    <td>
                        <Bars:BarsSqlDataSource ProviderName="barsroot.core" ID="sdsUsers" runat="server" SelectCommand="select STAFF_ID, FIO, LOGNAME, TABN, to_char(DATE_ON,'dd.MM.yyyy') DATE_ON, TYPE_NAME as TYPE, DEP_NAME as DEP, FLAG_DEL from V_NS_STAFF s, V_NS_TYPE_STAFF t, V_NS_DEPS d where s.TYPE_ID = t.TYPE_ID and s.DEP_ID = d.DEP_ID"></Bars:BarsSqlDataSource>
                        <Bars:BarsGridView ID="gvUsers" runat="server" DataSourceID="sdsUsers" AutoGenerateColumns="False" AllowPaging="True" OnRowCommand="gvUsers_RowCommand">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="imgEditUser" CommandArgument='<%# Eval("STAFF_ID") %>' Width="16px" ToolTip="Изменить параметры пользователя" CommandName="EditUser" AlternateText="Изменить" ImageUrl="/Common/Images/default/16/open.png" meta:resourcekey="imgEditUserResource1" Visible='<%# (Convert.ToString(Eval("FLAG_DEL")) == "1")?(true):(false) %>'></asp:ImageButton>
                                    
</ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ID="imgDeleteUser" CommandArgument='<%# Eval("STAFF_ID") %>' Width="16px" ToolTip="Удалить пользователя" CommandName="DeleteUser" AlternateText="Удалить" ImageUrl="/Common/Images/default/16/cancel.png" meta:resourcekey="imgDeleteUserResource1" Visible='<%# (Convert.ToString(Eval("FLAG_DEL")) == "1")?(true):(false) %>'></asp:ImageButton>
                                    
</ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="FIO" HeaderText="ФИО" meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                <asp:BoundField DataField="LOGNAME" HeaderText="Логин" meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                                <asp:BoundField DataField="TABN" HeaderText="Табельный номер" meta:resourcekey="BoundFieldTabN">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DATE_ON" HeaderText="Дата заведения" meta:resourcekey="BoundFieldResource3">
                                    <itemstyle horizontalalign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYPE" HeaderText="Тип" meta:resourcekey="BoundFieldResource4"></asp:BoundField>
                                <asp:BoundField DataField="DEP" HeaderText="Подразделение" meta:resourcekey="BoundFieldResource5"></asp:BoundField>
                            </Columns>
                        </Bars:BarsGridView>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px"><asp:Button ID="btNew" runat="server" Text="Новый пользователь" OnClick="btNew_Click" meta:resourcekey="btNewResource1" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
