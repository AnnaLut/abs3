//Необходимые переменные
var locked  = false;
var ServiceName = 'defaultWebService.asmx';
var callObj = {};
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
	
	var service = document.getElementById("webService");
	var options = {};

	if (typeof (service.createUseOptions) !== 'undefined') {
	    options = service.createUseOptions();
	}

	options.reuseConnection = true;

    if (typeof (service.useService) !== 'undefined') {
        service.useService(ServiceName + '?wsdl', 'WebService', options);
    } /*else {
        service.WebService = {};
        service.WebService.callService = function (paramObj) {
            debugger
            var serviceParam = callObj;
            $.soap({
                url: '/barsroot/clientregister/' + ServiceName + '/' ,
                method: serviceParam.funcName,
                async: serviceParam.async,
                data: serviceParam.params,

                success: function (soapResponse) {
                    debugger
                    var test = soapResponse
                    // do stuff with soapResponse
                    // if you want to have the response as JSON use soapResponse.toJSON();
                    //  r soapResponse.toString() to get XML string
                    // or soapResponse.toXML() to get XML DOM
                },
                error: function (soapResponse) {
                    debugger
                    var test = soapResponse
                    // show error
                }
            });
        }
    }*/

    //document.getElementById("webService").async = false;
	if (typeof (service.createCallOptions) !== 'undefined') {
	    callObj = service.createCallOptions();
	}
	callObj.async = false;	
				
	isInitialized = true;
}

