window.onload = InitPage;
function InitPage()  
{  
  LoadXslt("Xslt/DataBalansAcc_"+getCurrentPageLanguage()+".xsl");
  v_data[3] = "b.nls, b.kv";
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'Service.asmx';
  obj.v_serviceMethod = 'GetDataByAcc';
  obj.v_showFilterOnStart = false;
  obj.v_filterTable = "v_balans_acc";
  v_data[10] = getParamFromUrl("par",location.href);
  v_data[11] = getParamFromUrl("val",location.href);
  v_data[12] = getParamFromUrl("nbs",location.href);
  v_data[13] = getParamFromUrl("fdat",location.href);
  v_data[14] = getParamFromUrl("tobo",location.href);
    
  var menu = new Array();
  menu["История Счета"] = "fnAccHist()";
  menu["Выписка по счету"] = "fnAccTurn()";
  obj.v_menuItems = menu;
  fn_InitVariables(obj);	
     
  InitGrid();
} 

function fnAccHist()
{
  window.location.replace("/barsroot/customerlist/showhistory.aspx?acc="+selectedRowId+"&type=1");
}

function fnAccTurn()
{
  window.location.replace("/barsroot/customerlist/accextract.aspx?type=1&acc="+selectedRowId+"&date="+(v_data[13].replace('/','.')).replace('/','.'));
}