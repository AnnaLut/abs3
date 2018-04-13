window.attachEvent("onload",InitAcrInt);

var state  = 0;
var par; 
var maxFdat;
var dVdat;
var CP_;
var baseval;
var buildRep = false;
function InitAcrInt()
{
  HideImg(document.all.btIns);
  HideImg(document.all.btViewFile);

  webService.useService("BasicService.asmx?wsdl","BS");
  var par = getParamFromUrl("par",location.href);
  CP_ = par;
  if('Ц' == par) par = 'S';
  webService.BS.callService(onGetGlobalData, "GetGlobalData",par);
  LoadXslt('Xslt/AcrInt.xsl');
  var filt = unescape(location.search.substr(location.search.indexOf('&flt=')+5));
  if(filt == 'null') filt = '';
  v_data[2] = filt;
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'BasicService.asmx';
  obj.v_serviceMethod = 'GetAcrIntData';
  obj.v_showFilterOnStart = false;
  obj.v_filterTable = "saldo";
  
  var menu = new Array();
  menu[document.all.btDetails.title] = "fnDetails()";
  menu[document.all.btDel.title] = "fnDel()";
  menu[document.all.btSave.title] = "fnSave()";
  menu[document.all.btAccrue.title] = "fnAccrue()";
  menu[document.all.btShowProv.title] = "fnShowProv()";
  menu[document.all.btProvodki.title] = "fnProvodki()";
  menu[document.all.btCompress.title] = "fnCompress()";
  obj.v_menuItems = menu;
  fn_InitVariables(obj);
  InitGrid(true);
 }

function onGetGlobalData(result) 
{
  if(!getError(result)) return;
  
  document.all.tbDatFor.value = result.value[0];
  par = result.value[1];
  if(result.value[2] == "1")
	document.all.tbDatFor.disabled = true;
  maxFdat = result.value[3];
  dVdat = result.value[4];
  baseval = result.value[5];
  v_data[9] = baseval;
  v_data[10] = dVdat;
  v_data[11] = result.value[2];
  fnAccrue();	
}
 
//Показать \ Спрятать проводки
function fnShowProv() 
{
 HidePopupMenu(); 
 if(0 == state)
 {
   LoadXslt('Xslt/AcrIntProv.xsl');
   RefreshGrid();
   document.all.btShowProv.title = "Показать начисленные %";
   state = 1;
 }
 else
 {
   LoadXslt('Xslt/AcrInt.xsl');
   RefreshGrid();
   document.all.btShowProv.title = "Показать проводки по %";
   state = 0;
 }
}
//Начислить проценты по указаную дату включительно
function fnAccrue()
{
  HidePopupMenu(); 
  var str = (v_data[0]=='')?(", все счета?"):(", используя фильтр?");
  var message = "Начислить %% по "+document.all.tbDatFor.value + str;
  if(Dialog(message,"confirm") == 1)
  {
	if(maxFdat != ""){
		message = 'Виконати нарахування "Коригуючими" операціями за '+maxFdat+' ?';
		if(Dialog(message,"confirm") == 1) {}
	}	
	v_data[12] = document.all.tbDatFor.value;
	v_data[13] = CP_;
	webService.BS.callService(onAcrIntProcess, "AcrIntProcess",v_data);
  }
}
function onAcrIntProcess(result)
{
 if(!getError(result)) return;
 ReInitGrid();
}
//Filter
function fnFilter()
{
  HidePopupMenu(); 
  ShowModalFilter();
}
//Refresh
function fnRefresh()
{
   HidePopupMenu(); 
   ReInitGrid();
}
//Condencing of rate history
function fnCompress()
{
  HidePopupMenu();
  webService.BS.callService(onCompressRate, "CompressRate",v_data);
}
function onCompressRate(result)
{
 if(!getError(result)) return;
 ReInitGrid();
}
//Provodki
function fnProvodki()
{
  HidePopupMenu();
  var res = 0;
  res = window.showModalDialog("DialogAcrInt.htm","","dialogHeight:150px;dialogWidth:500px;scroll:no;center:yes;edge:sunken;help:no;status:no;");
  if(res == 2)
  {
    if(Dialog("Вы уверены, что без ПРОВОДОК?","confirm") != 1) return;
    else if(Dialog("","psw") != 1) return;
  }
  if(res == null || res == 3) return;
  v_data[14] = res;
  if(!buildRep) fnBuildRep();
  webService.BS.callService(onRunAccrueInt, "RunAccrueInt",v_data);
}
function onRunAccrueInt(result)
{
 if(!getError(result,1)) return;
 ReInitGrid();
}
//Del
function fnDel()
{
  webService.BS.callService(onDelRow, "DelRow",multSelRows);
  HidePopupMenu();
}
function onDelRow(result)
{
  if(!getError(result,1)) return;
  ReInitGrid();
}
//Ins
function fnSave()
{
  webService.BS.callService(onSaveTable, "SaveTable",selectedRowId,selectedRow.acrd,selectedRow.nazn);
  HidePopupMenu();
}
function onSaveTable(result)
{
  if(!getError(result,1)) return;
}
//Details
function fnDetails()
{
  HidePopupMenu();
  window.showModalDialog("ProcAccounts.aspx?acc="+selectedRow.acc,"","dialogHeight:600px;dialogWidth:800px;scroll:no;center:yes;edge:sunken;help:no;status:no;");
}
//
function fnPrintVed()
{
  window.open('Print.htm?key='+keyForPrint,null,'height='+(window.screen.height-200)+',width='+(window.screen.width-10)+',left=0,top=0');
  HidePopupMenu();
}
//
function fnViewFile()
{
  window.open('Print.htm?key='+keyForPrint,null,'height='+(window.screen.height-200)+',width='+(window.screen.width-10)+',left=0,top=0');
  HidePopupMenu();
}
//
function fnBuildRep()
{
  webService.BS.callService(onBuildRep, "BuildRep",v_data,par);
  HidePopupMenu();
}
var keyForPrint;
function onBuildRep(result)
{
  if(!getError(result,1)) return;
  keyForPrint = result.value;
  UnHideImg(document.all.btViewFile);
  buildRep = true;
}