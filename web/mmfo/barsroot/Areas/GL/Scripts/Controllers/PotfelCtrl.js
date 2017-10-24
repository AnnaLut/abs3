angular.module(globalSettings.modulesAreas)
    .constant("PortfelConfig", {
        "ndiFinDeb": "/ndi/referencebook/GetRefBookData/?tableName=FIN_DEBVC&accessCode=0&sPar=[CONDITIONS=>FIN_DEBVC.PROD=:NBS_N]",
        "ndiNewCreditsUO": "/ndi/referencebook/GetRefBookData/?tableName=V_CCK_NU&accessCode=1&sPar=[NSIFUNCTION][showDialogWindow=>false]",
        "ndiNewCreditsFO": "/ndi/referencebook/GetRefBookData/?tableName=CC_V_0&accessCode=1&sPar=[NSIFUNCTION]",
        "ndiElServices": "/ndi/referencebook/GetRefBookData/?tableName=E_DEAL_META&accessCode=1",
    })
	.controller('PortfelController', ['$scope', 'PortfelConfig', function($scope, config) {
	
	    function SelectFunc(MOD_ABS, NBS_N) {
	        debugger;
	        var selectedURL = ''
	        if (MOD_ABS === 0 || MOD_ABS === 1)
	            selectedURL = config.ndiFinDeb
	        if(MOD_ABS === 2)
	            selectedURL = config.ndiNewCreditsUO
	        if(MOD_ABS === 3)
	            selectedURL = config.ndiNewCreditsFO
	        if(MOD_ABS === 4)
	            selectedURL = config.ndiElServices
	        return selectedURL
	    }
	    $scope.Browselink = function (MOD_ABS, NBS_N) {
	        debugger;
	        var Url = bars.config.urlContent(SelectFunc(MOD_ABS, NBS_N));
	        window.location = Url;
	    }

	}]);
