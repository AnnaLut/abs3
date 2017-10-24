<%@ Page language="c#" Inherits="BarsWeb.DocumentsView.documents"  enableViewState="False" CodeFile="documents.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Просмотр документов</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="defaultCSS.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" src="\Common\WebGrid\Grid2005.js"></script>
        <script type="text/javascript" src="/Common/Script/BarsIe.js?v1.2"></script>
		<script type="text/javascript" src="Script.js?v1.5"></script>
        <script src="/common/jquery/jquery.js"></script>
        <style>
            #oTable tr{
                margin:-5px;
                padding:0px;
            }
            .dispNone{
                display:none;
            }
            button img{
                margin: 0 0 -3px 0;
                padding:0 0 0 0;
            }
        </style>
	</HEAD>
	<body onload="InitDocuments()" topMargin="3" BOTTOMMARGIN="0" LEFTMARGIN="3" RIGHTMARGIN="0">
		<table id="tb_main" cellSpacing="0" cellPadding="0" border="0" width="100%">
			<tr>
				<td height="30">
					<TABLE id="tb_title" cellSpacing="0" cellPadding="0" border="0">
						<TR>
							<TD nowrap style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; PADDING-BOTTOM: 5px; WIDTH: 1%; BORDER-BOTTOM: black 2px solid; FONT-FAMILY: Arial">
								<div id="lb_DocTitles" style="DISPLAY: inline">Документы</div>
							</TD>
						</TR>
						<TR>
							<td style="PADDING-BOTTOM: 10px; PADDING-TOP: 5px">
								<table cellpadding="0" cellspacing="0" border="0" width="100%">
									<tr>
										<TD align="left" valign="middle" style="PADDING-LEFT: 10px; WIDTH: 10px">
                                            <!--IMG id="bt_Refresh" class="appButtonStyle" onclick="RefreshButtonPressed()" height="18"
												alt="Перечитать" src="/Common/Images/refresh.gif" width="18"-->
                                            <button id="bt_Refresh" onclick="RefreshButtonPressed()" title="Перечитати" >
                                                <img alt=""  title="Перечитати" src="/common/images/default/16/refresh.png"/>
                                            </button>
										</TD>
										<TD align="left" valign="middle" style="PADDING-LEFT: 10px; WIDTH: 10px">
                                            <!--IMG id="bt_Filter" class="appButtonStyle" onclick="FilterButtonPressed()" height="18"
												alt="Установить фильтр" src="/Common/Images/FILTER_.gif" width="18"-->
                                            <button  id="bt_Filter" onclick="FilterButtonPressed()" title="Встановити фільтр">
                                                <img alt="" title="Встановити фільтр" src="/common/images/default/16/filter.png"/>
                                                <span>фільтр</span>
                                            </button>
										</TD>
										<TD width="100%" align="left" style="PADDING-LEFT: 10px; WIDTH: 100%">
                                            <div id="printPanel" class="dispNone">
                                                <button id="bt_Print" title="Друк відмічених документів" onclick="printSelDocum();">
                                                    <img alt="" title="Друк відмічених документів" src="/common/images/default/16/print.png" />
                                                    <span>друк</span>
                                                </button>
                                                <input type="checkbox" id="cbPrintTrnModel" />
                                                <label for="cbPrintTrnModel" style="font-size:12px;">друкувати бухмодель</label>
                                            </div>
                                        </TD>
									</tr>
								</table>
							</td>
						</TR>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td><div class="webservice" id="webService" showProgress="true"></div>
				</td>
			</tr>
		</table>
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
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Все документы " />
		<input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="отделения " />
		<input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="пользователя " />
		<input runat="server" type="hidden" id="Message4" meta:resourcekey="Message4" value="Полученные документы " />
		<input runat="server" type="hidden" id="Message5" meta:resourcekey="Message5" value="за день : " />
		<input runat="server" type="hidden" id="Message6" meta:resourcekey="Message6" value="Дата не задана!" />
		<input runat="server" type="hidden" id="Message7" meta:resourcekey="Message7" value="начиная с даты " />
		<input runat="server" type="hidden" id="Message8" meta:resourcekey="Message8" value="Открыть карточку документа" /> 
		<input runat="server" type="hidden" id="Message9" meta:resourcekey="Message9" value="по доступным счетам " /> 
		<input runat="server" type="hidden" id="Message10" meta:resourcekey="Message10" value="Продублировать документ" /> 
		<input runat="server" type="hidden" id="forbt_Refresh" meta:resourcekey="forbt_Refresh" value="Перечитать" /> 
		<input runat="server" type="hidden" id="forbt_Filter" meta:resourcekey="forbt_Filter" value="Установить фильтер" />  
	</body>
</HTML>
