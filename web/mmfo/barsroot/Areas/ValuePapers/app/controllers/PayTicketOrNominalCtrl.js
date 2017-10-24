angular.module('BarsWeb.Controllers', ["kendo.directives"])
.controller('PayTicketOrNominalCtrl', ['$scope', function ($scope, $http) {
    $scope.InitData = function (strPar02, nGrp, nID, CP_ID) {
        $("html").css("zoom", window.innerWidth / 2000);
        $scope.pars = {
            strPar02: strPar02,
            nGrp: nGrp,
            nID: nID,
            CP_ID: CP_ID
        }
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/PayTicketApi/GetModel") + '?p_ID=' + $scope.pars.nID + '&nGrp=' + nGrp,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.inputs_data = data.responseJSON;
                    }
        });

        $("#cp_id").val($scope.pars.CP_ID);
        $("#nid").val($scope.pars.nID);
        $("#sumni").val($scope.inputs_data.P_SUMNI);
        $("#sumnz").val($scope.inputs_data.P_SUMNZ);
        $("#sumri").val($scope.inputs_data.P_SUMRI);
        $("#sumrz").val($scope.inputs_data.P_SUMRZ);
        $("#datp").val(kendo.toString(kendo.parseDate($scope.inputs_data.P_DATP, 'yyyy-MM-dd'), 'dd/MM/yyyy'));
        $("#rate").val($scope.inputs_data.P_RATE);
        $("#dat_em").val(kendo.toString(kendo.parseDate($scope.inputs_data.P_DAT_EM, 'yyyy-MM-dd'), 'dd/MM/yyyy'));
        $("#cena").val($scope.inputs_data.P_CENA);
        $("#kv").val($scope.inputs_data.P_KV);


        if ($scope.inputs_data.P_CB_ZO === 1)
            $("#cb_zo")[0].checked = true;
        if ($scope.inputs_data.P_CB_STP === 1)
            $("#cb_stp")[0].checked = true;

        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/PayTicketApi/GetDataListFor_cbm_RYN") + "?kv=" + $scope.inputs_data.P_KV,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.drop_down_list_data = data.responseJSON;
                    }
        });
    }

    $scope.gridOptions = {
        dataSource: {
            type: "webapi",
            serverSorting: true,
            serverFiltering: true,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/valuepapers/payticketapi/getgriddata"),
                    data: function () {
                        console.log($("#dropdownlist").val());
                        return { p_ID: $scope.pars.nID, nRYN: parseInt($("#dropdownlist").val()), nGRP: $scope.pars.nGrp }
                    }
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
        columns: [
            {
                field: "P_SERR",
                title: "Код стану"
            },
            {
                field: "P_OKPO",
                title: "ЗКПО зберігача"
            },
            {
                field: "P_NB",
                title: "Назва банку зберігача"
            },
            {
                field: "P_MFO",
                title: "МФО зберігача"
            },
            {
                field: "P_NLS",
                title: "Рахунок для сплати"
            },
            {
                field: "P_NOM",
                title: "Сума номіналу у зберігача"
            },
            {
                field: "P_KUPON",
                title: "Очікув. купон"
            },
            {
                field: "P_OSTA",
                title: "Погашення номіналу"
            },
            {
                field: "P_OSTR",
                title: "Погашення купону"
            }
        ],
        filterable: true,
        sortable: true
    };

    $scope.onChange = function () {
        $("#grid").data("kendoGrid").dataSource.read();
    };

    $("#sumnk").change(function () {
        if ($("#sumnk").val() !== "") {
            $("#sumrk")[0].disabled = true;
            $("#sumrk").addClass("k-state-disabled");
            angular.element('#dropdownlist').data("kendoDropDownList").enable(false);
        }
        else {
            $("#sumrk")[0].disabled = false;
            $("#sumrk").removeClass("k-state-disabled");
            angular.element('#dropdownlist').data("kendoDropDownList").enable(true);
        }
    });

    $("#sumrk").change(function () {
        if ($("#sumrk").val() !== "") {
            $("#sumnk")[0].disabled = true;
            $("#sumnk").addClass("k-state-disabled");
            angular.element('#dropdownlist').data("kendoDropDownList").enable(false);
        }
        else {
            $("#sumnk")[0].disabled = false;
            $("#sumnk").removeClass("k-state-disabled");
            angular.element('#dropdownlist').data("kendoDropDownList").enable(true);
        }
    });

    angular.element("#sumnk_form").kendoValidator({
        messages: {
            correct: "Повинно бути більше нуля",
            number: "Повинно бути числом"
        },
        rules: {
            correct: function (input) {
                if (input.is("[name=sumnk]")) {
                    if (input.val() !== "") {
                        if (input.val() < 0)
                            return false;
                        else
                            return true;
                    }
                    else
                        return true;
                }
            },
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (input.is("[name=sumnk]")) {
                    if (input.val() !== "") {
                        if (!input.val().match(OnlyNumbers)) {
                            return false;
                        }
                        else
                            return true;
                    }
                    return true;
                }
            }
        }
    });

    angular.element("#sumrk_form").kendoValidator({
        messages: {
            correct: "Повинно бути більше нуля",
            number: "Повинно бути числом"
        },
        rules: {
            correct: function (input) {
                if (input.is("[name=sumrk]")) {
                    if (input.val() !== "") {
                        if (input.val() < 0 || input.val() !== "")
                            return false;
                        else
                            return true;
                    }
                }
                return true;
            },
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (input.is("[name=sumrk]")) {
                    if (input.val() !== "") {
                        if (!input.val().match(OnlyNumbers)) {
                            return false;
                        }
                    }
                }
                return true;
            }
        }
    });
}]);