<%@ Page language="c#" CodeFile="acc_rights.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Acc_Rights" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Tab2</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/Rights.js"></script>
</HEAD>
	<body scroll="no">
		<TABLE style="VISIBILITY:hidden;WIDTH:100%" id="tblOld">
			<TR>
				<TD height="1">
					<div id="Panel" class="BarsPanel">
						<span id="lbGroup" runat="server" meta:resourcekey="lbGroup" class="BarsLabel">Группа доступа</span>
						<TABLE id="T3" cellSpacing="1" cellPadding="1" width="100%">
							<TR>
								<TD style="WIDTH: 47px"></TD>
								<TD>
									<select name="ddGroups" id="ddGroups" style="WIDTH:321px" onclick="d_dlg(this)">
										<option value="" selected></option>
									</select></TD>
							</TR>
						</TABLE>
					</div>
					<div id="P1" class="BarsPanel"><P>
							<span id="lbPrava" runat="server" meta:resourcekey="lbPrava" class="BarsLabel">Права Исполнителя</span>
							<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%">
								<TR>
									<TD width="47"></TD>
									<TD>
										<span class="CheckBox"><input id="cbIspV" type="checkbox" name="cbIspV" onclick="CalcSeciSeco(cbIspV,cbIspD,cbIspK,'Seci')" CHECKED><label for="cbIspV" runat="server" meta:resourcekey="cbIspV">Просмотр</label></span></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<span class="CheckBox"><input id="cbIspD" type="checkbox" name="cbIspD" onclick="CalcSeciSeco(cbIspV,cbIspD,cbIspK,'Seci')"><label for="cbIspD" runat="server" meta:resourcekey="cbIspD">Разрешено 
												дебетовать</label></span></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<span class="CheckBox"><input id="cbIspK" type="checkbox" name="cbIspK" onclick="CalcSeciSeco(cbIspV,cbIspD,cbIspK,'Seci')"><label for="cbIspK" runat="server" meta:resourcekey="cbIspK">Разрешено 
												кредитовать</label></span></TD>
								</TR>
							</TABLE>
						</P>
					</div>
					<div id="P2" class="BarsPanel"><P>
							<span id="lbDr" runat="server" meta:resourcekey="lbDr" class="BarsLabel">Другие</span>
							<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%">
								<TR>
									<TD width="47"></TD>
									<TD>
										<span class="CheckBox"><input id="cbOthV" type="checkbox" name="cbOthV" onclick="CalcSeciSeco(cbOthV,cbOthD,cbOthK,'Seco')"><label for="cbOthV" runat="server" meta:resourcekey="cbIspV">Просмотр</label></span></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<span class="CheckBox"><input id="cbOthD" type="checkbox" name="cbOthD" onclick="CalcSeciSeco(cbOthV,cbOthD,cbOthK,'Seco')"><label for="cbOthD" runat="server" meta:resourcekey="cbIspD">Разрешено 
												дебетовать</label></span></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<span class="CheckBox"><input id="cbOthK" type="checkbox" name="cbOthK" onclick="CalcSeciSeco(cbOthV,cbOthD,cbOthK,'Seco')"><label for="cbOthK" runat="server" meta:resourcekey="cbIspK">Разрешено 
												кредитовать</label></span></TD>
								</TR>
							</TABLE>
						</P>
					</div>
				</TD>
			</TR>
		</TABLE>
		<TABLE style="VISIBILITY:hidden;WIDTH:100%" id="tblNew">
			<TR>
				<td><span runat="server" id="lbGroupsAcc" meta:resourcekey="lbGroupsAcc" class="BarsLabel">Выбранные группы счетов</span></td>
			</TR>
			<TR>
				<TD><SELECT size="15" id="lsGroupsAcc" style="WIDTH: 300px">
					</SELECT></TD>
			</TR>
			<TR>
				<TD><IMG id="btAdd" onclick="AddGrp()" src="/Common/Images/INSERT.gif">&nbsp;
					<IMG onclick="DelGrp()" src="/Common/Images/DELREC.gif" id="btDel"></TD>
			</TR>
		</TABLE>
		<div class="webservice" id="webService" showProgress="true"></div>
		<input type="hidden" runat="server" id="forbtAdd" meta:resourcekey="forbtAdd" value="Добавить группу счетов" />
		<input type="hidden" runat="server" id="forbtDel" meta:resourcekey="forbtDel" value="Удалить выделеную группу" />
		<input type="hidden" runat="server" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
		<script>fnLoadRights();</script>
	</body>
</HTML>
