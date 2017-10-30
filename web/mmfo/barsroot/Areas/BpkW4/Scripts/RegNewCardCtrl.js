angular.module("BarsWeb.Areas")
    .controller("BpkW4.RegNewCardCtrl", ["$scope", "$location", "$http", "$window", function ($scope, $location, $http, $window) {
        $scope.Title = 'Реєстрація нової картки';
        var localUrl = $location.absUrl();
        var rnk = bars.extension.getParamFromUrl('rnk', localUrl);
        var proectId = bars.extension.getParamFromUrl('proectId', localUrl);
        var cardCode = bars.extension.getParamFromUrl('cardCode', localUrl);

        var portfolioUrl = "/barsroot/Way4Bpk/Way4Bpk";
    
        $scope.model = null;
        $scope.params = {
            isIns: false,
            insUkrId: null,
            insWrdId: null,
            tmpUkrId: null,
            tmpWrdId: null
        };

        $scope.saveFinalize = function (ND) {
            bars.ui.loader('body', false);
            bars.ui.success({
                text: "Договір збережено №" + ND,
                close: function () { $window.location.href = portfolioUrl+"?nd="+ND; }
            });
        };
    
        $http.get(bars.config.urlContent('/bpkw4/RegisteringNewCard/GetIsIns?cardCode=' + cardCode))
            .then(function (request) {
                $scope.params.isIns = request.data.haveins;
                $scope.params.insUkrId = request.data.insUkrId;
                $scope.params.insWrdId = request.data.insWrdId;
                $scope.params.tmpUkrId = request.data.tmpUkrId;
                $scope.params.tmpWrdId = request.data.tmpWrdId;
            });
        bars.ui.loader('body', true);
        $http.get(bars.config.urlContent('/bpkw4/RegisteringNewCard/GetCardValue?rnk=' + rnk + '&proectId=' + proectId + '&cardCode=' + cardCode + '&isIns=' + $scope.params.isIns))
            .then(function (request) {
                bars.ui.loader('body', false);
                if(request.data.ERROR_MSG !== "" && request.data.ERROR_MSG !== null){
                    bars.ui.error({ text: request.data.ERROR_MSG });
                    return;
                }

                $scope.model = request.data;
                if ($scope.model.ISMFO) {
                    $scope.model.BRANCH = $scope.model.CURRENTBRANCH;
                    $scope.model.BRANCH_NAME = $scope.model.CURBRANCHNAME;
                    $scope.model.DELIVERY_BRANCH = $scope.model.CURRENTBRANCH;
                    $scope.model.DELIVERY_BRANCH_NAME = $scope.model.CURBRANCHNAME;
                }
        });
        //});
    
        $scope.toolsOptions = {
            items: [{
                template: "<button class='k-button' ng-click='save()' ng-disabled='isAccShow'><i class='pf-icon pf-16 pf-save'></i> Зареєструвати карту</button>",
            },
            {
                template: "<button class='k-button' ng-click='back()' ng-disabled='isDisExec' ><i class='pf-icon pf-16 pf-arrow_left'></i> Повернутися до портфелю</button>",
            }]
        };
    
        $scope.valid = function () { };
    
        $scope.dpOptions = {
            format: "{0:dd.MM.yyyy}",
            mask: "00.00.0000"
        };
    
        $scope.showReferBranch = function (tabName, showFields, whereClause) {
            $scope.showBranch(tabName, showFields, whereClause, 'BRANCH', 'BRANCH_NAME');
        };
    
        $scope.showDeliveryBranch = function (tabName, showFields, whereClause) {
            $scope.showBranch(tabName, showFields, whereClause, 'DELIVERY_BRANCH', 'DELIVERY_BRANCH_NAME');
        };

        $scope.showBranch = function (tabName, showFields, whereClause, key, name) {
            bars.ui.handBook(tabName, function (data) {
                    $scope.model[key] = data[0].BRANCH;
                    $scope.model[name] = data[0].NAME;
                    $scope.$apply();
                },
                {
                    multiSelect: false,
                    clause: whereClause,
                    columns: showFields
                });
        };
    
        $scope.back = function () {
            $scope.validator.destroy();
            $window.location.href = portfolioUrl;
        };

        $scope.save = function () {
            $http.get(bars.config.urlContent('/bpkw4/RegisteringNewCard/GetExternal?rnk=' + rnk))
                .then(function (request) {
                    $scope.ext = request.data;
                    if (!$scope.ext.IS_EXT && Number($scope.model.TYPE_INS) === 1) {
                        bars.ui.error({
                            text: 'Обрано Страхування подорожі за кордон.<br />У клієнта не зареєстровано закордонний паспорт.'
                        });
                    }
                    else if ($scope.validator.validate()) {
                        bars.ui.loader('body', true);
                        $http.post(bars.config.urlContent('/bpkw4/RegisteringNewCard/OpenCard'), $scope.model)
                            .then(function (request) {
                                var data = request.data;
                                if (data.ERR_CODE === -99) {
                                    bars.ui.loader('body', false);
                                    var error = {};
                                    try {
                                        error = JSON.parse(data.ERR_MSG);
                                    } catch (e) {
                                        //error
                                    }

                                    if (error.constraintViolations) {
                                        var message = "";
                                        var len = error.constraintViolations.length;
                                        for (var i = 0; i < len; i++) {
                                            message += "Параметер: " + error.constraintViolations[i].path + "<br />Повідомлення: " + error.constraintViolations[i].message;
                                            if(i < len-1){ message += "<br /><br />"; }
                                        }
                                        bars.ui.error({ text: message });
                                    } else {
                                        bars.ui.error({ text: data.ERR_MSG });
                                    }
                                }
                                else {
                                    var newCardData = null;
                                    if($scope.params.isIns && $scope.params.insUkrId){
                                        if ($scope.params.insWrdId){
                                            var typeIns = Number($scope.model.TYPE_INS);
                                            newCardData = { nd: data.ND,
                                                ins_id: typeIns === 0 ? $scope.params.insWrdId : $scope.params.insUkrId,
                                                tmp_id: typeIns === 0 ? $scope.params.tmpWrdId : $scope.params.tmpUkrId };
                                        }
                                        else{
                                            newCardData = { nd: data.ND, ins_id: $scope.params.insUkrId, tmp_id: $scope.params.tmpUkrId };
                                        }
                                    }
                                    if(newCardData !== null){
                                        $http.post(bars.config.urlContent('/bpkw4/RegisteringNewCard/SetInsId'), newCardData)
                                            .then(function (request) { $scope.saveFinalize(newCardData.nd); });
                                    }
                                    else{
                                        $scope.saveFinalize(data.ND);
                                    }
                                }
                            });
                    }
                });
        };

}]);