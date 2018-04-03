<%@ Page language="c#" CodeFile="custacc.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.AccountsList" enableViewState="False" enableViewStateMac="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Рахунки контрагента</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="Javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="Scripts\Common.js?v.1.0"></script>
		<script language="JavaScript" src="Scripts\CustAcc.js?v1.4"></script>
		<script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js?v1.1"></script>
		<script language="javascript">
		  window.onload = InitCustAccParams;
	      var image1 = new Image(); image1.src="/Common/Images/SHOW.gif";
		  var image2 = new Image(); image2.src="/Common/Images/INSERT.gif";
		  var image3 = new Image(); image3.src="/Common/Images/OPEN_.gif";
		  var image4 = new Image(); image4.src="/Common/Images/DELREC.gif";
		  var image5 = new Image(); image5.src="/Common/Images/CHEKIN.gif";
		  var image6 = new Image(); image6.src="/Common/Images/BACK.gif";
		  var image7 = new Image(); image7.src="/Common/Images/REFRESH.gif";
		  var image8 = new Image(); image8.src="/Common/Images/FILTER_.gif";
		  var image9 = new Image(); image9.src="/Common/Images/PRINT.gif";
		  var image10 = new Image(); image10.src="/Common/Images/DISCARD.gif";
		  var image11 = new Image(); image11.src="/Common/Images/BOOKS1.gif";
		  var image12 = new Image(); image12.src="/Common/Images/BOOKS.gif";
		</script>
	</HEAD>
	<body>
	    <form id="formCustAcc" runat="server" defaultbutton="btFind">
		<div style="BACKGROUND-COLOR: lightgrey">
			<span id="lbType" style="FONT-SIZE:8pt;COLOR:navy;FONT-FAMILY:Verdana"></span><span id="lbNmk" style="FONT-SIZE:8pt;COLOR:maroon;FONT-FAMILY:Verdana">
			</span>
            <asp:Panel CssClass="SimpleText" ID="pnSearsh" GroupingText="Пошук" style="white-space:nowrap;padding:10px;" runat="server">
                <table border="0" cellpadding="2" cellspacing="2" class="SimpleText">
                <tr>
                    <td>
                        <span>Рахунок:</span>
                    </td>
                    <td>
                        <input id="tbFindNls" style="width:150px" type="text" title="Маска рахунку для пошуку, перші цифри в номері" />
                    </td>
                    <td>
                        <span>Валюта:</span>
                    </td>
                    <td>
                        <input id="tbFindKv" style="width:35px" maxlength="3" type="text" title="Валюта рахунку(числова чи символьна)" />
                        <asp:Button ID="btnVal" runat="server" OnClientClick="selectKV('tbFindKv');return false;" Text="..." style="margin-left:-4px;padding-top:-3px;" />
                    </td>
                    <td>
                        <span>Назва:</span>
                    </td>
                    <td>
                        <input id="tbFindNms" style="width:150px" type="text" title="Найменування рахунку" />
                    </td>
                    <td>
                        <span>Акт/Пас:</span>
                    </td>
                    <td>
                        <select id="ddPap">
                            <option selected="selected" value="">Всі</option>
			                <option value="1">А</option>
			                <option value="2">П</option>
			                <option value="3">А/П</option>
                        </select>
                    </td>
                    <td rowspan="2">
                        &nbsp;&nbsp;
                        <asp:Button id="btFind" runat="server" style="width:60px;height:60px"  OnClientClick="QuickFind();return false;" Text="Ок" ToolTip="Застосувати вказані умови фільтру" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbFilterDD" runat="server" />
                    </td>
                    <td id="tdBranch" runat="server" visible="false" colspan="5">
                        <asp:DropDownList ID="ddBranches" runat="server" />       
                    </td>
                    <td id="tdSaldo" runat="server" visible="false" colspan="2">
                        <asp:DropDownList ID="ddWhereClause" runat="server" Width="150px" />       
                    </td>
                    <td>
                        РНК клієнта:
                    </td>
                    <td>
                        <input id="tbFindRNK" style="width:75px" type="text" />
                    </td>
                </tr>
                </table>
            </asp:Panel>
			<TABLE cellSpacing="0" cellPadding="0" border="1">
				<TR>
					<TD>&nbsp;<IMG class="outset" id="btShow" title="Показавать/спрятать закрытые счета" onclick="fnShowHide()">&nbsp;</TD>
					<TD>&nbsp;<IMG class="outset" id="btOpen" title="Открыть счет" onclick="fnOpenAcc()"><IMG class="outset" id="btEdit" title="Просмотр\редктирование атрибутов счета" onclick="fnViewAcc()"><IMG class="outset" id="btClose" title="Закрыть счет" onclick="fnCloseAcc()"><IMG class="outset" id="btReanim" title="'Реанимировать' счет" onclick="fnReanimAcc()"><IMG class="outset" id="btReg" title="Перерегистрировать счет на другого клиента" onclick="fnReRegistr()"
							style="VISIBILITY: hidden" width="0"> &nbsp;</TD>
					<TD>&nbsp;<IMG class="outset" id="btRefresh" title="Перечитать данные" onclick="ReInitGrid()"><IMG class="outset" id="btFilter" title="Установить фильтр" onclick="ShowModalFilter()">
						<IMG class="outset" id="btHistAcc" title="История счета" onclick="fnShowHistAcc()"><IMG class="outset" id="btHist" title="История изменения параметров счета" onclick="fnShowHist()"><IMG class="outset" id="btIntState" title="Моделювання нарахованих відсотків" onclick="fnIntState()" src="/Common/Images/A_PROC.gif">&nbsp;</TD>
					<TD>&nbsp;<IMG class="outset" id="btDiscard" title="Выход" onclick="goBack()">&nbsp;</TD>
					<td class="SimpleText" >
					    <div style="white-space:nowrap;">
					    &nbsp;&nbsp;Колір тексту:&nbsp;<span style="background-color:Purple;width:10px"></span>&nbsp; - заблоковані рахунки,&nbsp;&nbsp;<span style="background-color:#8080FF;width:10px"></span>&nbsp; - закриті рахунки&nbsp;&nbsp;
					    </div>
					</td>
				</TR>
			</TABLE>
		</div>
		<div class="webservice" id="webService" showProgress="true"></div>
		<!-- #include file="/Common/Include/Localization.inc"-->
		<!-- #include file="/Common/Include/WebGrid2005.inc"-->  
		<input runat="server" type="hidden" id="forbtShow" meta:resourcekey="forbtShow" value="Показывать/спрятать закрытые счета" />
		<input runat="server" type="hidden" id="forbtOpen" meta:resourcekey="forbtOpen" value="Открыть счет" />
		<input runat="server" type="hidden" id="forbtEdit" meta:resourcekey="forbtEdit" value="Редактирование атрибутов счета" />
		<input runat="server" type="hidden" id="forbtView" meta:resourcekey="forbtView" value="Просмотр атрибутов счета" />
		<input runat="server" type="hidden" id="forbtClose" meta:resourcekey="forbtClose" value="Закрыть счет" />
		<input runat="server" type="hidden" id="forbtReanim" meta:resourcekey="forbtReanim" value="'Реанимировать' счет" />
		<input runat="server" type="hidden" id="forbtReg" meta:resourcekey="forbtReg" value="Перерегистрировать счет на другого клиента" />
		<input runat="server" type="hidden" id="forbtRefresh" meta:resourcekey="forbtRefresh" value="Перечитать данные" />
		<input runat="server" type="hidden" id="forbtFilter" meta:resourcekey="forbtFilter" value="Установить фильтр" />
		<input runat="server" type="hidden" id="forbtHistAcc" meta:resourcekey="forbtHistAcc" value="История счета" />
		<input runat="server" type="hidden" id="forbtHist" meta:resourcekey="forbtHist" value="История изменения параметров счета" />
		<input runat="server" type="hidden" id="forbtPrint" meta:resourcekey="forbtPrint" value="Печать" />
		<input runat="server" type="hidden" id="forbtDiscard" meta:resourcekey="forbtDiscard" value="Выход" />
		
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Счета контрагента." />
		<input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="Счета пользователя." />
		<input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="Счета отделения." />
		<input runat="server" type="hidden" id="Message4" meta:resourcekey="Message4" value="Счета по кредитному договору №" />
		<input runat="server" type="hidden" id="Message5" meta:resourcekey="Message5" value="Счета контрагента." />
		<input runat="server" type="hidden" id="Message6" meta:resourcekey="Message6" value="Вы действительно хотите закрыть текущий счет?" />
		<input runat="server" type="hidden" id="Message7" meta:resourcekey="Message7" value="Вы уверены что хотите ВОССТАНОВИТЬ текущий счет? Эта операция применима только для счетов закрытых текущей банковской датой." />
		<input runat="server" type="hidden" id="Message8" meta:resourcekey="Message8" value="Вы уверены что хотите ПЕРЕРЕГИСТРИРОВАТЬ текущий счет на другого контрагента? Эта операция применима только для счетов открытых текущей банковской датой." />
		<input runat="server" type="hidden" id="Message10" meta:resourcekey="Message10" value="Счет был удачно перерегистрирован" />
		<input runat="server" type="hidden" id="Message11" meta:resourcekey="Message11" value="Ошибка при перерегистрации" />
		</form>
	</body>
</HTML>
