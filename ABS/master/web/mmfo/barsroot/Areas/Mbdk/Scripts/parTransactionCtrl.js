angular.module("BarsWeb.Areas").controller("Mbdk.parTransactionCtrl", ["$scope", "$http", "$location", function ($scope, $http, $location) {
    $scope.Title = 'Зміна параметрів угоди на МБ';
    var localUrl = $location.absUrl();
    var nd = bars.extension.getParamFromUrl('nd', localUrl);
    var nls = bars.extension.getParamFromUrl('nls', localUrl);
    $scope.toolbarOptions = {
        items: [
            {
                template: "<label>Пролонгація по договору " + nd + "</label>"
            },
            {
                type: "separator"
            },
            {
                template: "<label>№ розпорядження</label>"
            },
            {
                template: "<input type='text' class='k-textbox' style='width: 50px;' ng-model='model.rNum' />"
            },
            {
                type: "separator"
            },
            {
                template: "<button class='k-button margin-right-pos' id='' name='' value='' ng-click='saveRollOver()' title='Зберегти нові параметри'><span class='k-sprite pf-icon pf-16 pf-save'></span> </button>"
            },
            {
                template: "<button ng-click='wndHistory.open()' class='k-button margin-right-pos' id='' name='' value='' title='Відомості про зміни угоди'><span class='k-sprite pf-icon pf-16 pf-arrow_right'></span> </button>"
            },
            {
                type: "separator"
            },
            {
                template: "<button ng-click='wndSwift.open()' class='k-button margin-right-pos' id='' name='' value='' title='Введення доп. реквізитів SWIFT'><span class='k-sprite pf-icon pf-16 pf-tool_pencil'></span> </button>"
            },
            {
                template: "<button ng-click='createSwift()' class='k-button margin-right-pos' id='btnMail' name='btnMail' value='' title='Сформувати SWIFT повідомлення' ng-disabled='true'><span class='k-sprite pf-icon pf-16 pf-mail'></span> </button>"
            },
            {
                template: "<button ng-click='viewSwift()' class='k-button margin-right-pos' id='btnRepOpen' name='btnRepOpen' value='' title='Друк/Перегляд сформованого повідомлення'  ng-disabled='true'><span class='k-sprite pf-icon pf-16 pf-report_open'></span> </button>"
            }
        ]
    };

    $scope.model = {
        rnk: null,
        mfo: null,
        nmk: null,
        genAgreeDate: null,
        genAgreeNum: null,
        cntChange: null,
        curr: null,
        currName: null,
        typeTrCode: null,
        typeTrName: null,
        prevHolderDate: null,
        prevHolderNum: null,
        prevHolderRef: null,
        mainAcc: null,
        mainAccBal: null,
        newNextTr: false,
        newHolderNum: null,
        newHolderRef: null,
        interestAcc: null,
        interestAccBal: null,
        receivableAcc: null,
        receivableAccBal: null,
        dateStartPrev: null,
        dateStartNew: null,
        dateStartDiff: null,
        dateEndPrev: null,
        dateEndNew: null,
        dateEndDiff: null,
        dealSumPrev: null,
        dealSumNew: null,
        dealSumDiff: null,
        intRatePrev: null,
        intRateNew: null,
        intRateDiff: null,
        intSumPrev: null,
        intSumNew: null,
        intSumDiff: null,
        dealViddPrev: null,
        dealViddNew: null,
        dealViddAcc: null,
        garName: null,
        garAcc: null,
        dealViddName: null,
        innerCore: false,
        intInner: false,
        bicBank: null,
        accVostro: null,
        accNameToCurr: null,
        accToCurr: null,
        bicBankPar: null,
        accPartner: null,
        bankSwift: null,
        bankSwiftMulti: null,
        zal: null,
        nlsn: null,
        nlsb_new: null,
        nlsb_newb: null,
        ctNazn: 'Пролонгація',
        brokerA: null,
        brokerB: null,
        backIntA: null,
        backIntB: null,
        backBrokerA: null,
        backBrokerB: null,
        tipd: null,
        mfokred: null,
        rNum: null,
        basey: null,
        swtRef: null
    };

    $scope.saveModel = {
        CC_ID_NEW: null,
        ND: null,
        nID: null,
        nKV: null,
        NLS_OLD: null,
        NLS_NEW: null,
        NLS8_NEW: null,
        nS_OLD: null,
        nS_NEW: null,
        nPR_OLD: null,
        nPR_NEW: null,
        DATK_OLD: null,
        DATK_NEW: null,
        DATN_OLD: null,
        DATN_NEW: null,
        NLSB_NEW: null,
        MFOB_NEW: null,
        NLSNB_NEW: null,
        MFONB_NEW: null,
        REFP_NEW: null,
        BICA: null,
        SSLA: null,
        BICB: null,
        SSLB: null,
        AltB: null,
        IntermA: null,
        IntermB: null,
        IntPartyA: null,
        IntPartyB: null,
        IntIntermA: null,
        IntIntermB: null,
        IntAmount: null,
        ND_NEW: null,
        ACC_NEW: null
    };

    $scope.oldModel = {
        newHolderNum: null,
        newHolderRef: null,
        dateStartNew: null,
        ctNazn: null,
        nlsnb_new: null,
        dealViddNew: null,
        dealViddAcc: null,
        nlsn: null
    };

    var dataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: '/barsroot/api/mbdk/gettransaction/getallnbklist/',
                data: {
                    kv: function () {
                        return $scope.model.curr
                    }
                },
                dataType: "json"
            }
        },
        schema: {
            model: {
                nls: "NLS",
                nms: "NMS",
                bic: "BIC",
                teirAcc: "THEIR_ACC"
            }

        }
    });

    var historyDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/mbdk/gettransaction/gethistory/'),
                data: { nd: nd },
                dataType: "json"
            }
        },
        schema: {
            id: "FDAT",
            model: {
                fields: {
                    FDAT: { type: "date" },
                    NPP: { type: "number" },
                    TXT: { type: "string" },
                    KV: { type: "number" },
                    NLS: { type: "string" }
                }
            }
        }
    });

    var accModelDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent('/api/mbdk/gettransaction/getaccmodel/'),
                data: { nd: nd },
                dataType: "json"
            }
        },
        schema: {
            id: "REF",
            model: {
                fields: {
                    REF: { type: "number" },
                    VDAT: { type: "date" },
                    TT: { type: "string" },
                    NLS: { type: "string" },
                    KV: { type: "number" },
                    DB: { type: "number" },
                    KD: { type: "number" },
                    NMS: { type: "string" }
                }
            }
        }
    });

    var url = '/api/mbdk/gettransaction/gettransactionlist/?nd=' + nd + '&nls=' + nls;
    $http.get(bars.config.urlContent(url)).then(function (request) {
        var data = request.data[0];
        $scope.model.tipd = data.TIPD == 1 ? false : true;
        $scope.model.rnk = data.RNK;
        $scope.model.mfo = data.MFO;
        $scope.model.nmk = data.NMK;
        $scope.model.genAgreeDate = data.DAT_ND;
        $scope.model.genAgreeNum = data.NUM_ND;
        $scope.model.cntChange = data.KPROLOG;
        $scope.model.curr = data.A_KV;
        $scope.model.currName = data.NAME;
        $scope.model.typeTrCode = data.VIDD;
        $scope.model.typeTrName = data.VIDD_NAME;
        $scope.model.prevHolderDate = data.DATE_U;
        $scope.model.prevHolderNum = data.CC_ID;
        $scope.model.prevHolderRef = data.ND;
        $scope.model.mainAcc = data.A_NLS;
        $scope.model.mainAccBal = $scope.model.tipd ? data.A_OSTC : -data.A_OSTC;
        $scope.model.newNextTr = false;
        $scope.model.newHolderNum = data.CC_ID;
        $scope.model.newHolderRef = data.ND;
        $scope.model.interestAcc = data.B_NLS;
        $scope.model.interestAccBal = $scope.model.tipd ? data.B_OSTC : -data.B_OSTC;
        $scope.model.receivableAcc = data.NLS_1819;
        $scope.model.receivableAccBal = data.OSTC;
        $scope.model.dateStartPrev = data.DATE_V;
        $scope.model.dateStartNew = data.DATE_V;
        $scope.model.dateStartDiff = null;
        $scope.model.dateEndPrev = data.DATE_END;
        $scope.model.dateEndNew = data.DATE_END;
        $scope.model.dateEndDiff = null;
        $scope.model.dealSumPrev = data.S;
        $scope.model.dealSumNew = data.S;
        $scope.model.dealSumDiff = null;
        $scope.model.intRatePrev = data.S_PR;
        $scope.model.intRateNew = data.S_PR;
        $scope.model.intRateDiff = null;
        $scope.model.intSumPrev = data.INT_AMOUNT;
        $scope.model.intSumNew = data.INT_AMOUNT;
        $scope.model.intSumDiff = null;
        $scope.model.dealViddPrev = data.VIDD;
        $scope.model.dealViddNew = data.VIDD;
        $scope.model.dealViddAcc = data.A_NLS;
        $scope.model.zal = data.ZAL;
        $scope.model.bicBank = data.SWI_BIC;
        $scope.model.accVostro = data.SWI_ACC;
        $scope.model.bicBankPar = data.SWO_BIC;
        $scope.model.accPartner = data.SWO_ACC;
        $scope.model.mfokred = data.MFOKRED;
        $scope.model.basey = data.BASEY;
        $scope.model.bankSwiftMulti = data.ALT_PARTYB;
        if (!$scope.model.tipd && $scope.model.accPartner != null) {
            $scope.model.nlsnb_new = $scope.model.accPartner;
        }
        
        $scope.ddlNbkOptions.dataSource.fetch(function () {
            var url = '/api/mbdk/gettransaction/getnbklist/?accVostro=' + $scope.model.accVostro + '&bickA=' + $scope.model.bicBank;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                if (request.data[0]) $scope.model.accNameToCurr = { NLS: request.data[0].NLS, NMS: request.data[0].NMS };
            });
        });
        $scope.grdHistoryOptions.dataSource.read();
        $scope.grdAccModelOptions.dataSource.read();
    });

    $scope.ddlNbkOptions = {
        autoBind: false,
        dataSource: dataSource,
        dataTextField: "NMS",
        dataValueField: "NLS",
        change: function () {
            var length = dataSource.data().length;
            var data = dataSource.data();
            for (var i = 0; i < length; i++) {
                if ($scope.model.accNameToCurr.NLS == data[i].NLS) {
                    $scope.model.bicBank = data[i].BIC;
                    $scope.model.accVostro = data[i].THEIR_ACC;
                    $scope.$apply();
                }
            }
        }
    };

    $scope.dpDateFormatOptions = {
        format: "{0:dd.MM.yyyy}",
        mask: "99.99.9999"
    };

    $scope.decimalFormat = {
        format: "#.00"
    };

    $scope.showReferBankSwift = function (tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            $scope.model.bankSwift = data[0];
            $scope.$apply();
        },
        {
            multiSelect: false,
            clause: whereClause,
            columns: showFields
        });
    };

    $scope.showReferMultiSwift = function (modelName, tabName, showFields, whereClause) {
        bars.ui.handBook(tabName, function (data) {
            for (var i = 0; i < data.length; i++) {
                if ($scope.model[modelName] == null) {
                    $scope.model[modelName] = data[i].BIC;
                }
                else {
                    $scope.model[modelName] += " " + data[i].BIC;
                }
            }
            $scope.$apply();
        },
        {
            multiSelect: true,
            clause: whereClause,
            columns: showFields
        });
    };

    $scope.changeNewDeal = function () {
        if ($scope.model.newNextTr) {
            $scope.oldModel.newHolderNum = $scope.model.newHolderNum;
            $scope.oldModel.newHolderRef = $scope.model.newHolderRef;
            $scope.oldModel.dateStartNew = $scope.model.dateStartNew;
            $scope.oldModel.ctNazn = $scope.model.ctNazn;
            $scope.model.newHolderNum = null;
            $scope.model.newHolderRef = null;
            var url = '/api/kernel/BankDates/';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $scope.model.dateStartNew = request.data.Date;
            });
            $scope.model.ctNazn = 'RollOver'
        }
        else {
            $scope.model.newHolderNum = $scope.oldModel.newHolderNum;
            $scope.model.newHolderRef = $scope.oldModel.newHolderRef;
            $scope.model.dateStartNew = $scope.oldModel.dateStartNew;
            $scope.model.ctNazn = $scope.oldModel.ctNazn;
        }
    }

    $scope.changeInterest = function () {
        var amnt = -$scope.model.dealSumNew * 100;
        var io;
        var dateS = kendo.parseDate($scope.model.dateStartNew);
        var dateE = kendo.parseDate($scope.model.dateEndNew);
        var dayE = dateE.getDate();
        var dateStart = (dateS.getDate() < 10 ? "0" + dateS.getDate() : dateS.getDate()) + "." + ((dateS.getMonth() + 1) < 10 ? "0" + (dateS.getMonth() + 1) : (dateS.getMonth() + 1)) + "." + dateS.getFullYear();
        var dateEnd;
        var url = '/api/mbdk/gettransaction/getio/?vidd=' + $scope.model.typeTrCode;
        $http.get(bars.config.urlContent(url)).then(function (request) {
            io = request.data;
            if (io == 1 && dateS <= dateE - 2) {
                dayE = dayE - 2;
            }
            else {
                dayE = dayE - 1;
            }
            dateEnd = (dayE < 10 ? "0" + dayE : dayE) + "." + ((dateE.getMonth() + 1) < 10 ? "0" + (dateE.getMonth() + 1) : (dateE.getMonth() + 1)) + "." + dateE.getFullYear();
            url = '/api/mbdk/gettransaction/getints/?amnt=' + amnt + '&pr=' + $scope.model.intRateNew + '&dateStart=' + dateStart + '&dateEnd=' + dateEnd + '&basey=' + $scope.model.basey;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                $scope.model.intSumNew = -request.data/100;
            });
        });
    };

    $scope.$watch("model.dateStartNew", function (newValue, oldValue) {
        var dateTo = kendo.parseDate($scope.model.dateStartNew);
        var dateFrom = kendo.parseDate($scope.model.dateStartPrev);
        if (dateTo != null && dateFrom != null) {
            var timeDiff = Math.abs(dateTo.getTime() - dateFrom.getTime());
            var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
            $scope.model.dateStartDiff = diffDays;
        }
    });

    $scope.$watch("model.dateEndNew", function (newValue, oldValue) {
        var dateTo = kendo.parseDate($scope.model.dateEndNew);
        var dateFrom = kendo.parseDate($scope.model.dateEndPrev);
        if (dateTo != null && dateFrom != null) {
            var timeDiff = Math.abs(dateTo.getTime() - dateFrom.getTime());
            var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
            $scope.model.dateEndDiff = diffDays;
        }
    });

    $scope.$watch("model.dealSumNew", function (newValue, oldValue) {
        var sumTo = $scope.model.dealSumNew;
        var sumFrom = $scope.model.dealSumPrev;
        if (sumTo != null && sumFrom != null) {
            var sumDiff = sumTo - sumFrom;
            $scope.model.dealSumDiff = sumDiff;
        }
    });

    $scope.$watch("model.intRateNew", function (newValue, oldValue) {
        var rateTo = $scope.model.intRateNew;
        var rateFrom = $scope.model.intRatePrev;
        if (rateTo != null && rateFrom != null) {
            var rateDiff = rateTo - rateFrom;
            $scope.model.intRateDiff = rateDiff;
        }
    });

    $scope.$watch("model.intSumNew", function (newValue, oldValue) {
        var sumTo = $scope.model.intSumNew;
        var sumFrom = $scope.model.intSumPrev;
        if (sumTo != null && sumFrom != null) {
            var sumDiff = sumTo - sumFrom;
            $scope.model.intSumDiff = sumDiff;
        }
    });

    $scope.$watch("model.bankSwift", function () {
        if ($scope.model.bankSwift != null) {
            $scope.model.bicBankPar = $scope.model.bankSwift.BIC;
        }
    });

    $scope.$watch("model.dealViddNew", function () {
        if ($scope.model.dealViddNew != null && $scope.oldModel.dealViddNew != null && $scope.model.dealViddNew == $scope.oldModel.dealViddNew) {
            bars.ui.alert({
                text: "Не змінили вид договору"
            });
            $scope.model.dealViddAcc = $scope.oldModel.dealViddAcc;
            $scope.model.nlsn = $scope.oldModel.nlsn;
        }
    });
    
    $scope.checkVkrz = function () {
        if ($scope.model.nlsnb_new != null) {
            if ($scope.model.nlsnb_new != bars.utils.vkrz($scope.model.mfo, $scope.model.nlsnb_new.toString())) {
                bars.ui.alert({
                    text: "Не вірний контрольний розряд"
                });
            }
            else {
                $scope.model.accPartner = $scope.model.nlsnb_new;
            }
        }
    };

    $scope.wndBuhModelOption = {
        title: "Бухгалтерська модель",
        visible: false,
        width: "800px",
        height: "500px",
        modal: true
    }

    $scope.wndHistoryOption = {
        title: "Історія змін",
        visible: false,
        width: "800px",
        height: "500px",
        modal: true
    }

    $scope.wndSwiftOptions = {
        title: "Введення додаткових реквізитів SWIFT",
        visible: false,
        position : { top: 100, left: 100 },
        modal: true,
    };

    $scope.wndViewSwiftOptions = {
        title: "",
        content: "",
        visible: false,
        width: "600px",
        height: "420px",
        modal: true,
        iframe: true
    };    

    $scope.grdHistoryOptions = {
        autoBind: false,
        dataSource: historyDataSource,
        filterable: true,
        columns: [{
            field: "FDAT",
            title: "Дата змін",
            format: "{0:dd.MM.yyyy}",
            width: 100
        },
        {
            field: "NPP",
            title: "№ п.п",
            width: 50
        },
        {
            field: "KV",
            title: "Валюта",
            width: 50
        },
        {
            field: "NLS",
            title: "Основний рахунок",
            width: 150
        },
        {
            field: "TXT",
            title: "Опис змін"
        }]
    };

    $scope.grdAccModelOptions = {
        autoBind: false,
        dataSource: accModelDataSource,
        filterable: true,
        columns: [{
            field: "REF",
            title: "Реф."
        },
        {
            field: "VDAT",
            title: "Дата",
            format: "{0:dd.MM.yyyy}",
            width: 100
        },
        {
            field: "TT",
            title: "Оп.",
            width: 50
        },
        {
            field: "NLS",
            title: "Особистий рахунок"
        },
        {
            field: "KV",
            title: "Вал.",
            width: 50
        },
        {
            field: "DB",
            title: "Дебет",
            width: 100
        },
        {
            field: "KD",
            title: "Кредит",
            width: 100
        },
        {
            field: "NMS",
            title: "Найменування рахунка"
        }]
    };

    $scope.closeSwift = function () {
        $scope.model.brokerA = null;
        $scope.model.brokerB = null;
        $scope.model.backIntA = null;
        $scope.model.backIntB = null;
        $scope.model.backBrokerA = null;
        $scope.model.backBrokerB = null;
        $scope.wndSwift.close();
    };

    $scope.changeInnerCore = function () {
        if ($scope.model.innerCore) {
            $scope.oldModel.nlsnb_new = $scope.model.nlsnb_new;
            $scope.model.nlsnb_new = null;
        }
        else {
            $scope.model.nlsnb_new = $scope.oldModel.nlsnb_new;
        }
    };

    $scope.getAccNumber = function () {
        if (!$scope.oldModel.dealViddNew && !$scope.oldModel.dealViddAcc) {
            $scope.oldModel.dealViddNew = $scope.model.dealViddPrev;
            $scope.oldModel.dealViddAcc = $scope.model.dealViddAcc;
            $scope.oldModel.nlsn = $scope.model.nlsn;
        }
        var acclist = "";
        var url = '/api/mbdk/gettransaction/getaccnumber/?vidd=' + /*$scope.model.typeTrCode*/$scope.model.dealViddNew + '&rnk=' + $scope.model.rnk + '&kv=' + $scope.model.curr + '&mask=MBK_LIMITB';
        $http.get(bars.config.urlContent(url)).then(function (request) {
            acclist = request.data;
            var accarray = acclist.replace('"', '').split(" ");
            $scope.model.dealViddAcc = accarray[0];
            $scope.model.nlsn = accarray[1];
        });
    };

    $scope.saveRollOver = function () {
        var vps = null;
        var ourMfo = null;
        var url = '/api/mbdk/gettransaction/getvps/?mfokred=' + $scope.model.mfokred + "&kv=" + $scope.model.curr;
        $http.get(bars.config.urlContent(url)).then(function (request) {
            vps = request.data;
            url = '/api/kernel/Params/GetParam/?id=MFO';
            $http.get(bars.config.urlContent(url)).then(function (request) {
                ourMfo = request.data.Value;
                $scope.saveModel.CC_ID_NEW = $scope.model.newHolderNum;
                $scope.saveModel.ND = nd;
                $scope.saveModel.nID = ($scope.model.tipd ? 1 : 0);
                $scope.saveModel.nKV = $scope.model.curr;
                $scope.saveModel.NLS_OLD = $scope.model.mainAcc;
                $scope.saveModel.NLS_NEW = $scope.model.dealViddAcc;
                $scope.saveModel.NLS8_NEW = $scope.model.nlsn;
                $scope.saveModel.nS_OLD = $scope.model.dealSumPrev;
                $scope.saveModel.nS_NEW = $scope.model.dealSumNew;
                $scope.saveModel.nPR_OLD = $scope.model.intRatePrev;
                $scope.saveModel.nPR_NEW = $scope.model.intRateNew;
                $scope.saveModel.DATK_OLD = $scope.model.dateEndPrev;
                $scope.saveModel.DATK_NEW = $scope.model.dateEndNew;
                $scope.saveModel.DATN_OLD = $scope.model.dateStartPrev;
                $scope.saveModel.DATN_NEW = $scope.model.dateStartNew;
                $scope.saveModel.NLSB_NEW = $scope.model.innerCore ? $scope.model.nlsn : ($scope.model.curr == 980 || vps == 1 ? $scope.model.nlsn : $scope.model.accPartner);
                $scope.saveModel.MFOB_NEW = $scope.model.intInner ? ourMfo : ($scope.model.curr == 980 || vps == 1 || !$scope.model.tipd ? $scope.model.mfo : $scope.model.bicBankPar);
                $scope.saveModel.NLSNB_NEW = !$scope.model.tipd ? null : ($scope.model.innerCore ? $scope.model.nlsn : ($scope.model.curr == 980 || vps == 1 ? $scope.model.nlsn : $scope.model.accPartner));
                $scope.saveModel.MFONB_NEW = $scope.model.intInner ? ourMfo : ($scope.model.curr == 980 || vps == 1 || !$scope.model.tipd ? $scope.model.mfo : $scope.model.bicBankPar);
                $scope.saveModel.REFP_NEW = $scope.model.innerCore && (!$scope.model.tipd || $scope.model.innerCore && $scope.model.tipd || $scope.model.curr == 980) ? $scope.model.nlsn : ($scope.model.accNameToCurr == null ? $scope.model.nlsn : $scope.model.accNameToCurr.NLS);
                $scope.saveModel.BICA = $scope.model.bicBank;
                $scope.saveModel.SSLA = $scope.model.accVostro;
                $scope.saveModel.BICB = $scope.model.bicBankPar;
                $scope.saveModel.SSLB = $scope.model.accPartner;
                $scope.saveModel.AltB = $scope.model.bankSwiftMulti;
                $scope.saveModel.IntermA = $scope.model.brokerA;
                $scope.saveModel.IntermB = $scope.model.brokerB;
                $scope.saveModel.IntPartyA = $scope.model.backIntA;
                $scope.saveModel.IntPartyB = $scope.model.backIntB;
                $scope.saveModel.IntIntermA = $scope.model.backBrokerA;
                $scope.saveModel.IntIntermB = $scope.model.backBrokerB;
                $scope.saveModel.IntAmount = $scope.model.intSumNew;
                /************ send POST to save *********/
                url = '/api/mbdk/savetransaction/setdealparam/?nd=' + nd + '&tag=RNUM&val=' + $scope.model.rNum;
                $http.post(bars.config.urlContent(url)).then(function (request) {
                    url = '/api/mbdk/savetransaction/saveRollOver/';
                    $http.post(bars.config.urlContent(url), $scope.saveModel).then(function (request) {
                        var obj = request.data;
                        $scope.saveModel.ND_NEW = obj.nd;
                        $scope.saveModel.ACC_NEW = obj.acc;
                        bars.ui.alert({
                            text: "Збережено успішно"
                        });
                        angular.element(document).find("#btnMail")[0].removeAttribute("disabled");
                    });
                });
            });
        });
    };

    $scope.createSwift = function () {
        debugger;
        if ($scope.saveModel.ND_NEW != null && $scope.saveModel.ACC_NEW != null) {
            var url = '/api/mbdk/savetransaction/SaveRollOver1';
            var options = null;
            if ($scope.saveModel.ND_NEW == nd) {
                options = "ROLL";
            }
            var tmp_nd = parseInt($scope.saveModel.ND_NEW);
            debugger;
            $.ajax({
                url: bars.config.urlContent(url) + "?newReff=" + tmp_nd + "&sw_options=" + options,
                method: "GET",
                dataType: "json",
                data: ({newRef: $scope.saveModel.ND_NEW, options: options }),
                async: false,
                success: function (data) {
                    debugger;
                    if(data == "Error")
                        bars.ui.error({ text: "SWIFT повідомлення вже було сформовано" });
                    else
                        bars.ui.success({ text: "SWIFT повідомлення було сформовано" });
                    $("#btnRepOpen").prop("disabled", false);
                        }
            }).fail(function () {
            });
        }
    };

    $scope.viewSwift = function () {
        if ($scope.saveModel.ND_NEW != null) {
            var url = '/api/mbdk/gettransaction/getswiftref/?newNd=' + $scope.saveModel.ND_NEW;
            $http.get(bars.config.urlContent(url)).then(function (request) {
                debugger;
                $scope.model.swtRef = request.data;
                debugger;
                $scope.wndViewSwiftOptions.content = bars.config.urlContent("/documentview/view_swift.aspx?swref=") + $scope.model.swtRef;
                debugger;
                $scope.wndViewSwift.open();
            });
        }
    };
}]);