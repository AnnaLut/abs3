angular.module('BarsWeb.Controllers', [])
.controller('InterestRatesCtrl', ['$scope', function ($scope) {
    var brid = null;
    var brtype = null;
    var branch = "";
    $scope.branch_text = "";
    var inArchive = false;
    var bankdate = "";
    var action = "";
    $scope.Init = function () {
        ddbranches = $scope.AjaxGetFunction(bars.config.urlContent("/api/baserates/baseratesapi/getddbranches"));

        angular.element("#ddBranch").kendoDropDownList({
            dataTextField: "TEXT",
            dataValueField: "VALUE",
            dataSource: ddbranches,
            change: function () {
                branch = angular.element("#ddBranch").val();
                if (branch === "-") {
                    angular.element("#interestRateGrid").data("kendoGrid").showColumn("BRANCH");
                    angular.element("#interestRateGrid").data("kendoGrid").showColumn("BRANCH_NAME");
                }
                else {
                    angular.element("#interestRateGrid").data("kendoGrid").hideColumn("BRANCH");
                    angular.element("#interestRateGrid").data("kendoGrid").hideColumn("BRANCH_NAME");
                }
                if (brid !== "" && brtype !== "") {
                    angular.element("#interestRateGrid").data("kendoGrid").dataSource.read();
                }
            }
        });
        branch = angular.element("#ddBranch").val();

        angular.element("#addRate_KF_DD").kendoDropDownList({
            dataTextField: "TEXT",
            dataValueField: "VALUE",
            dataSource: {},
            change: function () {
                angular.element("#addRate_KF_NUM").val(angular.element("#addRate_KF_DD").val());
            }
        });

        angular.element("#addBaseRate_BRTYPE_NAME").kendoDropDownList({
            dataTextField: "TEXT",
            dataValueField: "VALUE",
            dataSource: {},
            change: function () {
                angular.element("#addBaseRate_BRTYPE").val(angular.element("#addBaseRate_BRTYPE_NAME").val());
            }
        });

        angular.element("#addBaseRate_ACTIVE").kendoDropDownList({
            dataTextField: "TEXT",
            dataValueField: "VALUE",
            dataSource:
                [
                    {
                        TEXT: "Діюча",
                        VALUE: 1
                    },
                    {
                        TEXT: "Недіюча",
                        VALUE: 0
                    }
                ]
        })
        bankdate = $scope.AjaxGetFunction(bars.config.urlContent("/api/baserates/baseratesapi/getbankdate"));
    }

    $scope.AjaxGetFunction = function (url) {
        data_req = null;
        $.ajax({
            url: url,
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        data_req = data;
                    }
        });
        return data_req;
    };

    $scope.Archive = function () {
        inArchive = !inArchive;
        if (inArchive)
            $scope.archive_text = "(Архів)";
        else
            $scope.archive_text = "";
        if (brid !== "" && brtype !== "") {
            angular.element("#interestRateGrid").data("kendoGrid").dataSource.read();
        }
    }

    var columns = [
            {
                field: "IDROW",
                title: "ID",
                hidden: true
            },
            {
                field: "DATB",
                title: "Дата",
                template: "#= kendo.toString(kendo.parseDate(DATB, 'yyyy/MM/dd'), 'dd/MM/yyyy') #"
            },
            {
                title: "Валюта",
                field: "KV"
            },
            {
                title: "Ставка",
                field: "IR",
                format: "{0:n2}",
                attributes: { style: "text-align:right;" }
            },
            {
                title: "Сума",
                field: "S",
                hidden: true,
                format: "{0:n2}",
                attributes: { style: "text-align:right;" }
            },
            {
                title: "!!!",
                field: "S_STRING",
                hidden: true,
            },
            {
                title: "Код<br>відділення",
                field: "BRANCH",
                hidden: true
            },
            {
                title: "Назва<br>відділення",
                field: "BRANCH_NAME",
                hidden: true
            }
    ];

    $scope.SelectBaseRate = function () {
        angular.element("#baseRateGrid").data("kendoGrid").dataSource.filter([]);
        angular.element("#baseRateGrid").data("kendoGrid").dataSource.sort({});
        angular.element("#baseRateGrid").data("kendoGrid").dataSource.data([]);
        angular.element("#baseRateGrid").data("kendoGrid").dataSource.read();
        $('#baseRWin').parent().css("top", "10%");
        $('#baseRWin').parent().css("left", "30%");
        $scope.baseRateWin.open();
    };

    $scope.interestRateGridOptions = {
        autoBind: false,
        columns: columns,
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/baserates/baseratesapi/getinterestrates"),
                    data: function () {
                        return { branch: branch, inarchive: inArchive, brtype: brtype, brid: brid };
                    }
                }
            },
            serverPaging: true,
            serverFiltering: true,
            serverSortering: true,
            pageSize: 15,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        DATB: {
                            type: 'date'
                        },
                        KV: {
                            type: 'number'
                        },
                        RATE: {
                            type: 'number'
                        },
                        S: {
                            type: 'number'
                        },
                        S_STRING: {
                            type: 'string'
                        }
                    }
                }
            }
        },
        dataBound: function () {
            if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8)//ступенчатая
                angular.element("#interestRateGrid").data("kendoGrid").showColumn("S");
            else//нормальная
                angular.element("#interestRateGrid").data("kendoGrid").hideColumn("S");
        },
        sortable: true,
        pageable: true,
        filterable: true,
        selectable: "row"
    };

    $scope.baseRateGridOptions = {
        autoBind: false,
        dataSource: {
            type: "webapi",
            transport: {
                read: {
                    url: bars.config.urlContent('/api/baserates/baseratesapi/GetBRates')
                }
            },
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        BR_ID: { type: "number" },
                        BR_NAME: { type: "string" },
                        TYPE_ID: { type: "number" },
                        TYPE_NAME: { type: "string" },
                        INUSE: { type: "number" }
                    }
                }
            },
            pageSize: 10
        },
        dataBound: function (e) {

        },
        dataBinding: function () {

        },
        change: function (e) {

        },
        autoBind: true,
        selectable: 'single',
        groupable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        resizable: true,
        reorderable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSizes: [5, 10, 20, 50],
            buttonCount: 5
        },
        columns: [
            {
                field: "BR_ID",
                title: "Код ставки",
                width: 80,
                attributes: { style: "text-align:center;" }
            },
            {
                field: "BR_NAME",
                title: "Назва базової ставки",
                width: 100,
                attributes: { style: "text-align:center;" }
            },
            {
                field: "TYPE_ID",
                title: "Тип ставки",
                width: 75,
                attributes: { style: "text-align:center;" }
            },
            {
                field: "TYPE_NAME",
                title: "Назва типу ставки",
                width: 100,
                attributes: { style: "text-align:center;" }
            },
            {
                field: "INUSE",
                title: "Діюча/Недіюча",
                width: 70,
                attributes: { style: "text-align:center;" }
            }
        ]
    };

    $("#baseRateGrid").on("dblclick", "tr.k-state-selected", function (e) {
        grid = $("#baseRateGrid").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        angular.element("#tbBRID").val(selectedItem.BR_ID);
        angular.element("#tbBRNAME").val(selectedItem.BR_NAME);
        brid = selectedItem.BR_ID;
        brtype = selectedItem.TYPE_ID;
        $scope.baseRateWin.close();
        angular.element("#interestRateGrid").data("kendoGrid").dataSource.read();
    });

    $scope.onCloseBaseRates = function () {
        grid = $("#baseRateGrid").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        if (selectedItem === null) {
            angular.element("#interestRateGrid").data("kendoGrid").dataSource.data([]);
            angular.element("#tbBRID").val("");
            angular.element("#tbBRNAME").val("");
            brid = null;
            brtype = null;
        }
    }

    $scope.AddInterestBrate = function () {
        if (angular.element("#tbBRNAME").val() !== "") {
            action = "insert";
            kvs = $scope.AjaxGetFunction(bars.config.urlContent("/api/baserates/baseratesapi/getkvs"));
            //angular.element("#old_rate").hide();
            angular.element("#addRate_KF_DD").data("kendoDropDownList").enable(true);
            angular.element("#addRate_KF_NUM").removeAttr("disabled", "disabled");
            angular.element("#addRate_DATE").removeAttr("disabled", "disabled");
            angular.element("#addRate_KF_DD").data("kendoDropDownList").dataSource.data(kvs);
            angular.element("#addRate_KF_DD").data("kendoDropDownList").value(980);
            angular.element("#addRate_KF_NUM").val(980);
            $scope.branch_text = angular.element("#ddBranch").data("kendoDropDownList").text();
            angular.element("#addRate_tbBRNAME").val(angular.element("#tbBRNAME").val());
            angular.element("#addRate_DATE").val(bankdate);
			angular.element("#addRate_DATE").data("kendoDatePicker").enable(true);
            if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8) {
                angular.element("#addRate_RATE").val(0);
                angular.element("#new_rate").hide();
                angular.element("#rateOptionsAddGrid").show();
                angular.element("#rateOptionsEditGrid").hide();
                angular.element("#addRate_add_row").show();
                angular.element("#addRate_delete_row").show();
                angular.element("#rateOptionsAddGrid").data("kendoGrid").dataSource.data([]);
                //angular.element("#rateOptionsAddGrid").data("kendoGrid").hideColumn("OLD_RATE");
            }
            else {
                angular.element("#rateOptionsAddGrid").hide();
                angular.element("#rateOptionsEditGrid").hide();
                angular.element("#addRate_add_row").hide();
                angular.element("#addRate_delete_row").hide();
                angular.element("#addRate_RATE").val(0);
                angular.element("#new_rate").show();
            }
            $scope.addInterestBrateWin.center().open();
        }
        else
            bars.ui.alert({ text: "Оберіть базову ставку." });
    }

    $("#addRate_KF_NUM").focusout(function () {
        angular.element("#addRate_KF_DD").data("kendoDropDownList").value(angular.element("#addRate_KF_NUM").val());
    })

    angular.element("#addRateFrom").kendoValidator({
        messages: {
            required: "Поле обов'язкове!",
            number: "Повинно бути числом!",
            ddkv: "Оберіть/введіть існуючу валюту!",
            date: "Введіть корректну дату",
            nomore: "Ставка не може перевищувати 100."
        },
        rules: {
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8) {
                    if (input.is("[name=KF_NUM]")) {
                        if (!input.val().match(OnlyNumbers)) {
                            return false;
                        }
                    }
                }
                else {
                    if (input.is("[name=KF_NUM]") || input.is("[name=RATE]")) {
                        if (!input.val().match(OnlyNumbers)) {
                            return false;
                        }
                    }
                }
                return true;
            },
            nomore: function (input) {
                if (input.is("[name=RATE]")) {
                    input.attr("data-nomore-msg", "Ставка не може перевищувати 100.");
                    return (input.val() <= 100);
                }
                return true;
            },
            ddkv: function (input) {
                if (input.is("[name=KF_NUM]")) {
                    if (angular.element("#addRate_KF_DD").data("kendoDropDownList").text() === "") {
                        return false;
                    }
                }
                return true;
            },
            date: function (input) {
                if (input.is("[data-role=datepicker]")) {
                    var date = kendo.parseDate(input.val(), "dd.MM.yyyy");
                    result = true;
                    if (!date) {
                        date = kendo.parseDate(input.val(), "dd/MM/yyyy");
                        if (!date) {
                            result = false;
                        }
                    }
                    return result;
                } else {
                    return true;
                }
            }
        }
    });


    $scope.AddEditInterestBrateToBD = function () {
        validator = angular.element("#addRateFrom").data("kendoValidator");
        if (validator.validate()) {
            var url;
            $scope.addInterestBrateWin.close();
            data_for_insert = [];
            editArray = [];
            var request;
            bd = kendo.parseDate(angular.element("#addRate_DATE").val(), 'dd/MM/yyyy');
            kv = angular.element("#addRate_KF_NUM").val();
            if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8) {

                if (action === "update") {
                    data = angular.element("#rateOptionsEditGrid").data("kendoGrid").dataSource.data();
                    oldData = angular.element("#rateOptionsEditGrid").data("kendoGrid").dataSource._pristineData;
                    for (var i = 0; i < data.length; i++) {
                        var newRow = { DATB: bd, KV: kv, IR: data[i].IR, S_STRING: data[i].S_STRING, BRANCH: null, BRANCH_NAME: null };
                        var oldRow = { DATB: bd, KV: kv, IR: oldData[i].IR, S_STRING: oldData[i].S_STRING, BRANCH: null, BRANCH_NAME: null };
                        if (!$scope.IsInterestBrateRowsEquel(newRow, oldRow))
                            data_for_insert.push({
                                NewRowInterestData: newRow,
                                OldRowInterestData: oldRow
                            });
                    };
                    url = "/api/baserates/baseratesapi/EditInterestBrateToBD/";
                }
                else {

                    data = angular.element("#rateOptionsAddGrid").data("kendoGrid").dataSource.data();
                    //bd = kendo.parseDate(angular.element("#addRate_DATE").val(), 'dd/MM/yyyy');
                    //kv = angular.element("#addRate_KF_NUM").val();
                    for (var i = 0; i < data.length; i++) {
                        data_for_insert.push({ DATB: bd, KV: kv, IR: data[i].IR, S: data[i].S, BRANCH: null, BRANCH_NAME: null })
                    }
                    url = "/api/baserates/baseratesapi/AddInterestBrateToBD/";
                }
            }
            else {
                if (action === "update") {
                    data = angular.element("#rateOptionsEditGrid").data("kendoGrid").dataSource.data();
                    url = "/api/baserates/baseratesapi/EditInterestBrateToBD/";
                }
                else {
                    data = angular.element("#rateOptionsAddGrid").data("kendoGrid").dataSource.data();
                    url = "/api/baserates/baseratesapi/AddInterestBrateToBD/";
                }
                //bd = kendo.parseDate(angular.element("#addRate_DATE").val(), 'dd/MM/yyyy');
                //kv = angular.element("#addRate_KF_NUM").val();
                rate = angular.element("#addRate_RATE").val();
                data_for_insert.push({ DATB: bd, KV: kv, IR: rate, S: null, BRANCH: null, BRANCH_NAME: null });
            }
            request = { InterestList: data_for_insert, br_id: brid };
            if (!data_for_insert || data_for_insert.length == 0)
                return false;
            $.ajax({
                url: bars.config.urlContent(url),
                method: "POST",
                dataType: "json",
                data: JSON.stringify(request),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            bars.ui.success({ text: "Дані успішно збережені" });
                            $("#interestRateGrid").data("kendoGrid").dataSource.read();
                        }
            });
        }
    }

    $scope.IsInterestBrateRowsEquel = function (oldRow, newRow) {
        if (oldRow.S != newRow.S || oldRow.IR != newRow.IR)
            return false;
        else
            return true;
    };

    $scope.rateOptionsAddGridOptions = {
        autoBind: false,
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent('/api/baserates/baseratesapi/GetRateOptions'),
                    data: function () {
                        return { branch: branch, brid: brid, kv: angular.element("#addRate_KF_NUM").val(), bdate: kendo.parseDate(angular.element("#addRate_DATE").val(), 'dd/MM/yyyy'), action: action };
                    }
                }
            },
            schema: {
                model: {
                    fields: {
                        S: {
                            type: "number",
                            validation: {
                                required: { message: "Поле Гранична сума обов'язкове!" },
                                onlynumber: function (input) {
                                    input.attr("data-onlynumber-msg", "Має бути числом.");
                                    return /^[0-9]/.test(input.val());
                                    //return true;
                                },
                                nomore: function (input) {
                                    if (input[0].name == "S") {
                                        input.attr("data-nomore-msg", "Ставка не може перевищувати 99999999999999999999");
                                        return (input.val() <= 99999999999999999999);
                                    }
                                    return true;
                                }
                            },
                            editable: true
                        },
                        IR: {
                            type: "number",
                            validation: {
                                required: { message: "Поле Нове значення обов'язкове!" },
                                onlynumber: function (input) {
                                    if (input[0].name == 'IR') {
                                        input.attr("data-onlynumber-msg", "Має бути числом.");
                                        return /^[0-9]/.test(input.val());
                                    }
                                    return true;
                                },
                                nomore: function (input) {
                                        input.attr("data-nomore-msg", "Ставка не може перевищувати 100.");
                                        return (input.val() <= 100);
                                }
                            },
                            editable: true
                        }
                    }
                }
            },
            pageSize: 4
        },
        dataBound: function (e) {

        },
        dataBinding: function () {

        },
        change: function (e) {

        },
        selectable: 'single',
        groupable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        editable: false,
        resizable: true,
        reorderable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            pageSizes: [5, 10, 20, 50],
            buttonCount: 3
        },
        editable: true,
        columns: [
            {
                field: "IDROW",
                title: "ID",
                hidden: true

            },
            {
                field: "S",
                title: "Гранична сума",
                format: "{0:n2}"
            },
            {
                field: "IR",
                title: "Значення ставки",
                attributes: { style: "text-align:center;" },
                format: "{0:n2}"
            }
        ]
    };

    $scope.rateOptionsEditGridOptions = {
        autoBind: false,
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent('/api/baserates/baseratesapi/GetRateOptions'),
                    data: function () {
                        return {
                            branch: branch, brid: brid, kv: angular.element("#addRate_KF_NUM").val(),
                            bdate: angular.element("#addRate_DATE").val(), action: action
                        };
                    }
                }
            },
            schema: {
                model: {
                    fields: {
                        S: {
                            type: "number",
                            validation: {
                                required: { message: "Поле Гранична сума обов'язкове!" },
                                onlynumber: function (input) {
                                    input.attr("data-onlynumber-msg", "Має бути числом.");
                                    return /^[0-9]/.test(input.val());
                                },
                                nomore: function (input) {
                                    if (input[0].name == "S") {
                                        input.attr("data-nomore-msg", "Ставка не може перевищувати 99999999999999999999");
                                        return (input.val() <= 99999999999999999999);
                                    }
                                    return true;
                                }
                            },
                            editable: true
                        },
                        S_STRING: {
                            type: "string"
                        },
                        IR: {
                            type: "number",
                            validation: {
                                required: { message: "Поле Нове значення обов'язкове!" },
                                onlynumber: function (input) {
                                    input.attr("data-onlynumber-msg", "Має бути числом.");
                                    return /^[0-9]/.test(input.val());
                                },
                                nomore: function (input) {
                                    input.attr("data-nomore-msg", "Ставка не може перевищувати 100.");
                                    return (input.val() <= 100);
                                }
                            },
                            editable: true
                        }
                    }
                }
            },
            pageSize: 4
        },
        dataBound: function (e) {

        },
        dataBinding: function () {

        },
        selectable: 'single',
        groupable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        editable: false,
        resizable: true,
        reorderable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            pageSizes: [5, 10, 20, 50],
            buttonCount: 3
        },
        editable: true,
        columns: [
            {
                field: "IDROW",
                title: "ID",
                hidden: true
            },
            {
                field: "S",
                title: "Гранична сума",
                format: "{0:n2}"
            },
            {
                field: "S_STRING",
                title: "сума",
                hidden: true
            },
            //{
            //    field: "OLD_RATE",
            //    title: "Старе значення",
            //    attributes: { style: "text-align:center;" },
            //    format: "{0:n2}"
            //},
            {
                field: "IR",
                title: "Нове значення",
                attributes: { style: "text-align:center;" },
                format: "{0:n2}"
            }
        ]
    };

    $scope.AddRow = function () {
        var grid = angular.element("#rateOptionsAddGrid").data("kendoGrid");
        grid.addRow();
        angular.element(".k-grid-edit-row").appendTo("#grid tbody");
    }

    $scope.editRow = function () {
        grid = $("#interestRateGrid").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        if (selectedItem !== null) {
            action = "update";
            kvs = $scope.AjaxGetFunction(bars.config.urlContent("/api/baserates/baseratesapi/getkvs"));
            angular.element("#addRate_KF_DD").data("kendoDropDownList").dataSource.data(kvs);
            angular.element("#addRate_KF_DD").data("kendoDropDownList").enable(false);
            angular.element("#addRate_KF_DD").data("kendoDropDownList").value(selectedItem.KV);
            angular.element("#addRate_add_row").hide();
            angular.element("#addRate_delete_row").hide();
            angular.element("#addRate_KF_NUM").val(selectedItem.KV);
            angular.element("#addRate_KF_NUM").attr("disabled", "disabled");
            $scope.branch_text = angular.element("#ddBranch").data("kendoDropDownList").text();
            angular.element("#addRate_tbBRNAME").val(angular.element("#tbBRNAME").val());
            angular.element("#addRate_DATE").val(kendo.toString(kendo.parseDate(selectedItem.DATB, 'yyyy/MM/dd'), 'dd/MM/yyyy'));
            angular.element("#addRate_DATE").data("kendoDatePicker").enable(false);
            //angular.element("#addRate_OLD_RATE").val(selectedItem.IR);
            if (brtype == 2 || brtype == 3 || brtype == 5 || brtype == 6 || brtype == 7 || brtype == 8) {
                angular.element("#addRate_RATE").val(0);
                angular.element("#new_rate").hide();
                angular.element("#rateOptionsAddGrid").hide();
                angular.element("#rateOptionsEditGrid").show();
                //angular.element("#rateOptionsEditGrid").data("kendoGrid").showColumn("OLD_RATE");
                angular.element("#rateOptionsEditGrid").data("kendoGrid").dataSource.read();
                //angular.element("#old_rate").hide();
            }
            else {
                //angular.element("#old_rate").show();
                angular.element("#rateOptionsAddGrid").hide();
                angular.element("#rateOptionsEditGrid").hide();
                angular.element("#addRate_RATE").val(0);
                angular.element("#new_rate").show();
            }
            $scope.addInterestBrateWin.center().open();
        }
        else {
            bars.ui.alert({ text: "Оберіть рядок." });
        }
    }

    $scope.deleteBrate = function () {
        grid = $("#interestRateGrid").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        if (selectedItem !== null) {
            $.ajax({
                url: bars.config.urlContent("/api/baserates/baseratesapi/DeleteBrate"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ model: selectedItem, br_id: brid }),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            bars.ui.success({ text: "Дані успішно видалені" });
                            $("#interestRateGrid").data("kendoGrid").dataSource.read();
                        }
            });
        }
        else {
            bars.ui.alert({ text: "Оберіть рядок." });
        }
    }

    $scope.addBaseRate = function () {
        types = $scope.AjaxGetFunction(bars.config.urlContent("/api/baserates/baseratesapi/getRatesTypes"));
        angular.element("#addBaseRate_BRTYPE_NAME").data("kendoDropDownList").dataSource.data(types);
        angular.element("#addBaseRate_BRTYPE").val(angular.element("#addBaseRate_BRTYPE_NAME").val());
        $scope.addBaseRateWin.center().open();
    }

    $("#addBaseRate_BRTYPE").focusout(function () {
        angular.element("#addBaseRate_BRTYPE_NAME").data("kendoDropDownList").value(angular.element("#addBaseRate_BRTYPE").val());
    })

    angular.element("#addBaseRateWinFrom").kendoValidator({
        messages: {
            required: "Поле обов'язкове!",
            number: "Повинно бути числом!",
            ddtype: "Оберіть/введіть існуючий тип!"
        },
        rules: {
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (input.is("[name=BRTYPE]")) {
                    if (!input.val().match(OnlyNumbers)) {
                        return false;
                    }
                }
                return true;
            },
            ddtype: function (input) {
                if (input.is("[name=BRTYPE]")) {
                    if (angular.element("#addBaseRate_BRTYPE_NAME").data("kendoDropDownList").text() === "") {
                        return false;
                    }
                }
                return true;
            }
        }
    });

    $scope.AddBaseRateToBD = function () {
        validator = angular.element("#addBaseRateWinFrom").data("kendoValidator");
        if (validator.validate()) {
            $scope.addBaseRateWin.close();
            model = {
                BR_ID: null,
                BR_NAME: angular.element("#addBaseRate_NAME").val(),
                TYPE_ID: angular.element("#addBaseRate_BRTYPE").val(),
                TYPE_NAME: angular.element("#addBaseRate_BRTYPE_NAME").data("kendoDropDownList").text(),
                INUSE: angular.element("#addBaseRate_ACTIVE").val()
            }

            $.ajax({
                url: bars.config.urlContent("/api/baserates/baseratesapi/AddBaseRateToBD"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ model: model }),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            bars.ui.success({ text: "Дані успішно збережені." });
                            $("#baseRate").data("kendoGrid").dataSource.read();
                        }
            });
        }
    }

    $scope.DublicateBRate = function () {
        grid = $("#baseRate").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        if (selectedItem !== null) {
            $.ajax({
                url: bars.config.urlContent("/api/baserates/baseratesapi/AddBaseRateToBD"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ model: selectedItem }),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            bars.ui.success({ text: "Дані успішно збережені." });
                            $("#baseRate").data("kendoGrid").dataSource.read();
                        }
            });
        }
        else {
            bars.ui.alert({ text: "Оберіть рядок." });
        }
    }

    $scope.DeleteRow = function () {
        grid = $("#rateOptionsAddGrid").data("kendoGrid");
        selectedItem = grid.dataItem(grid.select());
        if (selectedItem !== null) {
            grid.dataSource.remove(selectedItem);
        }
        else {
            bars.ui.alert({ text: "Оберіть рядок." });
        }
    }
}]);