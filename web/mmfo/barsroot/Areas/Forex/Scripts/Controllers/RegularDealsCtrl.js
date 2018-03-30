angular.module('BarsWeb.Controllers')
    .controller('RegularDealsCtrl', ['$scope', '$http', 'RegularDealService',
        function ($scope, $http, RegularDealService) {
            var sB57ADef;
            var vm = this;

            var counterForVal = 0,
            tempNazn = 'Продаж вал ';
            vm.model = {};
            vm.addPorp = {};
            vm.DisabledVars = {
                SWAP: false,
                VAL: false,
                DEPO: false,
                CreateSWT: true,
                ViewSWT: true,
                OK: false,
                ClearAll: false,
                SavePartner: true,
                Print: true,
                AccMod: true,
                INIC: false,
                PartGrid: false
            };
            vm.addParams = {};

            vm.Initialization = function (EnterDealTag) {                
                vm.EnterDealTag = EnterDealTag;                
            };

            vm.CheckEnterDealTag = function () {                
                if (vm.EnterDealTag != null || vm.EnterDealTag != undefined) {                    
                    vm.DealTag = vm.EnterDealTag;
                    vm.DisabledVars.SWAP = true;
                    vm.DisabledVars.PartGrid = true;
                    vm.DisabledVars.ClearAll = true;
                    vm.DisabledVars.CreateSWT = true;

                    
                    RegularDealService.GetFXDealByDealTag(vm.DealTag).then(
                       function (data) {                           
                           if (data.data[0] != null && data.data[0] != undefined) {
                               vm.NTIK = data.data[0].NTIK;                                                              
                               vm.TempBICKA = data.data[0].SWI_BIC;
                               vm.KVA = data.data[0].KVA;
                               vm.getCurrencyNameA(vm.KVA);
                               vm.KVB = data.data[0].KVB;
                               vm.getCurrencyNameB(vm.KVB);

                               vm.SumA = (data.data[0].SUMA / 100);
                               vm.SumB = (data.data[0].SUMB / 100);

                               if (vm.SumA != null || vm.SumB != null) {
                                   
                                   vm.SumA = vm.number_format(vm.SumA.toString(), 2, '.', ' ');
                                   vm.SumB = vm.number_format(vm.SumB.toString(), 2, '.', ' ');
                                   vm.crossSum();
                               }

                               //----                           
                               vm.SwapTag = data.data[0].SWAP_TAG;
                               vm.setPayments.A(data.data[0].KOD_NA);
                               vm.setPayments.B(data.data[0].KOD_NB);

                               RegularDealService.GetFortexPart(vm.KVB, 'rnk', data.data[0].RNK).then(
                                 function (response) {
                                     SetForexPart(response);

                                     vm.getDefSwiftPartners(data.data[0].SWO_BIC);

                                     vm.dfB56A = data.data[0].dfB56A;
                                     vm.dfB57A = data.data[0].dfB57A;
                                     vm.s58D = data.data[0].s58D;

                                     vm.dfAgrNum = data.data[0].dfAgrNum;
                                     
                                     vm.dfAgrDate = data.data[0].dfAgrDate == undefined ? '' : kendo.toString(kendo.parseDate(data.data[0].dfAgrDate, "yyyy-MM-dd"), "dd/MM/yyyy");
                                 },
                                 function (response) {

                                 });

                               
                               if (vm.DealTypeID == 2) {
                                   vm.DisabledVars.DEPO = true;                                   
                                   vm.DATA = null;
                                   vm.DATB = null;
                               } else {                                   
                                   vm.DATA = null;
                                   vm.DATB = null;                                   
                               }
                               vm.DealMode = 4;
                           }
                       },
                          function () { }
                       );

                    


                }
            };

            setDefaultProperties();

            function setDefaultProperties() {
                
                vm.DealTypeID = angular.element('#DealTypeId').val();
                vm.Base = 'A';
                vm.DAT = angular.element('#GlBankDate').val().replace(/\./g, "/");
                vm.DealMode = 0;
                vm.Mfo_300465 = '300465';
                vm.bSwap = false;
                vm.SwapTag = null;
                if (vm.DealTypeID == 1 || vm.DealTypeID == 2) {
                    vm.DealMode = 1;
                    vm.bSwap = true;
                    //vm.DisSwap = false;
                    if (vm.DealTypeID == 1) {
                        tempNazn = 'Валютний своп з ';
                    } else tempNazn = 'ДЕПО СВОП з ';
                };
                
                vm.DATA = vm.DAT;
                vm.DATB = vm.DAT;
                vm.dfAgrDate = '';

                var datepicker1 = $("#datePicker1");
                datepicker1.kendoMaskedTextBox({
                    mask: "00/00/0000"
                });
                datepicker1.removeClass("k-textbox");

                var datepicker2 = $("#datePicker2");
                datepicker2.kendoMaskedTextBox({
                    mask: "00/00/0000"
                });
                datepicker2.removeClass("k-textbox");

                var datepicker3 = $("#datePicker3");
                datepicker3.kendoMaskedTextBox({
                    mask: "00/00/0000"
                });
                datepicker3.removeClass("k-textbox");

                RegularDealService.GetDefSettings().then(
                   function (data) {
                       vm.BiCA = data.data[0].BiCA;
                       vm.MFOA = data.data[0].MFOA;
                       vm.KOD_BA = data.data[0].KOD_BA;
                       vm.NBA = data.data[0].NBA;
                       vm.OKPOA = data.data[0].OKPOA;
                       vm.KOD_GA = data.data[0].KOD_GA;
                       vm.NGA = data.data[0].NGA;
                       vm.SWIFT = data.data[0].SWIFT;
                       vm.T_1819 = data.data[0].T_1819;
                       vm.T_1819S = data.data[0].T_1819S;
                       vm.B_1819 = data.data[0].B_1819;
                       vm.B_1819N = data.data[0].B_1819N;
                       vm.B_1919 = data.data[0].B_1919;
                       vm.B_1919N = data.data[0].B_1919N;
                       //vm.bFxRezid = data.data[0].FxRezid == 1;
                       vm.FX_1PBA_R = data.data[0].FX_1PBA_R;
                       vm.FX_1PBB_R = data.data[0].FX_1PBB_R;
                       vm.FX_1PBA_NR = data.data[0].FX_1PBA_NR;

                       vm.strUseSwift = data.data[0].strUseSwift;
                       vm.strUseTelex = data.data[0].strUseTelex;
                       vm.FL_SWIFT = data.data[0].FL_SWIFT == 1;
                       //vm.nParamNoPrintMO = data.data[0].nParamNoPrintMO;
                       vm.KOD_GA = data.data[0].KOD_GA;
                       vm.NGA = data.data[0].NGA;

                       if (vm.strUseSwift != '1') {
                           vm.DisabledVars.CreateSWT = false;
                           vm.DisabledVars.ViewSWT = false;
                       };
                       vm.CheckEnterDealTag();                      
                       
                   },
                   function (data) {

                   }
              );
                setDefNLSA();
               
            };           

            function setDefNLSA() {
                RegularDealService.GetNLSA(1).then(
                function (NLSA) {
                    var nlsa = NLSA.split('"').join('');
                    vm.NLSA = nlsa;
                },
                   function () { }
                );
            };

            vm.SavePartners = function () {
                
                var alt_partyb = vm.dfB57A;
                if (vm.dfB57A !== '' && vm.dfB57A !== null && vm.dfB57A !== undefined) {
                    alt_partyb = vm.dfB57A.replace(/[\r\n]/g, " ");
                };
                if (vm.requiredFieldsPart() == true) {
                    var partner = {
                        MFO: vm.MFOB,
                        BIC: vm.BicB,
                        NAME: vm.NBB,
                        NLS: vm.NLSB,
                        KOD_G: vm.KOD_GB,
                        KOD_B: vm.KOD_B,
                        OKPO: vm.OKPOB,
                        KV: vm.KVB,
                        BICK: vm.BicKB,
                        NLSK: vm.SSB,
                        AGRMNT_NUM: vm.dfAgrNum,
                        AGRMNT_DATE: vm.dfAgrDate == '' ? null : vm.dfAgrDate,
                        INTERM_B: vm.dfB56A,
                        ALT_PARTYB: alt_partyb,
                        FIELD_58D: vm.s58D
                    }

                    vm.loading = true;

                    RegularDealService.SaveGhangesPartners(partner).then(
                               function (data) {
                                   if (data[0] == "200") {
                                       vm.loading = false;
                                       bars.ui.alert({ text: "Партнера збережено" });
                                   }
                                   else {
                                       var message = "Партнера не збережено" + data[0];
                                       vm.loading = false;
                                       bars.ui.alert({ text: message });
                                   }
                               },
                               function (data) {
                                   vm.loading = false;
                                   bars.ui.alert({ text: "Партнера не збережено" });
                               });
                }
            }

            vm.SaveGhanges = function (e) {
                
                var keyCode = e.keyCode || e.which;
                if (keyCode === 13) {
                    e.preventDefault();
                } else
                    if (vm.requiredFields() == true) {

                        if (vm.KVA == vm.KVB) {
                            bars.ui.error({ text: "Код валюти повинен бути різним" });
                        }
                        else {
                                                       
                            
                            if (vm.strUseSwift == '1' && (vm.dfB57A == '' || vm.dfB57A == null || vm.dfB57A == undefined)
                                && ((vm.BicKB == '' || vm.BicKB == null || vm.BicKB == undefined) || (vm.SSB == '' || vm.SSB == null || vm.SSB == undefined))) {
                                var text = "Не завповнений реквізит 'Опція D'! \n Зберегти угоду?";
                                bars.ui.confirm({
                                    title: 'У В А Г А!',
                                    text: text
                                }, function () {
                                    
                                    if (vm.DealTypeID == 0) {

                                        if (vm.KVA == 980) {
                                            tempNazn = 'Продаж вал'
                                        } else if (vm.KVB == 980) {
                                            tempNazn = 'Купівля вал'
                                        } else {
                                            tempNazn = 'Конверсія валюти'
                                        }
                                    }

                                    vm.sNazn = tempNazn + ' ' + vm.NBB + ' ' + vm.KVA + '/' + vm.KVB + ' Тікет ' + vm.NTIK + ' FOREX угода від ' + vm.DAT;
                                    bars.ui.confirm({
                                        title: 'Зберегти угоду з призначенням',
                                        text: '<textarea id="namzn" style="width: 340px; height: 100px;">' + vm.sNazn + '</textarea>'
                                    }, function () {
                                        vm.sNazn = angular.element('#namzn').val();
                                        vm.SaveForexDeal();
                                    });
                                });
                            } else {
                                
                                if (vm.b643) {
                                    bars.ui.confirm({
                                        title: 'Підтвердіть поле 58D',
                                        text: '<textarea id="s58D" style="width: 340px; height: 100px;">' + vm.s58D + '</textarea>'
                                    }, function () {
                                        vm.s58D = angular.element('#s58D').val();
                                    });
                                }
                                
                                if (vm.DealTypeID == 0) {
                                    
                                    if(vm.KVA == 980 ){
                                        tempNazn = 'Продаж вал'
                                    }else if (vm.KVB == 980) {
                                        tempNazn = 'Купівля вал'
                                    }else {
                                        tempNazn = 'Конверсія валюти'
                                    }
                                }

                                vm.sNazn = tempNazn + ' ' + vm.NBB + ' ' + vm.KVA + '/' + vm.KVB + ' Тікет ' + vm.NTIK + ' FOREX угода від ' + vm.DAT;

                                //if (vm.DealMode == 2) {
                                //    vm.sNazn = 'СПОТ ' + vm.sNazn;
                                //}

                                bars.ui.confirm({
                                    title: 'Зберегти угоду з призначенням',
                                    text: '<textarea id="namzn1" style="width: 340px; height: 100px;">' + vm.sNazn + '</textarea>'
                                }, function () {
                                    vm.sNazn = angular.element('#namzn1').val();
                                    vm.SaveForexDeal();
                                });
                            }


                        }
                    }
            };

            vm.checkboxModel = {
                cb_KS: false
            };

            vm.SaveForexDeal = function () {
               
                var payFlag = 0;
                var nSa = vm.SumA.replace(/\s/g, "") * Math.pow(10, vm.nDigA);
                var nSb = vm.SumB.replace(/\s/g, "") * Math.pow(10, vm.nDigB);
                var sNlsa = null;
                var interm_b = vm.dfB56A;
                if (vm.dfB56A != '' && vm.dfB56A != null && vm.dfB56A != undefined) {
                    interm_b = vm.dfB56A.replace(/[\r\n]/g, " ");
                };
                var alt_partyb = vm.dfB57A;
                if (vm.dfB57A != '' && vm.dfB57A != null && vm.dfB57A != undefined) {
                    alt_partyb = vm.dfB57A.replace(/[\r\n]/g, " ");
                };
                if ((vm.SSA != null && vm.SSA != undefined) || vm.checkboxModel.cb_KS && vm.KVA == 980 && (vm.SSA.substring(0, 1) == '29')) {
                    sNlsa = vm.SSA;
                };

                if (parseInt(vm.KVB) === 980 && vm.VPSB && !vm.checkboxModel.cb_KS) {
                    payFlag = 1;
                } else if ((parseInt(vm.KVB) === 980 && vm.checkboxModel.bvPSB && vm.checkboxModel.cb_KS)) {
                    if (vm.BiCA != null && vm.BiCA !== undefined && vm.BicKB != null && vm.BicKB !== undefined) {
                     if(vm.BiCA.replace(/^\s+|\s+$/g, '') === vm.BicKB.replace(/^\s+|\s+$/g, '')){
                         payFlag = 3;
                     }
                 }
                } else {
                    payFlag = 2;
                }

                vm.sKb = vm.KVB == 980 ? vm.MFOB : vm.BicB;
                var dealMode = vm.DealMode;
              
                var agreement = {
                    DealType: vm.DealTypeID,
                    Mode: vm.DealMode,
                    SwapTag: vm.SwapTag,
                    NTIK: vm.NTIK,
                    DAT: vm.DAT,
                    KVA: vm.KVA,
                    DAT_A: vm.DATA,
                    SUMA: nSa,
                    KVB: vm.KVB,
                    DAT_B: vm.DATB,
                    SUMB: nSb,
                    SUMB1: null,
                    SUMB2: null,
                    RNK: parseInt(vm.RNKB),
                    NB: vm.NBB,
                    SKB: vm.sKb,
                    SWI_REF: vm.nSwRef,
                    SWI_BIC: vm.BICKA,
                    SWI_ACC: vm.SSLA,
                    NLSA: sNlsa,
                    SWO_BIC: vm.BicKB,
                    SWO_ACC: vm.SSB,
                    NLSB: vm.NLSB,
                    B_PAYFLAG: payFlag,
                    ACRMNT_NUM: vm.dfAgrNum,
                    ACRMNT_DATE: vm.dfAgrDate == '' ? null : vm.dfAgrDate,
                    INTERM_B: interm_b,
                    ALT_PARTYB: alt_partyb,
                    BICB: vm.BicB,
                    CURR_BASE: vm.Base,
                    TELEXNUM: vm.sTlxNum,
                    KOD_NA: vm.Kod_NA,
                    KOD_NB: vm.Kod_NB,
                    FIELD_58D: vm.s58D,
                    VN_FLAG: null,
                    NAZN: vm.sNazn,
                    F092_CODE: vm.F092_CODE,
                    FOREX: vm.ForexDateType._old || vm.ForexDateType,
                    CB_NoKsB: null
                }
                
                vm.loading = true;

                RegularDealService.SaveGhanges(agreement).then(
                   function (data) {                      
                        
                       if (data[0].ErrorMessaage == null || data[0].ErrorMessaage == undefined) {
                           vm.DealTag = data[0].Out_Deal_Tag;

                           var cmb_INIC = vm.INIC,
                            nND = parseInt(vm.DealTag);

                           vm.DealMode = dealMode;

                           if (vm.DealMode != 4) {
                               RegularDealService.InsertOperw(cmb_INIC, nND).then(
                             function (data) {
                                 if (data == null) {

                                 } else {
                                     bars.ui.alert({ text: "Ініціатора не збережено" });
                                 };
                             });
                           };
                           

                           if (vm.strUseSwift == '1') {
                               vm.DisabledVars.CreateSWT = false;
                           }
                           
                          
                           if (vm.DealMode == 0) {                              
                               vm.DisabledVars.SavePartner = false;
                               vm.DisabledVars.AccMod = false;
                               vm.DisabledVars.OK = true;
                               vm.DisabledVars.Print = false;                               
                               setSwapTag(vm.DealTag);
                               bars.ui.alert({ text: "Угоду збережено!" });                                                             
                           } else if (vm.DealMode == 1) {

                               bars.ui.confirm({
                                   text: "Угоду збережено!",
                                   buttons: [                                    
                                    {
                                        text: '<span class="k-icon k-i-tick"></span> Ok',
                                        click: function () {                                           
                                                bars.ui.alert({ text: "Введіть другу угоду СВОП!" });
                                                this.close();
                                            },
                                        cssClass: 'k-primary'
                                    }]
                               });
                               vm.DisabledVars.SWAP = true;
                               vm.DisabledVars.ClearAll = true;
                               vm.DisabledVars.CreateSWT = true;
                               vm.DisabledVars.PartGrid = true;
                               setSwapTag(vm.DealTag);                               
                           } else {
                               if (vm.DealTypeID == 1) {
                                   bars.ui.alert({ text: "Угоду збережено!" });
                                   vm.DealMode++;
                                   setSwapTag(vm.DealTag);
                                   vm.DisabledVars.ClearAll = false;
                                   vm.DisabledVars.SavePartner = false;
                                   vm.DisabledVars.AccMod = false;
                                   vm.DisabledVars.OK = true;
                                   vm.DisabledVars.Print = false;
                               } else {
                            var options = {
                                       jsonSqlParams: "[{\"Name\":\"nDealTag\",\"Type\":\"N\",\"Value\":" + vm.DealTag + "}]",
                                       code: "CALL_FOREX",
                                        hasCallbackFunction: false//,
                                      // externelFuncOnly: true,
                                   };
                                   
                                   bars.ui.alert({ text: "Угоду збережено!" },bars.ui.getMetaDataNdiTable("",function (success) {

                                       },options));
                                   vm.DealMode++;
                                   setSwapTag(vm.DealTag);
                                   vm.DisabledVars.ClearAll = false;
                                   vm.DisabledVars.SavePartner = false;
                                   vm.DisabledVars.AccMod = false;
                                   vm.DisabledVars.OK = true;
                                   vm.DisabledVars.Print = false;                                  
                                      
                                   RegularDealService.PutDepo(vm.DealTag).then(
                                      function (data) {

                                          //if (data === null || data === undefined || data === '' ) {

                                          //    var url = "/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_FX_SWAP0&nsiFuncId=182";
                                          //    window.open(url, '_blank');
                                          //} else {
                                          //    bars.ui.alert({ text: "Помилка з платіжним календарем по ДЕПО-СВОП" });
                                          //};
                                      });
                                   
                               };
                               if (vm.DealMode > 2 && vm.DealMode != 4) {
                                   clearSwap();
                               };

                           };
                           
                       }
                       else {
                           var message = "Угоду не збережено \n" + data[0].ErrorMessaage;                          
                           bars.ui.error({ text: message });
                       };
                       vm.loading = false;
                   },
                   function (data) {
                    
                   }                   
                );

                
            };

            vm.getCodePurposeOfPayment = function (mode) {
       
                var options = {
                    tableName: "BOPCODE",
                    jsonSqlParams: "",
                    filterCode: "",
                    hasCallbackFunction: true
                };
                bars.ui.getMetaDataNdiTable("BOPCODE", function (selectedItem) {
                    
                    if (mode == 'gridCodePurposeOfPaymentA') {
                        vm.Kod_NA = selectedItem.TRANSCODE;
                        vm.sKod_NA = selectedItem.TRANSDESC;
                        $scope.$apply();
                    }
                    else if (mode == 'gridCodePurposeOfPaymentB') {
                        vm.Kod_NB = selectedItem.TRANSCODE;
                        vm.sKod_NB = selectedItem.TRANSDESC;
                        $scope.$apply();
                    }
                }, options)
            };

            vm.getBankSwiftParts = function (part) {
    
                var options = {
                    tableName: "SW_BANKS",
                    jsonSqlParams: "",
                    filterCode: "",
                    hasCallbackFunction: true
                };
                if (part == 0) {
                    bars.ui.getMetaDataNdiTable("SW_BANKS", function (selectedItem) {
                        
                        vm.NBKB = selectedItem.NAME;
                        vm.BicKB = selectedItem.BIC;
                        $scope.$apply();
                    }, options);
                } else if (part == 1) {
                    bars.ui.getMetaDataNdiTable("SW_BANKS", function (selectedItem) {
                        if (vm.dfB56A == '' || vm.dfB56A == null || vm.dfB56A == undefined) {
                            vm.dfB56A = selectedItem.BIC + '\n';
                        } else {
                            vm.dfB56A = vm.dfB56A + selectedItem.BIC + '\n';
                        }
                        $scope.$apply();
                    }, options);
                }
            };

            vm.getForexTable = function () {
                var _JsonSqlParams = "", _filterCode = "";

                if (vm.DisabledVars.PartGrid) {
                    _JsonSqlParams = "[{\"Name\":\"KV\",\"Type\":\"N\",\"Value\":" + vm.KVB + "}, {\"Name\":\"RNK\",\"Type\":\"N\",\"Value\":" + vm.RNKB.toString() + "}]";
                    _filterCode = "FOREX_VAL_PART";
                } else {
                    _JsonSqlParams = "[{\"Name\":\"KV\",\"Type\":\"N\",\"Value\":" + vm.KVB + "}]";
                    _filterCode = "FOREX_VAL";
                }

                var options = {
                    tableName: "CUST_FX_AL",
                    jsonSqlParams: _JsonSqlParams,                    
                    filterCode: _filterCode,
                    hasCallbackFunction: true,
                    funcId: 180
                };

                bars.ui.getMetaDataNdiTable("CUST_FX_AL", function (selectedItem) {
                    
                    vm.model.NBB = selectedItem.NAME;
                    vm.model.BicB = selectedItem.BIC;
                    vm.model.MFOB = selectedItem.MFO;
                    vm.model.SSB = selectedItem.NLSK;
                    vm.model.OKPOB = selectedItem.OKPO;
                    vm.model.NLSB = selectedItem.NLS;
                    vm.model.KOD_B = selectedItem.KOD_B;
                    vm.model.KOD_GB = selectedItem.KOD_G;
                    vm.model.AGRMNT_NUM = selectedItem.AGRMNT_NUM;
                    vm.model.AGRMNT_DATE = selectedItem.AGRMNT_DATE;
                    vm.model.CODCAGENT = selectedItem.CODCAGENT;
                    vm.model.BICK = selectedItem.BICK;
                    vm.model.TXT = selectedItem.TXT;
                    vm.model.sTlxNum = selectedItem.TELEXNUM;
                    vm.model.sTmpB57A = selectedItem.ALT_PARTYB;
                    vm.model.dfB56A = selectedItem.INTERM_B;
                    vm.model.s58D = selectedItem.FIELD_58D;
                    vm.RNKB = selectedItem.RNK;
                    vm.saveSelectedValue('partnersForexDeals');                    
                    setTrassaCent();
                }, options);
            };

            vm.getF092Table = function () {
                
                var options = {
                    tableName: "F092",
                    hasCallbackFunction: true,
                    filterCode: ""
                };

                bars.ui.getMetaDataNdiTable("F092", function (selectedItem) {
                    if(selectedItem && selectedItem.F092 !== undefined)
                    {
                        vm.addParams.F092_TXT = selectedItem.TXT;
                        vm.addPorp.F092_CODE = selectedItem.F092;
                        vm.saveSelectedValue('RegDeal.F092')
                    }

                    
                }, options);
            };

            vm.ForexAccMode = function () {
                var options = {
                    tableName: "V_FOREX_ACCOUNT_MODEL",
                    jsonSqlParams: "[{\"Name\":\"deal_tag\",\"Type\":\"N\",\"Value\":" + vm.DealTag + "}]",
                    filterCode: "FOREX_ACC_MOD",
                    hasCallbackFunction: false,
                    funcId: 180
                };
              
                bars.ui.getMetaDataNdiTable("V_FOREX_ACCOUNT_MODEL", null, options);
            };

            vm.checkKey = function (event, str) {

                if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
                                   || event.keyCode == 27 || event.keyCode == 13
                                   || (event.keyCode == 65 && event.ctrlKey === true)
                                   || (event.keyCode >= 35 && event.keyCode <= 39) || (str == 'dot' && (event.keyCode == 110 || event.keyCode == 191))) {
                    return;
                } else {
                    if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                        event.preventDefault ? event.preventDefault() : (event.returnValue = false);
                    };
                };
            };


            vm.getCurrencyNameA = function (kv) {
                
                vm.emptyFields('clearSSA');

                if (kv != undefined && kv.toString().length === 3) {
                    kv = parseInt(kv);

                    RegularDealService.getCurrencyNameA(kv).then(
                        function (data) {

                            if (data.data[0] != undefined) {
                                var dropDownList = angular.element('#revenueDropDown').data("kendoDropDownList");

                                if (kv != 980) {
                                    var myKV = kv;
                                    dropDownList.dataSource.read({ kv: myKV });
                                    vm.cb_SWIFT = vm.FL_SWIFT;
                                } else {

                                    dropDownList.dataSource.read({ kv: 0 });
                                    vm.cb_SWIFT = true;

                                    vm.BICKA = vm.BiCA;
                                    vm.SSLA = vm.NLSA;
                                }

                                vm.ISOA = data.data[0].ISO;
                                vm.NameVA = data.data[0].NAME;
                                vm.nDigA = data.data[0].NDIG;
                                vm.VES_A = data.data[0].VES;

                                crossCourse(vm.KVA, vm.KVB);

                                

                                if (counterForVal == 0) {
                                    vm.setPayments.A(8443009);
                                    vm.setPayments.B(8443009);
                                    counterForVal++;
                                }

                                if (vm.MFOB != null && vm.KVB != null && vm.KVB !== undefined && vm.MFOB !== undefined) {
                                    vm.getCheckPS(vm.MFOB, vm.KVA, vm.KVB);
                                }
                                f_swSetDefaults();
                                
                                
                            } else {
                                bars.ui.error({ text: "Невірний код валюти А" });
                            }


                        },
                        function (data) { }
                        );
                }
            };

            vm.getTransactionLengthType = function (datCurr,datA,datB) {
                    
                if(!datCurr || !datA || !datB)
                    return;

                var da =   kendo.toString(kendo.parseDate(vm.DATA , "yyyy-MM-dd"), "dd/MM/yyyy");
                var db = kendo.toString(kendo.parseDate(vm.DATB , "yyyy-MM-dd"), "dd/MM/yyyy");
                
                if(!da || !db)
                    return;
                vm.loading = true;
                    RegularDealService.getTransactionLengthType(datCurr,da,db).then(
                        function (data) {
                            if(data)
                            {
                                
                                vm.loading = false;
                                vm.ForexDateType = data.data;
                                $scope.$apply();

                            }


                        },
                        function (data) { }
                    );

            };

            vm.getCurrencyNameB = function (kv) {
                if (kv != undefined && kv.toString().length === 3) {
                    kv = parseInt(kv);
                    RegularDealService.getCurrencyNameB(kv).then(
                       function (data) {
                           if (data.data[0] != undefined) {

                               vm.ISOB = data.data[0].ISO;
                               vm.NameVB = data.data[0].NAME;
                               vm.nDigB = data.data[0].NDIG;
                               vm.VES_B = data.data[0].VES;

                               crossCourse(vm.KVA, vm.KVB);

                               if (vm.MFOB != null && vm.KVA != null && vm.KVA !== undefined && vm.MFOB !== undefined) {
                                   vm.getCheckPS(vm.MFOB, vm.KVA, vm.KVB);
                               }
                               f_swSetDefaults();
                           } else {
                               bars.ui.error({ text: "Невірний код валюти Б" });
                           }
                       },
                       function (data) { }
                   );


                }

            };

            vm.revenueDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Forex/RegularDeals/GetRevenueDropDown"),
                        dataType: 'json',
                        cache: false
                    }
                },
                change: function (data) {
                    
                    var dataitem = data.items[0];                    
                    vm.RevenueData = data.items;
                    if (vm.TempBICKA != null && vm.TempBICKA != undefined) {
                        vm.getOurTrassa('BICKA', vm.TempBICKA);
                    } else if (dataitem !== undefined) {
                        vm.SSA = dataitem.NLS;
                        vm.BICKA = dataitem.BICKA;
                        vm.SSLA = dataitem.SSLA;
                        $scope.$apply();
                    }
                },
                requestEnd: function (data) {
                                        vm.RevenueData = data.items;
                }
            };

            
            vm.revenueDropDownOptions = {
                dataSource: vm.revenueDropDownDataSource,
                select: function (e) {
                    
                    var dataItem = this.dataItem(e.item.index());
                    vm.SSA = parseInt(dataItem.NLS);
                    vm.BICKA = dataItem.BICKA;
                    vm.SSLA = dataItem.SSLA;
                    $scope.$apply();
                },
                dataBound: function () {
                    this.select(0);
                }
            };


            vm.INICDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Forex/RegularDeals/GetINICDropDown"),
                        cache: false
                    }
                }
            };

            vm.ForexTypeDropDownOptions = {
                dataSource: vm.ForexTypeDropDownDataSource,
                select: function (e) {
                    
                    var dataItem = this.dataItem(e.item.index());
                    vm.FTYPE = dataItem.KOD;
                    $scope.$apply();
                },
                dataBound: function () {
                    this.select(0);
                }
            };
            vm.ForexTypeDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Forex/RegularDeals/GetForexType"),
                        cache: false
                    }
                }
            }

            vm.Forex_ob22DropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Forex/RegularDeals/GetINICDropDown"),
                        cache: false
                    }
                }
            };
            vm.INICDropDownOptions = {
                select: function (e) {
                    
                    var dataItem = this.dataItem(e.item.index());
                    vm.INIC = parseInt(dataItem.CODE);
                }
            };


            vm.emptyFields = function (mode) {
                if (mode == 'clearSSA') {
                    vm.SSA = null;
                }
                else if(mode == 'clearLeftTrassa'){
                    vm.BICKA = null;
                    vm.SSLA = null;
                    vm.NLS = null;
                    vm.SSA = null;
                }
                else if (mode == 'clearAll') {
                    
                    if (vm.MFOA == vm.Mfo_300465) {
                       
                        var k = angular.element('#inicDropDown').data("kendoDropDownList").dataSource.read();
                        vm.DisabledVars.INIC = false;
                            //.dataSource.read();
                        //vm.INICD.dataSource.read();
                        angular.element('#inicDropDown').data("kendoDropDownList").value("");
                    } else {
                        vm.DisabledVars.INIC = true;
                    }
                    vm.Base = 'A';
                    vm.KVA = null;
                    vm.KVB = null;
                    vm.DisabledVars.ViewSWT = true;
                    vm.DisabledVars.CreateSWT = true;
                    vm.DisabledVars.SavePartner = true;
                    vm.DisabledVars.AccMod = true;
                    vm.DisabledVars.OK = false;
                    vm.DisabledVars.Print = true;
                    vm.DisabledVars.SWAP = false;
                    vm.DisabledVars.PartGrid = false;
                    vm.BICKA = null;
                    vm.SSLA = null;
                    vm.NTIK = null;
                    vm.NameVA = null;
                    vm.DATA = vm.DAT;
                    vm.SumA = null;
                    vm.SUMOA = null;
                    vm.KURSOA = null;
                    vm.finRes = null;
                    vm.SUMOB = null;
                    vm.KURSOB = null;
                    setDefNLSA();
                    vm.Kod_NA = null;
                    vm.sKod_NA = null;
                    vm.KVB = null;
                    vm.NameVB = null;
                    vm.DATB = vm.DAT;
                    vm.SumB = null;
                    vm.BicB = null;
                    vm.MFOB = null;
                    vm.NBB = null;
                    vm.RNKB = null;
                    vm.OKPOB = null;
                    vm.NLSB = null;
                    vm.BicKB = null;
                    vm.SSB = null;
                    vm.NBKB = null;
                    vm.Kod_NB = null;
                    vm.sKod_NB = null;
                    vm.SSA = null;
                    vm.NLS = null;
                    vm.KOD_B = null;
                    vm.KOD_GB = null;
                    vm.dfAgrNum = null;
                    vm.dfAgrDate = null;
                    vm.VPSB = null;
                    vm.VPSA = null;
                    vm.checkboxModel.cb_KS = null;
                    vm.dfB56A = '';
                    vm.dfB57A = '';
                    vm.INIC = null;
                    angular.element('#revenueDropDown').data("kendoDropDownList").value("");
                    vm.DealTag = null;
                    vm.SwapTag = null;
                    vm.ISOA = null;
                    vm.ISOB = null;
                    sB57ADef = '';
                    vm.colPLBQ = null;
                    vm.colOstBQ = null;
                    vm.colLim = null;
                    vm.nSwRef = null;
                    vm.finRes = null;
                    counterForVal = 0;
                }
            };


            vm.saveSelectedValue = function (mode) {
                if (mode == 'partnersForexDeals') {
                    vm.NBB = vm.model.NBB;
                    vm.BicB = vm.model.BicB;
                    vm.MFOB = vm.model.MFOB;
                    vm.SSB = vm.model.SSB;
                    vm.OKPOB = vm.model.OKPOB;
                    vm.NLSB = vm.model.NLSB;
                    vm.KOD_B = vm.model.KOD_B;
                    vm.KOD_GB = vm.model.KOD_GB;
                    vm.dfAgrNum = vm.model.AGRMNT_NUM;
                    vm.dfAgrDate = vm.model.AGRMNT_DATE == undefined ? '' : kendo.toString(kendo.parseDate(vm.model.AGRMNT_DATE, "yyyy-MM-dd"), "dd/MM/yyyy");
                    
                    vm.CODCAGENT = vm.model.CODCAGENT;
                    vm.TXT = vm.model.TXT;
                    vm.sTlxNum = vm.model.sTlxNum;
                    vm.sTmpB57A = vm.model.sTmpB57A;
                    vm.dfB56A = vm.model.dfB56A;
                    vm.s58D = vm.model.s58D;



                    RegularDealService.GetNLSA(vm.model.CODCAGENT).then(
                       function (NLSA) {
                           var nlsa = NLSA.split('"').join('');
                           vm.NLSA = nlsa;
                       },
                       function () {
                           vm.NLSA = null;
                       }
                    );

                    if (vm.model.BICK !== "" && vm.model.BICK != null) {
                        vm.getDefSwiftPartners(vm.model.BICK);
                    } else {
                        vm.NBKB = null;
                        vm.BicKB = null;
                    }
                    vm.getCheckPS(vm.MFOB, vm.KVA, vm.KVB);
                    
                    vm.getColumsLimits(vm.OKPOB);
                }
                if(mode == 'RegDeal.F092')
                {
                    vm.F092_TXT = vm.addParams.F092_TXT;
                    vm.F092_CODE = vm.addPorp.F092_CODE;
                    $scope.$apply();
                }

            };


            vm.requiredFieldsPart = function () {
                if (vm.KVB == null || vm.KVB == '') {
                    bars.ui.error({ text: "Поле код валюти B  обов'язкові" });
                    return false;
                } else if (vm.BicB == null || vm.BicB == '') {
                    bars.ui.error({ text: "Поле BicB обов'язкові" });
                    return false;
                } else {
                    return true;
                }
            };



            vm.requiredFields = function () {
                var dat = kendo.toString(kendo.parseDate(vm.DAT, "dd/MM/yyyy"));
               
                if (vm.NTIK == null || vm.NTIK == '') {
                    bars.ui.error({ text: "Поле №Тикета обов'язкові" });
                    return false;
                } else if (vm.DATA == null || vm.DATB == null) {
                    bars.ui.error({ text: "Поля дати обов'язкові" });
                    return false;
                }
                else if (vm.KVA == null || vm.KVA == '') {
                    bars.ui.error({ text: "Поле код валюти А обов'язкові" });
                    return false;
                }
                else if (vm.KVB == null || vm.KVB == '') {
                    bars.ui.error({ text: "Поле код валюти B  обов'язкові" });
                    return false;
                } else if (vm.KVA == vm.KVB) {
                    bars.ui.error({ text: "Код валюти повинен бути різним" });
                }
                else if (vm.SumA == null || vm.SumA == '' || isNaN(vm.SumA.replace(/\s/g, ""))) {                    
                    bars.ui.error({ text: "Поле суми обов'язкові" });
                    return false;
                }
                else if (vm.SumB == null || vm.SumB == '' || isNaN(vm.SumB.replace(/\s/g, ""))) {
                    bars.ui.error({ text: "Поле суми B обов'язкові" });
                    return false;
                } if (vm.KVB == 980 && (vm.NLSB == null || vm.NLSB == '')) {
                    bars.ui.error({ text: "Не заповнене поле рахунок партнера." });
                    return false;
                } else if (vm.KVB == 980 && (vm.MFOB == null || vm.MFOB == '')) {
                    bars.ui.error({ text: "Не заповнене поле МФО партнера." });
                    return false;
                } else if (vm.KVB == 980 && (vm.KOD_GB == null || vm.KOD_GB == '')) {
                    bars.ui.error({ text: "Не заповнене поле Держава партнера." });
                    return false;
                } else if (vm.KVB == 980 && (vm.OKPOB == null || vm.OKPOB == '')) {
                    bars.ui.error({ text: "Не заповнене поле ЗКПО партнера." });
                    return false;
                //} else if (vm.CODCAGENT != 1 && vm.CODCAGENT != 2) {
                //    bars.ui.error({ text: "Невідома резидентність партнера." });
                //    return false;
                }
                else if (vm.RNKB == null || vm.RNKB == '') {
                    bars.ui.error({ text: "Поле РНК Партнера обов'язкові" });
                    return false;
                } else if ((vm.MFOA == vm.Mfo_300465) && (vm.INIC == null || vm.INIC == undefined)) {
                    bars.ui.error({ text: "Виберіть ініціатора угоди!" });
                    return false;
                }
                else if (vm.KVB == 643 && vm.KOD_GB == '643') {
                    vm.b643 = true;
                }
                else if (vm.DATA < dat || vm.DATB < dat) {
                    bars.ui.error({ text: "Дати повинні бути більші за банківську дату" });
                    return false;
                } else {
                    return true;
                }
            };

            vm.RedirectToArchive = function () {
                window.location.href = '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&tableName=V_FXS_ARCHIVE&sPar=[NSIFUNCTION]';
            };
                       

            vm.ViewSWT = function () {
                var dealTag = vm.DealTag;
                if (dealTag !== undefined && dealTag != null) {
                    RegularDealService.GetSWRef(dealTag).then(
                           function (response) {
                               if (response != null && response != undefined && response != '') {
                                   vm.nSwRef = response;
                                   var url = '/barsroot/documentview/view_swift.aspx?swref=' + vm.nSwRef;
                                   window.open(url, '_blank');
                               } else {
                                   bars.ui.error({ text: "Неможливо переглянути SWIFT повідомлення!" });
                               }
                           },
                           function (response) {

                           }
                        );
                };
            };

            vm.CreateSWT = function () {
                var dealTag = vm.DealTag;
                vm.loading = true;
                if (dealTag !== undefined && dealTag != null) {
                    if (vm.BicB != null || vm.BicB != undefined) {
                    RegularDealService.SWIFTCreateMsg(dealTag).then(
                           function (message) {
                               vm.loading = false;
                               if (message == null) {
                                   vm.DisabledVars.ViewSWT = false;
                                   vm.DisabledVars.CreateSWT = true;
                                   bars.ui.alert({ text: "SWIFT повідомлення сформовано!" });
                               } else {
                                   bars.ui.error({ text: message });
                               }

                           },
                           function (status) { }
                       );
                    }
                } else {
                    bars.ui.error({ text: "Сформувати SWIFT повідомлення невдалося!" });
                }
            }

            vm.printTicket = function () {
                
                var url = '/barsroot/tools/print_frx.aspx?frt=forex_tic&p_ref=' + vm.nRef + '&p_deal_tag=' + vm.DealTag + '&ref_b=' + vm.nRef2 + '&ref_a=' + vm.nRef1;
                window.open(url, 'popup_name', 'height=' + 800 + ',width=' + 750 + ',resizable=yes,scrollbars=yes,toolbar=yes,menubar=yes,location=yes')
            }

            vm.backSpaceEvent = function (event) {
                event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            };

            vm.enterEvent = function (e) {
                var keyCode = e.keyCode || e.which;
                if (keyCode === 13) {
                    e.preventDefault();
                }
            };

            function setSwapTag(DealTag) {
                RegularDealService.GetSwapTag(DealTag).then(
                  function (data) {                      
                      if (data[0].data != null) {
                          vm.SwapTag = data[0].data[0].nSwapTag;
                          vm.nRef = data[0].data[0].nRef;
                          vm.nRef1 = data[0].data[0].nRef1;
                          vm.nRef2 = data[0].data[0].nRef2;
                          vm.nRef22 = data[0].data[0].nRef22;
                          if (vm.DealMode == 1) {
                              if (vm.SwapTag == vm.DealTag) {
                                  Swap();
                                  vm.DealMode = 2;
                                  
                                  RegularDealService.GetFortexPart(vm.KVB, 'rnk', vm.RNKB).then(
                                      function (response) {
                                          
                                          SetForexPart(response);
                                      },
                                      function (response) {

                                      });
                              }
                          }
                      }
                  },
                   function (data) {

                   });
            };


            function Swap() {
                
                var tempSwap = {};
                vm.DisabledVars.INIC = true;

                tempSwap.KVA = vm.KVB;
                tempSwap.KVB = vm.KVA;
                tempSwap.SumA = vm.SumB;
                tempSwap.SumB = vm.SumA;

                tempSwap.Kod_NA = vm.Kod_NB;
                tempSwap.Kod_NB = vm.Kod_NA;
                tempSwap.sKod_NA = vm.sKod_NB;
                tempSwap.sKod_NB = vm.sKod_NA;
                vm.KVA = tempSwap.KVA;
                vm.KVB = tempSwap.KVB;
                vm.Kod_NB = tempSwap.Kod_NB;
                vm.Kod_NA = tempSwap.Kod_NA;
                vm.sKod_NB = tempSwap.sKod_NB;
                vm.sKod_NA = tempSwap.sKod_NA;
                

                if (vm.DealTypeID == 2) {
                    vm.DisabledVars.DEPO = true;
                    vm.SumA = tempSwap.SumA;
                    vm.SumB = tempSwap.SumB;
                    vm.DATA = null;
                    vm.DATB = null;
                    vm.ForexDateType = "";
                } else {
                    vm.ForexDateType = "";
                    vm.DATA = null;
                    vm.DATB = null;
                    vm.SumA = null;
                    vm.SumB = null;
                }
                vm.crossSum();
                vm.getCurrencyNameA(tempSwap.KVA);
                vm.getCurrencyNameB(tempSwap.KVB);

            };

            function clearSwap() {
                vm.DealMode = 1;
                vm.DisabledVars.SWAP = false;
                vm.DisabledVars.PartGrid = false;
                vm.DisabledVars.DEPO = false;
            };

            function crossCourse(KVA, KVB) {
                if (vm.KVA != null && vm.KVB != null) {
                    RegularDealService.GetCrossCourse(KVA, KVB).then(
                       function (data) {
                           if (data.status == "ok") {
                               vm.KURSOA = parseFloat(data.data).toFixed(9);
                               var num = 1 / data.data;
                               vm.KURSOB = parseFloat(num).toFixed(9);
                               if (vm.VES_A < vm.VES_B) {
                                   vm.Base = 'A';
                               } else {
                                   vm.Base = 'B';
                               }
                           }
                       },
                       function (data) { }
                   );
                }
            };

           
            vm.crossSum = function () {
                if (vm.SumA != null && vm.SumA != '' && vm.SumB != null && vm.SumB != '') {
                    var tempSumA = vm.SumA.replace(/\s/g, "");
                    var tempSumB = vm.SumB.replace(/\s/g, "");
                    var numA = tempSumA / tempSumB;
                    vm.SUMOA = parseFloat(numA).toFixed(19);
                    var num = 1.0 / vm.SUMOA;
                    vm.SUMOB = parseFloat(num).toFixed(19);
                    KVA = vm.KVA;
                    KVB = vm.KVB;
                    NSA = tempSumA * Math.pow(10, vm.nDigA);
                    NSB = tempSumB * Math.pow(10, vm.nDigB);
                    
                    RegularDealService.GetFinResult(KVA, NSA, KVB, NSB).then(
                       function (data) {
                           if (data.status == "ok") {
                               vm.finRes = vm.number_format(data.data.toString(), 2, '.', ' ');
                           }
                       },
                       function (data) { }
                   );
                } else {
                    vm.SUMOA = '';
                    vm.SUMOB = '';
                    vm.finRes = '';
                }
            };

            vm.setPayments = {
                A: function (kod) {
                    RegularDealService.GetCodePurposeOfPayment(kod).then(
                        function (response) {
                            if (response[0] !== undefined) {
                                vm.Kod_NA = response[0].TRANSCODE;
                                vm.sKod_NA = response[0].TRANSDESC;
                            } else {
                                bars.ui.error({ text: "Код призначення для PA не знайдено!" });
                            }
                        },
                        function (response) {
                        });
                },
                B: function (kod) {
                    RegularDealService.GetCodePurposeOfPayment(kod).then(
                        function (response) {
                            if (response[0] !== undefined) {
                                vm.Kod_NB = response[0].TRANSCODE;
                                vm.sKod_NB = response[0].TRANSDESC;
                            } else {
                                bars.ui.error({ text: "Код призначення для PB не знайдено!" });
                            }
                        },
                        function (response) {
                        });
                }
            };

            vm.getDefSwiftPartners = function (bick) {
                if (bick != '' && bick != undefined && bick != null) {
                    RegularDealService.GetSwiftParti(bick).then(
                       function (response) {
                           if (response[0] !== undefined) {
                               vm.NBKB = response[0].NAME;
                               vm.BicKB = response[0].BIC;
                           } else {
                               bars.ui.error({ text: "Трасу платежу не знайдено!" });
                           }
                       },
                       function (response) {

                       });
                }
            };

            vm.GetFortexPart = function (key, value) {
                if (value != "" && value != null) {
                    if (vm.DealMode < 2) {
                        var kvb = vm.KVB;
                        RegularDealService.GetFortexPart(kvb, key, value).then(
                           function (response) {
                               SetForexPart(response);
                           },
                           function (response) {

                           });
                    }
                }
            };

            function SetForexPart(response) {
                
                if (response != '') {
                    vm.model.NBB = response.NAME;
                    vm.model.BicB = response.BIC;
                    vm.model.MFOB = response.MFO;
                    vm.model.SSB = response.NLSK;
                    vm.model.OKPOB = response.OKPO;
                    vm.model.NLSB = response.NLS;
                    vm.model.KOD_B = response.KOD_B;
                    vm.model.KOD_GB = response.KOD_G;
                    vm.model.AGRMNT_NUM = response.AGRMNT_NUM;
                    
                    vm.model.AGRMNT_DATE = response.AGRMNT_DATE;
                    vm.model.CODCAGENT = response.CODCAGENT;
                    vm.model.BICK = response.BICK;
                    vm.model.TXT = response.TXT;
                    vm.model.sTlxNum = response.TELEXNUM;
                    vm.model.sTmpB57A = response.ALT_PARTYB;
                    vm.model.dfB56A = response.INTERM_B;
                    vm.model.s58D = response.FIELD_58D;
                    vm.RNKB = response.RNK;
                    vm.saveSelectedValue('partnersForexDeals');
                    setTrassaCent();
                } else {
                    var tempNBB = vm.NBB;
                    vm.BicB = null;
                    vm.MFOB = null;
                    vm.NBB = null;
                    vm.NLSB = null;
                    vm.KOD_GB = null;
                    vm.KOD_B = null;
                    vm.RNKB = null;
                    vm.OKPOB = null;
                    vm.SSB = null;
                    vm.NBKB = null;
                    vm.CODCAGENT = null;
                    vm.TXT = null;
                    vm.sTlxNum = null;
                    vm.sTmpB57A = null;
                    vm.dfB56A = null;
                    vm.s58D = null;
                    vm.BicKB = null;
                    vm.dfAgrNum = null;
                    vm.dfAgrDate = null;
                    if (vm.DealMode > 1) {
                        var text = "У партнера '" + tempNBB + "' відсутні реквізити для валюти " + vm.KVB;
                        bars.ui.error({ text: text });
                    } else {
                        bars.ui.error({ text: "Партнера не знайдено!" });
                    }
                    
                }
            };

            vm.getCheckPS = function (mfob, kva, kvb) {
                if (mfob != null && mfob !== undefined && kva != null && kva !== undefined && kvb != null && kvb !== undefined) {
                    vm.VPSA = 0;
                    vm.VPSB = 0;
                    RegularDealService.GetCheckPS(mfob, kva, kvb).then(
                           function (response) {
                               vm.VPSA = response.VPSA === 0 ? false : true;
                               vm.VPSB = response.VPSB === 0 ? false : true;
                           },
                           function (response) {

                           }
                        );
                }
            };

            vm.checkboxModel.changeStraightKS = function () {
                if (vm.checkboxModel.cb_KS) {
                    vm.BicKB = vm.BiCA;
                    vm.NBKB = vm.NBA;
                } else {
                    vm.BicKB = null;
                    vm.NBKB = null;
                }
            };

            vm.getColumsLimits = function (okpob) {
                if (okpob != null && okpob !== undefined) {
                    RegularDealService.GetCustLimits(okpob).then(
                           function (response) {
                               if (response.data != undefined) {
                                   vm.colLim = response.data.colLim;
                                   vm.colPLBQ = response.data.colOstBQ;
                                   vm.colOstPLBQ = response.data.colOstPLBQ;
                               }
                           },
                           function (response) {

                           }
                        );
                }
            };


            function setTrassaCent() {
                vm.dfB57A = vm.sTmpB57A;
                if (vm.dfB57A == null || vm.dfB57A == undefined || vm.dfB57A == '') {
                    
                    sB57ADef = vm.dfB57A;
                }
                f_swSetDefaults();
            };

            var sB5f7ADef = '';
            function f_swSetDefaults() {
                
                if (vm.KVB == 980 && (vm.BICKB == null || vm.BICKB == undefined) && (vm.dfB57A == sB57ADef || vm.dfB57A == undefined)) {
                    vm.dfB57A = '/' + (vm.NLSB == undefined ? '' : vm.NLSB) + '\n';
                    if (vm.BicB == null || vm.BicB == undefined) {
                        vm.dfB57A = vm.dfB57A + (vm.MFOB != null ? vm.MFOB : 'MFO');
                    } else {
                        vm.dfB57A = vm.dfB57A + vm.BicB;
                    }
                    sB57ADef = vm.dfB57A;
                } else {
                    
                    if (vm.dfB57A == sB57ADef || vm.dfB57A == undefined) {
                        vm.dfB57A = '';
                        sB57ADef = vm.dfB57A;
                    }
                }
            };

            vm.setDatB = function () {
                
                if (vm.DealMode >= 2) {
                    vm.DATB = vm.DATA;
                }



            };

            vm.blurDatAHandler = function () {
                vm.setDatB();
                vm.getTransactionLengthType(vm.DAT, vm.DATA, vm.DATB);
            }


            vm.blurDatBHandler = function () {
                
                vm.getTransactionLengthType(vm.DAT, vm.DATA, vm.DATB);
            }
            vm.getOurTrassa = function (key, value) {
                if (vm.KVA != 980 && value != null && value != undefined && value != '') {
                    var kvb = vm.KVB;
                    var arrayOfElem = vm.RevenueData;
                    var elem;               
                    for (var i = 0; i < arrayOfElem.length; i++) {                        
                        elem = arrayOfElem[i];
                        if (elem[key] == value) {
                            vm.BICKA = arrayOfElem[i].BICKA;
                            vm.SSLA = arrayOfElem[i].SSLA;                          
                            vm.SSA = arrayOfElem[i].NLS;
                            angular.element('#revenueDropDown').data("kendoDropDownList").select(parseInt(i));
                            return;
                        }
                    }
                    bars.ui.error({ text: "Трасу по надходженню не знайдено!" });
                    vm.emptyFields('clearLeftTrassa');
                }
            };            
               
            /***
            number - число
            decimals - количество знаков после разделителя
            dec_point - символ разделителя
            separator - разделитель тысячных
            ***/
            vm.number_format = function (number, decimals, dec_point, separator) {
                
                if (number.indexOf(',') !== -1) {
                    number = number.replace(/,/g, ".");
                }                
                number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
                var n = !isFinite(+number) ? 0 : +number,
                  prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                  sep = (typeof separator === 'undefined') ? ',' : separator,
                  dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
                  s = '',
                  toFixedFix = function (n, prec) {
                      var k = Math.pow(10, prec);
                      return '' + (Math.round(n * k) / k)
                        .toFixed(prec);
                  };
                // Фиксим баг в IE parseFloat(0.55).toFixed(0) = 0;
                s = (prec ? toFixedFix(n, prec) : '' + Math.round(n))
                  .split('.');
                if (s[0].length > 3) {
                    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
                }
                if ((s[1] || '')
                  .length < prec) {
                    s[1] = s[1] || '';
                    s[1] += new Array(prec - s[1].length + 1)
                      .join('0');
                }
                return s.join(dec);
            }

        }]);

