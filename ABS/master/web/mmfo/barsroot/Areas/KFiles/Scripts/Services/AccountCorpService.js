angular.module('BarsWeb.Controllers')
.factory('AccountCorpService', ['$http', '$q', function ($http, $q) {

    var SaveAccountCorp = function (model) {

        var deferred = $q.defer();

        var corpAccArr = [];
        var saveCorpAcc = {};

        for (i in model) {

            saveCorpAcc = {
                RNK: model[i].RNK,
                ACC: model[i].ACC,
                USE_INVP: model[i].USE_INVP,
                TRKK_KOD: model[i].TRKK_KOD,
                INST_KOD: model[i].INST_KOD,
                ALT_CORP_COD: model[i].ALT_CORP_COD,
                DAOS: model[i].DAOS
            };

            corpAccArr.push(saveCorpAcc);
        }

        var url = bars.config.urlContent('/api/kfiles/kfilesApi/post');

        $http.post(url, corpAccArr)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var SaveAccountCorpWithFilter = function (request) {

        var deferred = $q.defer();

        var url = bars.config.urlContent('/kfiles/kfiles/SaveAccCorpWithFilter');

        $http({
            url: url,
            method: "POST",
            data: request
        })
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }


    return {
        SaveAccountCorp: SaveAccountCorp,
        SaveAccountCorpWithFilter: SaveAccountCorpWithFilter
    }

}]);