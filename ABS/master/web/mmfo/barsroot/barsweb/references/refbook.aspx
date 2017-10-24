<%@ Page language="c#" Inherits="barsweb.References.RefForm"  CodeFile="RefBook.aspx.cs" EnableViewState="true" ValidateRequest="false" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Справочник</title>
		<link href="References.css" type="text/css" rel="Stylesheet"/>
		<link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
	</head>
	<body>
    <form id="form1" runat="server">
    <div>
        <div class="title"><asp:Label ID="Label1" runat="server" Text="Название справочника" meta:resourcekey="Label1Resource1" ></asp:Label></div>
        <div runat="server" id="divMsg" style="padding-left:10px;color:red"></div>
        <Bars:BarsSqlDataSourceEx 
            ID="ds" runat="server" 
            ConflictDetection="CompareAllValues" 
            OldValuesParameterFormatString="old_{0}" 
            AllowPaging="False" 
            FilterStatement="" 
            PageButtonCount="10" 
            PagerMode="NextPrevious" 
            PageSize="10" 
            ProviderName="barsroot.core" 
            SortExpression="" 
            SystemChangeNumber="" 
            WhereStatement="">
        </Bars:BarsSqlDataSourceEx>
        <div style="margin-top:7px; width:100%;">
        <Bars:BarsGridViewEx ID="gv" runat="server" 
            DataSourceID="ds" AllowPaging="True" AllowSorting="True" ShowPageSizeBox="true"
            AutoGenerateColumns="False" DateMask="dd/MM/yyyy" 
            CaptionText="" CssClass="barsGridView" 
            ExcelImageUrl="/common/images/default/16/export_excel.png" 
            FilterImageUrl="/common/images/default/16/filter.png" 
            CaptionType="Cool" 
            RefreshImageUrl="/common/images/default/16/refresh.png" 
                onrowupdating="gv_RowUpdating" onrowcommand="gv_RowCommand" 
                onrowupdated="gv_RowUpdated">
            <footerstyle cssclass="footerRow" />
            <headerstyle cssclass="headerRow" />
            <editrowstyle cssclass="editRow"/>
            <pagerstyle cssclass="pagerRow" />
            <selectedrowstyle cssclass="selectedRow" />
            <alternatingrowstyle cssclass="alternateRow" />
            <pagersettings mode="Numeric"></pagersettings>
            <rowstyle cssclass="normalRow" />
            <NewRowStyle CssClass="" />
        </Bars:BarsGridViewEx>   
        <div runat="server" id="divVer" style="padding-top:10px;font-size:7pt;text-align:right;"></div> 
        </div>
    </div>
    </form>
	</body>
</html>
