angular.module("BarsWeb.Areas").controller("crsour.CreditAgreementCtrl", ["$scope", "$http", "$location", "$element", function ($scope, $http, $location, $element) {
    $scope.Title = 'Угода кредитних ресурсів';
    var localUrl = $location.absUrl();
    var isRO = bars.extension.getParamFromUrl('isReadOnly', localUrl) == "0" ? false : true;
    var isUp = bars.extension.getParamFromUrl('isUpdate', localUrl) == "1" ? true : false;
    var nd = bars.extension.getParamFromUrl('nd', localUrl);
    $scope.isReadOnly = isRO;
    $scope.isUpdate = isUp;

    $scope.model = {
        nd: null,
        vidd: {},
        dateStart: null,
        dateEnd: null,
        sum: null,
        curr: {},
        rate: null,
        basey: {},
        nlsDA: null,
        nlsDB: null,
        nameD: null,
        rnkD: null,
        nlsPA: null,
        nlsPB: null,
        nameP: null,
        rnkP: null,
        sumRate: null,
    };
    $scope.dateFormat = {
        format: "{0:dd/MM/yyyy}",
        mask: "99/99/9999"
    };
    $scope.decimalFormat = {
        format: "#.00"
    };
    $scope.decimalFormatRate = {
        format: "n4",
        decimals: 4,
        step: 0.0001,
    };
    $scope.viddOptions = {
        //autoBind: false,
        dataSource: {
            transport: {
                read: {
                    url: '/barsroot/crsour/dealmonitor/getvidd/',
                    dataType: "json"
                }
            },
            schema: {
                model: {
                    vidd: "VIDD",
                    name: "NAME"
                }

            }
        },
        dataTextField: "NAME",
        dataValueField: "VIDD",
        optionLabel: " "
    };

    $scope.baseyOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: '/barsroot/crsour/dealmonitor/GetBasey/',
                    dataType: "json"
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "BASEY"
    };

    $scope.currOptions = {
        dataSource: {
            cache: false,
            transport: {
                read: {
                    url: '/barsroot/crsour/dealmonitor/GetCurrency/',
                    dataType: "json"
                }
            }
        },
        dataTextField: "LCV",
        dataValueField: "KV"
    };
    $scope.mainValidationOptions = {
        rules: {
            datediff: function (element) {
                var $this = $element.find('[name="dateEnd"]')[0];
                if ($scope.model.dateEnd != null && $this == element[0]) {
                    var endDate = kendo.parseDate($scope.model.dateEnd);
                    var startDate = kendo.parseDate($scope.model.dateStart);
                    return !(endDate <= startDate);
                }
                return true;
            },
            nlsA: function (element) {
                var $this = $element.find('[name="nlsPA"]')[0];
                if (($scope.model.nlsPA != null || $scope.model.nlsPA != "") && $this == element[0] && $scope.model.mfoP != null) {
                    var nls = $scope.model.nlsPA;
                    var mfo = $scope.model.mfoP;
                    if (mfo && nls) {
                        return bars.utils.vkrz(mfo.toString(), nls.toString()) == nls.toString();
                    }
                }
                return true;
            },
            nlsB: function (element) {
                var $this = $element.find('[name="nlsPB"]')[0];
                if (($scope.model.nlsPB != null || $scope.model.nlsPB != "") && $this == element[0] && $scope.model.mfoP != null) {
                    var nls = $scope.model.nlsPB;
                    var mfo = $scope.model.mfoP;
                    if (mfo && nls) {
                        return bars.utils.vkrz(mfo.toString(), nls.toString()) == nls.toString();
                    }
                }
                return true;
            }
        }
    };
    $scope.getRateSum = function () {
        if (!$scope.isReadOnly) {
            var model = $scope.model;
            if (!model.vidd) {
                bars.ui.alert({
                    text: "Оберіть вид угоди"
                });
            }
            else if (!model.dateStart) {
                bars.ui.alert({
                    text: "Вкажіть дату початку"
                });
            }
            else if (!model.dateEnd) {
                bars.ui.alert({
                    text: "Вкажіть дату погашення"
                });
            }
            else if (!model.sum) {
                bars.ui.alert({
                    text: "Вкажіть суму угоди"
                });
            }
            else if (!model.curr) {
                bars.ui.alert({
                    text: "Вкажіть валюту"
                });
            }
            else if (!model.rate) {
                bars.ui.alert({
                    text: "Вкажіть відсоткову ставку"
                });
            }
            else if (!model.basey) {
                bars.ui.alert({
                    text: "Оберіть база відсотків"
                });
            }
            else {
                var url = '/crsour/dealmonitor/GetRateSum/';
                $http.post(bars.config.urlContent(url),
                    {
                        productId: model.vidd.VIDD,
                        openDate: kendo.parseDate(model.dateStart),
                        expiryDate: kendo.parseDate(model.dateEnd),
                        dealAmount: model.sum,
                        currencyId: model.curr.KV,
                        interestRate: model.rate,
                        interestBase: model.basey.BASEY
                    }).then(function (request) {
                        model.sumRate = request.data;
                    });
            }
        }
    };
    $http.get(bars.config.urlContent('/api/kernel/Params/GetParam/?id=MFO')).then(function (request) {
        $scope.mfo = request.data.Value;
        $http.get(bars.config.urlContent('/crsour/dealmonitor/GetMfoName/?mfo=' + $scope.mfo)).then(function (request) {
            $scope.model.nameD = request.data.customerName;
            $scope.model.rnkD = request.data.customerId;
            $scope.model.mfoD = $scope.mfo;
            /*$http.post(bars.config.urlContent(url), { rnk: $scope.model.rnkD }).then(function (request) {
                $scope.model.mfoD = request.data.replace(/(")/g, '');
            });*/
        });

        if (nd /*&& isRO*/) {
            $http.get(bars.config.urlContent('/crsour/dealmonitor/getdeal/?nd=' + nd), { cache: false }).then(function (request) {
                var model = request.data;
                //23042025
                $scope.model.nd = model.contractNumber;
                $scope.model.vidd = { VIDD: model.productId };
                $scope.model.rnkP = model.partnerId;
                $scope.model.dateStart = kendo.parseDate(model.contractDate);
                $scope.model.dateEnd = kendo.parseDate(model.expiryDate);
                $scope.model.sum = model.amount;
                $scope.model.curr = { KV: model.currencyCode };
                $scope.model.rate = model.interestRate;
                $scope.model.basey = { BASEY: model.interestBase };
                $scope.model.nlsDA = model.mainAccount;
                $scope.model.nlsDB = model.interestAccount;
                $scope.model.nlsPA = model.partyMainAccount;
                $scope.model.nlsPB = model.partyInterestAccount;
                $scope.model.nameD = model.ownerName;
                $scope.model.nameP = model.partnerName;
                $scope.model.sumRate = null;
                var url = '/crsour/dealmonitor/GetRateSum/';
                $http.post(bars.config.urlContent(url),
                    {
                        productId: model.productId,
                        openDate: kendo.parseDate(model.contractDate),
                        expiryDate: kendo.parseDate(model.expiryDate),
                        dealAmount: model.amount,
                        currencyId: model.currencyCode,
                        interestRate: model.interestRate,
                        interestBase: model.interestBase
                    }).then(function (request) {
                        $scope.model.sumRate = request.data;
                    });
                url = '/crsour/dealmonitor/GetMfo/';
                $http.post(bars.config.urlContent(url), { rnk: model.partnerId }).then(function (request) {
                    $scope.model.mfoP = request.data.replace(/(")/g, '');
                });
            });
        }
        else {

            var url = '/api/kernel/BankDates/';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                var tomorrow = kendo.parseDate(request.data.Date);
                tomorrow.setDate(tomorrow.getDate() + 1);
                $scope.model.curr = { KV: "980", LCV: "" };
                $scope.model.dateStart = kendo.parseDate(request.data.Date);
                $scope.model.dateEnd = tomorrow;
                $scope.model.basey = { BASEY: "1", NAME: "" };
            });

            $scope.getNls = function () {
                if (!$scope.isReadOnly) {
                    if ($scope.model.vidd.VIDD) {
                        var url = '/crsour/dealmonitor/GetDealNls/?productId=' + $scope.model.vidd.VIDD + '&currencyId=' + $scope.model.curr.KV;
                        $http.get(bars.config.urlContent(url)).then(function (request) {
                            $scope.model.nlsDA = request.data.mainAccount;
                            $scope.model.nlsDB = request.data.interestAccount;
                        });
                    }
                    else {
                        bars.ui.alert({
                            text: "Оберіть вид угоди"
                        });
                    }
                }
            };

            $scope.showNameP = function (tabname, showfield) {
                if (!$scope.isReadOnly) {
                    var where = "customer.kf = sys_context('bars_context', 'user_mfo') and customer.date_off is null and customer.custtype = 1 and customer.rnk in (select rnk from custbank b where customer.codcagent = 9 and b.mfo is not null and b.mfo <> sys_context('bars_context', 'user_mfo'))";
                    bars.ui.handBook(tabname, function (data) {
                        $scope.model.nameP = data[0].NMK;
                        $scope.model.rnkP = data[0].RNK;
                        $scope.$apply();
                        url = '/crsour/dealmonitor/GetMfo/';
                        $http.post(bars.config.urlContent(url), { rnk: $scope.model.rnkP }).then(function (request) {
                            $scope.model.mfoP = request.data.replace(/(")/g, '');
                        });
                    },
                    {
                        multiSelect: false,
                        clause: where,
                        columns: showfield
                    });
                }
            };
        }
        $scope.saveDeal = function () {
            debugger;
            if (nd && $scope.isUpdate) {
                if (!$scope.isReadOnly) {
                    var model = $scope.model;
                    if (!model.dateEnd) {
                        bars.ui.alert({
                            text: "Вкажіть дату погашення"
                        });
                    }
                    else if (!model.sum) {
                        bars.ui.alert({
                            text: "Вкажіть суму угоди"
                        });
                    }
                    else if (!model.rate) {
                        bars.ui.alert({
                            text: "Вкажіть відсоткову ставку"
                        });
                    }
                    else if (!model.nlsPA || !model.nlsPB) {
                        bars.ui.alert({
                            text: "Вкажіть рахунки партнера"
                        });
                    }
                    else {
                        var url = '/crsour/dealmonitor/UpdateDeal/';
                        $http.post(bars.config.urlContent(url), {
                            dealId: nd,
                            expiryDate: model.dateEnd,
                            dealAmount: model.sum,
                            interestRate: model.rate,
                            partnerMainAccount: model.nlsPA,
                            partnerInterestAccount: model.nlsPB
                        }).then(function (request) {
                            if (request.status == 200 && request.data == '"Ok"') {
                                bars.ui.alert({
                                    text: "Договір збережено"
                                });
                                $scope.isReadOnly = true;
                            }
                            else {
                                bars.ui.alert({
                                    text: request.data
                                });
                            }
                        });
                    }
                }
            }
            else {
                var model = $scope.model;
                if (!model.nd) {
                    bars.ui.alert({
                        text: "Вкажіть номер угоди"
                    });
                }
                else if (!model.vidd) {
                    bars.ui.alert({
                        text: "Оберіть вид угоди"
                    });
                }
                else if (!model.dateStart) {
                    bars.ui.alert({
                        text: "Вкажіть дату початку"
                    });
                }
                else if (!model.dateEnd) {
                    bars.ui.alert({
                        text: "Вкажіть дату погашення"
                    });
                }
                else if (!model.sum) {
                    bars.ui.alert({
                        text: "Вкажіть суму угоди"
                    });
                }
                else if (!model.curr) {
                    bars.ui.alert({
                        text: "Вкажіть валюту"
                    });
                }
                else if (!model.rate) {
                    bars.ui.alert({
                        text: "Вкажіть відсоткову ставку"
                    });
                }
                else if (!model.basey) {
                    bars.ui.alert({
                        text: "Оберіть база відсотків"
                    });
                }
                else if (!model.nameP) {
                    bars.ui.alert({
                        text: "Оберіть партнера"
                    });
                }
                else if (!model.nlsDA || !model.nlsDB) {
                    bars.ui.alert({
                        text: "Вкажіть рахунки власника"
                    });
                }
                else if (!model.nlsPA || !model.nlsPB) {
                    bars.ui.alert({
                        text: "Вкажіть рахунки партнера"
                    });
                }
                else {
                    $scope.save = {
                        contractNumber: model.nd,
                        productId: model.vidd.VIDD,
                        partnerId: model.rnkP,
                        contractDate: kendo.parseDate(model.dateStart),
                        expiryDate: kendo.parseDate(model.dateEnd),
                        amount: model.sum,
                        currencyCode: model.curr.KV,
                        interestRate: model.rate,
                        interestBase: model.basey.BASEY,
                        mainAccount: model.nlsDA,
                        interestAccount: model.nlsDB,
                        partyMainAccount: model.nlsPA,
                        partyInterestAccount: model.nlsPB
                    }
                    var url = '/crsour/dealmonitor/SaveDeal/';
                    $http.post(bars.config.urlContent(url), $scope.save).then(function (request) {
                        debugger;
                        if (request.status == 200 && request.data == '"Ok"') {
                            bars.ui.alert({
                                text: "Договір збережено"
                            });
                            $scope.isReadOnly = true;
                        }
                        else {
                            bars.ui.alert({
                                text: request.data
                            });
                        }
                    });
                }
            }
        };
    });
}]);