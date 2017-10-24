﻿angular.module('BarsWeb.Areas')
    .controller('Acct.ReservedAccountsCtrl', ['$scope', '$http', function ($scope, $http) {
        var vm = this;
        debugger;
        var apiUrl = bars.config.urlContent('/api/v1/acct/ReservedAccounts/');

        var getSelectedItem = function () {
            return vm.resAcctGrid.dataItem(vm.resAcctGrid.select());
        };

        vm.viewCustomer = function (RNK) {
            if(RNK != null && RNK !== "null"){
                window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + RNK),null,
                    "height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
            }
            else{ bars.ui.error({ title: 'Помилка', text: "Неправильний ПІБ клієнта!" }); }
        };
        
        vm.viewAcc = function (ACC) {
            if(ACC != null && ACC !== "null"){
                window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + ACC + "&rnk=&accessmode=1"),null,
                    "height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
            }
            else{ bars.ui.error({ title: 'Помилка', text: "Неправильний рахунок клієнта!" }); }
        };

        var openReservedAcc = function (id) {
            bars.ui.loader('body', true);
            $http({
                method: 'DELETE',
                url: apiUrl + '?id=' + id
            }).success(function () {
                bars.ui.loader('body', false);
                bars.ui.notify('Рахунок відкрито', '', 'success');
                vm.resAcctGrid.dataSource.read();
                vm.resAcctGrid.refresh();
            }).error(function() {
                bars.ui.loader('body', false);
            });
        };

        var openReservedAccDialog = function () {
            var data = getSelectedItem();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рахунку' });
            } else {
                bars.ui.confirm(
                    {
                        text: 'Перевести рахунок <b>' + data.Number + '</b>(валюта ' + data.CurrencyId + ') ' + 
                             'клієнта <b> ' + data.CustomerName + '</b>, в статус "відкритий"?'
                    },
                    function () {
                        openReservedAcc(data.Id);
                    }
                );
            }
        }

        vm.toolbarOptions = {
            items: [
                {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-add_button"></i> Відкрити',
                    click: function () {
                        openReservedAccDialog();
                    }
                },
                {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-folder_open"></i> Картка рахунку',
                    click: function () {
                        debugger;
                        var formUrl = bars.config.urlContent("/viewaccounts/accountform.aspx?type=2&acc=" + getSelectedItem().Id + "&rnk=&accessmode=0");
                        bars.ui.dialog({
                            content: formUrl,
                            iframe: true,
                            width: '90%',
                            height: '80%',
                        });
                        
                    }
                }
                /*,
                {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Видалити',
                    click: function () {
                        //$scope.showDelete();
                    }
                }*/
            ]
        };

        vm.resAcctGridOptions = {
            height: 100,
            autoBind: true,
            selectable: 'single',
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
                if (e.sender.dataSource.total() === 0) {
                    var colCount = e.sender.columns.length;
                    $(e.sender.wrapper)
                        .find('tbody')
                        .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' :(</td></tr>');
                }
                var grid = this;
                grid.element.height("auto");
                grid.element.find(".k-grid-content").height("auto");
                kendo.resize(grid.element);
            },
            dataSource: {
                type: 'webapi',
                pageSize: 20,
                page: 1,
                total: 0,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                sort: {
                    field: "Id",
                    dir: "desc"
                },
                transport: {
                    dataType: 'json',
                    type: 'GET',
                    read: apiUrl
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        fields: {
                            Id: { type: "number", editable: false },
                            Number: { type: "string", editable: false },
                            CurrencyId: { type: "number", editable: false },
                            Name: { type: "string", editable: false },
                            IsOpen: { type: "boolean", editable: false },
                            CustomerId: { type: "number", editable: false },
                            CustomerCode: { type: "string", editable: false },
                            CustomerName: { type: "string", editable: false }
                        }
                    }
                }
            },
            columns: [
                {
                    field: 'Id',
                    title: 'Ід',
                    width: '100px',
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }, {
                    template: '<a href="." ng-click="resAcctCtrl.viewAcc(#=Id#)" style="color: blue" onclick="return false;">#= Number #</a>',
                    field: 'Number',
                    title: 'Номер',
                    width: '120px'
                }, {
                    field: 'CurrencyId',
                    title: 'Валюта',
                    width: '70px',
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }, {
                    field: 'Name',
                    title: 'Назва',
                    width: '250px',
                    template: '<span title="#=Name#">#=Name#</span>'
                }, {
                    field: 'CustomerId',
                    template: '<a href="." ng-click="resAcctCtrl.viewCustomer(#=CustomerId#)" style="color: blue" onclick="return false;">#= CustomerId #</a>',
                    title: 'Ід клієнта',
                    width: '100px',
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }, {
                    field: 'CustomerCode',
                    title: 'ЄДРПО',
                    width: '100px'
                }, {
                    field: 'CustomerName',
                    title: 'Назва клієнта',
                    width: '250px',
                    template: '<span title="#=CustomerName#">#=CustomerName#</span>'
                }
            ]
        }

    }]);