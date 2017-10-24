angular.module("BarsWeb.Areas").controller("Credit.mainCreditCtrl", ["$scope", "$http", "$rootScope", "$element", "$location", "$timeout", function ($scope, $http, $rootScope, $element, $location, $timeout) {
    $scope.Title = 'Кредитний договір';
    var localUrl = $location.absUrl();
    $rootScope.nd = bars.extension.getParamFromUrl('nd', localUrl);
    $rootScope.custtype = bars.extension.getParamFromUrl('custtype', localUrl);

    var vm = this;

    $scope.isSave = false;
    $scope.create = {
        ACC8: null,
        ND: null,
        nRNK: null,
        CC_ID: null,
        Dat1: null,
        Dat4: null,
        Dat2: null,
        Dat3: null,
        nKV: null,
        nS: null,
        nVID: null,
        nISTRO: null,
        nCEL: null,
        MS_NX: null,
        nFIN: null,
        nOBS: null,
        sAIM: null,
        ID: null,
        NLS: null,
        nBANK: null,
        nFREQ: null,
        dfPROC: null,
        nBasey: null,
        dfDen: null,
        DATNP: null,
        nFREQP: null,
        nKom: null
    };

    $rootScope.whereForCust = $rootScope.custtype == 3 ? 'where custtype = 3 and date_off is null' : 'where (custtype = 2 or (custtype = 3 and prinsider = 99)) and date_off is null';

    $rootScope.credit = {
        curValue: { KV: "980", LCV: "" },
        numValue: null,
        branchValue: null,
        sumValue: null,
        conslValue: null,
        startValue: null,
        issueValue: null,
        endValue: null,
        custValue: null,
        rnkValue: null,
        nmkValue: null,
        finValue: { FIN: "1", NAME: "" },
        obsValue: { OBS: "1", NAME: "" },
        viddValue: null,
        sourValue: { SOUR: "4", NAME: "" },
        aimValue: null,
        prodValue: null,
        prodNameValue: null,
        serviceValue: false,
        sIdValue: null,
        sCatValue: null,
        currAValue: "980",
        rateAValue: null,
        currBValue: null,
        rateBValue: null,
        currCValue: null,
        rateCValue: null,
        currDValue: null,
        rateDValue: null,
        currEValue: null,
        rateEValue: null,
        baseRateValue: null,
        baseRateNameValue: null,
        baseyValue: { BASEY: "0", NAME: "" },
        nlsValue: null,
        purposeValue: null,
        guaranteeValue: null,
        rangValue: { RANG: "0", NAME: "" },
        freqValue: { FREQ: "400", NAME: "" },
        dayOfPayValue: null,
        firstPayDateValue: null,
        holidayValue: false,
        freqIntValue: { FREQ: "400", NAME: "" },
        diffDaysValue: false,
        previousValue: { ID: "0", NAME: "" },
        discontSumValue: null,
        curComAccValue: { KV: "980", LCV: "" },
        metrValue: null,
        metrRateValue: null,
        unusedLimitValue: null,
        listUnsedValue: { id: "0", name: "" },
        isPenaltiesValue: true,
        penaltiesRateValue: null,
        earlyRateValue: null,
        acc8: null,
        basem: null
    }

    if ($rootScope.nd != null) {
        var url = '/credit/newcredit/getDeal/?nd=' + $rootScope.nd;
        $http.get(bars.config.urlContent(url)).then(function (request) {
            var resp = request.data;
            var save = $rootScope.credit;
            save.rnkValue = resp.nRNK;
            save.numValue = resp.CC_ID;
            save.conslValue = resp.Dat1;
            save.endValue = resp.Dat4;
            save.startValue = resp.Dat2;
            save.issueValue = resp.Dat3;
            save.curValue = { KV: resp.nKV, NAME: "" };
            save.sumValue = resp.nS;
            save.viddValue = { VIDD: resp.nVID, NAME: "" };
            save.sourValue = { SOUR: resp.nISTRO, NAME: "" };
            save.aimValue = { AIM: resp.nCEL, NAME: "" };
            save.prodValue = resp.MS_NX;
            save.finValue = { FIN: resp.nFIN, NAME: "" };
            save.obsValue = { OBS: resp.nOBS, NAME: "" };
            save.nlsValue = resp.NLS;
            save.mfoValue = resp.nBANK;
            save.freqValue = { FREQ: resp.nFREQ, NAME: "" };
            save.rateAValue = resp.dfPROC;
            save.baseyValue = { BASEY: resp.nBasey, NAME: "" };
            save.dayOfPayValue = resp.dfDen;
            save.firstPayDateValue = resp.DATNP;
            save.freqIntValue = { FREQ: resp.nFREQP, NAME: "" };
            save.unusedLimitValue = resp.nKom;
            save.branchValue = resp.INIC;
            save.custValue = resp.OKPO;
            save.nmkValue = resp.NMK;
            save.prodNameValue = resp.PRODNAME;
            save.purposeValue = resp.AIMNAME;
            save.acc8 = resp.ACC8;
            save.serviceValue = resp.BASEM == 1 ? true : false;
        });
    }
    else {
        var url = '/api/kernel/BankDates/';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $rootScope.credit.conslValue = request.data.Date;
            $rootScope.credit.startValue = request.data.Date;
            $rootScope.credit.issueValue = request.data.Date;
            $rootScope.credit.endValue = request.data.Date;
        });
    }

    $scope.$on('kendoWidgetCreated', function (ev, widget) {
        if (widget === $scope.mainTabStrip) {
            $scope.mainTabStrip.select(0);
        }
    });

    $scope.tabStripMainOptions = {
        animation: false,
        height: 400
    };

    var element = this;

    $scope.mainValidationOptions = {
        rules: {
            issue: function (element) {
                var $this = $element.find('[name="dpIssue"]')[0];
                if ($scope.credit.issueValue != null && $this == element[0]) {
                    var issueDate = kendo.parseDate($scope.credit.issueValue);
                    var startDate = kendo.parseDate($scope.credit.startValue);
                    var endDate = kendo.parseDate($scope.credit.endValue);
                    return !((issueDate < startDate) || (issueDate > endDate));
                }
                return true;
            },
            end: function (element) {
                var $this = $element.find('[name="dpEnd"]')[0];
                if ($scope.credit.endValue != null && $this == element[0]) {
                    var endDate = kendo.parseDate($scope.credit.endValue);
                    var startDate = kendo.parseDate($scope.credit.startValue);
                    return !(endDate <= startDate);
                }
                return true;
            },
            dayofpay: function (element) {
                var $this = $element.find('[name="tbDayOfPay"]')[0];
                if ($scope.credit.dayOfPayValue != null && $this == element[0]) {
                    var day = kendo.parseInt($scope.credit.dayOfPayValue);
                    return !(1 > day || day > 31);
                }
                return true;
            },
            firstpaydate: function (element) {
                var $this = $element.find('[name="dpFirtsPayDate"]')[0];
                if ($scope.credit.firstPayDateValue != null && $this == element[0]) {
                    var dateFirst = kendo.parseDate($scope.credit.firstPayDateValue);
                    var dateIssue = kendo.parseDate($scope.credit.issueValue);
                    return !(dateFirst < dateIssue);
                }
                return true;
            },
            /*nls: function (element) {
                var $this = $element.find('[name="nls"]')[0];
                console.log($scope.credit.nlsValue);
                if (($scope.credit.nlsValue != null || $scope.credit.nlsValue != "") && $this == element[0] && $scope.credit.mfoValue != null) {
                    console.log($scope.credit.nlsValue);
                    var nls = $scope.credit.nlsValue;
                    var mfo = $scope.credit.mfoValue;
                    return bars.utils.vkrz(mfo.toString(), nls.toString()) == nls.toString();
                }
                return true;
            },*/
            daypaydiff: function (element) {
                var $this = $element.find('[name="tbDayPayDiff"]')[0];
                if ($scope.credit.dayPayDiffValue != null && $this == element[0]) {
                    var day = kendo.parseInt($scope.credit.dayPayDiffValue);
                    return !(1 > day || day > 31);
                }
                return true;
            },
            firstpaydiff: function (element) {
                var $this = $element.find('[name="dpFirtsPayDiff"]')[0];
                if ($scope.credit.firstPayDiffValue != null && $this == element[0]) {
                    var dateFirst = kendo.parseDate($scope.credit.firstPayDiffValue);
                    var dateIssue = kendo.parseDate($scope.credit.issueValue);
                    return !(dateFirst < dateIssue);
                }
                return true;
            }
        }
    };

    $scope.save = function () {
        var save = $rootScope.credit;
        if ($scope.validator.validate()) {
            debugger;
            if (save.rnkValue == null) {
                bars.ui.alert({
                    text: "Не обрано позичальника"
                });
            }
            else if (save.numValue == null) {
                bars.ui.alert({
                    text: "Не введенно номер договору"
                });
            }
            else if (save.sumValue == null) {
                bars.ui.alert({
                    text: "Не введенно суму договору"
                });
            }
            else if (save.custValue == null) {
                bars.ui.alert({
                    text: "Не обрано валюту договору"
                });
            }
            else if (save.freqValue == null) {
                bars.ui.alert({
                    text: "Не обрана періодичність основного боргу"
                });
            }
            else if (save.freqIntValue == null) {
                bars.ui.alert({
                    text: "Не обрана періодичність сплати відсотків"
                });
            }
            else if (save.firstPayDateValue == null) {
                bars.ui.alert({
                    text: "Не задана перша дата погашення"
                });
            }
            else if (save.viddValue == null) {
                console.log(save.viddValue);
                bars.ui.alert({
                    text: "Не обраний вид договору"
                });
            }
            else if (save.dayOfPayValue == null) {
                bars.ui.alert({
                    text: "Не вказаний день погашення"
                });
            }
            else if (save.sourValue == null) {
                bars.ui.alert({
                    text: "Не обрано джерело залучення коштів"
                });
            }
            else if (save.prodValue == null) {
                bars.ui.alert({
                    text: "Не обрано код продукта"
                });
            }
            else if (save.finValue == null) {
                bars.ui.alert({
                    text: "Не обрано фінансовий стан позичальника"
                });
            }
            else if (save.rateAValue == null && save.baseRateValue == null) {
                bars.ui.alert({
                    text: "Не обрано процентну ставку або базу нарахування по договору"
                });
            }
            else if (save.aimValue == null) {
                bars.ui.alert({
                    text: "Не обрано ціль кредитування"
                });
            }
            else if (save.rangValue == null) {
                bars.ui.alert({
                    text: "Не обрано шаблон погашення"
                });
            }
            else if (save.discontSumValue > 0 && save.metrValue == null) {
                bars.ui.alert({
                    text: "Не обрано метод щомісячної комісії"
                });
            }
            else if (save.discontSumValue > 0 && save.curComAccValue == null) {
                bars.ui.alert({
                    text: "Не обрано валюту коміссійних доходів"
                });
            }
            else if (save.unusedLimitValue > 0 && save.curComAccValue == null) {
                bars.ui.alert({
                    text: "Не обрано валюту коміссійних доходів"
                });
            }
            else if (save.branchValue == null) {
                bars.ui.alert({
                    text: "Не обрано \"Ініціативу\""
                });
            }
            else {
                if ($rootScope.nd == null) {
                    $scope.create.nRNK = save.rnkValue;
                    $scope.create.CC_ID = save.numValue;
                    $scope.create.Dat1 = kendo.parseDate(save.conslValue);
                    $scope.create.Dat4 = kendo.parseDate(save.endValue);
                    $scope.create.Dat2 = kendo.parseDate(save.startValue);
                    $scope.create.Dat3 = kendo.parseDate(save.issueValue);
                    $scope.create.nKV = save.curValue.KV;
                    $scope.create.nS = save.sumValue;
                    $scope.create.nVID = save.viddValue.VIDD;
                    $scope.create.nISTRO = save.sourValue.SOUR;
                    $scope.create.nCEL = save.aimValue.AIM;
                    $scope.create.MS_NX = save.prodValue;
                    $scope.create.nFIN = save.finValue.FIN;
                    $scope.create.nOBS = save.obsValue.OBS;
                    $scope.create.sAIM = save.aimValue.NAME;
                    $scope.create.ID = null;
                    $scope.create.NLS = save.nlsValue;
                    $scope.create.nBANK = save.mfoValue;
                    $scope.create.nFREQ = save.freqValue.FREQ;
                    $scope.create.dfPROC = save.rateAValue;
                    $scope.create.nBasey = save.baseyValue.BASEY;
                    $scope.create.dfDen = kendo.parseInt(save.dayOfPayValue);
                    $scope.create.DATNP = save.firstPayDateValue;
                    $scope.create.nFREQP = save.freqIntValue.FREQ;
                    $scope.create.nKom = save.unusedLimitValue;
                    var url = '/credit/newcredit/createdeal';
                    $http.post(bars.config.urlContent(url), $scope.create).then(function (request) {
                        $rootScope.ndtxtsave.nd = request.data;
                        if ($rootScope.ndtxtsave.nd != -1) {
                            url = '/credit/newcredit/setndtxt';
                            $http.post(bars.config.urlContent(url), $rootScope.ndtxtsave).then(function (request) {
                                url = '/credit/newcredit/afterSaveDeal';
                                var flags = (save.holidayValue ? "1" : "0") + (save.previousValue.ID == 1 ? "1" : "0");
                                $http.post(bars.config.urlContent(url), { nd: $rootScope.ndtxtsave.nd, prod: save.prodValue, fin: save.finValue.FIN, inic: save.branchValue, flags: flags, rang: save.rangValue.RANG }).then(function (request) {
                                    $scope.isSave = true;
                                    bars.ui.alert({
                                        text: "Створено КД №" + $rootScope.ndtxtsave.nd
                                    });
                                });
                            });
                        }
                        else {
                            bars.ui.alert({
                                text: "<span style='color:red'>Помилка створення КД</span>"
                            });
                        }
                    });
                }
                else {
                    $scope.create.ACC8 = save.acc8;
                    $scope.create.ND = $rootScope.nd;
                    $scope.create.nRNK = save.rnkValue;
                    $scope.create.CC_ID = save.numValue;
                    $scope.create.Dat1 = kendo.parseDate(save.conslValue);
                    $scope.create.Dat4 = kendo.parseDate(save.endValue);
                    $scope.create.Dat2 = kendo.parseDate(save.startValue);
                    $scope.create.Dat3 = kendo.parseDate(save.issueValue);
                    $scope.create.nKV = save.curValue.KV;
                    $scope.create.nS = save.sumValue;
                    $scope.create.nVID = save.viddValue.VIDD;
                    $scope.create.nISTRO = save.sourValue.SOUR;
                    $scope.create.nCEL = save.aimValue.AIM;
                    $scope.create.MS_NX = save.prodValue;
                    $scope.create.nFIN = save.finValue.FIN;
                    $scope.create.nOBS = save.obsValue.OBS;
                    $scope.create.sAIM = save.aimValue.NAME;
                    $scope.create.nKom = save.unusedLimitValue;
                    $scope.create.NLS = save.nlsValue;
                    $scope.create.nBANK = save.mfoValue;
                    $scope.create.nFREQ = save.freqValue.FREQ;
                    $scope.create.dfPROC = save.rateAValue;
                    $scope.create.nBasey = save.baseyValue.BASEY;
                    $scope.create.dfDen = kendo.parseInt(save.dayOfPayValue);
                    $scope.create.DATNP = kendo.parseDate(save.firstPayDateValue);
                    $scope.create.nFREQP = save.freqIntValue.FREQ;
                    var url = '/credit/newcredit/updatedeal';
                    $http.post(bars.config.urlContent(url), $scope.create).then(function (request) {
                        $rootScope.ndtxtsave.nd = request.data;
                        if ($rootScope.ndtxtsave.nd != -1) {
                            url = '/credit/newcredit/setndtxt';
                            $http.post(bars.config.urlContent(url), $rootScope.ndtxtsave).then(function (request) {
                                url = '/credit/newcredit/afterSaveDeal';
                                var flags = (save.holidayValue ? "1" : "0") + (save.previousValue.ID == 1 ? "1" : "0");
                                $http.post(bars.config.urlContent(url), { nd: $rootScope.ndtxtsave.nd, prod: save.prodValue, fin: save.finValue.FIN, inic: save.branchValue, flags: flags, rang: save.rangValue.RANG }).then(function (request) {
                                    $scope.isSave = true;
                                    bars.ui.alert({
                                        text: "Оновлено КД №" + $rootScope.ndtxtsave.nd
                                    });
                                });
                            });
                        }
                        else {
                            bars.ui.alert({
                                text: "<span style='color:red'>Помилка оновлення КД</span>"
                            });
                        }
                    });
                }
            }
        }
    };
}]);