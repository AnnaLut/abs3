angular.module('BarsWeb.Controllers', [])
.controller('PCCtrl', ['$scope', function ($scope) {
    var selected_date_from = kendo.toString(kendo.parseDate(new Date(), 'yyyy-MM-dd'), 'dd/MM/yyyy') + " 00:00:00",
        selected_date_to = kendo.toString(kendo.parseDate(new Date(), 'yyyy-MM-dd'), 'dd/MM/yyyy') + " 23:59:59",
        obj_selected_date_from,
        obj_selected_date_to,
        selected_operation = "";

    obj_selected_date_from = angular.element("#select_date_from").kendoDatePicker({
        value: selected_date_from,
        format: "dd/MM/yyyy",
        change: function (e) {
            selected_date_from = angular.element("#select_date_from").val() + " 00:00:00";
            console.log(selected_date_from);
        }
    }).data("kendoDatePicker");;

    obj_selected_date_to = angular.element("#select_date_to").kendoDatePicker({
        value: selected_date_to,
        format: "dd/MM/yyyy",
        change: function (e) {
            selected_date_to = angular.element("#select_date_to").val() + " 23:59:59";
            console.log(selected_date_to);
        }
    }).data("kendoDatePicker");;

    $scope.validator = $("#dates_period").kendoValidator().data("kendoValidator");

    angular.element("#dates_period").kendoValidator({
        messages: {
            datestart: "Стартова дата більша",

            dateend: "Стартова дата більша",

            required: "Поле обов'язкове!"
        },
        rules: {
            dateend: function (input) {
                var date = $("#select_date_from").val();
                if (input.is("[name=select_date_to]") && date != null) {
                    if (input.val() < date) {
                        return false;
                    }
                }
                return true;
            },
            datestart: function (input) {
                var date = $("#select_date_to").val();
                if (input.is("[name=select_date_from]") && date != null) {
                    if (input.val() > date) {
                        return false;
                    }
                }
                return true;
            }

        }
    });

    function startChange() {
        var startDate = obj_selected_date_from.value(),
        endDate = obj_selected_date_to.value();

        if (startDate) {
            startDate = new Date(startDate);
            startDate.setDate(startDate.getDate());
            obj_selected_date_to.min(startDate);
        } else if (endDate) {
            obj_selected_date_from.max(new Date(endDate));
        } else {
            endDate = new Date();
            obj_selected_date_from.max(endDate);
            obj_selected_date_to.min(endDate);
        }
    }

    function endChange() {
        var endDate = obj_selected_date_to.value(),
        startDate = obj_selected_date_from.value();

        if (endDate) {
            endDate = new Date(endDate);
            endDate.setDate(endDate.getDate());
            obj_selected_date_from.max(endDate);
        } else if (startDate) {
            obj_selected_date_to.min(new Date(startDate));
        } else {
            endDate = new Date();
            obj_selected_date_from.max(endDate);
            obj_selected_date_to.min(endDate);
        }
    }

    obj_selected_date_from.max(obj_selected_date_to.value());
    obj_selected_date_to.min(obj_selected_date_from.value());

    $scope.operationsOptions = {
        dataSource: {
            transport: {                       
                read: {
                    url: bars.config.urlContent("/api/pc/pcapi/getoperations")
                }
            }
        },
        dataTextField: "NAME",
        dataValueField: "ID",
        optionLabel: "--Оберіть операцію--",
        select: function (e) {
            selected_operation = this.dataItem(e.item).ID;
        }
    };

    $scope.mainGridOptions = {
        autoBind: false,
        dataSource: {
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pc/pcapi/GetGridData"),
                    data: function () {
                        return { date_from: selected_date_from, date_to: selected_date_to }
                    }
                }
            },
            pageSize: 15,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        FILE_NAME: { type: 'string' },
                        FILE_DATE: { type: 'date' },
                        FILE_N: { type: 'number' }
                    }
                }
            }

        },
        selectable: "row",
        columns: [
            {
                field: "FILE_NAME",
                title: "Ім'я файлу",
                width: "200px"
            },
            {
                field: "FILE_DATE",
                title: "Дата файлу",
                template: "#= kendo.toString(kendo.parseDate(FILE_DATE, 'yyyy-MM-dd HH:mm:ss'), 'dd/MM/yyyy HH:mm:ss') #",
                width: "100px"
            },
            {
                field: "FILE_N",
                title: "Кількість",
                width: "100px"
            }
        ],
        dataBound: function () {
        },
        srollable: true,
        pageable: true,
        filterable: true,
        sortable: true
    }

    $scope.RunSelectedProcedure = function () {
        if (selected_operation !== "") {
            $.ajax({
                url: bars.config.urlContent("/api/pc/pcapi/RunSelectedProcedure") + "?id=" + selected_operation,
                method: "GET",
                dataType: "json",
                async: false,
                success: function (data) {
                    bars.ui.success({ text: data });
                    if (data === "Файли успішно сформовано.")
                    {
                        grid = angular.element("#mainGrid").data("kendoGrid");
                        selected_date_from = new Date();
                        selected_date_from.setHours(0, 0, 0, 0);
                        obj_selected_date_from.value(selected_date_from);

                        selected_date_to = new Date();
                        selected_date_to.setHours(23, 59, 59, 999);
                        obj_selected_date_to.value(selected_date_to);
                        grid.dataSource.read();
                    }
                }
            });
        }
        else
            bars.ui.error({ text: "Оберіть спочатку операцію"});
    }

    $scope.SearchGridData = function()
    {
        grid = angular.element("#mainGrid").data("kendoGrid");
        grid.dataSource.read();
    }
}]);