angular.module('BarsWeb.Areas')
    .controller('Acct.ReservedAccountsCtrl', ['$scope', '$http', function ($scope, $http) {
        var vm = this;
        var apiUrl = bars.config.urlContent('/api/v1/acct/ReservedAccounts/');
        var exception = "";
        var getSelectedItem = function () {
            return vm.resAcctGrid.dataItem(vm.resAcctGrid.select());
        };

        vm.viewCustomer = function (RNK) {
            if (RNK != null && RNK !== "null") {
                window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=1&rnk=" + RNK), null,
                    "height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
            }
            else { bars.ui.error({ title: 'Помилка', text: "Неправильний ПІБ клієнта!" }); }
        };

        vm.viewAcc = function (ACC, RNK) {
            if (ACC != null && ACC !== "null") {
                window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + ACC + "&rnk=" + RNK + "&accessmode=1"), null,
                    "height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
            }
            else { bars.ui.error({ title: 'Помилка', text: "Неправильний рахунок клієнта!" }); }
        };

        $scope.openReservedAcc = function (confirm) {
            $scope.winConfirmOpen.close();
            bars.ui.loader('body', true);
            $http({
                method: 'DELETE',
                url: apiUrl + '?id=' + vm.id_edit
            }).success(function () {
                vm.opened = true;
                bars.ui.loader('body', false);
                bars.ui.notify('Рахунок відкрито', '', 'success');
                vm.resAcctGrid.dataSource.read();
                vm.resAcctGrid.refresh();
                if (confirm === 0)
                {
                    angular.element("#conf").text("Редагувати?")
                    angular.element("#winConfirm").data("kendoWindow").center().open();
                }
            }).error(function (data) {
                vm.opened = false;
                bars.ui.loader('body', false);
                exception = data.ExceptionMessage;
                angular.element("body > div.k-widget.k-window.with-footer > div.k-content.k-window-footer > button").click(function () {
                    if (exception.indexOf("необхідно заповнити") > 0) {
                        angular.element("#conf").text(exception + "\n Редагувати?")
                        angular.element("#winConfirm").data("kendoWindow").center().open();
                    }
                });
            });
        };
        



        var openReservedAccDialog = function () {
            var data = getSelectedItem();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рахунку' });
            } else {
                vm.id_edit = data.Id;
                vm.rnk_edit = data.CustomerId;
                bars.ui.confirm(
                    {
                        text: 'Перевести рахунок <b>' + data.Number + '</b>(валюта ' + data.CurrencyId + ') ' +
                             'клієнта <b> ' + data.CustomerName + '</b>, в статус "відкритий"?'
                    },
                    function () {
                        $scope.winConfirmOpen.center().open();
                    }
                );
            }
        }

        vm.showDelete = function () {
            bars.ui.confirm(
                    {
                        text: 'Ви <b>дійсно впевнені</b> що хочете <b>видалити</b> зарезервований рахунок?<br>' +
                              'Разунок може видалятися у разі його <b>помилкового резервування працівником фронт офісу</b>, або у разі <b>відмови клієнта від обслуговлювання</b>'
                    },
                    function () {
                        debugger;
                        bars.ui.loader('body', true);
                        $http({
                            method: 'GET',
                            url: bars.config.urlContent("/api/bpkw4/accentacc/denyaccepraccount") + '?acc=' + getSelectedItem().Id
                        }).success(function () {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Рахунок відхилено', '', 'success');
                            vm.resAcctGrid.dataSource.read();
                            vm.resAcctGrid.refresh();
                        }).error(function () {
                            bars.ui.loader('body', false);
                        });
                    }
                );
        };

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
                },
                {
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Відхилити',
                    click: function () {
                        //$scope.showDelete();
                        vm.showDelete();
                    }
                }
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
                    template: '<a href="." ng-click="resAcctCtrl.viewAcc(#=Id#, #=CustomerId#)" style="color: blue" onclick="return false;">#= Number #</a>',
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

        $scope.OnCloseCoonfWin = function () {
            $("#winConfirm").data("kendoWindow").close();
        }

        $scope.OpenAccCard = function (type) {
            $scope.OnCloseCoonfWin();
            if (type === 1)
            {
                bars.ui.dialog({
                    content: encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + vm.rnk_edit),
                    iframe: true,
                    width: document.documentElement.offsetWidth * 0.8,
                    height: document.documentElement.offsetHeight * 0.8,
                    close: function () {
                        if (!vm.opened)
                            openReservedAccDialog();
                    }
                });
            }
            else
            {
                bars.ui.dialog({
                    content: encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + vm.id_edit + "&rnk=" + vm.rnk_edit + "&accessmode=1"),
                    iframe: true,
                    width: document.documentElement.offsetWidth * 0.8,
                    height: document.documentElement.offsetHeight * 0.8,
                    close: function () {
                        if (!vm.opened)
                            openReservedAccDialog();
                    }
                });
            }
        }
    }]);