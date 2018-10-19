//DOM переменные
var v_Xml_Http = new ActiveXObject('Microsoft.XMLHTTP');
var v_Obj_Xslt = new ActiveXObject('MSXML2.DOMDocument');
var v_Xml_Filter = new ActiveXObject('MSXML2.DOMDocument');
var v_Obj_Soap = new ActiveXObject('MSXML2.DOMDocument');
v_Obj_Xslt.async = false;
v_Obj_Soap.async = false;
v_Xml_Filter.async = false;
/*
v_data[0] \
v_data[1]  -  формируют фильтр
v_data[2] /
v_data[3] - сортировка
v_data[4] - номер строки с которой выбираються данные 
v_data[5] - размер страницы (сколько строк выбирается)
v_data[6] - количество строк в фильтре
v_data[7] - номер следующей строки в фильтре
v_data[8] - общее количество строк в таблице
v_data[9-20] - любые данные 
*/
//Глобальные переменние
var v_data = new Array(20);				//хранилище данних на странице(можна хранить любые данные в ячейках с 10 по 20)
var v_editFields = new Array();			//масив полей таблицы, которие можно изменять
var filter_list = new Array();			//масив всех строчек фильтра
var view_state;							//состояние вида
for (i = 0; i <= 20; i++) v_data[i] = '';	//обнуляем 20 первых елементов
var pageSize = 20;						//размер страницы (количество строк)
var filter_array = new Array();			//Массив строк фильтра
var v_ServiceObjName;					//id сервиса на странице
var v_ServiceName;						//имя страницы сервиса (Service.asmx)
var v_ServiceMethod;					//имя веб-метода из сервиса, который возвращает данные для таблицы
var v_ServiceFuncAfter;					//имя javascript функции, которая выполится сразу после отрисовки таблицы
var v_FuncDelRow;						//имя javascript функции, при удалении стоки из таблицы
var v_FuncFilter;						//имя javascript функции, при применении или изменении фильтра 
var v_FuncFilterBefore;                 //имя javascript функции, которая выполится сразу после изменения фильтра
var v_FuncOnSelect;						//имя javascript функции, при выделении стоки	
var v_ShowFilterOnStart = false;		//флаг - показать окно фильтра при начальной загрузке
var v_FilterTable;						//имя таблицы, для которой строется фильтр
var v_ServiceAfterRefresh;
var v_CustomViewState;					//имя javascript функции, для заполнения не типичных данных состояния
var v_EnableSelect = true;				//флаг - возможность выделять стоку

var v_ShowPager = true;					//флаг - изпользование педжинга
var v_alignPager = "center";			//размещение пейджинга
var v_PagerCellWidth = "50%";			//ширина ячейки пейджера

var v_EnablePageSize = true;			//флаг - изпользование ввода кол-тва строк грида
var v_PageSizeText = "Строк на странице:";	//ширина ячейки поля ввода кол-тва строк грида
var v_PageSizeCellWidth = "50%";		//ширина ячейки поля ввода кол-тва строк грида

var v_EnableSort = true;				//флаг - возможность сортировки
var v_EnableViewState = false;			//флаг - работа с view_state: сохранение основних параметров в head.aspx фрейма из barsweb
var v_FilterInMenu = true;				//флаг - в контекстном меню пункт Установить фильтр
var selectedRow;						//выделенная строка
var selectedRowId;						//id выделеной строки (значение уникального поля таблицы)
var row_id;								//id выделеной строки (номер строки по порядку начиная с 0)	
var sort_exp;							//выражение для сортировки
var returnServiceValue;					//масив занчений, возвращаемых веб-методом, изпользуются первых два значения
var acces_mode;							//флаг доступа (0=readonly, 1=edit) 
var v_XmlFilenameFilter;				//имя xml-файла для вычитки фильтра
var v_MenuItems = new Array();
var row_new = 0;
var v_row_style;
var v_NotFill = false;                  //флаг - не выполнять заполнение грида

//Инициализация параметров грида
function fn_InitVariables(obj) {
    v_ServiceObjName = obj.v_serviceObjName;
    v_ServiceName = obj.v_serviceName;
    v_ServiceMethod = obj.v_serviceMethod;
    v_ServiceFuncAfter = obj.v_serviceFuncAfter;
    v_FuncDelRow = obj.v_funcDelRow;
    v_FuncCheckValue = obj.v_funcCheckValue;
    v_FuncFilter = obj.v_funcFilter;
    v_FuncFilterBefore = obj.v_funcFilterBefore;
    v_FuncOnSelect = obj.v_funcOnSelect;
    v_CustomViewState = obj.v_customViewState;
    v_ServiceAfterRefresh = obj.v_serviceAfterRefresh;
    v_XmlFilenameFilter = obj.v_xmlFilenameFilter;
    v_MenuItems = obj.v_menuItems;
    v_FilterTable = obj.v_filterTable;
    if (obj.v_notFill != null) v_NotFill = obj.v_notFill;

    if (obj.v_filterInMenu != null) v_FilterInMenu = obj.v_filterInMenu;

    if (obj.v_showPager != null) v_ShowPager = obj.v_showPager;
    if (obj.v_alignPager != null) v_alignPager = obj.v_alignPager;
    if (obj.v_PagerCellWidth != null) v_PagerCellWidth = obj.v_PagerCellWidth;

    if (obj.v_EnablePageSize != null) v_EnablePageSize = obj.v_EnablePageSize;
    if (obj.v_PageSizeText != null) v_PageSizeText = obj.v_PageSizeText;
    if (obj.v_PageSizeCellWidth != null) v_PageSizeCellWidth = obj.v_PageSizeCellWidth;
    if (obj.v_showFilterOnStart != null) v_ShowFilterOnStart = obj.v_showFilterOnStart;

    if (obj.v_enableSelect != null) v_EnableSelect = obj.v_enableSelect;
    if (obj.v_enableSort != null) v_EnableSort = obj.v_enableSort;
    if (obj.pageSize != null) pageSize = obj.pageSize;
    if (obj.v_enableViewState != null) v_EnableViewState = obj.v_enableViewState;
}
//Загрузка xslt-шаблона грида
function LoadXslt(filename) {
    v_Obj_Xslt.load(filename);
}
//Инициализация веб-сервиса и вызов веб-метода по извлечению данных
function InitGrid(notFill) {
    v_PageSizeText = LocalizedString('wgPageSizeText'); // Локализируем надпись

    v_data[4] = 0;        // номер первой строки 
    v_data[5] = pageSize; // устанавливаем размер страницы
    v_data[7] = 0;        // номер строки фильтра  
    //создаем объект веб-сервиса с именем = имени веб-метода
    document.getElementById(v_ServiceObjName).useService(v_ServiceName + "?wsdl", v_ServiceMethod);

    //В оновном обьекте создаем 2 подобьекта: для самой таблицы и для контролов.
    document.getElementById(v_ServiceObjName).insertBefore(document.createElement("<div id=oTable></div>"));
    document.getElementById(v_ServiceObjName).insertBefore(document.createElement("<div id=oControls></div>"));
    //Генерим контролы
    CreateControls();

    fnLoadViewState();

    if (v_ShowFilterOnStart) {
        // Если нет сохраненного фильтра на старте показывать окно фильтра
        if ((filter_array.length == 0 && v_data[20].length == 0) && (parent.isHist != null && parent.isHist == false)) {
            ShowFilterWindow();
            fnSaveViewState();
        }
    }
    //Вызов веб-метода
    if (notFill) return; //не загружать данные
    var srv = document.getElementById(v_ServiceObjName);
    var srv_obj = eval('srv.' + v_ServiceMethod);
    srv_obj.callService(onInitGrid, v_ServiceMethod, v_data);

}

function getGlobalObj() {
    var globalObj = null;
    if (parent) {
        if (parent.global_obj) {
            globalObj = parent.global_obj;
        } else if (parent.frames.length != 0 && parent.frames[0].document.getElementById("global_obj")) {
            globalObj = parent.frames[0].document.getElementById("global_obj");
        }
    }
    return globalObj;
}
//Типа ViewState. Все основные данные сохраняются в объекте верхнего фрейма
//barsweb в виде масива объектов, где ключом есть url страницы.
function fnLoadViewState() {
    var globalObj = getGlobalObj();
    if (v_EnableViewState && globalObj) {
        if (globalObj.value == null)
            globalObj.value = new Array();//если пустой, то инициализируем  
        view_state = globalObj.value;//достаем из фрейма obj
        var href = (location.hash == "") ? (location.href) : (location.href.substring(0, location.href.length - 1));
        if (view_state[href]) { //если по ключу есть данние, то вычитываем в основные переменные
            v_data[0] = view_state[href].data[0];
            v_data[1] = view_state[href].data[1];
            v_data[2] = view_state[href].data[2];
            v_data[3] = view_state[href].data[3];
            v_data[4] = view_state[href].data[4];
            if (view_state[href].data[5]) filter_list = view_state[href].data[5];
            filter_array = view_state[href].data[6];
            if (document.getElementById("lb_FilterText"))
                document.getElementById("lb_FilterText").innerHTML = view_state[href].data[7];
            v_data[20] = view_state[href].data[8];
        }
        else { //если нет, то создаем пустые экземпляры объектов
            view_state[href] = new Object();
            view_state[href].data = new Array();
            fnSaveViewState();
        }
    }
}

//Сохраняем состояние вида (аля SaveViewState)
function fnSaveViewState() {
    var globalObj = getGlobalObj();
    if (globalObj == null) return;
    var href = (location.hash == "") ? (location.href) : (location.href.substring(0, location.href.length - 1));
    view_state = globalObj.value;
    if (view_state == null) return;
    if (view_state[href]) {
        view_state[href].data[0] = v_data[0];
        view_state[href].data[1] = v_data[1];
        view_state[href].data[2] = v_data[2];
        view_state[href].data[3] = v_data[3];
        view_state[href].data[4] = v_data[4];
        if (document.getElementById("lbFilter"))
            view_state[href].data[5] = makeArrayOption(document.getElementById("lbFilter"));
        view_state[href].data[6] = filter_array;
        if (document.getElementById("lb_FilterText"))
            view_state[href].data[7] = document.getElementById("lb_FilterText").innerHTML;
        if (v_CustomViewState != null) eval(v_CustomViewState + '(view_state[href])');
        view_state[href].data[8] = v_data[20];
    }
    globalObj.value = view_state;//Запихиваем обратно в глобальний объект
}

function getViewStateParam(param) {
    var globalObj = getGlobalObj();
    if (globalObj == null || globalObj.value == null) return null;
    var href = (location.hash == "") ? (location.href) : (location.href.substring(0, location.href.length - 1));
    return globalObj.value[href][param];
    //return eval('parent.frames[0].document.getElementById("global_obj").value[href].'+param);
}
//Очищаем данные(нужно в случае возникновения ошибки)
function fnClearViewState() {
    var globalObj = getGlobalObj();
    if (v_EnableViewState && globalObj)
        globalObj.value = null;
}
function onInitGrid(result) {
    if (result.error) {
        fnClearViewState();

        if (window.dialogArguments) {
            //var xfaultcode   = result.errorDetail.code; 
            //var xfaultstring = result.errorDetail.string;
            //var xfaultsoap   = result.errorDetail.raw;
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
            //window.showModalDialog("dialog.aspx?type=4&message="+xfaultcode+"&source="+escape(xfaultstring)+"&trace="+xfaultsoap,"","dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        }
        else
            location.replace("dialog.aspx?type=err");
    }
    else if (!result.error) {
        returnServiceValue = result.value;
        v_Obj_Soap.loadXML(returnServiceValue[0].text);
        v_data[8] = returnServiceValue[1].text;
        //Функция,которая выполняется после получения даных
        RefreshGrid();
        if (v_ServiceFuncAfter != null) eval(v_ServiceFuncAfter + '()');
    }
    if (window.findls) {

        QuickFind();
        window.findls = false;
    }
}
function CreateControls() {
    //--------контролы которые будут помещены в footer грида----------
    //Добавляем пейджинг
    if (document.getElementById('tblFooter') == null) {
        var strFooterHTML = "<TABLE id='tblFooter' class='footer_body' cellSpacing='0' cellPadding='0' border='0' width='100%'>";
        strFooterHTML += "<TR>";
        if (v_ShowPager == true || v_ShowPager == "true") {
            strFooterHTML += "<TD align=" + v_alignPager + " width=" + v_PagerCellWidth + "><img id='aLeft' onclick='fnPrev()' title='" + LocalizedString('wgPrevPage') + "' src='/Common/WebGrid/aLeft.gif' class=pager_img><span id='PageNum' class=pager_num> 1 </span><img id='aRight' src='/Common/WebGrid/aRight.gif' title='" + LocalizedString('wgNextPage') + "' onclick='fnNext()' class=pager_img></TD>";
        }
        //Добавляем возможность изменения к-тво строк в гриде
        if (v_EnablePageSize == true || v_EnablePageSize == "true") {
            strFooterHTML += "<TD width=" + v_PageSizeCellWidth + "><DIV nowrap>" + v_PageSizeText + "&nbsp;<input type='text' id='edPageSize' class='footer_PageSize' title='" + LocalizedString('wgRowsInTable') + "' onkeypress='return KeyPressedOnEdit(event)' onchange='OnEditChanged()' value=" + pageSize + "></DIV></TD>";
        }
        strFooterHTML += "<TD></TD>";
        strFooterHTML += "</TR>";
        strFooterHTML += "</TABLE>";
        document.getElementById('oControls').innerHTML += strFooterHTML;
    }
    //--------контролы которые будут помещены в footer грида----------

    //Добавляем возможность выделять строки
    if (v_EnableSelect == true || v_EnableSelect == "true") {
        if (document.getElementById('o_id') == null) {
            document.body.insertBefore(document.createElement("<div id=o_id></div>"));
            document.getElementById('o_id').innerHTML = "<INPUT id=row_id type='hidden'>";
        }
    }
    //Добавляем возможность сортировки
    if (v_EnableSort == true || v_EnableSort == "true") {
        if (document.getElementById('sort_ord') == null) {
            document.body.insertBefore(document.createElement("<div id=sort_ord class=layer></div>"));
            document.getElementById('sort_ord').innerHTML = "<img title='" + LocalizedString('wgAscending') + "' onclick='fnSortAsc()' src='/Common/WebGrid/sort_asc.gif'><BR><img title='" + LocalizedString('wgDescending') + "' onclick='fnSortDesc()' src='/Common/WebGrid/sort_desc.gif'>";
        }
    }
}
//Refresh grid
function RefreshGrid() {
    document.getElementById('oTable').innerHTML = v_Obj_Soap.transformNode(v_Obj_Xslt.documentElement);
    if (v_ShowPager == true || v_ShowPager == "true") Pager();
    if (v_ServiceAfterRefresh != null) eval(v_ServiceAfterRefresh + '()');
}
//Перечитка данных для грида
function ReInitGrid(notFill) {
    if (notFill) return; //не загружать данные
    if (v_EnableViewState) fnSaveViewState();
    var srv = document.getElementById(v_ServiceObjName);
    var srv_obj = eval('srv.' + v_ServiceMethod);
    srv_obj.callService(onInitGrid, v_ServiceMethod, v_data);
}
/********************************************************************************
Изменение к-тва строк грида
********************************************************************************/
// ограничение ввода только цифрами (без знака минус и запятой)
function KeyPressedOnEdit(evt) {
    var charCode = getCharCode(evt);
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    if (charCode == 13) {
        var val = document.getElementById('edPageSize').value;
        while (val.charAt(0) == '0') val = val.substr(1)
        if (val == '') val = '10';
        document.getElementById('edPageSize').value = val;

        pageSize = new Number(val);
        v_data[5] = pageSize;
        v_data[4] = 0;

        ReInitGrid();

        return false;
    }

    return true;
}
// при изменении эдита
function OnEditChanged() {
    return;
    //var val = document.getElementById('edPageSize').value;
    //while (val.charAt(0) == '0') val = val.substr(1)
    //if (val == '') val = '10';
    //document.getElementById('edPageSize').value = val;

    //pageSize = new Number(val);
    //v_data[5] = pageSize;
    //v_data[4] = 0;

    //ReInitGrid();
}
// код нажатого символа
function getCharCode(evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : ((evt.which) ? evt.which : 0));

    return charCode;
}
/********************************************************************************
Пейджинг
********************************************************************************/
function Pager() {
    document.getElementById('aLeft').style.visibility = 'visible';
    document.getElementById('aRight').style.visibility = 'visible';
    if (v_data[4] == 0) document.getElementById('aLeft').style.visibility = 'hidden';
    if (v_data[8] < pageSize) document.getElementById('aRight').style.visibility = 'hidden';
    if (Math.ceil(v_data[8] / pageSize) == Math.ceil((v_data[4] + pageSize) / pageSize)) document.getElementById('aRight').style.visibility = 'hidden';
    document.getElementById("PageNum").innerText = " " + ((v_data[4] + pageSize) / pageSize) + " ";
}
//Пейджинг вперёд
function fnNext() {
    if (v_data[8] > pageSize && Math.ceil(v_data[8] / pageSize) != Math.ceil((v_data[4] + pageSize) / pageSize)) {
        v_data[4] = eval(v_data[4] + pageSize);
        ReInitGrid();
    }
}
//Пейджинг назад
function fnPrev() {
    if (v_data[4] != 0) {
        v_data[4] = eval(v_data[4] - pageSize);
        ReInitGrid();
    }
}
/********************************************************************************/

//Выделение строки
function SelectRow(val, id, mode) {
    if (mode != "" || mode != null) acces_mode = mode;
    if (selectedRow != null) selectedRow.style.backgroundColor = v_row_style;
    v_row_style = document.getElementById('r_' + id).style.backgroundColor;
    document.getElementById('r_' + id).style.backgroundColor = '#d3d3d3';
    selectedRow = document.getElementById('r_' + id);
    row_id = id;
    selectedRowId = val;
    document.getElementById("row_id").value = val;
    if (v_FuncOnSelect != null) eval(v_FuncOnSelect + '()');
}
//Нажатие клавиш
function KeyPress(alt) {
    var key = (alt) ? (alt) : (13);
    if (event.keyCode == 40) {
        if (document.getElementById('r_' + (row_id + 1)))
            SelectRow(document.getElementById('r_' + (row_id + 1)).value, row_id + 1);
    }
    else if (event.keyCode == 38) {
        if (document.getElementById('r_' + (row_id - 1)))
            SelectRow(document.getElementById('r_' + (row_id - 1)).value, row_id - 1);
    }
    else if (event.keyCode == key) {
        document.getElementById('r_' + row_id).fireEvent("ondblclick");
        event.cancleBubble = true;
        event.returnValue = false;
        return false;
    }
}
/********************************************************************************
Сортировка 
********************************************************************************/
// условия на страницы и поля, где можно сортировать
function canSort(colName) {
    return true;
    /*var isFilterSet = !(filter_array.length == 0 && v_data[20].length == 0 && v_data[1].length == 0);
    if (location.href.indexOf('checkinner') > 0 || location.href.indexOf('udeposit') > 0)
        return true;
    if (isFilterSet) {
        if (location.href.indexOf('documentsview') > 0 || location.href.indexOf('customerlist') > 0) 
            return true;
    }
	return false;*/
}

function Sort(val) {
    if (!canSort(val)) {
        alert("Сортування недоступне.");
        return;
    }
    sort_exp = val;
    sort_ord.style.left = event.clientX + document.body.scrollLeft;
    sort_ord.style.top = event.clientY;
    sort_ord.style.visibility = 'visible';
}
function fnSortAsc() {
    if (!canSort(sort_exp)) {
        alert("Сортування недоступне.");
        return;
    }
    v_data[3] = sort_exp + " ASC";
    ReInitGrid();
    sort_ord.style.visibility = 'hidden';
}
function fnSortDesc() {
    if (!canSort(sort_exp)) {
        alert("Сортування недоступне.");
        return;
    }
    v_data[3] = sort_exp + " DESC";
    ReInitGrid();
    sort_ord.style.visibility = 'hidden';
}
/********************************************************************************/

//Закрываем модальное окно и передаем выбранные параметры
function Read(id, val) {
    var array = new Array();
    array[0] = id; array[1] = val;
    document.close();
    window.close();
    window.returnValue = array;
}
//Устанавливаем в комбо-боксе выбранное из диалога значения
function SetDDlist(ddlist, url) {
    var result = window.showModalDialog(url, "", "dialogWidth:400px;center:yes;edge:sunken;help:no;status:no;");
    if (result != null) {
        if (ddlist.options.length == 0) {
            var oOption = document.createElement("OPTION");
            ddlist.options.add(oOption);
            oOption.innerText = result[1];
            oOption.value = result[0];
        }
        else {
            ddlist.options[0].value = result[0];
            ddlist.options[0].text = result[1];
        }
    }
}
function gridControlAddEvent(element, event, fn) {
    if (element.addEventListener) element.addEventListener(event, fn, false);
    else if (element.attachEvent) element.attachEvent('on' + event, fn);
    else { element['on' + event] = fn; }
}
function gridControlRemoveEventHandler(elem, eventType, handler) {
    if (elem.removeEventListener)
        elem.removeEventListener(eventType, handler, false);
    if (elem.detachEvent)
        elem['on' + eventType] = null;
    //elem.detachEvent('on' + eventType, handler);
}
function gridControlCheckDocNumber(element) {
    // ENTER пускаємо далі
    if (event.keyCode === 13) {
        return true;
    }


    var paramType = element.getAttribute('paramtype');

    var val = String.fromCharCode(event.keyCode);
    var valFull = element.value + val;

    // Ми щось виділили в TextBox - прибираємо перевірку на довжину
    if (document.selection.type == "Text") valFull = val;
    if (0 === val.length) return true;

	var rexp = new RegExp(/[0-9]/);
	var rexpNumFull = new RegExp(/^[0-9]*(\.[0-9]{0,2})?$/);
	var length = element.getAttribute('maxlength');

	if (paramType === 'N' && valFull.indexOf(".") > -1) {
		return rexpNumFull.test(valFull);
	}
	if (paramType === 'N' && !rexp.test(val) || (length && valFull.length > length)) {
		return false;
	}

    return true;
}
//---------------------------------------------------------------------
//Изменение стоки таблицы
function Edit(val, id) {
    if (accessmode != 1) return;
    if (document.getElementById('editTbl') == null) {
        document.body.insertBefore(document.createElement("<DIV class='edit_body' id='editTbl' style='WIDTH: 500px' align='center'>"));
        document.getElementById('editTbl').innerHTML = makeEditControls();
    }

    for (i = 0; i < v_editFields.length ; i++) {
        if (v_editFields[i].indexOf("dd") != -1) {
            document.getElementById(v_editFields[i]).options[0].value = document.getElementById(v_editFields[i] + "_" + id).value;
            document.getElementById(v_editFields[i]).options[0].text = document.getElementById(v_editFields[i] + "_" + id).innerHTML;
        } else {
            var element = document.getElementById(v_editFields[i] + "_" + id);
            var value = element.innerHTML;

            var control = document.getElementById(v_editFields[i]);
            control.value = value;

            var maxLength = element.getAttribute('maxlength');
            if (maxLength) {
                control.maxLength = maxLength;
            } else {
                control.maxLength = 300;
            }

            var paramType = element.getAttribute('paramtype');
            control.paramtype = paramType;
            gridControlAddEvent(control, 'keypress', function () {
                return gridControlCheckDocNumber(control);
            });
        }

    }
    var top = document.body.offsetHeight / 2 - 100;
    var left = document.body.offsetWidth / 2 - 250;
    editTbl.style.left = left;
    editTbl.style.top = top;
    editTbl.style.visibility = 'visible';
    return false;
}
function makeEditControls() {
    var params = v_Obj_Xslt.documentElement.childNodes[0].text;
    var value = "", text = "", controls = "<TABLE width='100%' border='1'>", ro, dd_id, dd_value, dd_name;
    for (i = 0; i < params.split(";").length ; i++) {
        text = params.split(";")[i].split("=")[1];
        ro = (text.substring(0, 1) == " ") ? ("disabled=true") : ("");
        value = params.split(";")[i].split("=")[0];
        //ddlist

        controls += "<TR><TD style='width:245px'><span class='edit_label'>" + text + "</span></TD><TD style='width:245px'>";
        if (value.substring(0, 1) == "[") {
            dd_id = value.substring(1, value.length - 1).split(":")[0];
            dd_value = value.substring(1, value.length - 1).split(":")[1];
            dd_name = value.substring(1, value.length - 1).split(":")[2];
            value = dd_name;
            controls += "<select style='width:100%' id=" + dd_name + " onclick='d_dlg(this)'><option value=''></option></select>";
        }
            //textbox
        else {
            controls += "<input style='width:100%' type=text " + ro + " id=" + value + ">";
        }
        controls += "</TD></TR>";
        v_editFields[i] = value;
    }
    controls += "</TABLE><div align=center><INPUT class='filter_bt' style='WIDTH: 100px' onclick='CloseEdit()' type='button' value='" + LocalizedString('wgSave') + "'><INPUT class='bt' style='WIDTH: 100px' onclick='CancelEdit()' type='button' value='" + LocalizedString('wgCancel') + "'></div>";
    return controls;
}
//
function CancelEdit()
{ editTbl.style.visibility = 'hidden'; }
//Изменнение значений
function CloseEdit() {
    if (v_FuncCheckValue != null) eval(v_FuncCheckValue + "()");
    var nodes = FindNode(selectedRowId), node_child;
    var node = nodes.childNodes;
    for (i = 0; i < v_editFields.length ; i++) {
        node_child = null;
        for (j = 0; j < node.length; j++) {
            if (node[j].nodeName == v_editFields[i] || node[j].nodeName == v_editFields[i].substring(2).toUpperCase()) node_child = node[j];
        }
        if (node_child == null) {
            node_child = v_Obj_Soap.createNode(1, v_editFields[i], '');
            nodes.appendChild(node_child);
        }
        if (v_editFields[i].indexOf("dd") != -1)
            node_child.text = document.getElementById(v_editFields[i]).options[0].text;
        else
            node_child.text = document.getElementById(v_editFields[i]).value;
    }
    RefreshGrid();
    editTbl.style.visibility = 'hidden';
}
//Добавляем стоку в таблицу
function AddRow(id, param) {
    if (document.getElementById('editTbl') == null) {
        document.body.insertBefore(document.createElement("<DIV class='edit_body' id='editTbl' style='WIDTH: 500px' align='center'>"));
        document.getElementById('editTbl').innerHTML = makeEditControls();
    }
    for (i = 0; i < v_editFields.length ; i++) {
        if (v_editFields[i].indexOf("dd") != -1)
            document.getElementById(v_editFields[i]).options[0].text = "";
        else
            document.getElementById(v_editFields[i]).value = "";
    }
    var top = document.body.offsetHeight / 2 - 100;
    var left = document.body.offsetWidth / 2 - 250;
    editTbl.style.left = left;
    editTbl.style.top = top;
    if (param == null) editTbl.style.visibility = 'visible';

    var node_base = v_Obj_Soap.createNode(1, 'Table', ''), node_child;
    if (id != null) {
        node_child = v_Obj_Soap.createNode(1, id, '');
        selectedRowId = "new" + row_new;
        node_child.text = selectedRowId;
        row_new++;
        node_base.appendChild(node_child);
    }
    var value = "";
    for (i = 0; i < v_editFields.length ; i++) {
        if (v_editFields[i].indexOf("dd") != -1)
            value = v_editFields[i].substring(2).toUpperCase();
        else
            value = v_editFields[i];
        node_child = v_Obj_Soap.createNode(1, value, '');
        node_base.appendChild(node_child);
    }
    v_Obj_Soap.documentElement.appendChild(node_base);
    RefreshGrid();
}
//Удаляем строку
function DelRow() {
    if (selectedRow == null) return;
    var node = FindNode(selectedRowId);
    if (v_FuncDelRow != null) eval(v_FuncDelRow + '(node)');
    v_Obj_Soap.documentElement.removeChild(node);
    RefreshGrid();
}
//Поиск xml-noda
function FindNode(val) {
    for (i = 0; i < v_Obj_Soap.documentElement.childNodes.length; i++) {
        if (v_Obj_Soap.documentElement.childNodes[i].childNodes[0].text == val)
            return v_Obj_Soap.documentElement.childNodes[i];
    }
}
/********************************************************************************
Работа с фильтром
********************************************************************************/
function InitFilter() {
    //document.getElementById('oFiltStatic').innerHTML = drawFilterElementStatic();
    // ddOperation.selectedIndex = 6;
}
function KeyPressFilter() {
    if (event.keyCode == 13) {
        fnApplyFilter(true);
        document.getElementById("tbValue").focus();
        document.getElementById("tbValue").select();
    }
    else if (event.keyCode == 27) fnAllLines(true);
}
//
function ShowModalFilter() {
    if (ShowFilterWindow()) {
        if (v_FuncFilterBefore != null) eval(v_FuncFilterBefore + '()');
        ReInitGrid(v_NotFill);
    }
    if (v_FuncFilter != null) eval(v_FuncFilter + '()');
}
//Показать фильтр
function ShowFilter() {
    if (v_ShowFilterOnStart) {
        if (ShowFilterWindow()) ReInitGrid();
        if (v_FuncFilter != null) eval(v_FuncFilter + '()');
    }
    else {
        if (document.getElementById('filter') == null) {
            document.body.insertBefore(document.createElement("<DIV class='layer' id='filter' style='WIDTH: 350px' align='center' onkeydown='fnEnterFilter()'>"));
            if (document.getElementById("header_row"))
                document.getElementById('filter').innerHTML = drawFilterElement('meta');
            else
                document.getElementById('filter').innerHTML = drawFilterElement();
            if (filter_list.length != 0) makeOptionsFromArray(document.getElementById("lbFilter"), filter_list);
            ddOperation.selectedIndex = 6;
        }
        var left = document.body.offsetWidth / 2 - 180 + document.body.scrollLeft;
        var top = document.body.offsetHeight / 2 - 180;
        filter.style.left = left;
        filter.style.top = top;
        filter.style.visibility = 'visible';
        document.getElementById("tbValue").value = "";
        document.getElementById("tbValue").focus();
    }
}
function fnEnterFilter() {
    if (event.keyCode == 13) fnApplyFilter();
    else if (event.keyCode == 27) fnFilterCancel();
}
function GetOperation(index) {
    switch (index) {
        case '1': return '='; break;
        case '2': return '&lt;'; break;
        case '3': return '&lt;='; break;
        case '4': return '&gt;'; break;
        case '5': return '&gt;='; break;
        case '6': return '&lt;&gt;'; break;
        case '7': return 'LIKE'; break;
        case '8': return 'NOT LIKE'; break;
        case '9': return 'IS NULL'; break;
        case '10': return 'IS NOT NULL'; break;
        case '11': return 'IN'; break;
        case '12': return 'NOT IN'; break;
    }
}
function GetOperand(index) {
    switch (index) {
        case '1': return 'AND'; break;
        case '2': return 'OR'; break;
        case '3': return '('; break;
        case '4': return ')'; break;
        case '5': return ' '; break;
    }
}
function ShowFilterWindow() {
    var add = "&" + Math.random();
    var result = window.showModalDialog("/barsroot/webservices/filter.aspx?table=" + v_FilterTable + add, window, "dialogWidth:630px;dialogHeight:480px;center:yes;edge:sunken;help:no;status:no;scroll:no");
    var str = "";
    if (result != null) {
        if (result["SYS"]) str += "[SYS:" + result["SYS"] + "] ";
        if (result["USER"]) str += "[USER:" + result["USER"] + "] ";
        v_data[20] = str;
        v_data[0] = "";
        v_data[4] = 0;
        var array = result["FILT"];
        filter_array = array;
        if (array != null && array.length > 0) {
            v_data[0] = " AND (";
            for (i = 0; i < array.length; i++) {
                var obj = array[i];
                var line_filter = "";
                var field = (obj.attr.split(';').length > 1) ? (obj.attr.split(';')[0]) : ("");
                var case_sens = (obj.attr.split(';').length > 1) ? (obj.attr.split(';')[1]) : ("0");
                var type = (obj.attr.split(';').length > 1) ? (obj.attr.split(';')[2]) : ("");
                //if (obj.op == '4') {
                //    v_data[0] += " ) ";
                //    continue;
                //}
                if (obj.op && !obj.attr && !obj.sign && !obj.val) {

                    v_data[0] += ' ' + GetOperand(obj.op) + ' ';
                    continue;
                }
                line_filter += GetOperand(obj.op) + " ";
                var value = "";
                for (j = 0; j < obj.val.length; j++) {
                    if (obj.val.charAt(j) == '*') value += '%';
                    else if (obj.val.charAt(j) == '?') value += '_';
                    else if (obj.val.charAt(j) == ' ') value += '__space__';
                    else value += obj.val.charAt(j);
                }
                if (obj.attr.split(';').length == 3) {
                    // поле не чуствительно к регистру
                    if (case_sens == "0" && type == "C") {
                        line_filter += 'UPPER($ALIAS$.' + field + ') ';
                        value = value.toUpperCase();
                    }
                    else
                        line_filter += '$ALIAS$.' + field + ' ';

                    line_filter += GetOperation(obj.sign);
                    if (obj.sign != '9' && obj.sign != '10') {
                        line_filter += ' :';
                        if (obj.sign == '11' || obj.sign == '12') line_filter += 'L';
                        else line_filter += type;
                        line_filter += 'param_' + i + '[' + value + '] ';
                    }
                }
                else {
                    var tabname = obj.attr.split(';')[3];
                    //var rel1 = obj.attr.split(';')[4];
                    // var rel2 = obj.attr.split(';')[5];
                    if (case_sens == "0" && type == "C") {
                        line_filter += 'UPPER(' + tabname + "." + field + ') ';
                        value = value.toUpperCase();
                    }
                    else
                        line_filter += tabname + '.' + field + ' ';

                    line_filter += GetOperation(obj.sign);
                    line_filter += ' @' + tabname;
                    if (obj.sign != '9' && obj.sign != '10') {
                        line_filter += ' :';
                        if (obj.sign == '11' || obj.sign == '12') line_filter += 'L';
                        else line_filter += type;
                        line_filter += 'param_' + i + '[' + value + '] ';
                    }
                    //line_filter += ' AND ' + tabname + '.' + rel2 + '(+)=$ALIAS$.' + rel1 + " ";
                    var arr = obj.attr.split(";");
                    for (var j = 4; j < arr.length; j += 2) {
                        line_filter += ' AND ' + tabname + '.' + arr[j + 1] + '(+)=$ALIAS$.' + arr[j] + " ";
                    }
                }

                /*if ((line_filter.indexOf('$ALIAS$.OST') > 0) && obj.sign != "2" && obj.sign != "3" ) {
                    line_filter = line_filter.replace('$ALIAS$.OSTC', 'ABS($ALIAS$.OSTC)');
                    line_filter = line_filter.replace('$ALIAS$.OSTB', 'ABS($ALIAS$.OSTB)');
                    line_filter = line_filter.replace('$ALIAS$.OSTF', 'ABS($ALIAS$.OSTF)');
                }*/

                v_data[0] += line_filter;
            }
            v_data[0] += " )";
        }
        return true;
    }
    else return false;
}
//Отфильтровать
function fnApplyFilter(f_static) {
    var ddAtr = document.getElementById("ddAtributes");
    var ddOp = document.getElementById("ddOperation");
    var value = document.getElementById("tbValue").value;
    var oOption = document.createElement("OPTION");
    var oper_index = ddOp.options[ddOp.selectedIndex].value;
    oOption.text = 'И ' + ddAtributes.options[ddAtributes.selectedIndex].text + ' ' + ddOp.options[ddOp.selectedIndex].text;
    if (oper_index != '9' && oper_index != '10')
        oOption.text += ' ' + value;
    oOption.value = v_data[7];
    v_data[0] = ddAtr.options[ddAtr.selectedIndex].value + ';' + value;
    var curr_filter = "";
    var desc_filter = ddAtr.options[ddAtr.selectedIndex].value;
    var length = desc_filter.split(';').length;
    var tmp_value = "";
    for (i = 0; i < value.length; i++) {
        if (value.charAt(i) == '*') tmp_value += '%';
        else if (value.charAt(i) == '?') tmp_value += '_';
        else tmp_value += value.charAt(i);
    }
    value = tmp_value;
    if (length == 2) {
        curr_filter += ' AND ';
        if (oper_index == '7' || oper_index == '8') //LIKE
            curr_filter += 'UPPER(' + desc_filter.split(';')[0] + ') ';
        else
            curr_filter += desc_filter.split(';')[0] + ' ';
        curr_filter += GetOperation(oper_index);//operation
        if (oper_index != '9' && oper_index != '10') {//если не NULL и NOT NULL
            curr_filter += ' :';
            if (oper_index == 11 || oper_index == 12)
                curr_filter += 'L';
            else
                curr_filter += desc_filter.split(';')[1];
            curr_filter += 'param_' + v_data[7] + '[' + value + ']';
        }
    }
    else {
        var tabname = desc_filter.split(';')[2];
        var rel1 = desc_filter.split(';')[3];
        var rel2 = desc_filter.split(';')[4];
        curr_filter = ' AND ';
        if (oper_index == '7' || oper_index == '8') //LIKE
            curr_filter += 'UPPER(' + tabname + '.' + desc_filter.split(';')[0] + ') ';
        else
            curr_filter += tabname + '.' + desc_filter.split(';')[0] + ' ';
        curr_filter += GetOperation(ddOp.options[ddOp.selectedIndex].value);
        curr_filter += ' @' + tabname;
        if (oper_index != '9' && oper_index != '10') {//если не NULL и NOT NULL
            curr_filter += ' :' + desc_filter.split(';')[1]
            curr_filter += 'param_' + v_data[7] + '[' + value + ']';
        }
        curr_filter += ' AND ' + tabname + '.' + rel1 + '(+)=' + rel2;
    }
    filter_array[filter_array.length] = curr_filter;
    v_data[0] = ArrayToString(filter_array);
    v_data[4] = 0; v_data[7] += 1;
    if (f_static == null) {
        document.getElementById("lbFilter").add(oOption);
        filter.style.visibility = 'hidden';
    }
    else {
        if (document.getElementById("lb_FilterText") == null) return;
        if (document.getElementById("lb_FilterText").innerHTML == "")
            document.getElementById("lb_FilterText").innerHTML = "<b style='color: red'>" + oOption.text.substring(2) + "</b>";
        else document.getElementById("lb_FilterText").innerHTML += " и " + "<b style='color: red'>" + oOption.text.substring(2) + "</b>";
    }
    if (v_FuncFilter != null) eval(v_FuncFilter + '()');
    ReInitGrid();
}
//---------------------------------------------------------------------
//Удалить строку из фильтра
function fn1Line() {
    if (document.getElementById("lbFilter").options.length == 0) return;
    document.getElementById("lbFilter").selectedIndex = 0;
    v_data[0] = "";
    filter_array[document.getElementById("lbFilter").options[document.getElementById("lbFilter").selectedIndex].value] = "";
    document.getElementById("lbFilter").options.remove(document.getElementById("lbFilter").selectedIndex);
    for (i = 0; i < filter_array.length; i++)
        v_data[0] += filter_array[i] + " ";
    if (v_FuncFilter != null) eval(v_FuncFilter + '()');
    //ReInitGrid();
    //filter.style.visibility='hidden';
}
//---------------------------------------------------------------------
//Удалить все строки фильтра
function fnAllLines(f_static) {
    v_data[0] = "";
    v_data[4] = 0;
    v_data[7] = 0;
    filter_array = new Array();
    if (f_static == null) {
        for (i = document.getElementById("lbFilter").options.length; i > 0; i--) {
            document.getElementById("lbFilter").options.remove(i - 1);
        }
        filter.style.visibility = 'hidden';
    }
    else {
        if (document.getElementById("lb_FilterText"))
            document.getElementById("lb_FilterText").innerHTML = "";
    }
    if (v_FuncFilter != null) eval(v_FuncFilter + '()');
    ReInitGrid();
}
//---------------------------------------------------------------------
//Закрить окно фильтра
function fnFilterCancel() {
    filter.style.visibility = 'hidden';
}
//Вычитка из хмл-файла возможных значений фильтра
function XmlReaderFilter() {
    var option = "", value, text, from, colname, tag, coltype, tabname, rel1, rel2;
    if (v_XmlFilenameFilter == null) {
        return option;
    }
    else {
        v_Xml_Filter.load(v_XmlFilenameFilter);
        var node_col_native = v_Xml_Filter.documentElement.childNodes.item(0);
        colname = node_col_native.getElementsByTagName("COLNAME");
        tag = node_col_native.getElementsByTagName("TAG");
        coltype = node_col_native.getElementsByTagName("COLTYPE");
        for (i = 0; i < colname.length ; i++) {
            option += "<option value='" + colname.item(i).text + ';' + coltype.item(i).text + "'>" + tag.item(i).text + "</option>";
        }
        var node_col_relative = v_Xml_Filter.documentElement.childNodes.item(1);
        if (node_col_relative == null) return option;
        colname = node_col_relative.getElementsByTagName("COLNAME");
        tag = node_col_relative.getElementsByTagName("TAG");
        coltype = node_col_relative.getElementsByTagName("COLTYPE");
        tabname = node_col_relative.getElementsByTagName("TABNAME");
        rel1 = node_col_relative.getElementsByTagName("COLNAME_REL_1");
        rel2 = node_col_relative.getElementsByTagName("COLNAME_REL_2");
        for (i = 0; i < colname.length ; i++) {
            option += "<option value='" + colname.item(i).text + ';' + coltype.item(i).text + ';' + tabname.item(i).text + ';' + rel1.item(i).text + ';' + rel2.item(i).text + "'>" + tag.item(i).text + "</option>";
        }
        return option;
    }
}
function optionMetaFilter() {
    var row = document.getElementById("header_row");
    var option = "";
    for (i = 1; i < row.innerHTML.split('">').length; i++) {
        option += "<option value='COL" + i + ";C'>" + row.innerHTML.split('">')[i].substring(0, row.innerHTML.split('">')[i].indexOf('</TD>')) + "</option>";
    }
    return option;
}
//Создаем елемент фильтра 
function drawFilterElement(meta) {
    var option = "";
    if (meta) option = optionMetaFilter();
    else option = XmlReaderFilter();
    var draw_filter = "<div class=filter_title>" + LocalizedString('wgFilter') + "</div>" +
    "<TABLE cellSpacing=1 cellPadding=1 width='100%' border='0'>" +
    "<TR><TD align='center' class=filter_fields>" + LocalizedString('wgAttribute') + "</TD>" +
    "<TD align='center' class=filter_fields>" + LocalizedString('wgOperator') + "</TD>" +
    "</TR><TR><TD width='70%'><select class=filter_dd id='ddAtributes'>" + option +
    "</select></TD><TD><select id='ddOperation' class=filter_dd>" +
    "<option value='1'>=</option><option value='2'>&lt;</option>" +
    "<option value='3'>&lt;=</option><option value='4'>&gt;</option>" +
    "<option value='5'>&gt;=</option><option value='6'>&lt;&gt;</option>" +
    "<option value='7'>" + LocalizedString('wgLike') + "</option><option value='8'>" + LocalizedString('wgNotLike') + "</option>" +
    "<option value='9'>" + LocalizedString('wgIsNull') + "</option><option value='10'>" + LocalizedString('wgIsNotNull') + "</option>" +
    "<option value='11'>" + LocalizedString('wgOneOf') + "</option><option value='12'>" + LocalizedString('wgNotOneOf') + "</option>" +
    "</select></TD></TR></TABLE>" +
    "<div><span class=filter_fields>" + LocalizedString('wgValue') + "</span><input class=filter_val type='text' id='tbValue' /></div>" +
    "<INPUT class='filter_bt' id='F_Go' onclick='fnApplyFilter()' type='button' value='" + LocalizedString('wgApply') + "'>&nbsp;<input class='filter_bt' id='f_c' onclick='fnFilterCancel()' type='button'" +
    "value='" + LocalizedString('wgFilterCancel') + "'><BR><span class=filter_cur>" + LocalizedString('wgCurrentFilter') + "<span><BR>" +
    "<select size='3' id='lbFilter' class=filter_list></select>" +
    "<BR><INPUT class='filter_bt' id='F_Clear_Line' onclick='fn1Line()' type='button' value='" + LocalizedString('wgDeleteRow') + "'>&nbsp;" +
    "<INPUT class='filter_bt' id='F_Clear' onclick='fnAllLines()' type='button' value='" + LocalizedString('wgDeleteAll') + "'>";
    return draw_filter;
}
function drawFilterElementStatic() {
    var option = XmlReaderFilter();
    var draw_filter = "<TABLE cellSpacing=1 cellPadding=1 border='0'>" +
    "<TR><TD><select id='ddAtributes' class=s_filter_atr>" + option +
    "</select></TD><TD><select id='ddOperation' class=s_filter_op>" +
    "<option value='1'>=</option><option value='2'>&lt;</option>" +
    "<option value='3'>&lt;=</option><option value='4'>&gt;</option>" +
    "<option value='5'>&gt;=</option><option value='6'>&lt;&gt;</option>" +
    "<option value='7'>похож</option><option value='8'>не похож</option>" +
    "<option value='9'>пустой</option><option value='10'>не пустой</option>" +
    "<option value='11'>один из</option><option value='12'>ни один из</option>" +
    "</select></TD><TD><span class=s_filter_lb>Значение</span></TD><TD><input class=s_filter_val type='text' id='tbValue' onkeydown='KeyPressFilter()'/></TD>" +
    "<TD><INPUT class=s_filter_ok onclick='fnApplyFilter(true)' type='button' value='Принять'></TD>" +
    "<TD><input class=s_filter_cancel onclick='fnAllLines(true)' type='button' value='Отменить'></TD></TR></TABLE>";
    return draw_filter;
}
/********************************************************************************
Контекстное меню
********************************************************************************/
function ShowPopupMenu() {
	if (document.getElementById('popupmenu') == null) {
        document.body.insertBefore(document.createElement("<div id='popupmenu' style='visibility:hidden;POSITION: absolute'>"));
        document.getElementById('popupmenu').innerHTML = MakePopupMenu();
    }
    popupmenu.style.left = (event.x < popupmenu.style.width ? popupmenu.style.width : event.x) + document.body.scrollLeft;
    popupmenu.style.top = event.y;
    popupmenu.style.visibility = 'visible';
}
function ShowPopupMenu4Docs(){
	if (document.getElementById('popupmenu') == null) {
        document.body.insertBefore(document.createElement("<div id='popupmenu' style='visibility:hidden;POSITION: absolute'>"));
        document.getElementById('popupmenu').innerHTML = MakePopupMenu();
    }
	if(selectedRowId){
		popupmenu.style.top = selectedRow.offsetTop+85;
	}
	else
	{
		popupmenu.style.top = event.y;
	}
	//('.menu_body').width = 200 in webgrid/grid.css
	//document.getElementById('applist').width = 195

	popupmenu.style.left = (event.x + 200 > document.body.clientWidth - 200) ? document.body.clientWidth - 200 : event.x + 195 ;

    popupmenu.style.visibility = 'visible';
}
//-------------------------------------------------------------------------------
function MakePopupMenu() {
    var result = "<div class=menu_body>";
    var item = "<div UNSELECTABLE='on' class=menu_item onmouseover=\"this.style.background='#ffffff'\" onmouseout=\"this.style.background='#cccccc'\" onclick='#func'>#item_name</div>";
    if (v_FilterInMenu == true || v_FilterInMenu == "true")
        result += item.replace("#func", "ShowFilter();HidePopupMenu()").replace("#item_name", LocalizedString('wgSetFilter'));
    result += item.replace("#func", "fnNext()").replace("#item_name", LocalizedString('wgNextPage'));
    result += item.replace("#func", "fnPrev()").replace("#item_name", LocalizedString('wgPrevPage'));
    result += "<hr>";
    for (key in v_MenuItems) {
        result += item.replace("#func", v_MenuItems[key]).replace("#item_name", key);
    }
    result += "</div>";
    return result;
}
//-------------------------------------------------------------------------------
function HidePopupMenu() {
    if (document.getElementById('popupmenu') != null)
        popupmenu.style.visibility = 'hidden';
}
/********************************************************************************
Вспомогательные функции
********************************************************************************/
function makeArrayOption(ddlist) {
    var result = new Array();
    for (i = 0; i < ddlist.options.length; i++)
        result[ddlist.options[i].value] = ddlist.options[i].text;
    return result;
}
//-------------------------------------------------------------------------------
function makeOptionsFromArray(ddlist, array) {
    for (key in array) {
        var oOption = document.createElement("OPTION");
        ddlist.options.add(oOption);
        oOption.innerText = array[key];
        oOption.value = key;
    }
}
//-------------------------------------------------------------------------------
function ArrayToString(array) {
    var result = '';
    for (key in array) {
        result += ' ' + array[key];
    }
    return result;
}
//-------------------------------------------------------------------------------
// Подсчет суммы ячеек выделенных строк (по столбцам)
function insertXslRowSelectionTooltip(jQuery) {
    var selectionPivot;
    // 1 for left button, 2 for middle, and 3 for right.
    var LEFT_MOUSE_BUTTON = 1;
    var trs = $("tr[id^='r_']"); //table.children("tbody").children("tr");
    var cells = trs.children("td");

    cells.each(function (idx, cell) {
        $(cell).mouseover(function (event) {
            var res = calcSelColSum(cell);
            if ("none" == res) return;
            cell.title = res.columnSum;
        });
    });


    trs.each(function (idx, tRow) {

        $(tRow).mouseup(function (event) {
            if (event.which != LEFT_MOUSE_BUTTON) {
                return;
            }

            var selRange;
            if (window.getSelection) {  // all browsers, except IE before version 9
                selRange = window.getSelection();
            }
            else {
                if (document.selection) {        // Internet Explorer
                    var selRange = document.selection.createRange();
                }
            }

            var row = trs[idx];
            if (selectionPivot && selectionPivot.rowIndex != row.rowIndex) {
                selectRowsBetweenIndexes(selectionPivot.rowIndex, row.rowIndex);
                if (selRange.removeAllRanges) {
                    selRange.removeAllRanges();
                } else if (document.selection.empty) {
                    document.selection.empty();
                }
            }
        });

        $(tRow).mousedown(function (event) {
            if (event.which != LEFT_MOUSE_BUTTON) {
                clearAll();
                return;
            }
            var row = trs[idx];
            if (!event.ctrlKey && !event.shiftKey) {
                clearAll();
                toggleRow(row);
                selectionPivot = row;
                return;
            }
            if (event.ctrlKey && event.shiftKey) {
                selectRowsBetweenIndexes(selectionPivot.rowIndex, row.rowIndex);
                return;
            }
            if (event.ctrlKey) {
                toggleRow(row);
                selectionPivot = row;
            }
            if (event.shiftKey) {
                event.preventDefault();
                clearAll();
                selectRowsBetweenIndexes(selectionPivot.rowIndex, row.rowIndex);
            }
        });
    });

    function toggleRow(row) {
        row.className = row.className == 'selected' ? '' : 'selected';
    }

    function selectRowsBetweenIndexes(ia, ib) {
        var bot = Math.min(ia, ib);
        var top = Math.max(ia, ib);

        for (var i = bot; i <= top; i++) {
            trs[i - 1].className = 'selected';
        }
    }

    function clearAll() {
        for (var i = 0; i < trs.length; i++) {
            trs[i].className = '';
            for (var j = 0; j < trs[i].cells.length; j++) {
                trs[i].cells[j].title = '';
            }
        }
    }

    function calcSelColSum(cell) {

        if ("selected" != cell.parentNode.className) {
            return "none";
        }
        var trsSel = $("tr.selected[id^='r_']");// table.children("tbody").children("tr.selected");
        if (trsSel.length === 1) {
            return "none";
        }

        var title = $("tr[align=center]").children()[cell.cellIndex].innerHTML;
        var columnSum;
        if (!$.isNumeric(cell.innerText.replace(/ /g, ""))) {
            columnSum = "Дані цього стовпчика не сумуються";
            return { "columnName": title, "columnSum": columnSum };
        } else {
            var selectedCellsInColumnValues = trsSel.map(function (i, trSel) {
                var val = $(trSel).children()[cell.cellIndex].innerText.replace(/ /g, "");
                if ($.isNumeric(val)) {
                    return +val;
                }
            });

            if (trsSel.length != selectedCellsInColumnValues.length) {
                columnSum = "Дані цього стовпчика не сумуються";
                return { "columnName": title, "columnSum": columnSum };
            } else {
                var sum = 0;
                for (var i = 0; i < selectedCellsInColumnValues.length; i++) {
                    sum += selectedCellsInColumnValues[i];
                }
                columnSum = "Cума виділених елементів стовчика:\n" + sum.toFixed(2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
                return { "columnName": title, "columnSum": columnSum };
            }
        }
    }
}