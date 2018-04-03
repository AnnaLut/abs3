function Begin()
{
	webService.useService("Service.asmx?wsdl","Repl");
	webService.Repl.callService(onBeginReplication,"BeginReplication");	
	fnShowProgress();		
	if(!isPostBack) FillGrid();
	else ReInitGrid();	
}
function onBeginReplication(result)
{
	if(!getError(result)) return;
	document.getElementById('btReplicate').disabled = true;
}
function getError(result)
{
	if(result.error){
		location.replace("dialog.aspx?type=err");
		return false;
	}
	return true;
}
//--------------------------------------------------------------
//XML объекты для работы с ответом сервиса.

//Ссылки на таймеры
var intervalID;
var activityTimerID;
var iCallID;
var optionsAsync;

function Init() 
{
	optionsAsync = webService.createUseOptions();
	optionsAsync.reuseConnection = true;
	webService.useService("Service.asmx?wsdl","Sync",optionsAsync);
	webService.async = true;
	intervalID = window.setInterval("CallSynchronizer()", 5000);
}

var isPostBack = false;

function CallSynchronizer()
{
	webService.showProgress = false;
	if(!isPostBack) FillGrid();
	else ReInitGrid();
	webService.showProgress = true;
}
function onSynchronize(result) {
	if(!getError(result)) return;
	{
		try	{	
			if(!isPostBack) FillGrid();
			else ReInitGrid(); 
		}
		finally	{;}	
	}
}
function Dispose()
{
	window.clearInterval(intervalID);
	window.clearTimeout(activityTimerID);
}

function FillGrid()
{
	LoadXslt('Dat.xsl');
  	var obj = new Object();
	obj.v_serviceObjName = 'webService';
	obj.v_serviceName = 'Service.asmx';
	obj.v_serviceMethod = 'GetLog';
	obj.v_serviceFuncAfter = "SetVals";	
	fn_InitVariables(obj);	
	InitGrid();
	isPostBack = true;			
}

function SetVals()
{
	var obj = returnServiceValue[2].text.split('%');
		
	document.getElementById('textRequest').value = obj[0];
	document.getElementById('textBegin').value = obj[1];
	document.getElementById('textEnd').value = obj[2];
	document.getElementById('textStatus').value = obj[3];
	
	if (obj[2] != '' && obj[2] != null)
	{
		hideProgress();
		Dispose();
	}
}

var _mProg = null;

function hideProgress()
{
	if (_mProg == null || _mProg.parentElement == null)
		return;
	document.body.removeChild(_mProg);
}
function fnShowProgress()
{
	if (_mProg == null)
	{
		var top = document.body.offsetHeight/2 - 15;
		var left = document.body.offsetWidth/2 - 50;

		var s = '<div style="position: absolute; top:'+top+'; background:white; left:'+left+'; width:101; height:33;" >'+
		''+
		'</div>';
		_mProg = document.createElement(s);
		_mProg.innerHTML = '<img src=/Common/Images/process.gif>';
	}
	
	_mProg.style.top = document.body.offsetHeight/2 - 15;
	_mProg.style.left = document.body.offsetWidth/2 - 50;
	
	if (_mProg.parentElement == null)
		document.body.insertAdjacentElement("beforeEnd",_mProg);
}



