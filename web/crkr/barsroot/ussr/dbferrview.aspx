<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dbferrview.aspx.cs" Inherits="ussr_dbferrview" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перелiк помилок в файлi</title>
</head>
<body style="font-size:8pt;">
    <form id="formDbfErrView" runat="server">
    <div>
    <table>
        <tr>
            <td style="padding-bottom:20px"><div style="border-bottom: 1px solid gray;font-size:12pt;">Перелiк помилок в файлi</div></td>
        </tr>
        <tr>
        <td align="left"><asp:LinkButton ID="LinkButton1" runat="server" Text="Назад" OnClick="bntBack_Click1" TabIndex="-1" Font-Size="10pt"/></td>
        </tr>        
        <tr>
            <td>    
                <Bars:BarsSqlDataSource ID="ds" runat="server" ProviderName="barsroot.core"
                    PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                    SelectCommand="select rec_num, region, otdel, filial, nsc, dbcode, rec_msg, rec_msg_ora from v_ussr_dbf_implog where file_id=:file_id order by rec_num">
                </Bars:BarsSqlDataSource>        
                <Bars:BarsGridView ID="gv" runat="server" 
                    DataSourceID="ds" AllowPaging="True" ShowFilter="True"
                    AutoGenerateColumns="False" MergePagerCells="True" ShowPageSizeBox="True" BackColor="White" AllowSorting="True">
                    <Columns>
                        <asp:BoundField DataField="rec_num" HeaderText="Рядок" SortExpression="rec_num" />
                        <asp:BoundField DataField="Region" HeaderText="Region" SortExpression="Region"/>
                        <asp:BoundField DataField="Otdel" HeaderText="Otdel" SortExpression="Otdel"/>
                        <asp:BoundField DataField="Filial" HeaderText="Filial" SortExpression="Filial"/>
                        <asp:BoundField DataField="NSC" HeaderText="NSC" SortExpression="NSC"/>
                        <asp:BoundField DataField="dbcode" HeaderText="Код клieнта" SortExpression="dbcode"/>
                        <asp:BoundField DataField="rec_msg" HeaderText="Помилка (користувач)" SortExpression="rec_numrec_msg" />
                        <asp:BoundField DataField="rec_msg_ora" HeaderText="Помилка (сервер)" SortExpression="rec_msg_ora"/>
                    </Columns>
                </Bars:BarsGridView> 
             </td>
        </tr>
    </table>           
    </div>
    </form>
</body>
</html>
