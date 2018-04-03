<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dbfdataview.aspx.cs" Inherits="ussr_dbfdataview" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>Перегляд даних завантаженого файлу</title>
</head>
<body style="font-size:8pt;">
    <form id="formDbfDataView" runat="server">
    <div hidefocus="hideFocus">
    <table>
        <tr>
            <td style="padding-bottom:20px"><div id="divTitle" runat="server" style="border-bottom: 1px solid gray;font-size:12pt;">Перегляд даних завантаженого файлу</div></td>
        </tr>
        <tr>
        <td align="left"><asp:LinkButton ID="LinkButton1" runat="server" Text="Назад" OnClientClick="history.go(-1); return false;" TabIndex="-1" Font-Size="10pt"/></td>
        </tr>        
        <tr>
            <td>
                <div style="margin-bottom: 3px;">
                    <asp:ImageButton ID="hypExcel" runat="server"  style="padding-right: 10px"
                        ImageUrl="/common/images/default/16/export_excel.png" 
                        AlternateText="Експорт до Excel" CommandName="ExportExcel" OnCommand="hypExcel_Command" >
                    </asp:ImageButton>
                </div>
                <Bars:BarsGridView ID="gv" runat="server" 
                    DataSourceID="ds" 
                    AllowPaging="True"
                    ShowFilter="true"
                    AutoGenerateColumns="true" 
                    MergePagerCells="True" 
                    DataKeyNames="id" 
                    ShowPageSizeBox="True" 
                    PageSize="10"
                    BackColor="White" AllowSorting="True">
                </Bars:BarsGridView>     
             </td>
        </tr>
    </table>   
    </div>
    <!-- 
        Источники данных
    -->
    <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
        SelectCommand="select * from DATA_TABLE where file_id=:file_id order by id">
    </Bars:BarsSqlDataSource>        
    </form>
</body>
</html>
