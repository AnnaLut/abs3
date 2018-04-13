var nls = null; 
function InitAccHist()
{
	LoadXslt("Xslt/FinHistory_" + getCurrentPageLanguage() + ".xsl");
	var obj = new Object();
	v_data[3] = "a.fdat desc";

	v_data[10] = getParamFromUrl("acc", location.href);;
	v_data[11] = document.getElementById('ed_strDt_TextBox').value;
	v_data[12] = document.getElementById('ed_endDt_TextBox').value;
	v_data[13] = getParamFromUrl("type", location.href);;

	obj.v_serviceObjName = 'webService';	
	obj.v_serviceName = 'CustService.asmx';	
	obj.v_serviceMethod = 'GetDataHistory';	
	obj.v_enableViewState = false;			
	obj.v_serviceFuncAfter = "SetTilte";

	fn_InitVariables(obj);
	InitGrid();
	IniDateTimeControl("ed_strDt");
	IniDateTimeControl("ed_endDt");
}
function SetTilte()
{
  document.getElementById("Title").innerText = returnServiceValue[2].text;
  nls = returnServiceValue[3].text;
}
function IniDateTimeControl(name)
{
 window[name] = new RadDateInput(name, "Windows");			                    
 window[name].PromptChar=" ";
 window[name].DisplayPromptChar="_";
 window[name].SetMask(rdmskr(1, 31, false, true),rdmskl('.'),rdmskr(1,12, false, true),rdmskl('.'),rdmskr(1, 2999, false, true));		
 window[name].RangeValidation=true;
 window[name].SetMinDate('01.01.1980 00:00:00');
 window[name].SetMaxDate('31.12.2099 00:00:00');
 window[name].SetValue(document.getElementById(name+"_TextBox").value);
 window[name].Initialize();
}
//показывает карточку счета
function OpenAccExtract(acc, date)
{
    var type = getParamFromUrl("type",location.href);
    //location.replace('AccExtract.aspx?type=' + type + '&acc=' + acc + '&date=' + date);
    document.location.href = 'AccExtract.aspx?type=' + type + '&acc=' + acc + '&date=' + date;
}
//Отрабатываем нажатие кнопки после изменения дат
function bt_AcceptDates_click()
{
	v_data[11] = document.getElementById('ed_strDt_TextBox').value;
	v_data[12] = document.getElementById('ed_endDt_TextBox').value;
	ReInitGrid();
}
//Печать выписки
function printExtract(format)
{
	window.open('/barsroot/crystalreports/default.aspx?template=0&format='+format+'&nls='+nls+'&dateb='+document.getElementById('ed_strDt_TextBox').value+'&datee='+document.getElementById('ed_endDt_TextBox').value,null,'height='+(window.screen.height-200)+',width='+(window.screen.width-10)+',left=0,top=0');
}
//Локализация
function LocalizeHtmlTitles() { 
    LocalizeHtmlTitle("btShow");
    LocalizeHtmlTitle("btOpen");
}