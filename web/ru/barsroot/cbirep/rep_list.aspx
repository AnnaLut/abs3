<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rep_list.aspx.cs" Inherits="cbirep_rep_list"
    Theme="default" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>

<%@ Register Src="../credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb"
    TagPrefix="bec" %>
<%@ Register Src="../credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<%@ Register Src="../credit/usercontrols/loading.ascx" TagName="loading" TagPrefix="bec" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Друк звітів</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <script language="javascript" type="text/jscript" src="../credit/jscript/JScript.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <ajx:ToolkitScriptManager ID="sm" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </ajx:ToolkitScriptManager>
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Друк звітів"></asp:Label>
    </div>
    <div class="pageContainer">
        <asp:Panel ID="pnlRepResults" runat="server" GroupingText="Сформовані звіти">
            <asp:UpdatePanel ID="upRepResults" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Timer ID="tVCbirepRepresults" runat="server" Interval="20000" OnTick="tVCbirepRepresults_Tick">
                    </asp:Timer>
                    <asp:ObjectDataSource 
                        ID="odsVCbirepRepresults" 
                        runat="server" 
                        EnablePaging="True"
                        SortParameterName="SortExpression" 
                        SelectMethod="SelectCbirepRepresults" 
                        TypeName="Bars.ObjLayer.CbiRep.VCbirepRepresults">
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx 
                        ID="gvVCbirepRepresults" 
                        runat="server" 
                        AllowPaging="True" 
                        AllowSorting="True"
                        AutoGenerateColumns="False" 
                        CaptionText="" 
                        ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                        CssClass="barsGridView" 
                        DataSourceID="odsVCbirepRepresults" 
                        DateMask="dd.MM.yyyy"
                        ExcelImageUrl="/common/images/default/16/export_excel.png" 
                        FilterImageUrl="/common/images/default/16/filter.png"
                        MetaFilterImageUrl="/common/images/default/16/filter.png" 
                        MetaTableName="" 
                        RefreshImageUrl="/common/images/default/16/refresh.png"
                        OnRowCommand="gvVCbirepRepresults_RowCommand" 
                        DataKeyNames="QUERY_ID" 
                        PageSize="7"
                        ShowFooter="True" 
                        OnRowDataBound="gvVCbirepRepresults_RowDataBound" 
                        ShowExportExcelButton="false"><FooterStyle CssClass="footerRow">
                    </FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle><EditRowStyle CssClass="editRow"></EditRowStyle><PagerStyle CssClass="pagerRow"></PagerStyle><NewRowStyle CssClass=""></NewRowStyle><SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle><AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle><Columns><asp:TemplateField ShowHeader="False"><ItemTemplate><asp:ImageButton ID="ibPrint" runat="server" ToolTip="Друкувати звіт" CausesValidation="False"
                                        Visible='<%# ((String)Eval("STATUS_ID") == "DONE" || (String)Eval("STATUS_ID") == "PRINTED" || (String)Eval("STATUS_ID") == "CREATEDFILE") %>'
                                        CommandName="Print" ImageUrl="/Common/Images/default/16/print.png" CommandArgument='<%# Eval("QUERY_ID") %>' /></ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:TemplateField><asp:TemplateField ShowHeader="False"><ItemTemplate><asp:ImageButton ID="ibClear" runat="server" ToolTip="Видалити тимчасові дані" CausesValidation="False"
                                        CommandName="Clear" ImageUrl="/Common/Images/default/16/garbage.png" CommandArgument='<%# Eval("QUERY_ID") %>'
                                        OnClientClick="if (!confirm('Видалити дані?')) return false;" /></ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:TemplateField><asp:BoundField DataField="QUERY_ID" HeaderText="№" SortExpression="QUERY_ID" /><asp:TemplateField HeaderText="№ Звіту" SortExpression="REP_ID"><ItemTemplate><asp:Label ID="Label1" runat="server" Text='<%# Bind("REP_ID") %>' ToolTip='<%# Eval("REP_DESC") %>'></asp:Label></ItemTemplate></asp:TemplateField><asp:BoundField DataField="REP_DESC" HeaderText="Назва" SortExpression="REP_DESC" /><asp:BoundField DataField="CREATION_TIME" DataFormatString="{0:dd.MM.yy hh:mm}" HeaderText="Дата"
                                SortExpression="CREATION_TIME"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:BoundField DataField="PROC_TIME" HeaderText="Час формування (хв.)" SortExpression="PROC_TIME"><ItemStyle HorizontalAlign="Center" /></asp:BoundField><asp:TemplateField HeaderText="Статус" SortExpression="STATS_NAME"><ItemTemplate><asp:Label ID="Label2" runat="server" Text='<%# Bind("STATS_NAME") %>' ToolTip='<%# ((String)Eval("STATUS_ID") == "ERROR" ? "№ запису у журналі - " + Convert.ToString(Eval("STATS_COMM_ID")) + "\n" + (String)Eval("STATS_COMM") : "") %>'></asp:Label></ItemTemplate></asp:TemplateField><asp:TemplateField HeaderText="Параметри" SortExpression="XML_PARAMS"><ItemTemplate><asp:Label ID="lbParams" runat="server" Text='<%# Bind("XML_PARAMS") %>'></asp:Label></ItemTemplate></asp:TemplateField></Columns><RowStyle CssClass="normalRow"></RowStyle></Bars:BarsGridViewEx>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Panel ID="pnlRepQuery" runat="server" GroupingText="Заявка на формування звіту">
            <asp:UpdatePanel ID="upRepQuery" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div style="padding-bottom: 5px">
                        <table border="0" cellpadding="3" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lbSearchFolderID" runat="server" Text="Папка :" ToolTip="Папка звіту" />
                                </td>
                                <td>
                                    <asp:ObjectDataSource ID="odsVCbirepRepfolderslist" runat="server" SelectMethod="SelectCbirepRepfolderslist"
                                        TypeName="Bars.ObjLayer.CbiRep.VCbirepRepfolderslist">
                                        <SelectParameters>
                                            <asp:QueryStringParameter Name="CODEAPP" QueryStringField="codeapp" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:DropDownList ID="ddlSearchRepfolders" runat="server" DataSourceID="odsVCbirepRepfolderslist"
                                        DataTextField="FOLDER_NAME" DataValueField="FOLDER_ID" AppendDataBoundItems="True">
                                        <asp:ListItem Selected="True" Value="">Всі</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lbSearchRepID" runat="server" Text="№ звіту :" ToolTip="№ звіту" />
                                </td>
                                <td>
                                    <bec:TextBoxNumb ID="tbSearchRepID" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lbRepDesc" runat="server" Text="Найменування :" ToolTip="Найменування звіту" />
                                </td>
                                <td>
                                    <bec:TextBoxString ID="tbRepDesc" runat="server" Width="250" />
                                </td>
                                <td>
                                    <asp:Button ID="btApplySearch" runat="server" Text="Застосувати" ToolTip="Застосувати пошук"
                                        OnClick="btApplySearch_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:ObjectDataSource ID="odsVCbirepReplist" runat="server" EnablePaging="true" SortParameterName="SortExpression"
                        SelectMethod="SelectCbirepReplist" TypeName="Bars.ObjLayer.CbiRep.VCbirepReplist">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="CODEAPP" QueryStringField="codeapp" Type="String" />
                            <asp:ControlParameter ControlID="ddlSearchRepfolders" Name="FOLDER_ID" PropertyName="SelectedValue"
                                Type="String" />
                            <asp:ControlParameter ControlID="tbSearchRepID" Name="REP_ID" PropertyName="Value"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="tbRepDesc" Name="REP_DESC" PropertyName="Value"
                                Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gvVCbirepReplist" runat="server" AllowPaging="false" AllowSorting="True"
                        AutoGenerateColumns="False" CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png"
                        CssClass="barsGridView" DataSourceID="odsVCbirepReplist" DateMask="dd.MM.yyyy"
                        ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/filter.png"
                        MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                        OnRowCommand="gvVCbirepReplist_RowCommand" ShowPageSizeBox="false" PageSize="7"><FooterStyle CssClass="footerRow"></FooterStyle><HeaderStyle CssClass="headerRow"></HeaderStyle><EditRowStyle CssClass="editRow"></EditRowStyle><PagerStyle CssClass="pagerRow"></PagerStyle><NewRowStyle CssClass=""></NewRowStyle><SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle><AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle><Columns><asp:TemplateField ShowHeader="False"><ItemTemplate><asp:ImageButton ID="ibQuery" runat="server" ToolTip="Відправити заявку на формування"
                                        CausesValidation="False" CommandArgument='<%# Eval("REP_ID") %>' CommandName="Query"
                                        ImageUrl="/Common/Images/default/16/options.png" /></ItemTemplate><ItemStyle HorizontalAlign="Center" Width="25px" /></asp:TemplateField><asp:BoundField DataField="REP_ID" HeaderText="№" SortExpression="REP_ID" /><asp:BoundField DataField="REP_DESC" HeaderText="Назва" SortExpression="REP_DESC" /></Columns><RowStyle CssClass="normalRow"></RowStyle></Bars:BarsGridViewEx>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <div style="width: 99%; text-align: right; padding: 10px 10px 10px 0px">
            <a href='#top'>Нагору</a>
        </div>
    </div>
    <asp:UpdateProgress ID="uprgRepResults" runat="server" AssociatedUpdatePanelID="upRepResults">
        <ProgressTemplate>
            <bec:loading ID="ldngRepResults" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdateProgress ID="uprgRepQuery" runat="server" AssociatedUpdatePanelID="upRepQuery">
        <ProgressTemplate>
            <bec:loading ID="ldngRepQuery" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    </form>
</body>
</html>
