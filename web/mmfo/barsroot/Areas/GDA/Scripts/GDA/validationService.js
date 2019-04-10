/**
 * Created by serhii.karchavets on 22-Nov-17.
 */

angular.module(globalSettings.modulesAreas).factory("validationService", function (utilsService) {

    var _indexOff = function (array, value) {
        for(var i = 0; i < array.length; i++){
            if(array[i] === value){ return i; }
        }
        return -1;
    };

    var _Date1LessDate2 = function (strDate1, strDate2) {
        var arrDate1 = strDate1.split('/');
        var date1 = new Date(arrDate1[2], arrDate1[1]-1, arrDate1[0]);
        var date2 = new Date();
        if(!utilsService.isEmpty(strDate2)){
            var arrDate2 = strDate2.split('/');
            date2 = new Date(arrDate2[2], arrDate2[1]-1, arrDate2[0]);
        }
        var diff = utilsService.dateDiff(date2, date1);
        for(var i = 0; i < diff.length; i++){
            if(diff[i] < 0){
                return true;
            }
        }
        return false;
    };

    var _formValidators = {
        placementTranche: function (fieldId, formData) {
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);

            if(_indexOff(['sumValue', 'period'], fieldId) !== -1 ||
                (_indexOff(['numberAutoparts', 'interestRateBonus'], fieldId) !== -1 && formData["autoExtension"]) ||
                (fieldId === 'interestRate' && !formData['individualInterestRate'])){
                return isEmpty ? false : value > 0;
            }
            else if(_indexOff(['sumValueMax', 'sumValueMin'], fieldId) !== -1 && formData["replenishmentTranche"]){
                if(isEmpty || value <= 0){
                    return false;
                }
                var max = fieldId === 'sumValueMax' ? value : formData['sumValueMax'];
                var min = fieldId === 'sumValueMin' ? value : formData['sumValueMin'];

                var isMaxEmpty = fieldId === 'sumValueMax' ? false : utilsService.isEmpty(max, true);
                var isMinEmpty = fieldId === 'sumValueMin' ? false : utilsService.isEmpty(min, true);
                if(!isMaxEmpty && !isMinEmpty){
                    return min <= max;
                }
            }
            else if(_indexOff(['comment', 'individualInterestRateValue'], fieldId) !== -1 && formData["individualInterestRate"]){
                if(isEmpty || (fieldId === "individualInterestRateValue" && value <= 0)){
                    return false;
                }
            }
            else if(_indexOff(['dateKontractPlacement', 'dateReturn', 'dateCompletingTranche2'], fieldId) !== -1){
                return isEmpty ? false : !_Date1LessDate2(value);
            }
            return _indexOff(['accDebit', 'payingInterest'], fieldId) === -1 || !isEmpty;
        },
        replacementTranche: function (fieldId, formData){
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);

            if (_indexOff(['sumValue', 'period'], fieldId) !== -1 ||
                (_indexOff(['numberAutoparts', 'interestRateBonus'], fieldId) !== -1 && formData["autoExtension"]) ||
                (fieldId === 'interestRate' && !formData['individualInterestRate'])) {
                return isEmpty ? false : value > 0;
            }
            else if (_indexOff(['sumValueMax', 'sumValueMin'], fieldId) !== -1 && formData["replenishmentTranche"]) {
                if (isEmpty || value <= 0) {
                    return false;
                }
                var max = fieldId === 'sumValueMax' ? value : formData['sumValueMax'];
                var min = fieldId === 'sumValueMin' ? value : formData['sumValueMin'];

                var isMaxEmpty = fieldId === 'sumValueMax' ? false : utilsService.isEmpty(max, true);
                var isMinEmpty = fieldId === 'sumValueMin' ? false : utilsService.isEmpty(min, true);
                if (!isMaxEmpty && !isMinEmpty) {
                    return min <= max;
                }
            }
            else if (_indexOff(['comment', 'individualInterestRateValue'], fieldId) !== -1 && formData["individualInterestRate"]) {
                if (isEmpty || (fieldId === "individualInterestRateValue" && value <= 0)) {
                    return false;
                }
            }
            else if (_indexOff(['dateKontractPlacement', 'dateReturn', 'dateCompletingTranche2'], fieldId) !== -1) {
                return isEmpty ? false : !_Date1LessDate2(value);
            }
            return _indexOff(['accDebit', 'payingInterest'], fieldId) === -1 || !isEmpty;
        },
        earlyRepaymentTranche: function (fieldId, formData){
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);

            if(_indexOff(['commentPenalty', 'penaltyInterestRateValue'], fieldId) !== -1 && formData["penaltyInterestRate"]){
                return fieldId === "commentPenalty" ? !isEmpty : (isEmpty ? false : value > 0);
            }
            else if(fieldId === 'dateReturnStatement'){
                return isEmpty ? false : !_Date1LessDate2(value);
            }
            return _indexOff(['accCreit'], fieldId) === -1 || !isEmpty;
        },
        depositDemand: function (fieldId, formData) {
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);

            if(fieldId === 'sumValue'){
                if(formData['replenishmentOnDayRegistration']){
                    return isEmpty ? false : value > 0;
                }
            }
            else if(fieldId === "comment" || fieldId === "individualInterestRateValue"){
                if(formData["individualInterestRate"]){
                    if(fieldId === "comment"){
                        return !isEmpty;
                    }
                    else if(fieldId === "individualInterestRateValue"){
                        return isEmpty ? false : value > 0;
                    }
                }
            }
            else if(fieldId === 'interestRate' && !formData['individualInterestRate']){
                return isEmpty ? false : value > 0;
            }
            return _indexOff(['accDebit', 'accCreit'], fieldId) === -1 || !isEmpty;
		},
		closeDepositDemand: function (fieldId, formData) {
			var value = formData[fieldId];
			var isEmpty = utilsService.isEmpty(value);

			if (fieldId === 'sumValue') {
				if (formData['replenishmentOnDayRegistration']) {
					return isEmpty ? false : value > 0;
				}
			}
			else if (fieldId === "comment" || fieldId === "individualInterestRateValue") {
				if (formData["individualInterestRate"]) {
					if (fieldId === "comment") {
						return !isEmpty;
					}
					else if (fieldId === "individualInterestRateValue") {
						return isEmpty ? false : value > 0;
					}
				}
			}
			else if (fieldId === 'interestRate' && !formData['individualInterestRate']) {
				return isEmpty ? false : value > 0;
			}
			return _indexOff(['accDebit', 'accCreit'], fieldId) === -1 || !isEmpty;
		},
		editDepositDemand: function (fieldId, formData) {
			var value = formData[fieldId];
			var isEmpty = utilsService.isEmpty(value);

			if (fieldId === 'sumValue') {
				if (formData['replenishmentOnDayRegistration']) {
					return isEmpty ? false : value > 0;
				}
			}
			else if (fieldId === "comment" || fieldId === "individualInterestRateValue") {
				if (formData["individualInterestRate"]) {
					if (fieldId === "comment") {
						return !isEmpty;
					}
					else if (fieldId === "individualInterestRateValue") {
						return isEmpty ? false : value > 0;
					}
				}
			}
			else if (fieldId === 'interestRate' && !formData['individualInterestRate']) {
				return isEmpty ? false : value > 0;
			}
			return _indexOff(['accDebit', 'accCreit'], fieldId) === -1 || !isEmpty;
		}
    };
    //Реализовуем дату возврара + срок
    var _blurLogic = {
       
        placementTranche: function (fieldId, formData) {
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);
            if (fieldId === 'ExpiryDate') {
                if (!isEmpty) {
                    if (isNaN(value)) {
                        value = $('#expiryDateCalendar').val();
                        formData[fieldId] = value;
                    }
                    //var dPlacementArr = formData['StartDate'].split('-');
                    var dPlacementArr = formData['StartDate'].split('.');
                    //var dPlacement = new Date(dPlacementArr[0], dPlacementArr[1]-1, dPlacementArr[2]);
                    var dPlacement = new Date(dPlacementArr[2], dPlacementArr[1] - 1, dPlacementArr[0]);
                    //var dReturnArr = value.split('-');
                    var dReturnArr = value.split('.');
                    //var dReturn = new Date(dReturnArr[0], dReturnArr[1]-1, dReturnArr[2]);
                    var dReturn = new Date(dReturnArr[2], dReturnArr[1] - 1, dReturnArr[0]);

                    var dateDiff = utilsService.dateDiff(dPlacement, dReturn);
                    formData['NumberTrancheDays'] = dateDiff[2];
                    $("#isReplenishmentTran").data("kendoDropDownList").trigger("change");
                    return true;

                }
            }
            else if (fieldId === 'NumberTrancheDays') {
                var value = formData[fieldId]; //количество дней строка транша
                var isEmpty = utilsService.isEmpty(value);
                if (!isEmpty) {
                    var dPlacement = new Date();
                    var dReturn = new Date();
                    dReturn.setDate(dPlacement.getDate() + Number(value));
                    //var dReturn = [addLeadZero('00' + dReturn.getDate()), addLeadZero(dReturn.getMonth() + 1), dReturn.getFullYear()].join('-');
                    var dReturn = [addLeadZero('00' + dReturn.getDate()), addLeadZero(dReturn.getMonth() + 1), dReturn.getFullYear()].join('.');
                    formData['ExpiryDate'] = dReturn;
                    $("#isReplenishmentTran").data("kendoDropDownList").trigger("change");
                    return true;
                }
            }
            

        },
        replacementTranche: function (fieldId, formData) {
            var value = formData[fieldId];
            var isEmpty = utilsService.isEmpty(value);
            if (fieldId === 'ExpiryDate') {
                if (!isEmpty) {
                    var startDate = kendo.toString(kendo.parseDate(formData['StartDate']), 'dd.MM.yyyy');
                    var expiryDate = kendo.toString(kendo.parseDate(formData['ExpiryDate']), 'dd.MM.yyyy')
                    
                    //var dPlacementArr = formData['StartDate'].split('-');
                  
                   // var dPlacementArr = formData['StartDate'].split('.');
                    var dPlacementArr = startDate.split('.');
                    //var dPlacement = new Date(dPlacementArr[0], dPlacementArr[1]-1, dPlacementArr[2]);
                    var dPlacement = new Date(dPlacementArr[2], dPlacementArr[1] - 1, dPlacementArr[0]);

                    //var dReturnArr = value.split('-');
                  
                    var dReturnArr = expiryDate.split('.');
                    //var dReturn = new Date(dReturnArr[0], dReturnArr[1]-1, dReturnArr[2]);
                    var dReturn = new Date(dReturnArr[2], dReturnArr[1] - 1, dReturnArr[0]);

                    var dateDiff = utilsService.dateDiff(dPlacement, dReturn);

                    formData['NumberTrancheDays'] = dateDiff[2];
                    $("#isReplenishmentTranReplace").data("kendoDropDownList").trigger("change");
                    return true;
                }
            }
            else if (fieldId === 'NumberTrancheDays') {
           
                var value = +formData[fieldId]; //количество дней строка транша
                var isEmpty = utilsService.isEmpty(value);
                if (!isEmpty) {
                    var dPlacement = $("#datePlacement").data("kendoDatePicker");

                    var date = new Date(dPlacement.value());
                    date.setDate(date.getDate() + value);

                   
                    var dReturn = $("#dateReturning").data("kendoDatePicker");
                    
                    dReturn.value(date);
                   
                    dReturn.trigger("change");
                    //formData['ExpiryDate'] = dReturn.value();

                    //$("#isReplenishmentTranReplace").data("kendoDropDownList").trigger("change");
                    return true;
                }
            }
        }
    };

    //Режем дату в нужном формате
    function addLeadZero(v) {
        return ('00' + v).slice(-2);
    }

    var validationOnForms = {
        
        placementTranche: function (operation, fieldsData) {
            var ostc = fieldsData.ostc;
            var frequencyPayment = fieldsData.frequencyPayment;
            var interestRate = fieldsData.interestRate;
            var amount = fieldsData.amount;
            var currency = fieldsData.currency;
            var debitAccount = fieldsData.debitAccount;
            var returnAccount = fieldsData.returnAccount;
            var isProlongation = fieldsData.isProlongation;
            var numProlongation = fieldsData.numProlongation;
            var interestRateProlongation = fieldsData.interestRateProlongation;
            var isReplenishmentTranche = fieldsData.isReplenishmentTranche;
            //var maxSumTranche = fieldsData.maxSumTranche;
            var minReplenishmentAmount = fieldsData.minReplenishmentAmount;
            var isIndividualRate = fieldsData.isIndividualRate;
            var individualInterestRate = fieldsData.individualInterestRate;
            var isCapitalization = fieldsData.isCapitalization;
            var interestRateCapitalization = fieldsData.interestRateCapitalization;
            var comment = fieldsData.comment;
            var numberTrancheDays = fieldsData.numberTrancheDays;


            if (amount == 0 || amount == null || amount == '' || amount == ' ') {        //проверка: сумма не должна быть меньше 100
                bars.ui.alert({ text: "Укажіть суму траншу" });
                return false;
            }
            if (amount <= 0) {        //проверка: сумма не должна быть меньше 100
                bars.ui.alert({ text: "Сума траншу повинна бути не менше 0" });
                return false;
            }
            if (currency == null || currency == 0 || currency == '' || currency == ' ') {
                bars.ui.alert({ text: "Укажіть валюту <br><br> (Введіть код валюти)" });
                return false;
            }
            if (debitAccount == null || debitAccount == 0 || debitAccount == '' || debitAccount == ' ') {
                bars.ui.alert({ text: "Виберіть рахунок для списання <br><br> (Якщо немає рахунків для вибору, можливо ви не правильно вказали код валюти)" });
                return false;
            }
            if (returnAccount == null || returnAccount == 0 || returnAccount == '' || returnAccount == ' ') {
                bars.ui.alert({ text: "Виберіть рахунок для повернення <br><br> (Якщо немає рахунків для вибору, можливо ви не правильно вказали код валюти)" });
                return false;
            }
            if (isProlongation != 0 && isProlongation != 1) {
                bars.ui.alert({ text: "Виберіть Автопролонгацію" });
                return false;
            }

            if (isProlongation == 1) {
                if (numProlongation == null || numProlongation == 0 || numProlongation == '' || numProlongation == ' ') {
                    bars.ui.alert({ text: "Оберіть кількість автопролонгацій" });
                    return false;
                }
                if (interestRateProlongation == null || interestRateProlongation == 0 || interestRateProlongation == '' || interestRateProlongation == ' ') {
                    bars.ui.alert({ text: "Виберіть Пролонгацію" });
                    console.log(interestRateProlongation);
                    return false;
                }
            }
            if (isReplenishmentTranche != 0 && isReplenishmentTranche != 1) {
                bars.ui.alert({ text: "Виберіть Поповнення траншу" });
                console.log(isReplenishmentTranche);
                return false;
            }
            if (isReplenishmentTranche == 1) {
                //if (maxSumTranche == null || maxSumTranche == 0 || maxSumTranche == '' || maxSumTranche == ' ') {
                //    bars.ui.alert({ text: "Введіть Максимальну суму траншу" });
                //    return false;
                //}
                //if (maxSumTranche < amount) {
                //    bars.ui.alert({ text: "Максимальна сума траншу повинна бути не меншою, ніж Сума траншу" });
                //    return false;
                //}
                //if (minReplenishmentAmount == null || minReplenishmentAmount == 0 || minReplenishmentAmount == '' || minReplenishmentAmount == ' ') {
                //    bars.ui.alert({ text: "Введіть Мінімальну суму траншу" });
                //    return false;
                //}
                //if (minReplenishmentAmount > amount) {
                //    bars.ui.alert({ text: "Мінімальна сума траншу повинна бути не більшою, ніж Сума траншу" });
                //    return false;
                //}
            }



            if (frequencyPayment == 0) {
                bars.ui.alert({ text: "Виберіть періодичність виплати" });
                return false;
            }
            if (frequencyPayment == 1) {        //проверка: дата Поверрнення должна быть на месяц больше чем дата Розміщення
               
                if (numberTrancheDays <= 29) {
                    bars.ui.alert({ text: "Строк вкладу менше місяця. Змініть \"Дату повернення\" або оберіть \"періодичність виплати - В кінці строку\"  " });
                    return false;
                }
            }
            if (frequencyPayment == 2) {        //проверка: дата Поверрнення должна быть на 3 месяца больше чем дата Розміщення
                
                if (numberTrancheDays <= 89) {
                    bars.ui.alert({ text: "Строк вкладу менше 90 днів. Змініть \"Дату повернення\" або оберіть \"періодичність виплати - В кінці строку\"" });
                    return false;
                }
            }
            if (isIndividualRate != 0 && isIndividualRate != 1) {
                bars.ui.alert({ text: "Виберіть Індивідуальну ставку" });
                return false;
            }
            if (isIndividualRate == 1) {
                if (individualInterestRate == null || individualInterestRate == 0 || individualInterestRate == '' || individualInterestRate == ' ') {
                    bars.ui.alert({ text: "Введіть % ставку" });
                    return false;
                } else if (interestRate != individualInterestRate && operation == 'save') {
                    bars.ui.alert({ text: "Ви обрали індивідуальну ставку. Натисніть <button id='countPercentBtn' class='btn btn-default'><i class='pf-icon pf-16 pf-percentage'></i>Розрахувати</button> для коректного розрахунку та збереження параметрів" });
                    return false;
                }
            }
            if (isCapitalization != 0 && isCapitalization != 1) {
                bars.ui.alert({ text: "Виберіть Капіталізацію" });
                return false;
            }

            //if (isIndividualRate == 1 && interestRate != individualInterestRate) {
            //    bars.ui.alert({ text: "Ви обрали індивідуальну ставку. Натисніть 'Розрахувати ставку' для коректного розрахунку та збереження параметрів" });
            //    return false;
            //}

            //if (isCapitalization == 1) {
               
            //    if (interestRateCapitalization == null || interestRateCapitalization == 0 || interestRateCapitalization == '' || interestRateCapitalization == ' ') {
            //        bars.ui.alert({ text: "Виберіть Періодичність Капіталізації" });
            //        console.log(interestRateCapitalization);
            //        return false;
            //    }
            //    }
        

            if (interestRateCapitalization == 2) {
               
                if (numberTrancheDays <= 89) {
                    bars.ui.alert({ text: "Строк вкладу менше місяця. Змініть \"Дату повернення\" або Змініть \"Періодичність Капіталізації\"  " });
                    
                    return false;
                }
            }

            switch (operation) {
                case "save":
                    if (interestRate == 0 || interestRate == "" || interestRate == " " || interestRate == null) {
                        bars.ui.alert({ text: "Розрахуйте % ставку" });
                        return false;
                    }
                    if (isIndividualRate == 1) {
                        if (comment == 0 || comment == "" || comment == " " || comment == null) {
                            bars.ui.alert({ text: "Введіть коментар" });
                            return false;
                        }
                    }
                    break;
            }
        },
       
        replacementTranche: function (operation, fieldsData) {
            
            var ostc = fieldsData.ostc;
            var frequencyPayment = fieldsData.frequencyPayment;
            var interestRate = fieldsData.interestRate;
            var amount = fieldsData.amount;
            var currency = fieldsData.currency;
            var debitAccount = fieldsData.debitAccount;
            var returnAccount = fieldsData.returnAccount;
            var isProlongation = fieldsData.isProlongation;
            var numProlongation = fieldsData.numProlongation;
            var interestRateProlongation = fieldsData.interestRateProlongation;
            var isReplenishmentTranche = fieldsData.isReplenishmentTranche;
            //var maxSumTranche = fieldsData.maxSumTranche;
            var minReplenishmentAmount = fieldsData.minReplenishmentAmount;
            var isIndividualRate = fieldsData.isIndividualRate;
            var individualInterestRate = fieldsData.individualInterestRate;
            var isCapitalization = fieldsData.isCapitalization;
            var interestRateCapitalization = fieldsData.interestRateCapitalization;
            var comment = fieldsData.comment;
            var numberTrancheDays = fieldsData.numberTrancheDays;

            if (amount == 0 || amount == null || amount == '' || amount == ' ') {        //проверка: сумма не должна быть меньше 100
                bars.ui.alert({ text: "Укажіть суму траншу" });
                return false;
            }

            if (amount <= 0) {        //проверка: сумма не должна быть меньше 100
                bars.ui.alert({ text: "Сума траншу повинна бути не менше 0" });
                return false;
            }
            if (currency == null || currency == 0 || currency == '' || currency == ' ') {
                bars.ui.alert({ text: "Укажіть валюту <br><br> (Введіть код валюти)" });
                return false;
            }
            if (debitAccount == null || debitAccount == 0 || debitAccount == '' || debitAccount == ' ') {
                bars.ui.alert({ text: "Виберіть рахунок для списання <br><br> (Якщо немає рахунків для вибору, можливо ви не правильно вказали код валюти)" });
                return false;
            }
            if (returnAccount == null || returnAccount == 0 || returnAccount == '' || returnAccount == ' ') {
                bars.ui.alert({ text: "Виберіть рахунок для повернення <br><br> (Якщо немає рахунків для вибору, можливо ви не правильно вказали код валюти)" });
                return false;
            }
            if (isProlongation != 0 && isProlongation != 1) {
                bars.ui.alert({ text: "Виберіть Автопролонгацію" });
                return false;
            }
            if (isProlongation == 1) {
                if (numProlongation == null || numProlongation == 0 || numProlongation == '' || numProlongation == ' ') {
                    bars.ui.alert({ text: "Оберіть кількість автопролонгацій" });
                    return false;
                }
                //if (interestRateProlongation == null || interestRateProlongation == 0 || interestRateProlongation == '' || interestRateProlongation == ' ') {
                //    bars.ui.alert({ text: "Виберіть Пролонгацію" });
                //    console.log(interestRateProlongation);
                //    return false;
                //}
            }
            if (isReplenishmentTranche != 0 && isReplenishmentTranche != 1) {
                bars.ui.alert({ text: "Виберіть Поповнення траншу" });
                console.log(isReplenishmentTranche);
                return false;
            }
            if (isReplenishmentTranche == 1) {
                //if (maxSumTranche == null || maxSumTranche == 0 || maxSumTranche == '' || maxSumTranche == ' ') {
                //    bars.ui.alert({ text: "Введіть Максимальну суму траншу" });
                //    return false;
                //}
                //if (maxSumTranche < amount) {
                //    bars.ui.alert({ text: "Максимальна сума траншу повинна бути не меншою, ніж Сума траншу" });
                //    return false;
                //}
                //if (minReplenishmentAmount == null || minReplenishmentAmount == 0 || minReplenishmentAmount == '' || minReplenishmentAmount == ' ') {
                //    bars.ui.alert({ text: "Введіть Мінімальну суму траншу" });
                //    return false;
                //}
                //if (minReplenishmentAmount > amount) {
                //    bars.ui.alert({ text: "Мінімальна сума траншу повинна бути не більшою, ніж Сума траншу" });
                //    return false;
                //}
            }
            if (frequencyPayment == 0) {
                bars.ui.alert({ text: "Виберіть періодичність виплати" });
                return false;
            }
            if (frequencyPayment == 1) {        //проверка: дата Поверрнення должна быть на месяц больше чем дата Розміщення
                
                if (numberTrancheDays <= 29) {
                    bars.ui.alert({ text: "Строк вкладу менше місяця. Змініть \"Дату повернення\" або оберіть \"періодичність виплати - В кінці строку\"  " });
                    return false;
                }
            }
            if (frequencyPayment == 2) {        //проверка: дата Поверрнення должна быть на 3 месяца больше чем дата Розміщення
                
                if (numberTrancheDays <= 89) {
                    bars.ui.alert({ text: "Строк вкладу менше 90 днів. Змініть \"Дату повернення\" або оберіть \"періодичність виплати - В кінці строку\"  " });
                    return false;
                }
            }
            if (isIndividualRate != 0 && isIndividualRate != 1) {
                bars.ui.alert({ text: "Виберіть Індивідуальну ставку" });
                return false;
            }
            if (isIndividualRate == 1) {
                if (individualInterestRate == null || individualInterestRate == 0 || individualInterestRate == '' || individualInterestRate == ' ') {
                    bars.ui.alert({ text: "Введіть % ставку" });
                    return false;
                }
            }
            if (isCapitalization != 0 && isCapitalization != 1) {
                bars.ui.alert({ text: "Виберіть Капіталізацію" });
                return false;
            }
            //if (isCapitalization == 1) {
                
            //    if (interestRateCapitalization == null || interestRateCapitalization == 0 || interestRateCapitalization == '' || interestRateCapitalization == ' ') {
            //        bars.ui.alert({ text: "Виберіть Періодичність Капіталізації" });
            //        console.log(interestRateCapitalization);
            //        return false;
            //    }
            //    }
            
            if (interestRateCapitalization == 2) {
                
                if (numberTrancheDays <= 89) {
                    bars.ui.alert({ text: "Строк вкладу менше місяця. Змініть \"Дату повернення\" або Змініть \"Періодичність Капіталізації\"  " });

                    return false;
                }
            }

            switch (operation) {
                case "save":
                    if (interestRate == 0 || interestRate == "" || interestRate == " " || interestRate == null) {
                        bars.ui.alert({ text: "Розрахуйте % ставку" });
                        return false;
                    }
                    if (isIndividualRate == 1) {
                        if (comment == 0 || comment == "" || comment == " " || comment == null) {
                            bars.ui.alert({ text: "Введіть коментар" });
                            return false;
                        }
                    }
                    break;
            }
        },
        earlyRepaymentTranche: function (operation, fieldsData) {
            switch (operation) {
                case "count":

                    break;
                case "save":
                    if (fieldsData.comment == null || fieldsData.comment == '') {
                        bars.ui.alert({ text: 'Вкажіть коментар щодо причини повернення' });
                        return false;   
                    }

                    //if (fieldsData.penaltyRate == null || fieldsData.penaltyRate == '' || fieldsData.penaltyRate <= 0) {
                    //    bars.ui.alert({ text: 'Вкажіть штрафну ставку' });
                    //    return false; 
                    //}
                    break;
            }
        },
        depositDemand: function (operation, fieldsData) {
            switch (operation) {
                case "count":

                    break;
                case "save":

                    break;
            }
        },
        closeDepositDemand: function (operation, fieldsData) {
            switch (operation) {
                case "count":

                    break;
                case "save":

                    break;
            }
        },
        editDepositDemand: function (operation, fieldsData) {
            switch (operation) {
                case "count":

                    break;
                case "save":

                    break;
            }
        }
    };

    return {
        validateField: function (formId, fieldId, formData) {
            return _formValidators[formId](fieldId, formData);
        },
        validateAllFields: function (formId, formData) {
            for(var key in formData){
                if(!_formValidators[formId](key, formData)){
                    return false;
                }
            }
            return true;
        },
        onBlur: function (formId, fieldId, formData) {
            return _blurLogic[formId](fieldId, formData);
        },
        indexOff: function (array, value) {
            return _indexOff(array, value);
        },
       
        validation: function (formId, operation, fieldsData) {
            return validationOnForms[formId](operation, fieldsData);
        }
    }
});