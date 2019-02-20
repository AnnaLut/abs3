app.factory('paramsService', function ($http) {

    var paramsServiceFactory = {};

    var model = {
        DTMP: null,
        REF_MAIN: null,
        AMORT: null,
        NTMP: null,
        STMP: null,
        AMFO: null,
        SSQLPF: null,
        STMP1: null,
        SREF: null,
        NDCP: null,
        NTIPD: null,
        NBASEY: null,
        FL: null,
        ACCA: null,
        ACCP: null,
        ACCR: null,
        NRYN: null,
        NPF: null,
        NDOX: null,
        NEMI: null,
        NAMEEMI: null,
        NAMECP: null,
        ND_: null,
        NID: null,
        N980: null,
        NCOUNTRY: null,
        MFO_NBU: null,
        NREF: null,
        NREF0: null,
        NREF1: null,
        NREF2: null,
        NREF3: null,
        SPOISK: null,
        SPOISK_: null,
        SPOISK1: null,
        NLS9: null,
        NLS8: null,
        NLS71: null,
        HBTNYES: null,
        HBTNNO: null,
        HBTNS: null,
        BARC: null,
        DDAT: null,
        DDAT31: null,
        DAY_ZO: null,
        P_VIDD: null,
        IFRS: "",
        BUS_MOD: null,
        SPPI: null
    };
    var baseUrl = '/barsroot/api/valuepapers/generalfolder/';

    var defaultParams = {};
    var _getDefaultParams = function () {

        return $http.get(baseUrl + 'GetContractSaleWindowFixedParams')
        .then(function (response) {

            if (!$.isArray(response.data))
                throw new Error('method return wrong value!');

            response.data.forEach(function (elem) {
                model[elem.Param] = elem.Value;
                defaultParams[elem.Param] = elem.Value;
            });

            return model;
        });
    }

    var _resetModel = function () {
        Object.keys(model).forEach(function (elem) {
            if (!defaultParams[elem])
                delete model[elem];
        });
    }


    var _getGetDataListFor_cbm_PF = function () {
        return $http.get(baseUrl + 'GetDataListFor_cbm_PF')
                .then(function (response) {
                    return response.data;
                })
    }

    var _get_NLS_A_and_SVIDD = function () {
        return $http({
            url: baseUrl + 'Get_NLS_A_and_SVIDD',
            method: "GET",
            params: { NKV: model.NKV, NRYN: model.NRYN, NVIDD: model.NVIDD, P_DOX: model.P_DOX, P_NEMI: model.P_NEMI }
        }).then(function (response) {

            model.NLS_A = response.data.NLSA;
            model.SVIDD = response.data.SVIDD;
        });
    }

    var _getDealWindowParams = function (p_nOp, p_fl_END, p_nGrp, options) {
        var p_strPar02;
        if (options.ID) {
            model.dealID = options.ID;
            p_strPar02 = 'ID = ' + options.ID;
        }
            
        if (options.REF) {
            model.REF = options.REF;
            p_strPar02 = 'REF = ' + options.REF;
        }

        model.NOP = p_nOp;
        model.FL_END = p_fl_END;
        model.NGRP = p_nGrp;

        return $http({
            url: baseUrl + 'GetPrepareWndDeal',
            method: "GET",
            params: { p_nOp: p_nOp, p_fl_END: p_fl_END, p_nGrp: p_nGrp, p_strPar02: p_strPar02 }
        }).then(function (response) {

            Object.keys(response.data).forEach(function (elem) {
                model[elem] = response.data[elem];
            });

            Object.keys(model).forEach(function (elem) {
                if (typeof model[elem] == "string" && model[elem].match(/Date\((\S+)\)/)) {
                    model[elem] = new Date(parseInt(model[elem].match(/Date\((\S+)\)/)[1]));
                }
            });

            return model.WNDTITLE;
            $scope.isDisabled = false;

        })
    }

    

    var _getRR_ = function () {
        if (!model.dealID || !model.SUMBN || !model.DAT_ROZ)
            return;
        $http({
            url: baseUrl + 'GetRR_',
            method: "GET",
            params: { DAT_ROZ: model.DAT_ROZ, ID: model.dealID, SUMBN: model.SUMBN }
        }).then(function (response) {
            model.RR_ = response.data.RR_;
        });
    }

    var _checkMFOB = function (MFOB) {

        return $http({
            url: baseUrl + 'GetCheckMFOB',
            method: "GET",
            params: { MFOB: MFOB }
        }).then(function (response) {

            return response.data.isValid;
        });
    }

    var _checkNLS = function (NLS, MFO) {

        return $http({
            url: baseUrl + 'GetCheckNls',
            method: "GET",
            params: { NLS: NLS, MFO: MFO }
        }).then(function (response) {

            return response.data.isValid;
        });
    }

    var _getPartnerFieldSet = function (obj) {
        return $http({
            url: baseUrl + 'GetPartnersFields',
            method: "GET",
            params: { NBB: obj.NBB, OKPOB: obj.OKPOB, NLSB: obj.NLSB, MFOB: obj.MFOB }
        }).then(function (response) {
            return response.data;
        });
    }

    var _fSave = function () {
        return $http.post(baseUrl + 'PostFSave', JSON.stringify(model),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
            return response.data;
        });
    }

    var _setNazn = function (REF_MAIN, NAZN) {
        return $http.post(baseUrl + 'PostSetNazn', JSON.stringify({ REF_MAIN: REF_MAIN, NAZN: NAZN }),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    return response.data;
                });
    }

    var _setSpecparams = function (REF_MAIN, COD_I, COD_M, COD_F, COD_V, COD_O) {
        return $http.post(baseUrl + 'PostSetSpecparam', JSON.stringify({ REF_MAIN: REF_MAIN, COD_I: COD_I, COD_M: COD_M, COD_F: COD_F, COD_V: COD_V, COD_O: COD_O }),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    return response.data;
                });
    }

    var _getMoneyFlowParams = function (REF) {

        return $http({
            url: baseUrl + 'GetMoneyFlowParams',
            method: "GET",
            params: { REF: REF }
        }).then(function (response) {

            return response.data;
        });
    }

    var _getIrrWindowParams = function (data) {
        return $http({
            url: baseUrl + 'GetPrepareIrrWindow',
            method: "GET",
            params: data
        }).then(function (response) {
            return response.data;
        });
    }

    var _cpAmor = function (data) {
        return $http.post(baseUrl + 'PostCpAmor', JSON.stringify(data),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    return response.data;
                });
    }

    var _makeAmort = function (data) {
        return $http.post(baseUrl + 'PostMakeAmort', JSON.stringify(data),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {

                    return response.data;
                });
    }
    var _delIir = function (data) {
        return $http.post(baseUrl + 'PostDelIir', JSON.stringify(data),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {

                    return response.data;
                });
    }

    var _calcEfectBet = function () {
        return $http.post(baseUrl + 'PostEfectBet', JSON.stringify(""),
                {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function (response) {
                    return response.data;
                });
    }

    var _calcFlows = function (data) {
        return $http.post(baseUrl + 'PostCalcFlows', JSON.stringify(data),
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).then(function (response) {
                return response.data;
            });
    }

    var _getIFRS = function (vidd) {

        return $http({
            url: baseUrl + 'GetIFRS',
            method: "GET",
            params: { vidd: vidd }
        }).then(function (response) {

            return response.data.IRFS;
        });
    };

    paramsServiceFactory.calcFlows = _calcFlows;
    paramsServiceFactory.calcEfectBet = _calcEfectBet;
    paramsServiceFactory.delIir = _delIir;
    paramsServiceFactory.getIrrWindowParams = _getIrrWindowParams;
    paramsServiceFactory.makeAmort = _makeAmort;
    paramsServiceFactory.cpAmor = _cpAmor;
    paramsServiceFactory.getMoneyFlowParams = _getMoneyFlowParams;
    paramsServiceFactory.setSpecparams = _setSpecparams;
    paramsServiceFactory.setNazn = _setNazn;
    paramsServiceFactory.fSave = _fSave;
    paramsServiceFactory.checkNLS = _checkNLS;
    paramsServiceFactory.getPartnerFieldSet = _getPartnerFieldSet;
    paramsServiceFactory.checkMFOB = _checkMFOB;
    paramsServiceFactory.getRR_ = _getRR_;
    paramsServiceFactory.getDealWindowParams = _getDealWindowParams;
    paramsServiceFactory.model = model;
    paramsServiceFactory.get_NLS_A_and_SVIDD = _get_NLS_A_and_SVIDD;
    paramsServiceFactory.baseUrl = baseUrl;
    paramsServiceFactory.getDefaultParams = _getDefaultParams;
    paramsServiceFactory.resetModel = _resetModel;
    paramsServiceFactory.getIFRS = _getIFRS;

    return paramsServiceFactory;
});
