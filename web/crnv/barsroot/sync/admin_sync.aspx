﻿<%@ Page Language="C#" AutoEventWireup="true" UICulture="uk" Culture="uk-UA" CodeFile="admin_sync.aspx.cs" Inherits="admin_sync" %>

<%@ Register assembly="Bars.DataComponentsEx" namespace="Bars.DataComponents" tagprefix="Bars" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
<%@ Register src="../UserControls/loading.ascx" tagname="loading" tagprefix="uc1" %>
<%@ Register src="../UserControls/DateEdit.ascx" tagname="DateEdit" tagprefix="uc2" %>

<%@ Register assembly="Bars.Web.Controls.2" namespace="UnityBars.WebControls" tagprefix="Bars" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Синхронізація таблиць</title>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" /> 
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <link href="style.css" type="text/css" rel="stylesheet" /> 
    <link href="/barsroot/UserControls/style/jscal2.css" type="text/css" rel="stylesheet" /> 
</head>
<body>
    <form id="Form1" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager1" EnableScriptGlobalization="true" EnableScriptLocalization="true" 
                EnablePartialRendering="false" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="sync_update_panel"  UpdateMode="Conditional" runat="server">
            <ContentTemplate>                        
                <asp:UpdateProgress ID="updateProgressBars" runat="server" AssociatedUpdatePanelID="sync_update_panel">
                    <ProgressTemplate>
                        <uc1:loading ID="sync_loading" runat="server" />
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <table>
                    <tr>
                        <td style="width:100%">
                            <asp:Label ID="lbTitle" runat="server" 
                                Text="CAPTURE процеси"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%"></td>
                    </tr>
                    <tr>
                        <td style="width:100%">
                            <Bars:BarsGridViewEx ID="gvCapture" runat="server" AllowPaging="True" 
                                AllowSorting="False" AutoGenerateColumns="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="CAPTURE_NAME" DataSourceID="dsCapture" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                onrowcommand="gvCapture_RowCommand" PageSize="5" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="5%" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btStartCapture" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CAPTURE_NAME"))%>'
                                                CommandName="START_CAPTURE" ToolTip="Стартувати CAPTURE процес" 
                                                Enabled='<%#Convert.ToBoolean(Convert.ToString(Eval("STATUS"))!="ENABLED")%>' 
                                                Text="Стартувати"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="5%" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btStopCapture" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("CAPTURE_NAME"))%>'
                                                CommandName="STOP_CAPTURE" ToolTip="Зупинити CAPTURE процес"
                                                Enabled='<%#Convert.ToBoolean(Convert.ToString(Eval("STATUS"))=="ENABLED")%>' 
                                                Text="Зупинити"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField ItemStyle-Width="10%" HeaderText="Назва" DataField="CAPTURE_NAME">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField ItemStyle-Width="10%" HeaderText="Статус" DataField="STATUS" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField ItemStyle-Width="20%" HeaderText="Стан" DataField="STATE" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>                                    
                                    <asp:BoundField ItemStyle-Width="10%" HeaderText="Стартований" DataField="STARTUP_TIME" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>                                    
                                    <asp:BoundField ItemStyle-Width="10%" HeaderText="Зміна стану" DataField="STATE_CHANGED_TIME" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>                                    
                                    <asp:BoundField ItemStyle-Width="10%" HeaderText="Зміна статусу" DataField="STATUS_CHANGE_TIME" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>                                                                        
                                    <asp:BoundField ItemStyle-Width="20%" HeaderText="Помилка" DataField="ERROR_MESSAGE" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>                                    
                                </Columns>
                            </Bars:BarsGridViewEx>
                            <Bars:BarsSqlDataSourceEx ID="dsCapture" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>
                    <tr>
                        <td style="height:10px"></td>
                    </tr>
                    <tr>
                        <td style="width:100%">
                            <asp:Label ID="Label1" runat="server" 
                                Text="APPLY процеси"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%"></td>
                    </tr>
                    <tr>
                        <td style="width:100%">
                            <Bars:BarsGridViewEx ID="gvApply" runat="server" AllowPaging="True" 
                                AllowSorting="False" AutoGenerateColumns="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="APPLY_NAME" DataSourceID="dsApply" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                onrowcommand="gvApply_RowCommand" PageSize="5" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="5%" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btStartCapture" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("APPLY_NAME"))%>'
                                                CommandName="START_APPLY" ToolTip="Стартувати APPLY процес" 
                                                Enabled='<%#Convert.ToBoolean(Convert.ToString(Eval("STATUS"))!="ENABLED")%>' 
                                                Text="Стартувати"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="5%" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btStopCapture" runat="server" CausesValidation="false" 
                                                CommandArgument='<%#Convert.ToString(Eval("APPLY_NAME"))%>'
                                                CommandName="STOP_APPLY" ToolTip="Зупинити APPLY процес"
                                                Enabled='<%#Convert.ToBoolean(Convert.ToString(Eval("STATUS"))=="ENABLED")%>' 
                                                Text="Зупинити"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderText="Назва"  DataField="APPLY_NAME" />
                                    <asp:BoundField ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderText="Статус"  DataField="STATUS" />
                                    <asp:BoundField ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderText="Внесення змін"  DataField="APPLY_TIME" />
                                    <asp:BoundField ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" HeaderText="Зміна статусу"  DataField="STATUS_CHANGE_TIME" />                                    
                                    <asp:BoundField ItemStyle-Width="50%" ItemStyle-HorizontalAlign="Left" HeaderText="Помилка"  DataField="ERROR_MESSAGE" />
                                </Columns>
                            </Bars:BarsGridViewEx>
                            <Bars:BarsSqlDataSourceEx ID="dsApply" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%"></td>
                    </tr>
                    <tr>
                        <td style="width:100%">
                            <asp:Label ID="Label2" runat="server" 
                                Text="Стан синхронізації таблиць"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%">
                            <Bars:BarsGridViewEx ID="gvSync" EnableViewState="true" runat="server" AllowPaging="True" 
                                AllowSorting="False" AutoGenerateColumns="False" CaptionText="" 
                                ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                                CssClass="barsGridView" DataKeyNames="TABLE_NAME" DataSourceID="dsSync" 
                                DateMask="dd.MM.yyyy" 
                                ExcelImageUrl="/common/images/default/16/export_excel.png" 
                                FilterImageUrl="/common/images/default/16/find.png" 
                                MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" 
                                onrowcommand="gvSync_RowCommand" PageSize="20" 
                                RefreshImageUrl="/common/images/default/16/refresh.png" ShowFilter="True">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btSyncTable" runat="server" CausesValidation="true" 
                                                    CommandArgument='<%#Convert.ToString(Eval("SYNC_SQL"))+"-"+Convert.ToString(Eval("PARAMETER_NAME"))+"-"+Convert.ToString(((GridViewRow) Container).RowIndex)+"-"+Eval("TABLE_NAME")%>'
                                                    CommandName="SYNC" ToolTip="Синхронізувати дані в таблиці" 
                                                    ValidationGroup='<%#Convert.ToString(Eval("TABLE_NAME"))%>'
                                                    Text="Синхронізувати" Width="150px"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Початок синхронізації">
                                        <ItemTemplate>
                                            <uc2:DateEdit ID="start_date" runat="server" Required="True" 
                                                validationMessage="Необхідно заповнити" 
                                                validationGroup='<%#Convert.ToString(Eval("TABLE_NAME"))%>'
                                                Visible='<%#!Convert.ToBoolean(String.IsNullOrEmpty(Convert.ToString(Eval("PARAMETER_NAME"))))%>'
                                                SelectedDate='<%#Eval("SYNC_DATE")%>'/>
                                         </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Назва таблиці" DataField="TABLE_NAME" >
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Статус"  DataField="STATUS" >                                    
                                        <ItemStyle HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Коментар" DataField="STATUS_COMMENT">
                                        <ItemStyle HorizontalAlign="Left"/>
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Час початку" DataField="START_TIME">                                    
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Час завершення" DataField="FINISH_TIME" >                                    
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Помилка" DataField="ERROR_MESSAGE" >                                    
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Код завдання" DataField="JOB_ID" >                                    
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                            </Bars:BarsGridViewEx>
                            <Bars:BarsSqlDataSourceEx ID="dsSync" ProviderName="barsroot.core" runat="server">
                            </Bars:BarsSqlDataSourceEx>
                        </td>
                    </tr>
                </table>                    
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>