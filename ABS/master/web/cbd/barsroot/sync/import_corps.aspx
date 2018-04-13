<%@ Page Language="C#" AutoEventWireup="true" CodeFile="import_corps.aspx.cs" Inherits="admin_sync_import_corps" Title="Експорт клієнтів та рахунків (юридичних осіб)" %>

<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<%@ Register assembly="Bars.Web.Controls.2" namespace="UnityBars.WebControls" tagprefix="Bars" %>
<%@ Register src="../UserControls/DateEdit.ascx" tagname="DateEdit" tagprefix="uc2" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title="Експорт клієнтів та рахунків (юридичних осіб)" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" /> 
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="style.css" type="text/css" rel="stylesheet" /> 
    <link href="/barsroot/UserControls/style/jscal2.css" type="text/css" rel="stylesheet" /> 
</head>
<body>
    <form id="Form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server">
        </asp:ScriptManager>
                <table style="width:100%">
                    <tr>
                        <td style="width:100%"></td>
                    </tr>
                    </table>
        <asp:UpdatePanel ID="sync_update_panel"  UpdateMode="Conditional" runat="server">
            <ContentTemplate>  
                <table style="width:100%">
                    <tr>
                        <td style="width:100%"></td>
                    </tr>                
                    <tr>
                        <td style="width:100%">
                            <asp:Label ID="lbAccounts0" runat="server" Text="Клієнти"></asp:Label>
                        </td>
                    </tr>
                    <tr>         
                        <td style="width:100%">                                 
                            <Bars:BarsGridViewEx ID="gvCustomers" runat="server" 
                                DataSourceID = "dsCustomers" AllowPaging="True" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" 
                                AllowSorting="True" AutoGenerateColumns="False" 
                                onrowcommand="gvCustomers_RowCommand" PageSize="5" DataKeyNames="CUST_RNK" 
                                ShowFilter="True">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btImport" runat="server" CausesValidation="false"                                 
                                                CommandName="IMPORT_CLIENT" ToolTip="Створити нового клієнта інтернет банкінгу" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                Enabled = '<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' 
                                                Text="Експорт" Width="150px"/>
                                            <br />
											<asp:Button ID="btBind" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                CommandName="BIND_CLIENT" ToolTip="Прив'язати до існуючого клієнта інтернет банкінгу"
                                                Enabled='<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' 
                                                Text="Прив'язка" Width="150px"/>                                                
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btGetAccounts" runat="server" CausesValidation="false" 
                                                CommandName="GET_ACCOUNTS" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                Text="Рахунки"  Width="150px"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Експорто- ваний" SortExpression="IMPORTED">
                                        <itemtemplate>
                                            <asp:CheckBox ID="ckImp" runat="server" Enabled = "false"
                                                Checked='<%#Convert.ToBoolean(Eval("IMPORTED"))%>' />                    
                                        </itemtemplate>
                                        <itemstyle horizontalalign="Center" />
                                    </asp:TemplateField>                
                                    <asp:BoundField HeaderText="Код клієнта в АБС" DataField="CUST_RNK" SortExpression="CUST_RNK" />
                                    <asp:BoundField HeaderText="Код клієнта" DataField="CUST_ID" SortExpression="CUST_ID" />
                                    <asp:BoundField HeaderText="Найменування клієнта" DataField="NAME" SortExpression="NAME" />
                                    <asp:BoundField HeaderText="Ідентифікаційний код" DataField="CUST_CODE" SortExpression="CUST_CODE" />
                                    <asp:BoundField HeaderText="Адреса" DataField="ADDRESS" SortExpression="ADDRESS" />
                                    <asp:BoundField HeaderText="Дата заведення" DataField="DATE_ON" SortExpression="DATE_ON" />
                                    <asp:BoundField HeaderText="Повне найменування" DataField="LEGAL_NAME" SortExpression="LEGAL_NAME" />                    
                                    <asp:BoundField HeaderText="ПІБ директора" DataField="CHIEF_NAME" SortExpression="CHIEF_NAME" />
                                    <asp:BoundField HeaderText="Телефон директора" DataField="CHIEF_PHONE" SortExpression="CHIEF_PHONE" />
                                    <asp:BoundField HeaderText="ПІБ головного бухгалтера" DataField="BOOKKEEPER_NAME" SortExpression="BOOKKEEPER_NAME" />
                                    <asp:BoundField HeaderText="Телефон головного бухгалтера" DataField="BOOKKEEPER_PHONE" SortExpression="BOOKKEEPER_PHONE" />
                                    <asp:BoundField HeaderText="Код відділення" DataField="BRANCH_CODE" SortExpression="BRANCH_CODE" />
                                    <asp:BoundField HeaderText="Назва відділення" DataField="BRANCH_NAME" SortExpression="BRANCH_NAME" />
                                </Columns>
                                <RowStyle CssClass="normalRow" />
                           </Bars:BarsGridViewEx>
                            <Bars:BarsSqlDataSourceEx ID="dsCustomers" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>
                    <tr>
                        <td style="height:10px"></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbAccounts" runat="server" Text="Рахунки клієнта"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Всі рахунки вибраного клієнта"></asp:Label>
                            <asp:Button ID="btExportAll" runat="server" Enabled="False" 
                                onclick="btExportAll_Click" Text="Експортувати" Width="150px" />
                            <cc1:ConfirmButtonExtender ID="btExportAll_ConfirmButtonExtender" 
                                runat="server" 
                                ConfirmText="Ви дійсно бажаєте експортувати всі рахунки вибраного клієнта?" 
                                Enabled="True" TargetControlID="btExportAll">
                            </cc1:ConfirmButtonExtender>
                            <asp:UpdateProgress ID="updateProgressBars" runat="server" 
                                AssociatedUpdatePanelID="sync_update_panel">
                                    <ProgressTemplate>
                                        <uc1:loading ID="sync_loading" runat="server" />
                                        </ProgressTemplate>
                            </asp:UpdateProgress>
                        </td>                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Вибрані рахунки клієнта"></asp:Label>
                            <asp:Button ID="btExportSelected" runat="server" Enabled="False" 
                                onclick="btExportSelected_Click" Text="Експортувати" Width="150px" />
                            <cc1:ConfirmButtonExtender ID="btExportSelected_ConfirmButtonExtender" 
                                runat="server" 
                                ConfirmText="Ви дійсно бажаєте експортувати вибрані рахунки клієнта?" 
                                Enabled="True" TargetControlID="btExportSelected">
                            </cc1:ConfirmButtonExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbTitle" runat="server" 
                                Text="Дата початку синхронізації"></asp:Label>
                            <uc2:DateEdit ID="start_date" runat="server" Required="True" 
                                validationMessage="Необхідно заповнити" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbTitle0" runat="server" 
                                Text="Синхронізувати виписку по всіх рахунках:"></asp:Label>
                            <asp:Button ID="btSync" runat="server" CausesValidation="true" 
                                onclick="btSync_Click" Text="Синхронізувати" 
                                ToolTip="Синхронізувати виписку по всіх рахунках" Width="150px" />
                            <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
                                ConfirmText="Ви дійсно бажаєте синхронізувати виписку по всіх рахунках?" 
                                Enabled="True" TargetControlID="btSync">
                            </cc1:ConfirmButtonExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>                            
                            <Bars:BarsGridViewEx ID="gvAccounts" runat="server" DataSourceID = "dsAccounts" 
                                AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" PageSize="5" 
                                onrowcommand="gvAccounts_RowCommand" DataKeyNames="ACC" ShowFilter="True" 
                                JavascriptSelectionType="MultiSelect">
                                <FooterStyle CssClass="footerRow" />
                                <HeaderStyle CssClass="headerRow" />
                                <EditRowStyle CssClass="editRow" />
                                <PagerStyle CssClass="pagerRow" />
                                <NewRowStyle CssClass="" />
                                <NewRowStyle CssClass="" /><NewRowStyle CssClass="" /><NewRowStyle CssClass="" /><SelectedRowStyle CssClass="selectedRow" />
                                <AlternatingRowStyle CssClass="alternateRow" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btImport" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Eval("ACC")%>' CommandName="IMPORT_ACCOUNT" 
                                                Enabled='<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' Text="Експорт"
                                                Width="150px" ToolTip="Експортувати рахунок до інтернет банкінгу"/>
                                            <br />
                                            <asp:Button ID="btSync" runat="server" CausesValidation="true" 
                                                Enabled="false" 
                                                CommandArgument='<%#Eval("ACC")%>' CommandName="SYNC_ACCOUNT"                                                 
                                                Text="Синхронізувати" 
                                                ToolTip="Синхронізувати виписку по вибраному рахунку" Width="150px" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Експорто- ваний" SortExpression="IMPORTED">
                                        <itemtemplate>
                                            <asp:CheckBox ID="ckImp" runat="server" Enabled = "false"
                                                Checked='<%#Convert.ToBoolean(Eval("IMPORTED"))%>' />                    
                                        </itemtemplate>
                                        <itemstyle horizontalalign="Center" />
                                    </asp:TemplateField>                                
                                    <asp:BoundField HeaderText="Код клієнта" DataField="CUST_ID" SortExpression="CUST_ID" />
                                    <asp:BoundField HeaderText="Код рахунку в АБС" DataField="ACC" SortExpression="ACC" />
                                    <asp:BoundField HeaderText="Код рахунку" DataField="ACC_ID" SortExpression="ACC_ID" />            
                                    <asp:BoundField HeaderText="Номер рахунку" DataField="ACC_NUM" SortExpression="ACC_NUM" />
                                    <asp:BoundField HeaderText="Найменування рахунку" DataField="NAME" SortExpression="NAME" />
                                    <asp:BoundField HeaderText="Код валюти" DataField="CUR_CODE" SortExpression="CUR_CODE" />
                                    <asp:BoundField HeaderText="Дата відкриття" DataField="OPENED" SortExpression="OPENED" />
                                    <asp:BoundField HeaderText="Дата останнього руху" DataField="LAST_MOVEMENT" SortExpression="LAST_MOVEMENT" />
                                    <asp:BoundField HeaderText="Дата закриття" DataField="CLOSED" SortExpression="CLOSED" />
                                    <asp:BoundField HeaderText="Залишок" DataField="BALANCE" SortExpression="BALANCE" />
                                    <asp:BoundField HeaderText="Дебетові обороти" DataField="DEBIT_TURNS" SortExpression="DEBIT_TURNS" />
                                    <asp:BoundField HeaderText="Кредитові обороти" DataField="CREDIT_TURNS" SortExpression="CREDIT_TURNS" />
                                    <asp:BoundField HeaderText="ПІБ виконавця" DataField="EXEC_NAME" SortExpression="EXEC_NAME" />
                                    <asp:BoundField HeaderText="Код відділення" DataField="BRANCH_ID" SortExpression="BRANCH_ID" />
                                    <asp:BoundField HeaderText="Назва відділення" DataField="BRANCH_NAME" SortExpression="BRANCH_NAME" />
                                </Columns>
                                <RowStyle CssClass="normalRow" />
                            </Bars:BarsGridViewEx>
                            <Bars:BarsSqlDataSourceEx ID="dsAccounts" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>
                </table>                                                
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
