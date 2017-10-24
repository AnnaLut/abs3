angular.module('BarsWeb.Controllers', ["kendo.directives"])
.controller('PayTicketCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.InitData = function (strPar01, strPar02, nGrp, nMode, nID, CP_ID) {
        if (nMode == 0) {
            $("#sumni_all").hide();
        }
        $("html").css("zoom", window.innerWidth / 1024);
        angular.element("#ryn_drop_down_list").kendoDropDownList({});
        $scope.nID = nID;
        $scope.CP_ID = CP_ID;
        $scope.pars = {
            strPar01: strPar01,
            strPar02: strPar02,
            nGrp: nGrp,
            nMode: nMode
        }
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/PayTicketApi/GetModel") + '?strPar01=' + strPar01 + '&strPar02=' + strPar02 + '&nGrp=' + nGrp + '&nMode=' + nMode,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.inputs_data = data.responseJSON;
                    }
        });
        $scope.inputs_data.p_DAT_EM = kendo.toString(kendo.parseDate($scope.inputs_data.p_DAT_EM, 'yyyy-MM-dd'), 'dd/MM/yyyy');
        $scope.inputs_data.p_DATP = kendo.toString(kendo.parseDate($scope.inputs_data.p_DATP, 'yyyy-MM-dd'), 'dd/MM/yyyy');

        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/generalfolder/GetDataListFor_cbm_PF") + "?p_DOX=" + $scope.inputs_data.p_nDOX + "&p_nEMI=" + $scope.inputs_data.p_nEMI,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.pf_drop_down = data.responseJSON;
                    }
        });

        angular.element("#pf_drop_down_list").kendoDropDownList({
            dataTextField: "TEXT",
            dataValueField: "VAL",
            dataSource: $scope.pf_drop_down,
            change: onChangePF,
            filter: "contains"
        });
        angular.element("#save").kendoButton({ enable: false });
        angular.element("#glasses").kendoButton({ enable: false });
        angular.element("#pf_drop_down_list").data("kendoDropDownList").value("");
        angular.element("#ryn_drop_down_list").data("kendoDropDownList").enable(false);
        $("#mainGrid").kendoGrid({
            dataSource: {},
            columns: [
                                {
                                    field: "p_NLSA",
                                    title: "Рахунок номіналу",
                                    width: "150px"

                                },
                                {
                                    field: "p_OSTA",
                                    title: "Сума номіналу",
                                    width: "150px"

                                },
                                {
                                    field: "p_NLSR2",
                                    title: "Рахунок купону накопиченого",
                                    width: "150px"
                                },
                                {
                                    field: "p_OSTR2",
                                    title: "Залишок купону накопиченого",
                                    width: "150px"

                                },
                                {
                                    field: "p_NLSR3",
                                    title: "Рахунок купону 'кривого'",
                                    width: "150px"
                                },
                                {
                                    field: "p_OSTR3",
                                    title: "Залишок купону 'кривого'",
                                    width: "150px"
                                },
                                {
                                    field: "p_ACC",
                                    title: "Рахунок",
                                    width: "150px"
                                },
                                {
                                    field: "p_ACR_DAT",
                                    title: "Нараховано купон по дату",
                                    template: '#: GetDate(p_ACR_DAT) #',
                                    width: "150px"
                                },
                                {
                                    field: "p_NLSR",
                                    title: "Рахунок купону нарахованого ",
                                    width: "150px"
                                },
                                {
                                    field: "p_OSTR",
                                    title: "Залишок (до сплати) купону нарахованого",
                                    width: "150px"
                                },
                                {
                                    field: "p_APL_DAT",
                                    title: "Сплачено купон по дату",
                                    template: '#: GetDate(p_APL_DAT) #',
                                    width: "150px"
                                },
                                {
                                    field: "p_ACR_DAT_INT",
                                    title: "Сплатим нарахований купон по дату",
                                    template: '#: GetDate(p_ACR_DAT_INT) #',
                                    width: "150px"
                                },
                                {
                                    field: "p_OSTR_REAL",
                                    title: "Залишок (реальний) купону нарахованого",
                                    width: "150px"
                                }
            ],
            filterable: true,
            sortable: true,
            scrollable: true,
            resizable: true
        });
    }

    function onChangePF() {
        angular.element("#save").data("kendoButton").enable(false);
        angular.element("#glasses").data("kendoButton").enable(false);
        if (angular.element("#ryn_drop_down_list").data("kendoDropDownList").value() != "") {
            angular.element("#ryn_drop_down_list").data("kendoDropDownList").value("");
            angular.element("#ryn_drop_down_list").data("kendoDropDownList").enable(false);
        }
        for (var i = 0; i < $scope.pf_drop_down.length; i++) {
            if ($scope.pf_drop_down[i].TEXT === angular.element("#pf_drop_down_list").data("kendoDropDownList").text()) {
                $scope.pf_drop_down_select = $scope.pf_drop_down[i];
                angular.element("#vidd").val($scope.pf_drop_down_select.VAL);
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/generalfolder/GetDataListFor_cbm_RYN") + "?p_Vidd=" + $scope.pf_drop_down_select.VAL + "&p_Kv=" + $scope.inputs_data.p_KV + "&p_Tipd=" + $scope.inputs_data.p_nTipD,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete:
                            function (data) {
                                $scope.ryn_drop_down = data.responseJSON;
                            }
                });

                angular.element("#ryn_drop_down_list").kendoDropDownList({
                    dataTextField: "TEXT",
                    dataValueField: "VAL",
                    dataSource: $scope.ryn_drop_down,
                    change: $scope.onChangeRYN,
                    filter: "contains"
                });
            }

        }
        angular.element("#ryn_drop_down_list").data("kendoDropDownList").value("");
        angular.element("#ryn_drop_down_list").data("kendoDropDownList").enable(true);
    };

    $scope.onChangeRYN = function () {
        for (var i = 0; i < $scope.ryn_drop_down.length; i++) {
            if ($scope.ryn_drop_down[i].TEXT === angular.element("#ryn_drop_down_list").data("kendoDropDownList").text()) {
                $scope.ryn_drop_down_select = $scope.ryn_drop_down[i];
                angular.element("#save").data("kendoButton").enable(true);
                $("#mainGrid").kendoGrid({
                    dataSource: {
                        type: "webapi",
                        serverSorting: true,
                        serverFiltering: true,
                        transport: {
                            read: {
                                url: bars.config.urlContent("/api/valuepapers/payticketapi/getgriddata") + "?strPar01=" + $scope.pars.strPar01 + "&strPar02=" + $scope.pars.strPar02 + "&nGrp=" + $scope.pars.nGrp +
                                    "&nMode=" + $scope.pars.nMode + "&p_nRyn=" + $scope.ryn_drop_down_select.VAL + "&p_nPf=" + $scope.pf_drop_down_select.PF,
                            }
                        },
                        schema: {
                            data: "Data",
                            total: "Total",
                            errors: "Errors",
                            model: {
                                p_NLSA: { type: "string" },
                                p_OSTA: { type: "number" },
                                p_NLSR: { type: "string" },
                                p_OSTR: { type: "number" },
                                p_NLSR2: { type: "string" },
                                p_OSTR2: { type: "number" },
                                p_NLSR3: { type: "string" },
                                p_OSTR3: { type: "number" },
                                p_ACC: { type: "number" },
                                p_ACR_DAT_INT: { type: "string" },
                                p_OSTR_REAL: { type: "number" },
                                p_ACR_DAT: { type: "string" },
                                p_APL_DAT: { type: "string" }
                            }
                        }
                    },
                    dataBound: function dataBound(e) {
                        var grid = $("#mainGrid").data("kendoGrid");
                        var gridData = grid.dataSource.data();
                        var sum = 0.00;
                        var sum2 = 0.00;
                        $.ajax({
                            url: bars.config.urlContent("/api/valuepapers/payticketapi/GetSumTicket") + "?strPar01=" + $scope.pars.strPar01 + "&strPar02=" + $scope.pars.strPar02 + "&nGrp=" + $scope.pars.nGrp +
                                    "&nMode=" + $scope.pars.nMode + "&p_nRyn=" + $scope.ryn_drop_down_select.VAL + "&p_nPf=" + $scope.pf_drop_down_select.PF,
                            method: "GET",
                            dataType: "json",
                            async: false,
                            success: function (data) {
                                angular.element("#sumn").val(parseFloat(Math.round(data.SUMN * 100) / 100).toFixed(2));
                                angular.element("#sumn2").val(parseFloat(Math.round(data.SUMN2 * 100) / 100).toFixed(2));
                                angular.element("#sumnk").val(parseFloat(Math.round(data.SUMNK * 100) / 100).toFixed(2));
                                angular.element("#sumni").val(parseFloat(Math.round(data.SUMNK * 100) / 100).toFixed(2));
                            }
                        });
                        if (!$("#sumni_all")[0].hidden) {
                            $.ajax({
                                url: bars.config.urlContent("/api/valuepapers/PayTicketApi/GetSumiAll") + "?strPar01=" + $scope.pars.strPar01 + "&kv=" + $scope.inputs_data.p_KV + "&pf=" + $scope.pf_drop_down_select.PF +
                                    "&emi=" + $scope.inputs_data.p_nEMI + "&vidd=" + $scope.pf_drop_down_select.VAL + "&dox=" + $scope.inputs_data.p_nDOX + "&ryn=" + $scope.ryn_drop_down_select.VAL,
                                method: "GET",
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    angular.element("#sumni_all").val(parseFloat(Math.round(data * 100) / 100).toFixed(2));
                                }
                            });
                        }
                    },
                    columns: [
                                {
                                    field: "p_NLSA",
                                    title: "Рахунок номіналу",
                                    width: "125px"

                                },
                                {
                                    field: "p_OSTA",
                                    title: "Сума номіналу",
                                    width: "90px",
                                    format: "{0:n}"

                                },
                                {
                                    field: "p_NLSR2",
                                    title: "Рахунок купону накопиченого",
                                    width: "125px",
                                    attributes: { style: "white-space: nowrap" }
                                },
                                {
                                    field: "p_OSTR2",
                                    title: "Залишок купону накопиченого",
                                    format: "{0:n}",
                                    width: "90px"

                                },
                                {
                                    field: "p_NLSR3",
                                    title: "Рахунок купону 'кривого'",
                                    width: "125px"
                                },
                                {
                                    field: "p_OSTR3",
                                    title: "Залишок купону 'кривого'",
                                    format: "{0:n}",
                                    width: "90px"
                                },
                                {
                                    field: "p_ACC",
                                    title: "Рахунок",
                                    width: "80px"
                                },
                                {
                                    field: "p_ACR_DAT",
                                    title: "Нараховано купон по дату",
                                    template: '#: GetDate(p_ACR_DAT) #',
                                    width: "80px"
                                },
                                {
                                    field: "p_NLSR",
                                    title: "Рахунок купону нарахованого ",
                                    width: "125px"
                                },
                                {
                                    field: "p_OSTR",
                                    title: "Залишок (до сплати) купону нарахованого",
                                    format: "{0:n}",
                                    width: "90px"
                                },
                                {
                                    field: "p_APL_DAT",
                                    title: "Сплачено купон по дату",
                                    template: '#: GetDate(p_APL_DAT) #',
                                    width: "80px"
                                },
                                {
                                    field: "p_ACR_DAT_INT",
                                    title: "Сплатим нарахований купон по дату",
                                    template: '#: GetDate(p_ACR_DAT_INT) #',
                                    width: "80px"
                                },
                                {
                                    field: "p_OSTR_REAL",
                                    title: "Залишок (реальний) купону нарахованого",
                                    format: "{0:n}",
                                    width: "90px"
                                }
                    ],
                    filterable: true,
                    sortable: true,
                    scrollable: true,
                    resizable: true
                });
            }

        };
    };

    GetDate = function (date) {
        if (date == "/Date(-62135596800000+0200)/") {
            return "";
        }
        else
            return kendo.toString(kendo.parseDate(date, 'yyyy-MM-dd'), 'dd/MM/yyyy');
    }

    $scope.ViewDoc = function () {
        bars.ui.dialog({
            content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + $scope.after_save_pars.p_sREF,
            iframe: true,
            height: document.documentElement.offsetHeight * 0.8,
            width: document.documentElement.offsetWidth * 0.8
        });
    }
    
    $("#sumni_all").change(function () {
        angular.element("#sumni_all").val(parseFloat(Math.round(angular.element("#sumni_all").val() * 100) / 100).toFixed(2));
    });

    $("#sumnk").change(function () {
        angular.element("#sumnk").val(parseFloat(Math.round(angular.element("#sumnk").val() * 100) / 100).toFixed(2));
    });

    $scope.Save = function () {
        var cb_Zo = 0;
        if (angular.element("#kor").is(':checked')) {
            cb_Zo = 96;
        }
        else
            cb_Zo = 6;

        //if (!$("#sumni_all")[0].hidden) {
        //    if ($("#sumni_all").val() != $("#sumnk").val()) {
        //        alert("Суми не співпадають");
        //        return false;
        //    }
        //}

        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/PayTicketApi/savecp") + "?p_nTipD=" + $scope.inputs_data.p_nTipD + "&p_cb_Zo=" + cb_Zo +
                "&p_nGrp=" + $scope.pars.nGrp + "&p_nID=" + $scope.nID + "&p_nRYN=" + $scope.ryn_drop_down_select.VAL + "&p_nVidd=" + $scope.pf_drop_down_select.VAL +
                "&p_SUMK=" + angular.element("#sumnk").val(),
            method: "GET",
            dataType: "json",
            async: false,
            success: function (data) {
                alert("Операція успішна");
                $scope.after_save_pars = data;
                $("#mainGrid").data("kendoGrid").dataSource.read();
                $("#mainGrid").data("kendoGrid").refresh();
                angular.element("#glasses").data("kendoButton").enable(true);
            }
        });
    }

    angular.element("#sum_form").kendoValidator({
        messages: {
            correct: "Повинно бути більше нуля",
            number: "Повинно бути числом"
        },
        rules: {
            correct: function (input) {
                if (input.is("[name=sumk]")) {
                    if (input.val() < 0 || input.val() == "")
                        return false;
                    else
                        return true;
                }
                return true;
            },
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (input.is("[name=sumk]")) {
                    if (!input.val().match(OnlyNumbers)) {
                        return false;
                    }
                }
                return true;
            }
        }
    });
}]);