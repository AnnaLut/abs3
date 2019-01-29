angular.module('BarsWeb.Areas')
    .controller('Acct.StatementsCtrl', ['$http', '$window', function ($http, $window) {
        'use strict';

        var vm = this;
        vm.fractionSize = 2;

        var type = bars.extension.getParamFromUrl('type');
        var acctId = bars.extension.getParamFromUrl('acctId');
        var dateStartFromUrl = bars.extension.getParamFromUrl('dateStart') || bars.extension.getParamFromUrl('date');
        var dateEndFromUrl = bars.extension.getParamFromUrl('dateEnd') || bars.extension.getParamFromUrl('date');

        var parseDateFopmat = ['dd/MM/yyyy', 'dd.MM.yyyy', "yyyy/MM/dd", 'yyyy-MM-dd', "MM/dd/yyyy"];
        var dateStart = kendo.parseDate(dateStartFromUrl, parseDateFopmat);


        var date = dateStart || new Date();
        var dateEnd = kendo.parseDate(dateEndFromUrl, parseDateFopmat) || date;

        vm.statementData = {
            acctId: acctId,//130544,
            accountNumber: '',
            accountCurrencyId: '',
            dateStart: new Date(date.setHours(0, 0, 0)),
            dateEnd: new Date(dateEnd.setHours(23, 59, 59, 999))
        };

        vm.startDateOptions = {
            format: '{0:dd/MM/yyyy}',
            mask: '00/00/0000',
            change: function () {
                //vm.endDate.min(this.value());
            }
        };

        vm.endDateOptions = {
            format: '{0:dd/MM/yyyy}',
            mask: '00/00/0000',
            change: function () {
                vm.startDate.max(this.value());
            }
        };

        vm.statementTurnovers = {};
        var getStatementParams = function () {
            var result = {};
            result.acctId = vm.statementData.acctId;
            result.dateStart = kendo.toString(vm.statementData.dateStart, 'yyyy-MM-dd');
            result.dateEnd = kendo.toString(vm.statementData.dateEnd, 'yyyy-MM-dd');
            //
            result.type = 'saldo';
            return result;
        };

        var getStmTurnoverParams = function () {
            var result = {};
            result.acctId = vm.statementData.acctId;
            result.dateStart = kendo.toString(vm.statementData.dateStart, 'yyyy-MM-dd');
            result.dateEnd = '';//kendo.toString(vm.statementData.dateEnd, 'yyyy-MM-dd');

            return result;
        };

        /*var getTurnovers = function () {
            $http({
                url: bars.config.urlContent('/api/v1/acct/Statements/GetStatement'),
                method: "GET",
                responseType: 'json',
                params: getStmTurnoverParams()
            }).then(function (response) {
                vm.statementData.accountNumber = response.data.AccountNumber;
                vm.statementData.accountCurrencyId = response.data.AccountCurrencyId;
                vm.statementTurnovers = response.data.Turnovers;
                //конвертуємо дату
                if (vm.statementTurnovers) {
                    if (vm.statementTurnovers.MaxDate) {
                        vm.statementTurnovers.MaxDate = new Date(vm.statementTurnovers.MaxDate.match(/\d+/)[0] * 1);
                    }
                    if (vm.statementTurnovers.MinDate) {
                        vm.statementTurnovers.MinDate = new Date(vm.statementTurnovers.MinDate.match(/\d+/)[0] * 1);
                    }
                }
            });
        };*/

        var reloadStatement = function () {
            bars.ui.loader('body');
            $http({
                url: bars.config.urlContent('/api/v1/acct/Statements/'),
                method: "GET",
                responseType: 'json',
                params: getStatementParams()
            }).then(function (response) {
                bars.ui.loader('body', false);
                vm.statementData.accountNumber = response.data.AccountNumber;
                vm.statementData.accountCurrencyId = response.data.AccountCurrencyId;
                vm.statementTurnovers = response.data.Turnovers;

                //конвертуємо дату
                if (vm.statementTurnovers) {
                    if (vm.statementTurnovers.MaxDate) {
                        vm.statementTurnovers.MaxDate = new Date(vm.statementTurnovers.MaxDate.match(/\d+/)[0] * 1);
                    }
                    if (vm.statementTurnovers.MinDate) {
                        vm.statementTurnovers.MinDate = new Date(vm.statementTurnovers.MinDate.match(/\d+/)[0] * 1);
                    }
                }
                /*var data = response.data.PaymentsList;
                for (var i = 0; i < data.length; i++) {
                    data[i].Date = new Date(data[i].Date.match(/\d+/)[0] * 1);
                }*/


                //vm.statementsGrid.dataSource.data(data);
                //vm.statementsGrid.reload();
                vm.statementsGridOptions.dataSource.read();
                //vm.statementsGridOptions.refresh();
            }/*, function (response) {
                
            }*/);
        };

        var remoteDataSource = new kendo.data.DataSource({
            type: "webapi",
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 20,
            //sort: {
            //    field: "Id",
            //    dir: "desc"
            //},
            sort: [{
                field: "Debit",
                dir: "desc"
            }, {
                    field: "Kredit",
                    dir: "desc"
            }],
            transport: {
                read: {
                    dataType: 'json',
                    type: 'GET',
                    url: bars.config.urlContent('/api/v1/acct/Statements/Payments'),
                    data: //getStatementParams() 
                    function () {
                        var result = {};
                        result.acctId = vm.statementData.acctId;
                        result.dateStart = kendo.toString(vm.statementData.dateStart, 'yyyy-MM-dd');
                        result.dateEnd = kendo.toString(vm.statementData.dateEnd, 'yyyy-MM-dd');
                        return result;
                    }
                }
            },
            schema: {
                data: "Data",
                //total: "PaymentsList.length",
                //data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    id: 'Id',
                    fields: {
                        Id: { type: "number", editable: false },
                        DocumentId: { type: "number", editable: false },
                        Number: { type: "string", editable: false },
                        TransactionType: { type: "string", editable: false },
                        AccountId: { type: "number", editable: false },
                        StatusCode: { type: "number", editable: false },
                        CorrespBankId: { type: "string", editable: false },
                        CorrespCurrencyId: { type: "number", editable: false },
                        CorrespAccountNumber: { type: "string", editable: false },
                        CorrespAccountName: { type: "string", editable: false },
                        Debit: { type: "number", editable: false },
                        Kredit: { type: "number", editable: false },
                        Purpose: { type: "string", editable: false },
                        Date: { type: "date", editable: false },
                        FactDate: { type: "date", editable: false },
                        SenderAccountNumber: { type: "number", editable: false },
                        SenderAccountName: { type: "string", editable: false }
                    }
                }
            }
        });

        angular.element(document).ready(function () {
            reloadStatement();

            //insertSelectionTooltip();
            //insertRowSelectionTooltip();
            insertRowSelectionTooltipByCellIndex(5);    //Debit
            insertRowSelectionTooltipByCellIndex(6);    //Kredit

            //getTurnovers();

            //vm.statementsGridOptions.dataSource.read();
            //vm.statementsGridOptions.refresh();
        });


        var itemsToolbar = [
            {
                template: '<label>Період : </label>'
            }, {
                template: '  <input type="text" k-ng-model="statementsCtrl.statementData.dateStart" kendo-masked-date-picker="statementsCtrl.startDate"  k-options="statementsCtrl.startDateOptions" />'
            }, {
                template: ' по <input type="text" k-ng-model="statementsCtrl.statementData.dateEnd" kendo-masked-date-picker="statementsCtrl.endDate" k-options="statementsCtrl.endDateOptions" />'
            }, {
                type: 'separator'
            }, {
                type: 'button',
                text: '<i class="pf-icon pf-16 pf-reload_rotate"></i> Перечитати',
                click: function () {
                    reloadStatement();
                }
            }
        ];
        if(type !== undefined && type !== null && type !== ""){
            itemsToolbar.push({
                type: 'button',
                text: '<i class="pf-icon pf-16 pf-undo_green"></i> Повернутись до історії',
                click: function () {
                    $window.location = "/barsroot/customerlist/showhistory.aspx?acc=" + acctId + "&type=" + type;
                }
            });
        }
        vm.stToolbarOptions = { items: itemsToolbar };

        var paintStatementGridRow = function (grid) {
            var gridData = grid.dataSource.view();

            for (var i = 0; i < gridData.length; i++) {
                var color = 'black';
                var statusCode = gridData[i].StatusCode;

                if (statusCode < 0) {
                    color = 'red';
                } else if (statusCode === 1) {
                    color = 'green';
                } else if (statusCode === 2) {
                    color = 'purple';
                } else if (statusCode === 3) {
                    color = 'blue';
                }

                grid.table.find("tr[data-uid='" + gridData[i].uid + "']").css('color', color);
            }
        };

        vm.showDocument = function (id) {
            var frameUrl = '/barsroot/documentview/default.aspx?ref=' + id;
            //bars.ui.dialog({
            //    content: frameUrl,
            //    iframe: true,
            //    maximize: true,
            //    width: 720,
            //    height: 504 //optimal size of window
            //});
            //window.showModalDialog(frameUrl, "", "dialogHeight:" + window.screen.height + ";dialogwidth:" + window.screen.width + ";dialogtop:0;dialogleft:0;edge:sunken;help:0;status:0;resizable:1;scroll:1");
            window.open(frameUrl, '_blank');
        };

        vm.lineToolbarOptions = {
            items: [
                {
                    type: "splitButton",
                    name: "excel",
                    icon: "excel",
                    text: "Вигрузити в EXCEL",
                    menuButtons: [
                        {
                            text: "Усі сторінки", click: function () {
                                vm.statementsGrid.options.excel.allPages = true;
                                vm.statementsGridOptions.saveAsExcel();
                            }
                        },
                        {
                            text: "Поточна сторінка", click: function () {
                                vm.statementsGrid.options.excel.allPages = false;
                                vm.statementsGridOptions.saveAsExcel();
                            }
                        }
                    ],
                    //click: function () { vm.statementsGridOptions.saveAsExcel(); }
                }
            ]
        };
        vm.statementsGridOptions = {
            saveAsExcel: function (p) { vm.statementsGrid.saveAsExcel(p); },
            //toolbar: [{
            //    name: "excel",
            //    imageClass: 'pf-icon pf-16 pf-exel',
            //    text: ' Вигрузити в EXCEL'
            //}],
            toolbar: [{
                template: "<div id='lineToolbarDiv' kendo-toolbar='lineToolbar' k-options='statementsCtrl.lineToolbarOptions' class='button-group-toolbar'></div>"
            }],
            excelExport: function (e) {
                var sheet = e.workbook.sheets[0];
                for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
                    var row = sheet.rows[rowIndex];
                    for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
                        var type = vm.statementsGridOptions.dataSource.options.schema.model.fields[vm.statementsGridOptions.columns[cellIndex].field].type;
                        var field = vm.statementsGridOptions.columns[cellIndex].field;
                        if ('date' === type) {
                            row.cells[cellIndex].format = "dd/MM/yyyy HH:mm:ss";
                        } else if ('Kredit' === field || 'Debit' === field) {
                            row.cells[cellIndex].format = '###,##0.00';
                        }
                    }
                }
                //debugger;
                //var tbHeader = $("#tbHeader")[0];
                //var newRows = [];
                //var nR = tbHeader.rows[1];
                //for (var rowIndex = 0; rowIndex < tbHeader.rows.length; rowIndex++) {
                //    var cells = [];
                //    for (var cellIndex = 0; cellIndex < tbHeader.rows[rowIndex].cells.length; cellIndex++) {
                //        cells.push(tbHeader.rows[rowIndex].cells[cellIndex].innerText);
                //    }
                //    newRows.push(cells);
                //}
                //e.workbook.sheets[0].rows.unshift(newRows);
            },
            excel: {
                fileName: "accounts.xlsx",
                allPages: false,
                filterable: true,
                pagenable: false,
                proxyURL: bars.config.urlContent('/acct/statements/convertBase64toFile/')
            },
            height: 100,
            autoBind: false,
            //selectable: 'multiple, cell',
            //selectable: 'multiple, row',
            groupable: false,
            sortable: true,
            resizable: true,
            filterable: true,
            scrollable: true,

            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 1
            },
            dataBound: function (e) {
                var grid = e.sender;
                bars.ext.kendo.grid.noDataRow(e);

                paintStatementGridRow(grid);
            },
            dataSource: remoteDataSource /*{
                type: 'webapi',
                /*pageSize: 20,
                page: 1,
                total: 0,*/
                /*serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,*/
                /*sort: {
                    field: "Id",
                    dir: "desc"
                },
                /*transport: {
                    dataType: 'json',
                    type: 'GET',
                    read: bars.config.urlContent('/api/v1/acct/ReservedAccounts/')
                },*/
                /*transport: {
                    read: {
                        dataType: 'json',
                        type: 'GET',
                        url: bars.config.urlContent('/api/v1/acct/Statements/'),
                        data: getStatementParams()
                    }
                },
                /*schema: {
                    data: "PaymentsList",
                    //total: "PaymentsList.length",
                    //data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: 'Id',
                        fields: {
                            Id: { type: "number", editable: false },
                            DocumentId: { type: "number", editable: false },
                            Number: { type: "string", editable: false },
                            TransactionType: { type: "string", editable: false },
                            AccountId: { type: "number", editable: false },
                            StatusCode: { type: "number", editable: false },
                            CorrespBankId: { type: "string", editable: false },
                            CorrespCurrencyId: { type: "number", editable: false },
                            CorrespAccountNumber: { type: "string", editable: false },
                            CorrespAccountName: { type: "string", editable: false },
                            Debit: { type: "number", editable: false },
                            Kredit: { type: "number", editable: false },
                            Purpose: { type: "string", editable: false },
                            Date: { type: "date", editable: false },
                            FactDate: { type: "date", editable: false }
                        }
                    }
                }
            }*/,
            selectable: "multiple cell",
            allowCopy: true,
            columns: [
                {
                    field: 'DocumentId',
                    title: 'Номер док.',
                    width: '90px',
                    template: '<a href="\\#" ng-click="statementsCtrl.showDocument(#=DocumentId#)">#=DocumentId#</a>',
                    filterable: bars.ext.kendo.grid.uiNumFilter
                }, {
                    field: 'TransactionType',
                    title: 'Код оп.',
                    width: '60px'
                }, {
                    field: 'SenderAccountName',
                    title: 'Відправник',
                    width: '200px'
                }, {
                    field: 'CorrespAccountName',
                    title: 'Одержувач',
                    width: '200px'
                }, {
                    field: 'Debit',
                    title: 'Дебет',
                    format: '{0:n2}',
                    attributes: { "class": "text-right" },
                    template: '#=kendo.toString(Debit, "n' + vm.fractionSize + '") #',
                    width: '120px'
                }, {
                    field: 'Kredit',
                    title: 'Кредит',
                    format: '{n:0}',
                    attributes: { "class": "text-right" },
                    template: '#=kendo.toString(Kredit, "n' + vm.fractionSize + '") #',
                    width: '120px'
                }, {
                    field: 'Purpose',
                    title: 'Призначення',
                    width: '200px'
                }, {
                    field: 'Date',
                    format: '{0:dd/MM/yyyy HH:mm:ss}',
                    exportFormat: "{0:dd/MM/yyyy HH:mm:ss}",
                    title: 'Дата надходження',
                    width: '150px',
                    filterable: {
                        ui: function (element) {
                            element.kendoDateTimePicker({
                                format: "{0:dd/MM/yyyy HH:mm:ss}"
                            });
                        }
                    }
                }, {
                    field: 'FactDate',
                    format: '{0:dd/MM/yyyy HH:mm:ss}',
                    exportFormat: "{0:dd/MM/yyyy HH:mm:ss}",
                    title: 'Фактична дата валютування',
                    width: '150px',
                    filterable: {
                        ui: function (element) {
                            element.kendoDateTimePicker({
                                format: "{0:dd/MM/yyyy HH:mm:ss}"
                            });
                        }
                    }
                }
            ]
        };
    }]);