//id="content" ng-app="BarsWeb.Controllers" ng-controller="EditingFinesDFO"
angular.module('BarsWeb.Controllers', [])
.controller('InstantCards', ['$scope', '$http', function ($scope, $http) {


    //получаем продукт - первый дроп даун
    $scope.GetProduct = function () {
        $http({
            url: bars.config.urlContent("/api/Way/InstantCardsApi/GetProduct"),
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            async: false
        }).success(function (data) {
            $scope.Product = data;
            $scope.selected_product = $scope.Product[0].CODE;
            $scope.GetCardType($scope.selected_product);
            $scope.GetNBSandKV();
        }).error(function (error) {
        });
    }

    //получаем название ранча
    /*$scope.GetBranch = function () {
        $http({
            url: bars.config.urlContent("/api/Way/InstantCardsApi/GetBranch"),
            method: "GET",
            dataType: "json",
            async: false
        }).success(function (data) {
            //console.log(data);
            BRANCH = data;
             
        }).error(function (error) {
        });
    }*/

    //получаем тип картки - второй дропдаун
    $scope.GetCardType = function (test) {
         
        $.ajax({
            url: bars.config.urlContent("/api/Way/InstantCardsApi/GetCardType") + "?code=" + test,
            method: "GET",
            dataType: "json",
            async: false,
            complete: function (data) {
                $scope.CardType = data.responseJSON;
            }
        });
        $scope.GetNBSandKV();
    }
    //при визове фце-и $scope.Open() визиваем процедуру create_instant_cards
    $scope.GetInstantCards = function () {
         
             
            var CARD_AMOUNT = $scope.card_amount;
            var CARD_TYPE = $scope.selected_card_type;
            if ($scope.selected_card_type==="")
                 CARD_TYPE = $scope.CardType[0].CODE;
            console.log($("#card_type").data("kendoDropDownList").text());
            var dropdownlist = $("#card_type").data("kendoDropDownList");
            debugger;
            $http({
                url: bars.config.urlContent("/api/Way/InstantCardsApi/GetInstantCards"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ CARD_TYPE: CARD_TYPE, CARD_AMOUNT: CARD_AMOUNT }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                AlertNotifySuccess();
                $scope.card_amount = "";
            }).error(function (error) {
            });
            
        
    }
    //при изминении первого дроп дауна вызывается и ставит по дефолу имя во второй
    $scope.onSelect = function () {
        $scope.GetCardType($scope.selected_product);
        var name = $scope.CardType[0].SUB_NAME;
        $scope.selected_card_type = $scope.CardType[0].CODE;
        debugger;
        var dropdownlist = $("#card_type").data("kendoDropDownList");
        dropdownlist.datasource = $scope.CardType;
        dropdownlist.text(name + " ");
        dropdownlist.refresh();
        $scope.GetNBSandKV();
         
    }
    //кнопка "Відкрити"
    $scope.Open = function () {
        //console.log("ok");

         
        if ($scope.card_amount >0 ) {
                $scope.GetInstantCards();
        }
        else {
            AlertNotifyError();
        }
    }
    //закрівваем окно
    $scope.CloseForm = function () {
        $scope.Form.close();
    }
    //получаем валюту и Балансовий рахцнок
    $scope.GetNBSandKV = function () {
        var sProductId = $scope.selected_product;
         
        $.ajax({
            url: bars.config.urlContent("/api/Way/InstantCardsApi/GetKV") + "?sProductId=" + sProductId,
            method: "GET",
            dataType: "json",
            async: false,
            complete: function (data) {
                 
                $scope.valuta = data.responseJSON
            }
        });

        $.ajax({
            url: bars.config.urlContent("/api/Way/InstantCardsApi/GetNB") + "?sProductId=" + sProductId,
            method: "GET",
            dataType: "json",
            async: false,
            complete: function (data) {
                 
                $scope.nbs = data.responseJSON;
            }
        });
    }
    //если не ввели количество карток
    AlertNotifyError = function () {
         
        var popupNotification = $("#popupNotification").kendoNotification({
            height: 45,
            position: {
                pinned: true,
                top:20,
                right:20
            },
           
        }).data("kendoNotification");
        popupNotification.show("Введить кількість карток", "error");
    }
 AlertNotifySuccess= function () {
         
        var popupNotification = $("#popupNotification").kendoNotification({
            height: 45,
            position: {
                pinned: true,
                top:20,
                right:20
            },
           
        }).data("kendoNotification");
        popupNotification.show("Виконано","info");
    };
}]);