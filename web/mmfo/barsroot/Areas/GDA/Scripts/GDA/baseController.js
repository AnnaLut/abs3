var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("GdaBaseController", function ($controller, $scope, $http,
    settingsService, saveDataService, modelService, validationService) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    var ts = settingsService.settings().TrancheStates;
    var ur = settingsService.settings().UserRoles;


    //Кнопочка-справочник на формах 
    $scope.onHandBook = function (modelId, fieldId) {
        if (!$scope.isEditable(modelId)) { return; }
        var _data = settingsService.settings().dictHandBook[modelId][fieldId];

        var clause = _data.clause;
        //if (_data.clauseFields !== undefined) {
        //    for (var j = 0; j < _data.clauseFields.length; j++) {
        //        clause = clause.replace("{" + j + "}", $scope[modelId][_data.clauseFields[j]]);
        //    }
        //}

        bars.ui.handBook(_data.tableName, function (data) {

            for (var i = 0; i < _data.modelValueFields.length; i++) {
                var modelValueField = _data.modelValueFields[i];
                for (var k in modelValueField) {
                    $scope[modelId][k] = data[0][modelValueField[k]];
                }
            }
            if (data.length > 0) {

                $('#placementCurrency').val(data[0].KV);

            } else {
                $('#placementCurrency').val('');
            }


            $scope.$apply();
            switch (modelId) {
                case "depositDemand":
                    $("#DebitAccDepositDemand").data("kendoDropDownList").dataSource.read();
                    //$("[ng-model='DepositDemand.accDebit']").data("kendoDropDownList").value("");
                    $("[ng-model='DepositDemand.accCredit']").data("kendoDropDownList").value("");
                    break;
                case "editDepositDemand":
                    $('[ng-model="editDepositDemand.accDebit"]').data("kendoDropDownList").dataSource.read();
                    $('[ng-model="editDepositDemand.accDebit"]').data("kendoDropDownList").value("");
                    $('[ng-model="editDepositDemand.accCredit"]').data("kendoDropDownList").value("");
                    break;
                case "replacementTranche":
                    $("#DebitAccReplacement").data("kendoDropDownList").dataSource.read();
                    break;
                default:
                    $("#DebitAcc").data("kendoDropDownList").dataSource.read();
                    break;
            }

        }, {
                multiselect: false,
                clause: clause,
                columns: _data.columns
            });


        //bars.ui.handBook(_data.tableName, function (data) {
        //          for (var i = 0; i < _data.modelValueFields.length; i++) {
        //              var modelValueField = _data.modelValueFields[i];
        //              for (var k in modelValueField) {
        //                  $scope[modelId][k] = data[0][modelValueField[k]];
        //              }
        //          }

        //          $scope.$apply();

        //	switch (modelId) {
        //		case "depositDemand":
        //			$("#DebitAccDepositDemand").data("kendoDropDownList").dataSource.read();
        //			$("[ng-model='DepositDemand.accDebit']").data("kendoDropDownList").value("");
        //			$("[ng-model='DepositDemand.accCreit']").data("kendoDropDownList").value("");
        //			break;
        //		case "editDepositDemand":
        //			$('[ng-model="editDepositDemand.accDebit"]').data("kendoDropDownList").dataSource.read();
        //			$('[ng-model="editDepositDemand.accDebit"]').data("kendoDropDownList").value("");
        //			$('[ng-model="editDepositDemand.accCredit"]').data("kendoDropDownList").value("");
        //			break;
        //		case "replacementTranche":
        //			$("#DebitAccReplacement").data("kendoDropDownList").dataSource.read();
        //			break;
        //		default:
        //			$("#DebitAcc").data("kendoDropDownList").dataSource.read();
        //			break;
        //	}		                                
        //      },
        //      {
        //          multiSelect: false,
        //          clause: clause,
        //          columns: _data.columns,

        //          width: "1000px !important"
        //      });
    };

    $scope.autolog = [
        { value: true, name: 'Так' },
        { value: false, name: 'Ні' }
    ];

    $scope.getStateTranche = function (State) { return settingsService.settings().getTrancheStateLocalize(State); };
    $scope.getUserRoleLocalize = function (roleId) { return settingsService.settings().getUserRoleLocalize(roleId); };

    $scope.isEditable = function (formId) {
        if ($scope.userInfo.ROLE === ur.OPERATOR) {
            return $scope[formId].State === ts.TS_CREATED || $scope[formId].State === ts.TS_EDITING;
        }
        else if ($scope.userInfo.ROLE === ur.CONTROLLER) {
            return $scope[formId].State === ts.TS_AUTHORIZED;
        }
        return false;   //CONTROLLER_2
    };

    $scope.onClickDisabledBase = function (formId, op) {
        if ($scope[formId].State === ts.TS_ON_AUTHORIZATION || $scope[formId].State === ts.TS_CLOSED) {
            return true;
        }

        switch (op) {
            case "save":
                return !validationService.validateAllFields(formId, $scope[formId]);
            case "auth":
            case "print":
                return $scope[formId].State === ts.TS_CREATED || $scope[formId].State === ts.TS_CLOSED;
        }
    };

    $scope.isValueValid = function (formId, fieldId) {
        return validationService.validateField(formId, fieldId, $scope[formId]);
    };

    $scope.isFieldDisabled = function (formId, fieldId) {
        switch (formId) {
            case "placementTranche":
                if (fieldId == 'NumberProlongation' || fieldId == 'InterestRateProlongation' || fieldId == 'ApplyBonusProlongation') {
                    if ($("[ng-model ='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 0 || $("[ng-model ='placementTranche.IsProlongation']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'MaxSumTranche' || fieldId == 'MinReplenishmentAmount') {
                    if ($("[ng-model ='placementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == 0 || $("[ng-model ='placementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'IndividualInterestRate' || fieldId == 'Comment') {
                    if ($("[ng-model ='placementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 0 || $("[ng-model ='placementTranche.IsIndividualRate']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'IsCapitalization') {

                    if ($scope.placementTranche.NumberTrancheDays <= 29) {
                        $("#placementIsCapitalizationList").data("kendoDropDownList").enable(false);
                        $scope.placementTranche.IsCapitalization = 0;
                        $("[ng-model ='placementTranche.IsCapitalization']").data("kendoDropDownList").value(0);
                        return true;
                    } else {

                        $("#placementIsCapitalizationList").data("kendoDropDownList").enable(true);
                        return false;
                    }

                }
                else if (fieldId == 'CapitalizationTerm') {
                    if ($("[ng-model ='placementTranche.IsCapitalization']").data("kendoDropDownList").value() == 0 || $("[ng-model ='placementTranche.IsCapitalization']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }

                }
                else if (fieldId == 'ExpiryDate') {
                    var value = $('#expiryDateCalendar').value();
                    if (value)
                        return true;
                    else
                        return false;
                }
                break;

            case "replacementTranche":
                if (fieldId == 'NumberProlongation' || fieldId == 'InterestRateProlongation' || fieldId == 'ApplyBonusProlongation') {
                    if ($("[ng-model ='replacementTranche.IsProlongation']").data("kendoDropDownList").value() == 0 || $("[ng-model ='replacementTranche.IsProlongation']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'MaxSumTranche' || fieldId == 'MinReplenishmentAmount') {
                    if ($("[ng-model ='replacementTranche.isReplenishmentTranche']").data("kendoDropDownList").value() == 0 || $("[ng-model ='replacementTranche.isReplenishmentTranche']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'IndividualInterestRate' || fieldId == 'Comment') {
                    if ($("[ng-model ='replacementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 0 || $("[ng-model ='replacementTranche.IsIndividualRate']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }
                }
                else if (fieldId == 'IsCapitalization') {

                    if ($scope.replacementTranche.NumberTrancheDays <= 29) {
                        $("#replacementIsCapitalizationList").data("kendoDropDownList").enable(false);
                        $scope.replacementTranche.IsCapitalization = 0;
                        $("[ng-model ='replacementTranche.IsCapitalization']").data("kendoDropDownList").value(0);
                        return true;
                    } else {
                        $("#replacementIsCapitalizationList").data("kendoDropDownList").enable(true);
                        return false;
                    }

                }
                else if (fieldId == 'CapitalizationTerm') {
                    if ($("[ng-model ='replacementTranche.IsCapitalization']").data("kendoDropDownList").value() == 0 || $("[ng-model ='replacementTranche.IsCapitalization']").data("kendoDropDownList").value() == "") {
                        return true;
                    }
                    else { return false; }

                }
                break;
        }


    };


    $scope.userInfo = modelService.initUserInfo();
    $http.get(bars.config.urlContent('api/gda/gda/getuserinfo'))
        .success(function (response) {
            $scope.userInfo = response;
        }).error(function (response) {
        });


    //Функция клика на кнопки операция по траншам (передаём имя формы и вызываем контроллер)
    $scope.onClick = function (formId, op) {
        switch (op) {
            case "save":
                switch (formId) {
                    case "placementTranche":
                        //данные которые будем отправлять в базу
                        var _data = saveDataService.prepareData4Save(formId, $scope[formId]);

                        //поля для дальнейшей валидации значений
                        var fieldsData = {
                            ostc: $('#placementOstc').data('kendoNumericTextBox').value(),
                            frequencyPayment: $("[ng-model='placementTranche.FrequencyPayment']").data("kendoDropDownList").value(),
                            interestRate: $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(),
                            amount: $scope.placementTranche.amountTranche,
                            currency: $scope.placementTranche.CurrencyId,
                            debitAccount: $("[ng-model='placementTranche.DebitAccount']").data("kendoDropDownList").value(),
                            returnAccount: $("[ng-model ='placementTranche.ReturnAccount']").data("kendoDropDownList").value(),
                            isProlongation: $scope.placementTranche.IsProlongation,
                            numProlongation: $scope.placementTranche.NumberProlongation,
                            interestRateProlongation: $scope.placementTranche.ApplyBonusProlongation,
                            isReplenishmentTranche: $scope.placementTranche.IsReplenishmentTranche,
                            isIndividualRate: $scope.placementTranche.IsIndividualRate,
                            individualInterestRate: $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(),
                            isCapitalization: $scope.placementTranche.IsCapitalization,
                            comment: $scope.placementTranche.Comment,
                            numberTrancheDays: $scope.placementTranche.NumberTrancheDays
                        };

                        //блок где переводим дату в нужный формат
                        var expDate = $("[ng-model='placementTranche.ExpiryDate']").data("kendoDatePicker");
                        if (true) {

                            expDate.value(kendo.parseDate(_data.ExpiryDate, "dd.MM.yyyy"));
                        }
                        _data.ExpiryDate = expDate.value();

                        var lrDate = $("[ng-model='placementTranche.LastReplenishmentDate']").data("kendoDatePicker");
                        if (true) {
                            lrDate.value(kendo.parseDate(_data.LastReplenishmentDate, "dd.MM.yyyy"));
                        }
                        _data.LastReplenishmentDate = lrDate.value();

                        var startDate = $("[ng-model='placementTranche.StartDate']").data("kendoDatePicker");
                        if (true) {
                            startDate.value(kendo.parseDate(_data.StartDate, "dd.MM.yyyy"));
                        }
                        _data.StartDate = startDate.value();
                        //

                        //валидация
                        if (validationService.validation("placementTranche", "save", fieldsData) == false) {
                            return;
                        }
                        if (fieldsData.ostc < _data.AmountTranche) {
                            bars.ui.notify("Інформація", "Недостатньо коштів на рахунку!", "info", { autoHideAfter: 5 * 1000 });
                            $("#placementSaveBtn").prop("disabled", true);
                        }

                        bars.ui.loader($('#placeTranche').parent('.k-widget.k-window'), true);

                        //странная ошибка, где терялся счёт при сохранении согласно заявке COBUDPUMMSB-282 (ошибка была когда выбирали валюту со справочника, а не ввода вручную))
                        if (_data.DebitAccount == null && _data.ReturnAccount == null) {
                            _data.DebitAccount = fieldsData.debitAccount;
                            _data.ReturnAccount = fieldsData.returnAccount;
                        }

                        //передаю 0, документ ещё не подписал клиент после распечатки 
                        _data.IsSigned = 0;

                        $http.post(bars.config.urlContent("/api/gda/gda/save" + formId), _data)
                            .success(function (request) {
                                $scope.returnedProcessId = request;
                                $("#placementSaveBtn").prop("disabled", true);
                                var a = $('#placeTranche').parent('.k-widget.k-window');
                                bars.ui.loader(a, false);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Транш створено!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                $scope[formId].State = ts.TS_EDITING;
                                $scope.TimeTranshesGrid.dataSource.read();
                                $scope.TimeTranshesGrid.refresh();
                            });
                        break;
                    case "replacementTranche":
                        var fieldsData = {
                            ostc: $('#replacementOstc').data('kendoNumericTextBox').value(),
                            frequencyPayment: $("[ng-model='replacementTranche.FrequencyPayment']").data("kendoDropDownList").value(),
                            interestRate: $("[ng-model='replacementTranche.interestRate']").data("kendoNumericTextBox").value(),
                            amount: $("[ng-model='replacementTranche.amountTranche']").data("kendoNumericTextBox").value(),
                            currency: $scope.replacementTranche.CurrencyId,
                            debitAccount: $("[ng-model='replacementTranche.DebitAccount']").data("kendoDropDownList").value(),
                            returnAccount: $("[ng-model ='replacementTranche.ReturnAccount']").data("kendoDropDownList").value(),
                            isProlongation: $("[ng-model ='replacementTranche.IsProlongation']").data("kendoDropDownList").value(),
                            numProlongation: $("[ng-model ='replacementTranche.NumberProlongation']").data("kendoDropDownList").value(),
                            interestRateProlongation: $scope.replacementTranche.ApplyBonusProlongation,
                            isReplenishmentTranche: $scope.replacementTranche.isReplenishmentTranche,
                            isIndividualRate: $scope.replacementTranche.IsIndividualRate,
                            individualInterestRate: $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(),
                            isCapitalization: $scope.replacementTranche.IsCapitalization,
                            comment: $scope.replacementTranche.Comment,
                            numberTrancheDays: $scope.replacementTranche.NumberTrancheDays,
                        };

                        // Передаём данные в базу
                        $scope.requestObj.CurrencyId = $scope.replacementTranche.CurrencyId;
                        $scope.requestObj.CustomerId = $scope.replacementTranche.CustomerId;
                        $scope.requestObj.DebitAccount = $scope.replacementTranche.DebitAccount;
                        $scope.requestObj.NumberTrancheDays = $scope.replacementTranche.NumberTrancheDays;
                        $scope.requestObj.AmountTranche = $scope.replacementTranche.amountTranche;
                        $scope.requestObj.InterestRate = $scope.replacementTranche.interestRate;
                        $scope.requestObj.IsProlongation = $scope.replacementTranche.IsProlongation;
                        $scope.requestObj.NumberProlongation = $("[ng-model='replacementTranche.NumberProlongation']").data("kendoDropDownList").value();
                        $scope.requestObj.InterestRateProlongation = $scope.replacementTranche.InterestRateProlongation;
                        $scope.requestObj.IsReplenishmentTranche = $scope.replacementTranche.isReplenishmentTranche;
                        $scope.requestObj.ApplyBonusProlongation = $scope.replacementTranche.ApplyBonusProlongation;
                        $scope.requestObj.FrequencyPayment = $scope.replacementTranche.FrequencyPayment;
                        $scope.requestObj.IsIndividualRate = $scope.replacementTranche.IsIndividualRate;
                        $scope.requestObj.IndividualInterestRate = $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value();
                        $scope.requestObj.IsCapitalization = $scope.replacementTranche.IsCapitalization;
                        $scope.requestObj.Comment = $scope.replacementTranche.Comment;
                        $scope.requestObj.PrimaryAccount = $scope.replacementTranche.PrimaryAccount;
                        $scope.requestObj.DebitAccount = $scope.replacementTranche.DebitAccount;
                        $scope.requestObj.ReturnAccount = $scope.replacementTranche.ReturnAccount;
                        $scope.requestObj.InterestAccount = $scope.replacementTranche.InterestAccount;
                        $scope.requestObj.Branch = $scope.replacementTranche.Branch;
                        $scope.requestObj.LastReplenishmentDate = $("#dateReplenishmentToReplacement").data("kendoDatePicker").value();
                        $scope.requestObj.IsSigned = $scope.replacementTranche.IsSigned;

                        if (validationService.validation("replacementTranche", "save", fieldsData) == false) {
                            return;
                        }
                        if (fieldsData.ostc < fieldsData.amount) {
                            bars.ui.notify("Інформація", "Недостатньо коштів на рахунку!", "info", { autoHideAfter: 5 * 1000 });
                        }

                        var expDate = $("#dateReturning").data("kendoDatePicker");
                        if (true) {
                            expDate.value(kendo.parseDate($scope.replacementTranche.ExpiryDate, "dd.MM.yyyy"));
                        }
                        $scope.requestObj.ExpiryDate = expDate.value();
                        var lrDate = $("#dateReplenishmentToReplacement").data("kendoDatePicker");
                        if (true) {
                            lrDate.value(kendo.parseDate($scope.replacementTranche.LastReplenishmentDate, "dd.MM.yyyy"));
                        }
                        $scope.requestObj.LastReplenishmentDate = lrDate.value();
                        var startDate = $("#datePlacement").data("kendoDatePicker");
                        if (true) {
                            startDate.value(kendo.parseDate($scope.replacementTranche.StartDate, "dd.MM.yyyy"));
                        }
                        $scope.requestObj.StartDate = startDate.value();
                        bars.ui.loader($('#replaceTranche').parent('.k-widget.k-window'), true);

                        $http.post(bars.config.urlContent("/api/gda/gda/saveplacementtranche"), $scope.requestObj)
                            .success(function (request) {
                                $scope.returnedProcessId = request;
                                $("#replacementSaveBtn").prop("disabled", true);
                                var a = $('#replaceTranche').parent('.k-widget.k-window');
                                bars.ui.loader(a, false);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Транш відредаговано!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                $('#replacementTrancheBtn').prop("disabled", true);
                                var form = settingsService.settings().formWindows[formId];
                                $scope[form].close();
                                $("#timetranchesgrid").data("kendoGrid").dataSource.read();
                            });
                        break;
                    case "replenishmentTranche":
                        // Передаём данные в базу
                        $scope.requestObj.ActionDate = $("[ng-model='replenishmentTranche.ActionDate']").data("kendoDatePicker").value();
                        $scope.requestObj.CurrencyId = $scope.replenishmentTranche.CurrencyId;
                        $scope.requestObj.CustomerId = $scope.replenishmentTranche.CustomerId;
                        $scope.requestObj.DebitAccount = $("[ng-model='replenishmentTranche.DebitAccount']").data("kendoDropDownList").value();

                        var ExpiryDate = kendo.parseDate($scope.requestObj.ExpiryDate, "dd.MM.yyyy"),
                            LastReplenishmentDate = kendo.parseDate($scope.requestObj.LastReplenishmentDate, "dd.MM.yyyy"),
                            StartDate = kendo.parseDate($scope.requestObj.StartDate, "dd.MM.yyyy");

                        // Передаём данные в базу
                        $scope.requestObj.NumberTrancheDays = $scope.replenishmentTranche.NumberTrancheDays;
                        $scope.requestObj.AmountTranche = $scope.replenishmentTranche.amountTranche;
                        $scope.requestObj.InterestRate = $scope.replenishmentTranche.interestRate;
                        $scope.requestObj.IsProlongation = $scope.replenishmentTranche.isProlongation;
                        $scope.requestObj.NumberProlongation = $scope.replenishmentTranche.NumberProlongation;
                        $scope.requestObj.InterestRateProlongation = $scope.replenishmentTranche.InterestRateProlongation;
                        $scope.requestObj.IsReplenishmentTranche = $scope.replenishmentTranche.isReplenishmentTranche;
                        $scope.requestObj.FrequencyPayment = $scope.replenishmentTranche.FrequencyPayment;
                        $scope.requestObj.IsIndividualRate = $scope.replenishmentTranche.IsIndividualRate;
                        $scope.requestObj.IndividualInterestRate = $scope.replenishmentTranche.IndividualInterestRate;
                        $scope.requestObj.IsCapitalization = $scope.replenishmentTranche.IsCapitalization;
                        $scope.requestObj.Comment = $scope.replenishmentTranche.Comment;
                        $scope.requestObj.PrimaryAccount = $scope.replenishmentTranche.PrimaryAccount;
                        $scope.requestObj.ReturnAccount = $scope.replenishmentTranche.ReturnAccount;
                        $scope.requestObj.InterestAccount = $scope.replenishmentTranche.InterestAccount;
                        // при создании передаём 0, потому документ ещё не подписан 
                        $scope.requestObj.IsSigned = 0;

                        $http.post(bars.config.urlContent("/api/gda/gda/saverepleishmenttranche"), $scope.requestObj)
                            .success(function (request) {
                                var a = $('#replenishTranche').parent('.k-widget.k-window');
                                bars.ui.loader(a, true);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Поповнення траншу збережено!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                bars.ui.loader(a, false);
                                var form = settingsService.settings().formWindows[formId]
                                $scope[form].close();
                                $("#replenishmentHistoryGrid").data("kendoGrid").dataSource.read();
                            }
                            );
                        break;
                    case "earlyRepaymentTranche":
                        var fieldsData = {
                            comment: $scope.earlyRepaymentTranche.AdditionalComment,
                            penaltyRate: $scope.earlyRepaymentTranche.PenaltyRate
                        };

                        $scope.requestObj.CurrencyId = $scope.earlyRepaymentTranche.CurrencyId;
                        $scope.requestObj.CustomerId = $scope.earlyRepaymentTranche.CustomerId;
                        $scope.requestObj.DebitAccount = $scope.earlyRepaymentTranche.DebitAccount;

                        //ANDRII HNATIUK
                        $scope.requestObj.ActionDate = $("[ng-model='earlyRepaymentTranche.StartDate']").data("kendoDatePicker").value();
                        //
                        $scope.requestObj.NumberTrancheDays = $scope.earlyRepaymentTranche.NumberTrancheDays;
                        $scope.requestObj.AmountTranche = $scope.earlyRepaymentTranche.amountTranche;
                        $scope.requestObj.InterestRate = $scope.earlyRepaymentTranche.interestRate;
                        $scope.requestObj.IsProlongation = $scope.earlyRepaymentTranche.isProlongation;
                        $scope.requestObj.NumberProlongation = $scope.earlyRepaymentTranche.NumberProlongation;
                        $scope.requestObj.InterestRateProlongation = $scope.earlyRepaymentTranche.InterestRateProlongation;
                        $scope.requestObj.IsReplenishmentTranche = $scope.earlyRepaymentTranche.isReplenishmentTranche;
                        $scope.requestObj.LastReplenishmentDate = $scope.earlyRepaymentTranche.LastReplenishmentDate;
                        $scope.requestObj.FrequencyPayment = $scope.earlyRepaymentTranche.FrequencyPayment;
                        $scope.requestObj.IsIndividualRate = $scope.earlyRepaymentTranche.IsIndividualRate ? 1 : 0;
                        $scope.requestObj.IsCapitalization = $scope.earlyRepaymentTranche.IsCapitalization;
                        $scope.requestObj.PrimaryAccount = $scope.earlyRepaymentTranche.PrimaryAccount;
                        $scope.requestObj.DebitAccount = $scope.earlyRepaymentTranche.DebitAccount;
                        $scope.requestObj.ReturnAccount = $("[ng-model='earlyRepaymentTranche.ReturnAccount']").data("kendoDropDownList").value();
                        $scope.requestObj.InterestAccount = $scope.earlyRepaymentTranche.InterestAccount;
                        $scope.requestObj.PenaltyRate = $('[ng-model="earlyRepaymentTranche.PenaltyRate"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.AdditionalComment = $scope.earlyRepaymentTranche.AdditionalComment;
                        $scope.requestObj.Comment = $scope.earlyRepaymentTranche.Comment;
                        $scope.requestObj.IsSigned = $scope.earlyRepaymentTranche.IsSigned;


                        if (validationService.validation("earlyRepaymentTranche", "save", fieldsData) == false) {
                            return;
                        }

                        $http.post(bars.config.urlContent("/api/gda/gda/saveearlyrepaymenttranche"), $scope.requestObj)
                            .success(function (request) {
                                bars.ui.loader('body', true);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Дострокове повернення Траншу збережено!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                bars.ui.loader('body', false);
                                var form = settingsService.settings().formWindows[formId];
                                $scope[form].close();
                                $("#timetranchesgrid").data("kendoGrid").dataSource.read();
                                $("#timetranchesgrid").data("kendoGrid").refresh();
                                $('#earlyRepaymentTrancheBtn').prop('disabled', true);
                                $('#replenishmentTrancheBtn').prop('disabled', true);
                            }
                            );
                        break;
                    case "editreplenishmentTranche":
                        $scope.requestObj.DebitAccount = $('[ng-model="editreplenishmentTranche.DebitAccount"]').data('kendoDropDownList').value();
                        $scope.requestObj.ActionDate = $("[ng-model='editreplenishmentTranche.ActionDate']").data("kendoDatePicker").value();
                        $scope.requestObj.AmountTranche = $scope.editreplenishmentTranche.amountTranche;
                        $scope.requestObj.IsSigned = $scope.editreplenishmentTranche.IsSigned;

                        $http.post(bars.config.urlContent("/api/gda/gda/saverepleishmenttranche"), $scope.requestObj)
                            .success(function (request) {
                                bars.ui.loader('body', true);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Поповнення траншу відредаговано!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                bars.ui.loader('body', false);
                                var form = settingsService.settings().formWindows[formId]
                                $scope[form].close();
                                $("#replenishmentHistoryGrid").data("kendoGrid").dataSource.read();
                            }
                            );
                        break;

                    case "depositDemand":
                        // Очищаем объект, потому после того как провели операции в траншами, нужно передавать только данные, которые присваиваються ниже
                        $scope.requestObj = {};
                        //
                        $scope.requestObj.StartDate = $('[ng-model="depositDemand.dboDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.CurrencyId = $scope.depositDemand.currency;
                        $scope.requestObj.ReturnAccount = $scope.DepositDemand.accCredit;
                        $scope.requestObj.ReturnAccount = $('[ng-model="DepositDemand.accCredit"]').data('kendoDropDownList').value();
                        $scope.requestObj.CustomerId = $scope.depositDemand.clientRnk;
                        $scope.requestObj.FrequencyPayment = 1;
                        $scope.requestObj.IsIndividualRate = $scope.depositDemand.individualInterestRate === true ? 1 : 0;
                        $scope.requestObj.TransferDayRegistration = $scope.depositDemand.replenishmentOnDayRegistration === true ? 1 : 0;
                        $scope.requestObj.CalculationType = $scope.depositDemand.calculationType;
                        $scope.requestObj.IndividualInterestRate = $('[k-ng-model="depositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.Comment = $scope.depositDemand.comment;
                        $scope.requestObj.ProcessId = null;
                        $scope.requestObj.IsSigned = 0;


                        bars.ui.loader($('#depositDemandOpen').parent('.k-widget.k-window'), true);
                        $http.post(bars.config.urlContent("/api/gda/gda/savedepositdemand"), $scope.requestObj)
                            .success(function (request) {

                                $scope.returnedProcessIdDepositDemand = request;
                                var a = $('#depositDemandOpen').parent('.k-widget.k-window');
                                bars.ui.loader(a, false);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Вклад на вимогу відкрито!</span>", title: "Операція успішна", winType: '', height: '85px' });

                                $("#depositDemandSaveBtn").prop("disabled", true);
                                var form = settingsService.settings().formWindows[formId]

                                $("[kendo-grid='RequireDepositGrid']").data("kendoGrid").dataSource.read();
                            });

                        break;
                    case "editDepositDemand":
                        // Очищаем объект, потому после того как провели операции в траншами, нужно передавать только данные, которые присваиваються ниже
                        $scope.requestObj = {};
                        //
                        $scope.requestObj.StartDate = $('[ng-model="editDepositDemand.dboDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.CurrencyId = $scope.editDepositDemand.currency;
                        $scope.requestObj.ReturnAccount = $scope.editDepositDemand.accCredit;
                        $scope.requestObj.ReturnAccount = $('[ng-model="editDepositDemand.accCredit"]').data('kendoDropDownList').value();
                        $scope.requestObj.CustomerId = $scope.editDepositDemand.clientRnk;
                        $scope.requestObj.FrequencyPayment = 1;
                        $scope.requestObj.IsIndividualRate = $scope.editDepositDemand.IsIndividualRate === true ? 1 : 0;
                        $scope.requestObj.TransferDayRegistration = $scope.editDepositDemand.replenishmentOnDayRegistration === true ? 1 : 0;
                        $scope.requestObj.CalculationType = $scope.editDepositDemand.calculationType;
                        $scope.requestObj.IndividualInterestRate = $('[k-ng-model="editDepositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.Comment = $scope.editDepositDemand.Comment;
                        $scope.requestObj.ProcessId = $scope.processId;
                        $scope.requestObj.Branch = $scope.editDepositDemand.Branch;
                        $scope.requestObj.PrimaryAccount = $scope.editDepositDemand.acc;
                        $scope.requestObj.IsSigned = $scope.editDepositDemand.IsSigned;

                        if ($('[ng-model="editDepositDemand.IsIndividualRate"]').is(":checked") == true) {
                            $scope.requestObj.Comment = $scope.editDepositDemand.Comment;
                            $scope.requestObj.IsIndividualRate = $scope.editDepositDemand.IsIndividualRate === true ? 1 : 0;
                            $scope.requestObj.IndividualInterestRate = $('[k-ng-model="editDepositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        } else {
                            $scope.requestObj.Comment = null;
                            $scope.requestObj.IsIndividualRate = 0;
                            $scope.requestObj.IndividualInterestRate = null;
                        }

                        bars.ui.loader($('#editDepositDemand').parent('.k-widget.k-window'), true);
                        $http.post(bars.config.urlContent("/api/gda/gda/savedepositdemand"), $scope.requestObj)
                            .success(function (request) {
                                $scope.returnedProcessIdDepositDemand = request;
                                var a = $('#editDepositDemand').parent('.k-widget.k-window');

                                bars.ui.loader(a, false);
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Вклад на вимогу відредаговано!</span>", title: "Операція успішна", winType: '', height: '85px' });


                                $("#editDepositDemandSaveBtn").prop("disabled", true);
                                var form = settingsService.settings().formWindows[formId];
                                $scope[form].close();

                                $("[kendo-grid='RequireDepositGrid']").data("kendoGrid").dataSource.read();

                            });
                        $('#closeDepositBtn').prop("disabled", true);
                        $('#editDepositBtn').prop("disabled", true);
                        $('#changeDepositBtn').prop("disabled", true);
                        $('#printDepositBtn').prop("disabled", true);
                        break;
                    case "closeDepositDemand":
                        $scope.requestObj.ActionDate = $('[ng-model="closeDepositDemand.actionDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.ObjectId = $scope.depositId;
                        $scope.requestObj.IsSigned = $('[ng-model="closeDepositDemand.IsSigned"]').data('kendoDropDownList').value();
                        var postObj = {
                            deposite: $scope.requestObj,
                            processId: null,
                            objectId: $scope.depositId
                        };

                        $http.post(bars.config.urlContent("/api/gda/gda/closedeposit"), postObj)
                            .success(function (request) {
                                $scope.returnedProcessIdDepositDemand = request;
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Закриття вкладу на вимогу збережено!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                var form = settingsService.settings().formWindows[formId];
                                $scope[form].close();
                                $("[kendo-grid='RequireDepositGrid']").data("kendoGrid").dataSource.read();
                            });
                        break;
                    case "changeDepositDemand":

                        var _data = saveDataService.prepareData4Save(formId, $scope[formId]);
                        if ($scope.processId == null || $scope.processId == "") {

                        } else {
                            $scope.returnedProcessId = $scope.processId;
                        }
                        _data.ProcessId = $scope.returnedProcessId;
                        $http.post(bars.config.urlContent("/api/gda/gda/changecalculationtype"), _data)
                            .success(function (request) {
                                $scope.returnedProcessIdDepositDemand = request;
                                bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Метод нарахування відсотків змінено!</span>", title: "Операція успішна", winType: '', height: '85px' });
                                var form = settingsService.settings().formWindows[formId]
                                $("[kendo-grid='RequireDepositGrid']").data("kendoGrid").dataSource.read();
                            });
                        break;
                }
                break;

            //розрахувати ставку
            case "count":
                switch (formId) {
                    case "placementTranche":
                        var _data = saveDataService.prepareData4Save(formId, $scope[formId]);
                        var fieldsData = {
                            ostc: $('#placementOstc').data('kendoNumericTextBox').value(),
                            frequencyPayment: $("[ng-model='placementTranche.FrequencyPayment']").data("kendoDropDownList").value(),
                            interestRate: $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(),
                            amount: $scope.placementTranche.amountTranche,
                            currency: $scope.placementTranche.CurrencyId,
                            debitAccount: $("[ng-model='placementTranche.DebitAccount']").data("kendoDropDownList").value(),
                            returnAccount: $("[ng-model ='placementTranche.ReturnAccount']").data("kendoDropDownList").value(),
                            isProlongation: $scope.placementTranche.IsProlongation,
                            numProlongation: $("[ng-model ='placementTranche.NumberProlongation']").data("kendoDropDownList").value(),
                            interestRateProlongation: $scope.placementTranche.InterestRateProlongation,
                            isReplenishmentTranche: $scope.placementTranche.IsReplenishmentTranche,
                            isIndividualRate: $scope.placementTranche.IsIndividualRate,
                            individualInterestRate: $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(),
                            isCapitalization: $scope.placementTranche.IsCapitalization,
                            comment: $scope.placementTranche.Comment,
                            numberTrancheDays: $scope.placementTranche.NumberTrancheDays
                        };

                        //меняем разделитель на точку в любом случае, потому что базе нужна только точка
                        $scope.placementTranche.amountTranche = $scope.placementTranche.amountTranche.replace(/,/g, '.');

                        //Когда расчитали ставку по индивидуальной, но потом запретили индивилд ставку и снова нажали кнопку "Розрахувати", тогда достаём ставку пролонгации с темплейта выпадающего списка
                        var value = $("[ng-model ='placementTranche.NumberProlongation']").data("kendoDropDownList").value();
                        var length = $("[ng-model ='placementTranche.NumberProlongation']").data("kendoDropDownList").dataSource._data.length;
                        if ($scope.placementTranche.InterestRateProlongation == null) {
                            for (var i = 0; i < length; i++) {
                                var item = $("[ng-model ='placementTranche.NumberProlongation']").data("kendoDropDownList").dataSource._data[i].NUMBERPROLONGATION;
                                if (value == item) {
                                    $scope.placementTranche.InterestRateProlongation = item;
                                    break;
                                }
                            }
                        }
                        //и присваиваем объекту это значение руками для успешной валидации 
                        fieldsData.interestRateProlongation = $scope.placementTranche.InterestRateProlongation;
                        //

                        var expDate = $("[ng-model='placementTranche.ExpiryDate']").data("kendoDatePicker");
                        if (true) {

                            expDate.value(kendo.parseDate(_data.ExpiryDate, "dd.MM.yyyy"));
                        }
                        _data.ExpiryDate = expDate.value();
                        var lrDate = $("#dateReplenishmentToPlacement").data("kendoDatePicker");
                        _data.LastReplenishmentDate = lrDate.value();

                        var startDate = $("[ng-model='placementTranche.StartDate']").data("kendoDatePicker");
                        if (true) {
                            startDate.value(kendo.parseDate(_data.StartDate, "dd.MM.yyyy"));
                        }
                        _data.StartDate = startDate.value();

                        if (validationService.validation("placementTranche", "count", fieldsData) == false) {
                            return;
                        }

                        $http.post(bars.config.urlContent("/api/gda/gda/count" + formId), _data).success(function (request) {
                            $scope.placementTranche.InterestRate = request.InterestRate;
                            $scope.placementTranche.IndividualInterestRate = request.IndividualInterestRate;
                            $scope.placementTranche.InterestRateBonus = request.InterestRateBonus;
                            $scope.placementTranche.BonusDescription = request.BonusDescription;
                            $scope.placementTranche.InterestRateGeneral = request.InterestRateGeneral;
                            $scope.placementTranche.InterestRatePayment = request.InterestRatePayment;
                            $scope.placementTranche.InterestRateProlongation = request.InterestRateProlongation;
                            $scope.placementTranche.InterestRateReplenishment = request.InterestRateReplenishment;
                            $scope.placementTranche.InterestRateCapitalization = request.InterestRateCapitalization;
                            $scope.placementTranche.InterestRateProlongationBonus = request.InterestRateProlongationBonus;

                            if (request.IndividualInterestRate !== null) {
                                $scope.placementTranche.InterestRate = null;
                                $scope.placementTranche.InterestRateProlongation = null;
                                $scope.placementTranche.InterestRateCapitalization = null;

                                $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(request.IndividualInterestRate);
                            }
                            else if (request.IndividualInterestRate === null) {
                                if (request.InterestRate == "") {

                                    $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(0);

                                    bars.ui.alert({ text: "Відсутні потрібні дані у довідниках для рохрахунку ставки " });

                                }

                                if (request.InterestRate != "") {

                                    $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(request.InterestRate);
                                    $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").trigger('change');
                                }
                            }
                            $('#showDetailsPercentBtn').removeProp('disabled');
                        });

                        if (fieldsData.isProlongation == 1 && fieldsData.isIndividualRate == 1) {
                            $('[ng-model="placementTranche.IsProlongation"]').data('kendoDropDownList').value(0);
                            $scope.placementTranche.IsProlongation = 0;
                            $scope.placementTranche.NumberProlongation = null;
                            $('[ng-model="placementTranche.NumberProlongation"]').data('kendoDropDownList').value(0);
                            $('#applyprologField').val('');
                            $('[ng-model="placementTranche.NumberProlongation"]').data('kendoDropDownList').enable(false);
                        }

                        break;
                    case "replacementTranche":
                        var fieldsData = {
                            ostc: $('#replacementOstc').data('kendoNumericTextBox').value(),
                            frequencyPayment: $("[ng-model='replacementTranche.FrequencyPayment']").data("kendoDropDownList").value(),
                            interestRate: $("[ng-model='replacementTranche.interestRate']").data("kendoNumericTextBox").value(),
                            amount: $("[ng-model='replacementTranche.amountTranche']").data("kendoNumericTextBox").value(),
                            currency: $scope.replacementTranche.CurrencyId,
                            debitAccount: $("[ng-model='replacementTranche.DebitAccount']").data("kendoDropDownList").value(),
                            returnAccount: $("[ng-model ='replacementTranche.ReturnAccount']").data("kendoDropDownList").value(),
                            isProlongation: $scope.replacementTranche.IsProlongation,
                            numProlongation: $("[ng-model ='replacementTranche.NumberProlongation']").data("kendoDropDownList").value(),
                            interestRateProlongation: $scope.replacementTranche.InterestRateProlongation,
                            isReplenishmentTranche: $scope.replacementTranche.isReplenishmentTranche,
                            isIndividualRate: $scope.replacementTranche.IsIndividualRate,
                            individualInterestRate: $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(),
                            isCapitalization: $scope.replacementTranche.IsCapitalization,
                            comment: $scope.replacementTranche.Comment,
                            numberTrancheDays: $scope.replacementTranche.NumberTrancheDays
                        };

                        $scope.requestObj.CurrencyId = $scope.replacementTranche.CurrencyId;
                        $scope.requestObj.CustomerId = $scope.replacementTranche.CustomerId;
                        $scope.requestObj.DebitAccount = $scope.replacementTranche.DebitAccount;
                        $scope.requestObj.NumberTrancheDays = $scope.replacementTranche.NumberTrancheDays;
                        $scope.requestObj.AmountTranche = $scope.replacementTranche.amountTranche;
                        $scope.requestObj.InterestRate = $scope.replacementTranche.InterestRate;
                        $scope.requestObj.IsProlongation = $scope.replacementTranche.IsProlongation;
                        $scope.requestObj.NumberProlongation = $("[ng-model ='replacementTranche.NumberProlongation']").data("kendoDropDownList").value();
                        $scope.replacementTranche.NumberProlongation = $scope.requestObj.NumberProlongation;
                        $scope.requestObj.InterestRateProlongation = $("[ng-model ='replacementTranche.NumberProlongation']").data("kendoDropDownList").value();
                        $scope.requestObj.ApplyBonusProlongation = $scope.replacementTranche.ApplyBonusProlongation;
                        $scope.requestObj.IsReplenishmentTranche = $scope.replacementTranche.isReplenishmentTranche;
                        $scope.requestObj.FrequencyPayment = $scope.replacementTranche.FrequencyPayment;
                        $scope.requestObj.IsIndividualRate = $scope.replacementTranche.IsIndividualRate;
                        $scope.requestObj.IndividualInterestRate = $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value();
                        $scope.requestObj.IsCapitalization = $scope.replacementTranche.IsCapitalization;
                        $scope.requestObj.Comment = $scope.replacementTranche.Comment;
                        $scope.requestObj.PrimaryAccount = $scope.replacementTranche.PrimaryAccount;
                        $scope.requestObj.DebitAccount = $scope.replacementTranche.DebitAccount;
                        $scope.requestObj.ReturnAccount = $scope.replacementTranche.ReturnAccount;
                        $scope.requestObj.InterestAccount = $scope.replacementTranche.InterestAccount;
                        $scope.requestObj.Branch = $scope.replacementTranche.Branch;

                        if (validationService.validation("replacementTranche", "count", fieldsData) == false) {
                            return;
                        }
                        var expDate = $("#dateReturning").data("kendoDatePicker");
                        if (true) {
                            expDate.value(kendo.parseDate($scope.replacementTranche.ExpiryDate, "dd.MM.yyyy"));
                        }
                        $scope.requestObj.ExpiryDate = expDate.value();
                        var lrDate = $("#dateReplenishmentToReplacement").data("kendoDatePicker");
                        $scope.requestObj.LastReplenishmentDate = lrDate.value();
                        var startDate = $("#datePlacement").data("kendoDatePicker");
                        if (true) {
                            startDate.value(kendo.parseDate($scope.replacementTranche.StartDate, "dd.MM.yyyy"));
                        }
                        $scope.requestObj.StartDate = startDate.value();

                        $http.post(bars.config.urlContent("/api/gda/gda/countplacementTranche"), $scope.replacementTranche).success(function (request) {
                            $scope.replacementTranche.interestRate = request.InterestRate;
                            $scope.replacementTranche.IndividualInterestRate = request.IndividualInterestRate;
                            $scope.replacementTranche.InterestRateBonus = request.InterestRateBonus;
                            $scope.replacementTranche.BonusDescription = request.BonusDescription;
                            $scope.replacementTranche.InterestRateGeneral = request.InterestRateGeneral;
                            $scope.replacementTranche.InterestRatePayment = request.InterestRatePayment;
                            $scope.replacementTranche.InterestRateProlongation = request.InterestRateProlongation;
                            $scope.replacementTranche.InterestRateReplenishment = request.InterestRateReplenishment;
                            $scope.replacementTranche.InterestRateCapitalization = request.InterestRateCapitalization;

                            if (request.IndividualInterestRate !== null) {
                                $("[ng-model='replacementTranche.interestRate']").data("kendoNumericTextBox").value(request.IndividualInterestRate);
                            }
                            else if (request.IndividualInterestRate === null) {
                                if (request.InterestRate == "") {
                                    $("[ng-model='replacementTranche.interestRate']").data("kendoNumericTextBox").value(0);
                                    bars.ui.alert({ text: "Відсутні потрібні дані у довідниках для рохрахунку ставки " });
                                }
                                if (request.InterestRate != "") {
                                    $("[ng-model='replacementTranche.interestRate']").data("kendoNumericTextBox").value(request.InterestRate);
                                }
                            }

                        });
                        break;
                    case "depositDemand":
                        $scope.requestObj.StartDate = $('[ng-model="depositDemand.dboDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.CurrencyId = $scope.depositDemand.currency;
                        $scope.requestObj.ReturnAccount = $scope.DepositDemand.accCredit;
                        $scope.requestObj.DebitAccount = $scope.DepositDemand.accDebit;
                        $scope.requestObj.CustomerId = $scope.depositDemand.clientRnk;
                        $scope.requestObj.FrequencyPayment = 1;
                        $scope.requestObj.IsIndividualRate = $scope.depositDemand.individualInterestRate === true ? 1 : 0;
                        $scope.requestObj.TransferDayRegistration = $scope.depositDemand.replenishmentOnDayRegistration === true ? 1 : 0;
                        $scope.requestObj.CalculationType = 1;
                        $scope.requestObj.IndividualInterestRate = $('[k-ng-model="depositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.Comment = $scope.depositDemand.comment;

                        $http.post(bars.config.urlContent("/api/gda/gda/countdepositDemand"), $scope.requestObj).success(function (request) {
                            $scope.depositDemand.interestRate = request.InterestRate;
                            $scope.depositDemand.individualInterestRateValue = request.IndividualInterestRate;

                            if (request.IndividualInterestRate != "") {

                                $("[ng-model='depositDemand.interestRate']").data("kendoNumericTextBox").value(request.IndividualInterestRate);
                            }
                            if (request.IndividualInterestRate == "") {

                                if (request.InterestRate == "") {

                                    $("[ng-model='depositDemand.interestRate']").data("kendoNumericTextBox").value(0);

                                    bars.ui.alert({ text: "Відсутні потрібні дані у довідниках для рохрахунку ставки " });

                                }
                                if (request.InterestRate != "") {

                                    $("[ng-model='depositDemand.interestRate']").data("kendoNumericTextBox").value(request.InterestRate);
                                }
                            }
                        });
                        break;
                    case "closeDepositDemand":
                        $scope.requestObj.StartDate = $('[ng-model="closeDepositDemand.dboDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.CurrencyId = $scope.closeDepositDemand.currency;
                        $scope.requestObj.ReturnAccount = $scope.closeDepositDemand.accCredit;
                        $scope.requestObj.DebitAccount = $scope.closeDepositDemand.accDebit;
                        $scope.requestObj.AmountDeposit = $('[k-ng-model="closeDepositDemand.sumValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.CustomerId = $scope.closeDepositDemand.clientRnk;
                        $scope.requestObj.FrequencyPayment = 1;
                        $scope.requestObj.IsIndividualRate = $scope.closeDepositDemand.individualInterestRate === true ? 1 : 0;
                        $scope.requestObj.TransferDayRegistration = $scope.closeDepositDemand.replenishmentOnDayRegistration === true ? 1 : 0;
                        $scope.requestObj.CalculationType = 1;
                        $scope.requestObj.IndividualInterestRate = $('[k-ng-model="closeDepositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.Comment = $scope.closeDepositDemand.comment;

                        $http.post(bars.config.urlContent("/api/gda/gda/countdepositDemand"), $scope.requestObj).success(function (request) {
                            $scope.closeDepositDemand.interestRate = request.InterestRate;
                            $scope.closeDepositDemand.individualInterestRateValue = request.IndividualInterestRate;


                            if (request.IndividualInterestRate !== "") {

                                $("[ng-model='closeDepositDemand.interestRate']").data("kendoNumericTextBox").value(request.IndividualInterestRate);
                            }
                            else if (request.IndividualInterestRate === "") {

                                if (request.InterestRate == "") {

                                    $("[ng-model='closeDepositDemand.interestRate']").data("kendoNumericTextBox").value(0);

                                    bars.ui.alert({ text: "Поле 'Строк дії' не заповнене!" });
                                }
                                if (request.InterestRate != "") {

                                    $("[ng-model='closeDepositDemand.interestRate']").data("kendoNumericTextBox").value(request.InterestRate);
                                }

                            }
                        });
                        break;
                    case "editDepositDemand":
                        $scope.requestObj.StartDate = $('[ng-model="editDepositDemand.dboDate"]').data('kendoDatePicker').value();
                        $scope.requestObj.CurrencyId = $scope.editDepositDemand.currency;
                        $scope.requestObj.ReturnAccount = $scope.editDepositDemand.accCredit;
                        $scope.requestObj.DebitAccount = $scope.editDepositDemand.accDebit;
                        $scope.requestObj.AmountDeposit = $('[k-ng-model="editDepositDemand.sumValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.CustomerId = $scope.editDepositDemand.clientRnk;
                        $scope.requestObj.FrequencyPayment = 1;
                        $scope.requestObj.IsIndividualRate = $scope.editDepositDemand.individualInterestRate === true ? 1 : 0;
                        $scope.requestObj.TransferDayRegistration = $scope.editDepositDemand.replenishmentOnDayRegistration === true ? 1 : 0;
                        $scope.requestObj.CalculationType = 1;
                        $scope.requestObj.IndividualInterestRate = $('[k-ng-model="editDepositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value();
                        $scope.requestObj.Comment = $scope.editDepositDemand.comment;
                        $scope.requestObj.ProcessId = $scope.processId;
                        $

                        $http.post(bars.config.urlContent("/api/gda/gda/countdepositDemand"), $scope.requestObj).success(function (request) {

                            $scope.editDepositDemand.interestRate = request.InterestRate;
                            $scope.editDepositDemand.individualInterestRateValue = request.IndividualInterestRate;


                            if (request.IndividualInterestRate !== "") {

                                $("[ng-model='editDepositDemand.interestRate']").data("kendoNumericTextBox").value(request.IndividualInterestRate);
                            }
                            else if (request.IndividualInterestRate === "") {

                                if (request.InterestRate == "") {

                                    $("[ng-model='editDepositDemand.interestRate']").data("kendoNumericTextBox").value(0);

                                    bars.ui.alert({ text: "Відсутні потрібні дані у довідниках для рохрахунку ставки " });

                                }
                                if (request.InterestRate != "") {

                                    $("[ng-model='editDepositDemand.interestRate']").data("kendoNumericTextBox").value(request.InterestRate);
                                }
                            }
                        });
                        break;
                }
                break;


            //Передача на авторизацию
            case "auth":
                if (formId == "depositDemand") {

                    $http.post(bars.config.urlContent("/api/gda/gda/authdeposit"), $scope.returnedProcessIdDepositDemand.toString()).then(function (request) {
                        $scope[formId].State = ts.TS_ON_AUTHORIZATION;
                        bars.ui.loader('body', true);
                        bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Успішно передано на авторизацію!</span>", title: "Операція успішна", winType: '', height: '85px' });
                        bars.ui.loader('body', false);
                        var form = settingsService.settings().formWindows[formId];

                        $scope[form].close();

                        $('[kendo-grid="RequireDepositGrid"]').data("kendoGrid").dataSource.read();

                    }, function (error) {

                    });

                } else if (formId == "closeDepositDemand") {
                    $scope.getProccesId = function () {
                        $http.get(bars.config.urlContent("/api/gda/gda/getclosingdepositdemand?processId=" + $scope.processId + "&objectId=" + $scope.depositId)).then(function (request) {
                            $scope.requestObj = request.data;
                        }, function (error) { });
                        return $scope.requestObj.ProcessId;
                    };

                    $scope.returnedProcessIdDepositDemand = $scope.getProccesId();

                    $http.post(bars.config.urlContent("/api/gda/gda/AuthDepositClose"), $scope.returnedProcessIdDepositDemand.toString()).then(function (request) {

                        $scope[formId].State = ts.TS_ON_AUTHORIZATION;
                        bars.ui.loader('body', true);
                        bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Успішно передано на авторизацію!</span>", title: "Операція успішна", winType: '', height: '85px' });
                        bars.ui.loader('body', false);
                        var form = settingsService.settings().formWindows[formId];

                        $scope[form].close();

                        $('[kendo-grid="RequireDepositGrid"]').data("kendoGrid").dataSource.read();
                    }, function (error) {

                    });
                } else if (formId == "editDepositDemand") {
                    var authProcessId = $scope.returnedProcessIdDepositDemand;
                    if (!authProcessId) {
                        authProcessId = $scope.processId;
                    }
                    $http.post(bars.config.urlContent("/api/gda/gda/authdeposit"), authProcessId.toString()).then(function (request) {

                        $scope[formId].State = ts.TS_ON_AUTHORIZATION;
                        bars.ui.loader('body', true);
                        bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Успішно передано на авторизацію!</span>", title: "Операція успішна", winType: '', height: '85px' });
                        bars.ui.loader('body', false);
                        var form = settingsService.settings().formWindows[formId];
                        $scope[form].close();

                        $('[kendo-grid="RequireDepositGrid"]').data("kendoGrid").dataSource.read();
                    }, function (error) {

                    });
                } else if (formId == 'changeDepositDemand') {
                    var authProcessId = $scope.returnedProcessIdDepositDemand;
                    if (!authProcessId) {
                        authProcessId = $scope.processId;
                    }
                    $http.post(bars.config.urlContent("/api/gda/gda/authchangecalctype"), authProcessId.toString()).then(function (request) {
                        $scope[formId].State = ts.TS_ON_AUTHORIZATION;
                        bars.ui.loader('body', true);
                        bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Успішно передано на авторизацію!</span>", title: "Операція успішна", winType: '', height: '85px' });
                        bars.ui.loader('body', false);
                        var form = settingsService.settings().formWindows[formId];
                        $scope[form].close();

                        $('[kendo-grid="RequireDepositGrid"]').data("kendoGrid").dataSource.read();
                    }, function (error) {

                    });

                } else {
                    var _data = saveDataService.prepareData4Save(formId, $scope[formId]);                            //get data from Form by FormId 
                    if ($scope.processId == null || $scope.processId == "") {
                        return;
                    } else {
                        $scope.returnedProcessId = $scope.processId;
                    }
                    var url = formId === "earlyRepaymentTranche" ? "/api/gda/gda/returningauthtranche" : "/api/gda/gda/authtranche";
                    $http.post(bars.config.urlContent(url), $scope.returnedProcessId.toString()).then(function (request) {
                        $scope[formId].State = ts.TS_ON_AUTHORIZATION;
                        bars.ui.loader('body', true);
                        bars.ui.alert({ text: "<i class='pf-icon pf-24 pf-ok_button'></i><span style='font-size:20px;margin-left: 10px;'>Успішно передано на авторизацію!</span>", title: "Операція успішна", winType: '', height: '85px' });
                        $scope.TimeTranshesGrid.dataSource.read();
                        $scope.TimeTranshesGrid.refresh();
                        bars.ui.loader('body', false);
                        var form = settingsService.settings().formWindows[formId];

                        $scope[form].close();

                        $scope.accountsGrid.dataSource.read();
                        $scope.accountsGrid.refresh();
                    }, function (error) {
                    });

                }
                break;

            case "print":
                /*
                функция для вызова печати отчётов
                аргументы функции:
                formId - что будем печатать,
                gridFunc - какую универсальную функцию будет использовать (см.MainFront.js комментарий универсальные функции),
                gridField - какое поле передаим этой функции,
                gridText - какое поле покажем в сообщении подтверждении
                text - текст подтверждения
                */
                $scope.print = function (formId, gridFunc, gridField, gridText, text) {
                    var Id = $scope[gridFunc](gridField);

                    if (Id == null) {
                        bars.ui.alert({ text: "Не обрано жодного рядку! Оберіть рядок" });
                    } else {
                        bars.ui.confirm({ text: "Сформувати звіт " + text + " № " + '<b>' + $scope[gridFunc](gridText) + '</b>' + " ?" }, function () {
                            var rnk = $scope.curAccInfo('rnk'),
                                customer_id = $scope.currOperDBO('Customer_id');
                            if (rnk == null && customer_id != null) {
                                _rnk = customer_id;
                            } else if (rnk != null && customer_id == null) {
                                _rnk = rnk;
                            }
                            document.location.href = '/barsroot/api/gda/gda/print/' + formId + '/' + Id + '/' + _rnk;
                        });
                    }
                }
                //

                if (formId == 'replacementTranche') {
                    $scope.print(formId, 'curTrancheInfo', 'tranche_id', 'deal_number', 'по траншу');
                    break;
                } else if (formId == 'editDepositDemand') {
                    $scope.print(formId, 'curRequireDeposit', 'DEPOSIT_ID', 'DEAL_NUMBER', 'по вкладу');
                    break;
                } else if (formId == 'replenishmentTranche' || formId == 'editReplenishmentTranche') {
                    $scope.print(formId, 'curReplenishInfo', 'process_id', 'deal_number', 'щодо поповнення');
                    break;
                } else if (formId == 'earlyRepaymentTranche') {
                    $scope.print(formId, 'curTrancheInfo', 'tranche_id', 'deal_number', 'по достроковому поверненню траншу');
                    break;
                } else if (formId == 'closeDepositDemand') {
                    $scope.print(formId, 'curRequireDeposit', 'DEPOSIT_ID', 'DEAL_NUMBER', 'по закриттю вкладу на вимогу');
                    break;
                }


            //Кнопка показати детали
            case "showDetails":
                if (formId == 'replacementTranche') {
                    $http.post(bars.config.urlContent("/api/gda/gda/countplacementTranche"), $scope.replacementTranche).success(function (request) {


                        $scope.replacementTranche.interestRate = request.InterestRate;
                        $scope.replacementTranche.IndividualInterestRate = request.IndividualInterestRate;
                        $scope.replacementTranche.InterestRateBonus = request.InterestRateBonus;
                        $scope.replacementTranche.BonusDescription = request.BonusDescription;
                        $scope.replacementTranche.InterestRateGeneral = request.InterestRateGeneral;
                        $scope.replacementTranche.InterestRatePayment = request.InterestRatePayment;
                        $scope.replacementTranche.InterestRateProlongation = request.InterestRateProlongation;
                        $scope.replacementTranche.InterestRateReplenishment = request.InterestRateReplenishment;
                        $scope.replacementTranche.InterestRateCapitalization = request.InterestRateCapitalization;
                        $scope.replacementTranche.InterestRateProlongationBonus = request.InterestRateProlongationBonus;

                        var IndividualInterestRate = "";
                        var InterestRateBonus = "";
                        var InterestRateGeneral = "";
                        var InterestRatePayment = "";
                        var InterestRateProlongation = "";
                        var InterestRateReplenishment = "";
                        var InterestRateCapitalization = "";
                        var InterestRateProlongationBonus = "";

                        $scope[formId].IndividualInterestRate == null ? IndividualInterestRate = "0" : IndividualInterestRate = $scope[formId].IndividualInterestRate;
                        $scope[formId].InterestRateBonus == null ? InterestRateBonus = "0" : InterestRateBonus = $scope[formId].InterestRateBonus;
                        $scope[formId].InterestRateGeneral == null ? InterestRateGeneral = "0" : InterestRateGeneral = $scope[formId].InterestRateGeneral;
                        $scope[formId].InterestRatePayment == null ? InterestRatePayment = "0" : InterestRatePayment = $scope[formId].InterestRatePayment;
                        $scope[formId].InterestRateProlongation == null ? InterestRateProlongation = "0" : InterestRateProlongation = $scope[formId].InterestRateProlongation;
                        $scope[formId].InterestRateReplenishment == null ? InterestRateReplenishment = "0" : InterestRateReplenishment = $scope[formId].InterestRateReplenishment;
                        $scope[formId].InterestRateCapitalization == null ? InterestRateCapitalization = "0" : InterestRateCapitalization = $scope[formId].InterestRateCapitalization;
                        $scope[formId].InterestRateProlongationBonus == null ? InterestRateProlongationBonus = "0" : InterestRateProlongationBonus = $scope[formId].InterestRateProlongationBonus;


                        var details =
                            "<ul class='list-group'>" +
                            "<li id='IndIntRate' class='list-group-item'>        1.   Індивідуальна ставка    = " + +IndividualInterestRate +
                            "</li><li id='IntRateBon' class='list-group-item'>   2.   Бонусна ставка          = " + +InterestRateBonus +
                            "</li><li id='IntRateGen' class='list-group-item'>   3.   Базова ставка           = " + +InterestRateGeneral +
                            "</li><li id='IntRatePay'class='list-group-item'>   4.   Виплата по депозиту     = " + +InterestRatePayment +
                            "</li><li id='IntRateProl'class='list-group-item'>   5.   Пролонгація             = " + +InterestRateProlongation +
                            "</li><li id='IntRateRepl' class='list-group-item'>   6.   Ставка при поповненні   = " + +InterestRateReplenishment +
                            "</li><li id='IntRateCap'class='list-group-item'>   7.   Капіталізація           = " + +InterestRateCapitalization +
                            "</li><li id='IntRateBonProl' class='list-group-item'>   8.   Бонусна % ставка при пролонгації   = " + +InterestRateProlongationBonus + "</ul>";

                        $scope.HighLightDetails = function (field, idSelector) {
                            var html = $(details);
                            if (field > 0 || field < 0) {
                                var elem = html.find('#' + idSelector);
                                if (idSelector == 'IntRateProl') {
                                    elem.addClass('list-group-item-warning');
                                } else {
                                    elem.addClass('list-group-item-success');
                                }
                                details = html;
                                return details;
                            } else {
                                var elem = html.find('#' + idSelector);
                                elem.removeClass('list-group-item-success');
                            }
                        }

                        $scope.HighLightDetails(InterestRateProlongation, 'IntRateProl');
                        $scope.HighLightDetails(IndividualInterestRate, 'IndIntRate');
                        $scope.HighLightDetails(InterestRateBonus, 'IntRateBon');
                        $scope.HighLightDetails(InterestRateGeneral, 'IntRateGen');
                        $scope.HighLightDetails(InterestRatePayment, 'IntRatePay');

                        $scope.HighLightDetails(InterestRateReplenishment, 'IntRateRepl');
                        $scope.HighLightDetails(InterestRateCapitalization, 'IntRateCap');
                        $scope.HighLightDetails(InterestRateProlongationBonus, 'IntRateBonProl');


                        bars.ui.alert({ text: details, title: 'Деталі', width: '290px', height: '327px', winType: '' });
                    });
                }
                else {
                    var IndividualInterestRate = "";
                    var InterestRateBonus = "";
                    var InterestRateGeneral = "";
                    var InterestRatePayment = "";
                    var InterestRateProlongation = "";
                    var InterestRateReplenishment = "";
                    var InterestRateCapitalization = "";
                    var InterestRateProlongationBonus = "";


                    $scope[formId].IndividualInterestRate == null ? IndividualInterestRate = "0" : IndividualInterestRate = $scope[formId].IndividualInterestRate;
                    $scope[formId].InterestRateBonus == null ? InterestRateBonus = "0" : InterestRateBonus = $scope[formId].InterestRateBonus;
                    $scope[formId].InterestRateGeneral == null ? InterestRateGeneral = "0" : InterestRateGeneral = $scope[formId].InterestRateGeneral;
                    $scope[formId].InterestRatePayment == null ? InterestRatePayment = "0" : InterestRatePayment = $scope[formId].InterestRatePayment;
                    $scope[formId].InterestRateProlongation == null ? InterestRateProlongation = "0" : InterestRateProlongation = $scope[formId].InterestRateProlongation;
                    $scope[formId].InterestRateReplenishment == null ? InterestRateReplenishment = "0" : InterestRateReplenishment = $scope[formId].InterestRateReplenishment;
                    $scope[formId].InterestRateCapitalization == null ? InterestRateCapitalization = "0" : InterestRateCapitalization = $scope[formId].InterestRateCapitalization;
                    $scope[formId].InterestRateProlongationBonus == null ? InterestRateProlongationBonus = "0" : InterestRateProlongationBonus = $scope[formId].InterestRateProlongationBonus;


                    var details =
                        "<ul class='list-group'>" +
                        "<li id='IndIntRate' class='list-group-item'>        1.   Індивідуальна ставка    = " + +IndividualInterestRate +
                        "</li><li id='IntRateBon' class='list-group-item'>   2.   Бонусна ставка          = " + +InterestRateBonus +
                        "</li><li id='IntRateGen' class='list-group-item'>   3.   Базова ставка           = " + +InterestRateGeneral +
                        "</li><li id='IntRatePay'class='list-group-item'>   4.   Виплата по депозиту     = " + +InterestRatePayment +
                        "</li><li id='IntRateProl'class='list-group-item'>   5.   Пролонгація             = " + +InterestRateProlongation +
                        "</li><li id='IntRateRepl'class='list-group-item'>   6.   Ставка при поповненні   = " + +InterestRateReplenishment +
                        "</li><li id='IntRateCap'class='list-group-item'>   7.   Капіталізація           = " + +InterestRateCapitalization +
                        "</li><li id='IntRateBonProl' class='list-group-item'>   8.   Бонусна % ставка при пролонгації   = " + +InterestRateProlongationBonus + "</ul>";

                    //подсветка
                    $scope.HighLightDetails = function (field, idSelector) {
                        var html = $(details);
                        if (field > 0 || field < 0) {
                            var elem = html.find('#' + idSelector);
                            if (idSelector == 'IntRateProl') {
                                elem.addClass('list-group-item-warning');
                            } else {
                                elem.addClass('list-group-item-success');
                            }
                            details = html;
                            return details;
                        } else {
                            var elem = html.find('#' + idSelector);
                            elem.removeClass('list-group-item-success');
                        }
                    }

                    $scope.HighLightDetails(InterestRateProlongation, 'IntRateProl');
                    $scope.HighLightDetails(IndividualInterestRate, 'IndIntRate');
                    $scope.HighLightDetails(InterestRateBonus, 'IntRateBon');
                    $scope.HighLightDetails(InterestRateGeneral, 'IntRateGen');
                    $scope.HighLightDetails(InterestRatePayment, 'IntRatePay');
                    $scope.HighLightDetails(InterestRateReplenishment, 'IntRateRepl');
                    $scope.HighLightDetails(InterestRateCapitalization, 'IntRateCap');
                    $scope.HighLightDetails(InterestRateProlongationBonus, 'IntRateBonProl');

                    bars.ui.alert({ text: details, title: 'Деталі', width: '280px', height: '327px', winType: '' });
                    $('#showDetailsPercentBtn').prop('disabled', true);
                    break;
                }
        }
    };

    $scope.blurValue = function (formId, fieldId) {
        // обновляем ставку когда поменяли срок транша в режиме редактирования транша
        if (formId == 'replacementTranche' && fieldId == 'NumberTrancheDays') {
            $scope.onClick('replacementTranche', 'count');
        }
        //

        //отрезаем хвост при указании срока транша не целым значением
        $scope[formId][fieldId] = Math.floor(+$scope[formId][fieldId]);
        //

        $scope.replacementTranche.ExpiryDate = $("#dateReturning").data("kendoDatePicker").value();
        if (validationService.validateField(formId, fieldId, $scope[formId])) {
            validationService.onBlur(formId, fieldId, $scope[formId]);
        }
        $scope.replacementTranche.ExpiryDate = $("#dateReturning").data("kendoDatePicker").value();
    };
});