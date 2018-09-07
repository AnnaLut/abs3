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
            $('body').on('keydown', handleBodyKeyDown);
            function handleBodyKeyDown(event) {
                var e = event || window.event,
                    target = e.target || e.srcElement;

                if (e.keyCode != 8 || target.tagName.toUpperCase() == 'INPUT' || target.tagName.toUpperCase() == 'TEXTAREA') return true;

                e.preventDefault();
                return false;
            }

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
            //var tabStrip = $("#myTabStrip").kendoTabStrip().data("kendoTabStrip");
            var custId = bars.ext.getParamFromUrl('custId');
            var clmode = bars.ext.getParamFromUrl('clmode');
            var addCorp2Tube = bars.ext.getParamFromUrl('addCorp2Tube');
            if (clmode == 'base') {
                customersService.getTypeOfCustomer(custId).then(
                    function (response) {
                        response = JSON.parse(response);
                        if (response && response != 'person') {
                            $('#li_corp2').show();
                            if (addCorp2Tube && addCorp2Tube.toUpperCase() == 'TRUE')
                            $('#div_corp2').show();
                            //$(tabStrip.items()[1]).hide();
                            //tabStrip.remove("li:last");
                        }
                    },
                    function () { }
                );
            }
            //#endregion
        }
    ]);