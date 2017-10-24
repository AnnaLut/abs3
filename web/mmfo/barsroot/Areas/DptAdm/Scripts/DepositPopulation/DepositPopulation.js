angular.module('BarsWeb.Controllers', [])
.controller('DepositPopulation', ['$scope', '$http', function ($scope, $http) {
    var columns_width = "200px";

    $scope.global_count = 0;

    $scope.date_grid_start = new Date();
    $scope.date_grid_end = new Date();

    var datafor = [
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        },
        {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        }, {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        }
        , {
            KOD_DEP: "TEST",
            NAME_DEP: "TEST",
            FIO_PER: "TEST",
            TYPE_DEP: "TEST",
            KOD_VAL: "TEST",
            BAL_COUNT: "TEST",
            S_DEP_START: "TEST",
            MID_STAV_START: "TEST",
            S_DT_OBR: "TEST",
            S_KT_OBR: "TEST",
            MID_STAV_END: "TEST",
            S_DEP_END: "TEST",
            S_NACH_START: "TEST",
            S_DT_NACH: "TEST",
            S_KT_NACH: "TEST",
            S_NACH_END: "TEST",
            COUNT_AMOUNT_START: "TEST",
            COUNTS_OPENED: "TEST",
            COUNTS_CLOSED: "TEST",
            COUNTS_AMOUNT_END: "TEST",
        }
    ];

    $scope.validator = $("#dates_period").kendoValidator().data("kendoValidator");

    angular.element("#dates_period").kendoValidator({
        messages: {
            datestart: "Стартова дата більша",

            dateend: "Стартова дата більша",

            required: "Поле обов'язкове!"
        },
        rules: {
            dateend: function (input) {
                var date = $("#start").val();
                console.log(date);
                if (input.is("[name=end]") && date != null) {
                    if (input.val() < date) {
                        return false;
                    }
                }
                return true;
            },
            datestart: function (input) {
                var date = $("#end").val();
                console.log("START");
                if (input.is("[name=start]") && date != null) {
                    if (input.val() > date) {
                        return false;
                    }
                }
                return true;
            }

        }
    });

    function startChange() {
        var startDate = start.value(),
        endDate = end.value();

        if (startDate) {
            startDate = new Date(startDate);
            startDate.setDate(startDate.getDate());
            end.min(startDate);
        } else if (endDate) {
            start.max(new Date(endDate));
        } else {
            endDate = new Date();
            start.max(endDate);
            end.min(endDate);
        }
    }

    function endChange() {
        var endDate = end.value(),
        startDate = start.value();

        if (endDate) {
            endDate = new Date(endDate);
            endDate.setDate(endDate.getDate());
            start.max(endDate);
        } else if (startDate) {
            end.min(new Date(startDate));
        } else {
            endDate = new Date();
            start.max(endDate);
            end.min(endDate);
        }
    }

    var start = $("#start").kendoDatePicker({
        value: new Date(),
        change: startChange,
        format: 'dd/MM/yyyy',
        footer: "Today - #: kendo.toString(data, 'd') #"
    }).data("kendoDatePicker");

    var end = $("#end").kendoDatePicker({
        value: new Date(),
        change: endChange,
        format: 'dd/MM/yyyy',
        footer: "Today - #: kendo.toString(data, 'd') #"
    }).data("kendoDatePicker");

    start.max(end.value());
    end.min(start.value());


    $scope.DepositPopulationGridOptions = {
        dataSource:
            {
                data: datafor
            },
        selectable: "multiple",
        columns: [],
        height: 350,
        dataBound: function dataBound(e) {
            if (this.dataSource.view().length == 0) {

                var colspan = this.thead.find("th").length;
                var emptyRow = "<tr><td colspan='" + colspan + "'></td></tr>";
                this.tbody.html(emptyRow);

                this.table.width;
                $(".k-grid-content").height(18.9 * kendo.support.scrollbar());
            }
        },
        width: 1000
    }

    $scope.DepositPopulationGrid1Options = {
        dataSource: {
            data: [
            {
                ORDER: "",
                INCISION: "Виконавець",
                CHECK: false
            },
            {
                ORDER: "",
                INCISION: "Баланс рахунку",
                CHECK: false
            },
            {
                ORDER: "",
                INCISION: "Валюта",
                CHECK: false
            },
            {
                ORDER: "",
                INCISION: "Вид депозиту",
                CHECK: false
            },
            {
                ORDER: "",
                INCISION: "Орган",
                CHECK: false
            }
            ],
            schema:
                {
                    model: {
                        fields: {
                            ORDER: { type: "number" },
                            INCISION: { type: "string" },
                            CHECK: { type: "boolen" }
                        }
                    }
                },

        },
        columns: [
                {
                    field: "ORDER",
                    title: "Порядок",
                    width: "100px"
                },
                {
                    field: "INCISION",
                    title: "Розріз",
                    width: "100px"
                },
                {
                    field: "CHECK",
                    template: "<div align=center><input type='checkbox' id='check' ng-click='isSelected(dataItem)' class='sel'/></div>",
                    title: "Відмітити",
                    width: "100px"
                },
        ],
        height: 150,
        srollable: false
    };

    $scope.isSelected = function (dataItem) {
        var gridElement = angular.element("#DepositPopulationGrid1").data("kendoGrid");
        if (dataItem.CHECK === false) {
            $scope.global_count += 1;
            dataItem.ORDER = $scope.global_count;
            dataItem.CHECK = true;
        }
        else {
            $scope.global_count -= 1;
            $scope.GetAllOrders(dataItem.ORDER);
            dataItem.ORDER = "";
            dataItem.CHECK = false;
        }
    };


    $scope.GetAllOrders = function (current_order) {
        var gridElement = angular.element("#DepositPopulationGrid1").data("kendoGrid");
        var gridData = gridElement.dataSource.data();

        for (var i = 0; i < gridData.length; i++) {
            if (gridData[i].ORDER > current_order)
                gridData[i].ORDER -= 1;
        }
    };

    $scope.DepositPopulationGridOptions.columns = [
                {
                    field: "KOD_DEP",
                    title: "Код органу",
                    width: "200px"
                },
                {
                    field: "NAME_DEP",
                    title: "Назва органу",
                    width: "200px"
                },
                {
                    field: "FIO_PER",
                    title: "ФІО виконавця",
                    width: "200px"
                },
                {
                    field: "TYPE_DEP",
                    title: "Вид дипозиту",
                    width: "200px"
                },
                {
                    field: "KOD_VAL",
                    title: "Код ВАЛ",
                    width: "200px"
                },
                {
                    field: "BAL_COUNT",
                    title: "Баланс рахунку",
                    width: "200px"
                },
                {
                    field: "S_DEP_START",
                    title: "Сума дипозиту на початок",
                    width: "200px"
                },
                {
                    field: "MID_STAV_START",
                    title: "Середньовзв. ставка на початок",
                    width: "220px"
                },
                {
                    field: "S_DT_OBR",
                    title: "Сума Дт оборотів по вкладах",
                    width: "200px"
                },
                {
                    field: "S_KT_OBR",
                    title: "Сума Кт оборотів по вкладах",
                    width: "200px"
                },
                {
                    field: "MID_STAV_END",
                    title: "Середньовзв. ставка на кінець",
                    width: "200px"
                },
                {
                    field: "S_DEP_END",
                    title: "Сума дипозиту на кінець",
                    width: "200px"
                },
                {
                    field: "S_NACH_START",
                    title: "Сума начисл. %% на початок",
                    width: "200px"
                },
                {
                    field: "S_DT_NACH",
                    title: "Сума Дт оборотів по начисл. %%",
                    width: "200px"
                },
                {
                    field: "S_KT_NACH",
                    title: "Сума Кт оборотів по начисл. %%",
                    width: "200px"
                },
                {
                    field: "S_NACH_END",
                    title: "Сума начисл. %% на кінець",
                    width: "200px"
                },
                {
                    field: "COUNT_AMOUNT_START",
                    title: "Кількість рахунків на початок",
                    width: "200px"
                },
                {
                    field: "COUNTS_OPENED",
                    title: "Відкрито рахунків",
                    width: "200px"
                },
                {
                    field: "COUNTS_CLOSED",
                    title: "Закрито рахунків",
                    width: "200px"
                },
                {
                    field: "COUNTS_AMOUNT_END",
                    title: "Кількість рахунків на кінець",
                    width: "200px"
                },
    ];



}]);