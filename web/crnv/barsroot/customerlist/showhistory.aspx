<%@ Page language="c#" CodeFile="showhistory.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.ShowHistory"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Історія рахунку</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>
		<script language="javascript" src="Scripts/AccHistory.js?v1.1"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" src="/Common/WebEdit/RadInput.js"></script>
		<script language="javascript">
			function GetStart() 
			{
				InitAccHist(); 
				if(document.all.hPrintFlag.value != '1')
				{
					document.all.btPrintHtml.style.visibility = "hidden";
					document.all.btPrintRtf.style.visibility = "hidden";
				}
			}
			function keyPressInEdit(evnt)
			{
				if(evnt.keyCode == 13)
				{
					bt_AcceptDates_click();
				}
			}		
		</script>
	</HEAD>
	<body onload="GetStart()">
		<form id="Form1" method="post" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%">
				<tr>
					<td style="HEIGHT: 42px">
						<table width="100%">
							<tr>
								<td align="center">
									<DIV class="SmallTitleText" id="Title" style="DISPLAY: inline" runat="server"></DIV>
								</td>
								<TD noWrap width="1"><IMG id="btPrintHtml" title="Печать выписки по счету за период(html формат)" style='visibility:hidden' onclick="printExtract(0)"
										src="/Common/Images/Print.gif"></TD>
								<td noWrap width="1"><IMG id="btPrintRtf" title="Печать выписки по счету за период(rtf формат)" style='visibility:hidden' onclick="printExtract(1)"
										src="/Common/Images/word_2005.gif"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="BORDER-TOP: black 2px solid; PADDING-BOTTOM: 2px; PADDING-TOP: 2px; BORDER-BOTTOM: black 2px solid">
						<table cellSpacing="0" cellPadding="0" width="100%">
							<tr>
								<td class="BodyCell" runat="server" meta:resourcekey="tdFrom" width="20" style="height: 24px">С :
								</td>
								<td onkeypress="keyPressInEdit(event)" width="102" style="height: 24px">
								<input id="ed_strDt" type="hidden"><input id="ed_strDt_Value" type="hidden" name="ed_strDt"><asp:textbox id="ed_strDt_TextBox" style="TEXT-ALIGN: center" tabIndex="1" runat="server" Width="100px"
										EnableViewState="False" BorderStyle="Solid" BorderWidth="1px" BorderColor="Black"></asp:textbox>
								<td class="BodyCell" runat="server" meta:resourcekey="tdTill" style="width: 20px; height: 24px;">По :
								</td>
								<td onkeypress="keyPressInEdit(event)" width="102" style="height: 24px">
								<input id="ed_endDt" type="hidden"><input id="ed_endDt_Value" type="hidden" name="ed_endDt"><asp:textbox id="ed_endDt_TextBox" style="TEXT-ALIGN: center" tabIndex="2" runat="server" Width="100px"
										EnableViewState="False" BorderStyle="Solid" BorderWidth="1px" BorderColor="Black"></asp:textbox>
								<td style="PADDING-LEFT: 4px; height: 24px;"><input onkeypress="keyPressInEdit(event)" id="bt_AcceptDates" meta:resourcekey="bt_AcceptDates" style="COLOR: darkred" onclick="bt_AcceptDates_click()"
										runat="server" tabIndex="3" type="button" value="Принять"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td style="PADDING-TOP: 2px">
						<div class="webservice" id="webService" showProgress="true"></div>
					</td>
				</tr>
			</table>
			<input type="hidden" id="hPrintFlag" runat="server">
			<!-- #include file="/Common/Include/Localization.inc"-->
			<!-- #include file="/Common/Include/WebGrid2005.inc"-->   
			<input runat="server" type="hidden" id="forbtPrintHtml" meta:resourcekey="forbtPrintHtml" value="Печать выписки по счету за период(html формат)" />
			<input runat="server" type="hidden" id="forbtPrintRtf" meta:resourcekey="forbtPrintRtf" value="Печать выписки по счету за период(rtf формат)" />
		</form>
	</body>
</HTML>
