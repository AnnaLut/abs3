<%@ Page Language="C#" AutoEventWireup="true" CodeFile="verifdoc.aspx.cs" Inherits="checkinner_verifdoc" meta:resourcekey="PageResource" %>
<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Верификация ввода</title>
    <link href="CSS/AppStyles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet" />
    <script  type="text/javascript" language="javascript" src="/Common/WebGrid/Grid2005.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
	<script type="text/javascript" language="javascript" src="JScript/Script.js"></script>
	<script type="text/javascript" language="javascript" src="JScript/Script_Documents.js"></script>
	<script type="text/javascript" language="javascript" src="/Common/Script/Sign.js"></script>
	<script type="text/javascript" language="javascript"  src="/Common/WebEdit/NumericEdit.js"></script>
</head>
<body onload="initverifdoc()">
    <form id="form1" runat="server">
    <table cellspacing="0" cellpadding="0" width="100%">
			<tr height="20">
			<td style="PADDING-BOTTOM: 3px; PADDING-TOP: 3px; BORDER-BOTTOM: black 2px solid; border-top: black 2px solid;HEIGHT: 10px">
					<table style="WIDTH: 100%" >
						<tr>
							<td style="PADDING-RIGHT: 5px; WIDTH: 1px; height: 44px;">
							    <bars:ImageTextButton ID="bt_Refresh" meta:resourcekey="bt_Refresh" runat="server" Text="Обновить" ToolTip="Обновить данные" ImageUrl="/Common/Images/default/16/refresh_table.png" OnClientClick="RefreshClk();return false;" EnabledAfter="0" />
							</td>
							<td style="PADDING-RIGHT: 5px; WIDTH: 1px; height: 44px;">
							    <bars:ImageTextButton ID="bt_Filter" meta:resourcekey="bt_Filter" runat="server" Text="Фильтр" ToolTip="Установить фильтр" ImageUrl="/Common/Images/default/16/filter.png" OnClientClick="FilterButtonPressed();return false;" EnabledAfter="0" />
							</td>									
							<td style="WIDTH: 100px;" >
                                <asp:CheckBox ID="cbNlsA" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="Счет-А" Checked="True" meta:resourcekey="cbNlsA" /></td>
							<td style="WIDTH: 100px;">
                                <asp:CheckBox ID="cbMfoB" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="МФО-Б" Checked="True" meta:resourcekey="cbMfoB" /></td>
							<td style="WIDTH: 100px;">
                                <asp:CheckBox ID="cbNlsB" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="Счет-Б" Checked="True" meta:resourcekey="cbNlsB" /></td>
                            <td style="width: 100px;">
                                <asp:CheckBox ID="cbOkpoB" runat="server" Font-Names="Verdana" Font-Size="10pt" Text="ОКПО-Б" Checked="True" meta:resourcekey="cbOkpoB" /></td>
							<td style="PADDING-RIGHT: 5px; WIDTH: 1px; height: 44px;">
                                <bars:ImageTextButton ID="bt_OneStepBack" meta:resourcekey="bt_OneStepBack" runat="server" Text="Возврат" ToolTip="Возврат на одну визу" ImageUrl="/Common/Images/default/16/visa_back.png" OnClientClick="putVisa(10);return false;" EnabledAfter="0" />
							</td>
							<td style="height: 44px"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
			<td style="height:100%"><div class="webservice" id="webService" showProgress="true"></div></td>
			</tr>
			<tr>
			<td>
			<input id="txtNlsA" style="visibility:hidden;position:absolute" onblur="HideTextFields()" onchange="verifData(this)" onkeydown="if(event.keyCode==13) bt_Refresh.focus();"/>
			<input id="txtNlsB" style="visibility:hidden;position:absolute" onblur="HideTextFields()" onchange="verifData(this)" onkeydown="if(event.keyCode==13) bt_Refresh.focus();"/>
			<input id="txtMfoB" style="visibility:hidden;position:absolute" onblur="HideTextFields()" onchange="verifData(this)" onkeydown="if(event.keyCode==13) bt_Refresh.focus();"/>
			<input id="txtOkpoB" style="visibility:hidden;position:absolute" onblur="HideTextFields()" onchange="verifData(this)" onkeydown="if(event.keyCode==13) bt_Refresh.focus();"/>
			<input id="txtSum" style="visibility:hidden;position:absolute;text-align:right" onblur="HideTextFields()" onchange="verifData(this)" onkeydown="if(event.keyCode==13) bt_Refresh.focus();"/>
			</td>
			</tr>
			</table>
			<table style="DISPLAY: none; Z-INDEX: 102; LEFT: 8px; VISIBILITY: hidden; POSITION: absolute; TOP: 672px">
			<tr>
			    <td><input id="hid_grpid" type="hidden" runat="server" /></td>
				<td><input id="__BDATE" type="hidden" runat="server" /></td>
				<td><input id="__SYSDATE" type="hidden" runat="server" /></td>
				<td><input id="__OURMFO" type="hidden" runat="server" /></td>
				<td><input id="__SIGNCC" type="hidden" runat="server" /></td>
				<td><input id="__DOCKEY" type="hidden" runat="server" /></td>
				<td><input id="__REGNCODE" type="hidden" runat="server" /></td>
				<td><input id="__DOCREF" type="hidden" runat="server" /></td>
				<td><input id="__INTSIGN" type="hidden" runat="server" /></td>
				<td><input id="__VISASIGN" type="hidden" runat="server" /></td>
				<td><input id="__SIGNTYPE" type="hidden" runat="server" /></td>
				<td><input id="__SIGNLNG" type="hidden" runat="server" /></td>
				<td><input id="__SEPNUM" type="hidden" runat="server" /></td>
				<td><input id="__VOB2SEP" type="hidden" runat="server" /></td>
				<td><input id="__CERTNAME" type="hidden" runat="server" /></td>
			</tr>
		</table>
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Визировать документ " />
		<input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="Вернуть документ " />
		<input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="Неверное значение!" />
         <input runat="server" type="hidden" id="currentPageCulture" meta:resourcekey="currentPageCulture" value="ru" />
        <input runat="server" type="hidden" id="wgPageSizeText" meta:resourcekey="wgPageSizeText" value="Cтрок на странице:" />
        <input runat="server" type="hidden" id="wgPrevPage" meta:resourcekey="wgPrevPage" value="Предыдущая страница" />
        <input runat="server" type="hidden" id="wgNextPage" meta:resourcekey="wgNextPage" value="Следующая страница" />
        <input runat="server" type="hidden" id="wgRowsInTable" meta:resourcekey="wgRowsInTable" value="Количество строк в таблице" />
        <input runat="server" type="hidden" id="wgAscending" meta:resourcekey="wgAscending" value="По возрастанию" />
        <input runat="server" type="hidden" id="wgDescending" meta:resourcekey="wgDescending" value="По убыванию" />
        <input runat="server" type="hidden" id="wgSave" meta:resourcekey="wgSave" value="Сохранить" />
        <input runat="server" type="hidden" id="wgCancel" meta:resourcekey="wgCancel" value="Отмена" />
        <input runat="server" type="hidden" id="wgSetFilter" meta:resourcekey="wgSetFilter" value="Установить фильтр" />
        <input type="hidden" id="wgFilter" value="Фильтр" />
        <input type="hidden" id="wgAttribute" value="Атрибут" />
        <input type="hidden" id="wgOperator" value="Оператор" />
        <input type="hidden" id="wgLike" value="похож" />
        <input type="hidden" id="wgNotLike" value="не похож" />
        <input type="hidden" id="wgIsNull" value="пустой" />
        <input type="hidden" id="wgIsNotNull" value="не пустой" />
        <input type="hidden" id="wgOneOf" value="один из" />
        <input type="hidden" id="wgNotOneOf" value="ни один из" />
        <input type="hidden" id="wgValue" value="Значение" />
        <input type="hidden" id="wgApply" value="Применить" />
        <input type="hidden" id="wgFilterCancel" value="Отменить" />
        <input type="hidden" id="wgCurrentFilter" value="Текущий фильтр:" />
        <input type="hidden" id="wgDeleteRow" value="Удалить строку" />
        <input type="hidden" id="wgDeleteAll" value="Удалить все" />
	
    </form>
</body>
</html>
