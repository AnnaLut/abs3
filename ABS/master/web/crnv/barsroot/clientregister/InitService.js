//Необходимые переменные
var locked  = false;
var ServiceName = 'defaultWebService.asmx';
var callObj;
var strLockMsg = LocalizedString('Mes01');//"Сервис заблокирован. Попробуйте снова через несколько секунд.";
var isInitialized = false;

//window.onload = FullInit;

function FullInit()
{
 	Init();
	// document.getElementById('webService').onserviceavailable = InitObjects;
}
function Init()
{
	locked = true;
	
	var options = document.getElementById("webService").createUseOptions();
	options.reuseConnection = true;
	document.getElementById("webService").useService(ServiceName + '?wsdl','WebService',options);	
	//document.getElementById("webService").async = false;
	callObj = document.getElementById("webService").createCallOptions();
	callObj.async = false;	
				
	isInitialized = true;
}

