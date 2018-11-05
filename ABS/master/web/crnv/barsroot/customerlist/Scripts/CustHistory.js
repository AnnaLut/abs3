//Показать историю изменения клиента
function InitCustHistory()
{
  LocalizeHtmlTitles();
  LoadXslt("Xslt/History_" + getCurrentPageLanguage() + ".xsl");
  key = getParamFromUrl("key",location.href);
 // v_data[3] = 'h.dat desc, t.tabid, h.idupd desc';
  v_data[9] = key;
  v_data[10] = document.getElementById("date1").value;
  v_data[11] = document.getElementById("date2").value;
  //v_data[12] = mode;
  //v_data[13] = type;
  var obj = new Object();
  obj.v_serviceObjName = 'webService';
  obj.v_serviceName = 'CustService.asmx';
  obj.v_serviceMethod = 'ShowHistoryImmobile';
  obj.v_serviceFuncAfter = "LoadCustHistory";
  fn_InitVariables(obj);	
  InitGrid();
}
function LoadCustHistory()
{
  document.getElementById("date1").value = returnServiceValue[2].text;
  document.getElementById("date2").value = returnServiceValue[3].text;
  document.getElementById("lbNmk").innerText = returnServiceValue[3].text;
  if(document.getElementById("btRefresh").src == ""){
	document.getElementById("btRefresh").src = image1.src;
	document.getElementById("btClose").src = image3.src;
  }
}
//История
function fnRefreshHist()
{
  var filter = "";
  //if(document.getElementById('cmb1').value != 0) filter += "AND t.tabid="+document.getElementById('cmb1').value;
  //if(document.getElementById('cmb2').value != 0) filter += "AND c.colid="+document.getElementById('cmb2').value;
  v_data[0] = filter;
  v_data[10] = document.getElementById("date1").value;
  v_data[11] = document.getElementById("date2").value;
  ReInitGrid();
}
function fnCmb1()
{
 //if(document.getElementById('cmb1').value != ""){
 //   document.getElementById('cmb2').disabled = false;
 //   var val = document.getElementById('cmb1').value; 
 //   dd_data["cmb2"] = 'dialog.aspx?type=metatab&tail="tabid='+val+' AND colid in (select colid from acc_par where tabid='+val+')"&role=wr_metatab&tabname=meta_columns';
 //}	
}
//Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("btRefresh");
    LocalizeHtmlTitle("btClose");
}
function getValueForCmd1(ddlist)
{
 //if(ddlist.selectedIndex == 1){
 //var result = window.showModalDialog(dd_data[ddlist.id],"","dialogWidth:450px;center:yes;edge:sunken;help:no;status:no;");
 //if(result != null){
 // ddlist.options[1].value = result[0];
 // ddlist.options[1].text = result[1];
 // fnCmb1();
 // }
 //} 
}
