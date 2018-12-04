angular.module('BarsWeb.Controllers', ["kendo.directives"])
.controller('CPToAnotherBag', ['$scope', '$http', function ($scope, $http) {
    //инициализация параметров
    $scope.InitParams = function (id) {
        angular.element("#dropdownlistfirst").kendoDropDownList({
        });
        angular.element("#dropdownlistsecond").kendoDropDownList({
        });
        angular.element("#dropdownlistthird").kendoDropDownList({
        });
        angular.element("#dropdownlistfourth").kendoDropDownList({
        });
        $scope.id_paper = id;
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetInputs") + "?id=" + id,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.pars = data.responseJSON;
                    }
        });
        angular.element("#id_cp").val($scope.pars[0].CP_ID);
        angular.element("#val").val($scope.pars[0].KV);
        angular.element("#out").val(kendo.toString(kendo.parseDate($scope.pars[0].DATP, 'yyyy-MM-dd'), 'dd/MM/yyyy'));
        angular.element("#deposit").val($scope.pars[0].IR);
        angular.element("#cancell").val(kendo.toString(kendo.parseDate($scope.pars[0].DAT_EM, 'yyyy-MM-dd'), 'dd/MM/yyyy'));
        angular.element("#unnamed").val(parseFloat($scope.pars[0].CENA).toFixed(2));
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetFirstComboBox") + "?id=" + id,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.first_combo = data.responseJSON;
                    }
        });
        angular.element("#dropdownlistfirst").kendoDropDownList({
            dataTextField: "VAL",
            dataValueField: "PF",
            filter: "contains",
            dataSource: $scope.first_combo,
            change: onChangeFirst
        });
        angular.element("#dropdownlistfirst").data("kendoDropDownList").value("");
        angular.element("#dropdownlistsecond").data("kendoDropDownList").enable(false);
        angular.element("#dropdownlistthird").data("kendoDropDownList").enable(false);
        angular.element("#dropdownlistfourth").data("kendoDropDownList").enable(false);
        angular.element("#get_some").kendoButton({ enable: false });
        angular.element("#send").kendoButton({ enable: false });
        angular.element("#glasses").kendoButton({ enable: false });
        angular.element("#sum").attr('disabled', 'disabled');
        angular.element("#ticket_number").attr('disabled', 'disabled');
        angular.element("#kor").attr('disabled', 'disabled');
    };

    function onChangeFirst() {
        angular.element("#nlsa").val("");
        angular.element("#ostb").val("");
        angular.element("#ostc").val("");
        angular.element("#_vidd").val("");
        angular.element("#_nlsa").val("");
        angular.element("#get_some").data("kendoButton").enable(false);
        angular.element("#send").data("kendoButton").enable(false);
        angular.element("#glasses").data("kendoButton").enable(false);
        angular.element("#sum").attr('disabled', 'disabled');
        angular.element("#ticket_number").attr('disabled', 'disabled');
        angular.element("#kor").attr('disabled', 'disabled');
        if (angular.element("#dropdownlistthird").data("kendoDropDownList").value() != "") {
            angular.element("#dropdownlistthird").data("kendoDropDownList").value("");
            angular.element("#dropdownlistthird").data("kendoDropDownList").enable(false);
        }
        if (angular.element("#dropdownlistfourth").data("kendoDropDownList").value() != "") {
            angular.element("#dropdownlistfourth").data("kendoDropDownList").value("");
            angular.element("#dropdownlistfourth").data("kendoDropDownList").enable(false);
        }
        for (var i = 0; i < $scope.first_combo.length; i++) {
            if ($scope.first_combo[i].VAL === angular.element("#dropdownlistfirst").data("kendoDropDownList").text()) {
                $scope.first_combo_select = $scope.first_combo[i];
                angular.element("#vidd").val($scope.first_combo[i].VIDD);
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetSecondComboBox") + "?id=" + $scope.id_paper + "&vidd=" + $scope.first_combo_select.VIDD,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete:
                            function (data) {
                                $scope.second_combo = data.responseJSON;
                            }
                });
                angular.element("#dropdownlistsecond").kendoDropDownList({
                    dataTextField: "NAME",
                    dataValueField: "RYN",
                    dataSource: $scope.second_combo,
                    change: onChangeSecond,
                    filter: "contains"
                });
                angular.element("#dropdownlistsecond").data("kendoDropDownList").enable(true);
                angular.element("#dropdownlistsecond").data("kendoDropDownList").value("");
            }
        }
    }

    function onChangeSecond() {
        angular.element("#_vidd").val("");
        angular.element("#_nlsa").val("");
        angular.element("#get_some").data("kendoButton").enable(false);
        angular.element("#send").data("kendoButton").enable(false);
        angular.element("#glasses").data("kendoButton").enable(false);
        angular.element("#sum").attr('disabled', 'disabled');
        angular.element("#ticket_number").attr('disabled', 'disabled');
        angular.element("#kor").attr('disabled', 'disabled');
        if (angular.element("#dropdownlistfourth").data("kendoDropDownList").value() != "") {
            angular.element("#dropdownlistfourth").data("kendoDropDownList").value("");
            angular.element("#dropdownlistfourth").data("kendoDropDownList").enable(false);
        }
        for (var i = 0; i < $scope.second_combo.length; i++) {
            if ($scope.second_combo[i].NAME === angular.element("#dropdownlistsecond").data("kendoDropDownList").text()) {
                $scope.second_combo_select = $scope.second_combo[i];
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetInputs") + "?id=" + $scope.id_paper + "&ryn=" + $scope.second_combo_select.RYN +
                        "&emi=" + $scope.pars[0].EMI + "&pf=" + $scope.first_combo_select.PF + "&vidd=" + $scope.first_combo_select.VIDD + "&kv=" + $scope.pars[0].KV,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete:
                            function (data) {
                                $scope.pars2 = data.responseJSON;
                            }
                });
            }
        }
        angular.element("#nlsa").val($scope.pars2[0].NLSA);
        angular.element("#ostb").val($scope.pars2[0].OSTB + ".00");
        angular.element("#ostc").val($scope.pars2[0].OSTC + ".00");

        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetThirdComboBox") + "?emi=" + $scope.pars[0].EMI + "&dox=" + $scope.pars[0].DOX +
                "&pf=" + $scope.first_combo_select.PF,
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.third_combo = data.responseJSON;
                    }
        });
        angular.element("#dropdownlistthird").kendoDropDownList({
            dataTextField: "VAL",
            dataValueField: "PF",
            dataSource: $scope.third_combo,
            change: onChangeThird,
            filter: "contains"
        });
        angular.element("#dropdownlistthird").data("kendoDropDownList").enable(true);
        angular.element("#dropdownlistthird").data("kendoDropDownList").value("");
    };

    function onChangeThird() {
        angular.element("#_nlsa").val("");
        angular.element("#get_some").data("kendoButton").enable(false);
        angular.element("#send").data("kendoButton").enable(false);
        angular.element("#glasses").data("kendoButton").enable(false);
        angular.element("#sum").attr('disabled', 'disabled');
        angular.element("#ticket_number").attr('disabled', 'disabled');
        angular.element("#kor").attr('disabled', 'disabled');
        for (var i = 0; i < $scope.third_combo.length; i++) {
            if ($scope.third_combo[i].VAL === angular.element("#dropdownlistthird").data("kendoDropDownList").text()) {
                $scope.third_combo_select = $scope.third_combo[i];
                angular.element("#_vidd").val($scope.third_combo[i].VIDD);
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetFourthComboBox") + "?emi=" + $scope.pars[0].EMI + "&dox=" + $scope.pars[0].DOX + "&vidd=" +
                        $scope.third_combo_select.VIDD,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete:
                            function (data) {
                                $scope.fourth_combo = data.responseJSON;
                            }
                });
                angular.element("#dropdownlistfourth").kendoDropDownList({
                    dataTextField: "NAME",
                    dataValueField: "RYN",
                    dataSource: $scope.fourth_combo,
                    change: onChangeFourth,
                    filter: "contains"
                });
                angular.element("#dropdownlistfourth").data("kendoDropDownList").enable(true);
                angular.element("#dropdownlistfourth").data("kendoDropDownList").value("");
            }
        }
    }
    function onChangeFourth() {
        for (var i = 0; i < $scope.fourth_combo.length; i++) {
            if ($scope.fourth_combo[i].NAME === angular.element("#dropdownlistfourth").data("kendoDropDownList").text()) {
                $scope.fourth_combo_select = $scope.fourth_combo[i];
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/GetNlsa") + "?ryn=" + $scope.fourth_combo_select.RYN + "&emi=" + $scope.pars[0].EMI +
                        "&pf=" + $scope.third_combo_select.PF + "&vidd=" + $scope.third_combo_select.VIDD,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete:
                            function (data) {
                                angular.element("#_nlsa").val(data.responseJSON);
                            }
                });

            }
        }
        angular.element("#get_some").data("kendoButton").enable(true);
        angular.element("#send").data("kendoButton").enable(true);
        angular.element("#sum").removeAttr('disabled');
        angular.element("#ticket_number").removeAttr('disabled');
        angular.element("#kor").removeAttr('disabled');
    };

    $("#sum").change(function () {
        angular.element("#sum").val(parseFloat(Math.round(angular.element("#sum").val() * 100) / 100).toFixed(2));
    });

    angular.element("#sum_form").kendoValidator({
        messages: {
            nominal: "Повинно бути кратне номінальній вартості",
            correct: "Повинно бути більше нуля",
            inostb: "Повинно не перевищувати залишку",
            number: "Повинно бути числом",
            required: "Введіть суму"
        },
        rules: {
            number: function (input) {
                var OnlyNumbers = /^(?:[1-9]\d*|0)?(?:\.\d+)?$/;
                if (input.is("[name=sum]")) {
                    if (!input.val().match(OnlyNumbers)) {
                        return false;
                    }
                }
                return true;
            },
            nominal: function (input) {
                if (input.is("[name=sum]")) {
                    if (parseFloat(input.val()).toFixed(2) % parseFloat($scope.pars[0].CENA).toFixed(2) == 0)
                        return true;
                    else
                        return false;
                }
                return true;
            },
            correct: function (input) {
                if (input.is("[name=sum]")) {
                    if (input.val() > 0)
                        return true;
                    else
                        return false;
                }

                return true;
            },
            inostb: function (input) {
                if (input.is("[name=sum]")) {
                    if (input.val() <= $scope.pars2[0].OSTB)
                        return true;
                    else
                        return false;
                }
                return true;
            }

        }
    });
    angular.element("#ticket_form").kendoValidator({
        messages: {
            required: "Введіть номер квитка"
        }
    });

    $scope.SendPaper = function () {
        $scope.validator = angular.element("#sum_form").data("kendoValidator");
        $scope.validator1 = angular.element("#ticket_form").data("kendoValidator");
        if ($scope.validator.validate() && $scope.validator1.validate()) {
            if (angular.element("#ref").val() === "") {
                bars.ui.error({ text: "Реф. не обраний" });
            }
            else {
                $scope.ticket_text = "Переведення ЦП " + $scope.pars[0].CP_ID + " з " + $scope.pars[0].DOX + " " + $scope.second_combo_select.NAME + "в " + $scope.third_combo_select.VAL + " " + $scope.fourth_combo_select.NAME;
                $scope.SendPaperWindow.center().open();
            }
        }
    };

    $scope.InsertValuePaper = function () {
        $scope.SendPaperWindow.close();
        var send_data = {
            id: $scope.id_paper,
            pf_1: $scope.first_combo_select.VIDD,
            ryn_1: $scope.second_combo_select.RYN,
            pf_2: $scope.third_combo_select.VIDD,
            ryn_2: $scope.fourth_combo_select.RYN,
            sum: angular.element("#sum").val(),
            _ref: angular.element("#ref").val(),
            nazn: $scope.ticket_text,
            kor: angular.element("#kor").is(':checked')
        };
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/InsertValuePaper"),
            data: { valuepaper : JSON.stringify(send_data) },
            method: "GET",
            dataType: "json",
            async: false,
            complete:
                    function (data) {
                        $scope.result = data.responseJSON;
                    }
        });
        if ($scope.result.sErr === null && $scope.result.REF_MAIN !== null) {
            angular.element("#glasses").data("kendoButton").enable(true);
            angular.element("#print").data("kendoButton").enable(true);
            angular.element("#send").data("kendoButton").enable(false);
            if (angular.element("#ticket_form").val() !== "") {
                $.ajax({
                    url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/UpdateTicketNumber") + "?REF_MAIN=" + $scope.result.REF_MAIN + "&ticket_form=" + angular.element("#ticket_form").val(),
                    method: "GET",
                    dataType: "json",
                    async: false
                });
            }
            bars.ui.success({ text: "Операція успішна.<br/> Новий Референс - " + $scope.result.REF_MAIN });
        }
        else if ($scope.result.sErr !== null) {
            bars.ui.error({ text: $scope.result.sErr });
        }
    };

    $scope.getDealWindowFilter = function () {
        $.ajax({
            url: bars.config.urlContent("/api/valuepapers/CPToAnotherBagApi/MakeMDTable") + "?id=" + $scope.id_paper + "&pf=" + $scope.first_combo_select.PF + "&ryn=" + $scope.second_combo_select.RYN,
            method: "GET",
            dataType: "json",
            async: false
        });
        bars.ui.getMetaDataNdiTable("CP_V1", function (response) {
            angular.element("#ref").val(response.REF);
        }, { hasCallbackFunction: true });
    }

    $scope.closeWin = function () {
        $scope.SendPaperWindow.close();
    };

    $scope.ViewDoc = function () {
        bars.ui.dialog({
            content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + angular.element("#ref").val(),
            iframe: true,
            height: document.documentElement.offsetHeight * 0.8,
            width: document.documentElement.offsetWidth * 0.8
        });
    }
}]);