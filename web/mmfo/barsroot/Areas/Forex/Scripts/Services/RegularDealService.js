angular.module('BarsWeb.Controllers')
.factory('RegularDealService', ['$http', '$q', function ($http, $q) {

    var config = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        }
    };

    var getCurrencyNameA = function (kv) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetCurrencyProp?kv=" + kv);

        $http.get(url, config)
            .success(function (data, status, headers, config) {

                deferred.resolve(data);

            }).error(function (data, status, headers, config) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var getTransactionLengthType = function (datCurr,datA,datB) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetTransactionLengthType?datCurr=" + datCurr + "&datA=" + datA + "&datB=" + datB);

        $http.get(url, config)
            .success(function (data, status, headers, config) {

                deferred.resolve(data);

            }).error(function (data, status, headers, config) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var GetFXDealByDealTag = function (nDealTag) {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetFXDealByDealTag");

        $http.get(url, {
            params: { DealTag: nDealTag }
        })
        .success(function (data, status, headers, config) {
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });
        return deferred.promise;
    }

    var GetSWRef = function(nDealTag){
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetSWRef");

        $http.get(url, {
            params: { DealTag: nDealTag }
        })
        .success(function (data, status, headers, config) {
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });
        return deferred.promise;
    }

    var GetCustLimits = function (okpob) {
        var deferred = $q.defer();
        
        var url = bars.config.urlContent("/Forex/RegularDeals/GetCustLimits");

        $http.get(url, {
            params: { OKPOB: okpob }
        })
        .success(function (data, status, headers, config) {

            deferred.resolve(data);

        }).error(function (data, status, headers, config) {

            deferred.reject(data);
        });
        return deferred.promise;
    }


    var getCurrencyNameB = function (kv) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetCurrencyProp?kv=" + kv);

        $http.get(url, config)
         .success(function (data, status, headers, config) {
             deferred.resolve(data);
         }).error(function (data, status, headers, config) {
             deferred.reject(data);
         });

        return deferred.promise;
    }

    var PutDepo = function (dealTag) {
        
        var deferred = $q.defer();
        var url = bars.config.urlContent("/Forex/RegularDeals/PutDepoDealTag");
        $http.get(url, {
            params: { DealTag: dealTag }
        })
        .success(function (data, status, headers, config) {
            deferred.resolve(data.message);
        }).error(function (data, status, headers, config) {
            deferred.reject(data.message);
        });
        return deferred.promise;
    }

    var GetSwapTag = function (dealTag) {
        var deferred = $q.defer();
        var url = bars.config.urlContent("/Forex/RegularDeals/GetSwapTag");        
        $http.get(url, {
            params: { DealTag: dealTag }
        })
        .success(function (data, status, headers, config) {
            deferred.resolve([data, status]);
        }).error(function (data, status, headers, config) {
            deferred.reject([data, status]);
        });
        return deferred.promise;
    }

    var SaveGhangesPartners = function (partner) {
        
        var deferred = $q.defer();
        var url = bars.config.urlContent("/api/Forex/RegularDealPartnerApi");
        $http.post(url, partner)
            .success(function (data, status, headers, config) {           
            deferred.resolve([status, data]);
        })
            //.error(function (data, status, headers, config) {
            //deferred.reject([status, data]);
        //})
        ;
        return deferred.promise;
    }

    var InsertOperw = function (PINIC, NND) {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/InsertOperw");

        $http.get(url, {
            params: { pInic: PINIC, nND: NND }
        }).success(function (data, status, headers, config) {
            
            deferred.resolve(data.message);

        }).error(function (data, status, headers, config) {

            deferred.reject(data.message);
        });

        return deferred.promise;
    }


    var SWIFTCreateMsg = function (dealtag) {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/SWIFTCreateMsg");

        $http.get(url, {
            params: { DealTag: dealtag }
        }).success(function (data, status, headers, config) {
            
            deferred.resolve(data.message);

        }).error(function (data, status, headers, config) {

            deferred.reject(data.message);
        });

        return deferred.promise;
    }

    var GetDealType = function (dealtag) {
        var deferred = $q.defer();
        var url = bars.config.urlContent("/Forex/RegularDeals/GetDealType");
        $http.get(url, {
            params: { DealTag: dealtag }
        }).success(function (data, status, headers, config) {
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });
        return deferred.promise;
    }

    var SaveGhanges = function (agreement) {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/api/Forex/RegularDealApi");

        $http.post(url, agreement).success(function (data, status, headers, config) {
            deferred.resolve([data, status]);
        })
            //.error(function (data, status, headers, config) {
            //    deferred.reject([data, status]);
            //})
        ;
        return deferred.promise;
    }

    var UpdateChanges = function (fxupd) {
        var deferred = $q.defer();
        var url = bars.config.urlContent("/api/Forex/ChangeFXSDealApi");

        $http.post(url, fxupd).success(function (data, status, headers, config) {
            deferred.resolve(data);
        })
        .error(function (data, status, headers, config) {
            deferred.reject(data);
        });
        return deferred.promise;
    }

    var GetRNKB = function (mfob, bicb, kod_bb) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetRNKB");

        $http.get(url, {
            params: { MFOB: mfob, BICB: bicb, KOD_B: kod_bb }
        }).success(function (response) {

            deferred.resolve(response);

        }).error(function (response) {

            deferred.reject(response);
        });

        return deferred.promise;
    }

    var GetCrossCourse = function (kva, kvb) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetCrossCourse");

        $http.get(url, {
            params: { KVA: kva, KVB: kvb }
        }).success(function (response) {

            deferred.resolve(response);

        }).error(function (response) {

            deferred.reject(response);
        });

        return deferred.promise;
    }

    var GetFinResult = function (kva, nSa, kvb, nSB) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetFinResult");

        $http.get(url, {
            params: { KVA: kva, NSA: nSa, KVB: kvb, NSB: nSB }
        }).success(function (response) {

            deferred.resolve(response);

        }).error(function (response) {

            deferred.reject(response);
        });

        return deferred.promise;
    }

    var GetDefSettings = function () {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetDefSettings");

        $http.get(url, {           
        }).success(function (response) {

            deferred.resolve(response);

        }).error(function (response) {

            deferred.reject(response);
        });

        return deferred.promise;
    }
    var GetCodePurposeOfPayment = function (kod) {
        
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetCodePurposeOfPayment");

        $http.get(url, { params: { KOD: kod } }).success(function (data, status, headers, config) {
            
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });

        return deferred.promise;
    }

    var GetCheckPS = function (mfob, kva, kvb) {
        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetCheckPS");

        $http.get(url, { params: { MFOB: mfob, KVA : kva, KVB: kvb,  } }).success(function (data, status, headers, config) {
            
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });

        return deferred.promise;
    }

    var GetSwiftParti = function (bick) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetBanksSWIFTParticipants");

        $http.get(url, {
            params: { BICK: bick }
        }).success(function (data, status, headers, config) {            
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });

        return deferred.promise;
    }

    var GetFortexPart = function (kvb, key, value) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetFortexPart");

        $http.get(url, {
            params: { KVB: kvb, KEY: key, VALUE: value }
        }).success(function (data, status, headers, config) {            
            deferred.resolve(data);
        }).error(function (data, status, headers, config) {
            deferred.reject(data);
        });

        return deferred.promise;
    }
    
    var GetNLSA = function (codeAgent) {

        var deferred = $q.defer();

        var url = bars.config.urlContent("/Forex/RegularDeals/GetNLSA");

        $http.get(url, {
            params: { codeAgent: codeAgent }
        }).success(function (response) {

            deferred.resolve(response);

        }).error(function (response) {

            deferred.reject(response);
        });

        return deferred.promise;
    }

    return {
        getCurrencyNameA: getCurrencyNameA,
        getCurrencyNameB: getCurrencyNameB,
        getTransactionLengthType: getTransactionLengthType,
        SaveGhanges: SaveGhanges,
        GetRNKB: GetRNKB,
        GetNLSA: GetNLSA,
        GetCrossCourse: GetCrossCourse,
        GetFinResult: GetFinResult,
        GetDefSettings: GetDefSettings,
        SaveGhangesPartners: SaveGhangesPartners,
        GetSwapTag: GetSwapTag,
        InsertOperw: InsertOperw,
        GetCodePurposeOfPayment: GetCodePurposeOfPayment,
        GetSwiftParti: GetSwiftParti,
        GetFortexPart: GetFortexPart,
        GetCheckPS: GetCheckPS,
        GetSWRef: GetSWRef,
        GetCustLimits: GetCustLimits,
        SWIFTCreateMsg: SWIFTCreateMsg,
        PutDepo: PutDepo,
        GetDealType: GetDealType,
        GetFXDealByDealTag: GetFXDealByDealTag,
        UpdateChanges: UpdateChanges
    }
}])