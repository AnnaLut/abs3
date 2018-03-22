angular.module(globalSettings.modulesAreas)
    .controller('CDO.CommonCustomers',
    [
        '$scope', 
        'CDO.commonCustomersService', 
        'CDO.CorpLight.relatedCustomersService', 
        'CDO.Corp2.relatedCustomersService',
        '$rootScope',
        function ($scope, customersService, corpLightRelCustService, corp2RelCustService, $rootScope) {
            'use strict';

            var vm = this;

            customersService.getModuleVersion().then(
                function (response) {
                    vm.moduleVersion = 'v' + response;
                },
                function () { }
            );

            //#region Tabs options
            vm.tabstripOptions = {
                activate: function (e) {
                    var tabItem = e.item.innerText.trim();
                    var evtName = '.readCustomersGrid';
                    if (tabItem === "Corplight") {
                        evtName = 'CDO.CorpLight' + evtName;
                    }
                    else {
                        evtName = 'CDO.Corp2' + evtName;
                    }
                    $rootScope.$broadcast(evtName);
                },
                show: function (e) {
                    /* vm.isCorpLight = e.item.innerText.trim() === "Corplight";
                    vm.isCorp2 = e.item.innerText.trim() === "Corp2"; */
                },
                contentLoad: function (e) {
                    /* vm.isCorpLight = e.item.innerText.trim() === "Corplight";
                    vm.isCorp2 = e.item.innerText.trim() === "Corp2"; */
                },
                error: function (e) {
                    /* vm.isCorpLight = e.item.innerText.trim() === "Corplight";
                    vm.isCorp2 = e.item.innerText.trim() === "Corp2"; */
                }
            };
            //#endregion
        }
    ]);