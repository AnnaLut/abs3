﻿angular.module(globalSettings.modulesAreas)
    // module constants
    .constant("SchemeBuilderConfig", {
        "baseApiUrl": "/api/gl/SchemeBuilder/",
        "defaultGroupId": 1
    })
    .controller('SchemeBuilder', ['$scope', 'SchemeBuilderConfig', 'schemeBuilderService',
        function ($scope, config, service) {
            'use strict';
            var vm = this;

            //*** helper functions -----------------------------------

            // remove all mask symbols from kendoMaskedTextBox
            var unmaskKendoText = function (str) {
                return (str + '').replace(/[()\s-_]/g, "");
            };

            //------------------------------------------------------------------------
            /// filters for grids
            vm.schemeBuilderFilter = {
                groupId: config.defaultGroupId
            };
            vm.schemeBuilderDetailFilter = {
                schemeId: $scope.schemeId
            };

            //-------------------------------------------------------------------------
            // get selected row data main grid
            var selectedSBRow = function () {
                return vm.schemeBuilderGrid.dataItem(vm.schemeBuilderGrid.select());
            };
            // get selected row data detail grid
            var selectedSBDRow = function () {
                return vm.schemeBuilderDetailGrid.dataItem(vm.schemeBuilderDetailGrid.select());
            };
            //-------------------------------------------------------------------------

            // affect main toolbar
            var enableToolbarButtons = function (type, data) {
                vm.schemeBuilderGridToolbar.enable('#editSchemeBtn', type);
                vm.schemeBuilderGridToolbar.enable('#deleteSchemeBtn', type);
            };

            // affect detail toolbar
            var enableDetailToolbarButtons = function (type, data) {
                vm.schemeBuilderDetailGridToolbar.enable('#editSchemeDetailBtn', type);
                vm.schemeBuilderDetailGridToolbar.enable('#deleteSchemeDetailBtn', type);
            };

            // refresh detail grid
            var showDetailData = function () {
                $scope.$apply(function () {
                    var row = selectedSBRow();
                    if (row) {
                        vm.schemeId = row.SchemaId;
                        vm.schemeBuilderDetailFilter.schemeId = vm.schemeId;
                    }
                });
                vm.schemeBuilderDetailGrid.dataSource.data([]);
                vm.schemeBuilderDetailGrid.refresh();
                vm.schemeBuilderDetailGridToolbar.enable('#addSchemeDetailBtn', false);
                if (vm.schemeId) {
                    vm.schemeBuilderDetailGrid.dataSource.read();
                    vm.schemeBuilderDetailGrid.refresh();
                    vm.schemeBuilderDetailGridToolbar.enable('#addSchemeDetailBtn', true);
                }
            }

            vm.checkSchemeAccount = function () {
                if ($scope.validator.validate()) {
                    vm.sa.AccNum = unmaskKendoText(vm.sa.AccNum);
                    vm.sa.CurrId = unmaskKendoText(vm.sa.CurrId);
                    vm.sa.SchemaId = unmaskKendoText(vm.sa.SchemaId);
                    vm.sa.CalcMethod = unmaskKendoText(vm.sa.CalcMethod);
                    // new account or changed, check if exists
                    if (!vm.sa.AccId || vm.sa.AccNum != vm.sa.AccNumOrigin) {
                        service.getAccount(vm.sa.AccNum, vm.sa.CurrId).then(
                            function (response) {
                                vm.sa.AccId = response.AccId;
                                vm.sa.Name = response.Name;
                                vm.saveSchemeAccount();
                            });
                    }
                    else vm.saveSchemeAccount();
                }
            };

            vm.saveSchemeAccount = function () {
                if ($scope.validator.validate()) {
                    vm.sa.GroupId = vm.schemeBuilderFilter.groupId;
                    service.editSchemeAccount(vm.sa).then(
                        function () {
                            bars.ui.notify('Статус', 'Рахунок ' + vm.sa.AccNum + '(' + vm.sa.CurrId + ') успішно добавлено\\змінено у схемі перекриття.', 'success');
                            vm.schemeBuilderGrid.dataSource.read();
                            $scope.editSchemeAccWindow.close();
                        },
                        function () {
                            bars.ui.notify('Помилка вставки рахунку у схему перекриття', error.Message || error, 'error')
                        });
                }
            };

			vm.saveSchemeSideB = function (elem, editedRows) {
                if (elem)
                    vm.ssb = elem;
                if (editedRows && editedRows.length > 0) {
                    service.batchEditSchemeSideB(editedRows).then(
                        function (result) {
                            vm.schemeBuilderDetailGrid.dataSource.read();
                            bars.ui.notify('Статус', 'Зміни успішно збережено!', 'success');
                        });
                }
                else
                    if ($scope.validatorSB.validate() || elem) {
                        vm.ssb.OpType = unmaskKendoText(vm.ssb.OpType);
						vm.ssb.OpCode = unmaskKendoText(vm.ssb.OpCode);
						vm.ssb.RecipientBankId = (vm.ssb.RecipientBankId.length === 6) ? unmaskKendoText(vm.ssb.RecipientBankId) : unmaskKendoText(angular.element('#ssbRecipientBankId').val()); // bug with refreshing field in ie8 
                        vm.ssb.RecipientAccNum = unmaskKendoText(vm.ssb.RecipientAccNum);
                        vm.ssb.CurrId = unmaskKendoText(vm.ssb.CurrId);
                        vm.ssb.RecipienCustCode = unmaskKendoText(vm.ssb.RecipienCustCode);
                        vm.ssb.Scale = unmaskKendoText(vm.ssb.Scale);
                        vm.ssb.SchemaId = vm.schemeBuilderDetailFilter.schemeId;
                        service.editSchemeSideB(vm.ssb).then(
                            function () {
                                bars.ui.notify('Статус', 'Отримувача з рахунком ' + vm.ssb.RecipientAccNum + '(' + vm.ssb.CurrId + ') успішно ' + (vm.ssb.Id ? 'змінено' : 'добавлено') + ' у схемі перекриття.', 'success');
                                vm.schemeBuilderDetailGrid.dataSource.read();
                                $scope.editSchemeSideBWindow.close();
                            });
                    }
            }

            // edit window for scheme account
            vm.showEditSaWindow = function (editMode, title, row) {
                vm.sa = row || { CurrId: 980 };
                vm.sa.editMode = editMode;
                vm.sa.AccNumOrigin = vm.sa.AccNum;
                $scope.$apply();
                $scope.validator.hideMessages();
                $scope.editSchemeAccWindow.setOptions({ title: title });
                $scope.editSchemeAccWindow.center().open();
            };

            // edit window for scheme account
            vm.showEditSsbWindow = function (editMode, title, row) {
                vm.ssb = row || { CurrId: selectedSBRow().CurrId };
                vm.ssb.editMode = editMode;
                $scope.$apply();
                $scope.validatorSB.hideMessages();
                $scope.editSchemeSideBWindow.setOptions({ title: title });
                $scope.editSchemeSideBWindow.center().open();
            };

            // main grid toolbar
            vm.schemeBuilderGridToolbarOptions = {
                resizable: false,
                items: [
                    {
                        type: 'button',
                        id: 'addSchemeBtn',
                        text: '<i class="pf-icon pf-16 pf-add_button"></i> Добавити',
                        click: function () {
                            vm.showEditSaWindow(false, "Вставка нового рахунку до схеми");
                        }
                    }, { type: 'separator' },
                    {
                        enable: false,
                        id: 'editSchemeBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-tool_pencil"></i> Редагувати',
                        click: function () {
                            vm.showEditSaWindow(true, "Редагування рахунку в схемі", selectedSBRow());
                        }
                    }, { type: 'separator' },
                    {
                        enable: false,
                        id: 'deleteSchemeBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-delete"></i> Видалити',
                        click: function () {
                            var row = selectedSBRow();
                            service.deleteSchemeAccount(row.AccId).then(
                                function () {
                                    bars.ui.notify('Статус', 'Рахунок ' + row.AccNum + '(' + row.CurrId + ') успішно видалено з вказаної схеми перекриття.', 'success');
                                    vm.schemeBuilderGrid.dataSource.read();
                                },
                                function (error) {
                                    bars.ui.notify('Помилка видалення рахунку з схеми перекриття', error.Message || error, 'error')
                                });
                        }
                    }, { type: 'separator' }
                ]
            };

            // detail grid toolbal
            vm.schemeBuilderDetailGridToolbarOptions = {
                resizable: false,
                items: [
                    {
                        type: 'button',
                        id: 'addSchemeDetailBtn',
                        text: '<i class="pf-icon pf-16 pf-add_button"></i> Добавити',
                        click: function () {
                            vm.showEditSsbWindow(false, "Вставка отримувача до схеми");
                        }
                    }, { type: 'separator' },
                    {
                        enable: false,
                        id: 'editSchemeDetailBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-tool_pencil"></i> Редагувати',
                        click: function () {
                            vm.showEditSsbWindow(true, "Редагування отримувача по схемі перекриття", selectedSBDRow());
                        }
                    }, { type: 'separator' },
                    {
                        enable: true,
                        id: 'saveSchemeDetailBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-save"></i> Зберегти',
                        click: function () {
                            var data = vm.schemeBuilderDetailGrid.dataSource.data();
                            var totalCoefficient = 0;
                            var editedRows = [];
                            for (var i = 0; i < data.length; i++) {
                                totalCoefficient += data[i].Coefficient;
                                if (data[i].dirty)
                                    editedRows.push(data[i]);
                            }
			    totalCoefficient = Math.round(totalCoefficient * 10000000) / 10000000;
                            if (totalCoefficient !== 1) {
                                bars.ui.error({ title: 'Помилка', text: 'Сума усіх коефіцієнтів повинна дорівнювати 1, поточна сума - ' + totalCoefficient });
                            }
                            else {
                                if (editedRows.length > 0)
                                    vm.saveSchemeSideB(null, editedRows);
                                else 
                                    bars.ui.alert({ title: 'Збереження', text: 'Відсутні данні для збереження!' });
                            }
                        }
                    }, { type: 'separator' },
                    {
                        enable: false,
                        id: 'deleteSchemeDetailBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-delete"></i> Видалити',
                        click: function () {
                            var id = selectedSBDRow().Id;
                            service.deleteSchemeSideB(id).then(
                                function () {
                                    bars.ui.notify('Статус', 'Стрічку з id=' + id + ' успішно видалено.', 'success');
                                    vm.schemeBuilderDetailGrid.dataSource.read();
                                },
                                function () {
                                    bars.ui.notify('Помилка видалення', error.Message || error, 'error')
                                });
                        }
                    }, { type: 'separator' }
                ]
            };

            // setting main scheme grid
            vm.schemeBuilderGridOptions = {
                autoBind: false,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                },
                dataBound: function (e) {
                    var data = e.sender.dataSource.data();
                    if (data.length === 0) {
                        var colCount = e.sender.columns.length;
                        $(e.sender.wrapper)
                            .find('tbody')
                            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' :(</td></tr>');
                    }
                    var grid = this;
                    grid.element.height("auto");
                    grid.element.find(".k-grid-content").height("auto");
                    grid.select("tr:eq(1)");
                    kendo.resize(grid.element);
                },
                dataBinding: function () {
                    enableToolbarButtons(false);
                },
                change: function () {
                    enableToolbarButtons(true, selectedSBRow());
                    showDetailData();
                },
                dataSource: {
                    type: 'webapi',
                    pageSize: 5,
                    page: 1,
                    total: 0,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    serverGrouping: true,
                    serverAggregates: true,
                    transport: {
                        read: {
                            url: bars.config.urlContent(config.baseApiUrl + 'GetSchemeAccounts'),
                            dataType: 'json',
                            data: function () { return vm.schemeBuilderFilter }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'AccId',
                            fields: {
                                AccId: { type: 'number' },
                                AccNum: { type: 'string' },
                                CurrId: { type: 'number' },
                                Name: { type: 'string' },
                                GroupId: { type: 'number' },
                                SchemaId: { type: 'number' },
                                CalcMethod: { type: 'number' }
                            }
                        }
                    }
                },
                columns: [
                   {
                       field: 'AccNum',
                       title: 'Рахунок',
                       width: '120px'
                   }, {
                       field: 'CurrId',
                       title: 'Валюта',
                       width: '30px'
                   }, {
                       field: 'Name',
                       title: 'Назва рахунку',
                       width: '200px'
                   }, {
                       field: 'CustCode',
                       title: 'ОКПО',
                       width: '100px'
                   }, {
                       field: 'SchemaId',
                       title: 'Номер схеми',
                       width: '160px'
                   }, {
                       field: 'CalcMethod',
                       title: 'Спосіб обрахування суми',
                       width: '80px'
                   }
                ]
            };

            vm.coefficientFormat = {
                format: "n10",
                decimals: 10,
                restrictDecimals: true,
                step: 0.01
            };

            // setting detail scheme grid
            vm.schemeBuilderDetailGridOptions = {
                autoBind: false,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                pageable: {
                    refresh: true,
                    buttonCount: 5
                },
                dataBinding: function () {
                    enableDetailToolbarButtons(false);
                },
                change: function () {
                    enableDetailToolbarButtons(true, selectedSBDRow());
                },
                dataSource: {
                    type: 'webapi',
                    pageSize: 10,
                    page: 1,
                    total: 0,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    serverGrouping: true,
                    serverAggregates: true,
                    transport: {
                        read: {
                            url: bars.config.urlContent(config.baseApiUrl + 'GetSchemeDetail'),
                            dataType: 'json',
                            data: function () { return vm.schemeBuilderDetailFilter }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        batch: true,
                        model: {
                            id: 'Id',
                            fields: {
                                Id: { type: 'number', editable: false },
                                Scale: { type: 'number', editable: false },
                                OpType: { type: 'number', editable: false },
                                OpCode: { type: 'string', editable: false },
                                CurrId: { type: 'number', editable: false },
                                Coefficient: { type: 'number', validation: { min: 0, max: 1, step: 0.01 } },
                                RecipientBankId: { type: 'string', editable: false },
                                RecipientAccNum: { type: 'string', editable: false },
                                RecipientName: { type: 'string', editable: true },
                                RecipienCustCode: { type: 'string' },
                                Narrative: { type: 'string' }
                            }
                        }
                    }
                },
                editable: true,
                columns: [
                   {
                       field: 'OpType',
                       title: 'Вид док.',
                       width: '5%'
                   }, {
                       field: 'OpCode',
                       title: 'Код оп.',
                       width: '5%'
                   }, {
                       field: 'RecipientBankId',
                       title: 'МФО отримувача',
                       width: '10%'
                   }, {
                       field: 'RecipientAccNum',
                       title: 'Рахунок отимувача',
                       width: '10%',
                   }, {
                       field: 'CurrId',
                       title: 'Валюта',
                       width: '5%',
                   }, {
                       field: 'Coefficient',
                       title: 'Коефіціент',
                       width: '10%',
                       format: "{0:n10}",
                       editor: numberEditor,
                   }, {
                       field: 'RecipientName',
                       title: 'Отримувач',
                       width: '20%',
                       editor: stringEditor,
                   }, {
                       field: 'Narrative',
                       title: 'Призначення платежу',
                       width: '25%',
                       editor: stringEditor,
                   }, {
                       field: 'RecipienCustCode',
                       title: 'ОКПО отримувача',
                       width: '10%',
                       editor: stringEditor
                   }, {
                       field: 'Scale',
                       title: 'Рівень',
                       width: '10%'
                   }
                ]
            };

            function numberEditor(container, options) {
                $('<input ng-model="sbCtrl.ssb.' + options.field + '" name="' + options.field + '"/>')
                        .appendTo(container)
                        .kendoNumericTextBox({
                            format: "{0:n10}",
                            decimals: 10,
                            restrictDecimals: true,
                            min: 0,
                            max: 1,
                            step: 0.01
                            //,change: onInlineFieldChange,
                        });
            }
            function stringEditor(container, options) {
                $('<input ng-model="sbCtrl.ssb.' + options.field + '" name="' + options.field + '" class="k-textbox" />')
                    .change(onInlineFieldChange)
                        .appendTo(container);
            }


            function onInlineFieldChange() {
                vm.saveSchemeSideB(selectedSBDRow());
            }

            // drop down source
            $scope.schemeGroupDataSource = {
                type: "webapi",
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'GetSchemeGroupList')
                    }
                }
            };

            $scope.schemeGroupOptions = {
                dataBound: function (e) {
                    e.sender.select(function (dataItem) {
                        return dataItem.GroupId === config.defaultGroupId;
                    });
                    e.sender.trigger("change");
                },
                change: function () {
                    var value = this.value();
                    vm.schemeBuilderFilter.groupId = value;
                    vm.schemeId = null;
                    if (value) {
                        vm.schemeBuilderGrid.dataSource.read();
                        vm.schemeBuilderGrid.dataSource.page(1);
                    }
                }
            };

            $scope.currDataSource = {
                type: "webapi",
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'GetCurrenciesList')
                    }
                }
            };

            $scope.banksDataSource = {
                type: "webapi",
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'GetBanksList')
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            BankId: { type: "string" },
                            Name: { type: "string" }
                        }
                    }
                }
            };

            $scope.operationsDataSource = {
                type: "webapi",
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'GetOperationList')
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            Id: { type: "string" },
                            Name: { type: "string" }
                        }
                    }
                }
            };

            $scope.opTypesDataSource = {
                type: "webapi",
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent(config.baseApiUrl + 'GetOpTypeList')
                    }
                },
                schema: {
                    data: "Data",
                    model: {
                        fields: {
                            Id: { type: "string" },
                            Name: { type: "string" }
                        }
                    }
                }
            };

            $scope.currOptions = {
                change: function () {
                    var value = this.value();
                    vm.sa.CurrId = value;
                    $scope.$apply();
                }
            };

            $scope.currOptionsB = {
                change: function () {
                    var value = this.value();
                    vm.ssb.CurrId = value;
                    $scope.$apply();
                }
            };
        }]);
