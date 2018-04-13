var activeElement = null;
var findProc = false;
window.onload = InitTab_Contracts;
//***************************************************************************
function fnHotKeyContracts()
{
  parent.fnGlobalHotKey(event);
  //ALT+CTRL+S - показать\спрятать детальную информацию
  if(event.altKey && event.ctrlKey && event.keyCode == 83)
	fnShowDetail(document.getElementById("btDetail"))
  //ALT+CTRL+1 - установить фокус на МФО
  if(event.altKey && event.ctrlKey && event.keyCode == 49)
	document.getElementById("tbMfo").focus();
  //ALT+CTRL+2 - установить фокус на СЧЕТ	
  if(event.altKey && event.ctrlKey && event.keyCode == 50)
	document.getElementById("tbNls").focus();
  //ALT+CTRL+Z - установить фокус на поиск по позиции
  if(event.altKey && event.ctrlKey && event.keyCode == 90)
	document.getElementById("tbPos").focus();		
  //ALT+CTRL+F - поиск	
  if(event.altKey && event.ctrlKey && event.keyCode == 70)
    document.getElementById("btFind").fireEvent("onclick");	
  //ALT+CTRL+D - очистить поиск	
  if(event.altKey && event.ctrlKey && event.keyCode == 68)
	document.getElementById("btClear").fireEvent("onclick");	
	//ALT+CTRL+A - установить фокус на таблицу соглашений
  if(event.altKey && event.ctrlKey && event.keyCode == 65)
	document.getElementById("dGridDog").focus();	
}
//***************************************************************************
function InitTab_Contracts()
{
 //init_num("tbMfo",0,0)
 tbMfo.attachEvent("onblur",fnCkeckMfo);
 tbNls.attachEvent("onblur",fnCheckNls);
 
 LoadXslt('Xslt/Gen_'+getCurrentPageLanguage()+'.xsl');
 v_data[0] = '';
 v_data[1] = '';
 v_data[2] = '';
 v_data[3] = 't.pos';
 v_data[4] = 0;
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'Service.asmx';
 obj.v_serviceMethod = 'GetGen';
 obj.v_serviceAfterRefresh = 'TrySelect';
 fn_InitVariables(obj);	
 InitGrid();
}
//***************************************************************************
//Выделяем первую строчку на старте
function TrySelect()
{
 if(document.getElementById("r_1")){
    document.all.dGridDog.focus();
	document.getElementById("r_1").fireEvent("onclick");
	}
  else if(findProc){
     findProc = false;
     parent.webService.KP.callService(onGetSimpleNd, "GetSimpleNd");
  } 	
}
function onGetSimpleNd(result)
{
 if(!getError(result)) return;
 if(result.value[0] == ""){
	Dialog(LocalizedString('Mes30')/*"Для даного отделения не задан параметр NLS2902 (справочник TOBO_PARAMS)"*/,"alert");
	return;
  }
  if(result.value[1] == ""){
	Dialog(LocalizedString('Mes31')/*"Счет "*/+result.value[0]+" " + LocalizedString('Mes32')/*"не найден(параметр NLS2902 из справочника TOBO_PARAMS)"*/,"alert");
	return;
  }
  var array = new Array();
  for(i=0;i<22;i++) array[i] = "";
  array[0] = "";
  array[1] = result.value[0];
  array[2] = result.value[1];
  array[10] = result.value[2];
  array[12] = result.value[3];
  array[14] = result.value[4];
  array[15] = result.value[5];
  array[16] = result.value[6];
  array[17] = result.value[7];
  array[18] = 0;
  array[19] = result.value[8];
  
  ShowFrame(array);
}
//***************************************************************************
/*basic_obj 
 0 - ND      6 - OKPO		12 - TT      18 - GRP
 1 - NLS     7 - NMSB		13 - NAK	 19 - SUM 		
 2 - NMS     8 - NB			14 - ACC6F
 3 - SK		 9 - NLSB		15 - ACC6U
 4 - SKN     10 - NAZN		16 - ACC3U
 5 - MFO     11 - NAME      17 - VOB
*/
function FillData(nd)
{
 var array = new Array();
 array[0] = nd;
 array[1] = document.getElementById("r_"+row_id).NLS;
 array[2] = document.getElementById("r_"+row_id).NMS;
 array[3] = document.getElementById("r_"+row_id).SK;
 array[4] = document.getElementById("r_"+row_id).SKN;
 array[5] = document.getElementById("r_"+row_id).MFO;
 array[6] = document.getElementById("r_"+row_id).OKPO;
 array[7] = document.getElementById("r_"+row_id).NMSB;
 array[8] = document.getElementById("r_"+row_id).NB;
 array[9] = document.getElementById("r_"+row_id).NLSB;
 array[10] = document.getElementById("r_"+row_id).NAZN;
 array[11] = document.getElementById("r_"+row_id).NAME;
 array[12] = document.getElementById("r_"+row_id).TT;
 array[13] = document.getElementById("r_"+row_id).NAK;
 array[14] = document.getElementById("r_"+row_id).ACC6F;
 array[15] = document.getElementById("r_"+row_id).ACC6U;
 array[16] = document.getElementById("r_"+row_id).ACC3U;
 array[17] = document.getElementById("r_"+row_id).VOB;
 array[18] = document.getElementById("r_"+row_id).GRP;
 array[19] = document.getElementById("r_"+row_id).SUM;
 return array;
}
//Нажатие ввода
function Enter(nd)
{
 if(nd >= 0)
 {
    parent.b_folder = false;
	var data = FillData(nd);
	parent.curr_sum.disabled = false;
	parent.mainAttr.style.visibility = "visible";
	parent.mainAttr.style.overflow = "";
	parent.mainAttr.style.height = null;
 	ShowFrame(data);
 }
 else 
 {
    parent.b_folder = true;
    var res = window.showModalDialog("Folder.aspx?nd="+nd+"&name="+escape(document.getElementById("r_"+row_id).NAME),"","dialogWidht:600px;dialogHeight:500px;center:yes;edge:sunken;help:no;status:no;");
    if(res != null){ 
        parent.curr_folder = res;
        var tts = new Array();
        var sum = 0,k_fl = 0;
        for(i=0;i<res.length;i++){
			tts[i] = res[i].tt;
			sum = eval(res[i].sum) + sum;
			k_fl = eval(res[i].k_fl) + k_fl;
		}
		parent.curr_sum.value = sum;
		parent.data_obj.value.kom_f = k_fl;
		parent.curr_sum.disabled = true;
		AddParams("",tts);
		var top = 40;
		var left = parent.document.body.offsetWidth/2 - 300;
		parent.mainAttr.style.visibility = "hidden";	
		parent.mainAttr.style.overflow = "auto";
		parent.mainAttr.style.height = 1;
		parent.data.style.left = left;
		parent.data.style.top = top;
		parent.focus_on_elem = true;
		parent.data.style.visibility = 'visible';
		parent.focus();
	}
 }	
}
 
function GetDistinctTags(arr,tts)
{
 var array = new Array();
 var j = 0;
 for(k = 0; k < tts.length; k++){
	for(i = 0; i< arr.length; i++)
	{
		if(arr[i][0] == tts[k])
			array[j++] = arr[i];
	}
 }	
 
 var a = new Array();
 for(i = 0; i < array.length; i++ )
 {
   for(k = 0; k < array.length; k++){
      if(i != k && array[i][1] == array[k][1]){
		if(array[i][3] == 'M' || array[k][3] == 'M') array[k][3] = 'M';
		array[i][1] = null;
	  }	
   }
 }
 j = 0;
 for(i = 0; i < array.length; i++ )
	if(array[i][1] != null) a[j++] = array[i];
	
 return a;
} 

function findTag(arr,tag)
{
  for(i = 0; i < arr.length; i++ )
   if(arr[i][1] == tag) return true; 
  return false; 
}
 
function ShowFrame(data)
{
 var tt = data[12]; 
 
 parent.data_obj.value.tt = tt;
 parent.data_obj.value.nd = data[0];
 parent.curr_sum.value = "0.00";
 parent.NLS.value = data[1];
 parent.NMS.value = data[2];
 parent.SK.value = data[3];
 parent.SKN.value = data[4];
 parent.MFO.value = data[5];
 parent.OKPO.value = data[6];
 parent.NMSB.value = data[7];
 parent.NB.value = data[8];
 parent.NLSB.value = data[9];
 parent.NAZN.value = data[10];
 parent.data_obj.value.acc6f = data[14];
 parent.data_obj.value.acc6u = data[15];
 parent.data_obj.value.acc3u = data[16];
 parent.data_obj.value.vob = data[17];
 if(data[18] == 1) parent.cbGroup.checked = true;
 parent.data_obj.value.NAK = data[13];
 parent.data_obj.value.GRP = data[18];
 
 //Ходим по enterу как по таб
 parent.AddListeners("MFO,NLSB,NMSB,OKPO,SK,NAZN", 'onkeydown', parent.TreatEnterAsTab);
 
 if(data[18] == 1){
	parent.btBank.disabled = true;
	parent.MFO.style.backgroundColor = "lightgrey";
	parent.MFO.readOnly = true;
	parent.NLSB.style.backgroundColor = "lightgrey";
	parent.NLSB.readOnly = true;
	parent.NMSB.style.backgroundColor = "lightgrey";
	parent.NMSB.readOnly = true;
	parent.OKPO.style.backgroundColor = "lightgrey";
	parent.OKPO.readOnly = true;
 }
 else
 {
    parent.btBank.disabled = false;
	parent.MFO.style.backgroundColor = "white";
	parent.MFO.readOnly = false;
	parent.NLSB.style.backgroundColor = "white";
	parent.NLSB.readOnly = false;
	parent.NMSB.style.backgroundColor = "white";
	parent.NMSB.readOnly = false;
	parent.OKPO.style.backgroundColor = "white";
	parent.OKPO.readOnly = false;
 } 	
 
 parent.SK.style.backgroundColor = "white";
   
 AddParams(tt);
 
 var top = 40;
 var left = parent.document.body.offsetWidth/2 - 300;
 parent.data.style.left = left;
 parent.data.style.top = top;
 parent.data.style.visibility = 'visible';
 if(data[0] > 0) parent.mainAttr.style.visibility = 'visible';
 
 parent.curr_sum.focus();
 parent.curr_sum.select();
 
 if("" == parent.MFO.value) parent.MFO.focus();
 else if("" == parent.NLSB.value) parent.NLSB.focus();
 else if("" == parent.NMSB.value) parent.NMSB.focus();
 else if("" == parent.OKPO.value) parent.OKPO.focus();
 else if("" == parent.SK.value) parent.SK.focus();
 else if("" == parent.NAZN.value) parent.NAZN.focus();
 else if(parent.e_0) parent.e_0.focus();
 
 if(data[0] == 0)
	parent.webService.KP.callService(onGetNls2902, "getNls2902");
}

function onGetNls2902(result)
{ 
  if(!getError(result)) return;
  if(result.value[0] == ""){
	Dialog(LocalizedString('Mes30')/*"Для даного отделения не задан параметр NLS2902 (справочник TOBO_PARAMS)"*/,"alert");
	return;
  }
  if(result.value[1] == ""){
	Dialog(LocalizedString('Mes31')/*"Счет "*/+result.value[0]+LocalizedString('Mes32')/*" не найден(параметр NLS2902 из справочника TOBO_PARAMS)"*/,"alert");
	return;
  }
  parent.NLS.value = result.value[0];
  parent.NMS.value = result.value[1];
}
//***************************************************************************
//0 - tt   2 - val   4 - name
//1 - tag  3 - opt
function AddParams(tt,tts)
{
 var array;
 var val_arr = CopyArray(parent.fields_obj.value);
 if(tts) array = GetDistinctTags(val_arr,tts);
 else    array = SearchArray(val_arr,tt);
 id_fio = null;
 if(array.length == 0) parent.lbReq.style.visibility = "hidden";
 else parent.lbReq.style.visibility = "visible";
 parent.total_is = false;
 var inner = "<table border=1 cellpadding=0 cellspacing=0 width='100%'>";
 var style = "";
 var evt = "",ids="",value;
 var split = false, wdTagName="40%",wdTag="60%"; 
 parent.count_tags = array.length;
 var inputs = new Array();
 var tds = new Array();
 if(array.length >= 8){
	split = true;
	wdTagName="20%";
	wdTag="30%" ; 
 }
 
 for(i = 0; i < array.length; i++)
 {
  var tag = array[i][1];
  var val = array[i][2];
  var opt = array[i][3];
  var name = array[i][4];
  
  if(opt != 'O') style = "color:red"; else style = "";
  if(tag.substr(0,3) == 'FIO'){
   parent.id_fio = i;
   evt = "onchange='fnSetFio(this)'";
   if(parent.tbFio.value != "") val = parent.tbFio.value;
  }
  else if(tag.substr(0,3) == '?LC')
  {
	evt = "onblur='fnGetInfo(this)'";
  }
  else evt = "";
  var cur_input = "";
  tds[i] = "<td align=right nowrap class=hint style='width:"+wdTagName+";"+style+"'>"+name+"</td><td style='width:"+wdTag+"'>";
  cur_input = "<input style='width:100%' tabindex="+(30+i);
  //Formula
  if(val.indexOf("#") == -1) value = val;
  else{
	 value = "";
	 cur_input += " formula='"+val+"'";
  }
  if(opt == 'M') cur_input += " tagname='"+name+"'";
  cur_input += " onkeydown='fnArrow(this)' onfocus='fnFormula(this)' opt='"+opt+"' tag='"+tag+"' value='"+value+"' id=e_"+i+" "+evt+">";
  inputs[i] = cur_input;
   
  ids += "e_"+i+",";
 }
 
 if(split)
 {
    var half = Math.round(array.length/2);
	for(i = 0; i < half; i++)
	{
	    inner += "<tr>"+tds[i]+inputs[i]+"</td>";
	    if(inputs[i+half])
			inner += tds[i+half]+inputs[i+half]+"</td></tr>";
		else inner += "</tr>";
	}
 }
 else
 {
	for(i = 0; i < array.length; i++)
	{
		inner += "<tr>"+tds[i]+inputs[i]+"</td></tr>";
	}
 }	
 inner += "</table>";
  
 parent.fields.innerHTML = inner;
 //Ходим по enterу как по таб
 if("" != ids)
   parent.AddListeners(ids.substring(0,ids.length-1), 'onkeydown', parent.TreatEnterAsTab);
}
//***************************************************************************
function fnShowDetail(bt)
{
 if(bt.className == "in")
 {
   bt.className = "out"
   LoadXslt("Xslt/Gen_"+getCurrentPageLanguage()+".xsl");
 }
 else {
   bt.className = "in"
   LoadXslt("Xslt/GenFull_"+getCurrentPageLanguage()+".xsl");
 }
 RefreshGrid();
}
//***************************************************************************
function fnFocus()
{
 if(parent.data.style.visibility == "visible") return;
 document.all.dGridDog.focus();
 if(activeElement != null){
	document.getElementById(activeElement).focus();
	document.getElementById(activeElement).select();
	activeElement = null;
 }	
}
//***************************************************************************
function fnFind()
{
  var mfo = document.getElementById("tbMfo").value;
  var nls = document.getElementById("tbNls").value;
  mfo = mfo.replace("*","%").replace("*","%").replace("?","_").replace("?","_");
  nls = nls.replace("*","%").replace("*","%").replace("?","_").replace("?","_");;
  if(mfo != "")
	v_data[10] = " and k.mfob like '"+mfo +"'";
  if(nls != "")
	v_data[10] += " and k.nlsb like '"+nls +"'";
  if(v_data[10] != "") 
	ReInitGrid();
  findProc = true;
}
//***************************************************************************
function fnFindOnPos(obj)
{
  document.getElementById("tbMfo").value = "" ;
  document.getElementById("tbNls").value = "";
  if(event.keyCode == 17 || event.keyCode == 18 || event.keyCode == 90) return;
  v_data[10] = "";
  var val = obj.value; 
  if(val == "") v_data[11] = "";
  else      	v_data[11] = " and t.pos="+val;
  ReInitGrid();
  obj.focus();
}
//***************************************************************************
function fnClear()
{
 document.getElementById("tbMfo").value = "" ;
 document.getElementById("tbNls").value = "";
 document.getElementById("tbPos").value = "";
 if(v_data[10] != "" || v_data[11] != ""){
	v_data[10] = "";v_data[11] = "";
	ReInitGrid();
 }	
}
//**********************************************************************//
function fnCkeckMfo()
{
 if(tbMfo.value != "")
	parent.webService.KP.callService(onGetMfo, "getMfo",tbMfo.value);
}
function onGetMfo(result)
{
 if(!getError(result)) return;
 if(result.value == ""){
	  Dialog(LocalizedString('Mes25')/*"Несуществующий МФО!"*/,"alert");
	  activeElement = "tbMfo";
 }
}
//**********************************************************************//
function fnCheckNls()
{
  if(tbNls.value.length == 0 || tbNls.value.indexOf("*") > 0 || tbNls.value.indexOf("%") > 0 || tbNls.value.indexOf("?") > 0 || tbNls.value.indexOf("_") > 0) return;
  if(tbNls.value != checkNls(tbMfo.value,tbNls.value))
  {
    Dialog(LocalizedString('Mes26')/*"Неверный контрольный разряд!"*/,"alert");
    tbNls.focus();
    tbNls.select();
  }
}