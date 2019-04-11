var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("GDACtrlTest", function ($controller, $scope, $timeout, $http,
    saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.dateNd = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');

    $scope.placementTranche = modelService.initFormData("placementTranche");
    $scope.replacementTranche = modelService.initFormData("replacementTranche");
    $scope.replenishmentTranche = modelService.initFormData("replenishmentTranche");
    $scope.earlyRepaymentTranche = modelService.initFormData("earlyRepaymentTranche");
    $scope.editreplenishmentTranche = modelService.initFormData("editreplenishmentTranche");
    //
    $scope.depositDemand = modelService.initFormData("depositDemand");
    $scope.closeDepositDemand = modelService.initFormData("closeDepositDemand");
    $scope.editDepositDemand = modelService.initFormData("editDepositDemand");
    $scope.changeDepositDemand = modelService.initFormData("changeDepositDemand");

    $scope.processId = 0;
    $scope.depositId = 0;
    $scope.requestObj = {};

    //Тулбары для окон создания/редактирования/пополнения/досрочного возврата
    $scope.toolbarMainOptions = { items: settingsService.settings().toolbars.MainOptions.items };
    $scope.toolbarTimeTranshOptions = { items: settingsService.settings().toolbars.TimeTranshOptions.items };
    $scope.toolbarRequireDepositOptions = { items: settingsService.settings().toolbars.RequireDepositOptions.items };
    $scope.toolbarPlacementTrancheOptions = { items: settingsService.settings().toolbars.PlacementTrancheOptions.items };
    $scope.toolbarReplacementTrancheOptions = { items: settingsService.settings().toolbars.ReplacementTrancheOptions.items };
    $scope.toolbarReplenishmentTrancheOptions = { items: settingsService.settings().toolbars.ReplenishmentTrancheOptions.items };
    $scope.toolbarEarlyReplacementTrancheOptions = { items: settingsService.settings().toolbars.EarlyReplacementTrancheOptions.items };
    $scope.toolbarReplenishmentTrancheHistoryOptions = { items: settingsService.settings().toolbars.ReplenishmentTrancheHistoryOptions.items };
    $scope.toolbarEditreplenishmentTrancheOptions = { items: settingsService.settings().toolbars.EditreplenishmentTrancheOptions.items };
    //
    $scope.toolbarDepositDemandOptions = { items: settingsService.settings().toolbars.depositDemandOptions.items };
    $scope.toolbarCloseDepositDemandOptions = { items: settingsService.settings().toolbars.closeDepositDemandOptions.items };
    $scope.toolbarEditDepositDemandOptions = { items: settingsService.settings().toolbars.editDepositDemandOptions.items };
    $scope.toolbarChangeDepositDemandOptions = { items: settingsService.settings().toolbars.СhangeDepositDemandOptions.items };
    $scope.toolbarBackAdminOptions = { items: settingsService.settings().toolbars.BackAdminOptions.items };

    // функция для открытия окон справки
    $scope.GetInfo = function (grid) {
        if (grid == 'dbo') {

            var text = "<ul> \
                        <li style='margin-bottom: 10px'>щоб знайти потрібного клієнта, введіть дані у відповідні поля пошуку, натисніть кнопку <a class='btn btn-default'><i class='pf-icon pf-16 pf-find'></i>Пошук</a> або клавішу 'Enter'</li> \
                        <li style='margin-bottom: 10px'>щоб очистити поля пошуку, натисніть кнопку <a class='btn btn-default'><i class='pf-icon pf-16 pf-filter-remove'></i></a></li> \
                        <li style='margin-bottom: 10px'>щоб перейти до траншів знайденого клієнта, подвійним кліком натисніть на потрібну строку у гріді або оберіть строку і натисніть вкладку 'Портфель депозитів ММСБ' \
                        <li style='margin-bottom: 10px'>щоб переглянути всі операції операціоніста на поточну дату, перейдіть у вкладку 'Депозити операціоніста' та оберіть строку для автоматичного переходу у 'Портфель депозитів ММСБ' \
                        </li> \
                    </ul>";

            bars.ui.alert({ text: text, title: 'Підказки', width: '620px', height: '245px', winType: '' });
        } else {
            var text = "<ul> \
                        <li style='margin-bottom: 10px'>щоб створити транш натисніть кнопку <button class='btn btn-default'><i class='pf-icon pf-16 pf-add'></i>Розміщення траншу</button></li> \
                        <li style='margin-bottom: 10px'>форму для редагування траншу можна відкрити двома способами: обрати відповідний рядок і натиснути кнопку <button class='btn btn-default'><i class='pf-icon pf-16 pf-application-update'></i>Редагування траншу</button> або відкрити цю форму подвійнии кліком на відповідний рядок</li> \
                        <li style='margin-bottom: 10px'>для видалення траншу оберіть відповідний рядок и натисніть кнопку <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i>Видалення траншу</button></li> \
                        <li style='margin-bottom: 10px'>для формування звіту по траншу оберіть відповідний рядок і натисність кнопку <button class='btn btn-default'><i class='pf-icon pf-16 pf-print'></i>Друк</button>. Іншим способом формування звіту є відкриття форми редагування траншу і натиснення аналогічної кнопки</li> \
                        <li style='margin-bottom: 10px'>щоб імпортувати дані у Excel натисніть кнопку <button class='btn btn-default'><i class='pf-icon pf-16 pf-exel'></i></button></li> \
                    </ul>";

            bars.ui.alert({ text: text, title: 'Підказки', width: '720px', height: '345px', winType: '' });
        }
    }
    //
    //Получение счётов в выпадающих списках (Рахунок для повернення/Рахунок для списання) при дефокусе с поля для ввода валюты
    $scope.GetAccounts = function (operation) {
        switch (operation) {
            case 'placement':
                $("#DebitAcc").data("kendoDropDownList").dataSource.read();
                $("#DebitReturn").data("kendoDropDownList").dataSource.read();
                $('#placementOstc').data('kendoNumericTextBox').value('');

                if ($scope.placementTranche.CurrencyId == '') {
                    $("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value(0);
                    $("#NumberProlongationList").data("kendoDropDownList").dataSource.read([]);
                    $("#NumberProlongationList").data("kendoDropDownList").value(0);
                    $('#applyprologField').val('');
                    $scope.placementTranche.CurrencyId == null;
                } else if ($("[ng-model='replacementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {
                    $("#NumberProlongationList").data("kendoDropDownList").dataSource.read();
                } else {

                }
                break;

            case 'replacement':
                $("#DebitAccReplacement").data("kendoDropDownList").dataSource.read();
                $("#ReturnAccReplacement").data("kendoDropDownList").dataSource.read();
                $('#replacementOstc').data('kendoNumericTextBox').value('');

                if ($scope.replacementTranche.CurrencyId == '') {
                    $("[ng-model='replacementTranche.IsProlongation']").data("kendoDropDownList").value(0);
                    $("#NumberProlongationListReplace").data("kendoDropDownList").dataSource.read([]);
                    $("#NumberProlongationListReplace").data("kendoDropDownList").value(0);
                    $('#applyprologFieldReplace').val('');
                    $scope.replacementTranche.CurrencyId == null;
                } else {
                    $("#NumberProlongationListReplace").data("kendoDropDownList").dataSource.read();
                    $('#applyprologFieldReplace').val('');
                    $("#NumberProlongationListReplace").data("kendoDropDownList").enable(false);

                    if ($scope.replacementTranche.DebitAccount == null) {
                        //ставим задержку, чтоб датасорс выпадающих списков счётов успел подтянутся
                        setTimeout(function () { $scope.onClick('replacementTranche', 'count') }, 1000);
                    } else {
                        $scope.onClick('replacementTranche', 'count');
                    }
                };
                break;
            case 'depositDemand':
                $("#DebitAccDepositDemand").data("kendoDropDownList").dataSource.read();
                break;
        }
    };

    //добавляем пробелы между разрядами чисел
    $scope.numberWithSpaces = function (x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }

    //Функция для заполнения полей Оператор/Контроллер
    $scope.GetUsers = function (proccesId, scopeformId) {
        $http.get(bars.config.urlContent("/api/gda/gda/getoperatorcontrollerinfo?processId=" + proccesId)).then(function (request) {
            $scope.requestObjUsers = request.data;

            $scope.requestObjUsers.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
            $scope.requestObjUsers.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');

            $scope[scopeformId].OperatorFullName = $scope.requestObjUsers.OperatorFullName
            $scope[scopeformId].ControllerFullName = $scope.requestObjUsers.ControllerFullName;
            $scope[scopeformId].ControllerSysTime = $scope.requestObjUsers.ControllerSysTime;
            $scope[scopeformId].OperatorSysTime = $scope.requestObjUsers.OperatorSysTime;
        });
    }

    //Функция для отображения окна Деталей автопролонгации
    $scope.getProlongationDetails = function () {

        if ($scope.replacementTranche.IsProlongation === '1') {
            var processId = $scope.curTrancheInfo('process_id'),
                expiryDate = '',
                interestRate = '',
                prolongationNum = '';
            $http.get(bars.config.urlContent("/api/gda/gda/getprolongationdetails?processId=" + processId)).then(function (request) {
                expiryDate = request.data.ExpiryDate;
                interestRate = request.data.InterestRate;
                prolongationNum = request.data.ProlongationNumber;

                if (expiryDate == '' || expiryDate == null) {
                    bars.ui.alert({ text: "Дані відсутні" });
                    return;
                } else {
                    var details =
                        "<ul class='list-group'>" +
                        "<li class='list-group-item'>        1.   Закінчення пролонгації: " + kendo.toString(kendo.parseDate(expiryDate), 'dd.MM.yyyy') +
                        "</li><li class='list-group-item'>   2.   Бонусна ставка          = " + +interestRate +
                        "</li><li class='list-group-item'>   3.   Порядковий номер пролонгації           = " + +prolongationNum + "</ul>";
                }

                bars.ui.alert({ text: details, title: 'Деталі автопролонгації', width: '290px', height: '150px', winType: '' });
            });
        } else {
            bars.ui.alert({ text: "Автопролонгація не вибрана" });
            return;
        }

    }

    //Функция удаления транша - ануляция
    $scope.CancelTranche = function () {

        var processId = $scope.curTrancheInfo('process_id'),
            trancheState = $scope.curTrancheInfo('state_name'),
            trancheStateNow = $scope.curTrancheInfo('tranche_state_name'),
            dealNumber = $scope.curTrancheInfo('deal_number');

        if (processId == null || processId == " ") {
            bars.ui.alert({ text: "Оберіть потрібний рядок з траншем!" });
        } else if ((trancheState != "Cтворено" && trancheStateNow != "на редагуванні") && (trancheState != "Cтворено" && trancheStateNow != "відхилено БО / на редагуванні")) {
            bars.ui.alert({
                text: "Неможливо видалити транш, що не знаходиться в статусі 'Створено' і 'На редагуванні'!  або 'Створено' і 'відхилено БО / на редагуванні'!"
            });
        } else {
            eacForm({
                title: 'Підтвердження видалення',
                maxLength: 100,
                minLength: 10,
                customTemplate: "<h2>Видалити обраний транш " + "<b>" + dealNumber + "</b>" + "?</h2>",
                okFunc: function (e) {
                    $http.post(bars.config.urlContent("/api/gda/gda/removetimetranche?processId=" + processId + "&comment=" + encodeURI(e.reason)))
                        .success(function (response) {
                            bars.ui.notify('Транш № ' + dealNumber + '<br>' + 'видалено', '', 'success', { autoHideAfter: 10000, width: 400, height: 100 });

                            $scope.TimeTranshesGrid.dataSource.read();
                            $scope.TimeTranshesGrid.refresh();

                        }, function (error) { });
                }
            });
        }
    }

    //Функция удаления вклада на требование - ануляция
    $scope.CancelRequireDeposit = function () {

        var processId = $scope.curRequireDeposit('PROCESS_ID'),
            trancheState = $scope.curRequireDeposit('DEPOSIT_STATE_NAME'),
            dealNumber = $scope.curRequireDeposit('DEAL_NUMBER');

        if (processId == null || processId == " ") {
            bars.ui.alert({ text: "Оберіть потрібний рядок з вкладом на вимогу!" });
        } else if (trancheState != "на редагуванні" && trancheState != "відхилено БО / на редагуванні") {
            bars.ui.alert({ text: "Неможливо видалити вклад, що не знаходиться в статусі 'на редагуванні' або 'відхилено БО / на редагуванні'!" });
        } else {
            eacForm({
                title: 'Підтвердження видалення',
                maxLength: 100,
                minLength: 10,
                customTemplate: "<h2>Видалити відмічений вклад на вимогу " + "<b>" + dealNumber + "</b>" + "?</h2>",
                okFunc: function (e) {
                    $http.post(bars.config.urlContent("/api/gda/gda/removerequiredeposit?processId=" + processId + "&comment=" + encodeURI(e.reason)))
                        .success(function (response) {
                            bars.ui.notify('Транш № ' + dealNumber + '<br>' + 'видалено', '', 'success', { autoHideAfter: 10000, width: 400, height: 100 });

                            $scope.RequireDepositGrid.dataSource.read();
                            $scope.RequireDepositGrid.refresh();
                            $('#closeDepositBtn').prop("disabled", true);
                            $('#editDepositBtn').prop("disabled", true);
                            $('#changeDepositBtn').prop("disabled", true);
                            $('#printDepositBtn').prop("disabled", true);

                        }, function (error) { });
                }
            });
        }
    }

    //Функция удаления операции пополнения - ануляция
    $scope.CancelReplenishment = function () {
        var processId = $scope.curEditReplenishment('process_id'),
            replenishmentState = $scope.curEditReplenishment('replenish_state_name'),
            dealNumber = $scope.curEditReplenishment('deal_number');

        if (processId == null || processId == " ") {
            bars.ui.alert({ text: "Оберіть потрібний рядок з поповненням!" });
        } else if (replenishmentState != "створено" && replenishmentState != "відхилено БО / на редагуванні") {

            bars.ui.alert({
                text: "Неможливо видалити операцію поповнення, що не знаходиться в статусі 'створено' або 'відхилено БО / на редагуванні'!"
            });
        } else {
            eacForm({
                title: 'Підтвердження видалення',
                maxLength: 100,
                minLength: 10,
                customTemplate: "<h2>Видалити обрану операцію поповнення " + "<b>" + dealNumber + "</b>" + "?</h2>",
                okFunc: function (e) {
                    $http.post(bars.config.urlContent("/api/gda/gda/removereplenishment?processId=" + processId + "&comment=" + encodeURI(e.reason)))
                        .success(function (response) {
                            bars.ui.notify('Операція поповнення № ' + dealNumber + '<br>' + 'видалена', '', 'success', { autoHideAfter: 10000, width: 400, height: 100 });

                            $("#replenishmentHistoryGrid").data("kendoGrid").dataSource.read();
                            $("#replenishmentHistoryGrid").data("kendoGrid").refresh();

                        }, function (error) { });
                }
            });
        }
    }

    //Функция когда клик по кнопкам Розміщення/Поповнення/Редагування
    $scope.onClickMain = function (formId) {
        var trancheId = $scope.curTrancheInfo('tranche_id');

        if (formId === 'removeTranche') {
            bars.ui.confirm({ text: "Видалити відмічений транш " + trancheId + " ?" }, function () {
                $http.post(bars.config.urlContent("/api/gda/gda/removetranche"), JSON.stringify({
                    Acc: $scope.curAccInfo('Acc'), TrancheId: trancheId
                })).then(function (request) {
                    bars.ui.notify('Транш № ' + trancheId + ' видалено', '', 'success', { autoHideAfter: 5000 });
                    $scope.tranchesGrid.dataSource.read();
                    $scope.tranchesGrid.refresh();
                    //bars.ui.loader('body', false);
                }, function (error) {

                });
            });
        }
        else {
            var trancheDate = $scope.curTrancheInfo('start_date');
            $scope.today = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
            $scope.placementDate = kendo.toString(kendo.parseDate($scope.curTrancheInfo('start_date')), 'dd.MM.yyyy');
            $scope.titleDate = formId === "placementTranche" ? $scope.today : $scope.placementDate;

            $scope.nd = $scope.curAccInfo('contract_number');


            var form = settingsService.settings().formWindows[formId];
            var scopeFormId = formId === 'replacementTranche' ? 'placementTranche' : formId;


            if (formId == 'placementTranche') {
                $scope[scopeFormId] = modelService.initFormData(scopeFormId);
                $scope.processId = '';
                $scope.placementTranche.CurrencyId = null;
                $scope.placementTranche.amountTranche = null;
                $('#placementOstc').data('kendoNumericTextBox').value('');
                $('#interestRate').data('kendoNumericTextBox').value('');
                $scope.GetUsers($scope.processId, 'placementTranche');
                $("#placementSaveBtn").prop("disabled", false);
                $("#DebitAcc").data("kendoDropDownList").dataSource.read([]);
                $("#applyprologField").val('');
                $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value('');
                $("[ng-model='placementTranche.InterestRate']").data("kendoNumericTextBox").value(0);
                $scope.placementTranche.InterestRate = 0;
                $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(0);
                $scope.placementTranche.IndividualInterestRate = 0;
                $("#NumberProlongationList").data("kendoDropDownList").dataSource.read([]);
                var TimeTranshesGrid = $("#timetranchesgrid").data("kendoGrid");
                TimeTranshesGrid.clearSelection();
                $scope.placementTranche.Status = '';
            }
            //

            //Редактирование пополнения транша
            if (formId === 'editreplenishmentTranche') {

                var grid = $("#replenishmentHistoryGrid").data("kendoGrid");
                var selectedItem = grid.dataItem(grid.select());
                if ($scope.curReplenishInfo('type_') === 'основний транш') {
                    bars.ui.alert({ text: "Основний транш неможливо редагувати" });
                } else if (selectedItem == null) {
                    bars.ui.alert({ text: "Не обрано жодного рядку! Оберіть рядок" });
                } else {
                    $scope[form].center().open();     //.maximize();  
                    //берём номер дбо с грида операциониста
                    if ($scope.nd == null) {
                        $scope.nd = $scope.currOperDBO('Contract_number');
                        $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                    }
                    //
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                    $scope[scopeFormId] = modelService.initFormData(scopeFormId);

                    $http.get(bars.config.urlContent("/api/gda/gda/getreplenishtranche?processId=" + $scope.processId + "&trancheId=" + $scope.curTrancheInfo('tranche_id'))).then(function (request) {

                        $scope.requestObj = request.data;

                        $("[ng-model='editreplenishmentTranche.ActionDate']").data("kendoDatePicker").value(kendo.parseDate($scope.requestObj.ActionDate, "dd.MM.yyyy"));
                        $scope.editreplenishmentTranche.CurrencyId = $scope.requestObj.CurrencyId;
                        $scope.editreplenishmentTranche.CustomerId = $scope.requestObj.CustomerId;
                        $scope.editreplenishmentTranche.DealNumber = $scope.curTrancheInfo("deal_number");
                        $scope.editreplenishmentTranche.DealNumberReplenishment = $scope.requestObj.DealNumber;
                        $scope.editreplenishmentTranche.PrimaryAccount = $scope.requestObj.PrimaryAccount;
                        $("[ng-model='editreplenishmentTranche.DatePlacement']").data("kendoDatePicker").value(kendo.parseDate($scope.placementDate, "dd.MM.yyyy"));
                        $scope.editreplenishmentTranche.amountTranche = $scope.requestObj.AmountTranche;
                        $("[ng-model='editreplenishmentTranche.amountTranche']").data("kendoNumericTextBox").value($scope.requestObj.AmountTranche);
                        $("[ng-model ='editreplenishmentTranche.DebitAccount']").data("kendoDropDownList").value($scope.requestObj.DebitAccount);
                        $("[ng-model ='editreplenishmentTranche.IsSigned']").data("kendoDropDownList").value($scope.requestObj.IsSigned);
                        $("#DebitAccEditReplenishment").data("kendoDropDownList").dataSource.read();
                    },
                        function (error) {
                        });

                    $scope.GetUsers($scope.processId, 'editreplenishmentTranche');
                    $scope.editreplenishmentTranche.Status = $scope.curEditReplenishment('replenish_state_name');
                }
            }

            //Пополнение транша
            if (formId === 'replenishmentTranche') {

                $scope[form].center().open();     //.maximize();      
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                } else {
                    //
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                }
                $scope[scopeFormId] = modelService.initFormData(scopeFormId);

                $http.get(bars.config.urlContent("/api/gda/gda/getreplenishtranche?processId=" + "" + "&trancheId=" + $scope.curTrancheInfo('tranche_id'))).then(function (request) {
                    $scope.requestObj = request.data;
                    $("[ng-model='replenishmentTranche.amountTranche']").data('kendoNumericTextBox').value('');
                    $('#replenishmentOstc').data('kendoNumericTextBox').value('');
                    $scope.replenishmentTranche.CurrencyId = $scope.requestObj.CurrencyId;
                    $scope.replenishmentTranche.CustomerId = $scope.requestObj.CustomerId;
                    $scope.replenishmentTranche.DealNumber = $scope.curTrancheInfo("deal_number");
                    $scope.replenishmentTranche.DealNumberReplenishment = $scope.requestObj.DealNumber;
                    $scope.replenishmentTranche.PrimaryAccount = $scope.requestObj.PrimaryAccount;
                    $("[ng-model='replenishmentTranche.DatePlacement']").data("kendoDatePicker").value(kendo.parseDate($scope.placementDate, "dd.MM.yyyy"));
                    $scope.replenishmentTranche.ActionDate = $("[ng-model='replenishmentTranche.ActionDate']").data("kendoDatePicker").value(kendo.parseDate($scope.today, "dd.MM.yyyy"));
                    $scope.GetUsers($scope.processId, 'replenishmentTranche');
                    $("#DebitAccReplenishment").data("kendoDropDownList").dataSource.read();
                },
                    function (error) {
                    });

            }
            //Редактирование транша
            if (formId === 'replacementTranche') {
                $scope[form].center().open();     //.maximize();  
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.contract_date));
                } else {
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));
                }
                //

                $scope[scopeFormId] = modelService.initFormData(scopeFormId);



                $http.get(bars.config.urlContent("/api/gda/gda/getreplacementtranche?processId=" + $scope.processId)).then(function (request) {
                    $scope.requestObj = request.data;
                    $("#replacementSaveBtn").prop("disabled", false);
                    $scope.replacementTranche.CurrencyId = $scope.requestObj.CurrencyId;
                    $scope.replacementTranche.CustomerId = $scope.requestObj.CustomerId;
                    $("#datePlacement").data("kendoDatePicker").value(kendo.parseDate($scope.requestObj.StartDate), 'dd.MM.yyyy');
                    $("#datePlacementStatement").data("kendoDatePicker").value($scope.requestObj.StartDate);
                    $("#dateReturning").data("kendoDatePicker").value($scope.requestObj.ExpiryDate);
                    $scope.replacementTranche.NumberTrancheDays = $scope.requestObj.NumberTrancheDays;
                    $scope.replacementTranche.amountTranche = $scope.requestObj.AmountTranche;
                    $scope.replacementTranche.IsProlongation = $scope.requestObj.IsProlongation;
                    $("[ng-model ='replacementTranche.IsProlongation']").data("kendoDropDownList").value($scope.replacementTranche.IsProlongation);
                    $("[ng-model ='replacementTranche.IsProlongation']").data("kendoDropDownList").trigger('change');
                    $scope.replacementTranche.ApplyBonusProlongation = $scope.requestObj.ApplyBonusProlongation;
                    if ($scope.requestObj.IsProlongation != '0') {
                        $scope.replacementTranche.NumberProlongation = $scope.requestObj.NumberProlongation;
                        $("#NumberProlongationListReplace").data('kendoDropDownList').dataSource.read();
                    }
                    else {
                        setTimeout(function () {
                            $scope.replacementTranche.NumberProlongation = null;
                            $scope.$apply();
                            var dropdownlist = $("#NumberProlongationListReplace").data('kendoDropDownList');
                            dropdownlist.dataSource.read([]);
                            dropdownlist.refresh();
                            dropdownlist.value('');
                            dropdownlist.enable(false);
                            $("[ng-model='replacementTranche.NumberProlongation']").data("kendoDropDownList").value('');
                            $("#applyprologFieldReplace").val('');
                        }, 20);
                    }
                    if ($scope.replacementTranche.ApplyBonusProlongation == 2) {
                        $("#applyprologFieldReplace").val('для кожної');
                    } else if ($scope.replacementTranche.ApplyBonusProlongation == 1) {
                        $("#applyprologFieldReplace").val('для першої');
                    }



                    if ($scope.requestObj.IndividualInterestRate == null || $scope.requestObj.IndividualInterestRate == 0) {
                        $scope.replacementTranche.IndividualInterestRate = 0;
                        $('[ng-model="replacementTranche.IndividualInterestRate"]').data('kendoNumericTextBox').value(0);
                    } else {
                        $scope.replacementTranche.IndividualInterestRate = $scope.requestObj.IndividualInterestRate;
                        $('[ng-model="replacementTranche.IndividualInterestRate"]').data('kendoNumericTextBox').value($scope.replacementTranche.IndividualInterestRate);
                    }

                    if ($scope.requestObj.InterestRate == null) {
                        $scope.requestObj.InterestRate = $scope.requestObj.IndividualInterestRate;
                        $('[ng-model="replacementTranche.interestRate"]').data('kendoNumericTextBox').value($scope.requestObj.InterestRate);
                    } else {
                        $scope.replacementTranche.interestRate = $scope.requestObj.InterestRate;
                        $('[ng-model="replacementTranche.interestRate"]').data('kendoNumericTextBox').value($scope.requestObj.InterestRate);
                    }


                    $("[ng-model='replacementTranche.amountTranche']").data("kendoNumericTextBox").value($scope.requestObj.AmountTranche);
                    $scope.replacementTranche.InterestRateProlongation = $scope.requestObj.InterestRateProlongation;
                    $scope.replacementTranche.isReplenishmentTranche = $scope.requestObj.IsReplenishmentTranche;
                    $("#dateReplenishmentToReplacement").data("kendoDatePicker").value($scope.requestObj.LastReplenishmentDate);
                    $scope.replacementTranche.FrequencyPayment = $scope.requestObj.FrequencyPayment;
                    $scope.replacementTranche.IsIndividualRate = $scope.requestObj.IsIndividualRate;
                    $scope.replacementTranche.IsCapitalization = $scope.requestObj.IsCapitalization;
                    $scope.replacementTranche.Comment = $scope.requestObj.Comment;
                    $scope.replacementTranche.PrimaryAccount = $scope.requestObj.PrimaryAccount;
                    $scope.replacementTranche.InterestAccount = $scope.requestObj.InterestAccount;
                    $scope.requestObj.Branch = request.data.Branch;
                    $scope.replacementTranche.Branch = $scope.requestObj.Branch;
                    $scope.replacementTranche.DealNumber = $scope.curTrancheInfo("deal_number");
                    $scope.replacementTranche.Status = $scope.curTrancheInfo('tranche_state_name');
                    $scope.replacementTranche.StartDate = $scope.requestObj.StartDate;
                    $scope.replacementTranche.ExpiryDate = $scope.requestObj.ExpiryDate;
                    $("#ReturnAccReplacement").data("kendoDropDownList").dataSource.read();
                    $("#DebitAccReplacement").data("kendoDropDownList").dataSource.read();
                    $("[ng-model ='replacementTranche.IsSigned']").data("kendoDropDownList").value($scope.requestObj.IsSigned);


                }, function (error) {
                });

                $scope.GetUsers($scope.processId, 'replacementTranche');
                $scope[scopeFormId].CustomerId = $scope.curAccInfo('rnk');
            }

            if (formId === 'depositDemand') {
                $scope.GetUsers('', 'depositDemand');
                $scope.depositDemand.Status = '';
                $("#depositDemandSaveBtn").prop("disabled", false);
                $scope.depositDemand.individualInterestRate = 0;
                $scope.depositDemand.individualInterestRateValue = '';
                $scope.depositDemand.comment = '';
                $scope.DepositDemand.accCredit = null;
                $scope.depositDemand.currency = null;

            }
            if (formId === 'closeDepositDemand' && $scope.processId !== 0 && $scope.depositId !== 0) {
                $scope[form].center().open();
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.contract_date));
                    $scope.editDepositDemand.clientOkpo = $scope.currOperDBO('Deposit_id');
                    $scope.editDepositDemand.clientName = $scope.currOperDBO('Customer_id');
                } else {
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));
                }
                $http.get(bars.config.urlContent("/api/gda/gda/getclosingdepositdemand?processId=" + $scope.processId + "&objectId=" + $scope.depositId)).then(function (request) {
                    $scope.requestObj = request.data;
                    //если не сохраняли возврат то печатать не может
                    if ($scope.requestObj.ProcessId == null || $scope.requestObj.ProcessId == '') {
                        $('#btnPrintCloseDeposit').prop('disabled', true);
                        $("#isSignedCloseDeposit").data("kendoDropDownList").enable(false);
                    } else {
                        $('#btnPrintCloseDeposit').prop('disabled', false);
                        $("#isSignedCloseDeposit").data("kendoDropDownList").enable(true);
                    }
                    $scope.closeDepositDemand.clientRnk = $scope.requestObj.CustomerId;
                    $scope.closeDepositDemand.clientOkpo = $scope.curAccInfo('okpo');
                    $scope.closeDepositDemand.clientName = $scope.curAccInfo('nmk');
                    $scope.closeDepositDemand.dbo = $scope.curAccInfo('contract_number');

                    $scope.closeDepositDemand.currency = $scope.requestObj.CurrencyId;
                    $scope.closeDepositDemand.accDebit = $scope.requestObj.DebitAccount;
                    $scope.closeDepositDemand.accCredit = $scope.requestObj.ReturnAccount;
                    $scope.closeDepositDemand.acc = $scope.requestObj.PrimaryAccount;
                    $scope.closeDepositDemand.payingperiod = "Щомісяця";
                    $scope.closeDepositDemand.replenishmentOnDayRegistration = $scope.requestObj.TransferDayRegistration == "1" ? true : false;
                    $scope.closeDepositDemand.IsIndividualRate = $scope.requestObj.IsIndividualRate;
                    $scope.closeDepositDemand.individualInterestRateValue = $scope.requestObj.IndividualInterestRate;
                    $scope.closeDepositDemand.interestRate = $scope.requestObj.InterestRate;
                    $scope.closeDepositDemand.comment = $scope.requestObj.comment;
                    $('[ng-model="closeDepositDemand.dboDate"]').data('kendoDatePicker').value($scope.requestObj.StartDate);
                    $scope.closeDepositDemand.ActionDate = $scope.today;
                    $('[ng-model="closeDepositDemand.actionDate"]').data('kendoDatePicker').value($scope.closeDepositDemand.ActionDate);
                    $("[ng-model ='closeDepositDemand.IsSigned']").data("kendoDropDownList").value($scope.requestObj.IsSigned);

                    $scope.closeDepositDemand.AmountDeposit = $scope.requestObj.AmountDeposit;

                    $scope.GetUsers($scope.processId, 'closeDepositDemand');
                    $scope.closeDepositDemand.Status = $scope.curRequireDeposit('DEPOSIT_STATE_NAME');

                    var closeDepedotDemandDS = new kendo.data.DataSource({
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                                data: function () {
                                    return {
                                        customerId: $scope.closeDepositDemand.clientRnk,
                                        currencyId: $scope.closeDepositDemand.currency
                                    };
                                }
                            }
                        },
                        requestEnd: function (e) {

                            //if (e.response.Data) {
                            //    if (e.response.Data.length !== 0) {
                            //        var value = e.response.Data[0].Ostc;
                            //        $('#closeDepositDemandOstc').data('kendoNumericTextBox').value(value);
                            //    }
                            //}
                        },
                        schema: {
                            data: "Data",
                            total: "Total"
                        }
                    });

                    closeDepedotDemandDS.read();

                    $("#debitAccCloseDepositDemand, #creditAccCloseDepositDemand").kendoDropDownList({
                        autoBind: false,
                        dataSource: closeDepedotDemandDS,
                        dataTextField: "Nls",
                        dataValueField: "Nls"
                    });

                    var closeDepositDemandCalculationDS = new kendo.data.DataSource({
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/gda/gda/getcalculationtype")
                            }
                        }
                    });

                    closeDepositDemandCalculationDS.read();

                    $("#closeCalculationTypeDropDownList").kendoDropDownList({
                        autoBind: false,
                        dataSource: closeDepositDemandCalculationDS,
                        dataBound: function () {
                            $("#closeCalculationTypeDropDownList").data("kendoDropDownList").value($scope.requestObj.CalculationType);
                        },
                        dataTextField: "item_name",
                        dataValueField: "item_id",
                        valuePrimitive: true,
                        optionLabel: ""
                    });
                    $scope.closeDepositDemand.calculationType = $scope.requestObj.CalculationType;


                    //$("#creditAccCloseDepositDemand").data("kendoDropDownList").value($scope.requestObj.ReturnAccount);
                }, function (error) { $scope[form].close(); });
            }
            if (formId === 'editDepositDemand' && $scope.processId !== 0) {
                $scope[form].center().open();
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.contract_date));
                } else {
                    //
                    //реализовуем возможность редактирование "Метод нарахування %" до отправки на авторизацию проверяем статус вклада на требования с грида
                    var state = $scope.curRequireDeposit('DEPOSIT_STATE_CODE');
                    if (state === 'CREATED') {
                        $("#editCalculationTypeDropDownList").prop("disabled", false);
                    } else {
                        $("#editCalculationTypeDropDownList").prop("disabled", true);
                    }
                    //
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));
                }

                $http.get(bars.config.urlContent("/api/gda/gda/geteditingdepositdemand?processId=" + $scope.processId)).then(function (request) {
                    var firsOpen = true;

                    $scope.requestObj = request.data;


                    $scope.editDepositDemand.clientRnk = $scope.requestObj.CustomerId;
                    $scope.editDepositDemand.clientOkpo = $scope.curAccInfo('okpo');
                    $scope.editDepositDemand.clientName = $scope.curAccInfo('nmk');
                    $scope.editDepositDemand.dbo = $scope.curAccInfo('contract_number');

                    if ($scope.editDepositDemand.clientOkpo == null && $scope.editDepositDemand.clientName == null && $scope.editDepositDemand.dbo == null) {
                        $scope.editDepositDemand.clientOkpo = $scope.currOperDBO('Deposit_id');
                        $scope.editDepositDemand.clientName = $scope.currOperDBO('Customer_id');
                        $scope.editDepositDemand.dbo = $scope.currOperDBO('Contract_number');
                    }


                    $scope.editDepositDemand.currency = $scope.requestObj.CurrencyId;
                    $scope.editDepositDemand.Branch = $scope.requestObj.Branch;
                    $scope.editDepositDemand.acc = $scope.requestObj.PrimaryAccount;
                    $scope.editDepositDemand.payingperiod = "Щомісяця";
                    $scope.editDepositDemand.replenishmentOnDayRegistration = $scope.requestObj.TransferDayRegistration == "1" ? true : false;
                    $("#editDepositDemandSaveBtn").prop("disabled", false);

                    $scope.editDepositDemand.IsIndividualRate = $scope.requestObj.IsIndividualRate == "1" ? true : false;
                    $scope.editDepositDemand.individualInterestRateValue = $scope.requestObj.IndividualInterestRate;
                    $('[k-ng-model="editDepositDemand.individualInterestRateValue"]').data('kendoNumericTextBox').value($scope.requestObj.IndividualInterestRate);

                    $scope.editDepositDemand.Comment = $scope.requestObj.Comment;
                    $('[ng-model="editDepositDemand.dboDate"]').data('kendoDatePicker').value(new Date());
                    $("[ng-model ='editDepositDemand.IsSigned']").data("kendoDropDownList").value($scope.requestObj.IsSigned);
                    $scope.editDepositDemand.AmountDeposit = $scope.requestObj.AmountDeposit;


                    $scope.GetUsers($scope.processId, 'editDepositDemand');
                    $scope.editDepositDemand.Status = $scope.curRequireDeposit('DEPOSIT_STATE_NAME');

                    var editDepositDemandDS = new kendo.data.DataSource({
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                                data: function () {
                                    return {
                                        customerId: $scope.editDepositDemand.clientRnk,
                                        currencyId: $scope.editDepositDemand.currency
                                    };
                                }
                            }
                        },
                        requestEnd: function (e) {
                            if (e.response.Data) {
                                if (e.response.Data.length !== 0) {
                                    var acc = e.response.Data[0].Nls;
                                    $("[ng-model='editDepositDemand.accCredit']").data("kendoDropDownList").value(acc);
                                    //$scope.editDepositDemand.accCredit = acc;
                                }
                            }
                        },
                        schema: {
                            data: "Data",
                            total: "Total"
                        }
                    });

                    editDepositDemandDS.read();

                    $("#creditAccEditDepositDemand").kendoDropDownList({
                        autoBind: false,
                        dataSource: editDepositDemandDS,
                        dataTextField: "Nls",
                        dataValueField: "Nls",
                        valuePrimitive: true,
                        optionLabel: "",
                        //change: function (e) {
                        //    //var currentSelector = e.sender.element[0].id;
                        //    //var value = this.value();
                        //    //if ("debitAccEditDepositDemand" === currentSelector) {
                        //        var dataSource = this.dataSource.data();
                        //        var length = dataSource.length;
                        //        var value = dataSource[0].Nls;
                        //        //var ostc;

                        //        //for (var i = 0; i < length; i++) {
                        //            //if (dataSource[i].Nls == value) {
                        //            //    ostc = dataSource[i].Ostc;
                        //            //    break;
                        //            //}
                        //        //}
                        //        $scope.editDepositDemand.accDebit = value;
                        //        //$('#DebitAccEditDepositDemandOstc').data('kendoNumericTextBox').value(ostc);

                        //    ////} else {
                        //    ////    $scope.editDepositDemand.accCredit = value;
                        //    ////}
                        //},

                    });

                    var editDepositDemandCalculationDS = new kendo.data.DataSource({
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/gda/gda/getcalculationtype")
                            }
                        }
                    });

                    editDepositDemandCalculationDS.read();

                    $("#editCalculationTypeDropDownList").kendoDropDownList({
                        autoBind: false,
                        dataSource: editDepositDemandCalculationDS,
                        dataBound: function () {
                            $("#editCalculationTypeDropDownList").data("kendoDropDownList").value($scope.requestObj.CalculationType);
                        },
                        dataTextField: "item_name",
                        dataValueField: "item_id",
                        valuePrimitive: true,
                        optionLabel: "",
                        change: function (e) {
                            $scope.editDepositDemand.calculationType = $("#editCalculationTypeDropDownList").data("kendoDropDownList").value();
                        }
                    });

                    $scope.editDepositDemand.calculationType = $scope.requestObj.CalculationType;
                    //$("#creditAccCloseDepositDemand").data("kendoDropDownList").value($scope.requestObj.ReturnAccount);
                }, function (error) { $scope[form].close(); });
            }

            if (formId === 'changeDepositDemand' && $scope.processId !== 0) {
                $scope[form].center().open();
                $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));

                $http.get(bars.config.urlContent("/api/gda/gda/geteditingdepositdemand?processId=" + $scope.processId)).then(function (request) {
                    $scope.requestObj = request.data;

                    $scope.GetUsers($scope.processId, 'changeDepositDemand');
                    $scope.changeDepositDemand.Status = $scope.curRequireDeposit("DEPOSIT_STATE_NAME");

                    var changeDepositDemandCalculationDS = new kendo.data.DataSource({
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/gda/gda/getcalculationtype")
                            }
                        }
                    });

                    changeDepositDemandCalculationDS.read();

                    $("#changeCalculationTypeDropDownList").kendoDropDownList({
                        autoBind: false,
                        dataSource: changeDepositDemandCalculationDS,
                        dataBound: function () {
                            $("#changeCalculationTypeDropDownList").data("kendoDropDownList").value($scope.requestObj.CalculationType);
                        },
                        change: function () {
                            var value = $("#changeCalculationTypeDropDownList").data("kendoDropDownList").value();
                            $scope.changeDepositDemand.CalculationType = value;
                        },
                        dataTextField: "item_name",
                        dataValueField: "item_id",
                        valuePrimitive: true,
                        optionLabel: ""
                    });

                    //$scope.changeDepositDemand.CalculationType = $scope.requestObj.CalculationType;
                    $("[ng-model='changeDepositDemand.CalculationType']").data("kendoDropDownList").value($scope.requestObj.CalculationType);
                    $scope.changeDepositDemand.ProcessId = $scope.requestObj.ProcessId;
                    $scope.changeDepositDemand.Comment = $scope.requestObj.Comment;
                    if ($scope.requestObj.CAN_SAVE == 0) {
                        $('#changeCalculationTypeDropDownList').data('kendoDropDownList').enable(false);
                        //$('#changeCalculationTypeDropDownList').prop('disabled', true);
                        $('[ng-model="changeDepositDemand.CalculationType"]').prop('disabled', true);
                        $('[ng-model="changeDepositDemand.Comment"]').prop('disabled', true);
                        $('#saveChangeDepositType').prop('disabled', true);
                    } else {
                        $('#authChangeDepositType').prop('disabled', true);
                        $('#saveChangeDepositType').prop('disabled', false);
                    }

                    //$("#creditAccCloseDepositDemand").data("kendoDropDownList").value($scope.requestObj.ReturnAccount);
                }, function (error) { $scope[form].close(); });
            }

            //Размещения транша
            if (formId === 'placementTranche') {
                $scope[form].center().open();     //.maximize();  

                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope.placementTranche.CustomerId = $scope.currOperDBO('Customer_id');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.contract_date));
                } else {
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));
                    $scope[scopeFormId].CustomerId = $scope.curAccInfo('rnk');
                }
                //




            }
            //

            if (formId === 'depositDemand') {
                $scope[form].center().open();
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[scopeFormId].clientRnk = $scope.currOperDBO('Customer_id');
                    $scope[scopeFormId].clientOkpo = $scope.currOperDBO('Deposit_id');
                    $scope[scopeFormId].clientName = $scope.currOperDBO('Customer_name');
                    $scope.titleDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
                    $scope.depositDemand.dboDate = kendo.toString(kendo.parseDate($scope.currOperDBO('Sys_time')), 'dd.MM.yyyy');
                    $scope[scopeFormId].dbo = $scope.currOperDBO('Contract_number');
                    $scope[scopeFormId].dboDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
                    $scope.requestObj.StartDate = $('[ng-model="depositDemand.dboDate"]').data('kendoDatePicker').value(new Date());
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.contract_date));


                } else {
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.curAccInfo('contract_date')));
                    $("#DebitAccDepositDemand").data("kendoDropDownList").dataSource.data([]);
                    //$('#DebitAccDepositDemandOstc').data('kendoNumericTextBox').value("");

                    $scope[scopeFormId].dbo = $scope.curAccInfo('contract_number');
                    $scope[scopeFormId].dboDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
                    $scope.requestObj.StartDate = $('[ng-model="depositDemand.dboDate"]').data('kendoDatePicker').value(new Date());
                    $scope[scopeFormId].clientRnk = $scope.curAccInfo('rnk');
                    $scope[scopeFormId].clientOkpo = $scope.curAccInfo('okpo');
                    $scope[scopeFormId].clientName = $scope.curAccInfo('nmk');
                    $scope[scopeFormId].currency = null;
                    $("#calculationTypeDropDownList").data("kendoDropDownList").dataSource.read();

                }
            }
            if (formId === 'earlyRepaymentTranche') {

                $scope[form].center().open();     //.maximize();      
                //берём номер дбо с грида операциониста
                if ($scope.nd == null) {
                    $scope.nd = $scope.currOperDBO('Contract_number');
                    $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                }
                //
                $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
                $scope[scopeFormId] = modelService.initFormData(scopeFormId);


                $http.get(bars.config.urlContent("/api/gda/gda/getearlypaymenttranche?processId=" + '' + "&trancheId=" + $scope.curTrancheInfo('tranche_id')))
                    .then(function (request) {
                        $scope.requestObj = request.data;
                        //ANDRII HNATIUK
                        $scope.processId = $scope.requestObj.ProcessId;
                        //
                        //если нет процесса айди = значит досрочный возврат не сохранялся = на авторизацию сразу передать нельзя ()
                        if ($scope.processId == null || $scope.processId == '' || $scope.processId == undefined) {
                            $('#authEarlyRepaymentTranche').prop('disabled', true);
                            $('#printBtnEarly').prop('disabled', true);
                            $('#isSignEarlyRepayment').data('kendoDropDownList').enable(false);
                        } else {
                            $('#authEarlyRepaymentTranche').prop('disabled', false);
                            $('#printBtnEarly').prop('disabled', false);
                            $('#isSignEarlyRepayment').data('kendoDropDownList').enable(true);
                        }

                        $scope.earlyRepaymentTranche.CustomerId = $scope.requestObj.CustomerId;
                        $scope.earlyRepaymentTranche.DealNumber = $scope.curTrancheInfo("deal_number"); // Номер заяви про розміщення траншу
                        $scope.earlyRepaymentTranche.PrimaryAccount = $scope.requestObj.PrimaryAccount;
                        $scope.earlyRepaymentTranche.CurrencyId = $scope.requestObj.CurrencyId;
                        $scope.earlyRepaymentTranche.amountTranche = $scope.requestObj.AmountTranche;
                        $("[ng-model='earlyRepaymentTranche.amountTranche']").data("kendoNumericTextBox").value($scope.requestObj.AmountTranche);
                        $scope.earlyRepaymentTranche.NumberTrancheDays = $scope.requestObj.NumberTrancheDays;
                        $("[ng-model='earlyRepaymentTranche.StartDate']").data("kendoDatePicker").value(kendo.parseDate($scope.today, "dd.MM.yyyy"));
                        $("#earlyDatePlacement").data("kendoDatePicker").value(kendo.parseDate($scope.placementDate, "dd.MM.yyyy"));
                        $("#earlyDatePlacementTranche").data("kendoDatePicker").value(kendo.parseDate($scope.placementDate, "dd.MM.yyyy"));
                        $("[ng-model='earlyRepaymentTranche.ExpiryDate']").data("kendoDatePicker").value($scope.requestObj.ExpiryDate);
                        $scope.earlyRepaymentTranche.FrequencyPaymentName = $scope.curTrancheInfo('frequency_payment_name');
                        $scope.earlyRepaymentTranche.interestRate = $scope.requestObj.InterestRate;
                        $("[ng-model='earlyRepaymentTranche.interestRate']").data("kendoNumericTextBox").value($scope.requestObj.InterestRate);
                        $("[ng-model='earlyRepaymentTranche.IsIndividualInterestRate']").prop('checked', $scope.requestObj.InterestRate);
                        $scope.earlyRepaymentTranche.IndividualInterestRate = $scope.requestObj.IndividualInterestRate;
                        $("[ng-model='earlyRepaymentTranche.IndividualInterestRate']").data("kendoNumericTextBox").value($scope.requestObj.IndividualInterestRate);
                        $scope.earlyRepaymentTranche.Comment = $scope.curTrancheInfo('comment_text');
                        $scope.earlyRepaymentTranche.AdditionalComment = $scope.requestObj.AdditionalComment;
                        $scope.earlyRepaymentTranche.DebitAccount = $scope.requestObj.DebitAccount;
                        $scope.earlyRepaymentTranche.PenaltyRate = $scope.requestObj.PenaltyRate;
                        $('[ng-model="earlyRepaymentTranche.PenaltyRate"]').data("kendoNumericTextBox").value($scope.requestObj.PenaltyRate);
                        $("#DebitAccEarlyRepayment").data("kendoDropDownList").dataSource.read();
                        $scope.earlyRepaymentTranche.isProlongation = $scope.requestObj.IsProlongation;
                        $scope.earlyRepaymentTranche.MaxSumTranche = $scope.requestObj.MaxSumTranche;
                        $scope.earlyRepaymentTranche.InterestRateProlongation = $scope.requestObj.InterestRateProlongation;
                        $scope.earlyRepaymentTranche.isReplenishmentTranche = $scope.requestObj.IsReplenishmentTranche;
                        $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value($scope.requestObj.IndividualInterestRate);

                        $scope.earlyRepaymentTranche.LastReplenishmentDate = $scope.requestObj.LastReplenishmentDate;

                        $scope.earlyRepaymentTranche.MinReplenishmentAmount = $scope.requestObj.MinReplenishmentAmount;
                        $scope.earlyRepaymentTranche.FrequencyPayment = $scope.requestObj.FrequencyPayment;
                        $scope.earlyRepaymentTranche.IsIndividualRate = +$scope.requestObj.IsIndividualRate;
                        $scope.earlyRepaymentTranche.IsCapitalization = $scope.requestObj.IsCapitalization;
                        $("[ng-model ='placementTranche.DebitAccount']").data("kendoDropDownList").value($scope.requestObj.DebitAccount);
                        $("[ng-model ='earlyRepaymentTranche.ReturnAccount']").data("kendoDropDownList").value($scope.requestObj.ReturnAccount);
                        $scope.earlyRepaymentTranche.InterestAccount = $scope.requestObj.InterestAccount;
                        $scope.earlyRepaymentTranche.Branch = request.data.Branch;
                        $scope.earlyRepaymentTranche.Status = $scope.curTrancheInfo('tranche_state_name');
                        $("[ng-model ='earlyRepaymentTranche.IsSigned']").data("kendoDropDownList").value($scope.requestObj.IsSigned);
                    }, function (error) {

                    });

                $scope.GetUsers($scope.processId, 'earlyRepaymentTranche');

                ////
                //$http.get(bars.config.urlContent("/api/gda/gda/getoperatorcontrollerinfo?processId=" + $scope.processId)).then(function (request) {
                //    $scope.requestObjUsers = request.data;

                //    $scope.earlyRepaymentTranche.OperatorFullName = $scope.requestObjUsers.OperatorFullName;
                //    $scope.earlyRepaymentTranche.ControllerFullName = $scope.requestObjUsers.ControllerFullName;
                //    $scope.earlyRepaymentTranche.ControllerSysTime = $scope.requestObjUsers.ControllerSysTime;
                //    $scope.earlyRepaymentTranche.OperatorSysTime = $scope.requestObjUsers.OperatorSysTime;
                //});
                ////
            }

            //$scope[scopeFormId].Status = $scope.curTrancheInfo('State');
            //$scope[scopeFormId].OperatorName = $scope.curTrancheInfo('OperatorName');
            //$scope[scopeFormId].ControllerName = $scope.curTrancheInfo('ControllerName');
            //$scope[scopeFormId].OperatorDate = kendo.toString($scope.curTrancheInfo('OperatorDate'), 'dd.MM.yyyy');
            //$scope[scopeFormId].ControllerDate = kendo.toString($scope.curTrancheInfo('ControllerDate'), 'dd.MM.yyyy');

            //$scope[scopeFormId].kontractPlacement = $scope.curTrancheInfo('TranshNumber');
            //$scope[scopeFormId].dateKontractPlacement = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
            //$scope[scopeFormId].acc = $scope.curAccInfo('Acc');
            //$scope[scopeFormId].currency = $scope.curAccInfo('Kv');
        }

        if (formId == 'replenishmentHistory') {
            $http.get(bars.config.urlContent("/api/gda/gda/getreplenishmenthistory?trancheId=" + $scope.curTrancheInfo('tranche_id')))
                .success(function (request) {
                    $("#replenishmentHistoryGrid").data("kendoGrid").dataSource.read();
                },
                function (error) { });
            $scope[form].center().open();     //.maximize();   

            //берём номер дбо с грида операциониста
            if ($scope.nd == null) {
                $scope.nd = $scope.currOperDBO('Contract_number');
                $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
            }
            $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.titleDate));
        }

    };

    // подтягиваем счёт когда выбрали валюту и нажали ентер
    $scope.checkIfEnterKeyWasPressed = function ($event) {

        var keyCode = $event.which || $event.keyCode;
        if (keyCode === 13) {
            $event.preventDefault();
            var id = $event.currentTarget.id;
            var formId = id.slice(0, -8);
            if (formId === "placement") {
                $("#DebitAcc").data("kendoDropDownList").dataSource.read();
                $('#placementOstc').data('kendoNumericTextBox').value('');
            } else if (formId === "replacement") {
                $("#DebitAccReplacement").data("kendoDropDownList").dataSource.read();
                $('#replacementOstc').data('kendoNumericTextBox').value('');
            }
        }
    };

    //При нажатии enter выполнять поиск в Портфеле ДБО
    $("#numberDBO, #rnk,#okpo").on('keyup', function (e) {
        if (e.keyCode == 13) {

            $("#btnSearch").click();
        }
    });

    //$scope.valuesAutoExtension = [
    //    { value: true, name: "Так" },
    //    { value: false, name: "Ні" }
    //];


    //Функция получения значения в гриде
    var _getGridValue = function (grid, fieldId) {
        var row = grid.dataItem(grid.select());
        return row !== null ? row[fieldId] : null;
    };

    //Универсальные функции, которые получают значения с грида по имени поля
    $scope.curAccInfo = function (fieldId) {
        var grid = $scope.DBOGrid;
        var result = _getGridValue(grid, fieldId);
        return result;

    };
    $scope.curTrancheInfo = function (fieldId) {
        var grid = $scope.TimeTranshesGrid;
        var result = _getGridValue(grid, fieldId);
        return result;
    };
    $scope.curReplenishInfo = function (fieldId) {
        var grid = $scope.ReplenishmentHistoryGrid;
        return _getGridValue(grid, fieldId);
    };
    $scope.curRequireDeposit = function (fieldId) {
        var grid = $scope.RequireDepositGrid;
        return _getGridValue(grid, fieldId);
    };
    $scope.curEditReplenishment = function (fieldId) {
        var grid = $scope.ReplenishmentHistoryGrid;
        return _getGridValue(grid, fieldId);
    };
    $scope.currOperDBO = function (fieldId) {
        var grid = $scope.OperationistDBOGrid;
        if (grid == undefined) {
            return;
        } else {
            var result = _getGridValue(grid, fieldId);
            return result;
        }
    };
    //Немного изменил функцию, нужно значение с грида строка которого не выбрана 
    $scope.curDepositAcc = function (fieldId) {
        $scope.data = $scope.accountsGrid.dataSource._data;
        if ($scope.data.length == 0) {
            return "(відсутній)"
        } else {
            var acc = $scope.data[0].account_number;
            return acc;
        }
    };
    //конец блока универсальных функций

    //Инициализация окон при нажатии на соответсвующие кнопки
    $scope.placementTrancheWindowOptions = $scope.window({
        title: 'Розміщення траншу', height: "855px", width: "970px", resizable: false, draggable: false, close: function (e) {
            $("#timetranchesgrid").data("kendoGrid").dataSource.read();
            $("#timetranchesgrid").data("kendoGrid").refresh();
            //
            $('#replacementTrancheBtn').prop("disabled", true);
            $('#replenishmentTrancheBtn').prop("disabled", true);
            $('#earlyRepaymentTrancheBtn').prop("disabled", true);
            $('#printBtn').prop("disabled", true);
        }
    });
    $scope.replenishmentTrancheWindowOptions = $scope.window({
        title: 'Поповнення траншу', height: "480px", width: "970px", resizable: false, draggable: false, close: function (e) {
            $('#replacementTrancheBtn').prop("disabled", true);
            $('#replenishmentTrancheBtn').prop("disabled", true);
            $('#earlyRepaymentTrancheBtn').prop("disabled", true);
            $('#printBtn').prop("disabled", true);
        }
    });
    $scope.replenishmentTrancheHistoryWindowOptions = $scope.window({
        title: 'Історія операцій поповнення траншу', height: "480px", width: "970px", close: function (e) {
            //
            $('#replacementTrancheBtn').prop("disabled", true);
            $('#replenishmentTrancheBtn').prop("disabled", true);
            $('#earlyRepaymentTrancheBtn').prop("disabled", true);
            $('#printBtn').prop("disabled", true);
        }
    });
    $scope.earlyRepaymentTrancheWindowOptions = $scope.window({
        title: 'Дострокове повернення траншу', height: "800px", width: "1000px", resizable: false, draggable: false, close: function (e) {
            $("#timetranchesgrid").data("kendoGrid").dataSource.read();
            $("#timetranchesgrid").data("kendoGrid").refresh();
            //
            $('#replacementTrancheBtn').prop("disabled", true);
            $('#replenishmentTrancheBtn').prop("disabled", true);
            $('#earlyRepaymentTrancheBtn').prop("disabled", true);
            $('#printBtn').prop("disabled", true);
        }
    });
    $scope.editreplenishmentTrancheWindowOptions = $scope.window({ title: 'Редагування поповнення траншу', height: "480px", width: "1000px", modal: true, resizable: false, draggable: false });
    $scope.depositDemandWindowOptions = $scope.window({ title: 'Відкриття вкладу на вимогу', height: "730px", width: "930px", resizable: false, draggable: false });
    //

    //Выпадающий список Пролонгация в окне Расмещения/Редактирования транша
    $scope.ProlongationListDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getprolongatiotranchelist"),
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.ProlongationListOptions = {
        dataSource: $scope.ProlongationListDataSource,
        dataTextField: "item_name",
        dataValueField: "item_id",
        optionLabel: {
            item_name: "Оберіть значення",
            item_id: null
        },
        enable: function () {
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 0) {
                return false;
            }
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {
                return true;
            }
        }
    };
    //

    //Выпадающий список Пролонгация в окне Размещения/Редактирования транша
    $scope.CapitalizationListDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/GetCapitalizationTrancheList"),
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.CapitalizationListOptions = {
        dataSource: $scope.CapitalizationListDataSource,
        dataTextField: "item_name",
        dataValueField: "item_id",
        optionLabel: {
            item_name: "Оберіть значення",
            item_id: null
        },
        dataBound: function () {
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 0) {
                this.enable(false);
            }
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {
                this.enable(true);
            }
        },
        enable: function () {
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 0) {
                return false;
            }
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {
                return true;
            }
        }
    };
    //

    //Настройка всех дат
    $scope.dateOptions = {
        format: "dd.MM.yyyy",
        min: new Date()
    };
    //Настройка дат где нужно выбрать дату, но не "меньше", чем сегодня
    $scope.dateOptionsWithoutMin = {
        format: 'dd.MM.yyyy'
    }

    //Выпадающий список Рахунок для списання в окне Поповнення траншу
    $scope.DebitAccReplenishmentDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",

                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    var a = {
                        customerId: $scope.replenishmentTranche.CustomerId,
                        currencyId: $scope.replenishmentTranche.CurrencyId,
                    };
                    return a;
                }
            }
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var value = e.response.Data[0].Ostc,
                        acc = e.response.Data[0].Nls;
                    $('#replenishmentOstc').data('kendoNumericTextBox').value(value);
                    $scope.replenishmentTranche.DebitAccount = acc;
                    //$("[ng-model='replenishmentTranche.DebitAccount']").data("kendoDropDownList").value(acc);
                }
            }

        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.DebitAccReplenishmentOptions = {
        autoBind: false,
        valuePrimitive: true,
        dataSource: $scope.DebitAccReplenishmentDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        optionLabel: "",
        change: function (e) {
            var value = this.value();
            var dataSource = this.dataSource.data();
            var length = dataSource.length;
            var ostc;
            for (var i = 0; i < length; i++) {
                if (dataSource[i].Nls == value) {
                    ostc = dataSource[i].Ostc;
                    break;
                }
            }
            $('#replenishmentOstc').data('kendoNumericTextBox').value(ostc);
        }
    };
    //

    //Выпадающий список Рахунок для списання в окне Поповнення траншу(редагування)
    $scope.DebitAccEditReplenishmentDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",

                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    var a = {
                        customerId: $scope.editreplenishmentTranche.CustomerId,
                        currencyId: $scope.editreplenishmentTranche.CurrencyId,
                    };
                    return a;
                }
            }
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var value = e.response.Data[0].Ostc,
                        acc = e.response.Data[0].Nls;

                    $('#editreplenishmentOstc').data('kendoNumericTextBox').value(value);
                    $scope.editreplenishmentTranche.DebitAccount = acc;
                }
            }

        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.DebitAccEditReplenishmentOptions = {
        autoBind: false,
        valuePrimitive: true,
        dataSource: $scope.DebitAccEditReplenishmentDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        optionLabel: "",
        change: function (e) {
            var value = this.value();
            var dataSource = this.dataSource.data();
            var length = dataSource.length;
            var ostc;
            for (var i = 0; i < length; i++) {
                if (dataSource[i].Nls == value) {
                    ostc = dataSource[i].Ostc;
                    break;
                }
            }
            $('#editreplenishmentOstc').data('kendoNumericTextBox').value(ostc);
        }
    };
    //

    //Выпадающий список Рахунок для списання в окне Дострокове повернення траншу
    $scope.DebitAccEarlyRepaymentDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",

                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    if ($scope.curAccInfo('rnk') == null) {
                        var a = {
                            customerId: $scope.currOperDBO('Customer_id'),
                            currencyId: $scope.earlyRepaymentTranche.CurrencyId
                        };
                    } else {
                        var a = {
                            customerId: $scope.curAccInfo('rnk'),
                            currencyId: $scope.earlyRepaymentTranche.CurrencyId
                        };
                    }
                    return a;
                }
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var acc = e.response.Data[0].Nls;
                    $scope.earlyRepaymentTranche.ReturnAccount = acc;
                    //$("[ng-model='earlyRepaymentTranche.ReturnAccount']").data("kendoDropDownList").value(acc);
                }
            }

        },
    });
    $scope.DebitAccEarlyRepaymentOptions = {
        autoBind: false,
        valuePrimitive: true,
        dataSource: $scope.DebitAccEarlyRepaymentDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        optionLabel: ""
    };
    //

    //Выпадающий список Рахунок для списання в окне Розміщення траншу
    $scope.DebitAccDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    if ($scope.curAccInfo('rnk') == null) {
                        var a = {
                            customerId: $scope.currOperDBO('Customer_id'),
                            currencyId: $scope.placementTranche.CurrencyId,
                        };
                    } else {
                        var a = {
                            customerId: $scope.curAccInfo('rnk'),
                            currencyId: $scope.placementTranche.CurrencyId,
                        };
                    }
                    return a;
                }
            }
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var value = e.response.Data[0].Ostc;
                    var acc = e.response.Data[0].Nls;
                    $scope.placementTranche.DebitAccount = acc;
                    $scope.placementTranche.ReturnAccount = acc;
                    $('#placementOstc').data('kendoNumericTextBox').value(value);
                    //$('#DebitAcc').data('kendoDropDownList').value(acc);
                    //$("#DebitReturn").data("kendoDropDownList").value(acc);

                } else {
                    $('#placementOstc').data('kendoNumericTextBox').value('');
                }

            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.DebitAccOptions = {
        autoBind: false,
        valuePrimitive: true,
        optionLabel: '',
        dataSource: $scope.DebitAccDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        change: function (e) {
            var selector = "placementTranche.DebitAccount";
            var currentSelector = e.sender.element.select()[0].attributes[4].value;

            //эта проверка для того, потмоу что у IE странный порядок атрибутов в объекте элемента (в IE он 5й, а в Хроме - 4й )
            //dropdownlist - это 4й атрибут в IE
            if (currentSelector == 'dropdownlist') {
                currentSelector = e.sender.element.select()[0].attributes[5].value;
            } else {
                var currentSelector = e.sender.element.select()[0].attributes[4].value;
            }

            if (selector === currentSelector) {
                var value = this.value();
                var dataSource = this.dataSource.data();
                var length = dataSource.length;
                var ostc;

                for (var i = 0; i < length; i++) {
                    if (dataSource[i].Nls == value) {
                        ostc = dataSource[i].Ostc;
                        break;
                    }
                }
                //$("#placementOstc option:selected").val(ostc);
                $('#placementOstc').data('kendoNumericTextBox').value(ostc);
            }
        }
    };
    //

    //Выпадающий список Рахунок для списання в окне вклади на вимогу (відкриття)
    $scope.DebitAccDepositDemandDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    if ($scope.curAccInfo('rnk') == null) {
                        var a = {
                            customerId: $scope.currOperDBO('Customer_id'),
                            currencyId: $scope.depositDemand.currency,
                        };
                        return a;
                    } else {
                        var a = {
                            customerId: $scope.curAccInfo('rnk'),
                            currencyId: $scope.depositDemand.currency,
                        };
                        return a;
                    }
                }
            }
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var acc = e.response.Data[0].Nls;
                    $scope.DepositDemand.accCredit = acc;
                }
            }

        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.DebitAccDepositDemandOptions = {
        autoBind: false,
        valuePrimitive: true,
        optionLabel: "",
        dataSource: $scope.DebitAccDepositDemandDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        change: function (e) {
            var selector = "DepositDemand.accDebit";
            var currentSelector = e.sender.element.select()[0].attributes[4].value;

            if (selector === currentSelector) {
                var value = this.value();
                var dataSource = this.dataSource.data();
                var length = dataSource.length;
                var ostc;

                for (var i = 0; i < length; i++) {
                    if (dataSource[i].Nls == value) {
                        ostc = dataSource[i].Ostc;
                        break;
                    }
                }

                $('#DebitAccDepositDemandOstc').data('kendoNumericTextBox').value(ostc);
            }
        }
    };
    //

    //Выпадающий список Метод нарахування %
    $scope.CalculationTypeDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getcalculationtype")
            }
        }
    });
    $scope.CalculationTypeOptions = {
        autoBind: false,
        valuePrimitive: true,
        optionLabel: "",
        dataSource: $scope.CalculationTypeDataSource,
        dataTextField: "item_name",
        dataValueField: "item_id"
    };
    //

    //Выпадающий список Рахунок для списання в окне Редагування траншу
    $scope.DebitAccReplacementDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
                data: function () {
                    var a = {
                        customerId: $scope.replacementTranche.CustomerId,
                        currencyId: $scope.replacementTranche.CurrencyId,
                    };
                    return a;
                }
            }
        },
        requestEnd: function (e) {
            if (e.response.Data) {
                if (e.response.Data.length !== 0) {
                    var ostc = e.response.Data[0].Ostc;
                    var retAcc = e.response.Data[0].Nls;
                    $('#replacementOstc').data('kendoNumericTextBox').value('');
                    $("[ng-model ='replacementTranche.ReturnAccount']").data("kendoDropDownList").value(retAcc);
                    $("[ng-model ='replacementTranche.ReturnAccount']").data("kendoDropDownList").trigger('change');
                    $("[ng-model ='replacementTranche.DebitAccount']").data("kendoDropDownList").value(retAcc);
                    $("[ng-model ='replacementTranche.DebitAccount']").data("kendoDropDownList").trigger('change');
                    $("#replacementOstc").data('kendoNumericTextBox').value(ostc);
                }
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.DebitAccReplacementOptions = {
        autoBind: true,
        dataSource: $scope.DebitAccReplacementDataSource,
        dataTextField: "Nls",
        dataValueField: "Nls",
        optionLabel: "",
        change: function (e) {
            var selector = "replacementTranche.DebitAccount";
            var currentSelector = e.sender.element.select()[0].attributes[4].value;

            //эта проверка для того, потмоу что у IE странный порядок атрибутов в объекте элемента (в IE он 5й, а в Хроме - 4й )
            //dropdownlist - это 4й атрибут в IE
            if (currentSelector == 'dropdownlist') {
                currentSelector = e.sender.element.select()[0].attributes[5].value;
            } else {
                var currentSelector = e.sender.element.select()[0].attributes[4].value;
            }

            if (selector === currentSelector) {
                var value = this.value();
                var dataSource = this.dataSource.data();
                var length = dataSource.length;
                var ostc;

                for (var i = 0; i < length; i++) {
                    if (dataSource[i].Nls == value) {
                        ostc = dataSource[i].Ostc;
                        break;
                    }
                }
                $('#replacementOstc').data('kendoNumericTextBox').value(ostc);
            }
        }
    };
    //

    //Выпадающий список Періодичність виплати в окне Розміщення/Редагування траншу 
    $scope.FrequencyDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getpaymenttermtranche")
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    $scope.FrequencyListReplaceOptions = {
        autoBind: false,
        dataSource: $scope.FrequencyDataSource,
        dataTextField: "ITEM_NAME",
        dataValueField: "ITEM_ID",
        change: function (e) {
            $scope.onClick('replacementTranche', 'count');
        }
    };
    //

    //Выпадающий список Періодичність виплати в окне Розміщення траншу
    $scope.FrequencyListOptions = {
        autoBind: false,
        dataSource: $scope.FrequencyDataSource,
        dataTextField: "ITEM_NAME",
        dataValueField: "ITEM_ID"
    };
    //

    //Випадающий список автопролонгация в размещении транша
    $scope.NumberProlongationOptionsDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/gda/gda/getnumberprolongationlist"),
                data: function () {
                    if ($scope.placementTranche.CurrencyId != null) {
                        var a = {
                            startDate: $scope.placementTranche.StartDate,
                            currencyId: $scope.placementTranche.CurrencyId
                        }
                    } else if ($scope.replacementTranche.CurrencyId != null) {
                        var a = {
                            startDate: $("#datePlacement").val(),
                            currencyId: $scope.replacementTranche.CurrencyId
                        }
                    } else {
                        var a = {
                            startDate: null,
                            currencyId: null
                        }
                    }

                    return a
                }
            }
        },
        requestEnd: function (e) {
            if (e.response && e.response.Data) {
                if (e.response.Data.length !== 0 && $scope.replacementTranche.IsProlongation == 1 && $('#applyprologFieldReplace').val() != '') {
                    $scope.replacementTranche.NumberProlongation = $scope.requestObj.NumberProlongation;
                } else if (e.response.Data.length !== 0 && $scope.replacementTranche.NumberProlongation == null && $('#applyprologFieldReplace').val() == '') {
                    return;
                } else if (e.response.Data.length !== 0 && $scope.replacementTranche.IsProlongation == 0 && $('#applyprologFieldReplace').val() == '') {
                    return;
                } else {
                    $scope.replacementTranche.NumberProlongation = null;
                    $scope.replacementTranche.IsProlongation = 0;
                    $('#applyprologFieldReplace').val('');
                }
            }
        },
        schema: {
            data: "Data",
            total: "Total"
        }
    });
    //

    //Выпадающий спискок Кол-во автолонгаций Создании транша
    $scope.NumberProlongationOptions = {
        autoBind: false,
        optionLabel: 'Оберіть умову',
        dataSource: $scope.NumberProlongationOptionsDataSource,
        dataTextField: "NUMBERPROLONGATION",
        dataValueField: "NUMBERPROLONGATION",
        template: 'Пролонгації: #:NUMBERPROLONGATION# | Cтавка: #:INTEREST_RATE # % | Термін: #:NAME_ #',
        change: function (e) {
            var dropdownlist = $("#NumberProlongationList").data("kendoDropDownList");
            var dataItem = dropdownlist.dataItem();

            $('#applyprologField').val(dataItem.NAME_);

            $scope.placementTranche.NumberProlongation = dataItem.NUMBERPROLONGATION;
            $scope.placementTranche.InterestRateProlongation = dataItem.INTEREST_RATE;
            $scope.placementTranche.ApplyBonusProlongation = dataItem.APPLYBONUSPROLONGATION;

            $scope.replacementTranche.NumberProlongation = dataItem.NUMBERPROLONGATION;
            $scope.replacementTranche.InterestRateProlongation = dataItem.INTEREST_RATE;
            $scope.replacementTranche.ApplyBonusProlongation = dataItem.APPLYBONUSPROLONGATION;

        }
    };
    //

    //Выпадающий спискок Кол-во автолонгаций Редактировании транша
    $scope.NumberProlongationReplaceOptions = {
        autoBind: false,
        //optionLabel: 'Оберіть умову',
        dataSource: $scope.NumberProlongationOptionsDataSource,
        dataTextField: "NUMBERPROLONGATION",
        dataValueField: "NUMBERPROLONGATION",
        template: 'Пролонгації: #:NUMBERPROLONGATION# | Cтавка: #:INTEREST_RATE # % | Термін: #:NAME_ #',
        change: function (e) {
            var dropdownlist = $("#NumberProlongationListReplace").data("kendoDropDownList");
            var dataItem = dropdownlist.dataItem();
            if (dataItem != undefined) {
                $('#applyprologFieldReplace').val(dataItem.NAME_);
                $('#NumberProlongationListReplace').val(dataItem.NUMBERPROLONGATION);

                $scope.replacementTranche.NumberProlongation = dataItem.NUMBERPROLONGATION;
                $scope.replacementTranche.InterestRateProlongation = dataItem.INTEREST_RATE;
                $scope.replacementTranche.ApplyBonusProlongation = dataItem.APPLYBONUSPROLONGATION;
            } else {

                //
                var selector = "replacementTranche.NumberProlongation";
                var currentSelector = e.sender.element.select()[0].attributes[4].value;

                //эта проверка для того, потмоу что у IE странный порядок атрибутов в объекте элемента (в IE он 5й, а в Хроме - 4й )
                //dropdownlist - это 4й атрибут в IE
                if (currentSelector == 'dropdownlist') {
                    currentSelector = e.sender.element.select()[0].attributes[5].value;
                } else {
                    var currentSelector = e.sender.element.select()[0].attributes[4].value;
                }

                if (selector === currentSelector) {
                    var value = this.value();
                    var dataSource = this.dataSource.data();
                    var length = dataSource.length;
                    var ostc;

                    for (var i = 0; i < length; i++) {
                        if (dataSource[i].Nls == value) {
                            ostc = dataSource[i].Ostc;
                            break;
                        }
                    }
                    $('#replacementOstc').data('kendoNumericTextBox').value(ostc);
                }
            }
            if ($scope.replacementTranche.IsProlongation == '0') {
                dropdownlist.dataSource.read([])
            }
            //
        }
    };
    //

    //Выпадающий список Да/Нет поле Автопролонгация Размещение
    $scope.IsProlongationOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {
            if ($scope.placementTranche.CurrencyId == null || $scope.placementTranche.CurrencyId == '') {
                bars.ui.alert({ text: "Для коректного відображення значеннь автопролонгації вкажіть валюту у відповідному полі" });
                $("#NumberProlongationList").data("kendoDropDownList").enable(false);
                $("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value(0);
            }

            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 0) {
                $scope.placementTranche.NumberProlongation = null;
                $scope.placementTranche.ApplyBonusProlongation = null;
                $scope.$apply();
                $("#NumberProlongationList").data("kendoDropDownList").dataSource.read([]);
                $("#NumberProlongationList").data("kendoDropDownList").value(0);
                $("#NumberProlongationList").data("kendoDropDownList").enable(false);
                $("#applyprologField").val('');
            }
            if ($("[ng-model='placementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {

                $("#NumberProlongationList").data("kendoDropDownList").enable(true);
                $("#NumberProlongationList").data("kendoDropDownList").dataSource.read();
            }

        }
    };
    //

    //Выпадающий список Да/Нет поле Автопролонгация Редактирование
    $scope.IsProlongationReplaceOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {
            if (($scope.replacementTranche.CurrencyId == null || $scope.replacementTranche.CurrencyId == '') && $scope.replacementTranche.DealNumber != null) {
                bars.ui.alert({ text: "Для коректного відображення значеннь автопролонгації вкажіть валюту у відповідному полі" });
                $("[ng-model='replacementTranche.IsProlongation']").data("kendoDropDownList").value(0);
            }
            if ($("[ng-model='replacementTranche.IsProlongation']").data("kendoDropDownList").value() == 0) {
                $scope.replacementTranche.NumberProlongation = null;
                $scope.replacementTranche.ApplyBonusProlongation = null;
                $scope.$apply();
                $("#NumberProlongationListReplace").data("kendoDropDownList").dataSource.read([]);
                $("#NumberProlongationListReplace").data("kendoDropDownList").refresh();
                $("#NumberProlongationListReplace").data("kendoDropDownList").value('');
                $("#NumberProlongationListReplace").data("kendoDropDownList").enable(false);
                $("[ng-model='replacementTranche.NumberProlongation']").data("kendoDropDownList").value('');
                $("#applyprologFieldReplace").val('');
                //выполняем перерасчёт ставки
                $http.post(bars.config.urlContent("/api/gda/gda/countplacementTranche"), $scope.replacementTranche).success(function (request) {
                    $scope.replacementTranche.interestRate = request.InterestRate;
                    $('[ng-model="replacementTranche.interestRate"]').data('kendoNumericTextBox').value($scope.replacementTranche.interestRate);
                });
                //
            }
            if ($("[ng-model='replacementTranche.IsProlongation']").data("kendoDropDownList").value() == 1) {
                $("#NumberProlongationListReplace").data("kendoDropDownList").dataSource.read();
                $("#NumberProlongationListReplace").data("kendoDropDownList").refresh();
                $("#NumberProlongationListReplace").data("kendoDropDownList").enable(true);
                //выполняем перерасчёт ставки
                $http.post(bars.config.urlContent("/api/gda/gda/countplacementTranche"), $scope.replacementTranche).success(function (request) {
                    $scope.replacementTranche.interestRate = request.InterestRate;
                    $('[ng-model="replacementTranche.interestRate"]').data('kendoNumericTextBox').value($scope.replacementTranche.interestRate);
                });
                //
            }
        }
    };
    //

    //Выпадающий список Да/Нет поле Документ подписан или нет
    $scope.IsSignedOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () { }
    };
    //

    //Выпадающий список Да/Нет поле Капитализации
    $scope.IsCapitalizationOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {

            if ($("[ng-model='placementTranche.IsCapitalization']").data("kendoDropDownList").value() == 0) {

                //$scope.placementTranche.CapitalizationTerm = null;
                //$("[ng-model='placementTranche.CapitalizationTerm']").data("kendoDropDownList").value(0);

                //$("#placementCapitalizationList").data("kendoDropDownList").enable(false);

            }
            if ($("[ng-model='placementTranche.IsCapitalization']").data("kendoDropDownList").value() == 1) {

                //$("#placementCapitalizationList").data("kendoDropDownList").enable(true);
            }
            if ($("[ng-model='replacementTranche.IsCapitalization']").data("kendoDropDownList").value() == 0) {

                //$scope.replacementTranche.CapitalizationTerm = null;
                //$("[ng-model='replacementTranche.CapitalizationTerm']").data("kendoDropDownList").value(0);

                //$("#replacementCapitalizationList").data("kendoDropDownList").enable(false);
            }
            if ($("[ng-model='replacementTranche.IsCapitalization']").data("kendoDropDownList").value() == 1) {

                //$("#replacementCapitalizationList").data("kendoDropDownList").enable(true);
            }
        }
    };
    //

    //Выпадающий список Да/Нет поле Поповнення Размещение транша
    $scope.isReplenishmentTrancheOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {

            if ($("[ng-model='placementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == 1 || $scope.placementTranche.IsReplenishmentTranche == 1) {
                if ($scope.placementTranche.NumberTrancheDays == 0 || $scope.placementTranche.NumberTrancheDays == null || $scope.placementTranche.NumberTrancheDays == "") {
                    $("[ng-model='placementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == 0;
                    bars.ui.alert({ text: "Введіть строк траншу або оберіть відповідну дату у полі 'Дата повернення'" });

                } else {
                    var obj = {

                        StartDate: $scope.placementTranche.StartDate,
                        ExpiryDate: $scope.placementTranche.ExpiryDate

                    };
                    $http.get(bars.config.urlContent("/api/gda/gda/countLastReplenishmentDate?StartDate=" + obj.StartDate + "&ExpiryDate=" + obj.ExpiryDate)).then(function (request) {
                        var date = request.data[0];
                        $scope.dateReturn = kendo.toString(kendo.parseDate(date), 'dd.MM.yyyy');
                        //var dateReturn = kendo.toString(kendo.parseDate(date), 'dd.MM.yyyy');
                        if (request.data != 0) {

                            $scope.placementTranche.LastReplenishmentDate = $scope.dateReturn;
                            $("#dateReplenishmentToPlacement").data("kendoDatePicker").value($scope.dateReturn);


                        } else {
                            $scope.placementTranche.LastReplenishmentDate = $scope.placementTranche.StartDate;
                            $scope.dateReturn = $scope.placementTranche.LastReplenishmentDate;
                            if ($scope.dateReturn == $scope.placementTranche.StartDate) {
                                bars.ui.alert({ text: "Поповнення не передбачено" });
                                $scope.placementTranche.IsReplenishmentTranche = 0;
                                $("[ng-model='placementTranche.IsReplenishmentTranche']").data("kendoDropDownList").refresh();
                            }
                            //$("#dateReplenishmentToPlacement").data("kendoDatePicker").value($scope.today);
                        }
                    });
                }
            } else {
                $scope.isReplenishmentTranche = 0;
                $scope.placementTranche.LastReplenishmentDate = null;
                $("#dateReplenishmentToPlacement").data("kendoDatePicker").value('');
                //$("#dateReplenishmentToReplacement").data("kendoDatePicker").value('');
            }


        }
    }
    //

    //Выпадающий список Да/Нет поле Пополнение Редактирование транша
    $scope.isReplenishmentTrancheReplaceOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {
            //if ($("[ng-model='replacementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == 1) {
            if ($("#isReplenishmentTranReplace").data("kendoDropDownList").value() == 1) {
                //
                if ($scope.replacementTranche.interestRate != null) {
                    //bars.ui.alert({ text: "Ви змінили параметри, які вливають на Розрахункову ставку<br>Натисніть<button  class='btn btn-default'><i class='pf-icon pf-16 pf-percentage'></i>Розрахувати</button> для розрахуку нової ставки!" });

                    $scope.onClick('replacementTranche', 'count');
                    //$('#countPercentBtn').click();
                }
                //
                if ($scope.replacementTranche.NumberTrancheDays == 0 || $scope.replacementTranche.NumberTrancheDays == null || $scope.replacementTranche.NumberTrancheDays == "") {
                    $("[ng-model='replacementTranche.IsReplenishmentTranche']").data("kendoDropDownList").value() == 0;
                    bars.ui.alert({ text: "Введіть строк траншу або оберіть відповідну дату у полі 'Дата повернення'" });
                } else {
                    var obj = {
                        StartDate: kendo.toString(kendo.parseDate($scope.replacementTranche.StartDate), 'dd.MM.yyyy'),
                        ExpiryDate: kendo.toString(kendo.parseDate($("#dateReturning").data('kendoDatePicker').value()), 'dd.MM.yyyy')
                        //ExpiryDate: kendo.toString(kendo.parseDate($scope.replacementTranche.ExpiryDate), 'dd.MM.yyyy')

                    };
                    $http.get(bars.config.urlContent("/api/gda/gda/countLastReplenishmentDate?StartDate=" + obj.StartDate + "&ExpiryDate=" + obj.ExpiryDate)).then(function (request) {
                        var date = request.data[0];
                        $scope.dateReturn = kendo.toString(kendo.parseDate(date), 'dd.MM.yyyy');
                        if (request.data != 0) {
                            $scope.replacementTranche.LastReplenishmentDate = $scope.dateReturn;
                            $("#dateReplenishmentToReplacement").data("kendoDatePicker").value($scope.dateReturn);
                        } else {
                            $scope.replacementTranche.LastReplenishmentDate = $scope.replacementTranche.StartDate;
                            $scope.dateReturn = $scope.replacementTranche.LastReplenishmentDate;
                            if ($scope.dateReturn == $scope.replacementTranche.StartDate) {

                                bars.ui.alert({ text: "Поповнення не передбачено. Оберіть інший строк дії та виберіть Поповнення 'Так' " });

                                $scope.replacementTranche.isReplenishmentTranche = 0;
                                $("#dateReplenishmentToReplacement").data("kendoDatePicker").value('');
                                $scope.replacementTranche.LastReplenishmentDate = null;
                            }
                            //$("#dateReplenishmentToPlacement").data("kendoDatePicker").value($scope.today);
                        }
                    });
                }
            } else {
                if ($scope.replacementTranche.interestRate != null) {
                    $scope.onClick('replacementTranche', 'count');
                }
                $scope.replacementTranche.LastReplenishmentDate = null;
                $("#dateReplenishmentToReplacement").data("kendoDatePicker").value('');
            }
        }
    }
    //

    //Выпадающий список Да/Нет поле Індивідуальна ставка
    $scope.IsIndividualRateTrancheOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {
            if ($("[ng-model='placementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 0) {

                $scope.placementTranche.IndividualInterestRate = null;
                $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(0);
                $scope.placementTranche.Comment = null;
            } else if ($("[ng-model='placementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 1) {
                //bars.ui.alert({ text: "Ви обрали індивідуальну ставку. Натисніть 'Розрахувати ставку' для коректного розрахунку та збереження параметрів" });
                return;
            }
        }
    };
    //

    //Выпадающий список Да/Нет поле Індивідуальна ставка Редактирование
    $scope.IsIndividualRateReplaceTrancheOptions = {
        dataSource: [
            { text: "Так", value: 1 },
            { text: "Ні", value: 0 }
        ],
        value: 0,
        dataTextField: "text",
        dataValueField: "value",
        change: function () {
            if ($("[ng-model='replacementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 0) {
                $scope.onClick('replacementTranche', 'count');
                $("[ng-model='placementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(0);
                $scope.replacementTranche.Comment = null;
                $scope.replacementTranche.IndividualInterestRate = null;
                $("[ng-model='replacementTranche.IndividualInterestRate']").data("kendoNumericTextBox").value(0);
            } else if ($("[ng-model='replacementTranche.IsIndividualRate']").data("kendoDropDownList").value() == 1) {
                $scope.onClick('replacementTranche', 'count');
            }
        }
    };

    //Поля Залишок на рахунку 
    $scope.DebitAccOstcOptions = {
        dataSource: $scope.DebitAccDataSource,
        dataTextField: "Ostc"
    };
    //в пополнении
    $scope.DebitAccOstcReplenishmentOptions = {
        dataSource: $scope.DebitAccReplenishmentDataSource,
        dataTextField: "Ostc"
    };
    // в редактировании пополнения
    $scope.DebitAccOstcEditReplenishmentOptions = {
        dataSource: $scope.DebitAccEditReplenishmentDataSource,
        dataTextField: "Ostc"
    };
    //в редактировании транша
    $scope.DebitAccOstcReplacementOptions = {
        dataSource: $scope.DebitAccReplacementDataSource,
        dataTextField: "Ostc"
    };
    //


    //Грид Портфель ДБО
    var DBODataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 50,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/searchdbo"),
            }
        },
        schema: {
            model: {
                fields: {
                    contract_number: { type: 'string' },
                    contract_date: { type: 'string' },
                    contract_signature_flag: { type: 'string' },
                    rnk: { type: 'string' },
                    nmk: { type: 'string' },
                    okpo: { type: 'string' },
                    branch: { type: 'string' }
                }
            }
        },
        serverFiltering: true, ////!!!!!
        serverPaging: true
    });
    $scope.DBOGridOptions = $scope.createGridOptions({
        dataSource: DBODataSource,
        height: 600,
        //toolbar: [{ name: 'excel', text: 'Завантажити в Excel' }],
        excel: {
            fileName: "Портфель ДБО.xlsx",
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        change: function (data) {
            $('#closeDepositBtn').prop("disabled", true);

            $scope.CustomerId = null;


        },
        columns: [
            {
                field: "contract_number",
                title: "Номер ДБО",
                width: "35px",
                template: "<div style='text-align:center;'>#=contract_number#</div>"
            },
            {
                field: "contract_date",
                title: "Дата ДБО",
                width: "15px",
                template: "<div style='text-align:center;'>#=contract_date#</div>"
            },
            {
                field: "contract_signature_flag",
                title: "Ознака підписання",
                width: "15px",
                template: '<div style= text-align:center;">#=(contract_signature_flag == "0") ? "Ні" : "Так" #</div>'

            },
            {
                field: "rnk",
                title: "РНК",
                width: "15px",
                template: "<div style='text-align:center;'>#=rnk#</div>"
            },
            {
                field: "nmk",
                title: "Назва клієнта",
                width: "75px",
                template: "<div style='text-align:center;'>#=nmk#</div>"
            },
            {
                field: "okpo",
                type: 'string',
                title: "ЄДРПОУ Клієнта",
                width: "35px",
                template: "<div style='text-align:center;'>#=okpo#</div>"
            }
        ]
    });
    //

    //двойной клик по строке в гриде ДБО 
    $("#DBOGrid").on("dblclick", "tr.k-state-selected", function () {
        $("#DepositPortfolio").click();
    });
    //

    //открытие формы редактирования при двойном клике на строку с траншем в гриде строковых траеншей
    $("#timetranchesgrid").on("dblclick", "tr.k-state-selected", function (event) {
        var target = (event.currentTarget) ? event.currentTarget : event.srcElement;
        if ($(target).hasClass('classClose') || $(target).hasClass('classCanceled')) {
            bars.ui.alert({ text: "Редагування неможливе!" });
        } else {
            $("#replacementTrancheBtn").click();

        }
    });
    //

    //открытие формы редактирования при двойном клике на строку с вкладом на требование в гриде строковых траеншей
    $("#requireDepositGrid").on("dblclick", "tr.k-state-selected", function (event) {
        var target = (event.currentTarget) ? event.currentTarget : event.srcElement;
        if ($(target).hasClass('classCanceled')) {
            bars.ui.alert({ text: "Редагування неможливе!" });
        } else {
            $("#editDepositBtn").click();
        }
    });
    //

    //Грид Строковые транши
    var TimeTranshesDataSource = $scope.createDataSource({
        pageSize: 50,
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/searchtimetranshes"),
                data: function () {
                    if ($scope.CustomerId == null && $scope.curAccInfo('rnk') == null) {
                        return { rnk: null };
                    } else if ($scope.curAccInfo('rnk') != null && $scope.CustomerId == null) {
                        return { rnk: $scope.curAccInfo('rnk') };
                    } else if ($scope.curAccInfo('rnk') == null && $scope.CustomerId != null) {
                        return { rnk: $scope.CustomerId };
                    }
                },
            },
        },
        filter: { field: "state_name", operator: "neq", value: "Закрита" },
        sort: { field: "start_date", dir: "desc" },
        schema: {
            model: {
                process_id: "process_id",
                fields: {
                    tranche_id: { type: 'number' },
                    start_date: { type: 'date' },
                    plan_value: { type: 'number' },
                    currency: { type: 'string' },
                    is_prolongation: { type: 'number' },
                    state_name: { type: 'string' },
                    is_replenishment_tranche: { type: 'number' },
                    process_id: { type: 'number' },
                    deal_number: { type: 'string' },
                    frequency_payment_name: { type: 'string' },
                    comment_text: { type: 'string' },
                    tranche_state_name: { type: 'string' },
                    branch: { type: 'string' }
                    //frequency_payment: { type: 'string' }
                }
            }
        }
    });
    $scope.TimeTranshesGridOptions = $scope.createGridOptions({
        dataSource: TimeTranshesDataSource,
        dataBound: function (e) {
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("state_name") == "Створено" || dataItem.get("state_name") == "Редагування") {
                    row.addClass("classCreated");
                } else if (dataItem.get("state_name") == "Активна") {
                    row.addClass("classAuthorized");
                } else if (dataItem.get("state_name") == "На авторизації") {
                    row.addClass("classOnAuthorizing");
                } else if (dataItem.get("state_name") == "Заблоковано") {
                    row.addClass("classClose");
                } else if (dataItem.get("state_name") == "Видалено") {
                    row.addClass("classCanceled");
                }
            }

            //Get the datasource here
            var data = this._data;
            //Loop through each item
            for (var x = 0; x < data.length; x++) {
                //Get the currently active item
                var dataItem = data[x];
                //Access table row basedon uid
                var tr = $("#timetranchesgrid").find("[data-uid='" + dataItem.uid + "']");
                //Access cell object
                var cell = $("td:nth-child(7)", tr);

                if (cell[0].innerText == "на редагуванні" || cell[0].innerText == "відхилено БО / на редагуванні") {
                    cell.addClass("classEditCell");
                } else if (cell[0].innerText == "авторизовано з помилкою") {
                    cell.addClass("classAuthCellError");
                } else if (cell[0].innerText == "на авторизації") {
                    cell.addClass("classAuthSuccess");
                }

            }
        },
        height: 600,
        selectable: "row",
        //toolbar: [{ name: 'excel', text: 'Завантажити в Excel', className: 'btn btn-default' }],
        excel: {
            fileName: "Строкові транші.xlsx",
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        change: function (data) {
            var selectedItem = this.dataItem(this.select());
            if (selectedItem == null) {
                return;
            } else {
                $scope.processId = selectedItem.process_id;
                if (selectedItem.get("state_name") == "Активна") {
                    $('#replacementTrancheBtn').prop("disabled", false);
                    $('#replenishmentTrancheBtn').prop("disabled", false);
                    $('#earlyRepaymentTrancheBtn').prop("disabled", false);
                    $('#printBtn').prop("disabled", false);
                    if (selectedItem.get('is_replenishment_tranche') == 0) {
                        $('#replenishmentTrancheBtn').prop('disabled', true);
                    } else {
                        $('#replenishmentTrancheBtn').prop('disabled', false);
                    }
                } else if (selectedItem.get("state_name") == "Видалено") {
                    $('#replacementTrancheBtn').prop("disabled", true);
                    $('#replenishmentTrancheBtn').prop("disabled", true);
                    $('#earlyRepaymentTrancheBtn').prop("disabled", true);
                } else if (selectedItem.get("state_name") == "Заблоковано" || selectedItem.get("state_name") == "Видалено") {
                    $('#replacementTrancheBtn').prop("disabled", true);
                } else {
                    $('#replacementTrancheBtn').prop("disabled", false);
                    $('#replenishmentTrancheBtn').prop("disabled", true);
                    $('#earlyRepaymentTrancheBtn').prop("disabled", true);
                    $('#printBtn').prop("disabled", false);
                }
            }
        },
        columns: [
            {
                field: "deal_number",
                title: " Номер траншу",
                width: "30px",
                template: "<div style='text-align:center;'>#=deal_number#</div>"
            },
            {
                field: "start_date",
                title: "Дата відкриття",
                width: "20px",
                template: "<div style='text-align:center;'>#= kendo.toString(kendo.parseDate(start_date, 'dd.MM.yyyy'), 'dd.MM.yyyy') #</div>"
            },
            {
                field: "plan_value",
                title: "Сума траншу",
                width: "15px",
                headerAttributes: { style: "text-align:center" },
                format: "{0:n2}"
            },
            {
                field: "currency",
                title: "Валюта",
                width: "15px",
                template: "<div style='text-align:center;'>#=currency#</div>"

            },
            {
                field: "is_prolongation",
                title: "Автопролонгація",
                width: "10px",
                template: '<div style="text-align:center;">#=(is_prolongation == "0") ? "Ні" : "Так" #</div>'

            },
            {
                field: "state_name",
                title: "Статус траншу",
                width: "20px",
                template: "<div style='text-align:center;'>#=state_name#</div>"
            },
            {
                field: "tranche_state_name",
                title: "Статус поточний",
                width: "20px"
            },
            {
                field: "is_replenishment_tranche",
                title: "Поповнення",
                width: "10px",
                template: '<div style="text-align:center;">#=(is_replenishment_tranche == "0") ? "Ні" : "Так" #</div>'
            },
            {
                field: "comment_text",
                title: "Коментар",
                width: "25px"
            }
        ]

    });
    //

    //кастомная функция для експорта в ексель
    $scope.ExportToExcel = function (gridId) {
        var grid = $('#' + gridId).data("kendoGrid");
        grid.saveAsExcel();
    }
    //

    //Грид История пополнения траншей
    var ReplenishmentHistoryDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 10,
        autoBind: false,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getreplenishmenthistory"),
                data: function () {
                    return { trancheId: $scope.curTrancheInfo('tranche_id') };
                }
            }
        },
        schema: {
            model: {
                process_id: "process_id",
                fields: {
                    deal_number: { type: 'string' },
                    start_date: { type: 'date' },
                    amount: { type: 'number' },
                    value_date: { type: 'date' },
                    replenish_state_name: { type: 'string' },
                    type_: { type: 'string' },
                    process_id: { type: 'number' },
                    comment_: { type: 'string' }
                }
            }
        },
        serverFiltering: false,
        serverPaging: false
    });
    $scope.ReplenishmentHistoryGridOptions = $scope.createGridOptions({
        dataSource: ReplenishmentHistoryDataSource,
        dataBound: function (e) {
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("replenish_state_name") == "створено") {
                    row.addClass("classCreated");
                } else if (dataItem.get("replenish_state_name") == "на авторизації") {
                    row.addClass("classCreated");
                } else if (dataItem.get("replenish_state_name") == "авторизовано") {
                    row.addClass("classAuthorized");
                }
            }

            //Get the datasource here
            var data = this._data;
            //Loop through each item
            for (var x = 0; x < data.length; x++) {
                //Get the currently active item
                var dataItem = data[x];
                //Access table row basedon uid
                var tr = $("#replenishmentHistoryGrid").find("[data-uid='" + dataItem.uid + "']");
                //Access cell object
                var cell = $("td:nth-child(4)", tr);

                if (cell[0].innerText == "на авторизації") {
                    cell.addClass("classAuthSuccess");
                } else if (cell[0].innerText == "створено") {
                    cell.addClass("classEditCell");
                }
            }

        },
        autoBind: false,
        height: 410,
        columns: [
            {
                field: "deal_number",
                title: "Номер траншу",
                width: "10%",
                template: "<div style='text-align:center;'>#=deal_number#</div>"

            },
            {
                field: "start_date",
                title: "Дата відкриття/поповнення траншу",
                width: "10%",
                template: "<div style='text-align:center;'>#=kendo.toString(kendo.parseDate(start_date), 'dd.MM.yyyy')#</div>"

            },
            {
                field: "amount",
                title: "Сума траншу",
                width: "10%",
                //template: "<div style='text-align:center;'>#=amount#</div>"
                headerAttributes: { style: "text-align:center" },
                format: "{0:n2}"
            },
            {
                field: "replenish_state_name",
                title: "Статус",
                width: "10%",
                template: "<div style='text-align:center;'>#=replenish_state_name#</div>"
            },
            {
                field: "type_",
                title: "Вид поповнення",
                width: "10%",
                template: "<div style='text-align:center;'>#=type_#</div>"
            },
            {
                field: "reason",
                title: "Комментар повернення",
                width: "15%",
                template: '<div style="text-align:center;">#=(reason == null) ? " " : reason #</div>'

            }
        ],
        change: function (data) {
            var selectedItem = this.dataItem(this.select());
            $scope.processId = selectedItem.process_id;

            if (selectedItem.replenish_state_name == 'відхилений') {
                $('#editreplenish').prop("disabled", true);
            } else {
                $('#editreplenish').prop("disabled", false);
            }

            if (selectedItem.type_ == 'основний транш') {
                $('#printBtnHistory').prop("disabled", true);
            } else {
                $('#printBtnHistory').prop("disabled", false);
            }
        },

    });
    //

    //########################Грид Вклади на вимогу##################################
    var RequireDepositDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 50,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/searchrequiredeposits"),
                data: function () {
                    if ($scope.CustomerId == null && $scope.curAccInfo('rnk') == null) {
                        return { rnk: null };
                    } else if ($scope.curAccInfo('rnk') != null && $scope.CustomerId == null) {
                        return { rnk: $scope.curAccInfo('rnk') };
                    } else if ($scope.curAccInfo('rnk') == null && $scope.CustomerId != null) {
                        return { rnk: $scope.CustomerId };
                    }
                },
            }
        },
        sort: { field: "START_DATE", dir: "desc" },
        schema: {
            model: {
                fields: {
                    PROCESS_ID: { type: 'number' },
                    DEPOSIT_ID: { type: 'number' },
                    DEPOSIT_STATE_NAME: { type: 'string' },
                    DEPOSIT_STATE_CODE: { type: 'string' },
                    STATE_NAME: { type: 'string' },
                    DEAL_NUMBER: { type: 'string' },
                    START_DATE: { type: 'date' },
                    Currency: { type: 'string' },
                    //PLAN_VALUE: { type: 'number' },
                    CALCULATION_TYPE_NAME: { type: 'string' }
                }
            }
        }
    });
    $scope.RequireDepositGridOptions = $scope.createGridOptions({
        dataSource: RequireDepositDataSource,
        dataBound: function (e) {
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("STATE_NAME") == "Створено" || dataItem.get("STATE_NAME") == "Редагування") {
                    row.addClass("classCreated");
                } else if (dataItem.get("STATE_NAME") == "Активна") {
                    row.addClass("classAuthorized");
                } else if (dataItem.get("STATE_NAME") == "На авторизації") {
                    row.addClass("classOnAuthorizing");
                } else if (dataItem.get("STATE_NAME") == "Закрита") {
                    row.addClass("classClose");
                } else if (dataItem.get("STATE_NAME") == "Видалено") {
                    row.addClass("classCanceled");
                }
            }
        },
        height: 600,
        selectable: "row",
        //toolbar: [{ name: 'excel', text: 'Завантажити в Excel' }],
        excel: {
            fileName: "Вклади на вимоги.xlsx",
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        columns: [
            {

                field: "DEAL_NUMBER",
                title: "Номер вкладу на вимогу",
                width: "10%",
                template: "<div style='text-align:center;'>#=DEAL_NUMBER#</div>"
            },
            {

                field: "START_DATE",
                title: "Дата відкриття рахунку",
                width: "10%",
                format: "{0:dd.MM.yyyy}",
                template: "<div style='text-align:center;'>#=kendo.toString(kendo.parseDate(START_DATE), 'dd.MM.yyyy')#</div>"
            },
            {
                field: "Currency",
                title: "Валюта",
                width: "10%",
                template: "<div style='text-align:center;'>#=Currency#</div>"
            },
            {

                field: "STATE_NAME",
                title: "Статус депозиту",
                width: "10%",
                template: "<div style='text-align:center;'>#=STATE_NAME#</div>"
            },
            {

                field: "DEPOSIT_STATE_NAME",
                title: "Статус операції",
                width: "10%",
                template: "<div style='text-align:center;'>#=DEPOSIT_STATE_NAME#</div>"
            },
            {

                field: "CALCULATION_TYPE_NAME",
                title: "Тип нарахування",
                width: "10%",
                template: "<div style='text-align:center;'>#=CALCULATION_TYPE_NAME#</div>"

            }
        ],
        change: function (data) {

            var selectedItem = this.dataItem(this.select());
            $scope.processId = selectedItem.PROCESS_ID;
            $scope.depositId = selectedItem.DEPOSIT_ID;

            if (selectedItem.get("DEPOSIT_STATE_NAME") == "відхилений") {
                $('#closeDepositBtn').prop("disabled", true);
                $('#editDepositBtn').prop("disabled", true);
                $('#changeDepositBtn').prop("disabled", true);
                $('#printDepositBtn').prop("disabled", true);
            } else if (selectedItem.get("DEPOSIT_STATE_NAME") == "авторизовано") {
                $('#closeDepositBtn').prop("disabled", false);
                $('#changeDepositBtn').prop("disabled", false);
                $('#printDepositBtn').prop("disabled", false);
                $('#editDepositBtn').prop("disabled", false);
            } else {
                $('#closeDepositBtn').prop("disabled", true);
                $('#editDepositBtn').prop("disabled", false);
                $('#changeDepositBtn').prop("disabled", false);
                $('#printDepositBtn').prop("disabled", false);
            }

        }
    });
    //

    //Грид Депозитні рахунки
    var accountsDataSource = $scope.createDataSource({
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/searchaccounts"),
                data: function () {
                    return { rnk: $scope.curAccInfo('rnk') };
                }
            }
        },
        schema: {
            model: {
                fields: {
                    start_date: { type: 'date' },
                    close_date: { type: 'date' },
                    account_number: { type: 'string' },
                    currency_name: { type: 'string' },
                    account_balance: { type: 'number' },
                    currency_id: { type: 'number' },
                    deposit_code: { type: 'string' },
                    deposit_name: { type: 'string' },
                    account_id: { type: 'number' },
                    customer_id: { type: 'number' }
                }
            }
        }
    });
    $scope.accountsGridOptions = $scope.createGridOptions({
        dataSource: accountsDataSource,
        autoBind: false,
        height: 300,
        excel: {
            fileName: "Депозитні рахунки.xlsx",
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        columns: [
            {
                field: "account_number",
                title: "Номер рахунку",
                width: "10%"
            },
            {
                field: "deposit_name",
                title: "Тип депозиту",
                width: "10%"
            },
            {
                field: "currency_name",
                title: "Валюта рахунку",
                width: "10%"
            },
            {
                field: "account_balance",
                title: "Залишок коштів",
                width: "10%",
                template: '#=kendo.toString(account_balance,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            {
                field: "start_date",
                title: "Дата відкриття",
                width: "10%",
                template: "<div style='text-align:center;'>#=(start_date == null) ? ' ' : kendo.toString(start_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "close_date",
                title: "Дата закриття",
                width: "10%",
                template: "<div style='text-align:center;'>#=(close_date == null) ? ' ' : kendo.toString(close_date,'dd.MM.yyyy')#</div>"
            }
        ]

    });
    //

    //вкладки Cтрокові транші Вклади на вимогу Депозитні рахунки
    $scope.tabStripOptions = {
        animation: false,
        select: function () {
            var tabstrip = this;
            var curTabIndex = tabstrip.select().index();
            if (curTabIndex === 0 && $scope.curAccInfo('contract_number') !== null) {
                $scope.$apply();
                $scope.TimeTranshesGrid.dataSource.read();
                $scope.RequireDepositGrid.dataSource.read();
                $scope.accountsGrid.dataSource.read();

            }
        }
    };
    //

    //Функция для фильтрации траншей по статуту в гриде Строковых траншей Checkbox Показати закриті транші
    $scope.onShowClosedTranches = function () {
        var status = { field: "state_name", operator: "neq", value: "Закрита" };
        var status_ = { field: "state_name", operator: "neq", value: "Видалено" };
        var _filter = {
            filters: [],
            logic: 'and'
        };
        if ($("#showCloseTranches").prop('checked') == false) {
            _filter.filters = [];
            _filter.filters.push(status);
            $scope.TimeTranshesGrid.dataSource.filter(_filter);
        } else {
            _filter.filters = [];
            _filter.filters.push(status_);
            $scope.TimeTranshesGrid.dataSource.filter(_filter);
        }
    };
    //

    //кнопка "Очистити пошук"
    $scope.ResetFind = function () {
        var _filter = [];
        $scope.DBOGrid.dataSource.filter(_filter);

        $scope.contract_number = null;
        $scope.rnk = null;
        $scope.okpo = null;
    };
    //


    //Функция поиска атрибутов РНК ЕДРПОУ НОМЕР ДБО Фронт-офис
    $scope.Find = function () {
        //фильтр когда поля поиска пустые и клик на кнопку "Поиск"
        var _filter = {
            filters: [],
            logic: 'and'
        };
        if (($scope.contract_number == null || $scope.contract_number == '') && ($scope.rnk == null || $scope.rnk == '') && ($scope.okpo == null || $scope.okpo == null)) {
            bars.ui.alert({ text: "Введіть дані у поля для пошуку! <br> Для довідки натисніть '?' зліва від поля 'Номер ДБО' " });
        } else {
            //фильтры 
            var contractNumber = { field: "contract_number", operator: "startswith", value: $scope.contract_number };
            var rnk = { field: "rnk", operator: "startswith", value: $scope.rnk };
            var okpo = { field: "okpo", operator: "startswith", value: $scope.okpo };

            //проверяем в какие поля были введены данные
            if ($scope.contract_number !== undefined && ($scope.rnk == undefined || $scope.rnk.length == 0) && ($scope.okpo == undefined || $scope.okpo.length == 0)) {
                _filter.filters = [];
                _filter.filters.push(contractNumber);
                $scope.DBOGrid.dataSource.filter(_filter);
            } else if (($scope.contract_number == undefined || $scope.contract_number.length == 0) && $scope.rnk !== undefined && ($scope.okpo == undefined || $scope.okpo.length == 0)) {
                _filter.filters = [];
                _filter.filters.push(rnk);
                $scope.DBOGrid.dataSource.filter(_filter);
            } else if (($scope.contract_number == undefined || $scope.contract_number.length == 0) && ($scope.rnk == undefined || $scope.rnk.length == 0) && $scope.okpo !== undefined) {

                _filter.filters = [];

                _filter.filters.push(okpo);
                $scope.DBOGrid.dataSource.filter(_filter);
            } else if ($scope.contract_number !== undefined && $scope.rnk !== undefined && $scope.okpo !== undefined) {
                _filter.filters = [];
                _filter.filters.push(contractNumber);
                _filter.filters.push(rnk);
                _filter.filters.push(okpo);
                $scope.DBOGrid.dataSource.filter(_filter);
            } else {
                _filter.filters = [];
            }
        }
    }
    //

    //Фукнция поиска атрибутов РНК ЕДРПОУ НОМЕР ДБО Бэк-офис
    $scope.FindBack = function () {
        //фильтр когда поля поиска пустые и клик на кнопку "Поиск"
        var _filter = {
            filters: [],
            logic: 'and'
        };


        //фильтры 
        var contractNumber = { field: "contract_number", operator: "startswith", value: $scope.contract_number };
        var rnk = { field: "rnk", operator: "startswith", value: $scope.rnk };
        var okpo = { field: "okpo", operator: "startswith", value: $scope.okpo };

        //проверяем в какие поля были введены данные
        if ($scope.contract_number !== undefined && ($scope.rnk == undefined || $scope.rnk.length == 0) && ($scope.okpo == undefined || $scope.okpo.length == 0)) {
            _filter.filters = [];
            _filter.filters.push(contractNumber);
            $scope.DepositBackGrid.dataSource.filter(_filter);
        } else if (($scope.contract_number == undefined || $scope.contract_number.length == 0) && $scope.rnk !== undefined && ($scope.okpo == undefined || $scope.okpo.length == 0)) {
            _filter.filters = [];
            _filter.filters.push(rnk);
            $scope.DepositBackGrid.dataSource.filter(_filter);
        } else if (($scope.contract_number == undefined || $scope.contract_number.length == 0) && ($scope.rnk == undefined || $scope.rnk.length == 0) && $scope.okpo !== undefined) {
            _filter.filters = [];
            _filter.filters.push(okpo);
            $scope.DepositBackGrid.dataSource.filter(_filter);
        } else if ($scope.contract_number !== undefined && $scope.rnk !== undefined && $scope.okpo !== undefined) {
            _filter.filters = [];
            _filter.filters.push(contractNumber);
            _filter.filters.push(rnk);
            _filter.filters.push(okpo);
            $scope.DepositBackGrid.dataSource.filter(_filter);
        } else {
            _filter.filters = [];
        }

    }
    //

    //Директива для inputs (ДБО РНК ОКПО) чтоб вводились только цифры, а пробелы удалялись
    mainApp.directive('numbersOnly', function () {
        return {
            require: 'ngModel',
            link: function (scope, element, attr, ngModelCtrl) {
                function fromUser(text) {
                    if (text) {
                        var transformedInput = text.replace(/[^0-9]/g, '');

                        if (transformedInput !== text) {
                            ngModelCtrl.$setViewValue(transformedInput);
                            ngModelCtrl.$render();
                        }
                        return transformedInput;
                    }
                    return undefined;
                }
                ngModelCtrl.$parsers.push(fromUser);
            }
        };
    });
    //

    //Вывод сообщения если не выбран договор в вкладке "Портфель ДБО"
    $scope.CheckMessage = function () {
        if ($scope.curAccInfo('rnk') === null && $scope.CustomerId == null) {
            return true;
        } else {
            return false;
        }
    }
    //

    //Грид Портфель ДБО операциониста
    var OperationistDBODataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 50,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/searchoperationistdbo"),
            }
        },
        schema: {
            model: {
                fields: {
                    Start_date: { type: 'date' },
                    Customer_id: { type: 'string' },
                    Customer_name: { type: 'string' },
                    Okpo: { type: 'string' },
                    Amount_deposit: { type: 'number' },
                    Currency_id: { type: 'number' },
                    Transaction_type: { type: 'string' },
                    State_name: { type: 'string' },
                    Object_state_name: { type: 'string' },
                    Deal_number: { type: 'string' },
                    Fio: { type: 'string' },
                    Sys_time: { type: 'date' },
                    Expiry_date: { type: 'date' },
                    Process_id: { type: 'string' }
                }
            }
        },
        serverFiltering: true,
        serverPaging: true,
        serverSorting: false
    });
    $scope.OperationistDBOGridOptions = $scope.createGridOptions({
        dataSource: OperationistDBODataSource,
        height: 610,
        sortable: true,
        selectable: "row",
        toolbar: [{ name: 'excel', text: '' }],
        excel: {
            fileName: "Портфель ДБО операціоніста.xlsx",
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
        change: function (e) {
            var dboGrid = $("#DBOGrid").data("kendoGrid");
            dboGrid.dataSource.filter([]);
            dboGrid.clearSelection();
            dboGrid.refresh();

            $scope.rnk = null;
            $scope.contract_number = null;
            $scope.okpo = null;

            $scope.curAccInfo('rnk') == null;

            var selectedItem = this.dataItem(this.select());

            if (selectedItem != null) {
                $scope.CustomerId = selectedItem.Customer_id;
            } else {
                return;
            }


            $http.get(bars.config.urlContent("/api/gda/gda/getdatedbooperationist?contract_number=" + $scope.currOperDBO('Contract_number'))).then(function (request) {
                $scope.contract_date = request.data[0].contract_date;
            });

            $("#DepositPortfolio").click();

        },
        dataBound: function (e) {
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);


                if (dataItem.get("State_name") == "створено") {
                    row.addClass("classCreated");
                } else if (dataItem.get("State_name") == "авторизовано") {
                    row.addClass("classAuthorized");
                } else if (dataItem.get("State_name") == "на авторизації") {
                    row.addClass('classAuthSuccess');
                }
            }
        },
        columns: [
            {
                field: "Customer_id",
                title: "РНК",
                width: '80px',
            },
            {
                field: "Customer_name",
                title: "Назва клієнта",
                width: '200px'
            },
            {
                field: "Okpo",
                title: "ЄДРПОУ",
                width: '90px'
            },
            {
                field: "Transaction_type",
                title: "Тип операції",
                width: '200px'
            },
            {
                field: "Sys_time",
                title: "Дата операції",
                format: "{0:dd.MM.yyyy}",
                width: '90px'
            },
            {
                field: "State_name",
                title: "Статус операції",
                width: '90px'
            },
            {
                field: "Lcv",
                title: "Валюта",
                width: '90px'
            },
            {
                field: "Account_Number",
                title: "Номер рахунку",
                width: '200px'
            },
            {
                field: "Amount_deposit",
                title: "Сума траншу",
                width: '90px'
            },
            {
                field: "Interest_Rate",
                title: "Процентна ставка",
                width: '90px'
            },
            {
                field: "Total_Amount_Deposit",
                title: "Загальна сума на депозитному рахунку",
                width: '90px'
            },
            {
                field: "Frequency_Payment_Name",
                title: "Виплата відсотків",
                width: '200px'
            },
            {
                field: "Expiry_date",
                title: "Дата повернення траншу",
                format: "{0:dd.MM.yyyy}",
                width: '90px'
            },
            {
                field: "Branch_Id",
                title: "Код відділення",
                width: '200px'
            },
            {
                field: "Fio",
                title: "Виконавець",
                width: '90px'
            },
            {
                field: "Start_date",
                title: "Дата створення",
                format: "{0:dd.MM.yyyy}",
                width: '90px'
            },
            {
                field: "Object_state_name",
                title: "Статус депозиту",
                width: '90px'
            },
            {
                field: "Deal_number",
                title: "Номер траншу",
                width: '200px'
            }
        ]
    });
    //


    //Деактивируем кнопки действий над траншами и вкладами на требование после переключение между вкладками
    $('#depositDemand').click(function () {
        $('#replacementTrancheBtn').prop("disabled", true);
        $('#replenishmentTrancheBtn').prop("disabled", true);
        $('#earlyRepaymentTrancheBtn').prop("disabled", true);
        $('#printBtn').prop("disabled", true);

        $scope.RequireDepositGrid.dataSource.read();
        $scope.RequireDepositGrid.refresh();
    });
    $('#timeTranches').click(function () {
        $('#closeDepositBtn').prop("disabled", true);
        $('#editDepositBtn').prop("disabled", true);
        $('#changeDepositBtn').prop("disabled", true);
        $('#printDepositBtn').prop("disabled", true);
    });
    $('#depositAcc').click(function () {
        $('#replacementTrancheBtn').prop("disabled", true);
        $('#replenishmentTrancheBtn').prop("disabled", true);
        $('#earlyRepaymentTrancheBtn').prop("disabled", true);
        $('#printBtn').prop("disabled", true);
        $('#closeDepositBtn').prop("disabled", true);
        $('#editDepositBtn').prop("disabled", true);
        $('#changeDepositBtn').prop("disabled", true);
        $('#printDepositBtn').prop("disabled", true);
    });
    //


    //Автоматически пересчитываем ставку при редактировании транша
    $scope.recountRate = function () {
        $scope.onClick('replacementTranche', 'count');
    }

    //Проверки когда кликаем на вкладку Депозиты ММСБ
    $('#DepositPortfolio').click(function (e) {
        var rnk = $scope.curAccInfo('rnk'),
            customer_id = $scope.currOperDBO('Customer_id');


        $scope.tabStripDBO = $("#DBOPorfolio");
        $scope.tabStripOperationist = $("#OperationistDBOPorfolio");
        //проверяем с какой вкладки мы переключились (имеет ли элемент нужный класс)
        $scope.isClickFromDBO = $scope.tabStripDBO.attr("class").split(' ');
        $scope.isClickFromOperationist = $scope.tabStripOperationist.attr("class").split(' ');


        if (rnk != null && customer_id == null) {
            $(".well").addClass('disableSearch');
            $("#messageDBO").css("display", 'block');
            $("#messageOperator").css("display", 'none');
            $("#labelPlaceDBO").css("display", 'block');
            $("#labelPlaceOper").css("display", 'none');
            $("#labelReplaceDBO").css("display", 'block');
            $("#labelReplaceOper").css("display", 'none');

            $("#timetranchesgrid").data('kendoGrid').dataSource.read();
            $("#timetranchesgrid").data('kendoGrid').refresh();
        } else if (rnk == null && customer_id != null) {
            $(".well").addClass('disableSearch');
            $("#messageDBO").css("display", 'none');
            $("#messageOperator").css("display", 'block');
            $("#labelPlaceDBO").css("display", 'none');
            $("#labelPlaceOper").css("display", 'block');
            $("#labelReplaceDBO").css("display", 'none');
            $("#labelReplaceOper").css("display", 'block');

            $("#timetranchesgrid").data('kendoGrid').dataSource.read();
            $("#timetranchesgrid").data('kendoGrid').refresh();
        } else if ($scope.isClickFromDBO == 'k-state-active') {
            return;
        } else if ($scope.isClickFromOperationist[4] == 'k-state-active') {
            bars.ui.alert({ text: "Оберіть потрібного клієнта!" });
            e.stopImmediatePropagation();
        }

    });
    //

    //Проверки когда кликаем на вкладку Деппозиты операциониста
    $("#OperationistDBOPorfolio").click(function () {
        $("#OperationistDBOGrid").data("kendoGrid").clearSelection();
        $("#OperationistDBOGrid").data("kendoGrid").dataSource.filter([]);
        $("#OperationistDBOGrid").data("kendoGrid").dataSource.read();
        $("#OperationistDBOGrid").data("kendoGrid").refresh();
    });
    //

    //Проверки когда кликаем на вкладку Портфель депозитов
    $("#DBOPorfolio").click(function () {
        $(".well").removeClass('disableSearch');
        if ($scope.CustomerId != null) {
            var OperGrid = $("#OperationistDBOGrid").data("kendoGrid");
            OperGrid.clearSelection();
            OperGrid.dataSource.filter([]);
            OperGrid.refresh();
        } else {
            return;
        }
    });


    //Функция для вывода окна при удалении транша/вклада на требование
    function eacForm(properties) {
        properties.maxLength = checkLenParams(properties.maxLength, 500);
        properties.minLength = checkLenParams(properties.minLength, 0);
        properties.customTemplate = properties.customTemplate || "";
        properties.additionalData = properties.additionalData || {};

        var kendoWindow = $("<div />").kendoWindow({
            actions: ["Close"],
            title: properties.title || "Введіть коментар та підтвердіть свої дії",
            resizable: false,
            modal: true,
            draggable: true,
            width: "500px",
            height: "auto",
            deactivate: function () {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function () {
                $("#reason").focus();
            }
        });

        var totalTemplate = properties.customTemplate + textAreaTemplate(properties.maxLength, properties.minLength) + templateButtons();

        var template = kendo.template(totalTemplate);

        kendoWindow.data("kendoWindow").content(template({})).center().open();

        kendoWindow.find("#btnCancel").click(function () {
            kendoWindow.data("kendoWindow").close();
        }).end();

        kendoWindow.find("#btnCancel").keydown(function (e) {
            if (e.which == 9) {
                e.preventDefault();
                kendoWindow.find('#reason').focus();
            }
        });

        kendoWindow.find("#btnSave").click(function () {
            var reason = $("#reason").val().trim();
            if (reason === undefined || reason == null) {
                reason = "";
            }

            if (reason.length < properties.minLength) {
                bars.ui.alert({ text: "Коментар повинен містити мінімум " + properties.minLength + " символів" });
                return;
            } else if (reason.length > properties.maxLength) {
                bars.ui.alert({ text: "Коментар повинен містити максимум " + properties.maxLength + " символів" });
                return;
            }

            if (properties.okFunc)
                properties.okFunc({
                    reason: reason,
                    userData: properties.additionalData
                });
            kendoWindow.data("kendoWindow").close();
        }).end();

        kendoWindow.find("#btnSave").keypress(function (e) {
            if (e.which == 13)
                this.click();
        });

        function textAreaTemplate(maxLength, minLength) {
            var minMsg = minLength > 0 ? 'від ' + minLength + ', ' : '';
            return '<div class="row" style="margin:5px 5px 5px 5px;">'
                + '<label for="reason">Коментар щодо видалення(' + minMsg + 'до ' + maxLength + ' символів):</label>'
                + '<textarea id="reason" maxlength="' + maxLength + '" class="k-textbox" tabindex="1"/>'
                + '</div>';
        };

        function templateButtons() {
            return '<div class="row" style="margin:5px 5px 5px 5px;">'
                + '<div class="k-edit-buttons k-state-default">'
                + '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Скасувати</a>'
                + '<a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Підтвердити</a>'
                + '</div>'
                + '</div>';
        };

        function checkLenParams(value, defaultVal) {
            if (!value) return defaultVal;
            if (value < 0) return defaultVal;

            return value;
        };
    };
    //
});
