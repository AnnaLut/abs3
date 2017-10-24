//Acc_rights.aspx
function fnLoadRights()
{
 //Локализация
 LocalizeHtmlTitles();

 var data = parent.acc_obj.value;
 acc = getParamFromUrl("acc",location.href);
 accessmode = getParamFromUrl("accessmode",location.href);
 
 if("" != data[59].text){
    
    tblNew.style.visibility = "visible";
	data[61] = new Array();
    var id,val,row;  
	for(i = 0; i < data[60].text.split("##").length - 1; i++)
	{
	  row = data[60].text.split("##")[i];
	  id = row.substring(0,row.indexOf(" "));
	  val = row.substring(row.indexOf(" ")+1);
	  
	  var oOption = document.createElement("OPTION");
	  lsGroupsAcc.options.add(oOption);
      oOption.value = id;
      oOption.innerText = id+' '+val;
	  parent.acc_obj.value[24].text = id;
	  data[61][data[61].length] = id+";0";
	} 
	if(accessmode != 1){
		lsGroupsAcc.disabled = true;			
		btAdd.style.visibility = "hidden";
		btDel.style.visibility = "hidden";
	}	
	document.body.removeChild(tblOld);
 }	
 else{   
    tblOld.style.visibility = "visible";
    document.body.removeChild(tblNew);
    dd_data["ddGroups"] = url_dlg_mod + 'groups&tail=""&field=;(id||*||name)';
	if(acc != 0){
	document.all.cbIspK.checked = (data[25].text & 1);
	document.all.cbIspD.checked = (data[25].text & 2)/2;
	document.all.cbIspV.checked = (data[25].text & 4)/4;
	document.all.cbOthK.checked = (data[26].text & 1);
	document.all.cbOthD.checked = (data[26].text & 2)/2;
	document.all.cbOthV.checked = (data[26].text & 4)/4;
	if(accessmode != 1){
		if(data[10].text != ""){
			document.all.ddGroups.disabled = true;
			document.all.cbIspD.disabled = true;
			document.all.cbIspK.disabled = true;
			document.all.cbIspV.disabled = true;
			document.all.cbOthD.disabled = true;
			document.all.cbOthK.disabled = true;
			document.all.cbOthV.disabled = true;
		 }		 
	}	
	document.all.ddGroups.options[0].text = data[50].text;
	}
 }	
}
//Проверка checkbox-ов
function CalcSeciSeco(cb1,cb2,cb3,name)
{	
   parent.edit_data.value.general.data[name] = cb1.checked*4+cb2.checked*2+cb3.checked;
   if(parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
}
function AddGrp()
{
  var result = window.showModalDialog(url_dlg + "groups_acc","","dialogWidth:600px;center:yes;edge:sunken;help:no;status:no;");
  if(null != result)
  {
   for(i=0;i<lsGroupsAcc.options.length;i++)
	  if(lsGroupsAcc.options[i].value == result[0]) return;	
	  
   var oOption = document.createElement("OPTION");
   lsGroupsAcc.options.add(oOption);
   parent.acc_obj.value[24].text = result[0];
   oOption.value = result[0];
   oOption.innerHTML = result[0]+' '+result[1];
   parent.acc_obj.value[61][parent.acc_obj.value[61].length] = result[0]+";1";
   if(parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
  } 
}
function DelGrp()
{
  parent.acc_obj.value[61][parent.acc_obj.value[61].length] = lsGroupsAcc.options[lsGroupsAcc.selectedIndex].value+";-1";
  lsGroupsAcc.options.remove(lsGroupsAcc.selectedIndex);
  if(parent.edit_data.value.general.edit == false) parent.edit_data.value.general.edit = true;
}
//Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("btAdd");
    LocalizeHtmlTitle("btDel");
}
