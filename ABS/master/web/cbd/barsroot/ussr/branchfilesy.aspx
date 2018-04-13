<%@ Page Language="C#" AutoEventWireup="true" CodeFile="branchfilesy.aspx.cs" Inherits="ussr_branchfilesy" %>
<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Перегляд статистики файлів по відділенням</title>
    <link href="/common/css/barsgridview.css" rel="stylesheet" type="text/css" />
</head>
<body>
    
    <form id="frmBranchFilesY" runat="server">
    <div>
        <div class="tableTitle" runat="server" id="lblTitle">Відділення, по яким немає файлів для обробки</div>
        <Bars:BarsSqlDataSource 
                ID="ds" ProviderName="barsroot.core" PreliminaryStatement="begin bars_role_auth.set_role('WR_USSR_TECH'); end;"
                runat="server" 
                SelectCommand="select * from branch">
        </Bars:BarsSqlDataSource>        
        <Bars:BarsGridView ID="gv" runat="server" CssClass="barsGridView" AllowPaging="true" 
            ShowPageSizeBox="true" 
            DataSourceID="ds" 
            ShowFilter="true" 
            MergePagerCells="true"
            AutoGenerateColumns="false" 
            OnRowDataBound="gv_RowDataBound">
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <AlternatingRowStyle CssClass="alternateRow" />            
            <Columns>
                <asp:BoundField DataField="BRANCH" SortExpression="BRANCH"  HeaderText="Код підр." />
                <asp:BoundField DataField="BRANCH_NAME_SHORT" SortExpression="BRANCH_NAME" HeaderText="Назва" />            
            </Columns>
        </Bars:BarsGridView>
    </div>
    </form>
</body>
</html>
