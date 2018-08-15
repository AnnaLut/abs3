
$(document).ready(function () {
    $("div.col-sm-8.col-offset-1 input ").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: Ctrl+C
            (e.keyCode == 67 && e.ctrlKey === true) ||
            // Allow: Ctrl+X
            (e.keyCode == 88 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
});

function validate(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode(key);
    var regex = /[0-9]|\./;
    if (!regex.test(key)) {
        theEvent.returnValue = false;
        if (theEvent.preventDefault) theEvent.preventDefault();
    }
}

angular.module("BarsWeb.Controllers")
    .controller("currencyOpCtrl", function ($scope, $http) {
        $scope.dfID = '';
        $scope.rnk = '';
        $scope.dfKV = '';
        $scope.nDk = 1;

        function clearAllFields() {
            $scope.dfKV = "";
            $scope.dfID = "";
            $scope.rnk = "";
            $scope.dfKVNAME = "";
            $scope.nmk = "";
            $scope.DK = "";
            $scope.FDAT = "";
            $scope.sos = undefined;
            $scope.nRefSos = undefined;
            $scope.nDk = 1;
        }

        $scope.getCustomerNmk = function () {
            if (!$scope.rnk) {
                $scope.nmk = "";
                return;
            }
                
            $http.get(currencyOperationData.getNmkMethod, { params: { rnk: $scope.rnk } })
                .then(function (response) {
                    if (response.data == ""){
                        $scope.rnk = "";
                        $scope.nmk = "";
                        bars.ui.error({ text: "Не знайден клієнт з заданим РНК!" });
                    } else
                        $scope.nmk = response.data.replace(/\"/g, "");
                })
        }

        $scope.getTabvalName = function () {   
            if (!$scope.dfKV) {
                $scope.dfKVNAME = "";
                return;
            }
                
            $http.get(currencyOperationData.getTabvalNameMethod, { params: { dfKV: $scope.dfKV } })
                .then(function (response) {
                    if (response.data == "") {
                        $scope.dfKV = "";
                        $scope.dfKVNAME = "";
                        bars.ui.error({ text: "Не вірно задан код валюти!" });
                    } else
                        $scope.dfKVNAME = response.data.replace(/\"/g, "");
                });
        }

        $scope.findApplication = function () {

            if (!($scope.dfKV && $scope.rnk && $scope.dfID)) {
                bars.ui.error({ text: "Всі поля обов'язкові для заповнення!" });
                $scope.DK = "";
                $scope.FDAT = "";
                return;
            }
            $http.get(currencyOperationData.GetApplicationMethod, { params: { dfKV: $scope.dfKV, dfRNK: $scope.rnk, dfID: $scope.dfID, nDk: $scope.nDk } })
                .then(function (response) {
                    var result = response.data;
                    if (result.Status == "error") {
                        //       clearAllFields();
                        $scope.FDAT = "";
                        $scope.DK = "";
                        bars.ui.error({ text: result.Message });
                        return;
                    }
                    $scope.FDAT = kendo.toString(kendo.parseDate(response.data.Data.FDAT), 'dd/MM/yyyy');
                    $scope.DK = result.Data.DK;
                    $scope.sos = +result.Data.SOS;
                    $scope.ref = +result.Data.REF;

                    if ($scope.ref != undefined)
                        $http.get(currencyOperationData.getNrefSosMethod, { params: { nRef: $scope.ref } })
                            .then(function(response) {
                                $scope.nRefSos = +response.data;
                            });
                });               
        }

        $scope.deleteApplication = function () {
            switch ($scope.sos) {
                case 0: {
                    bars.ui.alert({
                        text: "Заявка поки не затверджена дилером!<br>" +
                            "Видалення заявок такого типу здійснюється з форми вводу заявок!"
                    });
                    break;
                }
                case 0.5: {
                    bars.ui.confirm({ text: "Заявка вже задовільнена дилером. Ви дійсно бажаєте видалити заявку?" }, _deleteApplication);
                    
                    break;
                }
                case 1: {
                    bars.ui.confirm({ text: "По даній заявці вже зарезервованы курси дилера. Ви дійсно бажаєте видалити заявку?" }, _deleteApplication);
                    break;
                }
                case 2: {
                    if ($scope.nRefSos > 0) {
                        bars.ui.alert({ text: "По даній заявці вже сформован документ по взаємозаліку з клієнтом. Видалення заявки неможливе!" });
                        break;
                    } else {
                        bars.ui.confirm({ text: "Дана заявка вже переміщена в архів. Ви дійсно бажаєте видалити заявку?" }, _deleteApplication);
                        break;
                    }
                }
                default: {
                    bars.ui.alert({ text: "Невизначений статус заявки. Видалення заявки неможливе!" });
                }
            }
        }

        var _deleteApplication = function () {
            $http.post(currencyOperationData.deleteApplicationMethod, { dfID: +$scope.dfID })
                    .then(function (response) {
                        if (!response.data.success) {
                            bars.ui.error({ text: response.data.error });
                            
                        } else {
                            $scope.findApplication();
                            bars.ui.alert({ text: "Заявка № " + $scope.dfID + " успішно видалена!" });
                        }
                            
                    });
        }

        $scope.restoreApplication = function () {
            if ($scope.sos < 0) {
                $http.post(currencyOperationData.restoreApplicationMethod, { dfID: $scope.dfID })
                    .then(function (response) {
                        if (!response.data.success) {
                            bars.ui.error({ text: response.data.error });
                        } else {
                            $scope.findApplication();
                            bars.ui.alert({ text: "Заявка № " + $scope.dfID + " успішно відновлена!" });
                        }
                            
                    });
            }
            else
                bars.ui.alert({ text: "Відновленню підлягають тільки помилково видалені заявки!" });
        }
    });