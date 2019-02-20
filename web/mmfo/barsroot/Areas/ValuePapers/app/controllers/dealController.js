app.controller("dealController", ['$scope', 'paramsService', dealController]);

function dealController($scope, paramsService) {
    
    var openRefEditWindow = function () {
        $scope.naznEditWindow.title("Бажаєте відкоректувати призначення?").open().center();
    }

    $scope.setNazn = function () {
        paramsService.setNazn($scope.contractModel.REF_MAIN, $scope.contractModel.NAZN).then(function (response) {
            response;
            $scope.naznEditWindow.close();
            $scope.$emit('updateGrid');
            if (($scope.p_nOp == 1 || $scope.p_nOp == 2) && $scope.p_fl_END == 0)
                $scope.openSpecparamsWindow();
        })
    }

    var checkVisibilityRB_AI = function () {
        
        if ($scope.contractModel.P_NCOUNTRY == 804 &&
                $scope.contractModel.RB_K_P == 0 &&
                $scope.contractModel.RB_AKT_PAS == 0 &&
                $scope.contractModel.PF != 4) {

            $scope.contractModel.RB_A_VISIBLE = true;
            $scope.contractModel.RB_I_VISIBLE = true;
        }
        else {
            $scope.contractModel.RB_A_VISIBLE = false;
            $scope.contractModel.RB_I_VISIBLE = false;
        }
        $scope.$apply();
    }

    $scope.contractModel = paramsService.model;

    $scope.getFailP = function () {
        return $scope.contractModel.P_NDCP == 1 ? 'Депозитарій (ДЦП)' : '';
    }

    $scope.$on('updateDropDown', function () {


        $scope.cmb_pf.dataSource.read();
        $scope.cmb_ryn.dataSource.data([]);
        $scope.dll_bus_mod.dataSource.read();
        $scope.dll_sppi.dataSource.read();
    });

    $scope.cmb_pf_options = {
        optionLabel: " ",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: paramsService.baseUrl + 'GetDataListFor_cbm_PF',
                    data: function () {
                        return {
                            p_DOX: $scope.contractModel.P_DOX,
                            p_nEMI: $scope.contractModel.P_NEMI
                        }
                    }
                }
            }
        },
        autoBind: false,
        dataTextField: "TEXT",
        dataValueField: "VAL",
        dataBound: function () {
            this.select(0);
            checkVisibilityRB_AI();
            //if (this.dataSource.data()[this.select()])
            //    $scope.contractModel.PF = this.dataSource.data()[this.select()].PF;
        },
        change: function () {
            if (this.select() === 0) {
                $scope.cmb_ryn.dataSource.data([]);
                $scope.contractModel.PF = "";
                $scope.contractModel.NLS_A = "";
                $scope.contractModel.SVIDD = "";
                return;
            }

            $scope.cmb_ryn.dataSource.read();
            $scope.contractModel.PF = this.dataSource.data()[this.select()-1].PF;
            checkVisibilityRB_AI();
            $scope.SetIFRS(this.value());
        }
    }

    $scope.cmb_ryn_options = {
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: paramsService.baseUrl + 'GetDataListFor_cbm_RYN',
                    data: function () {
                        return {
                            p_Vidd: $scope.contractModel.NVIDD || 0,
                            p_Kv: $scope.contractModel.P_KV,
                            p_Tipd: $scope.contractModel.P_TIPD
                        }
                    }
                }
            }
        },
        dataBound: function () {
            if (this.value())
                paramsService.get_NLS_A_and_SVIDD()
            else
                $scope.contractModel.NLS_A = "";
        },
        change: function () {
            paramsService.get_NLS_A_and_SVIDD()
        },
        autoBind: false,
        dataTextField: "TEXT",
        dataValueField: "VAL",
    }

    $scope.bus_mod_options = {
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: paramsService.baseUrl + 'GetDataListForBusMod'
                }
            }
        },
        autoBind: false,
        dataTextField: "TEXT",
        dataValueField: "VAL",
        dataBound: function () {
            this.select(0);
            $scope.contractModel.BUS_MOD = this.value();
        }
    };


    $scope.sppi_options = {
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: paramsService.baseUrl + 'GetDataListForSppi'
                }
            }
        },
        autoBind: false,
        dataTextField: "TEXT",
        dataValueField: "VAL",
        dataBound: function () {
            this.select(0);
            $scope.contractModel.SPPI = this.value();

        }
    };


    $scope.calcSUMBN = function () {
        $scope.contractModel.SUMBN = +$scope.contractModel.KOL * +$scope.contractModel.P_CENA;
    }

    $scope.calcKOL = function () {

        if (+$scope.contractModel.SUMBN % +$scope.contractModel.P_CENA == 0) {
            $scope.contractModel.KOL = +$scope.contractModel.SUMBN / +$scope.contractModel.P_CENA;
            $scope.getRR_();
        }            
        else {
            bars.ui.error({ text: "Сума номіналу має бути кратною до ціни однієї бумаги (" + $scope.contractModel.P_CENA + ")" });
            $scope.calcSUMBN();
        }
    }

    $scope.getRR_ = function () {
        paramsService.getRR_();
    }

    $scope.searchPartner = function () {
        bars.ui.getMetaDataNdiTable("V_CP_ALIENS", function (response) {
            $scope.contractModel.NBB = response.NBB;
            $scope.contractModel.MFOB = response.MFOB;
            $scope.contractModel.OKPOB = response.OKPOB;
            $scope.contractModel.NLSB = response.NLSB;
            $scope.$apply();

        }, { hasCallbackFunction: true });
    }

    $scope.searchPartner_ = function () {
        bars.ui.getMetaDataNdiTable("V_CP_ALIENS", function (response) {
            $scope.contractModel.NBB_ = response.NBB;
            $scope.contractModel.MFOB_ = response.MFOB;
            $scope.contractModel.OKPOB_ = response.OKPOB;
            $scope.contractModel.NLSB_ = response.NLSB;
            $scope.$apply();

        }, { hasCallbackFunction: true });
    }

    $scope.createDeal = function () {        
        if (typeof $scope.contractModel.SUMB == undefined) { bars.ui.error({ text: "Не введена сума угоди!" }); return; };
        if(typeof $scope.contractModel.RR_ == undefined ){ bars.ui.error({ text: "Не введена сума НКД!" }); return; };
        if(typeof $scope.contractModel.SUMBK == undefined) {bars.ui.error({ text: "Не введена сума комісії!" }); return; };
        if (typeof $scope.contractModel.SUMBN == undefined) { bars.ui.error({ text: "Не введена сума номінала!" }); return; };
        if (typeof $scope.contractModel.NTIK == undefined) { bars.ui.error({ text: "Не введено номер тікета!" }); return; };
        if($scope.contractModel.RB_K_P == 0)
        {
            if (!$scope.contractModel.NLSB) {bars.ui.error({ text: "Не введено номер рахунка контрагенту!" }); return; };
            if(!$scope.contractModel.MFOB) {bars.ui.error({ text: "Не введено МФО контрагенту!" }); return; };
            if(!$scope.contractModel.OKPOB) {bars.ui.error({ text: "Не введено номер ЗКПО контрагенту!" }); return; };}
        
        if($scope.contractModel.RB_K_P == 0 && $scope.contractModel.nKv==980 && $scope.contractModel.SUMBK>0)
        {
            if (!$scope.contractModel.NLSB_) { bars.ui.error({ text: "Не введено номер рахунка для сплати комісії!" }); return; };
            if(!$scope.contractModel.MFOB_){bars.ui.error({ text: "Не введено МФО для сплати комісії!" }); return; };
            if (!$scope.contractModel.OKPOB_) { bars.ui.error({ text: "Не введено номер ЗПКО для сплати комісії!" }); return; };
        }            

        var modelNames = Object.keys($scope.contractModel);
        for (var i = 0; i < modelNames.length; i++) {
            if (modelNames[i].match(/^CB_/g) != null)
                $scope.contractModel[modelNames[i]] = $scope.contractModel[modelNames[i]] || 0;
        }
        $scope.contractModel.P_REPO = $scope.contractModel.REF;
        paramsService.fSave().then(function (response) {
            if (response.Error)
                bars.ui.error({ text: response.Message });
            else {
                $scope.successMessage = response.Message;
                $scope.contractModel.NAZN = response.NAZN;                
                $scope.contractModel.REF_MAIN = response.REF_MAIN;                
                openRefEditWindow();
                $scope.contractModel.isDisabled = true;
             //   bars.ui.success({ text: response.Message });
            }           
        });
    }

    $scope.checkMFOB = function (fieldName) {
        if ($scope.contractModel[fieldName]) {
            paramsService.checkMFOB($scope.contractModel[fieldName]).then(function (isValid) {
                if (!isValid) {
                    $scope.contractModel[fieldName] = "";
                    bars.ui.error({ text: "Введено МФОБ неіснуючого банку!" });
                    return;
                }
            })
        }          
    }

    $scope.checkOKPO = function (fieldName) {

        if ($scope.contractModel[fieldName]) {

            if (!bars.utils.checkEdrpouCtrlDigit($scope.contractModel[fieldName])) {
                $scope.contractModel[fieldName] = "";
                bars.ui.error({ text: "Введено некоректне ОКПО!" });  
            }
        }            
    }

    $scope.checkNLSB = function () {
        if ($scope.contractModel.NLSB) {
            paramsService.checkNLS($scope.contractModel.NLSB, $scope.contractModel.MFOB).then(function (isValid) {
                if (!isValid) {
                    $scope.contractModel.NLSB = "";
                    bars.ui.error({ text: "Введено не коректні дані!" });
                    return;
                }
            })
        }
    }

    $scope.checkNLSB_ = function () {
        if ($scope.contractModel.NLSB_) {
            paramsService.checkNLS($scope.contractModel.NLSB_, $scope.contractModel.MFOB_).then(function (isValid) {
                if (!isValid) {
                    $scope.contractModel.NLSB_ = "";
                    bars.ui.error({ text: "Введено не коректні дані!" });
                    return;
                }
            })
        }
    }

    $('#dealform').on('keyup keypress', function (e) {
        var keyCode = e.keyCode || e.which;
        if (keyCode === 13) {
            e.preventDefault();
            return false;
        }
    });

    $scope.getPartnFieldSet = function (fieldName) {

        if (!$scope.contractModel[fieldName])
            return;
        var obj = {
            NBB: "",
            MFOB: "",
            OKPOB: "",
            NLSB: ""
        }
        obj[fieldName] = $scope.contractModel[fieldName];

        paramsService.getPartnerFieldSet(obj).then(function (response) {
            $scope.contractModel.NBB = response.NBB || $scope.contractModel.NBB;
            $scope.contractModel.MFOB = response.MFOB || $scope.contractModel.MFOB;
            $scope.contractModel.OKPOB = response.OKPOB || $scope.contractModel.OKPOB;
            $scope.contractModel.NLSB = response.NLSB || $scope.contractModel.NLSB;
      //      $scope.$apply();
        });
    }

    $scope.getPartnFieldSet_ = function (fieldName) {

        if (!$scope.contractModel[fieldName]) return;

        var obj = {
            NBB: "",
            MFOB: "",
            OKPOB: "",
            NLSB: ""
        }
        obj[fieldName.replace('_','')] = $scope.contractModel[fieldName];

        paramsService.getPartnerFieldSet(obj).then(function (response) {
            $scope.contractModel.NBB_ = response.NBB || $scope.contractModel.NBB_;
            $scope.contractModel.MFOB_ = response.MFOB || $scope.contractModel.MFOB_;
            $scope.contractModel.OKPOB_ = response.OKPOB || $scope.contractModel.OKPOB_;
            $scope.contractModel.NLSB_ = response.NLSB || $scope.contractModel.NLSB_;
            //      $scope.$apply();
        });
    }

    $scope.SetIFRS = function (vidd) {
        paramsService.getIFRS(vidd).then(function (ifrs) {
            $scope.contractModel.IFRS = ifrs;
        });
    };
 }