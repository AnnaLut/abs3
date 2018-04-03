window.onload = Init_Folder;
//***************************************************************************
function Init_Folder()
{
 v_data[10] = getParamFromUrl("nd",location.href);
 pName.innerText = " "+unescape(getParamFromUrl("name",location.href));
 window.name = pName.innerText; 
 if(v_data[10] == ""){
   alert(LocalizedString('Mes28')/*"Не задан код пачки!"*/);
   window.close();
 }
 LoadXslt('Xslt/Folder_'+getCurrentPageLanguage()+'.xsl');
 v_data[0] = '';
 v_data[1] = '';
 v_data[2] = '';
 v_data[3] = '';
 v_data[4] = 0;
 var obj = new Object();
 obj.v_serviceObjName = 'webService';
 obj.v_serviceName = 'Service.asmx';
 obj.v_serviceMethod = 'GetFolderList';
 obj.v_serviceAfterRefresh = 'TrySelect';
 fn_InitVariables(obj);	
 InitGrid();
}
//***************************************************************************
function TrySelect()
{
 if(document.getElementById("r_1")){
    document.all.dGridFolder.focus();
	document.getElementById("r_1").fireEvent("onclick");
 }
 
 var count=1;
 while(document.getElementById("s_"+count) != null){
	init_num("s_"+count);
	count++;
 }	
}	
//***************************************************************************
var nds = "";
var sums = "";
function savePos(id)
{
  var record = new Object();
  record.nd = document.getElementById('r_'+id).value;
  record.sum = document.getElementById('s_'+id).value;
  record.tt = document.getElementById('r_'+id).TT;
  nds += record.nd+";";
  sums += record.sum+";";
  return record;
}
//***************************************************************************
function PressSpace()
{
  if(event.srcElement.id.substring(0,2) == "s_"){
    if(event.keyCode == 40 || event.keyCode == 38 || event.keyCode == 13)  
       dGridFolder.focus();
  }
  if(event.keyCode == 32){
	if(document.getElementById("cb_"+row_id)){
      document.getElementById("cb_"+row_id).checked = !document.getElementById("cb_"+row_id).checked;
	  document.getElementById("cb_"+row_id).fireEvent("onclick");
    }
  }
  if(event.keyCode == 45)
    if(document.getElementById("s_"+row_id)){
		document.getElementById("s_"+row_id).focus();
		document.getElementById("s_"+row_id).select();
    }
  if(event.altKey && event.ctrlKey && event.keyCode == 65)
	fnSelAll();
  if(event.keyCode == 107)
	Applay();
  if(event.keyCode == 27)
	Close();
 }
//*************************************************************************** 
function fnSelAll()
{
 var count=1;
 while(document.getElementById("cb_"+count) != null){
	document.getElementById("cb_"+count).checked = true;
	document.getElementById("cb_"+count).fireEvent("onclick");
	count++;
 }
 dGridFolder.focus();
}
var arr = new Array();
//***************************************************************************
function Applay()
{
 var count=1,i=0;
 while(document.getElementById("r_"+count) != null){
    if(document.getElementById("cb_"+count).checked)
		arr[i++] = savePos(count);
	count++;
 }	
 
 webService.useService("Service.asmx?wsdl","Fld");
 webService.Fld.callService(onGetKomis,"GetKomis",nds,sums);
} 
function onGetKomis(result)
{
 if(!getError(result)) return; 
 var data = result.value;
 for(i=0;i<arr.length;i++)
 {
   arr[i].k_fl = data[i][1];
   arr[i].k_ul = data[i][2];
   arr[i].nls  = data[i][3];
   arr[i].nms  = data[i][4];
   arr[i].sk   = data[i][5];	
   arr[i].mfob = data[i][6];
   arr[i].okpob= data[i][7];
   arr[i].nmsb = data[i][8];
   arr[i].nlsb = data[i][9];
   arr[i].nazn = data[i][10];
   arr[i].tt   = data[i][11];
   arr[i].nak  = data[i][12];
   arr[i].acc6f= data[i][13];
   arr[i].acc6u= data[i][14];
   arr[i].acc3u= data[i][15];
   arr[i].vob  = data[i][16];
   arr[i].grp  = data[i][17];
   arr[i].sum  = data[i][18];
 }
 if(arr.length == 0) arr = null;
 window.returnValue = arr;
 document.close();
 window.close();
}
//***************************************************************************
function Close()
{
 document.close();
 window.close();
}
//***************************************************************************
function fnFocus()
{
 dGridFolder.focus();
}
//***************************************************************************