angular.module(globalSettings.modulesAreas).factory("validationService", function (utilsService, FILES_CONSTS, FILE_STATES) {

    var _checkFilesRowSum = function(validatorId, row){
        if(row === null){ return -1; }

        if(utilsService.isEmpty(row.SUM_TO_PAY) || row.SUM_TO_PAY <= 0.0){
            return FILES_CONSTS[validatorId].ID.PAY_SUM_ZERO;
        }
        return 0;
    }
    
    var _gridRowValidators = {
        files: {
            createPay: function(validatorId, row){
                var res = _checkFilesRowSum(validatorId, row);
                if(res !== 0){ return res; }

                var BALANCE_2560 = row.BALANCE_2560;
                if(utilsService.isEmpty(BALANCE_2560) || parseFloat(BALANCE_2560) < row.SUM_TO_PAY){
                    return FILES_CONSTS[validatorId].ID.BALANCE_2560;
                }
                
    
                return 0;   // OK
            },
            getBalanceRu: function(validatorId, row){
                var res = _checkFilesRowSum(validatorId, row);
                if(res !== 0){ return res; }
    
                return 0;   // OK
            },
            pay: function(validatorId, row){
                var res = _checkFilesRowSum(validatorId, row);
                if(res !== 0){ return res; }
                
                var BALANCE_2909 = row.BALANCE_2909;
                if(utilsService.isEmpty(BALANCE_2909) || row.SUM_TO_PAY > parseFloat(BALANCE_2909)){
                    return FILES_CONSTS[validatorId].ID.BALANCE_2909;
                }

                return 0;   // OK
            }
        }
    };

    return {
        validateGridRow: function (gridId, validatorId, row) {
            return _gridRowValidators[gridId][validatorId](validatorId, row);
        }
    }
});