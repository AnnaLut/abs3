window.onload = Init;
window.onbeforeunload = Dispose; 

//Переменная отвечающающая за синхронизацию доступа к веб сервису.
var locked = false;
//XML объекты для работы с ответом сервиса.

//Ссылки на таймеры
var intervalID;
var intervalID2;
var activityTimerID;
var activityTimerID2;
var iCallID;
var optionsAsync;
//часовой интервал проверки банковской даты(в мсек);
var timeOutCheckBankDate = 30000;
//Переменній для использования из-вне
var oSigner = null; // для хранения объекта ActiveX
//--------------------------------------------------------------
//Intitialize webservice object
function Init() 
{
	optionsAsync = webService.createUseOptions();
	optionsAsync.reuseConnection = true;
	webService.useService("SyncHead.asmx?wsdl","SyncHead",optionsAsync);
	webService.async = true;
	if(document.getElementById("hGlobalTimeout"))
	    timeOutCheckBankDate = parseFloat(document.getElementById("hGlobalTimeout").value)*1000;
	intervalID = window.setInterval("CallSynchronizer()", timeOutCheckBankDate);
	//Edocs
	if(EDocsActive.value == "On")
	{
	   intervalID2 = window.setInterval("CheckEDocs()", parseFloat(EDocsTimeOut.value)*1000);
	}
	
	LocalizeHtmlTitles();
}

function CheckEDocs()
{
  if(parent.main.location.href.indexOf("DocExport.aspx") > 0 )
    return false;
  webService.showProgress = false;
  webService.SyncHead.callService(onCheckEDocs, "CheckEDocs");
}
function onCheckEDocs(result)
{
 if (result.error) {	  
		HandleError(result);
 } 
 else if(!result.error){
  if( result.value != "" )
  {
        window.clearInterval(intervalID2);
        var res = window.showModalDialog("dialog.aspx?type=confirm&message="+escape(LocalizedString('Mes11')), null, 
          "dialogWidth:400px; dialogHeight:150px; center:yes; status:no; resizable:no; help:no;");
        
        if (res==1)  
          parent.main.location = "/barsroot/docinput/docexport.aspx?type="+result.value;
        intervalID2 = window.setInterval("CheckEDocs()", parseFloat(EDocsTimeOut.value)*1000);  
  }
 }
}

var periodCheckVisa = 20;
var curCheckVisa = 0;
var needCheckVisa = "0";
function CallSynchronizer()
{
	if (locked)
	{
		activityTimerID = window.setTimeout("CallSynchronizer()",timeOutCheckBankDate);
		return;
	}
    curCheckVisa ++;
    if(curCheckVisa >= periodCheckVisa) 
    {
      needCheckVisa = "1";
      curCheckVisa = 0;
    }
    else
      needCheckVisa = "0";  
	locked = true;	
	webService.showProgress = false;
	iCallID = webService.SyncHead.callService(onSynchronize, "GetHeadData", 
			  window.document.getElementById("textBankDate").value,needCheckVisa);
	webService.showProgress = true;
}

function onSynchronize(result)
{
	if (result.error) {	  
		locked = false;
		HandleError(result);
	} else{
			try
			{	
				var heads = result.value;
				if(heads[0] == "closeBankdate")
				{
				    parent.location.reload();
				    return;
				}
				var new_date = heads[0];
				var new_tobo = heads[1];
				var old_date = window.document.getElementById("textBankDate").value;
				var isBankDateAccessible = heads[4];
				var isCanUserChangeDate = heads[5];
				if(isBankDateAccessible == 0 && isCanUserChangeDate == 1)
				{
				    alert(LocalizedString('Mes12'));
				    parent.location.replace("/barsroot/barsweb/loginpage.aspx?changedate=on");
				}
				if(new_date != old_date) {
				    window.document.getElementById("textBankDate").value   = new_date;
					alert(/*"Банковская дата изменена!*/ LocalizedString('Mes1') + "\n\n"+
						LocalizedString('Mes2') + /*"Старая дата:*/"\t "+old_date+"\n"+
						LocalizedString('Mes3') + /*"Новая дата:*/"\t "+new_date
					);					
				}
				if(heads[2] != "")
				{
				  var data = heads[2].split(';');
				  var message = LocalizedString('Mes8');//"Произошло изменение остатка счетов:";
				  for(i=0;i<data.length-1;i++)
				  {
				    message += "\n     "+(i+1)+". "+LocalizedString('Mes9')+" "+data[i].split(',')[1]+"("+data[i].split(',')[2]+")"; 
				  }
				  alert(message);
				}
				if(heads[3] == "1")
				{
				  alert(LocalizedString('Mes10'));//"Присутствуют незавизированные документы на контроле");
				}
			}finally
			{
				locked = false;
			}	
	}
}

function HandleError(result) {
	var xfaultcode   = result.errorDetail.code;
	var xfaultstring = result.errorDetail.string;    
	var xfaultsoap   = result.errorDetail.raw;
	if(document.all.hCustomAuthentication.value == "On")
	{
	  parent.location.reload();
	  return;
	}
	alert(xfaultcode+"\n"+xfaultstring+"\n"+xfaultsoap);
}

function Dispose()
{
	locked = true;
	window.clearInterval(intervalID);
	window.clearTimeout(activityTimerID);
}

var origCols;
function toggleFrame()
{
 var frameset = parent.document.getElementById("masterFrameset");
 if(origCols){
    document.getElementById("imgHSMenu").title = LocalizedString('Mes4');//"Спрятать меню приложений";
    document.getElementById("imgHSMenu").src = "images/hide_menu.gif"; 
    frameset.cols = origCols;
    origCols = null;
 }
 else{
  	origCols = frameset.cols;
  	frameset.cols = "0,*";
  	document.getElementById("imgHSMenu").src = "images/show_menu.gif"; 
  	document.getElementById("imgHSMenu").title = LocalizedString('Mes5');//"Показать меню приложений";
 }
} 

function toggleImg()
{
  if(document.getElementById("imgCompanyLogo").style.visibility == "hidden"){
	document.getElementById("imgHSLogo").title = LocalizedString('Mes6');//"Спрятать логотип";
	document.getElementById("imgHSLogo").src = "images/hide_menu.gif"; 
	document.getElementById("imgCompanyLogo").style.visibility = "visible";
	document.getElementById("imgCompanyLogo").style.height = null;
  }
  else
  {
	document.getElementById("imgHSLogo").title = LocalizedString('Mes7');//"Показать логотип";
	document.getElementById("imgHSLogo").src = "images/show_menu.gif"; 
	document.getElementById("imgCompanyLogo").style.visibility = "hidden";
	document.getElementById("imgCompanyLogo").style.height = 0;
  }
} 

//
var last_top_app = null;
		       
function GetHref()
{
	return parent.main.location.href;
}
function ChangeTobo()
{
	parent.location.replace('SetToboCookie.aspx');
}  
function go(url)
{
	parent.visit_urls = new Array();
	if(last_top_app) last_top_app.className = "";
	last_top_app = event.srcElement;
	last_top_app.className = "inset"; 	
	if(parent.frames['contents'].last_select_app)parent.frames['contents'].last_select_app.className = "";
	//Очищаем состояние всех фильтров
	document.getElementById("global_obj").value = null;
	
	parent.frames['main'].location.replace(url);
}
function goBack()
{
	var length = parent.visit_urls.length; 
	if(length == 1){
		if(last_top_app) last_top_app.className = "";
		if(parent.frames['contents'].last_select_app) parent.frames['contents'].last_select_app.className = "";
		if(parent.location.search.indexOf('welcomePage=') > 0)
			parent.frames['main'].location.replace(parent.location.search.substr(parent.location.search.indexOf('welcomePage=')+12));
		  else 	
			parent.frames['main'].location.replace("welcome.aspx");
		parent.visit_urls = new Array();
	}
	else{
		parent.visit_urls.pop();
		parent.frames["main"].location.replace(parent.visit_urls[parent.visit_urls.length-1]);
		parent.isHist = true;
	}	
}
function showOptions()
{
    window.showModalDialog('OptionList.aspx?key='+Math.random(),'','dialogHeight: 400px; dialogWidth: 610px; center: yes; status: off; edge: sunken; help: no;');
    parent.frames.main.location.reload();
    parent.frames.header.location.reload();
}
function LocalizeHtmlTitles() {
    LocalizeHtmlTitle('imgHSLogo');
    LocalizeHtmlTitle('imgHSMenu');
    LocalizeHtmlTitle('lnkBack');
    LocalizeHtmlTitle('imgBack');
    LocalizeHtmlTitle('ed_Tobo');
}

function ChangeSchema()
{ 
  webService.SyncHead.callService(onChangeSchema, "ChangeSchema",document.getElementById("ddCScheme").value);
}
function onChangeSchema(result)
{
   if (result.error)
    HandleError(result);
   else
   {
    parent.frames.main.location.replace('/barsroot/barsweb/welcome.aspx');
    parent.frames.header.location.reload();
    parent.frames.contents.location.reload();
   }
}