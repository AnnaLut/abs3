window.onload = InitPage;
function InitPage()  
{  
  LoadXslt("Xslt/DataBalansVal_"+getCurrentPageLanguage()+".xsl");
  v_data[3] = "b.kv";
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'Service.asmx';
  obj.v_serviceMethod = 'GetDataByVal';
  //obj.v_showFilterOnStart = true;
  //obj.v_filterTable = "staff";
  v_data[10] = getParamFromUrl("nbs",location.href);
  v_data[11] = getParamFromUrl("fdat",location.href);
  v_data[12] = getParamFromUrl("tobo",location.href);
    
  var menu = new Array();
  menu["Счета"] = "fnByAcc()";
  obj.v_menuItems = menu;
  fn_InitVariables(obj);	
     
  InitGrid();
} 

function fnByAcc()
{
  window.location.replace("/barsroot/balansaccdoc/balansacc.aspx?tobo="+v_data[12]+"&par=2&val="+selectedRowId+"&nbs="+v_data[10]+"&fdat="+v_data[11]);
}