﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="import_clients.aspx.cs" Inherits="admin_sync_import_clients" EnableEventValidation="false" %>

<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<%@ Register assembly="Bars.Web.Controls.2" namespace="UnityBars.WebControls" tagprefix="Bars" %>
<%@ Register src="../UserControls/DateEdit.ascx" tagname="DateEdit" tagprefix="uc2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title="Експорт клієнтів та рахунків (фізичних осіб)" />
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" /> 
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="style.css" type="text/css" rel="stylesheet" /> 
    <link href="/barsroot/UserControls/style/jscal2.css" type="text/css" rel="stylesheet" /> 
    <style type="text/css">
        .style1
        {
            height: 10px;
        }
    </style>
</head>
<body>
    <form id="Form1" method="post" runat="server"> 
        <asp:ScriptManager ID="ScriptManager1" EnablePartialRendering="true" runat="server"
            EnablePageMethods="true">
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
                            <Bars:BarsGridViewEx ID="gvCustomers" runat="server" AllowPaging="True" 
                                AllowSorting="True" AutoGenerateColumns="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="CUST_RNK" DataSourceID="dsCustomers" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                onrowcommand="gvCustomers_RowCommand" PageSize="5" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btImport" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                CommandName="IMPORT_CLIENT" ToolTip="Створити нового клієнта інтернет банкінгу" 
                                                Enabled='<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' 
                                                Text="Експорт" Width="150px"/><br /><asp:Button ID="btBind" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                CommandName="BIND_CLIENT" ToolTip="Прив'язати до існуючого клієнта інтернет банкінгу"
                                                Enabled='<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' 
                                                Text="Прив'язка" Width="150px"/>                                                
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btGetAccounts" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CUST_RNK"))+":"+Convert.ToString(Eval("KF"))%>'
                                                CommandName="GET_ACCOUNTS"  Width="150px"
                                                Text="Рахунки"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Експорто- ваний" SortExpression="IMPORTED">
                                        <itemtemplate>
                                            <asp:CheckBox ID="ckImp" runat="server" 
                                                Checked='<%#Convert.ToBoolean(Eval("IMPORTED"))%>' Enabled="false" />
                                        </itemtemplate>
                                        <itemstyle horizontalalign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Код філії" DataField="KF" SortExpression="KF" />
                                    <asp:BoundField HeaderText="Код клієнта в АБС" DataField="CUST_RNK" SortExpression="CUST_RNK" />
                                    <asp:BoundField HeaderText="Код клієнта" DataField="CUST_ID" SortExpression="CUST_ID" />
                                    <asp:BoundField HeaderText="ПІБ клієнта" DataField="NAME" SortExpression="NAME" />
                                    <asp:BoundField HeaderText="Ідентифікаційний код" DataField="CUST_CODE" SortExpression="CUST_CODE" />
                                    <asp:BoundField HeaderText="Адреса" DataField="ADDRESS" SortExpression="ADDRESS" />
                                    <asp:BoundField HeaderText="Дата заведення" DataField="DATE_ON" SortExpression="DATE_ON" />
                                    <asp:BoundField HeaderText="Вид документа" DataField="PASP_TYPE" SortExpression="PASP_TYPE" />
                                    <asp:BoundField HeaderText="Серія документа" DataField="PASP_SERIAL" SortExpression="PASP_SERIAL" />
                                    <asp:BoundField HeaderText="Номер документа" DataField="PASP_NUMBER" SortExpression="PASP_NUMBER" />
                                    <asp:BoundField HeaderText="Дата документа" DataField="PASP_DATE" SortExpression="PASP_DATE" />
                                    <asp:BoundField HeaderText="Виданий" DataField="PASP_ISSUED" SortExpression="PASP_ISSUED" />
                                    <asp:BoundField HeaderText="Дата народження" DataField="BIRTH_DATE" SortExpression="BIRTH_DATE" />
                                    <asp:BoundField HeaderText="Місце народження" DataField="BIRTH_PLACE" SortExpression="BIRTH_PLACE" />
                                    <asp:BoundField HeaderText="Код відділення" DataField="BRANCH_CODE" SortExpression="BRANCH_CODE" />
                                    <asp:BoundField HeaderText="Назва відділення" DataField="BRANCH_NAME" SortExpression="BRANCH_NAME" />
                                </Columns>
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
                        <td class="style1">
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
                                Text="Експортувати" Width="150px" onclick="btExportSelected_Click" />
                            <cc1:ConfirmButtonExtender ID="btExportAll0_ConfirmButtonExtender" 
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
                            <asp:Label ID="lbTitle3" runat="server" 
                                Text="Дата початку синхронізації по обраному рахунку"></asp:Label>
                            <uc2:DateEdit ID="start_date2" runat="server" Required="false" 
                                validationMessage="Необхідно заповнити" />
                        </td>
                    </tr>  
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbTitle0" runat="server" 
                                Text="Синхронізувати виписку по всіх рахунках:"></asp:Label>
                            <asp:Button ID="btSync" runat="server" CausesValidation="true" 
                                onclick="btSync_Click" Text="Синхронізувати всi"
                                OnClientClick="ControlDateEditValidById(false, 'start_date2_dateValidator', true, 'start_date_dateValidator')"
                                ToolTip="Синхронізувати виписку по всiм рахунках" Width="150px" />
                            <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" 
                                ConfirmText="Ви дійсно бажаєте синхронізувати виписку по всім рахунках?" 
                                Enabled="True" TargetControlID="btSync">
                            </cc1:ConfirmButtonExtender>
                        </td>
                    </tr> 
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <tr>
                            <td>
                                <bars:BarsGridViewEx ID="gvAccounts" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png" CssClass="barsGridView" DataKeyNames="ACC" DataSourceID="dsAccounts" DateMask="dd.MM.yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/find.png" JavascriptSelectionType="MultiSelect" MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" onrowcommand="gvAccounts_RowCommand" PageSize="5" RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">
                                    <AlternatingRowStyle CssClass="alternateRow" />
                                    <Columns>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:Button ID="btImportInGv" runat="server" CausesValidation="false" CommandArgument='<%#Eval("ACC")%>' CommandName="IMPORT_ACCOUNT" Enabled='<%#!Convert.ToBoolean(Eval("IMPORTED"))%>' Text="Експорт" ToolTip="Експортувати рахунок до інтернет банкінгу" Width="150px" />
                                                <asp:Button ID="btSyncInGv" runat="server" CausesValidation="true" 
                                                    OnClientClick="return ControlDateEditValid(true)" 
                                                    CommandArgument='<%#Eval("ACC")%>' CommandName="SYNC_ACCOUNT" Enabled="true" Text="Синхронізувати" ToolTip="Синхронізувати виписку по вибраному рахунку" Width="150px" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Експорто-ваний" SortExpression="IMPORTED">
                                            <itemtemplate>
                                                <asp:CheckBox ID="ckImp" runat="server" Checked='<%#Convert.ToBoolean(Eval("IMPORTED"))%>' Enabled="false" />
                                            </itemtemplate>
                                            <itemstyle horizontalalign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CUST_ID" HeaderText="Код клієнта" SortExpression="CUST_ID" />
                                        <asp:BoundField DataField="ACC" HeaderText="Код рахунку в АБС" SortExpression="ACC" />
                                        <asp:BoundField DataField="ACC_ID" HeaderText="Код рахунку" SortExpression="ACC_ID" />
                                        <asp:BoundField DataField="ACC_NUM" HeaderText="Номер рахунку" SortExpression="ACC_NUM" />
                                        <asp:BoundField DataField="NAME" HeaderText="Найменування рахунку" SortExpression="NAME" />
                                        <asp:BoundField DataField="CUR_CODE" HeaderText="Код валюти" SortExpression="CUR_CODE" />
                                        <asp:BoundField DataField="OPENED" HeaderText="Дата відкриття" SortExpression="OPENED" />
                                        <asp:BoundField DataField="LAST_MOVEMENT" HeaderText="Дата останнього руху" SortExpression="LAST_MOVEMENT" />
                                        <asp:BoundField DataField="CLOSED" HeaderText="Дата закриття" SortExpression="CLOSED" />
                                        <asp:BoundField DataField="BALANCE" HeaderText="Залишок" SortExpression="BALANCE" />
                                        <asp:BoundField DataField="DEBIT_TURNS" HeaderText="Дебетові обороти" SortExpression="DEBIT_TURNS" />
                                        <asp:BoundField DataField="CREDIT_TURNS" HeaderText="Кредитові обороти" SortExpression="CREDIT_TURNS" />
                                        <asp:BoundField DataField="EXEC_NAME" HeaderText="ПІБ виконавця" SortExpression="EXEC_NAME" />
                                        <asp:BoundField DataField="BRANCH_ID" HeaderText="Код відділення" SortExpression="BRANCH_ID" />
                                        <asp:BoundField DataField="BRANCH_NAME" HeaderText="Назва відділення" SortExpression="BRANCH_NAME" />
                                    </Columns>
                                    <EditRowStyle CssClass="editRow" />
                                    <FooterStyle CssClass="footerRow" />
                                    <HeaderStyle CssClass="headerRow" />
                                    <PagerStyle CssClass="pagerRow" />
                                    <RowStyle CssClass="normalRow" />
                                    <SelectedRowStyle CssClass="selectedRow" />
                                </bars:BarsGridViewEx>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <bars:BarsSqlDataSourceEx ID="dsAccounts" runat="server" ProviderName="barsroot.core">
                                </bars:BarsSqlDataSourceEx>
                            </td>
                        </tr>
                    </tr>
                </table>                    
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
