angular.module('BarsWeb.Controllers').controller('Docs.Payments', ['$http', function ($http) {
    var vm = this;
    vm.Title = 'Перегляд документів';

    vm.Payment = {
        Id: null,
        LimitType: null,
        DeviationPercent: null,
        ViolationDeys: null,
        MaxLoadLimit: null,
        ViolationColor: '#FF0000',
        DateStart: new Date(1900, 0, 1),
        DateStop: new Date(1900, 0, 1),
        Mfo: null,
        DateSet: null,
        DateUpdate: null
    };

    var date = new Date();

    vm.PaymentsSearchParams = {
        dateStart: new Date(date.setHours(0, 0, 0)),
        dateEnd: new Date(date.setHours(0, 0, 0)),
        direction: 'out'
    }

    vm.dateStartOptions = {
        format: '{0:dd/MM/yyyy}'/*,
        mask: '00/00/0000',
        min: new Date(1900, 0, 1),
        change: function () {
            var thisDate = this.value();
            vm.dateEnd.min(thisDate);
            vm.dateEnd.max( new Date(thisDate.setMonth(thisDate.getMonth() + 1)));
        }*/
    }
    vm.dateEndOptions = {
        format: '{0:dd/MM/yyyy}'/*,
        min: new Date(1900, 0, 1),
        change: function () {
            var thisDate = this.value();
            vm.dateStart.max(thisDate);
            vm.dateStart.min(new Date(thisDate.setMonth(thisDate.getMonth() - 1)));
        }*/
    }

    vm.paymentsDirectionOptions = {
        dataSource:  [
                {
                    Value: 'out',
                    Text: 'Всі'
                }, {
                    Value: 'in',
                    Text: 'Отримані'
                }],
        dataTextField: "Text",
        dataValueField: "Value",
        select: vm.PaymentsSearchParams.direction
    };

    var dataSource = {
        url: bars.config.urlContent('/api/docs/payments/arcsbranchout'),
        get: function (id, func) {
            if (id) {
                $http.get(this.url + '?id=' + id)
                    .success(function (request) {
                        vm.treshold = request;
                        if (func) {
                            func.call();
                            //func.apply(null, [request]);
                        }
                    });
                return null;
            } else {
                return {
                    Id: null,
                    LimitType: "ATM",
                    DeviationPercent: null,
                    ViolationDeys: null,
                    MaxLoadLimit: null,
                    ViolationColor: '#FF0000',
                    DateStart: new Date(),
                    DateStop: new Date(),
                    Mfo: null,
                    DateSet: null,
                    DateUpdate: null
                }
            }
        },
        add: function (object, func) {
            $http.put(this.url, object)
                .success(function (request) {
                    if (func) {
                        func.apply(null, [request]);
                    }
                });
        },
        edit: function (object, func) {
            $http.post(this.url, object)
                .success(function (request) {
                    if (func) {
                        func.apply(null, [request]);
                    }
                });
        },
        remove: function (id, func) {
            $http({
                method: 'DELETE',
                url: this.url + '?id=' + id
            }).success(function (request) {
                if (func) {
                    func.apply(null, [request]);
                }
            });
        }
    }

    vm.SearchPayments = function() {
        vm.paymentsGrid.dataSource.read();
        //vm.paymentsGrid.refresh();
    }

    var paymentsGridDataBound = function (e) {
        var grid = e.sender;
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + grid.pager.options.messages.empty + ' :(</td></tr>');
        }
    };

    /*vm.toolbarOptions = {
        items: [
            {
                template: '<label>Період: </label>' +
                    ' з <input type="text" ng-model="PaymentsSearchDates.dateStart" kendo-date-picker="" k-options="dateOptions" />' +
                    ' по <input type="text" ng-model="PaymentsSearchDates.dateEnd" kendo-date-picker="" k-options="dateOptions" />'
            }, {
                type: 'separator'
            }, {
                template: '<label>Підрозділ: </label>'
            }
        ]
    };*/


    vm.paymentsGridToolbar = {
        items: [
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-add_button"></i>Створити',
                click: function () {
                    toolbarWindows.add();
                }
            },
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати',
                click: function () {
                    toolbarWindows.edit();
                }
            },
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i>Видалити',
                click: function () {
                    toolbarWindows.remove();
                }
            }
        ]
    }

    vm.paymentWindowOptions = {
        animation: false,
        visible: false,
        width: "650px",
        actions: ["Maximize", "Minimize", "Close"],
        draggable: true,
        height: "570px",
        modal: true,
        pinned: false,
        resizable: true,
        title: '',
        position: 'center',
        buttons: [
            {
                text: 'Відмінити',
                click: function () { this.close(); }
            },
            {
                text: '<span class="k-icon k-i-tick"></span> Ok',
                click: function () {
                    if (func) {
                        func.apply();
                        this.close();
                    }
                },
                cssClass: 'k-primary'
            }
        ],
        close: function () {
            //vm.advertising = vm.getNewAdvertising();
        },
        iframe: false
    };

    var toolbarWindows = {
        add: function () {
            vm.treshold = dataSource.get();
            vm.limitTypeDropDownList.enable();
            vm.$apply();
            vm.tresholdWindow.center().open();
        },
        edit: function () {
            var data = selectedRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для редагування' });
            } else {
                bars.ui.loader('#tresholdWindow', true);
                vm.treshold = dataSource.get();

                vm.limitTypeDropDownList.enable(false);

                dataSource.get(data.Id, function () {
                    vm.$apply();
                    bars.ui.loader('#tresholdWindow', false);
                });

                vm.tresholdWindow.center().open();
            }
        },
        remove: function () {
            var data = selectedRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для видалення' });
            } else {
                bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити параметр №' + data.Id },
                    function () {
                        dataSource.remove(data.Id, function () {
                            bars.ui.notify('Параметр № ' + data.Id + ' видалено', '', 'success');
                            vm.tresholdGrid.dataSource.read();
                            vm.tresholdGrid.refresh();
                        });
                    });
            }
        }
    };

    vm.saveTreshold = function () {
        /*if (vm.treshold.Id == null) {
            dataSource.add(vm.treshold, function (request) {
                bars.ui.notify('Параметр збережено. № ' + request.Id, '', 'success');
                vm.tresholdGrid.dataSource.read();
                vm.tresholdGrid.refresh();
                vm.tresholdWindow.close();
            });
        } else {
            dataSource.edit(vm.treshold, function () {
                bars.ui.notify('Параметр № ' + vm.treshold.Id + ' збережено.', '', 'success');
                vm.tresholdGrid.dataSource.read();
                vm.tresholdGrid.refresh();
                vm.tresholdWindow.close();
            });
        }*/
    }

    var selectedRow = function () {
        //return vm.tresholdGrid.dataItem(vm.tresholdGrid.select());
    };

    vm.paymentsGridOptions = {
        dataSource: {
            pageSize: 10,
            serverPaging: true,
            serverSorting: true,
            type: 'webapi',
            sort: {
                field: "DateSystem",
                dir: "desc"
            },
            transport: {
                read: {
                    url: dataSource.url,
                    dataType: 'json',
                    contentType: "application/json",
                    data: function () {
                        //console.log(vm.PaymentsSearchParams.dateStart);
                        return {
                            dateStart:  vm.PaymentsSearchParams.dateStart.toJSON(),
                            dateEnd: vm.PaymentsSearchParams.dateEnd.toJSON()
                        }
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        Id: {type: "number"},
                        Number: {type: "string"},
                        UserId: {type: "number"},
                        CurrencyId: {type: "number"},
                        Summa: {type: "number"},
                        SummaEquivalent: {type: "number"},
                        Status: {type: "number"},
                        Date: {type: "date"},
                        DateReceipt: {type: "date"},
                        DateSystem: {type: "date"},
                        DateCurrency: {type: "date"},
                        Purpose: {type: "string"},
                        TransactionType: {type: "string"},
                        DocumentType: {type: "number"},
                        SenderAccount: {type: "string"},
                        SenderMfo: {type: "string"},
                        SenderName: {type: "string"},
                        SenderCode: { type: "string" },
                        RecipientCurrencyId: {type: "number"},
                        RecipientSumma: {type: "number"},
                        RecipientAccount: {type: "string"},
                        RecipientMfo: {type: "string"},
                        RecipientName: {type: "string"},
                        RecipientCode: { type: "string" },
                        DebitKredit:{type: "number"},
                        Branch: {type: "string"},
                        FilialCode: {type: "string"}
                    }
                }
            }
        },
        columns: [
            {
                field: "Id",
                title: "Референс",
                width: "80px"
            },
            {
                field: "Number",
                title: "Номер",
                width: "80px"
            },
            {
                field: "UserId",
                title: "Користувач",
                width: "80px"
            },
            {
                field: "SenderAccount",
                title: "Рахунок<br>відправника",
                width: "120px"
            },
            {
                field: "Summa",
                title: "Сума",
                template: '#=kendo.toString(Summa/100,"0.00")#',
                format: "{0:n0}",
                attributes: { "class": "money" },
                width: "100px"
            },
            {
                field: "CurrencyId",
                title: "Код<br>валюти",
                width: "80px"
            },
            {
                field: "DateCurrency",
                title: "Дата<br>валютування",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            },
            {
                field: "RecipientSumma",
                title: "Сума<br>(B)",
                template: '#=kendo.toString(RecipientSumma/100,"0.00")#',
                format: "{0:n0}",
                attributes: { "class": "money" },
                width: "100px"
            },
            {
                field: "RecipientCurrencyId",
                title: "Bалюта<br>(B)",
                width: "80px"
            },
            {
                field: "RecipientMfo",
                title: "МФО<br>отримувача",
                width: "80px"
            },
            {
                field: "RecipientAccount",
                title: "Рахунок<br>отримувача",
                width: "120px"
            },
            {
                field: "DebitKredit",
                title: "Д/К",
                width: "80px"
            },

            {
                field: "Date",
                title: "Дата<br>документа",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            },
            {
                field: "Purpose",
                title: "Призначення",
                width: "250px",
                template: '#=Purpose.substring(0,30)#',
            },
            {
                field: "TransactionType",
                title: "Тип<br>транзакції",
                width: "80px"
            },
            {
                field: "Branch",
                title: "Бранч",
                width: "180px"
            }
            
            /*,

            
            {
                field: "SummaEquivalent",
                title: "Сума в еквіваленті",
                template: '#=kendo.toString(SummaEquivalent/100,"0.00")#',
                format: "{0:n0}",
                attributes: { "class": "money" },
                width: "100px"
            },
            {
                field: "Status",
                title: "Статус",
                width: "80px"
            },
            {
                field: "DateReceipt",
                title: "Дата поступлення",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            },
            {
                field: "DateSystem",
                title: "Дата системна",
                format: '{0:dd/MM/yyyy HH:mm}',
                width: "120px"
            },
            {
                field: "DocumentType",
                title: "Вид документа",
                width: "80px"
            },
            {
                field: "SenderMfo",
                title: "МФО відправника",
                width: "80px"
            },
            {
                field: "SenderName",
                title: "Назва відправника",
                width: "80px"
            },
            {
                field: "SenderCode",
                title: "ЄДРПО відправника",
                width: "80px"
            },
            {
                field: "RecipientName",
                title: "Назва отримувача",
                width: "80px"
            },
            {
                field: "RecipientCode",
                title: "ЄДРПО отримувача",
                width: "80px"
            },
            {
                field: "FilialCode",
                title: "Код філії",
                width: "80px"
            }*/
        ],
        //detailTemplate: "<div>Name: #: name #</div><div>Age: #: age #</div>",
        autoBind:false,
        dataBound: paymentsGridDataBound,
        sortable: true,
        filterable: true,
        resizable: true,
        selectable: "multiple",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        }
    };

}]);