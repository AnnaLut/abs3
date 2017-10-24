//Список валют
var arr_kv = new Array();

function InitListValuts()
{
  //Локализация
  LocalizeHtmlTitles();
  LoadXslt("Xslt/Valuts_"+getCurrentPageLanguage()+".xsl");
  v_data[3] = 'skv';
       
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'AccService.asmx';
  obj.v_serviceMethod = 'ListValuts';
  fn_InitVariables(obj);	
  InitGrid();
 }
 function GetVal(ch)
 {
  if(ch.checked)
   arr_kv[ch.value] = ch.value;
  else 
   arr_kv[ch.value] = null;
 }
 //Запоминание выбранных валют
 function fnCloseValutes()
 {
  var array = new Array(),i=0;
  for(key in arr_kv)
  {
   if(arr_kv[key] != null)
     array[i++] = arr_kv[key];
  }
  document.close();
  window.close();
  window.returnValue = array;
 }
 //Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("btClick");
    LocalizeHtmlTitle("btDiscard");
}
