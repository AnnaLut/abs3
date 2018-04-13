<%@ Page Language="C#" AutoEventWireup="true" CodeFile="joblist.aspx.cs" Inherits="ussr_joblist" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перегляд стану завдань</title>
    <link href="/common/css/barsgridview.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <Bars:BarsSqlDataSource 
                ID="dsJobs" ProviderName="barsroot.core" PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                runat="server" 
                SelectCommand="select * from v_ussr_collation_joblist order by what">
        </Bars:BarsSqlDataSource>    
        <table>
        <tr>
            <td style="padding-bottom:20px">
                <div id="divTitle" runat="server" style="border-bottom: 1px solid gray;font-size:12pt;">
                    Перегляд стану завдань
                </div>
            </td>
        </tr>
        <tr>
           <td>
                <Bars:BarsGridView ID="gv" runat="server" CssClass="barsGridView" 
                    DataSourceID="dsJobs" 
                    MergePagerCells="True" AutoGenerateColumns="False">
                    <FooterStyle CssClass="footerRow" />
                    <HeaderStyle CssClass="headerRow" />
                    <EditRowStyle CssClass="editRow" />
                    <PagerStyle CssClass="pagerRow" />
                    <AlternatingRowStyle CssClass="alternateRow" />                    
                    <Columns>
                        <asp:BoundField DataField="WHAT" HeaderText="Процедура, що виконується" />
                        <asp:BoundField DataField="BROKEN" HeaderText="Зупинено" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FAILURES" HeaderText="Кількість помилок" >
                            <itemstyle horizontalalign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CLIENT_INFO" HeaderText="Інформація" >
                            <itemstyle width="400px" />
                        </asp:BoundField>
                    </Columns>
                </Bars:BarsGridView>           
           </td>
        </tr>
        </table>

    </div>
    </form>
</body>
</html>
