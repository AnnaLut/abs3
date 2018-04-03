<%@ Page language="c#" CodeFile="DepositFileShow.aspx.cs" AutoEventWireup="true" Inherits="DepositFileShow" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Перегляд файлів зарахування</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js">function Button1_onclick() {

}

</script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle8" runat="server" CssClass="InfoHeader">Принятые файлы зачислений</asp:label></td>
				</tr>
				<tr>
					<td>
                        <Bars:BarsGridViewEx id="gridFiles" runat="server" CssClass="BaseGrid" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="dsFiles" DateMask="dd/MM/yyyy" OnRowDataBound="gridFiles_RowDataBound" CaptionText="" ClearFilterImageUrl="/common/images/default/16/filter_delete.png" ExcelImageUrl="/common/images/default/16/export_excel.png" FilterImageUrl="/common/images/default/16/find.png" MetaFilterImageUrl="/common/images/default/16/filter.png" MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png" ShowFooter="True">
                            <pagersettings pagebuttoncount="5"></pagersettings>
                            <columns>
                                <asp:TemplateField HeaderText="*">
                                    <itemtemplate>
                                        <asp:ImageButton id="imgOpen" runat="server" ImageUrl="\Common\Images\default\16\open.png"
                                            onclientclick=<%# "GetFile('" + Eval("FILENAME") + "','" + Eval("FDAT") + "','" + Eval("HEADER_ID") + "');return false;"%> ></asp:ImageButton> 
                                    </itemtemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="HEADER_ID" SortExpression="HEADER_ID" HeaderText="Id файлу"></asp:BoundField>
                                <asp:BoundField DataField="FILENAME" SortExpression="FILENAME" HeaderText="Ім'я файлу"></asp:BoundField>
                                <asp:BoundField DataField="DAT" SortExpression="DAT" HeaderText="Дата"></asp:BoundField>
                                <asp:BoundField DataField="INFO_LENGTH" SortExpression="INFO_LENGTH" HeaderText="К-сть платежів"></asp:BoundField>
                                <asp:BoundField DataField="SUM" SortExpression="SUM" HeaderText="Сума"></asp:BoundField>
                                <asp:BoundField DataField="NAZN" SortExpression="NAZN" HeaderText="Призначення"></asp:BoundField>
                                <asp:BoundField DataField="BRANCH" SortExpression="BRANCH" HeaderText="Відділення"></asp:BoundField>
                            </columns>
                            <FooterStyle CssClass="footerRow" />
                            <HeaderStyle CssClass="headerRow" />
                            <EditRowStyle CssClass="editRow" />
                            <PagerStyle CssClass="pagerRow" />
                            <NewRowStyle CssClass="" />
                            <SelectedRowStyle CssClass="selectedRow" />
                            <AlternatingRowStyle CssClass="alternateRow" />
                            <RowStyle CssClass="normalRow" />
                        </Bars:BarsGridViewEx>
                        <Bars:BarsSqlDataSourceEx ProviderName="barsroot.core" id="dsFiles" runat="server" 
                            SelectCommand="SELECT FILENAME,DAT,INFO_LENGTH,to_char(SUM/100,'9999999999999999990.99') SUM, NAZN, HEADER_ID, to_char(DAT,'dd/mm/yyyy') FDAT, 1,BRANCH FROM DPT_FILE_HEADER WHERE BRANCH like sys_context('bars_context','user_branch_mask') and file_version = '1' ORDER BY DAT DESC, FILENAME DESC"
                        >                            
                        </Bars:BarsSqlDataSourceEx>                        
					</td>
				</tr>
                <tr>
                    <td>
                        </td>
                </tr>
				<tr>
					<td>
					    <table class="InnerTable">
					        <tr>
					            <td style="width:25%">
					                <input id="btImport" runat="server" meta:resourcekey="btNewFile" class="AcceptButton" type="button" value="Принять новый файл" onclick="location.replace('DepositFile.aspx');"/></td>
					            <td style="width:25%">
					                <input id="btCreate" runat="server" meta:resourcekey="btCreate" class="AcceptButton" type="button" value="Создать новый файл" onclick="location.replace('DepositFile.aspx?mode=create');" visible="true"/></td>
					            <td style="width:25%">
                                    <input id="btCopy" runat="server" meta:resourcekey="btCopy" disabled="disabled" class="AcceptButton" type="button" value="Копировать файл" onserverclick="btCopy_ServerClick" /></td>
					            <td style="width:25%">
					                <input id="btDelete" runat="server" meta:resourcekey="btDelete" disabled="disabled" class="AcceptButton" type="button" value="Удалить файл" onserverclick="btDelete_ServerClick"/></td>
					        </tr>
                            <tr>
                                <td style="width: 25%">
                                </td>
                                <td style="width: 25%">
                                </td>
                                <td style="width: 25%">
                                </td>
                                <td style="width: 25%">
                                </td>
                            </tr>
					        <tr>
					            <td>
					                <input type="hidden" runat="server" id="header_id" />
					                <input type="hidden" runat="server" id="filename" />
					                <input type="hidden" runat="server" id="dat" />
					            </td>
					            <td></td>
					            <td></td>
					        </tr>					        
					    </table>		                            
                    </td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
