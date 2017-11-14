angular.module(globalSettings.modulesAreas)
    .controller('GeneralClearAddressCtrl',
        function () {

            var vm = this;
            vm.firstTimeArea = false;
            vm.firstTimeLocality = false;
            vm.firstTimeStreet = false;

            vm.regionGridDataSource = new kendo.data.DataSource({
                requestStart: function () {
                    vm.showLoaderRegion = true;
                },
                requestEnd: function () {
                    vm.showLoaderRegion = false;
                },
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/GeneralClearAddress/GetRegion"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Ncount: { type: "number" },
                            Domain: { type: "string" },
                            RegionName: { type: "string" }
                        }
                    }
                }
            });

            vm.regionGridOptions = {
                autoBind: true,
                dataSource: vm.regionGridDataSource,
                sortable: true,
                selectable: true,
                filterable: true,
                resizable: true,
                rowTemplate: '<tr ng-dblclick="GenClearAdr.selectedRegion(this)"><td>#= Ncount != null ? Ncount : "" #</td><td>#= Domain != null ?  Domain : "" #</td><td>#= RegionName != null ?  RegionName : "" #</td></tr>',
                pageable: {
                    pageSizes: [5, 10, 20, 50, 100],
                    buttonCount: 3
                },
                columns: [
                    {
                        field: "Ncount",
                        title: "Кількість подібних значень",
                        width: "20%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "Domain",
                        title: "Область (поточне значення)",
                        width: "40%"
                    },
                    {
                        field: "RegionName",
                        title: "Область (призначене значення)",
                        width: "40%"
                    }
                ]
            };


            vm.areaGridDataSource = new kendo.data.DataSource({
                requestStart: function () {
                    vm.showLoaderArea = true;
                },
                requestEnd: function () {
                    vm.showLoaderArea = false;
                },
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/GeneralClearAddress/GetArea"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Ncount: { type: "number" },
                            RegionName: { type: "string" },
                            Region: { type: "string" },
                            AreaName: { type: "string" },
                            RegionId: {type: "number"}
                        }
                    }
                }
            });

            vm.areaGridOptions = {
                autoBind: false,
                selectable: true,
                dataSource: vm.areaGridDataSource,
                rowTemplate: '<tr ng-dblclick="GenClearAdr.selectedArea(this)">' +
                                 '<td>#= Ncount != null ? Ncount : "" #</td>' +
                                 '<td>#= RegionName != null ?  RegionName : "" #</td>' +
                                 '<td>#= Region != null ?  Region : "" #</td>' +
                                 '<td>#= AreaName != null ?  AreaName : "" #</td>' +
                             '</tr>',
                sortable: true,
                filterable: true,
                resizable: true,
                pageable: {
                    pageSizes: [5, 10, 20, 50, 100],
                    buttonCount: 3
                },
                columns: [
                    {
                        field: "Ncount",
                        title: "Кількість подібних значень",
                        width: "20%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "RegionName",
                        title: "Область (поточне значення)",
                        width: "30%"
                    },
                    {
                        field: "Region",
                        title: "Район (поточне значення)",
                        width: "25%"
                    },
                    {
                        field: "AreaName",
                        title: "Район (призначене значення)",
                        width: "25%"
                    }
                ]
            };


            vm.localityGridDataSource = new kendo.data.DataSource({
                requestStart: function () {
                    vm.showLoaderLocality = true;
                },
                requestEnd: function () {
                    vm.showLoaderLocality = false;
                },
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/GeneralClearAddress/GetLocality"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Ncount: { type: "number" },
                            RegionName: { type: "string" },
                            AreaName: { type: "string" },
                            Locality: { type: "string" },
                            SettlementName: { type: "string" },
                            RegionId: { type: "number" },
                            AreaId: { type: "number" }                            
                        }
                    }
                }
            });

            vm.localityGridOptions = {
                selectable: true,
                autoBind: false,
                dataSource: vm.localityGridDataSource,
                rowTemplate: '<tr ng-dblclick="GenClearAdr.selectedLocality(this)">' +
                                 '<td>#= Ncount != null ? Ncount : "" #</td>' +
                                 '<td>#= RegionName != null ?  RegionName : "" #</td>' +
                                 '<td>#= AreaName != null ?  AreaName : "" #</td>' +
                                 '<td>#= Locality != null ?  Locality : "" #</td>' +
                                 '<td>#= SettlementName != null ?  SettlementName : "" #</td>' +
                             '</tr>',
                sortable: true,
                filterable: true,
                resizable: true,
                pageable: {
                    pageSizes: [5, 10, 20, 50, 100],
                    buttonCount: 3
                },
                columns: [
                    {
                        field: "Ncount",
                        title: "Кількість подібних значень",
                        width: "10%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "RegionName",
                        title: "Область (поточне значення)",
                        width: "25%"
                    },
                    {
                        field: "AreaName",
                        title: "Район (поточне значення)",
                        width: "25%"
                    },
                    {
                        field: "Locality",
                        title: "Населенийй пункт (поточне значення)",
                        width: "20%"
                    },
                    {
                        field: "SettlementName",
                        title: "Населенийй пункт (призначене значення)",
                        width: "20%"
                    }
                ]
            };


            vm.streetGridDataSource = new kendo.data.DataSource({
                requestStart: function () {
                    vm.showLoaderStreet = true;
                },
                requestEnd: function () {
                    vm.showLoaderStreet = false;
                },
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/GeneralClearAddress/GetStreet"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Ncount: { type: "number" },
                            RegionName: { type: "string" },
                            AreaName: { type: "string" },
                            SettlementName: { type: "string" },
                            Street: { type: "string" },
                            StreetName: { type: "string" },
                            RegionId: { type: "number" },
                            AreaId: { type: "number" },
                            SettlementId: { type: "number" }
                        }
                    }
                }
            });

            vm.streetGridOptions = {
                selectable: true,
                autoBind: false,
                dataSource: vm.streetGridDataSource,
                rowTemplate: '<tr ng-dblclick="GenClearAdr.selectedStreet(this)">' +
                                 '<td>#= Ncount != null ? Ncount : "" #</td>' +
                                 '<td>#= RegionName != null ?  RegionName : "" #</td>' +
                                 '<td>#= AreaName != null ?  AreaName : "" #</td>' +
                                 '<td>#= SettlementName != null ?  SettlementName : "" #</td>' +
                                 '<td>#= Street != null ?  Street : "" #</td>' +
                                 '<td>#= StreetName != null ?  StreetName : "" #</td>' +
                             '</tr>',
                sortable: true,
                filterable: true,
                resizable: true,
                pageable: {
                    pageSizes: [5, 10, 20, 50, 100],
                    buttonCount: 3
                },
                columns: [
                    {
                        field: "Ncount",
                        title: "Кількість подібних значень",
                        width: "10%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    {
                        field: "RegionName",
                        title: "Область (поточне значення)",
                        width: "18%"
                    },
                    {
                        field: "AreaName",
                        title: "Район (поточне значення)",
                        width: "18%"
                    },
                    {
                        field: "SettlementName",
                        title: "Населенийй пункт (поточне значення)",
                        width: "18%"
                    },
                    {
                        field: "Street",
                        title: "Вулиця (поточне значення)",
                        width: "18%"
                    },
                    {
                        field: "StreetName",
                        title: "Вулиця (призначене значення)",
                        width: "18%"
                    }
                ]
            };

            vm.selectTabArea = function () {
                if (!vm.firstTimeArea) {
                    vm.areaGrid.dataSource.read();
                    vm.firstTimeArea = true;
                }
            }


            vm.selectTabLocality = function () {
                if (!vm.firstTimeLocality) {
                    vm.localityGrid.dataSource.read();
                    vm.firstTimeLocality = true;
                }
            }

            vm.selectTabStreet = function() {
                if (!vm.firstTimeStreet) {
                    vm.streetGrid.dataSource.read();
                    vm.firstTimeStreet = true;
                }
            }

            vm.selectedRegion = function (e) {

                var domain = e.dataItem.Domain != null ? e.dataItem.Domain : "";

                bars.ui.dialog({
                    iframe: true,
                    width: "90%",
                    height: "90%",
                    title: "Очистка Адрес",
                    content: {
                        url: bars.config.urlContent("/clients/ClientAddress/ClearAddress?domain=" + domain + "&mode=fromRegion"),
                        modal: true
                    }
                });
            }

            vm.selectedArea = function (e) {

                var regionId = e.dataItem.RegionId != null ? e.dataItem.RegionId : "";
                var region = e.dataItem.Region != null ? e.dataItem.Region : "";

                bars.ui.dialog({
                    iframe: true,
                    width: "90%",
                    height: "90%",
                    title: "Очистка Адрес",
                    content: {
                        url: bars.config.urlContent("/clients/ClientAddress/ClearAddress?regionId=" + regionId + "&region=" + region + "&mode=fromArea"),
                        modal: true
                    }
                });
            }

            vm.selectedLocality = function (e) {

                var regionId = e.dataItem.RegionId != null ? e.dataItem.RegionId : "";
                var areaId = e.dataItem.AreaId != null ? e.dataItem.AreaId : "";
                var locality = e.dataItem.Locality != null ? e.dataItem.Locality : "";

                bars.ui.dialog({
                    iframe: true,
                    width: "90%",
                    height: "90%",
                    title: "Очистка Адрес",
                    content: {
                        url: bars.config.urlContent("/clients/ClientAddress/ClearAddress?regionId=" + regionId + "&areaId=" + areaId + "&locality=" + locality + "&mode=fromLocality"),
                        modal: true
                    }
                });
            }

            vm.selectedStreet = function(e) {

                var regionId = e.dataItem.RegionId != null ? e.dataItem.RegionId : "";
                var areaId = e.dataItem.AreaId != null ? e.dataItem.AreaId : "";
                var settlementId = e.dataItem.SettlementId != null ? e.dataItem.SettlementId : "";
                var street = e.dataItem.Street != null ? e.dataItem.Street : "";

                bars.ui.dialog({
                    iframe: true,
                    width: "90%",
                    height: "90%",
                    title: "Очистка Адрес",
                    content: {
                        url: bars.config.urlContent("/clients/ClientAddress/ClearAddress?regionId=" + regionId + "&areaId=" + areaId + "&settlementId=" + settlementId + "&street=" + street + "&mode=fromStreet"),
                        modal: true
                    }
                });
            }
        });