<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dbfimp.aspx.cs" Inherits="ussr_dbfimp" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title> Iмпорт DBF-Файлiв</title>
    <link href="/Common/CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
</head>
<body style="font-size:8pt;">
    <form id="DbfImpForm" runat="server">
    <table>
        <tr>
            <td style="padding-bottom:20px"><div style="border-bottom: 1px solid gray;font-size:12pt;">Перелiк завантажених файлiв</div></td>
        </tr>
        <tr>
            <td>
                <asp:ImageButton ID="ibRefresh" ImageUrl="/common/images/default/16/export_excel.png" ToolTip="Експорт до Excel" runat="server" OnClick="ibExportExcel_Click" Width="16px" />
                <asp:ImageButton ID="ibExportExcel" ImageUrl="/common/images/default/16/refresh.png" ToolTip="Перечитати" runat="server" OnClick="ibExportExcel_Click1" Width="16px"  />
                <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
                    PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                    SelectCommand="select id, title, file_name, fio, loaded, to_char(loaded, 'hh24:mi:ss') as loaded_time, total_rows, total_sum, branch, branch_name, done, err_count from v_ussr_dbf_files  order by loaded desc">
                </Bars:BarsSqlDataSource>                                
                <Bars:BarsGridView ID="gv" runat="server" 
                    DataSourceID="ds" 
                    AllowPaging="True"
                    AutoGenerateColumns="False" 
                    MergePagerCells="True" 
                    DataKeyNames="id,done" 
                    OnRowCommand="gv_RowCommand" 
                    ShowPageSizeBox="True" 
                    BackColor="White" 
                    AllowSorting="True" 
                    ShowFilter="True" OnPreRender="gv_PreRender">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <itemtemplate>
                                <asp:ImageButton ID="btShowGood" Visible='<%# ShowGoodButton(Eval("total_rows"), Eval("err_count")) %>' Width="16px" runat="server" ToolTip="Показати імпортовані дані" CommandName="ViewGood" CommandArgument='<% #Eval("id") %>' ImageUrl="/Common/Images/default/16/ok.png" CausesValidation="false"></asp:ImageButton>
                            </itemtemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <itemtemplate>
                                <asp:ImageButton ID="btShowBad" Visible='<%# ShowBadButton(Eval("total_rows"), Eval("err_count")) %>' Width="16px" runat="server" ToolTip="Показати помилкові дані" CommandName="ViewBad" CommandArgument='<% #Eval("id") %>' ImageUrl="/Common/Images/default/16/cancel.png" CausesValidation="false"></asp:ImageButton>
                            </itemtemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="file_name" HeaderText="Назва файлу" SortExpression="file_name">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fio" HeaderText="Користувач" SortExpression="fio">
                            <itemstyle horizontalalign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="loaded" HeaderText="Дата завантаження"  SortExpression="loaded">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="loaded_time" HeaderText="Час завантаження"  SortExpression="loaded_time">
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="total_rows" HeaderText="Кiлькiсть записiв" SortExpression="total_rows">
                            <itemstyle horizontalalign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="total_sum" HeaderText="Загальна сума" SortExpression="total_sum">
                            <itemstyle horizontalalign="Right" />
                        </asp:BoundField>
                        <asp:ButtonField ButtonType="Button" CommandName="Start" Text="Обробити" Visible="False" />
                        <asp:BoundField DataField="branch_name" HeaderText="Пiдроздiл" SortExpression="branch_name"/>
                        <asp:BoundField DataField="branch" HeaderText="Код пiдроздiлу" SortExpression="branch" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <HeaderStyle Font-Bold="False" Font-Size="9pt" Font-Underline="False" ForeColor="Black" />
                </Bars:BarsGridView> 
            </td>
        </tr>
        <tr>
            <td style="padding-bottom:20px;padding-top:20px;">
                <div style="border-bottom: 1px solid gray; font-size:12pt;">Завантаження нового файлу:</div>
            </td>
        </tr>
        <tr>
            <td>
                Файл: <asp:FileUpload ID="fileUpload" runat="server" Width="609px" />
            </td>
        </tr>
        <tr>
            <td align="left" style="height: 35px">
                <div style="padding-top:10px; padding-bottom:10px;">
                    <asp:Button ID="btnLoad" runat="server" Text="Завантажити" OnClick="btnLoad_Click" OnClientClick="tbMessage.value=''" />
                </div>
                <div align="left">Протокол:</div>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="width: 982px">
                <asp:TextBox ID="tbMessage" runat="server" ReadOnly="True" Rows="10" TextMode="MultiLine"
                    Width="99%"></asp:TextBox></td>
        </tr>
        <tr>
        <td>
            <asp:Button ID="btnGetLog" runat="server" Text="Зберегти лог" OnClick="btnGetLog_Click" />
        </td>
        </tr>
    </table>

    </form>
</body>
</html>
