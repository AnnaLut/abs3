var url_dlg = "dialog.aspx?type=metatab&tail=''&role=wr_viewacc&tabname="; 
var url_dlg_mod = "dialog.aspx?type=metatab&role=wr_viewacc&tabname="; 
var id;
var acc;
var accessmode;
var copy_on = false;
var dd_data = new Array();
var perData = new Array();
var perEditData = new Array();
var perEditTblData = new Array();
var edit = false;
var editT = false;
var accData = new Array();

function fnSave()
{
   var per = null;
   var pertbl = null;
   if(edit) per = ForUpdatePercent();
   if(editT)
   {
      pertbl = makeArray(perEditTblData);
      if(pertbl.length == 0) pertbl = null;
   }
   webService.Percent.callService(onSaving,"Save",acc,per,pertbl);
}
function makeArray(obj)
{
 if(obj == null) return null;
 var strobj = new Array(),i = 0;
 for(key in obj) {
   if(obj[key] == null) break;
   strobj[i] = key;
   strobj[i+1]= obj[key];
   i+=2;
 }
 return strobj;
}
function onSaving(result)
{
 if(!getError(result)) return;
 if(result.value != ""){
  Dialog("Изменения успешно сохранены!",1);
  HideImg(document.all.btSave);
  edit = false;
  editT = false;
 } 
} 
function ForUpdatePercent()
{
  var result = new Array();
  var data = perData;
  result[0] = data[0].text;
  result[1] = data[1].text;
  result[2] = data[2].text;
  result[3] = data[3].text;
  result[4] = data[4].text;
  result[5]	= data[5].text;
  result[6]	= data[6].text;
  result[7]	= data[7].text;
  result[8]	= data[8].text;
  result[9]	= data[9].text;
  result[10]= data[10].text;
  result[11]= data[11].text;
  result[12]= data[12].text;
  result[13]= data[13].text;
  result[14]= data[14].text;
  result[15]= data[15].text;
  result[16]= data[16].text;
  result[17]= data[24];
  var n_data = perEditData;
  for(key in n_data)
  {
    val = n_data[key];
    switch (key)
	{
	  case "ddMetr"		: result[0] = val;break;
	  case "ddBaseY"	: result[2] = val;(val == "2") ? (result[1]=1):(result[1]=0);break;
	  case "ddFreq"		: result[3] = val;break;
	  case "tbStpDat"	: result[4] = val;break;
	  case "tbAcrDat"	: result[5] = val;break;
	  case "tbAplDat"	: result[6] = val;break;
	  case "tbTT1"		: result[7] = val;break;
	  case "tbTT2"		: result[10] = val;break;
	  case "tbMFO"		: result[11] = val;break;
	  case "tbKvC"		: result[12] = val;break;
	  case "tbNlsC"		: result[13] = val;break;
	  case "tbNamC"		: result[14] = val;break;
	  case "tbNazn"		: result[15] = val;break;
	  case "ddOstat"	: result[16] = val;break;
	 }	
  }
  return result;
}

function InitPercent()
{
 webService.useService("BasicService.asmx?wsdl","Percent");
 acc = getParamFromUrl("acc",location.href);
 HideImg(document.all.btSave);
  
 webService.Percent.callService(onInitProcAccount, "InitProcAccount",acc);
}
function onInitProcAccount(result)
{
 if(!getError(result)) return;
  
 dd_data["ddBaseY"] = url_dlg + "basey";
 dd_data["ddFreq"] = url_dlg + "freq";
 dd_data["ddMetr"] = url_dlg + "int_metr";
 dd_data["ddName"] = url_dlg + "brates";
 
 accData = result.value; 
 var pap = parseInt(accData[2]);
 var lim = parseFloat(accData[8]);
 var accessmode = accData[13];
 
 if(accessmode != 1)
 {
  HideImg(document.all.btIns);
  HideImg(document.all.btDel);
  document.all.ddBaseY.disabled = true;
  document.all.ddFreq.disabled = true;
  document.all.ddMetr.disabled = true;
  document.all.ddOstat.disabled = true;
  document.all.tbAcrDat.disabled = true;
  document.all.tbAplDat.disabled = true;
  document.all.tbKvA.disabled = true;
  document.all.tbKvB.disabled = true;
  document.all.tbKvC.disabled = true;
  document.all.tbMFO.disabled = true;
  document.all.tbNamC.disabled = true;
  document.all.tbNazn.disabled = true;
  document.all.tbNlsA.disabled = true;
  document.all.tbNlsB.disabled = true;
  document.all.tbNlsC.disabled = true;
  document.all.tbTT1.disabled = true;
  document.all.tbTT2.disabled = true;
  document.all.tbStpDat.disabled = true;
  document.all.cb23.disabled = true;
 }
 
 //Param IO%   
 if(accData[9] != 'Y') document.all.ddOstat.disabled = true;  
 
 if(1 == pap && lim >= 0)
 {
	document.all.btOb0.disabled = false;
	document.all.btOb2.disabled = false;
	id = 0;
 }
 else if(2 == pap && lim <= 0)
 {
	document.all.btOb1.disabled = false;
	document.all.btOb3.disabled = false;
	id = 1;
 }
 else
 {
    if(lim > 0) id = 0;
    else		id = 1;
    document.all.btOb0.disabled = false;
	document.all.btOb1.disabled = false;
	document.all.btOb2.disabled = false;
	document.all.btOb3.disabled = false;
 }
 document.getElementById("btOb"+id).fireEvent("onclick");
}
//Table
function LoadTable()
{
 LoadXslt('Xslt/PerData.xsl');
 v_data[9] = acc;
 v_data[10] = id;
 v_data[3] = 'i.bdat';
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'BasicService.asmx';
 obj.v_serviceMethod = 'PercentTable';
 obj.v_serviceFuncAfter = 'AfterPercentTable';
 obj.v_funcCheckValue = 'fnSavePerTbl';
 obj.v_funcDelRow = 'onDelRow';
 fn_InitVariables(obj);	
 InitGrid();
}
function AfterPercentTable()
{
 webService.Percent.callService(onSetPerVal, "Percent_Button",acc,id,false,accData[1]);
}
function fnSavePerTbl()
{
 SavePT(selectedRowId,document.getElementById("IR").value,document.getElementById("OP").value,document.getElementById("ddName").value,document.getElementById("BDAT").value,id);
}
//Buttons
function P_B0(but)
{
 id = 0;SetId();
 LoadTable();
 but.style.borderStyle ='inset';
 document.getElementById('btOb1').style.borderStyle ='outset';
 document.getElementById('btOb2').style.borderStyle ='outset';
 document.getElementById('btOb3').style.borderStyle ='outset';
 document.getElementById('Copy').style.visibility = 'hidden';
}
function P_B1(but)
{
 id = 1;SetId();
 LoadTable();
 but.style.borderStyle ='inset';
 document.getElementById('btOb0').style.borderStyle ='outset';
 document.getElementById('btOb2').style.borderStyle ='outset';
 document.getElementById('btOb3').style.borderStyle ='outset';
 document.getElementById('Copy').style.visibility ='hidden';
}
function P_B2(but)
{
 id = 2;SetId();
 LoadTable();
 but.style.borderStyle ='inset';
 document.getElementById('btOb1').style.borderStyle ='outset';
 document.getElementById('btOb0').style.borderStyle ='outset';
 document.getElementById('btOb3').style.borderStyle ='outset';
 if(accessmode == 1) document.getElementById('Copy').style.visibility ='visible';
}
function P_B3(but)
{
 id = 3;SetId();
 LoadTable();
 but.style.borderStyle ='inset';
 document.getElementById('btOb1').style.borderStyle ='outset';
 document.getElementById('btOb2').style.borderStyle ='outset';
 document.getElementById('btOb0').style.borderStyle ='outset';
 if(accessmode == 1) document.getElementById('Copy').style.visibility ='visible';
}
function onSetPerVal(result)
{
 if(!getError(result,1)) return;
 perData = result.value;
 document.all.tbStpDat.value = result.value[4].text; 
 document.all.tbAcrDat.value = result.value[5].text; 
 document.all.tbAplDat.value = result.value[6].text; 
 document.all.tbTT1.value = result.value[7].text; 
 document.all.tbTT2.value = result.value[10].text;
 document.all.tbMFO.value = result.value[11].text;
 document.all.tbKvC.value = result.value[12].text;
 document.all.tbNlsC.value = result.value[13].text;
 document.all.tbNamC.value = result.value[14].text;
 document.all.tbNazn.value = result.value[15].text;
 document.all.tbNlsA.value = result.value[17].text;
 document.all.tbKvA.value = result.value[18].text;
 document.all.tbNlsB.value = result.value[19].text;
 document.all.tbKvB.value = result.value[20].text;
 if(!copy_on){
	document.all.ddMetr.options[0].text = result.value[21].text;
	document.all.ddBaseY.options[0].text = result.value[22].text;
	document.all.ddFreq.options[0].text = result.value[23].text;
	document.all.ddOstat.value = result.value[16].text;
 }
 else{
	document.all.tbStpDat.fireEvent("onchange");
	document.all.tbAcrDat.fireEvent("onchange");
	document.all.tbAplDat.fireEvent("onchange");
	document.all.tbTT1.fireEvent("onchange");
	document.all.tbTT2.fireEvent("onchange");
	document.all.tbMFO.fireEvent("onchange");
	document.all.tbKvC.fireEvent("onchange");
	document.all.tbNlsC.fireEvent("onchange");
	document.all.tbNamC.fireEvent("onchange");
	document.all.tbNazn.fireEvent("onchange");
	document.all.tbNlsA.fireEvent("onchange");
	document.all.tbKvA.fireEvent("onchange");
	document.all.tbNlsB.fireEvent("onchange");
	document.all.tbKvB.fireEvent("onchange");
	copy_on = false;
 } 	
 SetId();
}
//Сохраняем выбранный id
function SetId()
{
 perData[24] = id;
}
function Open23Percent()
{
 if(document.all.btOb2.disabled) document.all.btOb2.disabled = false;
 if(document.all.btOb3.disabled) document.all.btOb3.disabled = false;
 document.all.cb23.disabled = true;
}
function fnCopyPer()
{
  copy_on = true;
  webService.Percent.callService(onSetPerVal, "Percent_Button",acc,id,true);
}
function ValidPer(obj)
{
 var data = accData; 
 if(obj.value == ""){ 
   if(obj.id == "tbKvA") obj.value = data[1];
   else if(obj.id == "tbKvB") {
     if(document.all.tbKvA.value.substr(1,1) != '8')
       obj.value = data[12];
     else 
       obj.value = document.all.tbKvA.value;
   }
   else if(obj.id == "tbKvC"){
     if(document.all.tbKvA.value == "")
       obj.value = data[12];
     else 
       obj.value = document.all.tbKvA.value;
   }  
   else if(obj.id == "tbTT1") obj.value = "%%1";
   else if(obj.id == "tbTT2") obj.value = "PS1";
   else if(obj.id == "tbNlsA" && id < 2) getNlsA(data[3],data[11],data[0]);
   else if(obj.id == "tbNlsB" && id < 2) getNlsB();
  }
  obj.fireEvent("onchange");
}

function getNlsA(nbs,mfo,nls)
{
 webService.Percent.callService(onGetNlsA, "getNlsA",nbs,mfo,nls);
}
function onGetNlsA(result)
{
 if(!getError(result)) return;
 document.all.tbNlsA.value = result.value;
 document.all.tbNlsA.fireEvent("onchange");
}
//--------
function getNlsB()
{
 webService.Percent.callService(onGetNlsB, "getNlsB",acc);
}
function onGetNlsB(result)
{
 if(!getError(result)) return;
 document.all.tbNlsB.value = result.value[0];
 document.all.tbKvB.value = result.value[1];
 document.all.tbNlsB.fireEvent("onchange");
 document.all.tbKvB.fireEvent("onchange");
}
//-----------
//Проверка NlsA
function ValidNlsA()
{
  var value = document.all.tbNlsA.value;
  var kvA = accData[1];
  if(document.all.tbKvA.value != "") kvA = document.all.tbKvA.value;
  if(value == "") {
    document.all.tbKvA.value = "";
    perData[8].text = "";
    SaveP(document.all.tbNlsA);
  }  
  else webService.Percent.callService(onValidNlsA, "ValidNls",accData[11],value,kvA); 
}
function onValidNlsA(result)
{
 if(!getError(result)) return;
 var res;
 var kvA = accData[1];
 if(document.all.tbKvA.value != "") kvA = document.all.tbKvA.value;
 
 if(result.value[0] == "")
   res = Dialog('Счет '+result.value[1]+'/'+kvA+' не открыт. Открыть?',0);
 else
   perData[8].text = result.value[0];
 if(res == 1){  
    document.all.tbNlsA.value = result.value[1];
    webService.Percent.callService(onOpenAccA, "OpenAcc",acc,result.value[1],kvA,""); 
 }	
 SaveP(document.all.tbNlsA);
}
//Проверка NlsB
function ValidNlsB()
{
  var value = document.all.tbNlsB.value;
  var kvB = accData[12];
  if(document.all.tbKvB.value != "") kvB = document.all.tbKvB.value;
  if(value == "") {
     document.all.tbKvB.value = "";
     perData[9].text = "";
     SaveP(document.all.tbNlsB);
  }   
  else webService.Percent.callService(onValidNlsB, "ValidNls",accData[11],value,kvB); 
}
function onValidNlsB(result)
{
 if(!getError(result)) return;
 var res;
 var kvB = accData[12];;
 if(document.all.tbKvB.value != "") kvB = document.all.tbKvB.value;
 
 if(result.value[0] == "")
   res = Dialog('Счет '+result.value[1]+'/'+kvB+' не открыт. Открыть?',0);
 else perData[9].text = result.value[0];  
 if(res == 1){  
    document.all.tbNlsB.value = result.value[1];
    webService.Percent.callService(onOpenAccB, "OpenAcc",acc,result.value[1],kvB,""); 
 }	
 SaveP(document.all.tbNlsB);
}
//Проверка NlsC
function ValidNlsC()
{
 if(document.all.tbNlsC.value == "") return;
 if(document.all.tbMFO.value == "") {
   document.all.tbMFO.value = accData[11];
   SaveP(document.all.tbMFO);  
 }  
 webService.Percent.callService(onCheckAcc, "CheckAcc",document.all.tbMFO.value,document.all.tbNlsC.value,document.all.tbKvC.value); 
}
function onCheckAcc(result)
{
 if(!getError(result)) return;
 if(result.value[0] != document.all.tbNlsC.value){ 
   Dialog("Ошибка!Конр.разряд",1);
   document.all.tbNlsC.value = "";
 }  
 else{
    if(document.all.tbMFO.value == accData[11] && result.value[1] == 0){
        var res = Dialog('Счет '+result.value[0]+'/'+document.all.tbKvC.value+' не открыт. Открыть?',0);
		if(res == 1)   
			webService.Percent.callService(onOpenAcc,"OpenAcc",acc,result.value[0],document.all.tbKvC.value,document.all.tbNamC.value); 
	}	
 } 
 SaveP(document.all.tbNlsC);  
}
function onOpenAcc(result){
 if(!getError(result)) return;
 Dialog("Счет открыт!",1);
}
function onOpenAccA(result)
{
  if(!getError(result)) return;
  if(result.value[0] != -1){
     Dialog("Счет открыт!",1);
     perData[8].text = result.value[1];
  }   
  else   
    Dialog("Счет невозможно открыть!",1);
}
function onOpenAccB(result)
{
  if(!getError(result)) return;
  if(result.value[0] != -1){
    Dialog("Счет открыт!",1);
    perData[9].text = result.value[1];
  }  
  else   
    Dialog("Счет невозможно открыть!",1);
}
function onDelRow(node)
{
 if(node.childNodes[1].text == '')
    perEditTblData[node.childNodes[0].text] = null;
 else 
   SavePT('del'+selectedRowId+id,'','','',node.childNodes[1].text,id);
}
function Add()
{
 AddRow('ID');
 document.getElementById('BDAT').value = accData[10];
}


//Выпадающие списки
function d_dlg(ddlist,control)
{
 var result = window.showModalDialog(dd_data[ddlist.id],"","dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
 if(result!=null){
  if(ddlist.options.length == 0)
  {
   var oOption = document.createElement("OPTION");
   ddlist.options.add(oOption);
   oOption.innerText = result[1];
   oOption.value = result[0];
  }
  else{
  ddlist.options[0].value = result[0];
  ddlist.options[0].text = result[1];
  }
  if(control!=null) {
    if(result[0].indexOf(" ") != -1)
      control.value = result[0].split(" ")[1];
    else control.value = result[0];
  }  
  SaveP(ddlist);
 } 
}

//Percent
function SaveP(obj)
{
 perEditData[obj.id] = obj.value;
 if(!edit) UnHideImg(document.all.btSave);
 edit = true;
}
//Percent Table
function SavePT(id,ir,op,br,bdat,_id)
{
 var tbl = perEditTblData;
 tbl[id] = new Array();
 tbl[id][0] = id;
 tbl[id][1] = ir;
 tbl[id][2] = op;
 tbl[id][3] = br;
 tbl[id][4] = bdat;
 tbl[id][5] = _id;
 if(!editT) UnHideImg(document.all.btSave);
 editT = true;
}