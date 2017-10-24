angular.module('BarsWeb.Controllers')
    .controller('KFiles.AccountCorpCtrl', ['AccountCorpService',
        function (AccountCorpService) {

            var vm = this;

            vm.model = {};
            vm.modelGridCorporations = {};
            vm.selectedRow = [];
            vm.idField = "ACC";
            vm.firstTime = 1;
            vm.isFromGrid = false;
            vm.dataFromEditInstCod;


            var selectedCorp = [],
            tempSelectedCorp = [];

            vm.corp_code = "1";


            vm.toolbarOptionsAccCorp = {
                items: [
                    { template: "<button type = 'button' ng-click = 'accCorp.saveChanges()' title='Зберегти зміни' class='k-button'><i class='pf-icon pf-16 pf-save'></i></button>" },
                    { template: "<input type ='checkbox' id='checkAll' class='checkbox checkAll' ng-click='accCorp.checkAllRows()' ng-model='accCorp.checkedCheckBox' ng-checked='accCorp.checkedCheckBox'><span class='textChooseAll'> Вибрати всі </span>" },
                    { template: "<span class='textSetToChecked'> Встановити для виділених: </span><select kendo-drop-down-list ng-model='accCorp.dropDownType'><option value='1'>вкл. у виписку</option><option value='2'>Код ТРКК</option><option value='3'>Код установи</option></select>" },
                    { template: "<span class='textValue'> Значення: </span><div ng-show='accCorp.dropDownType == 1' style='display: inline'><select kendo-drop-down-list ng-model='accCorp.extractValue'><option value='Y'>Так</option><option value='N'>Ні</option></select></div>" },
                    { template: "<input type='text' class='k-input inputCodeTRKK' ng-show='accCorp.dropDownType == 2' ng-model='accCorp.CodeTRKKValue'>" },
                    { template: "<input type='text' class='k-input codeCorp'  ng-show='accCorp.dropDownType == 3' ng-keydown='accCorp.backSpaceEvent($event)' ng-model='accCorp.parentCorporation' readonly ><input type='text' class='k-input codeCorp' ng-keydown='accCorp.backSpaceEvent($event)' ng-show='accCorp.dropDownType == 3' ng-model='accCorp.childCorporation' readonly><button ng-show='accCorp.dropDownType == 3' class='k-button btnCodeCorp' ng-click='accCorp.openWinCorporations(" + '"fromToolBar"' + ")'><i class='pf-icon pf-16 pf-folder'></i></button>" },
                    { template: "<input type='hidden' ng-model='accCorp.hidBaseExtId' /><input type='hidden' ng-model='accCorp.hidExternalId' />" },                
                ]
            };

            vm.accountCorpGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/kfiles/kfiles/GetAccountCorp"),
                        dataType: 'json',
                        cache: false,
                        data: function () {
                            var sendCorps = [];
                            for (var i = 0; i < selectedCorp.length; i++) {
                                sendCorps.push(selectedCorp[i]);
                            }
                            return { corpIndexes: sendCorps };
                        }
                    }
                },
                batch: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            RNK: { type: "number" },
                            ACC: { type: "number" },
                            CORPORATION_CODE: { type: "string", editable: false },
                            CORPORATION_NAME: { type: "string", editable: false },
                            NMK: { type: "string", editable: false },

                            OKPO: { type: "string", editable: false },

                            NLS: { type: "string", editable: false },
                            KV: { type: "number", editable: false },
                            BRANCH: { type: "string", editable: false },
                            NMS: { type: "string", editable: false },
                            USE_INVP: { type: "string", editable: false },
                            TRKK_KOD: { type: "string" },
                            INST_KOD: { type: "string" },
                            ALT_CORP_COD: { type: "string" },
                            DAOS: { type: "date" },
                            ALT_CORP_NAME: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,

                requestStart: function () { vm.loading = true },
                requestEnd: function () { vm.loading = false },

                pageSize: 25
            });

            vm.accountCorpGridOptions = {
                dataSource: vm.accountCorpGridDataSource,
                sortable: true,
                autoBind: true,
                selectable: 'multiple',
                resizable: true,
                pageable: {
                    refresh: true,
                    pageSizes: [10, 25, 50, 100, "All"],
                    buttonCount: 5,
                    messages: {
                        empty: 'Немає даних',
                        allPages: 'Всі'
                    }
                },
                filterable: true,
                scrollable: true,
                editable: true,
                save: function (e) {
                    vm.saveRow(e);
                },
                change: function (e, args) {

                    var checkBox = angular.element('#checkAll');

                    if (vm.accountCorpGrid.select().length < 9) {
                        vm.model.selectAll = false;
                    }

                    if (vm.model.selectAll == true) {
                        vm.selectedRow = [];
                    }
                    else {
                        checkBox.prop('checked', false);
                        var grid = e.sender;
                        var items = grid.items();

                        items.each(function (idx, row) {

                            var idValue = grid.dataItem(row).get(vm.idField);
                            if (row.className.indexOf("k-state-selected") >= 0) {
                                var item = grid.dataItem(row);
                                vm.selectedRow[idValue] = {
                                    RNK: item.RNK,
                                    ACC: item.ACC,
                                    USE_INVP: item.USE_INVP,
                                    TRKK_KOD: item.TRKK_KOD,
                                    INST_KOD: item.INST_KOD,
                                    ALT_CORP_COD: item.ALT_CORP_COD,
                                    DAOS: item.DAOS
                                };
                            } else if (vm.selectedRow[idValue]) {
                                delete vm.selectedRow[idValue];
                            }

                        });
                    }
                },
                dataBound: function (e) {

                    if (vm.model.selectAll == true) {
                        vm.accountCorpGrid.select(vm.accountCorpGrid.tbody.find(">tr"));
                    }
                    else {
                        var grid = e.sender;
                        var items = grid.items();
                        var itemsToSelect = [];
                        items.each(function (idx, row) {
                            var dataItem = grid.dataItem(row);
                            if (vm.selectedRow[dataItem[vm.idField]]) {
                                itemsToSelect.push(row);
                            }
                        });
                        e.sender.select(itemsToSelect);
                    }
                },
                dataBinding: function (e) {

                    for (var i = 0; i < e.items.length; i++) {
                        if (vm.model[e.items[i].ACC] != undefined) {
                            if (e.items[i].ACC == vm.model[e.items[i].ACC].ACC) {

                                e.items[i].ACC = vm.model[e.items[i].ACC].ACC;
                                e.items[i].RNK = vm.model[e.items[i].ACC].RNK;
                                e.items[i].USE_INVP = vm.model[e.items[i].ACC].USE_INVP;
                                e.items[i].TRKK_KOD = vm.model[e.items[i].ACC].TRKK_KOD;
                                e.items[i].INST_KOD = vm.model[e.items[i].ACC].INST_KOD;
                                e.items[i].ALT_CORP_COD = vm.model[e.items[i].ACC].ALT_CORP_COD;
                                e.items[i].DAOS = vm.model[e.items[i].ACC].DAOS;
                                e.items[i].ALT_CORP_NAME = vm.model[e.items[i].ACC].ALT_CORP_NAME;

                            }
                        }
                    }
                },
                columns: [
                    {
                        field: "CORPORATION_CODE",
                        title: "Код корп.",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        },
                        width: 100
                    },
                    {
                        field: "CORPORATION_NAME",
                        title: "Назва корп.",
                        width: 120,
                        filterable: {
                            dataSource: {
                                transport: {
                                        read: {
                                                url: bars.config.urlContent('/kfiles/kfiles/GetCorpFilter'),
                                                type: "GET",
                                                dataType: "json",
                                                data: {
                                                        field: "CORPORATION_NAME"
                                                      }
                                               }
                                           }
                                        },
                                multi: true
                            }
                    },
                    {
                        field: "NMK",
                        title: "Клієнт",
                        width: 100
                    },
                    

                    {
                        field: "OKPO",
                        title: "Код ЄДРПОУ",
                        width: 100
                    },
                    

                    {
                        field: "NLS",
                        title: "Рахунок",
                        width: 100
                    },
                    {
                        field: "KV",
                        title: "Вал.",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        },
                        width: 100
                    },
                    {
                        field: "BRANCH",
                        title: "Відділення",
                        width: 100
                    },
                    {
                        field: "NMS",
                        title: "Назва рахунку",
                        width: 100
                    },
                    {
                        field: "USE_INVP",
                        title: "Виписка",
                        template: function (data) {
                            if (data.USE_INVP == 'Y') {
                                return "<input ng-model='checkedUse_Invp' type='checkbox'  ng-change='accCorp.checkedUseInvp(this)' ng-checked='true'></input>"
                            }
                            else {
                                return "<input ng-model='checkedUse_Invp' type='checkbox'  ng-change='accCorp.checkedUseInvp(this)'></input>"
                            }
                        },
                        filterable: false,
                        width: 80
                    },
                    {
                        field: "TRKK_KOD",
                        title: "Код ТРКК",
                        width: 100
                    },
                    {
                        field: "INST_KOD",
                        title: "Код устан.",
                        editor: "<button class='k-button btnInstcode' ng-click='accCorp.openWinCorporations(" + '"fromGrid"' + ',' + 'dataItem' + ")'><i class='pf-icon pf-16 pf-folder'></i></button>",
                        width: 100
                    },
                    {
                        field: "ALT_CORP_COD",
                        title: "Альт. корп.",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        },
                        width: 100
                    },
                    {
                        field: "DAOS",
                        title: "Дата відкриття",
                        template: "#=kendo.toString(DAOS,'dd/MM/yyyy')#",
                        width: 100

                    },
                    {
                        field: "ALT_CORP_NAMES",
                        title: "Назва Альт. Корп.",
                        width: "200px",
                        template: "#=ALT_CORP_NAME != null ?  ALT_CORP_NAME : '' #",
                        editor: function (container, options) { vm.altCorpNameDropDownEditor(container, options) },
                        width: 100
                    }
                ]
            };

            vm.checkedUseInvp = function (data) {

                var UseInvp;

                if (data.checkedUse_Invp == false) {
                    UseInvp = 'N';
                }
                else {
                    UseInvp = 'Y';
                }

                if (vm.model[data.dataItem.ACC]) {
                    vm.model[data.dataItem.ACC].USE_INVP = UseInvp;
                }
                else {
                    vm.model[data.dataItem.ACC] = {
                        RNK: data.dataItem.RNK,
                        ACC: data.dataItem.ACC,
                        USE_INVP: UseInvp,
                        TRKK_KOD: data.dataItem.TRKK_KOD,
                        INST_KOD: data.dataItem.INST_KOD,
                        ALT_CORP_COD: data.dataItem.ALT_CORP_COD,
                        DAOS: data.dataItem.DAOS,
                        ALT_CORP_NAME: data.dataItem.ALT_CORP_NAME
                    }
                }
            }

            vm.Search = function () {
                vm.accountCorpGridDataSource.read({ corp_code: vm.corp_code });
            }

            vm.saveRow = function (e) {

                if (vm.model[e.model.ACC]) {

                    vm.model[e.model.ACC].TRKK_KOD = e.values.TRKK_KOD != undefined ? e.values.TRKK_KOD : e.model.TRKK_KOD;
                    vm.model[e.model.ACC].INST_KOD = e.values.INST_KOD != undefined ? e.values.INST_KOD : e.model.INST_KOD;
                    vm.model[e.model.ACC].DAOS = e.values.DAOS != undefined ? e.values.DAOS : e.model.DAOS;
                    vm.model[e.model.ACC].ALT_CORP_COD = e.values.ALT_CORP_COD != undefined ? e.values.ALT_CORP_COD : e.model.ALT_CORP_COD;

                } else {
                    vm.model[e.model.ACC] = {
                        RNK: e.model.RNK,
                        ACC: e.model.ACC,
                        USE_INVP: e.model.USE_INVP,
                        TRKK_KOD: e.values.TRKK_KOD != undefined ? e.values.TRKK_KOD : e.model.TRKK_KOD,
                        INST_KOD: e.values.INST_KOD != undefined ? e.values.INST_KOD : e.model.INST_KOD,
                        DAOS: e.values.DAOS != undefined ? e.values.DAOS : e.model.DAOS,
                        ALT_CORP_COD: e.values.ALT_CORP_COD != undefined ? e.values.ALT_CORP_COD : e.model.ALT_CORP_COD,
                        ALT_CORP_NAME: e.model.ALT_CORP_NAME
                    }
                }
            }

            vm.altCorpNameDropDownEditor = function (container, options) {
                angular.element('<input required name="' + options.field + '"/>')
                    .appendTo(container)
                    .kendoDropDownList({
                        autoBind: true,
                        dataTextField: "ALT_CORP_NAME",
                        dataValueField: "EXTERNAL_ID",
                        template: '<span><b>#: EXTERNAL_ID # </b> -  #:ALT_CORP_NAME#</span>',
                        dataSource: {
                            type: 'aspnetmvc-ajax',
                            transport: {
                                read: {
                                    type: 'GET',
                                    url: bars.config.urlContent("/kfiles/kfiles/GetDropDownAltCorpName")
                                }
                            }
                        },
                        select: function (e) {

                            var idAltCorpName = parseInt(e.item.text());
                            var altCorpName = e.item.text().replace(/[^A-Za-zА-Яа-яЁё]/g, "");

                            options.model.ALT_CORP_NAME = altCorpName;
                            options.model.ALT_CORP_COD = idAltCorpName;

                        }
                    });


            }

            vm.saveChanges = function () {

                if ($.isEmptyObject(vm.model) || vm.selectedRow.length == 0 && vm.model.selectAll != true) {
                    bars.ui.error({ text: "Жодне поле не відредаговано" });
                    return false;
                }

                bars.ui.confirm({
                    text: ' Бажаєте зберeгти зміни ?'
                }, function () {
                    if (vm.model.selectAll == true) {

                        var value;

                        if (vm.dropDownType == 1) {
                            value = vm.extractValue;
                        }
                        else if (vm.dropDownType == 2) {
                            value = vm.CodeTRKKValue;
                        }
                        else if (vm.dropDownType == 3) {

                            var baseExtId = vm.hidBaseExtId;
                            var externalId = vm.hidExternalId;

                            value = '-' + baseExtId + '-' + externalId;
                        }

                        var parameterMap = vm.accountCorpGrid.dataSource.transport.parameterMap;
                        var requestObject = parameterMap({ filter: vm.accountCorpGrid.dataSource.filter(), dropDownType: vm.dropDownType, value: value });

                        //vm.loading = true;
                        AccountCorpService.SaveAccountCorpWithFilter(requestObject).then(

                                 function (data) {

                                     if (data.Status == "OK") {
                                         bars.ui.alert({ text: 'Зміни збережено' });
                                         vm.accountCorpGridDataSource.read();
                                         vm.model = {};
                                         vm.checkedCheckBox = false;
                                         //vm.loading = false;
                                     }
                                     if (data.Status == "ERROR") {
                                         bars.ui.error({ text: data.Message });
                                         //vm.loading = false;
                                     }
                                 },
                                 function (data) {
                                     bars.ui.error({ text: data.Message });
                                     //vm.loading = false;
                                 }
                             );
                    }
                    else {

                        for (var i in vm.selectedRow) {

                            if (vm.dropDownType == 1) {
                                vm.selectedRow[i].USE_INVP = vm.extractValue;
                            }
                            else if (vm.dropDownType == 2) {
                                vm.selectedRow[i].TRKK_KOD = vm.CodeTRKKValue;
                            }
                            else if (vm.dropDownType == 3) {

                                vm.selectedRow[i].ALT_CORP_COD = vm.hidBaseExtId;
                                vm.selectedRow[i].INST_KOD = vm.hidExternalId;

                            }
                        }

                        AccountCorpService.SaveAccountCorp(vm.selectedRow).then(

                                 function (data) {

                                     if (vm.model != {}) {
                                         vm.saveModel();
                                     }
                                     else {
                                         if (data.Message == 'Зміни збережено') {
                                             bars.ui.alert({ text: data.Message });
                                             vm.accountCorpGridDataSource.read();
                                             vm.model = {};
                                         }
                                         else {
                                             bars.ui.error({ text: data.Message });
                                         }
                                     }
                                 },
                                 function (data) {
                                     bars.ui.error({ text: data.Message });
                                 }
                             );
                    }

                });

            }

            vm.checkAllRows = function () {

                var checkBox = angular.element('#checkAll');

                if (checkBox.is(':checked')) {
                    vm.model.selectAll = true;
                    vm.selectedRow = [];
                    vm.accountCorpGrid.select(vm.accountCorpGrid.tbody.find(">tr"));
                }
                else {
                    vm.accountCorpGrid.clearSelection();
                    vm.model.selectAll = false;
                    vm.selectedRow = [];
                }

            }

            vm.saveModel = function () {

                AccountCorpService.SaveAccountCorp(vm.model).then(
                        function (data) {

                            if (data.Message == 'Зміни збережено') {
                                bars.ui.alert({ text: data.Message });
                                vm.accountCorpGridDataSource.read();
                                vm.model = {};
                            }
                            else {
                                bars.ui.error({ text: data.Message });
                            }
                        },
                        function (data) {
                            bars.ui.error({ text: data.Message });
                        }
                    );
            }


            vm.backSpaceEvent = function (event) {
                event.preventDefault();
                return false;
            }

            vm.openWinCorporations = function (type, data) {

                if (data) {
                    vm.dataFromEditInstCod = data;
                }

                vm.isFromGrid = type == 'fromGrid' ? true : false;

                vm.winCorporations.center().open().title("Перелік підрозділів");
                vm.gridCorporations.dataSource.read();
            }

            vm.corporationsGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/kfiles/kfiles/GetCorporationsGrid"),
                        dataType: 'json',
                        cache: false
                    }
                },
                batch: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            BASE_EXTID: { type: "string" },
                            BASE_CORP_NAME: { type: "string" },
                            EXTERNAL_ID: { type: "string" },
                            CORPORATION_NAME: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,
                pageSize: 10
            });

            vm.gridCorporationsOptions = {
                autoBind: false,
                dataSource: vm.corporationsGridDataSource,
                sortable: true,
                selectable: true,
                resizable: true,
                pageable: true,
                filterable: true,
                columns: [
                    {
                        field: "BASE_EXTID",
                        title: "Код корп.",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        },
                        width: 100
                    },
                    {
                        field: "BASE_CORP_NAME",
                        title: "Назва корп.",
                        width: 200
                    },
                    {
                        field: "EXTERNAL_ID",
                        title: "Код установи",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        },
                        width: 140
                    },
                    {
                        field: "CORPORATION_NAME",
                        title: "Назва установи",
                        width: 300
                    }
                ]
            };

            vm.changeCorporations = function (data) {
                vm.disabledSaveCorporation = false;
                vm.modelGridCorporations.BASE_CORP_NAME = data.BASE_CORP_NAME;
                vm.modelGridCorporations.BASE_EXTID = data.BASE_EXTID;
                vm.modelGridCorporations.CORPORATION_NAME = data.CORPORATION_NAME;
                vm.modelGridCorporations.EXTERNAL_ID = data.EXTERNAL_ID;
            }

            vm.closeWinCorporations = function () {
                vm.modelGridCorporations = {};
            }

            vm.btnSaveCorporation = function () {

                if (vm.isFromGrid) {

                    if (vm.model[vm.dataFromEditInstCod.ACC]) {

                        vm.model[vm.dataFromEditInstCod.ACC].INST_KOD = vm.modelGridCorporations.EXTERNAL_ID;
                        vm.model[vm.dataFromEditInstCod.ACC].ALT_CORP_COD = vm.modelGridCorporations.BASE_EXTID;
                        vm.model[vm.dataFromEditInstCod.ACC].ALT_CORP_NAME = vm.modelGridCorporations.BASE_CORP_NAME;
                    }
                    else {
                        vm.model[vm.dataFromEditInstCod.ACC] = {
                            RNK: vm.dataFromEditInstCod.RNK,
                            ACC: vm.dataFromEditInstCod.ACC,
                            USE_INVP: vm.dataFromEditInstCod.USE_INVP,
                            TRKK_KOD: vm.dataFromEditInstCod.TRKK_KOD,
                            INST_KOD: vm.modelGridCorporations.EXTERNAL_ID,
                            DAOS: vm.dataFromEditInstCod.DAOS,
                            ALT_CORP_COD: vm.modelGridCorporations.BASE_EXTID,
                            ALT_CORP_NAME: vm.modelGridCorporations.BASE_CORP_NAME
                        }
                    }

                    vm.accountCorpGrid.dataSource.read();
                    vm.winCorporations.close();
                    vm.modelGridCorporations = {};
                    vm.dataFromEditInstCod = undefined;
                }
                else {

                    vm.parentCorporation = vm.modelGridCorporations.BASE_EXTID + ' - ' + vm.modelGridCorporations.BASE_CORP_NAME;
                    vm.childCorporation = vm.modelGridCorporations.EXTERNAL_ID + ' - ' + vm.modelGridCorporations.CORPORATION_NAME;
                    vm.hidBaseExtId = vm.modelGridCorporations.BASE_EXTID;
                    vm.hidExternalId = vm.modelGridCorporations.EXTERNAL_ID;
                    vm.winCorporations.close();
                    vm.modelGridCorporations = {};
                }
            }

        }]);