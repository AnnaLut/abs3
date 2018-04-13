var count_tags = 0;
var b_folder = false;
var curr_folder;
var focus_on_elem = false;
//**********************************************************************//
function InitDefault()
{ 
 noprint = (location.search.indexOf("noprint") != -1)?(true):(false);
 fields_obj.value = new Array();
 data_obj.value = new Object();
 webService.useService("Service.asmx?wsdl","KP");

 webService.KP.callService(onPopulate,"Populate");
  
 init_numedit("tbTotal",0,2);
 init_numedit("tbNal",0,2);
 init_numedit("tbDel",0,2);
 init_numedit("curr_sum",0,2);
 init_num("MFO");
 init_num("NLSB");
 NLSB.attachEvent("onblur",fnCheckNls);
 tbTotalKol.value = 0;
}

function fnCheckNls()
{
  if(NLSB.value != checkNls(MFO.value,NLSB.value))
  {
    Dialog(LocalizedString('Mes01')/*"Неверный контрольный разряд!"*/,"alert");
    NLSB.focus();
    NLSB.select();
  }
}

function onPopulate(result){
 if(!getError(result)) return;
 
 webService.KP.callService(onGetFields,"GetFields");
  
 data_obj.value.bankday = result.value[0];
 data_obj.value.tobo = result.value[1];
 cash.value = result.value[2];
 data_obj.value.cash = result.value[2];
 data_obj.value.user_id = result.value[3];
 data_obj.value.our_mfo = result.value[4];
 data_obj.value.baseval = result.value[5];
 data_obj.value.okpo = result.value[6];
 isp.value = result.value[3];
 fio.value = result.value[7];
 cash_name.value = result.value[8];
 data_obj.value.cash_name = result.value[8];
 data_obj.value.adr = result.value[9];
 data_obj.value.bankname = result.value[10];
   
 var array = new Array();
 array[LocalizedString('Mes02')/*"Платежи по договорам"*/]="Tab_Contracts.aspx";
 array[LocalizedString('Mes03')/*"Введеные операции"*/]="Tab_Main.aspx";
 fnInitTab("webtab",array,450);
} 
//**********************************************************************//
//Обработка нажатия 
function fnGlobalHotKey(evt)
{
  if(evt == null)  evt = event;
  //F7 - новый клиент
  if(evt.keyCode == 118) btNewClient.fireEvent("onclick");
  //F8 - оплата
  if(evt.keyCode == 119) btOplata.fireEvent("onclick");
  //F9 - печать
  if(evt.keyCode == 120) btPrintAll.fireEvent("onclick");
  //ALT+1(2) - переключения страниц
  if(evt.altKey && !evt.ctrlKey && evt.keyCode != 18)
  {
    if(evt.keyCode>=49 && evt.keyCode<=50)
		goPage(document.getElementById("bTab"+(evt.keyCode-49)));
  }
}
//**********************************************************************//
//Новая пачка
function fnNewClient()
{
 data.style.visibility = 'hidden';
 mainAttr.style.visibility = 'hidden';
 cashGet.style.visibility = 'hidden';
 if(Dialog(LocalizedString('Mes04')/*"Начать новую пачку?"*/,"confirm") == 1)
 {
  ClearBasicValues();
  refs = new Array();
  var table = document.frames("Tab1").document.all.Oper;
  while(table.rows.length >1) table.deleteRow();
  goPage(document.getElementById("bTab0"));
  if(activeTab == "Tab0")
	document.frames("Tab0").document.all.dGridDog.focus();
 } 
}
//**********************************************************************//
function ClearBasicValues()
{
  allDocs = new Array();
  tbTotalKol.value = 0;
  tbFio.value = "";
  init_numedit("tbTotal",0,2);
  init_numedit("tbNal",0,2);
  init_numedit("tbDel",0,2);
  fnConvSum();
}
//**********************************************************************//
function fnConvSum()
{
 tbTotalSum.value = ConvertNumToCurr(GetValue("tbTotal"),"UAH");
 tbNalSum.value = ConvertNumToCurr(GetValue("tbNal"),"UAH");
 tbDelSum.value = ConvertNumToCurr(GetValue("tbDel"),"UAH");
}
//**********************************************************************//
function fnOplata()
{
 if(GetValue("tbTotal") == 0)
 {
  Dialog(LocalizedString('Mes05')/*"Не введено ни одного платежа!"*/,"alert");
  return;
 }
 var top = document.body.offsetHeight/2 - 150;
 var left = document.body.offsetWidth/2 - 250;
 cashGet.style.left = left;
 cashGet.style.top = top;
 cashGet.style.visibility = 'visible';
 tbNal.focus();
 tbNal.select();
 btOplAll.disabled = true;
}
//**********************************************************************//
function fnTryPay()
{
 if(event.keyCode == 13) {
    var total = GetValue("tbTotal");
    var user_cash = GetValue("tbNal");
    if(total - user_cash > 0)
	{
	  Dialog(LocalizedString('Mes06')/*"Сумма меньше требуемой!"*/,"alert");
	  tbNal.select();
	  return;
	}
	tbDel.value = user_cash - total;
	tbDel.fireEvent("onfocusout");
	fnConvSum();
	btOplAll.disabled = false;
   	btOplAll.focus();
 }
 if(event.keyCode == 27){
  tbNal.value = "0.00";
  tbDel.value = "0.00";
  fnConvSum();
  cashGet.style.visibility = 'hidden';
 }  
}
function HidePay()
{
 cashGet.style.visibility = 'hidden';
 tbNal.value = "0.00";
 tbDel.value = "0.00";
 fnConvSum();
 if(activeTab == "Tab0")
	document.frames("Tab0").document.all.dGridDog.focus();
}
//**********************************************************************//
function onGetFields(result)
{
 if(!getError(result)) return;
 fields_obj.value = result.value;
} 
//**********************************************************************//
function HideParam()
{
  data.style.visibility = 'hidden';
  mainAttr.style.visibility = 'hidden';
}
//**********************************************************************//
//Проверка суммы
function CheckSum()
{
 //Проверка реквизитов
 var check_req_str = CheckReq();
 if(check_req_str != ""){
   Dialog(check_req_str,"alert");
   return;
 }
 var currsum = GetValue("curr_sum");
 if(!CheckFields()) return;
 if(currsum == 0) {
   Dialog(LocalizedString('Mes07')/*"Ошибка суммы!"*/,"alert");
   curr_sum.focus();
   curr_sum.select();
   return;
 }  
 if(b_folder)
	ConfirmAdd();
 else{
	if(data_obj.value.nd == "") data_obj.value.nd = 0;
    if(data_obj.value.NAK == "") data_obj.value.NAK = 0;
	webService.KP.callService(onCheckSum,"CheckSum",data_obj.value.nd,currsum,data_obj.value.NAK);
  }
}
function onCheckSum(result)
{
 if(!getError(result)) return;
  if(data_obj.value.kom_f == null || data_obj.value.kom_f == 0)
	data_obj.value.kom_f = result.value[0];
 data_obj.value.kom_u = result.value[1];
 ConfirmAdd();
}
//**********************************************************************//
function ConfirmAdd()
{
 if(Dialog(LocalizedString('Mes08')/*"Добавить документ на сумму"*/ + "<br><font color=red>"+ConvertNumToCurr(GetValue("curr_sum"),"UAH")+"</font> ("+ToTxt("curr_sum")+"),<br>" + LocalizedString('Mes09')/*"комиссия с плательщика:"*/ + " <font color=green>"+ParseF(data_obj.value.kom_f)+"</font> ?","confirm") == 1)
   SaveData();
}
//**********************************************************************//
function CheckFields()
{
 for(i = 0; i < count_tags; i++ )
 {
   var elem = document.getElementById("e_"+i);
   if(elem.opt == 'M' && elem.value == ""){
     Dialog(LocalizedString('Mes10')/*"Не заполнено поле:"*/ + " <font color=red>["+elem.tagname+"]</font> !","alert");
     elem.focus();
     return false;
    }
 }
 return true;
}
//**********************************************************************//
function CheckReq()
{
  var result = "";
  if(mainAttr.style.visibility == "hidden") return result;
  if(MFO.value == "") {result = LocalizedString('Mes11')/*"Не заполнен реквизит [ МФО ]"*/;MFO.focus();} 
  else if(NLSB.value == "") {result = LocalizedString('Mes12')/*"Не заполнен реквизит [ Счет ]"*/;NLSB.focus();} 
  else if(NMSB.value == "") {result = LocalizedString('Mes13')/*"Не заполнен реквизит [ Имя счета ]"*/;NMSB.focus();}
  else if(OKPO.value == "") {result = LocalizedString('Mes14')/*"Не заполнен реквизит [ ОКПО ]"*/;OKPO.focus();}
  else if(SK.value == "") {result = LocalizedString('Mes15')/*"Не заполнен реквизит [ СК ]"*/;SK.focus();}
  else if(NAZN.value == "") {result = LocalizedString('Mes16')/*"Не заполнен реквизит [ Назначение платежа ]"*/;NAZN.focus();}
  return result;
}

//**********************************************************************//
//Сохраняем документ
function SaveData()
{
 //Сумма + коммисия
 var currsum = GetValue("curr_sum");
 if(data_obj.value.kom_f != 0) 
	currsum = ParseF(currsum) + ParseF(data_obj.value.kom_f);
 var sum = eval(GetValue("tbTotal")) + eval(currsum); 
 tbTotal.value = sum;
 tbTotal.fireEvent("onfocusout");
 fnConvSum(); 
 var docTags = new Array();
 var docParam = new Array();
 
 if(b_folder){
   var res = curr_folder;
   var i = 0;
   docTags = new Array();
   for(i = 0;i < res.length; i++)
   {
   	var j = 0;
   	var array = SearchArray(fields_obj.value,res[i].tt);
   	for(h = 0; h < count_tags; h++)
	{
		var elem = document.getElementById("e_"+h);
		for(g = 0; g < array.length; g++){
			if(array[g][1] == elem.tag)
			{
				docTags[j] = elem.tag;
				docTags[j+1] = elem.value;
				j += 2;  
				break;
			}
		}
	}
	docParam[0] = res[i].tt;
	docParam[1] = 1;
	docParam[2] = data_obj.value.cash;
	docParam[3] = data_obj.value.cash_name;
	docParam[4] = data_obj.value.our_mfo;
	docParam[5] = "";
	docParam[6] = data_obj.value.baseval;
	docParam[7] = eval(res[i].sum)*100;
	docParam[8] = data_obj.value.okpo;
	docParam[9] = res[i].nls;
	docParam[10] = res[i].nms;
	docParam[11] = data_obj.value.our_mfo;
	docParam[12] = "";
	docParam[13] = res[i].okpo;
	docParam[14] = res[i].nazn;
	if(tbFio.value != "")
		docParam[14] +=	LocalizedString('Mes17')/*". Плательщик:"*/+tbFio.value;
	if(docParam[14].length >=160) docParam[14] = docParam[14].substr(0,160);
	docParam[15] = data_obj.value.user_id;
	docParam[16] = res[i].sk;
	docParam[17] = data_obj.value.bankday;
	docParam[18] = res[i].nd;
	docParam[19] = res[i].grp;
	docParam[20] = res[i].nlsb;
	docParam[21] = res[i].nmsb;
	docParam[22] = res[i].mfob;
	docParam[23] = res[i].acc6f;
	docParam[24] = res[i].acc6u;
	docParam[25] = res[i].acc3u;
	docParam[26] = ParseF(res[i].k_fl);
	docParam[27] = ParseF(res[i].k_ul);
	docParam[28] = res[i].vob;
	docParam[29] = res[i].nak;
	docParam[30] = res[i].grp;
	var len = allDocs.length;
	allDocs[len] = CopyArray2(docParam);
	allDocs[len+1] = CopyArray2(docTags);
	
	AddToList(res[i].nazn,res[i].nms,res[i].mfob,res[i].nlsb,res[i].sum,res[i].k_fl);
	tbTotalKol.value++;
   }	
   b_folder = false;
   curr_folder = null;
 }
 else
 { 
    var s = ParseF(GetValue("curr_sum")) * 100;
	
	var j = 0;
	for(i = 0; i < count_tags; i++)
	{
		docTags[j] = document.getElementById("e_"+i).tag;
		docTags[j+1] = document.getElementById("e_"+i).value;
		j += 2;
	}
	   
	docParam[0] = data_obj.value.tt;
	docParam[1] = 1;
	docParam[2] = data_obj.value.cash;
	docParam[3] = data_obj.value.cash_name;
	docParam[4] = data_obj.value.our_mfo;
	docParam[5] = "";
	docParam[6] = data_obj.value.baseval;
	docParam[7] = s;
	docParam[8] = data_obj.value.okpo;
	docParam[9] = NLS.value;
	docParam[10] = NMS.value;
	docParam[11] = data_obj.value.our_mfo;
	docParam[12] = "";
	docParam[13] = OKPO.value;
	docParam[14] = NAZN.value
	if(tbFio.value != "")
		docParam[14] +=	LocalizedString('Mes17')/*". Плательщик:"*/+tbFio.value;
	if(docParam[14].length >=160) docParam[14] = docParam[14].substr(0,160);
	docParam[15] = data_obj.value.user_id;
	docParam[16] = SK.value;
	docParam[17] = data_obj.value.bankday;
	docParam[18] = data_obj.value.nd;
	docParam[19] = cbGroup.checked;
	docParam[20] = NLSB.value;
	docParam[21] = NMSB.value;
	docParam[22] = MFO.value;
	docParam[23] = data_obj.value.acc6f;
	docParam[24] = data_obj.value.acc6u;
	docParam[25] = data_obj.value.acc3u;
	docParam[26] = ParseF(data_obj.value.kom_f);
	docParam[27] = ParseF(data_obj.value.kom_u);
	docParam[28] = data_obj.value.vob;
	docParam[29] = data_obj.value.NAK;
	docParam[30] = data_obj.value.GRP;
	var len = allDocs.length;
	allDocs[len] = docParam;
	allDocs[len+1] = docTags;
	AddToList(NAZN.value,NMS.value,MFO.value,NLSB.value,curr_sum.value,data_obj.value.kom_f);
	tbTotalKol.value++;
	data_obj.value.kom_f = 0;	
 }
 data.style.visibility = 'hidden';
 mainAttr.style.visibility = 'hidden';
 if(activeTab == "Tab0")
	document.frames("Tab0").document.all.dGridDog.focus();
}
//**********************************************************************//
function OplataAllDocs()
{
 webService.KP.callService(onOplAllDoc,"OplDoc",allDocs);
}
//**********************************************************************//
function onOplAllDoc(result)
{
 if(!getError(result)) return;
 cashGet.style.visibility = 'hidden';
 refs =  result.value.split(';');
 var i = 1;
 while(refs[i-1])
 {
  //while();
  if(document.frames("Tab1").document.getElementById("r_"+i))
  {
	document.frames("Tab1").document.getElementById("r_"+i).ref = refs[i-1];
	document.frames("Tab1").document.getElementById("r_"+i).style.color = "navy";
	document.frames("Tab1").document.getElementById("ik_"+i).style.visibility = "visible";
	document.frames("Tab1").document.getElementById("it_"+i).style.visibility = "visible";
	document.frames("Tab1").document.getElementById("id_"+i).style.visibility = "hidden";
  }	
  i++;
 }
 
 var i,count_ref = 0;
 document.frames("Tab1").row_id = 0;
 while(true)
 {
	if(document.frames("Tab1").fnFindNextRow())
	{
		i = document.frames("Tab1").row_id;
		document.frames("Tab1").document.getElementById("r_"+i).ref = refs[count_ref++];
		document.frames("Tab1").document.getElementById("r_"+i).style.color = "navy";
		document.frames("Tab1").document.getElementById("r_"+i).style.fontWeight = "bold";
		document.frames("Tab1").document.getElementById("ik_"+i).style.visibility = "visible";
		document.frames("Tab1").document.getElementById("it_"+i).style.visibility = "visible";
		document.frames("Tab1").document.getElementById("id_"+i).style.visibility = "hidden";
	}
	else break;	
 }
 
 if(!noprint) Print(refs);
 ClearBasicValues();
 Dialog(LocalizedString('Mes18')/*"Пачка документов успешно оплачена!"*/,"alert");
 btNewClient.fireEvent("onclick");
}
//**********************************************************************//
//Add to table - oper
function AddToList(nazn,nms,mfo,nlsb,sum,k_fl)
{
 var table = document.frames("Tab1").document.all.Oper;
 var dv = document.frames("Tab1").document.all.plGrid;
 var inner = "";
 var id = table.rows.length;
 inner += "<tr ref='' onclick=\"SR("+id+")\" id='r_"+id+"'>"
 inner += "<td  align='center'>"+id+"</td>"
 inner += "<td>"+nazn+"</td>"
 inner += "<td>"+mfo+"</td>"
 inner += "<td>"+nlsb+"</td>"
 inner += "<td align='center' style='color:red'>"+sum+"</td>"
 inner += "<td align='center' style='color:green'>"+ParseF(k_fl)+"</td>"
 inner += "<td><img id='id_"+id+"' title='" + LocalizedString('Mes19') /*Удалить операцию(DEL)*/ + "' src='/Common/Images/DELREC.gif' onclick=DelRow('r_"+id+"',"+sum+","+k_fl+") ></td>"
 inner += "<td><img id='it_"+id+"' style='visibility:hidden' title='" + LocalizedString('Mes20') /*Распечатать тикет(ALT+CTRL+P)*/ + "' src='/Common/Images/PRINT.gif' onclick=PrintRow('r_"+id+"') ></td>"
 inner += "<td><img id='ik_"+id+"' style='visibility:hidden' title='" + LocalizedString('Mes21') /*Карточка документа(ALT+CTRL+D)*/ + "' src='/Common/Images/OPEN_.gif' onclick=ShowDoc('r_"+id+"') ></td>"
 inner += "<td><img id='io_"+id+"' title='" + LocalizedString('Mes22') /*Напечатать оттиск(ALT+CTRL+T)*/ + "' src='/Common/Images/DOC.gif' onclick=parent.PrintOttisk('"+escape(nms)+"',"+sum+","+k_fl+") ></td>"
 inner += "</tr>" 
 dv.innerHTML = dv.innerHTML.substr(0,dv.innerHTML.length-16)+inner+"</TBODY></TABLE>";	
}
//**********************************************************************//
function PrintAll()
{ 
  //refs[0] = "12555707";
  //refs[1] = "";
  //refs[2] = "";
  Print(refs);
}
function Print(rfs)
{
 if(rfs.length != 0)
   webService.KP.callService(onPrint,"GetFilesForPrint",rfs);
}
function onPrint(result)
{
  if(!getError(result)) return;
  var key = "print_now&";
  var top = window.screen.height+100;
  var left = window.screen.width/2 - 180;
  if("" == key) top = window.screen.height/2-100;
  var filename = "";
  for(i = 0; i < result.value.split(';').length-1; i++)
  {
     filename = result.value.split(';')[i];
     window_print = window.open("dialog.aspx?"+key+"type=print_tic&filename="+filename,"","height=200px,width=350px,status=no,toolbar=no,menubar=no,location=no,left="+left+",top="+top);
  }   
}
function PrintOttisk(nms,sum,kom)
{
 nms = unescape(nms);
 sum += LocalizedString('Mes23')/*" грн, ком. "*/;
 kom += LocalizedString('Mes24')/*" грн"*/;  
 var d = new Date();
 var s_date = d.getDate()+"/"+(d.getMonth()+1)+"/"+d.getFullYear()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
 var vals = data_obj.value.our_mfo + '~' + data_obj.value.bankname + '~' + data_obj.value.adr + '~' +s_date + '~' + document.getElementById("tbFio").value + '~' + nms + '~' + sum + '~' + kom + '~' + fio.value;
 webService.KP.callService(onPrintOtttisk,"GetFilesForOttisk","MFOA~NBA~ADR~TIME~FIO1~NMK~SUMB~SUMBK~FIO",vals,ottisk_name);
}
function onPrintOtttisk(result)
{
 if(!getError(result)) return;
 var filename = result.value;
 window.open("dialog.aspx?print_now&type=print_tic&filename="+filename,"","height=10px,width=350px,status=no,toolbar=no,menubar=no,location=no,top="+window.screen.height+100);
}
//**********************************************************************//
function fnTrySave()
{
 if(event.keyCode == 13){
   if(document.activeElement.id == "curr_sum")
		btSave.fireEvent("onclick");
 }
 if(event.keyCode == 27){
  data.style.visibility = 'hidden';
  mainAttr.style.visibility = 'hidden';
  document.frames("Tab0").document.all.dGridDog.focus();
 }  
}
//**********************************************************************//
function fnGetMfo()
{
 if(MFO.value != "")
	webService.KP.callService(onGetMfo, "getMfo",MFO.value);
}
function onGetMfo(result)
{
 if(!getError(result)) return;
 if(result.value == ""){
	  MFO.value = "";
	  NB.value = "";
	  Dialog(LocalizedString('Mes25')/*"Несуществующий МФО!"*/,"alert");
 }
 else NB.value = result.value;
}
//**********************************************************************//
function fnGetList()
{
 var result = window.showModalDialog("dialog.aspx?type=metatab&tail='nvl(blk,0) not in (4)'&role=wr_kp&tabname=banks","","dialogWidth:550px;center:yes;edge:sunken;help:no;status:no;"); 
 if(result != null) {
   MFO.value = result[0];
   NB.value = result[1];
 }  
}
//**********************************************************************//
function fnShowAliens()
{
 if(!NLSB.disabled){
	var result = window.showModalDialog("dialog.aspx?type=metatab&tail='kv=980'&role=wr_kp&tabname=alien","","dialogWidth:550px;center:yes;edge:sunken;help:no;status:no;");   
	if(result != null) {
		NLSB.value = result[0];
	    NMSB.value = result[1];
	}
 }
}
//**********************************************************************//
function fnGetOkpo()
{
 if(NLSB.value != "")
 {
   webService.KP.callService(onGetOkpo, "getOkpo",NLSB.value);
 }
}
function onGetOkpo(result)
{
 if(!getError(result)) return;
 OKPO.value = result.value;
}
//**********************************************************************//
//Nls
function fnGetNls()
{
  if(NLSB.value != "" && NLSB.value != checkControlRank(MFO.value,NLSB.value) )
  {
	Dialog(LocalizedString('Mes26')/*"Неверный контрольный разряд!"*/,"alert");
	NLSB.value = "";
	document.getElementById('NLSB').focus();
  }
  if(NLSB.value != "" && data_obj.value.our_mfo == MFO.value)
    	webService.KP.callService(onGetNls, "getNls",NLSB.value);
}
    	
function onGetNls(result) 
{
 if(!getError(result)) return;
  NMSB.value = result.value[0];
  OKPO.value = result.value[1];
}
//**********************************************************************//
//SK
function fnSKList()
{
 var result = window.showModalDialog("dialog.aspx?type=metatab&tail='-sk>-40'&role=wr_kp&tabname=sk","","dialogWidth:550px;center:yes;edge:sunken;help:no;status:no;"); 
 if(result != null) {
   SK.value = result[0];
   SKN.value = result[1];
 }  
}
//**********************************************************************//
function fnGetSK()
{
 if(SK.value != "")
	webService.KP.callService(onGetSK, "getSK",SK.value);
}
function onGetSK(result) {
 if(!getError(result)) return;
	if(result.value == ""){
	  SK.value = "";
	  SKN.value = "";
	  Dialog(LocalizedString('Mes27')/*"Несуществующий СКП!"*/,"alert");
	}
	else SKN.value = result.value;
}
//**********************************************************************//
function fnSetFio(obj)
{
 tbFio.value = obj.value;
}
//**********************************************************************//
function fnGetInfo(obj)
{
 if(obj.value != "" && !b_folder)
	webService.KP.callService(onGetInfo, "getInfo",obj.value,data_obj.value.tt);
}
function onGetInfo(result)
{
    if(result.error) return;
	var data = result.value;
	if(data[0] == "NULL")
		Dialog(data[1],"alert");
	else
	{
	 tbFio.value = data[0];
	 if(id_fio != null)
		document.getElementById("e_"+id_fio).value = data[0];
	 if(data[1] != "") SetValue("curr_sum",data[1]);
	 var index = 2; 
	 while(data[index])
	 {
	   var tag = data[index].split(';')[0];
	   var val = data[index].split(';')[1];
	   var i = 0;
	   while(document.getElementById("e_"+i))
	   {
	     if(document.getElementById("e_"+i).tag == tag){
	        document.getElementById("e_"+i).value = val;
            break;
	     } 
	     i++;  
	   }
	   index++;
	 }
	 document.getElementById("curr_sum").focus();
	}
}
//**********************************************************************//
function checkControlRank(mfo,nls0)
{ 
   var nls=nls0.substring(0,4)+'0'+nls0.substring(5, nls0.length );
   var m1 = '137130'         ;
   var m2 = '37137137137137' ;
   var  j = 0                ;
   for ( var i = 0; i < mfo.length; i++ )
       { j =j +  parseInt(mfo.substring(i,i+1)) * parseInt(m1.substring(i,i+1)); }

   for ( var i = 0; i < nls.length; i++ )
       { j =j +  parseInt(nls.substring(i,i+1)) * parseInt(m2.substring(i,i+1)); }
         
   return nls.substring(0,4) +
          (((j + nls.length ) * 7) % 10 ) +
          nls.substring(5, nls.length );
}
//**********************************************************************//
var total_is = false;
var total_id = false;
function fnFormula(obj)
{
  total_is = false;
  var f_count = 0;
  var f_array = new Array();
  var g_array = new Array(); 
  for(i = 0; i < count_tags; i++)
  {
	var elem = document.getElementById("e_"+i);
	g_array["#("+elem.tag+")"] = new Object();
	g_array["#("+elem.tag+")"].tag = elem.tag;
	g_array["#("+elem.tag+")"].val = elem.value;
	if(elem.tag == "TOTAL"){ total_is = true;total_id = elem.id;}
	if(elem.formula){
		f_array[f_count] = new Object();
		f_array[f_count].formula = elem.formula;
		f_array[f_count].id = elem.id;
		f_count++;
	}	
  }
  	
  for(i = 0; i < f_count; i++ )
    document.getElementById(f_array[i].id).value = CalcFormula(f_array[i].formula,g_array);
  obj.select();  
}
//**********************************************************************//
function CalcFormula(formula,g_array)
{
  var tmp = formula,i=0,str;
  var list = new Array();
  while(tmp != "")
  {
    str = tmp.substr(tmp.indexOf('#('),tmp.indexOf(')')-tmp.indexOf('#(')+1);
    list[i++] = str;
    tmp = tmp.replace(str,"");
    if(tmp.indexOf("#") == -1) tmp = "";
  }
  for(j = 0; j < i; j++ )
  { 
    formula = formula.replace(list[j],g_array[list[j]].val); 
  }
  try
  {
    formula = eval(formula);
    formula = (Math.round(formula * 100) / 100).toString();
  }
  catch(e){
	formula = "";
  }	
  return formula;
}
//**********************************************************************//
function fnCheckTotal()
{
 if(total_is){
  if(document.getElementById(total_id).value != "")
	curr_sum.value = document.getElementById(total_id).value;
 } 	
 curr_sum.select();	
}
//**********************************************************************//
function fnArrow(tb)
{
 var num = tb.id.substr(2),id;
 //left
 if(event.keyCode == 37)
 {
   if(count_tags < 8) return;
   var half = Math.round(count_tags/2);
   id = eval(num) - half;
 }
 //up
 else if(event.keyCode == 38)
 {
	id = eval(num) - 1;
 }
 //right
 else if(event.keyCode == 39)
 {
   if(count_tags < 8) return;
   var half = Math.round(count_tags/2);
   id = eval(num) + half;
 }
 //down
 else if(event.keyCode == 40)
 {
   id = eval(num) + 1;
 }
 if(document.getElementById("e_"+id)){
	document.getElementById("e_"+id).focus();
	document.getElementById("e_"+id).select();
 }
}
//**********************************************************************//
function fnFocusDef()
{
  if(data.style.visibility == 'visible'){
	if(focus_on_elem){
	  if(document.all.e_0) document.all.e_0.focus();
	  else document.all.btSave.focus();
	  focus_on_elem = false;
	}
  }	
}