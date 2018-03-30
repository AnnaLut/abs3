angular.module('BarsWeb.Controllers')
    .controller('ChangeParamFXSDealCtrl', ['$scope', '$http', 'RegularDealService',
        function ($scope, $http, RegularDealService) {
            //---
            var vm = this;
            vm.isSaved = false;

            vm.FXSDeal = eval("(" + angular.element('#dealFXS').val() + ")");

            Object.withUpperCaseKeys = function upperCaseKeys(o) {
                // this solution ignores inherited properties
                var r = {};
                for (var p in o)
                    r[p.toUpperCase()] = o[p];
                return r;
            };

            vm.FXSDeal = Object.withUpperCaseKeys(vm.FXSDeal);

            console.log(vm.FXSDeal);
            //-----
            vm.DAT = kendo.toString(kendo.parseDate(vm.FXSDeal.DAT, "yyyy-MM-dd"), "dd/MM/yyyy");
            vm.DATA = kendo.toString(kendo.parseDate(vm.FXSDeal.DAT_A, "yyyy-MM-dd"), "dd/MM/yyyy");
            vm.DATB = kendo.toString(kendo.parseDate(vm.FXSDeal.DAT_B, "yyyy-MM-dd"), "dd/MM/yyyy");

            //-----

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
            };


            //-----
            vm.SUMA = vm.FXSDeal.SUMA / 100;
            vm.SUMA = vm.number_format(vm.SUMA.toString(), 2, '.', ' ');
            
            vm.SUMB = vm.FXSDeal.SUMB / 100;
            vm.SUMB = vm.number_format(vm.SUMB.toString(), 2, '.', ' ');

            vm.BICKB = vm.FXSDeal.SWO_BIC;
            vm.SSB = vm.FXSDeal.SWO_ACC;
            vm.NBKB = vm.FXSDeal.NBKB;
            vm.dfB56A = vm.FXSDeal.INTERM_B != null ? vm.FXSDeal.INTERM_B + '\n' : vm.FXSDeal.INTERM_B;
            vm.dfB57A = vm.FXSDeal.ALT_PARTYB != null ? vm.FXSDeal.ALT_PARTYB + '\n' : vm.FXSDeal.ALT_PARTYB;



            //-----
            var indexOFRevenueList = 0;

            vm.revenueDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Forex/ChangeParamFXSDeal/GetRevenueDropDown"),
                        data: function () {
                            let _kv = vm.FXSDeal.KVA;
                            if (_kv != 980) {
                                return { kv: _kv }
                            } else {                               
                                vm.BICKA = vm.FXSDeal.SWI_BIC;
                                vm.SSLA = vm.FXSDeal.SWI_ACC;
                                return { kv: 0 }
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                change: function (data) {
                    let _dataitems = data.items;

                    if (_dataitems.length !== 0) {
                        vm.RevenueData = _dataitems;
                        vm.getOurTrassa('BICKA', vm.FXSDeal.SWI_BIC);
                    }
                    //else {
                    //    bars.ui.error({ text: "Помилка с трасою по надходженню" });
                    //}
                }
            };

            vm.revenueDropDownOptions = {
                dataSource: vm.revenueDropDownDataSource,
                select: function (e) {
                    let _dataItem = this.dataItem(e.item.index());
                    vm.SSA = parseInt(_dataItem.NLS);
                    vm.BICKA = _dataItem.BICKA;
                    vm.SSLA = _dataItem.SSLA;
                    $scope.$apply();
                },
                dataBound: function () {
                    this.select(indexOFRevenueList);
                }
            };

            vm.getOurTrassa = function (key, value) {
                if (value != null && value != undefined && value != '') {
                    let _arrayOfElem = vm.RevenueData;
                    let _elem;
                    for (var i = 0; i < _arrayOfElem.length; i++) {
                        _elem = _arrayOfElem[i];
                        if (_elem[key] == value) {
                            vm.BICKA = _arrayOfElem[i].BICKA;
                            vm.SSLA = _arrayOfElem[i].SSLA;
                            vm.SSA = _arrayOfElem[i].NLS;
                            indexOFRevenueList = i;                            
                            return;
                        }
                    }
                    bars.ui.error({ text: "Трасу по надходженню не знайдено!" });
                    vm.emptyFields('clearLeftTrassa');
                }
            };
            //-----
            vm.SaveGhanges = function () {
            
                var interm_b = vm.dfB56A;
                if (vm.dfB56A != '' && vm.dfB56A != null && vm.dfB56A != undefined) {
                    interm_b = vm.dfB56A.replace(/[\r\n]/g, " ");
                };
                var alt_partyb = vm.dfB57A;
                if (vm.dfB57A != '' && vm.dfB57A != null && vm.dfB57A != undefined) {
                    alt_partyb = vm.dfB57A.replace(/[\r\n]/g, " ");
                };

                var fxupd = {
                    DEAL_TAG: vm.FXSDeal.DEAL_TAG,
                    SWI_BIC: vm.BICKA,
                    SWI_ACC: vm.SSLA,
                    SWO_BIC: vm.BICKB,
                    SWO_ACC: vm.SSB,
                    INTERM_B: interm_b,
                    ALT_PARTYB: alt_partyb
                };

                vm.loading = true;
                RegularDealService.UpdateChanges(fxupd).then(
                        function (response) {
                            vm.loading = false;
                            vm.isSaved = true;
                            bars.ui.alert({ text: "Зміна параметрів угоди виконалась успішно!" });
                        },
                        function (response) {
                            vm.loading = false;
                        });
            }
            //-----
            vm.getDefSwiftPartners = function (bick) {
                if (bick != '' && bick != undefined && bick != null) {
                    RegularDealService.GetSwiftParti(bick).then(
                       function (response) {
                           if (response[0] !== undefined) {
                               vm.NBKB = response[0].NAME;
                               vm.BICKB = response[0].BIC;
                           } else {
                               bars.ui.error({ text: "Трасу платежу не знайдено!" });
                           }
                       },
                       function (response) {

                       });
                }
            };
                        
            vm.getBankSwiftParts = function (mode) {
                let options = {
                    tableName: "SW_BANKS",
                    jsonSqlParams: "",
                    filterCode: "",
                    hasCallbackFunction: true
                };
                if (mode == 'way') {
                    bars.ui.getMetaDataNdiTable("SW_BANKS", function (selectedItem) {
                        vm.NBKB = selectedItem.NAME;
                        vm.BICKB = selectedItem.BIC;
                        $scope.$apply();
                    }, options);
                } else if (mode == 'dealer') {
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

            //-----
            vm.checkKey = function (event, str) {
                if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9
                                   || event.keyCode == 27 || event.keyCode == 13
                                   || (event.keyCode == 65 && event.ctrlKey === true)
                                   || (event.keyCode >= 35 && event.keyCode <= 39) ) {
                    return;
                } else {
                    if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                        event.preventDefault ? event.preventDefault() : (event.returnValue = false);
                    };
                };
            };
                        
            vm.backSpaceEvent = function (event) {
                event.preventDefault ? event.preventDefault() : (event.returnValue = false);
            };
                       
            vm.emptyFields = function (mode) {
                if (mode == 'clearLeftTrassa') {
                    vm.BICKA = null;
                    vm.SSLA = null;
                    vm.NLS = null;
                    vm.SSA = null;
                }
            };

           

        }]);