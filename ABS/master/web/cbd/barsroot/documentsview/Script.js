// разбор аргументов командной строки
function getArgs() 
{
  var args = new Object();
  var query = location.search.substring(1).toLowerCase();
  var pairs = query.split("&");
  for(var i=0; i<pairs.length; i++){
    var pos = pairs[i].indexOf('=');
    if(-1==pos) continue;
    var argname = pairs[i].substring(0,pos);
    var value = pairs[i].substring(pos+1);
    args[argname] = unescape(value);
  }
  return args;  
}

function InitDocuments()
{
    //Локализация
    LocalizeHtmlTitles();
    
    LoadXslt("Data_" + getCurrentPageLanguage() + ".xsl");
	v_data[3] = 'REF DESC';//order
	
	var Params = unescape(location.search.substring(1,location.search.length));
	var args = getArgs();
	
	//default filter
	v_data[1] = "";
	v_data[10] = null;

	//-- просмотр документов отд/полз
	v_data[12] = args.type;
	
	if(args.par.charAt(1) == '1') 
	{
		document.getElementById("lb_DocTitles").innerText = LocalizedString('Message1');
		if(args.type == '0') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message2');
		v_data[11] = "V_DOCS_TOBO_OUT";}		
		if(args.type == '1') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message3');
		v_data[11] = "V_DOCS_USER_OUT";}
		if(args.type == '2') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message9');
		v_data[11] = "V_DOCS_SALDO";}
	}
	if(args.par.charAt(1) == '2') 
	{
		document.getElementById("lb_DocTitles").innerText = LocalizedString('Message4');
		if(args.type == '0') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message2');
		v_data[11] = "V_DOCS_TOBO_IN";}
		if(args.type == '1') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message3');
		v_data[11] = "V_DOCS_USER_IN";}
		if(args.type == '2') {document.getElementById("lb_DocTitles").innerText += LocalizedString('Message9');
		v_data[11] = "V_DOCS_SALDO";}
	}

	if(args.par.charAt(0) == '1') document.getElementById("lb_DocTitles").innerText += LocalizedString('Message5');
	if(args.par.charAt(0) == '2') {
	    if (null == args.date && null == args.dateb && null == args.datef)
		{
			alert(LocalizedString('Message6'));
			return;
        }
        if (args.dateb && args.datef) {
            v_data[9] = args.dateb;
            v_data[10] = args.datef;
            document.getElementById("lb_DocTitles").innerText += LocalizedString('Message7') + v_data[9] + " по " + v_data[10] + " :";
        }
        else {
            v_data[9] = "";
            v_data[10] = args.date;
            document.getElementById("lb_DocTitles").innerText += LocalizedString('Message7') + v_data[10] + " : ";
        }
		
		
	}
	
	var obj = new Object();
	obj.v_serviceObjName = 'webService';
	obj.v_serviceName = 'Service.asmx';
	obj.v_serviceMethod = 'GetData';
	obj.v_serviceFuncAfter = "LoadDocuments";
	var menu = new Array();
	menu[LocalizedString('Message8')] = "OpenDoc()";
	menu[LocalizedString('Message10')] = "CreateSameDocument()";
	menu["Редагувати дод. реквізити"] = "EditProps()";
	obj.v_menuItems = menu;
	obj.v_filterInMenu = false;
	obj.v_enableViewState = true; //включаем ViewState
	obj.v_alignPager = "left";//пейджинг слева
	
	obj.v_showFilterOnStart = true;
	obj.v_filterTable = "oper";

	fn_InitVariables(obj);	
	InitGrid();

    /*для друку документів*/
	var port = (location.port != "") ? (":" + location.port) : ("");
	document.all.webService.useService(location.protocol + "//" + location.hostname + port + "/barsroot/docinput/DocService.asmx?wsdl", "Doc");
	var printTrnModel = getCookie("prnModel");
	if (printTrnModel) {
	    document.getElementById("cbPrintTrnModel").checked = (printTrnModel == 1) ? (true) : (false);
	}
	
}
function getCookie(par) {
    var pageCookie = document.cookie;
    var pos = pageCookie.indexOf(par + '=');
    if (pos != -1) {
        var start = pos + par.length + 1;
        var end = pageCookie.indexOf(';', start);
        if (end == -1) end = pageCookie.length;
        var value = pageCookie.substring(start, end);
        value = unescape(value);
        return value;
    }
}
/*******************************/
var arrayForPrint = new Array();//масив з референсами відмічених документів
function addCheckbox() {
    arrayForPrint.splice(0, arrayForPrint.length);
    $('#printPanel').hide();
}
function editArrayForPrint(elem,ref) {
    ref = $(elem).attr('data-ref');
    if ($(elem).prop('checked')) {
        arrayForPrint.push(ref);
    }
    else {
        $('#mainChBox').removeAttr('checked');
        var num = -1;
        for (var i=0; i < arrayForPrint.length; i++) {
            if (arrayForPrint[i] == ref) {
                num = i;
            }
        }
        if (num != -1) {
            arrayForPrint.splice(num,1)
        }
    }
    if (arrayForPrint.length > 0) {
        $('#printPanel').show();
    }
    else {
        $('#printPanel').hide();
    }
}
function selAllCheckbox(elem) {
    arrayForPrint.splice(0, arrayForPrint.length);
    if ($(elem).prop('checked')) {
        var allChBox = $('#oTable tr td input[type="checkbox"]');
        allChBox.attr('checked', 'checked');
        allChBox.each(function (index, elem) {
            if (index > 0) {
                var ref = $(elem).attr('data-ref');
                if (ref) arrayForPrint.push(ref);
            }
        });
        if (arrayForPrint.length > 0) $('#printPanel').show();
    }
    else {
        $('#oTable tr td input[type="checkbox"]').removeAttr('checked');        
        $('#printPanel').hide();
    }
}
function printSelDocum() {
  if (arrayForPrint.length > 0)
    getTicketFile(arrayForPrint);
  return false;
}
function getTicketFile(ref) {
    if ("" != ref)
      document.all.webService.Doc.callService(onPrint, "GetArrayFileForPrint", ref, document.getElementById("cbPrintTrnModel").checked);
    return false;
}
function onPrint(result) {
    if (!getError(result)) return;
    var arrPatch = result.value.split('~~$$~~');
    for (var i = 0; i < arrPatch.length; i++) {
      barsie$print(arrPatch[i]);
    }
}
function getError(result, modal) {
    if (result.error) {
        if (window.dialogArguments || parent.frames.length == 0 || modal) {
            window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
        }
        else
            location.replace("dialog.aspx?type=err");
        return false;
    }
    return true;
}





 //Продублировать документ
 function CreateSameDocument()
 {
     location.replace("/barsroot/docinput/docinput.aspx?tt=" + escape(selectedRow.tt) + "&refDoc=" + selectedRowId);
 }
 //Load Default.aspx
 function LoadDocuments()
 {
     addCheckbox();
	//--empty--
 }
 //открываем карточку документа
 function OpenDoc(ref, winName) {
    var target = typeof winName !== 'undefined' ? winName : '_self';
    if(ref == null) ref = selectedRowId;
    window.open("/barsroot/documentview/default.aspx?ref=" + ref, target, true);
 }

 function EditProps() {
     window.showModalDialog("/barsroot/docinput/editprops.aspx?ref=" + selectedRowId, "", "dialogHeight:700px;dialogWidth:1280px;center:yes;edge:sunken;help:no;status:no;");
 }

//--рефреш
function RefreshButtonPressed()
{
	ReInitGrid();
}
//--фильтр--
function FilterButtonPressed()
{
	ShowFilter();
}
//Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("bt_Filter");
    LocalizeHtmlTitle("bt_Refresh");
}