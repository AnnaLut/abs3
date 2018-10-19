<%@ Page Language="c#" Inherits="BarsWeb.DocumentsView.documents" EnableViewState="False" CodeFile="documents.aspx.cs" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Просмотр документов</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="defaultCSS.css" type="text/css" rel="stylesheet">
    <link href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="\Common\WebGrid\Grid2005.js"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js?v1.2"></script>
    <script type="text/javascript" src="Script.js?v1.5"></script>
    <script src="/common/jquery/jquery.js"></script>
    <link href="../lib/alertify/css/alertify.core.css" rel="stylesheet" />
    <link href="../lib/alertify/css/alertify.default.css" rel="stylesheet" />
    <script src="../lib/alertify/js/alertify.min.js"></script>

    <style>
        #oTable tr {
            margin: -5px;
            padding: 0px;
        }

        .dispNone {
            display: none;
        }

        button img {
            margin: 0 0 -3px 0;
            padding: 0 0 0 0;
        }

        a.selected {
            background-color: #1F75CC;
            color: white;
            z-index: 100;
            display: block;
        }

        .selected {
            background: #bdf;
        }

        .messagepop {
            background-color: #FFFFFF;
            border: 1px solid #d9edf7;
            position: absolute;
            cursor: pointer;
            display: none;
            width: 220px;
            height: 90px;
            /*margin-top: 15px;
                position:absolute;
                text-align:left;
                z-index:50;
                padding: 25px 25px 20px;*/
        }

        .lab {
            margin-bottom: 3px;
            padding-left: 15px;
            text-indent: -15px;
        }

        .messagepop p, .messagepop.div {
            border-bottom: 1px solid #000000;
            background: #d9edf7;
            margin: 8px 0;
            padding-bottom: 8px;
        }

        .modalBackgroundOn {
            position: fixed; 
            z-index: 999; 
            height: 100%; 
            width: 100%; 
            top: 0; 
            left:0; 
            background-color: Black; 
            filter: alpha(opacity=60); 
            opacity: 0.6; 
            -moz-opacity: 0.8;
        }

        .modalBackgroundOff {
            display: none
        } 


        .modalWindow {
            display: block; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}



    </style>
</head>
<body onload="InitDocuments()" topmargin="3" bottommargin="0" leftmargin="3" rightmargin="0">
    <table id="tb_main" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td height="30">
                <table id="tb_title" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td nowrap style="font-weight: bold; font-size: 10pt; padding-bottom: 5px; width: 1%; border-bottom: black 2px solid; font-family: Arial">
                            <div id="lb_DocTitles" style="display: inline">Документы</div>
                            <div id="lb_DocCount" style="display: inline"></div>
                            <div id="lb_DocCountSelected" style="display: none"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-bottom: 10px; padding-top: 5px">
                            <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                    <td align="left" valign="middle" style="padding-left: 10px; width: 10px">
                                        <!--IMG id="bt_Refresh" class="appButtonStyle" onclick="RefreshButtonPressed()" height="18"
												alt="Перечитать" src="/Common/Images/refresh.gif" width="18"-->
                                        <button id="bt_Refresh" onclick="RefreshButtonPressed()" title="Перечитати">
                                            <img alt="" title="Перечитати" src="/common/images/default/16/refresh.png" />
                                        </button>
                                    </td>
                                    <td align="left" valign="middle" style="padding-left: 10px; width: 10px">
                                        <!--IMG id="bt_Filter" class="appButtonStyle" onclick="FilterButtonPressed()" height="18"
												alt="Установить фильтр" src="/Common/Images/FILTER_.gif" width="18"-->
                                        <button id="bt_Filter" onclick="FilterButtonPressed()" title="Встановити фільтр">
                                            <img alt="" title="Встановити фільтр" src="/common/images/default/16/filter.png" />
                                            <span>фільтр</span>
                                        </button>
                                    </td>
                                    <td align="left" valign="middle" style="padding-left: 10px; width: 10px">
                                        <!--IMG id="bt_Filter" class="appButtonStyle" onclick="FilterButtonPressed()" height="18"
												alt="Установить фильтр" src="/Common/Images/FILTER_.gif" width="18"-->
                                        <button id="bt_Excel" onclick="fnExportToExcel()" title="Імпорт в Excel">
                                            <img alt="" title="Імпорт в Excel" src="/common/images/default/16/export_excel.png" />
                                            <span>Excel</span>
                                        </button>
                                    </td>
                                    <td width="100%" align="left" style="padding-left: 10px; width: 100%">
                                        <div id="printPanel" class="dispNone">
                                            <button id="bt_Print" title="Друк відмічених документів" onclick="printSelDocum();">
                                                <img alt="" title="Друк відмічених документів" src="/common/images/default/16/print.png" />
                                                <span>друк</span>
                                            </button>
                                            <input type="checkbox" id="cbPrintTrnModel" />
                                            <label for="cbPrintTrnModel" style="font-size: 12px;">друкувати бухмодель</label>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div class="webservice" id="webService" showprogress="true"></div>
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


    <div id="popupsum" class="messagepop pop">
    <div id="cust_colm_Name"></div>
    <div id="cust_colm_Sum"></div>
    </div>
</body>

<script type="text/javascript">
    function arrayContains(element, arr) {
        var i = arr.length;
        var as = arr[0] + "/";
        while (i--) {
            var el = arr[i];
            if (el.substr(el.length - 1) != "/")
                el = el + "/";
            if (el === element ) {
                return true;
            }
        }
        return false;
    }

    function ManualKalkulateGrid(colmn_num) {
        //getting grid info
        //debugger;
        var gridInfo = [];
        for (var i = 1; i < 1000; i++) {
            var elements = $("#r_" + i).children();
            if (elements.length <= 0)
                break;
            var innerGrid = [];
            for (var j = 1; j < elements.length; j++) {
                innerGrid.push(elements[j].innerHTML)
            }
            gridInfo.push(innerGrid);
        }
        //select All
        var allSelectedItems = "";
        if (window.getSelection) {  // all browsers, except IE before version 9
            var allSelectedItems = window.getSelection();
        }
        else {
            if (document.selection.createRange) { // Internet Explorer
                var allSelectedItems = document.selection.createRange();
            }
        }
        allSelectedItems = allSelectedItems.text.split("\n");
        for (var i = 0; i < allSelectedItems.length; i++) {
            allSelectedItems[i] = allSelectedItems[i].replace(/^\s+|\s+$/gm, '').replace(" ", "");
            if (i < allSelectedItems.length - 1) {
                allSelectedItems[i] = allSelectedItems[i].substring(0, allSelectedItems[i].length - 1);
            }
        }
        var selectedObjects = [];
        for (var i = 0; i < gridInfo.length; i++) {
            var str = gridInfo[i].join("").replace(" ", "");
            if (arrayContains(gridInfo[i].join("").replace(" ", ""), allSelectedItems)) {
                selectedObjects.push(gridInfo[i]);
            }
        }
        if (selectedObjects.length > 1) {
            var tittles = $("tr[align=center]").children()[colmn_num].innerHTML;
            var my_sum = 0;
            var col = colmn_num - 1;
            var val = isNaN(parseFloat(selectedObjects[0][col]));
            var val2 = selectedObjects[0][col].indexOf('.');
            var val3 = selectedObjects[0][col].split(".").length;
            
            if (isNaN(parseFloat(selectedObjects[0][col])) || selectedObjects[0][col].indexOf('.') < 0 || selectedObjects[0][col].split(".").length > 2) {
                return { "comn": tittles, "sum": "Поле неможливо просумувати" };
            }
            for (var i = 0; i < selectedObjects.length; i++) {
                if (selectedObjects[i][col] == '')
                    continue;
                my_sum += parseFloat(selectedObjects[i][col].replace(/\D/g, '')) / 100;
            }
            return { "comn": tittles, "sum": my_sum.toFixed(2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ') };
        } else {
            return "none";
        }
        var identifier = parseFloat(selectedObjects);
        if (parseFloat)
            selectedObjects;


    }


    //$(document).on("click", function () {  additemToPopup(); });
    //function additemToPopup() {
        
        //for (var i = 1; i < 1000; i++) {
        //    var elements = $("#r_" + i).children();
        //    if (elements.length <= 0) {
        //        deselect($('#contact'));
        //        $("#popupsum").hide();
        //        $('.pop').css({ top: 100, left: 100 }).hide();
        //        break;
        //    }
           
        //    for (var j = 1; j < elements.length; j++) {
               
        //        //    "elements[j].attachEvent('onmouseover', function (event) {" +              
        //        //elements[j].attachEvent('onmouseout', function () {                
        //        eval(
        //            //"elements[j].unbind('onmouseover');" +
        //            //"elements[j].unbind('onmouseout');" +
        //            "elements[j].onmouseover =  function () {" +
        //            "var res = ManualKalkulateGrid(" + j + ");" +
        //            "if (res === 'none') {" +
        //            "    deselect($('#contact')); " +
        //             //"    $('#cust_colm_Name')[0].innerHTML = 'Обрано менше 2х записів';" +
        //             // "    $('#cust_colm_Sum')[0].innerHTML = '';" +
        //            "    return;" +
        //            "} else {" +
        //             "    $('#cust_colm_Name')[0].innerHTML = res.comn;" +
        //             "    $('#cust_colm_Sum')[0].innerHTML = res.sum;}" +
        //            "    if ($(this).hasClass('selected')) { deselect($(this)); } else { $(this).addClass('selected'); $('.pop').slideFadeToggle(); }" +
        //            "    $('#popupsum').show();" +
        //            "    $('.pop').css({ top: window.event.clientY+15, left: window.event.clientX }).show(); " +
        //            "    return false;" +
        //            "};");
        //        elements[j].onmouseout = function () {
                    
        //            deselect($('#contact'));
        //            //$("#popupsum").hide();
        //            //hide window in right part out of screen
        //            //Ie8 solution
        //           $('.pop').css({ top: 100, left: 100 }).hide();
        //            return false;
        //        };
        //    }
        //}
    //}


    function deselect(e) {
        $('.pop').slideFadeToggle(function () {
            e.removeClass('selected');
        });
    }
    $.fn.slideFadeToggle = function (easing, callback) {
        return this.animate({ opacity: 'toggle', height: 'toggle' }, 0, easing, callback);
    };

</script>

<%--<div id="popupsum" class="messagepop pop">
    <div id="cust_colm_Name"></div>
    <div id="cust_colm_Sum"></div>
</div>--%>

</html>
