<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bind_client.aspx.cs" Inherits="sync_bind_client" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>

<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Прив'язка до існуючого клієнта</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" /> 
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="style.css" type="text/css" rel="stylesheet" />     
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="sync_update_panel"  UpdateMode="Conditional" runat="server">
            <ContentTemplate> 
                <table style="width:100%">
                    <tr>
                        <td>
                            <asp:Label ID="lbSelected" runat="server" Text="Вибраний клієнт"></asp:Label>
                        </td>
                    </tr>
                        <td>
                            <Bars:BarsGridViewEx ID="gvSelectedClient" runat="server" AllowPaging="False" 
                                AllowSorting="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="CUST_ID" DataSourceID="dsSelectedClient" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="False">
                            </Bars:BarsGridViewEx>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <Bars:BarsSqlDataSourceEx ID="dsSelectedClient" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>            
                    <tr>
                        <td style="width:100%">
                            <asp:Label ID="lbAvailableClients" runat="server" Text="Виберіть одного з доступних клієнтів для привязки"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <Bars:BarsGridViewEx ID="gridCustomers" runat="server" AllowPaging="True" 
                                AllowSorting="True" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="CUST_ID" DataSourceID="dsCustomers" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                PageSize="10" JavascriptSelectionType="SingleRow" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">                               
                            </Bars:BarsGridViewEx>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <Bars:BarsSqlDataSourceEx ID="dsCustomers" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>            
                    <tr>
                        <td>
                            <table style="width:100%">
                                <tr>
                                    <td style="width:200px">
                                        <asp:Button ID="btBack" runat="server" 
                                        Text="Назад" Width="150px" />
                                    </td>
                                    <td style="width:100%">
                                        <asp:Button ID="btBind" runat="server" OnClick="btBind_Click" 
                                        Text="Прив'язати"  Width="150px"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>        
                </table>         
                <asp:UpdateProgress ID="updateProgressBars" runat="server" 
                    AssociatedUpdatePanelID="sync_update_panel">
                        <ProgressTemplate>
                            <uc1:loading ID="sync_loading" runat="server" />
                            </ProgressTemplate>
                </asp:UpdateProgress>                              
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
