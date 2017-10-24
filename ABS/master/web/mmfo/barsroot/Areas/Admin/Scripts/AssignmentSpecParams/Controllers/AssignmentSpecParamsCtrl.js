angular.module('BarsWeb.Controllers')
    .controller('AssignmentSpecParamsCtrl', ['assignmentSpecParamsService',
        function (assignmentSpecParamsService) {

            var vm = this;

            vm.model = {};
            vm.paramsToDelete = [];
            vm.paramsToAdd = [];
            vm.paramsToUpdate = [];

            vm.balanceAccountGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("Admin/AssignmentSpecParams/GetBalanceAccount"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            BalanceAccountNumber: { type: "string" },
                            BalanceAccountName: { type: "string" }
                        }
                    }
                }
            });

            vm.balanceAccountOptions = {
                autoBind: true,
                dataSource: vm.balanceAccountGridDataSource,
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: true,
                pageable: {
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 3,
                },
                dataBinding: function () {
                    vm.model.BalanceAccountNumber = "";
                    vm.selectedParametersGridDataSource.read({ parameterType: "selected", balanceAccountNumber: vm.model.BalanceAccountNumber });
                    vm.availableParametersGridDataSource.read({ parameterType: "available", balanceAccountNumber: vm.model.BalanceAccountNumber });
                    vm.selectedParametersGridDataSource.filter({});
                    vm.availableParametersGridDataSource.filter({});
                    vm.paramsToDelete = [];
                    vm.paramsToAdd = [];
                },
                columns: [
                    {
                        field: "BalanceAccountNumber",
                        title: "Номер балансового рахунку",
                        width: "30%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "BalanceAccountName",
                        title: "Найменування балансового рахунку",
                        width: "70%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    }
                ]
            };

            vm.selectedParametersGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                change: function () {
                    vm.paramsToDelete = [];
                },
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("Admin/AssignmentSpecParams/GetParameters"),
                        data: function () {
                            return {
                                parameterType: "selected",
                                balanceAccountNumber: vm.model.BalanceAccountNumber
                            };
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Code: { type: "string", editable: false },
                            ParameterName: { type: "string", editable: false },
                            RequiredParameter: { type: "string", editable: false },
                            SqlExpression: { type: "string" }
                        }
                    }
                }
            });

            vm.selectedParametersOptions = {
                autoBind: false,
                dataSource: vm.selectedParametersGridDataSource,
                sortable: true,
                filterable: true,
                resizable: true,
                editable: true,
                selectable: "multiple",
                save: function (e) {
                    vm.saveSelectedParameter(e);
                },
                dataBinding: function () {
                    vm.paramsToUpdate = [];
                },
                pageable: {
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 3,
                },
                columns: [
                    {
                        field: "Code",
                        title: "Код",
                        width: "15%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "ParameterName",
                        title: "Обрані параметри",
                        width: "35%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "RequiredParameter",
                        title: "Ознака <br> обов'язкового заповнення",
                        width: "20%",
                        headerAttributes: {
                            style: "text-align: center;"
                        },
                        template: function (data) {
                            if (data.RequiredParameter === '1') {
                                return "<div style='text-align: center;'>" +
                                            "<input ng-model='checkedRequiredParameter' type='checkbox'  ng-change='specParam.changeRequiredParameter(this)' ng-checked='true'></input>" +
                                       "</div>"
                            }
                            else {
                                return "<div style='text-align: center;'>" +
                                            "<input ng-model='checkedRequiredParameter' type='checkbox'  ng-change='specParam.changeRequiredParameter(this)'></input>" +
                                        "</div>"
                            }
                        }
                    },
                    {
                        field: "SqlExpression",
                        title: "SQL <br> вираз для значення за умовчанням",
                        width: "30%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    }
                ]
            };

            vm.availableParametersGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10,
                change: function () {
                    vm.paramsToAdd = [];
                },
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("Admin/AssignmentSpecParams/GetParameters"),
                        data: function () {
                            return {
                                parameterType: "available",
                                balanceAccountNumber: vm.model.BalanceAccountNumber
                            };
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Code: { type: "string" },
                            ParameterName: { type: "string" }
                        }
                    }
                }
            });

            vm.availableParametersOptions = {
                autoBind: false,
                dataSource: vm.availableParametersGridDataSource,
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "multiple",
                pageable: {
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 3,
                },
                columns: [
                    {
                        field: "Code",
                        title: "Код",
                        width: "20%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    },
                    {
                        field: "ParameterName",
                        title: "Доступні параметри",
                        width: "80%",
                        headerAttributes: {
                            style: "text-align: center;"
                        }
                    }
                ]
            };


            vm.changeBalanceAccountGrid = function (data) {
                vm.paramsToDelete = [];
                vm.paramsToAdd = [];
                vm.model.BalanceAccountNumber = data.BalanceAccountNumber;
                vm.selectedParametersGridDataSource.read({ parameterType: "selected", balanceAccountNumber: data.BalanceAccountNumber });
                vm.availableParametersGridDataSource.read({ parameterType: "available", balanceAccountNumber: data.BalanceAccountNumber });
                vm.selectedParametersGridDataSource.filter({});
                vm.availableParametersGridDataSource.filter({});
            }

            vm.changeRequiredParameter = function (element) {

                var isNewParameter = true;
                var requiredParameter = element.checkedRequiredParameter ? "1" : "0";

                for (var i = 0; i < vm.paramsToUpdate.length; i++) {

                    if (vm.paramsToUpdate[i].ParameterId === element.dataItem.ParameterId) {
                        vm.paramsToUpdate[i].RequiredParameter = requiredParameter;
                        isNewParameter = false;
                    } 

                }

                if (isNewParameter) {
                    var addParams = {
                        BalanceAccountNumber: vm.model.BalanceAccountNumber,
                        ParameterId: element.dataItem.ParameterId,
                        RequiredParameter: requiredParameter,
                        SqlExpression: element.dataItem.SqlExpression
                    };

                    vm.paramsToUpdate.push(addParams);
                }

            }


            vm.updateParemeters = function () {
                assignmentSpecParamsService.updateParemeters(vm.paramsToUpdate).then(
                       function (data) {
                           bars.ui.alert({ text: data.Message });
                           vm.selectedParametersGridDataSource.read({ parameterType: "selected", balanceAccountNumber: vm.model.BalanceAccountNumber });
                           vm.selectedParametersGridDataSource.filter({});
                           vm.paramsToUpdate = [];
                       },
                       function (data) {
                       }
                   );
            }

            vm.changeSelectedParametersGrid = function (data) {

                vm.paramsToDelete = [];

                for (var i = 0; i < data.length; i++) {

                    var addParams = {
                        BalanceAccountNumber: vm.model.BalanceAccountNumber,
                        ParameterId: data[i].ParameterId,
                        RequiredParameter: null,
                        SqlExpression: null
                    };

                    vm.paramsToDelete.push(addParams);
                }

            }

            vm.changeAvailableParametersGrid = function (data) {

                vm.paramsToAdd = [];

                for (var i = 0; i < data.length; i++) {

                    var addParams = {
                        BalanceAccountNumber: vm.model.BalanceAccountNumber,
                        ParameterId: data[i].ParameterId,
                        RequiredParameter: null,
                        SqlExpression: null
                    };

                    vm.paramsToAdd.push(addParams);
                }
            }

            vm.deleteParameters = function () {

                assignmentSpecParamsService.deleteParameters(vm.paramsToDelete).then(
                        function (data) {
                            bars.ui.alert({ text: data.Message });
                            vm.selectedParametersGridDataSource.read({ parameterType: "selected", balanceAccountNumber: vm.model.BalanceAccountNumber });
                            vm.availableParametersGridDataSource.read({ parameterType: "available", balanceAccountNumber: vm.model.BalanceAccountNumber });
                            vm.selectedParametersGridDataSource.filter({});
                            vm.availableParametersGridDataSource.filter({});
                            vm.paramsToDelete = [];
                        },
                        function (data) {
                        }
                    );
            }

            vm.addParameters = function () {

                assignmentSpecParamsService.addParameters(vm.paramsToAdd).then(
                        function (data) {
                            bars.ui.alert({ text: data.Message });
                            vm.selectedParametersGridDataSource.read({ parameterType: "selected", balanceAccountNumber: vm.model.BalanceAccountNumber });
                            vm.availableParametersGridDataSource.read({ parameterType: "available", balanceAccountNumber: vm.model.BalanceAccountNumber });
                            vm.selectedParametersGridDataSource.filter({});
                            vm.availableParametersGridDataSource.filter({});
                            vm.paramsToAdd = [];
                        },
                        function (data) {
                        }
                    );
            }

            vm.saveSelectedParameter = function (e) {

                var isNewParameter = true;

                for (var i = 0; i < vm.paramsToUpdate.length; i++) {

                    if (vm.paramsToUpdate[i].ParameterId === e.model.ParameterId) {
                        vm.paramsToUpdate[i].SqlExpression = e.values.SqlExpression;
                        isNewParameter = false;
                    }

                }

                if (isNewParameter) {
                    var addParams = {
                        BalanceAccountNumber: vm.model.BalanceAccountNumber,
                        ParameterId: e.model.ParameterId,
                        RequiredParameter: e.model.RequiredParameter,
                        SqlExpression: e.values.SqlExpression
                    };

                    vm.paramsToUpdate.push(addParams);
                }


            }

        }]);