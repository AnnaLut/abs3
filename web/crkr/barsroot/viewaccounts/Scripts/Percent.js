var id;
var copy_on = false;
function InitPercent()
{
 //Локализация
 LocalizeHtmlTitles();

 webService.useService("AccService.asmx?wsdl","Percent");
 var data = parent.acc_obj.value; 
 acc = getParamFromUrl("acc",location.href);
 accessmode = getParamFromUrl("accessmode",location.href);
 if(accessmode != 1) document.all.a_d.style.visibility = 'hidden';
 id = data[36].text;
 dd_data["ddBaseY"] = url_dlg + "basey";
 dd_data["ddFreq"] = url_dlg + "freq";
 dd_data["ddMetr"] = url_dlg + "int_metr";
 dd_data["ddName"] = url_dlg + "brates";

 if(accessmode != 1)
   document.getElementById('a_d').style.visibility = 'hidden'; 
   
 if(data[52].text != 'Y') document.all.ddOstat.disabled = true;  
 
 if(accessmode != 1)
 {
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
  document.all.ddProf.disabled = true;
  }
  /*
 // data[5] - PAP, data[21] - LIM  
 if(data[5].text==1 && data[21].text >= 0)
 {
	document.all.btOb1.disabled = true;
	document.all.btOb3.disabled = true;
 }
 else if(data[5].text==2 && data[21].text <= 0)
 {
	document.all.btOb0.disabled = true;
	document.all.btOb2.disabled = true;
 }
 if(data[36].text == 0)  document.all.btOb0.fireEvent("onclick");
 else  if(data[36].text == 1) document.all.btOb1.fireEvent("onclick");
 else  if(data[36].text == 2) document.all.btOb2.fireEvent("onclick");
 else  if(data[36].text == 3) document.all.btOb3.fireEvent("onclick");
 */
 document.all.ddGroups.fireEvent("onchange");
 //if(accessmode == 1) getProf();
}
//Table
function LoadTable()
{
 LoadXslt("Xslt/PerData_"+getCurrentPageLanguage()+".xsl");
 v_data[9] = acc;
 v_data[10] = id;
 v_data[3] = 'i.bdat';
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'AccService.asmx';
 obj.v_serviceMethod = 'PercentTable';
 obj.v_serviceFuncAfter = 'AfterPercentTable';
 obj.v_funcCheckValue = 'fnSavePerTbl';
 obj.v_funcDelRow = 'onDelRow';
 //obj.v_showPager = false;
 fn_InitVariables(obj);	
 InitGrid();
}
var prev_bdat = null;
function perCustomEdit(val, id) {
    Edit(val, id);
    prev_bdat = document.getElementById("BDAT").value;
}
function AfterPercentTable()
{
 webService.Percent.callService(onSetPerVal, "Percent_Button",acc,id,false);
}
function fnSavePerTbl()
{
    SavePT(selectedRowId, document.getElementById("IR").value, document.getElementById("OP").value, document.getElementById("ddName").value, document.getElementById("BDAT").value, prev_bdat, id);
}
function changeGroup(elem) {
    id = elem.value;
    SetId();
    LoadTable();
    if (accessmode == 1 && id != 1 && id != 2) document.getElementById('Copy').style.visibility = 'visible';
}
function onSetPerVal(result)
{
 if(!getError(result)) return;
 parent.per_obj.value = result.value;
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
 parent.per_obj.value[24] = id;
}
function Open23Percent()
{
 document.all.cb23.disabled = true;
}
function fnCopyPer()
{
  copy_on = true;
  webService.Percent.callService(onSetPerVal, "Percent_Button",acc,id,true);
}
function ValidPer(obj)
{
 var data = parent.acc_obj.value; 
 if(obj.value == ""){ 
   if(obj.id == "tbKvA") obj.value = data[1].text;
   else if(obj.id == "tbKvB") {
     if(document.all.tbKvA.value.substr(1,1) != '8')
       obj.value = data[53].text;
     else 
       obj.value = document.all.tbKvA.value;
   }
   else if(obj.id == "tbKvC"){
     if(document.all.tbKvA.value == "")
       obj.value = data[53].text;
     else 
       obj.value = document.all.tbKvA.value;
   }  
   else if(obj.id == "tbTT1") obj.value = "%%1";
   else if(obj.id == "tbTT2") obj.value = "PS1";
   else if(obj.id == "tbNlsA" && id < 2) getNlsA(data[2].text,data[51].text,data[0].text);
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
  var kvA = parent.acc_obj.value[1].text;
  if(document.all.tbKvA.value != "") kvA = document.all.tbKvA.value;
  if(value == "") {
    document.all.tbKvA.value = "";
    parent.per_obj.value[8].text = "";
    SaveP(document.all.tbNlsA);
  }  
  else webService.Percent.callService(onValidNlsA, "ValidNls",parent.acc_obj.value[51].text,value,kvA); 
}
function onValidNlsA(result)
{
 if(!getError(result)) return;
 var res;
 var kvA = parent.acc_obj.value[1].text;
 if(document.all.tbKvA.value != "") kvA = document.all.tbKvA.value;
 
 if(result.value[0] == "")
   res = Dialog('Счет '+result.value[1]+'/'+kvA+LocalizedString('Message30'),0);
 else
   parent.per_obj.value[8].text = result.value[0];
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
  var kvB = parent.acc_obj.value[53].text;
  if(document.all.tbKvB.value != "") kvB = document.all.tbKvB.value;
  if(value == "") {
     document.all.tbKvB.value = "";
     parent.per_obj.value[9].text = "";
     SaveP(document.all.tbNlsB);
  }   
  else webService.Percent.callService(onValidNlsB, "ValidNls",parent.acc_obj.value[51].text,value,kvB); 
}
function onValidNlsB(result)
{
 if(!getError(result)) return;
 var res;
 var kvB = parent.acc_obj.value[53].text;
 if(document.all.tbKvB.value != "") kvB = document.all.tbKvB.value;
 
 if(result.value[0] == "")
   res = Dialog('Счет '+result.value[1]+'/'+kvB+LocalizedString('Message30'),0);
 else parent.per_obj.value[9].text = result.value[0];  
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
   document.all.tbMFO.value = parent.acc_obj.value[51].text;
   SaveP(document.all.tbMFO);  
 }  
 webService.Percent.callService(onCheckAcc, "CheckAcc",document.all.tbMFO.value,document.all.tbNlsC.value,document.all.tbKvC.value); 
}
function onCheckAcc(result)
{
 if(!getError(result)) return;
 if(result.value[0] != document.all.tbNlsC.value){ 
   Dialog(LocalizedString('Message31'),1);
   document.all.tbNlsC.value = "";
 }  
 else{
    if(document.all.tbMFO.value == parent.acc_obj.value[51].text && result.value[1] == 0){
        var res = Dialog('Счет '+result.value[0]+'/'+document.all.tbKvC.value+LocalizedString('Message30'),0);
		if(res == 1)   
			webService.Percent.callService(onOpenAcc,"OpenAcc",acc,result.value[0],document.all.tbKvC.value,document.all.tbNamC.value); 
	}	
 } 
 SaveP(document.all.tbNlsC);  
}
function onOpenAcc(result){
 if(!getError(result)) return;
 Dialog(LocalizedString('Message32'),1);
}
function onOpenAccA(result)
{
  if(!getError(result)) return;
  if(result.value[1] != ""){
     Dialog(LocalizedString('Message32'),1);
     parent.per_obj.value[8].text = result.value[1];
  }   
  else   
    Dialog(LocalizedString('Message33'),1);
}
function onOpenAccB(result)
{
  if(!getError(result)) return;
  if(result.value[0] != -1){
    Dialog(LocalizedString('Message32'),1);
    parent.per_obj.value[9].text = result.value[1];
  }  
  else   
    Dialog(LocalizedString('Message33'),1);
}
function onDelRow(node)
{
 if(node.childNodes[1].text == '')
   parent.edit_data.value.percent.tbl[node.childNodes[0].text] = null;
 else
     SavePT('del' + selectedRowId + id, '', '', '', node.childNodes[1].text, node.childNodes[1].text, id);
}
//prof
function getProf()
{
 webService.Percent.callService(onGetProf,"getProf",parent.acc_obj.value[2].text); 
}
function onGetProf(result)
{
 if(!getError(result)) return;
 var oOption;
 for(i = 0; i < result.value.split(";").length - 1; i++)
 {
  oOption = document.createElement("OPTION");
  document.getElementById("ddProf").options.add(oOption);
  oOption.innerText = result.value.split(";")[i];
  oOption.value = result.value.split(";")[i];
 }
}
//
function setProf()
{
 var value = document.getElementById("ddProf").value;
 if(value != "")
   webService.Percent.callService(onSetProf,"setProf",parent.acc_obj.value[2].text,value); 
}
function onSetProf(result)
{
  if(!getError(result)) return;
  AddRow('Id','param');
  document.all.BDAT.value = parent.acc_obj.value[37].text;
  document.all.IR.value = result.value[0];
  document.all.ddName.options[0].value = result.value[1];
  document.all.ddName.options[0].text = result.value[2];
  CloseEdit();
  document.all.ddMetr.options[0].text = result.value[7];
  document.all.ddMetr.options[0].value = result.value[3];
  SaveP(document.all.ddMetr);
  document.all.ddBaseY.options[0].text = result.value[8];
  document.all.ddBaseY.options[0].value = result.value[4];
  SaveP(document.all.ddBaseY);
  document.all.ddFreq.options[0].text = result.value[9];
  document.all.ddFreq.options[0].value = result.value[5];
  SaveP(document.all.ddFreq);
  document.all.ddOstat.value = result.value[6];
  SaveP(document.all.ddOstat);
}
function Add()
{
 AddRow('ID');
 document.getElementById('BDAT').value = parent.acc_obj.value[37].text;
}
//Локализация
function LocalizeHtmlTitles() { 
}