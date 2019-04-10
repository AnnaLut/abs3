angular.module("BarsWeb.Areas").controller("CreditUi.mainCreditCtrl", ["$scope", "$http", "$rootScope", "$element", "$location", "$timeout", "dataService", function ($scope, $http, $rootScope, $element, $location, $timeout, dataService) {
    $scope.Title = 'Кредитний договір';
    var localUrl = $location.absUrl();
    $rootScope.nd = bars.extension.getParamFromUrl('nd', localUrl);
    if($rootScope.nd != null){ $scope.Title += (" ("+$rootScope.nd+")"); }
    $rootScope.custtype = bars.extension.getParamFromUrl('custtype', localUrl);
    $rootScope.isTagOnly = bars.extension.getParamFromUrl('tagOnly', localUrl);

    $rootScope.bankDate =  null;
    $rootScope.sos = bars.extension.getParamFromUrl('sos', localUrl);

    var isEmpty = function (s) { return s == null || s == "" };
    var isEmptyEny = function (s1, s2) {
        return (isEmpty(s1) && !isEmpty(s2)) || (isEmpty(s2) && !isEmpty(s1));
    };
    $rootScope.IsGKD = function () { return $rootScope.credit.viddValue !== null && $rootScope.credit.viddValue.Key == 5; };

    $rootScope.isNumValueValid = function() { return !isEmpty($rootScope.credit.numValue); };
    $rootScope.isSumValueValid = function() { return !isEmpty($rootScope.credit.sumValue); };
    $rootScope.isCustValueValid = function() { return !isEmpty($rootScope.credit.custValue); };
    $rootScope.isBranchValueValid = function() { return !isEmpty($rootScope.credit.branchValue); };
    $rootScope.isFirtsPayDateValueValid = function () { return !isEmpty($rootScope.credit.firstPayDateValue) || $rootScope.IsGKD(); };
    $rootScope.isDayOfPayValueValid = function () { return !isEmpty($rootScope.credit.dayOfPayValue) || $rootScope.IsGKD(); };
    $rootScope.isDdlViddValueValid = function () { return !isEmpty($rootScope.credit.viddValue) || $rootScope.IsGKD(); };
    $rootScope.isProdValueValid = function () { return !isEmpty($rootScope.credit.prodValue) || $rootScope.IsGKD(); };
    $rootScope.isBaseRateValueValueValid = function() {
        var isRateAValue = !isEmpty($rootScope.credit.rateAValue) || $rootScope.IsGKD();
        if(!isRateAValue){
            var prodValue = $rootScope.credit.prodValue;
            var isProdValueValid = false;
            if(!isEmpty(prodValue)){
                isProdValueValid = prodValue[0] == "9";
            }
            if(isProdValueValid){
                isRateAValue = $rootScope.credit.rateAValue !== null;
            }
        }
        return !isEmpty($rootScope.credit.baseRateValue) || isRateAValue;
    };
    $rootScope.isViddValid = function () { return !isEmpty($rootScope.credit.viddValue); };

    $rootScope.ShowCustInfo = false;

    $rootScope.isShowCustInfo = function () { return $rootScope.ShowCustInfo; };


    $rootScope.isFlagsValid = function () { return !($rootScope.credit.holidayValue.ID == "9" && $rootScope.credit.previousValue.ID == "2"); };  //92 - неможливе значення FLAGS

    $scope.DatesValidMsg = "";
    $rootScope.isDatesValid = function () {
        $scope.DatesValidMsg = "";
        var conslDate = kendo.parseDate($rootScope.credit.conslValue);
        if(conslDate == null){ $scope.DatesValidMsg = "Дата заключення некоректна"; return false;}
        var issueDate = kendo.parseDate($rootScope.credit.issueValue);
        if (issueDate == null && !$rootScope.IsGKD()) { $scope.DatesValidMsg = "Дата видачі некоректна"; return false; }
        var endDate = kendo.parseDate($rootScope.credit.endValue);
        if(endDate == null){ $scope.DatesValidMsg = "Дата завершення некоректна"; return false;}
        var startDate = kendo.parseDate($rootScope.credit.startValue);
        if (startDate == null && !$rootScope.IsGKD()) { $scope.DatesValidMsg = "Дата початку некоректна"; return false; }
        var dateFirst = kendo.parseDate($scope.credit.firstPayDateValue);
        if (dateFirst == null && !$rootScope.IsGKD()) { return false; }
        if (!$rootScope.IsGKD()) {
            if (startDate < conslDate) { $scope.DatesValidMsg = "Дата заключення більша за дату початку"; return false; }
            if (startDate > endDate) { $scope.DatesValidMsg = "Дата початку більша за дату завершення"; return false; }
            if (issueDate > dateFirst) { $scope.DatesValidMsg = "Дата видачі більша за першу платіжну дату"; return false; }
            if (dateFirst > endDate) { $scope.DatesValidMsg = "Перша платіжна дата більша за дату завершення"; return false; }
            if ((issueDate < startDate) || (issueDate > endDate)) {
                $scope.DatesValidMsg = "Дата видачі меньша за дату початку, або більша за дату завершення";
                return false;
            }
            if (conslDate > endDate || conslDate > issueDate || conslDate > dateFirst) {
                $scope.DatesValidMsg = "Дата заключення некоректна"; return false;
            }
        }

        var firstPayDiffValue = kendo.parseDate($rootScope.credit.firstPayDiffValue);
        if($rootScope.credit.diffDaysValue && (firstPayDiffValue < startDate || firstPayDiffValue < conslDate || firstPayDiffValue > endDate)){
            return false;
        }

        //check BD
        //if($rootScope.bankDate != null){
        //    var bd = kendo.parseDate($rootScope.bankDate);
        //    if(startDate < bd || issueDate < bd || dateFirst < bd || conslDate < bd || endDate < bd){
        //        $scope.DatesValidMsg = "Дата меньше за банківську"; return false;
        //    }
        //}

        return true;
    };
    $rootScope.isCurrValid = function () {
        if(isEmptyEny($rootScope.credit.currBValue, $rootScope.credit.rateBValue)
            || isEmptyEny($rootScope.credit.currCValue, $rootScope.credit.rateCValue)
            || isEmptyEny($rootScope.credit.currDValue, $rootScope.credit.rateDValue)
            || isEmptyEny($rootScope.credit.currEValue, $rootScope.credit.rateEValue)){
            $scope.DatesValidMsg = "Валюти і ставки - помилкові";
            return false;
        }
        return true;
    };

    $rootScope.isGKDInfoValid = function () {
        if (!$rootScope.isDdlViddValueValid())
            return false;

        var isKD_UO_notGKD = [1, 2, 3].indexOf($rootScope.credit.viddValue.Key) !== -1;
        if ($scope.isSave ||
                (!$scope.isSave &&
                    (!isKD_UO_notGKD || (isKD_UO_notGKD && $rootScope.credit.belongtoGKD.id === "0"))
                )
            )
            return true;

        if ($rootScope.credit.belongtoGKD.id === "") {
            $scope.DatesValidMsg = "Поле 'Приналежність до ГКД' обов'язкове!";
            return false;
        }

        if ($rootScope.credit.belongtoGKD.id == 1 && $rootScope.credit.gkd_id === null) {
            $scope.DatesValidMsg = "Введіть номер Ген договору!";
            return false;
        }
        
        if (kendo.parseDate($rootScope.credit.endValue) > kendo.parseDate($rootScope.GKD.wdate, 'dd/MM/yyyy')) {
            $scope.DatesValidMsg = "Дата завершення КД більша за дату завершення ГКД";
            return false;
        }
        if ($rootScope.credit.sumValue > kendo.parseFloat($rootScope.GKD.limit)) {
            $scope.DatesValidMsg = "Сума КД більша за поточний ліміт ГКД";
            return false;
        }
         return true;

    };

    $rootScope.isNlsValid = function () {
        if (!isEmpty($rootScope.credit.nlsValue) && !isEmpty($rootScope.credit.mfoValue)){
            return bars.utils.vkrz($rootScope.credit.mfoValue.toString(), $rootScope.credit.nlsValue.toString()) == $rootScope.credit.nlsValue.toString();
        }
        return true;
    };

    var vm = this;

    var isNew = ($rootScope.sos == "0") || ($rootScope.sos == null) ? false : true;

    $scope.isSaveFunc = function () {
        return false;
    };
    $scope.isSave = isNew;
    $scope.create = dataService.clearMain();

    $rootScope.whereForCust = $rootScope.custtype == 3 ? 'where custtype = 3 and date_off is null' : 'where (custtype = 2 or (custtype = 3 and k050 = 910)) and date_off is null';

    $scope.AvalibleViddChange = $rootScope.custtype == 2 && $scope.isSave;

    $rootScope.credit = dataService.clearCredit();

    $rootScope.CUST_INFO = dataService.CUST_INFO();

    $rootScope.GKD = dataService.GKD();

    $rootScope.update = function (mode) {
        var url = "";
        if ($rootScope.nd != null) {

            bars.ui.loader('body', true);
            url = '/creditui/newcredit/getDeal/?nd=' + $rootScope.nd;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                var error = $scope.validateRequest(request);
                var save = $rootScope.credit;
                dataService.getDeal(save, request.data.Data);
                if ($rootScope.isTagOnly) {
                    $scope.mainTabStrip.select(3);
                }
                var _cust_data = request.data.Data.CUST_DATA;
                if (_cust_data !== null && $rootScope.custtype !== "2" ) {
                    $rootScope.CUST_INFO.EDRPO = _cust_data.EDRPO;
                    $rootScope.CUST_INFO.EDUCA = _cust_data.EDUCA;
                    $rootScope.CUST_INFO.MEMB = _cust_data.MEMB;
                    $rootScope.CUST_INFO.NAMEW = _cust_data.NAMEW;
                    $rootScope.CUST_INFO.NREMO = _cust_data.NREMO;
                    $rootScope.CUST_INFO.REMO = _cust_data.REMO;
                    $rootScope.CUST_INFO.STAT = _cust_data.STAT;
                    $rootScope.CUST_INFO.TYPEW = _cust_data.TYPEW;
                    $rootScope.CUST_INFO.REAL6INCOME = _cust_data.REAL6INCOME;
                    $rootScope.CUST_INFO.NOREAL6INCOME = _cust_data.NOREAL6INCOME;


                    $rootScope.ShowCustInfo = true;
                }

                var res = request.data.MultiExt;
                var multiExt = ['B', 'C', 'D', 'E'];
                for(var i = 0; i < multiExt.length; i++){
                    if(res[i]){
                        save['curr' + multiExt[i] + 'Value'] = res[i].KV;
                        save['rate' + multiExt[i] + 'Value'] = res[i].PROC;
                    }
                }

                var gkd_info = request.data.Gkd;
                if (gkd_info != null) {
                    $rootScope.GKD.wdate = kendo.toString(kendo.parseDate(gkd_info.WDATE, 'yyyy-MM-dd'), 'dd/MM/yyyy');
                    $rootScope.GKD.limit = kendo.toString(gkd_info.LIMIT, "n2");
                }
                bars.ui.loader('body', false);

            });
            if (mode === "by_button")
                $rootScope.LoadMoreCreditData("exist");
        }
        else {
            url = '/api/kernel/BankDates/';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $rootScope.bankDate = request.data.Date;
                $rootScope.credit.conslValue = request.data.Date;
                $rootScope.credit.startValue = request.data.Date;
                $rootScope.credit.issueValue = request.data.Date;
                var endDate = kendo.parseDate(request.data.Date);
                endDate.setMonth(endDate.getMonth() + 12);
                $rootScope.credit.endValue = endDate;
            });
        }


        $http.get(bars.config.urlContent('/creditui/newcredit/GetDataSources')).then(function (request) {
            $rootScope.data_sources = request.data;
            
            $scope.ddlCurComAccOptions = {
                dataSource: $rootScope.data_sources.Currency,
                dataTextField: "Value",
                dataValueField: "Key"
            };
            $scope.ddlMetrOptions = {
                dataSource: $rootScope.data_sources.Metr,
                dataTextField: "Value",
                dataValueField: "Key",
                optionLabel: " "
            };

            $scope.ddlDayNP = {
                dataSource: $rootScope.data_sources.Daynp,
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlFreqOptions = {
                dataSource: $rootScope.data_sources.Freq,
                dataTextField: "Value",
                dataValueField: "Key"
            };
            $scope.ddlFreqIntOptions = {
                dataSource: $rootScope.data_sources.Freq,
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlSourOptions = {
                dataSource: $rootScope.data_sources.Sour,
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlBaseyOptions = {
                dataSource: $rootScope.data_sources.Basey,
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlFinOptions = {
                dataSource: $rootScope.data_sources.FinStan,
                dataTextField: "Value",
                dataValueField: "Key"
            };
            $scope.ddlObsOptions = {
                dataSource: $rootScope.data_sources.StanObs,
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlCurOptions = {
                dataSource: $rootScope.data_sources.Currency,
                change: function (e) {
                    if ($rootScope.credit.baseRateValue != null) {
                        $rootScope.credit.baseRateValue = null;
                        $rootScope.credit.baseRateNameValue = null;
                        $scope.$apply();
                    }
                    if ($scope.isSave)
                        bars.ui.alert({ text: "Не забудьте змінити валюту рахунків" });
                },
                filter: "startswith",
                dataTextField: "Value",
                dataValueField: "Key"
            };

            $scope.ddlPOCIOptions = {
                dataSource: $rootScope.data_sources.Poci,
                dataTextField: "Value",
                dataValueField: "Key",
                optionLabel: { "Key": "", "Value": "" },
                change: function () {
                    $rootScope.credit.prodValue = null;
                    $rootScope.credit.prodNameValue = null;
                    $scope.$apply();
                }
            }

            $scope.ddlSPPIOptions = {
                dataSource: $rootScope.data_sources.Sppi,
                dataTextField: "Value",
                dataValueField: "Key",
                optionLabel: { "Key": -1, "Value": "" },
                change: function () {
                    $rootScope.SetIFRS();
                    $rootScope.credit.prodValue = null;
                    $rootScope.credit.prodNameValue = null;
                }
            }
        });
    };

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
            nls: function (element) {
                var $this = $element.find('[name="nls"]')[0];
                if (($scope.credit.nlsValue != null || $scope.credit.nlsValue != "") && $this == element[0] && $scope.credit.mfoValue != null) {
                    var nls = $scope.credit.nlsValue;
                    var mfo = $scope.credit.mfoValue;
                    if (nls && mfo) {
                    return bars.utils.vkrz(mfo.toString(), nls.toString()) == nls.toString();
                }
                }
                return true;
            }
        }
    };

    $scope.validateRequest = function (request) {
        if(request.data["Status"] != "OK"){
            bars.ui.loader('body', false);
            bars.ui.error({
                title: "Помилка створення КД",
                text: request.data["Status"],
                width: '800px',
                height: '600px'
            } );
            return false;
        }
        return true;
    };

    $scope.isSaveBtnEnabled = function () {
        if ($rootScope.isTagOnly) {
            return true;
        }
        return $rootScope.isProdValueValid() //a little perf magic 
            && $rootScope.isCurrValid()
            && $rootScope.isDayOfPayValueValid()
            && $rootScope.isBranchValueValid()
            && $rootScope.isDatesValid()
            && $rootScope.isNumValueValid()
            && $rootScope.isSumValueValid()
            && $rootScope.isBaseRateValueValueValid()
            && $rootScope.isDdlViddValueValid()
            && $rootScope.isCustValueValid()
            && $rootScope.credit.rnkValue != null
            && $rootScope.isNlsValid()
            //&& $rootScope.isGKDInfoValid()
            && ($rootScope.credit.dayOfPayValue == null || ($rootScope.credit.dayOfPayValue >= 1 && $rootScope.credit.dayOfPayValue <= 31))
            && (!$rootScope.credit.diffDaysValue || ($rootScope.credit.dayPayDiffValue == null || ($rootScope.credit.dayPayDiffValue >= 1 && $rootScope.credit.dayPayDiffValue <= 31)))
            && $rootScope.isFlagsValid()
            ;
    };

    $scope.save = function () {
        bars.ui.loader('body', true);
        
        var save = $rootScope.credit;
        if ($scope.validator.validate()) {
            if (save.freqValue == null) {       //kendo-drop-down-list name="ddlFreq"
                bars.ui.alert({ text: "Не обрана періодичність основного боргу" });
                bars.ui.loader('body', false);
            }
            else if (save.freqIntValue == null) {       //kendo-drop-down-list name="ddlFreqInt"
                bars.ui.alert({ text: "Не обрана періодичність сплати відсотків" });
                bars.ui.loader('body', false);
            }
            else if (save.sourValue == null) {      //kendo-drop-down-list="ddlSour"
                bars.ui.alert({ text: "Не обрано джерело залучення коштів" });
                bars.ui.loader('body', false);
            }
            else if (save.finValue == null) {       //kendo-drop-down-list name="ddlFin"
                bars.ui.alert({ text: "Не обрано фінансовий стан позичальника" });
                bars.ui.loader('body', false);
            }
            else if (save.aimValue == null && !$rootScope.IsGKD()) {       //kendo-drop-down-list="ddlAim"
                bars.ui.alert({ text: "Не обрано ціль кредитування" });
                bars.ui.loader('body', false);
            }
            else if (save.rangValue == null && !$rootScope.IsGKD()) {      //kendo-drop-down-list="ddlRang"
                bars.ui.alert({ text: "Не обрано шаблон погашення" });
                bars.ui.loader('body', false);
            }
            // else if (save.discontSumValue > 0 && save.metrValue == null) {      //kendo-drop-down-list k-ng-model="credit.metrValue"
            //     bars.ui.alert({ text: "Не обрано метод щомісячної комісії" });
            //     bars.ui.loader('body', false);
            //}
            else if (save.discontSumValue > 0 && save.curComAccValue == null) {     //kendo-drop-down-list name="ddlCurComAcc"
                bars.ui.alert({ text: "Не обрано валюту коміссійних доходів" });
                bars.ui.loader('body', false);
            }
            else if (save.unusedLimitValue > 0 && save.curComAccValue == null) {
                bars.ui.alert({ text: "Не обрано валюту коміссійних доходів" });
                bars.ui.loader('body', false);
            }
            //else if (save.penaltiesRateValue && save.unusedLimitValue == null) {
            //    bars.ui.alert({ text: "Не обрано \"Комісія за не використаний кредит\"" });
            //    bars.ui.loader('body', false);
            //}
            else {
                if ($rootScope.nd == null) {
                    dataService.create($scope.create, save, $rootScope.IsGKD());
                    $scope.create.ID = null;

                    var url = '/creditui/newcredit/createdeal';
                    $http.post(bars.config.urlContent(url), $scope.create).then(function (request) {
                        if(!$scope.validateRequest(request)){ return; }

                        $rootScope.ndtxtsave.nd = request.data["Nd"];
                        $scope.Title += (" ("+$rootScope.ndtxtsave.nd+")");

                        if ($rootScope.ndtxtsave.nd != -1) {
                            url = '/creditui/newcredit/setndtxt';

                            $http.post(bars.config.urlContent(url), $rootScope.ndtxtsave).then(function (request) {
                                var output_err = request.data.Error_data != "Ok" ? request.data.Error_data : "";
                                if(!$scope.validateRequest(request)){ return; }

                                url = '/creditui/newcredit/afterSaveDeal';
                                $http.post(bars.config.urlContent(url), dataService.afterSaveDeal($rootScope.ndtxtsave.nd, save, $rootScope.IsGKD())).then(function (request) {
                                    if(!$scope.validateRequest(request)){ return; }

                                    if (save.currBValue || save.baseRateValue || save.serviceValue) {
                                        url = "/creditui/newcredit/setMultiExtInt";
                                        $http.post(bars.config.urlContent(url), dataService.multiExtInt($rootScope.ndtxtsave.nd, save)).then(function (request) {
                                            if(!$scope.validateRequest(request)){ return; }

                                            $rootScope.nd = $rootScope.ndtxtsave.nd;
                                            $scope.isSave = true;
                                            bars.ui.alert({
                                                text: "Створено КД №" + $rootScope.ndtxtsave.nd
                                            });
                                            if (output_err != "") {
                                                bars.ui.error({
                                                    title: "Помилки при збереженні доппараметрів",
                                                    text: output_err
                                                });
                                            }
                                            bars.ui.loader('body', false);
                                        });
                                    }
                                    else {
                                        $rootScope.nd = $rootScope.ndtxtsave.nd;
                                        $scope.isSave = true;
                                        bars.ui.alert({
                                            text: "Створено КД №" + $rootScope.ndtxtsave.nd
                                        });
                                        if (output_err != "") {
                                            bars.ui.error({
                                                title: "Помилки при збереженні доппараметрів",
                                                text: output_err
                                            });
                                        }
                                        bars.ui.loader('body', false);
                                    }
                                });
                            });
                        }
                        else {
                            bars.ui.alert({
                                text: "<span style='color:red'>Помилка створення КД</span>"
                            });
                            bars.ui.loader('body', false);
                        }
                    });
                }
                else if (!$rootScope.isTagOnly) {
                    $scope.create.ACC8 = save.acc8;
                    $scope.create.ND = $rootScope.nd;
                    dataService.create($scope.create, save);

                    var url = '/creditui/newcredit/updatedeal';
                    $http.post(bars.config.urlContent(url), $scope.create).then(function (request) {
                        if(!$scope.validateRequest(request)){ return; }

                        $rootScope.ndtxtsave.nd = request.data["Nd"];
                        if ($rootScope.ndtxtsave.nd != -1) {
                            url = '/creditui/newcredit/setndtxt';
                            $http.post(bars.config.urlContent(url), $rootScope.ndtxtsave).then(function (request) {
                                var output_err = request.data.Error_data != "Ok" ? request.data.Error_data : "";
                                url = '/creditui/newcredit/afterSaveDeal';
                                $http.post(bars.config.urlContent(url), dataService.afterSaveDeal($rootScope.ndtxtsave.nd, save)).then(function (request) {
                                    if (!$scope.validateRequest(request)) { return; }
                                    url = "/creditui/newcredit/setMultiExtInt";
                                    $http.post(bars.config.urlContent(url), dataService.multiExtInt($rootScope.ndtxtsave.nd, save)).then(function (request) {
                                        $scope.isSave = true;
                                        bars.ui.alert({
                                            text: "Оновлено КД №" + $rootScope.ndtxtsave.nd
                                        });
                                        if (output_err != "") {
                                            bars.ui.error({
                                                title: "Помилки при збереженні доппараметрів",
                                                text: output_err
                                            });
                                        }
                                        bars.ui.loader('body', false);
                                    });
                                });
                            });
                        }
                        else {
                            bars.ui.alert({
                                text: "<span style='color:red'>Помилка оновлення КД</span>"
                            });
                            bars.ui.loader('body', false);
                        }
                    });
                }
                else {
                    $rootScope.ndtxtsave.nd = $rootScope.nd;
                    if ($rootScope.ndtxtsave.nd != -1) {
                        url = '/creditui/newcredit/setndtxt';
                        $http.post(bars.config.urlContent(url), $rootScope.ndtxtsave).then(function (request) {
                            var output_err = request.data.Error_data != "Ok" ? request.data.Error_data : "";
                            $scope.isSave = true;
                            if (output_err == "") {
                                bars.ui.alert({
                                    text: "Оновлено КД №" + $rootScope.ndtxtsave.nd
                                });
                            } else {
                                bars.ui.error({
                                    title: "Помилки при збереженні доппараметрів", 
                                    text: output_err
                                });
                            }
                            bars.ui.loader('body', false);
                        });
                    }
                    else {
                        bars.ui.alert({
                            text: "<span style='color:red'>Помилка оновлення КД</span>"
                        });
                        bars.ui.loader('body', false);
                    }
                }
            }
        }
    };

    $scope.dpFormatOptions = {
        format: "{0:dd.MM.yyyy}",
        mask: "00.00.0000"
    };

    $scope.prolong = {
        dateEnd: null,
        bnkdate: null,
        kprolog: null,
        sos: null
    };

    $scope.prolongation = function () {
        var url = '/api/kernel/BankDates/';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            $scope.prolong.dateEnd = kendo.parseDate($rootScope.credit.endValue);//kendo.parseDate(request.data.Date);
            $scope.prolong.bnkdate = kendo.parseDate(request.data.Date);
        });
        $scope.wndProlongation.open();
        $scope.wndProlongation.center();
    };

    $scope.prolongationSave = function () {
        if ($scope.prolong.dateEnd < $scope.prolong.bnkdate) {
            bars.ui.alert({
                text: "Дата початку дії нової дати пролонгації повинна бути більше банківської дати"
            });
        }
        else if ($scope.prolong.dateEnd <= kendo.parseDate($rootScope.credit.startValue)) {
            bars.ui.alert({
                text: "Дата пролонгації не може бути меньше за дату початку дії договору"
            });
        }
        /*else if ($scope.prolong.dateEnd <= kendo.parseDate($rootScope.credit.endValue)) {
            bars.ui.alert({
                text: "Дата пролонгації меньша поточної дати закінчення договору"
            });
        }*/
        else {
            if ($scope.prolong.dateEnd <= kendo.parseDate($rootScope.credit.endValue)) {
                bars.ui.alert({
                    text: "ГПК містить записи з датою більше вказаної! Не забудьте ПЕРЕБУДУВАТИ ГПК!"
                });
            }
            var url = '/creditui/newcredit/getprolog?nd=' + $rootScope.nd;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $scope.prolong.kprolog = request.data.KPROLOG;
                $scope.prolong.sos = request.data.SOS;
                url = '/creditui/newcredit/setprolog';
                $http.post(bars.config.urlContent(url), {
                    nd: $rootScope.nd,
                    bnkDate: kendo.parseDate($scope.prolong.bnkdate),
                    kprolog: $scope.prolong.kprolog,
                    sos: $scope.prolong.sos,
                    dateStart: kendo.parseDate($rootScope.credit.startValue),
                    dateEnd: kendo.parseDate($scope.prolong.dateEnd)
                }).then(function (request) {
                    //debugger;
                    if (request.data == "\"Ok\"") {
                        bars.ui.alert({
                            text: request.data
                        });
                        $scope.wndProlongation.close();
                        $location.reload();
                    }
                    else {
                        bars.ui.error({
                            text: request.data
                        });
                        $scope.wndProlongation.close();
                    }
                });
            });
        }

    };

    $scope.creditUpdate = function () {
        $rootScope.update("by_button");
    };

    $scope.prolongationClose = function () {
        $scope.wndProlongation.close();
        $scope.prolong.dateEnd = null;
    };

    $rootScope.update("initial");    // load main data
}]);