<%@ Page language="c#" CodeFile="ReqPeriod.aspx.cs" AutoEventWireup="false" Inherits="mobinet.ReqPeriod" enableViewState="False"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>ReqPeriod</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<link href="/Common/CSS/AppCSS.css" type="text/css" rel=Stylesheet />
		<script language="javascript">
		      <!--
		      function InitialTask(){
		        document.FormPeriod.dt_finish_t.focus();
				document.FormPeriod.dt_start_t.focus();
		      }		      				
			//-->
		</script>
	</HEAD>
	<body onload="InitialTask();">
		<form id="FormPeriod" method="post" runat="server">
			<TABLE id="TableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
				<TR>
					<TD height="30%"></TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="HeadTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD style="FONT-WEIGHT: bold" align="center">Укажите период для отбора транзакций</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="MainTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD width="50" align="left">C:</TD>
								<TD style="WIDTH: 130px" align="center">
									<igtxt:WebDateTimeEdit id="dt_start" runat="server" DisplayModeFormat="dd.MM.yyyy" EditModeFormat="dd.MM.yyyy"
										EnableViewState="False" HorizontalAlign="Center" tabIndex="1" Width="130px" HideEnterKey="True"></igtxt:WebDateTimeEdit>
								</TD>
							</TR>
							<TR>
								<TD width="50" align="left">По:</TD>
								<TD style="WIDTH: 130px" align="center">
									<igtxt:WebDateTimeEdit id="dt_finish" runat="server" DisplayModeFormat="dd.MM.yyyy" EditModeFormat="dd.MM.yyyy"
										EnableViewState="False" HorizontalAlign="Center" tabIndex="2" Width="130px" HideEnterKey="True"></igtxt:WebDateTimeEdit>
								</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="ButtonTable" cellSpacing="0" cellPadding="0" width="260" border="0">
							<TR>
								<TD class="cell_label" align="right"><INPUT id="id_ok" tabIndex="3" type="submit" value="Утвердить">&nbsp;
								</TD>
								<TD style="WIDTH: 130px" align="left">&nbsp;<INPUT id="id_reset" tabIndex="4" type="reset" value="Отменить">
								</TD>
							</TR>
						</TABLE>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD height="70%"></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
