//ListNbs.aspx
function InitListNbs()
{
  LoadXslt("Xslt/ListNbs_"+getCurrentPageLanguage()+".xsl");
    
  v_data[0] = '0';//sA
  v_data[1] = '9';//sB
  v_data[2] = 1;//length
  v_data[3] = '1';//order
  v_data[4] = 0;//pos 
  v_data[9] = new Array();
  v_data[10] = getParamFromUrl("rnk", document.location.href)
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'AccService.asmx';
  obj.v_serviceMethod = 'ListNbs';
  fn_InitVariables(obj);	
  InitGrid();
}
function fnNbuPrev()
{
 v_data[2] -= 1;
 v_data[0] = v_data[9][v_data[2]-1].split(";")[0];
 v_data[1] = v_data[9][v_data[2]-1].split(";")[1];
 ReInitGrid();
}
function fnNbuCancel()
{
 window.close();
}
function fnNbuSet()
{
 var array = new Array();
 array[0] = selectedRowId;
 array[1] = document.getElementById("n_"+row_id).innerHTML;
 window.close();
 window.returnValue = array;
}
function fnNbuNext()
{
 if(selectedRowId == null) return;
 if(v_data[2] == 4) fnNbuSet();
 v_data[9][v_data[2]-1] = v_data[0]+";"+v_data[1];
 v_data[0] = selectedRowId+'0';
 v_data[1] = selectedRowId+'9';
 v_data[2] += 1;
 ReInitGrid();
}
