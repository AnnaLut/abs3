var type = 1;
		
var sysObj = new Object();
sysObj.selectedRow = null;
sysObj.selectedRowId = null;

var usrObj = new Object();
usrObj.selectedRow = null;
usrObj.selectedRowId = null;

var custObj = new Object();
custObj.selectedRow = null;
custObj.selectedRowId = null;

window.onload = function(){
	if(document.all.sysIs.value != "1"){
		document.all.btSysFilter.disabled = true;
		Switch(2);
	}
	else Switch(1);
	if(document.all.usrIs.value != "1"){
		document.all.btUserFilter.disabled = true;
		if(document.all.sysIs.value != "1")
			Switch(3);
		else Switch(1);	
	}
	var port = (location.port != "")?(":"+location.port):("");
	webService.useService(location.protocol +"//"+ location.hostname + port +"/barsroot/webservices/WebServices.asmx?wsdl","Srv");
	RestoreFilter();
	//Localization type operation
	document.all.op.options[0].text = LocalizedString('OpAND');
	document.all.op.options[1].text = LocalizedString('OpOr');
	
	document.all.sign.options[6].text = LocalizedString('Sign1');
	document.all.sign.options[7].text = LocalizedString('Sign2');
	document.all.sign.options[8].text = LocalizedString('Sign3');
	document.all.sign.options[9].text = LocalizedString('Sign4');
	document.all.sign.options[10].text = LocalizedString('Sign5');
	document.all.sign.options[11].text = LocalizedString('Sign6');
	
	AddRow();
}

function KeyDown()
{
 if(event.keyCode == 13){
   if(event.srcElement.id == "val")
		Set(event.srcElement);
   Apply();
 }  
 else if(event.keyCode == 27)
   Cancel();
}

function RestoreFilter()
{
 var mainWnd = window.dialogArguments;
 if(mainWnd){
	var filter = mainWnd.v_data[20];
	var pos = 0;
	if((pos=filter.indexOf("[SYS:")) >=0){
		idSys = filter.substring(pos+5,filter.indexOf("]",pos+5));
		Sel_Sys(idSys);
	}
	else
		Sel_Sys("*");
	if((pos=filter.indexOf("[USER:")) >=0)
	{
		idUser = filter.substring(pos+6,filter.indexOf("]",pos+6));
		Sel_Usr(idUser);
		if(filter.indexOf("[SYS:") < 0) Switch(2);
	}
	else
		Sel_Usr("*");
	var array = mainWnd.filter_array;
	if(array != null && array.length >0){
	 for(i = 1; i <= array.length; i++ ){ 
	  var obj = array[i-1];
	  AddRow();
	  document.getElementById("o_"+i).val = obj.op;
	  document.getElementById("o_"+i).innerText = GetTextById(document.all.op,obj.op);
	  document.getElementById("a_"+i).val = obj.attr;
	  document.getElementById("a_"+i).innerText = GetTextById(document.all.attr,obj.attr);
	  document.getElementById("s_"+i).val = obj.sign;
	  document.getElementById("s_"+i).innerText = GetTextById(document.all.sign,obj.sign);
	  document.getElementById("v_"+i).val = obj.val;
	  document.getElementById("v_"+i).innerText = obj.val;
	 } 
	 Switch(3);
   }
 }
}

function GetTextById(cmb,id)
{
 for(k=0; k < cmb.options.length; k++)
 {
   if(cmb.options[k].value == id)
    return cmb.options[k].text;
 }
 return "";
}

function ShowUserFilter()
{
 if(usrObj.selectedRow != null)
 {
   alert(usrObj.selectedRow.cw.replace("$~~ALIAS~~$","a").replace("$~~ALIAS~~$","a").replace("$~~ALIAS~~$","a"));
 }
}

function Sel_Sys(id)
{
	if(sysObj.selectedRow != null) sysObj.selectedRow.style.background = '';
	document.getElementById('y_'+id).style.background = '#d3d3d3';
	sysObj.selectedRow = document.getElementById('y_'+id);
	sysObj.selectedRowId = id; 
}
function Apl_Sys(id)
{
	Sel_Sys(id);
	Apply();
}
function Apl_Usr(id)
{
	Sel_Usr(id);
	Apply();
}

function Sel_Usr(id)
{
	if(usrObj.selectedRow != null) usrObj.selectedRow.style.background = '';
	document.getElementById('u_'+id).style.background = '#d3d3d3';
	usrObj.selectedRow = document.getElementById('u_'+id);
	usrObj.selectedRowId = id; 
}

function Sel_Cust()
{
	var id = event.srcElement.id.substr(2);
	if(custObj.selectedRow != null) custObj.selectedRow.style.background = '';
	document.getElementById('r_'+id).style.background = '#d3d3d3';
	custObj.selectedRow = document.getElementById('r_'+id);
	custObj.selectedRowId = id; 
}

function AddRow(index)
{
  var table = document.all.dgCust;
  var oCell;
  if(index == null) index = -1;
  var oRow = table.insertRow(index);
  var id = table.rows.length - 1;
  oRow.id = "r_"+id;
  oRow.style.fontWeight = "bold";
  oRow.style.cursor = "hand";
  oRow.style.height = 20;
  oRow.onclick = Sel_Cust;
  oCell = oRow.insertCell();
  oCell.innerText = " ";
  oCell.id = "o_"+id;
  oCell.onclick = s_o;
  oCell = oRow.insertCell();
  oCell.id = "a_"+id;
  oCell.noWrap = true;
  oCell.onclick = s_a;
  oCell = oRow.insertCell();
  oCell.id = "s_"+id;
  oCell.onclick = s_s;
  oCell.noWrap = true;
  oCell = oRow.insertCell();
  oCell.id = "v_"+id;
  oCell.onclick = s_v;
  oCell.noWrap = true;
}
function AddRowPos()
{
  AddRow(getSelectedRowIndex());
}
function getSelectedRowIndex()
{
 if(custObj.selectedRow != null){
	var oTable = document.all.dgCust;
	var curr_row = -1;
	for (curr_row = 1; curr_row<oTable.rows.length; curr_row++)
	{
		if(oTable.rows[curr_row].id == custObj.selectedRow.id) break; 
	}
	return curr_row;
  }
}
function DelRow()
{
 if(custObj.selectedRow != null){
	var oTable = document.all.dgCust;
	var curr_row;
	for (curr_row = 1; curr_row<oTable.rows.length; curr_row++)
	{
		if(oTable.rows[curr_row].id == custObj.selectedRow.id) break; 
	}
	document.all.dgCust.deleteRow(curr_row);
	custObj.selectedRow = null;
 }	
}
function DelAllRow()
{
	var oTable = document.all.dgCust;
	while(oTable.rows.length > 1)
		oTable.deleteRow();
	custObj.selectedRow = null;
}
function HideCustContols()
{
  document.all.op.style.visibility = "hidden";
  document.all.sign.style.visibility = "hidden";
  document.all.attr.style.visibility = "hidden";
  document.all.val.style.visibility = "hidden";
}
function Set(elem)
{
  var id = elem.id.substr(0,1)+"_"+custObj.selectedRowId;
  if(elem.tagName == "SELECT" && elem.selectedIndex != -1){
    document.getElementById(id).innerText = elem.options[elem.selectedIndex].text;
    document.getElementById(id).val = elem.options[elem.selectedIndex].value;
  }  
  else if(elem.tagName == "INPUT"){ 
  	document.getElementById(id).innerText = elem.value;
  	document.getElementById(id).val = elem.value;
  }	
  HideCustContols();	
}
function s_o()
{
	var elem = event.srcElement;
	HideCustContols();
	document.all.op.style.top = elem.offsetTop+27;
	document.all.op.style.left = elem.offsetLeft;
	document.all.op.style.width = elem.offsetWidth;
	document.all.op.style.visibility = "visible";
	if(elem.val) document.all.op.value = elem.val;
	else document.all.op.selectedIndex = -1;
	document.all.op.focus();
}
function s_a()
{
    var elem = event.srcElement;
    HideCustContols();
	document.all.attr.style.top = elem.offsetTop+27;
	document.all.attr.style.left = elem.offsetLeft;
	document.all.attr.style.width = elem.offsetWidth;
	document.all.attr.style.visibility = "visible";
	if(elem.val) document.all.attr.value = elem.val;
	else document.all.attr.selectedIndex = -1;
	document.all.attr.focus();
}
function s_s()
{
    var elem = event.srcElement;
    HideCustContols();
	document.all.sign.style.top = elem.offsetTop+27;
	document.all.sign.style.left = elem.offsetLeft;
	document.all.sign.style.width = elem.offsetWidth;
	document.all.sign.style.visibility = "visible";
	if(elem.val) document.all.sign.value = elem.val;
	else document.all.sign.selectedIndex = -1;
	document.all.sign.focus();
}
function s_v()
{
    var elem = event.srcElement;
    document.all.val.value = elem.innerText;
    HideCustContols();
	document.all.val.style.top = elem.offsetTop+27;
	document.all.val.style.left = elem.offsetLeft;
	document.all.val.style.width = elem.offsetWidth;
	document.all.val.style.visibility = "visible";
	document.all.val.focus();
}

function Switch(val)
{
	type = val;
	HideCustContols();
	document.all.pSys.style.visibility = (val==1)?("visible"):("hidden");
	document.all.pUser.style.visibility = (val==2)?("visible"):("hidden");
	document.all.pCustom.style.visibility = (val==3)?("visible"):("hidden");
	document.all.btSysFilter.className = (val==1)?("btinset"):("btoutset");
	document.all.btUserFilter.className = (val==2)?("btinset"):("btoutset");
	document.all.btCustomFilter.className = (val==3)?("btinset"):("btoutset");
}

var result = new Array();
function Apply()
{
	if(sysObj.selectedRowId != "*" ) result["SYS"] = sysObj.selectedRowId;
	else result["SYS"] = null;
	
	if(usrObj.selectedRowId != "*") result["USER"] = usrObj.selectedRowId;
	else result["USER"] = null;
	
	if(!CheckFilter()) return;
	
	result["FILT"] = GetCustFilter();
	
	window.returnValue = result;
	window.close();
}

var FLTR_START    = 0;
var FLTR_LPARANT  = 1; 
var FLTR_RPARANT  = 2;
var FLTR_ATOM     = 3;
var FLTR_OPERATOR = 4;
var FLTR_ISNULLOP = 7;
var FLTR_SIGN     = 5;
var FLTR_STOP     = 6;

function CheckFilter()
{
  var oTable = document.all.dgCust;
  var curr_row;
  var nParanteses = 0;
  var nLastState = FLTR_START;
  var nCurrState = FLTR_START;
  var fIsError = false;
  var sError = "";
  var rowsForDel = "";
  for (curr_row = 1; curr_row < oTable.rows.length; curr_row++)
  {
    var  id = oTable.rows[curr_row].id.substr(2);
    var attr = document.getElementById("a_"+id).val;
	var op = document.getElementById("o_"+id).val;
	if((attr == null || attr == "") && (op == "" || op == null)){
		rowsForDel += id+";";
		continue;
	}
  }
  for(i=0;i<rowsForDel.split(';').length-1;i++)
  {
    var  id = rowsForDel.split(';')[i];
    custObj.selectedRow = document.getElementById("r_"+id);
    DelRow();
  }
  for (curr_row = 1; curr_row < oTable.rows.length; curr_row++)
  {
    var  id = oTable.rows[curr_row].id.substr(2);
    custObj.selectedRow = document.getElementById("r_"+id);
	var op = document.getElementById("o_"+id).val;
	var attr = document.getElementById("a_"+id).val;
	var sign = document.getElementById("s_"+id).val;
	var val = document.getElementById("v_"+id).val;
	var val = document.getElementById("v_"+id).val;
	
	if(op == "3") nParanteses++;
	if(op == "4") nParanteses--;
	if(op != null && op != "5"){
		if(op == "3") nCurrState = FLTR_LPARANT;
		else if(op == "4") nCurrState = FLTR_RPARANT;
		else nCurrState = FLTR_OPERATOR;
		fIsError = CheckAllowence( nLastState, nCurrState);
		if(fIsError) return false;
		nLastState = nCurrState;
	}	
	if(attr != null && attr != "")
	{
		nCurrState = FLTR_ATOM;
		fIsError = CheckAllowence( nLastState, nCurrState);
		if(fIsError) return false;
		nLastState = nCurrState;
	}
	if(sign != null && sign != "")
	{
		if(sign == "9" || sign == "10")	nCurrState = FLTR_ISNULLOP;
		else							    nCurrState = FLTR_SIGN;
		fIsError = CheckAllowence( nLastState, nCurrState);
		if(fIsError) return false;
		nLastState = nCurrState;
	}
	if(val != null && val != "")
	{
		nCurrState = FLTR_ATOM;
		fIsError = CheckAllowence( nLastState, nCurrState);
		if(fIsError) return false;
		nLastState = nCurrState;
	}
  }	
  fIsError = CheckAllowence( nLastState, FLTR_STOP);
  if(fIsError) return false;
  if(nParanteses != 0)
  {
  	if(nParanteses > 0)
		sError = LocalizedString('Mes1'); //"Пропущена ЗАКРЫВАЮЩАЯ скобка";
	else
	    sError = LocalizedString('Mes2'); //"Пропущена ОТКРЫВАЮЩАЯ скобка";
	fIsError = true;
  }
  if(fIsError) {alert(sError);return false;}	    
  
  return true;
}

function CheckAllowence(nPrev,nNext)
{
  var sError = null;
  if(nPrev == FLTR_SIGN && nNext != FLTR_ATOM)
	sError = LocalizedString('Mes3'); //'Недопустимое выражение после оператора сравнения';
  if(nPrev == FLTR_ISNULLOP && nNext != FLTR_OPERATOR && nNext != FLTR_SIGN && nNext != FLTR_RPARANT && nNext != FLTR_STOP)
	sError = LocalizedString('Mes4'); //'Недопустимое выражение после оператора IS NULL/IS NOT NULL';
  if(nPrev == FLTR_OPERATOR && nNext != FLTR_ATOM && nNext != FLTR_LPARANT)
	sError = LocalizedString('Mes5'); //'Недопустимое выражение после логического оператора';
  if(nPrev == FLTR_START  && nNext != FLTR_ATOM && nNext != FLTR_LPARANT && nNext != FLTR_STOP)
	sError = LocalizedString('Mes6'); //'Недопустимое начало логического выражения фильтра';
  if(nPrev == FLTR_LPARANT && nNext != FLTR_ATOM && nNext != FLTR_LPARANT)
    sError = LocalizedString('Mes7'); //'Недопустимое выражение после открывающей скобки';
  if(nPrev == FLTR_RPARANT && nNext != FLTR_OPERATOR && nNext != FLTR_ISNULLOP && nNext != FLTR_RPARANT && nNext != FLTR_STOP)
	sError = LocalizedString('Mes8'); //'Недопустимое выражение после закрывающей скобки';
  if(nPrev == FLTR_ATOM && nNext != FLTR_OPERATOR && nNext != FLTR_ISNULLOP && nNext != FLTR_SIGN && nNext != FLTR_RPARANT && nNext != FLTR_STOP)
	sError = LocalizedString('Mes9'); //'Недопустимое выражение после атрибута или значения';
  if(sError) {alert(sError);return true;}
  return false;
}

function GetCustFilter()
{ 
  var array = new Array();
  var oTable = document.all.dgCust;
  var curr_row;
  for (curr_row = 1; curr_row < oTable.rows.length; curr_row++)
  {
	var  id = oTable.rows[curr_row].id.substr(2);
	var obj = new Object();
	obj.op = (document.getElementById("o_"+id).val)?(document.getElementById("o_"+id).val):("5");
	obj.attr = (document.getElementById("a_"+id).val)?(document.getElementById("a_"+id).val):("");
	obj.sign = (document.getElementById("s_"+id).val)?(document.getElementById("s_"+id).val):("");
	obj.val = (document.getElementById("v_" + id).val) ? (document.getElementById("v_" + id).val) : ("");
	array[array.length] = obj;
  }
  return array;
}

function SaveFilter()
{
  if(!CheckFilter()) return;
  if(document.all.dgCust.rows.length == 1) return;
  var fName = Dialog(LocalizedString('Mes10')/*"Сохранить текущий фильтр с именем"*/,"prompt");
  if(fName)
  {
    var array = GetCustFilter();
    var where = "";
    var tables = "";
    for(i=0;i<array.length;i++)
    {
		var obj = array[i];
		var line_filter = "";
		var field = (obj.attr.split(';').length > 1)?("$~~ALIAS~~$."+obj.attr.split(';')[0]):("");
		var type = (obj.attr.split(';').length > 2)?(obj.attr.split(';')[2]):("");
		if(obj.op == '4')
		{
			where +=  " ) ";
			continue;
		}
		line_filter += GetOperand(obj.op) + " ";
		var value = "";
		for(j = 0; j < obj.val.length; j++)
		{
			if(obj.val.charAt(j) == '*') value += '%';
			else if(obj.val.charAt(j) == '?') value += '_';
			else value += obj.val.charAt(j);
		}
		if(type=="C" && obj.sign != '11' && obj.sign != '12') value = "'"+value+"'";
		if(type=="D") value = "TO_DATE('"+value+"','dd/MM/yyyy')";
		if(obj.sign == '11' || obj.sign == '12') value = "("+value+")";

		if(obj.attr.split(';').length == 3)
		{
			if(obj.sign == '7' || obj.sign == '8') line_filter += field+' ';
			else 	    	  			  		   line_filter += field+' ';
			line_filter += GetOperation(obj.sign) + " ";
			if(obj.sign != '9' && obj.sign != '10')
				line_filter += value + " ";
		}
		else
		{
			var tabname = obj.attr.split(';')[3];  
			var rel1 = obj.attr.split(';')[4];
			var rel2 = obj.attr.split(';')[5];
			line_filter += tabname+'.'+obj.attr.split(';')[0]+' ';
			line_filter += GetOperation(obj.sign);
			tables += tabname;
			if(obj.sign != '9' && obj.sign != '10')
				line_filter += value + " ";
			line_filter += ' AND '+tabname+'.'+rel1+'(+)=$~~ALIAS~~$.'+rel2;
		}
		where += line_filter;	
    }
    where = "( " + where + " ) ";
    webService.Srv.callService(onSaveFilter,"SetFilter",fName,document.all.TID.value,where,tables);
   }
}
function onSaveFilter(result)
{
 if(result.error){
   location.replace("dialog.aspx?type=err&page=WebServices.asmx");
   return;
  }
  if(result.value > 0){
    alert(LocalizedString('Mes11'));/*"Изменения успешно сохранены!"*/
  }	
}
function DelUserFilter()
{
  if(usrObj.selectedRow)
  {
     webService.Srv.callService(onDelFilter,"DelFilter",usrObj.selectedRowId);
  }
}
function onDelFilter(result)
{
 if(result.error){
   location.replace("dialog.aspx?type=err&page=WebServices.asmx");
   return;
 }
 if(result.value > 0)
 {
	if(usrObj.selectedRow != null){
	var oTable = document.all.dgUser;
	var curr_row;
	for (curr_row = 1; curr_row<oTable.rows.length; curr_row++)
	{
		if(oTable.rows[curr_row].id == usrObj.selectedRow.id) break; 
	}
	document.all.dgUser.deleteRow(curr_row);
	usrObj.selectedRow = null;
	Sel_Usr("*");
	}	
 }
}

function Dialog(message,type)
{
  return window.showModalDialog("dialog.aspx?type="+type+"&message="+escape(message),"","dialogHeight:160px;center:yes;edge:sunken;help:no;status:no;");
}

function Cancel()
{
    window.returnValue = null;	
	window.close();
}
function GetOperation(index)
{
	switch(index){
		case '1': return '=';break; 
		case '2': return '&lt;';break;
		case '3': return '&lt;=';break;
		case '4': return '&gt;';break;
		case '5': return '&gt;=';break;
		case '6': return '&lt;&gt;';break; 
		case '7': return 'LIKE';break;
		case '8': return 'NOT LIKE';break; 
		case '9': return 'IS NULL';break; 
		case '10': return 'IS NOT NULL';break; 
		case '11': return 'IN';break; 
		case '12': return 'NOT IN';break; 
	} 
}
function GetOperand(index)
{
	switch(index){
		case '1': return 'AND';break; 
		case '2': return 'OR';break;
		case '3': return '(';break;
		case '4': return ')';break;
		case '5': return ' ';break;
	} 
}