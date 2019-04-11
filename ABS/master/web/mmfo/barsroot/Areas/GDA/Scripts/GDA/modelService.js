/**
 * Created by serhii.karchavets on 22-Nov-17.
 */

angular.module(globalSettings.modulesAreas).factory("modelService", function () {
    function MainInfo() {
        this.sumValue = 0.0;                          //Сума траншу/Сума поповнення/Сума вкладу
        this.currency = 980;                         //Валюта траншу
        this.acc = null;                      //Депозитний рахунок
        this.clientRnk = 0;      //РНК клієнта
        this.clientOkpo = "";    //ОКПО клієнта
        this.clientName = "";    //Назва клієнта
        this.State = 0;
        this.OperatorDate = null;
        this.ControllerDate = null;
        this.OperatorId = 0;
        this.OperatorName = "";
        this.ControllerId = 0;
        this.ControllerName = "";
        this.dateKontractPlacement = null;                    //Дата заяви про розміщення траншу
        this.kontractPlacement = null;                           //№ Заяви про розміщення траншу
    }

    function PlacementTranche() {
        this.ProcessId = null;
        this.ObjectId = null;
        this.CurrencyId = null;
        this.CustomerId = 0;
        this.StartDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.ExpiryDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.NumberTrancheDays = 0;
        this.AmountTranche = 0;
        this.InterestRate = null;
        this.IsProlongation = 0;
        this.NumberProlongation = null;
        this.InterestRateProlongation = 0;
        this.IsReplenishmentTranche = 0;
        this.MaxSumTranche = null;
        this.MinReplenishmentAmount = null;
        this.LastReplenishmentDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.FrequencyPayment = null;
        this.IsIndividualRate = 0;
        this.IndividualInterestRate = 0;
        this.IsCapitalization = 0;
        this.Comment = null;
        this.PrimaryAccount = null;
        this.DebitAccount = null;
        this.ReturnAccount = null;
        this.InterestAccount = null;
        this.Branch = null;
		this.ApplyBonusProlongation = null;
		this.InterestRateCapitalization = null;
		this.CapitalizationTerm = null;

		this.InterestRateBonus = null;
		this.BonusDescription = null;
		this.InterestRateGeneral = null;
		this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        //this.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        //this.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');

    }
    PlacementTranche.prototype = new MainInfo();

    function ReplacementTranche() {

        this.ProcessId = null;
        this.ObjectId = null;
        this.CurrencyId = null;
        this.CustomerId = 0;
        this.StartDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.ExpiryDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.NumberTrancheDays = 0;
        this.AmountTranche = 0;
        this.InterestRate = null;
        this.IsProlongation = null;
        this.NumberProlongation = null;
        this.InterestRateProlongation = 0;
        this.IsReplenishmentTranche = 0;
        this.MaxSumTranche = null;
        this.MinReplenishmentAmount = null;
        this.LastReplenishmentDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.FrequencyPayment = null;
        this.IsIndividualRate = 0;
        this.IndividualInterestRate = 0;
        this.IsCapitalization = 0;
        this.Comment = null;
        this.PrimaryAccount = null;
        this.DebitAccount = null;
        this.ReturnAccount = null;
        this.InterestAccount = null;
        this.Branch = null;
        this.DealNumber = null;
		this.ApplyBonusProlongation = null;
		this.InterestRateCapitalization = null;
		this.CapitalizationTerm = null;

		this.InterestRateBonus = null;
		this.BonusDescription = null;
		this.InterestRateGeneral = null;
		this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        //this.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        //this.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
    }
    ReplacementTranche.prototype = new MainInfo();

    function ReplenishmentTranche() {

        this.ProcessId = null;
        this.ObjectId = null;
        this.CurrencyId = null;
        this.CustomerId = 0;
        this.StartDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.ExpiryDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.NumberTrancheDays = 0;
        this.AmountTranche = 0;
        this.InterestRate = null;
        this.IsProlongation = null;
        this.NumberProlongation = null;
        this.InterestRateProlongation = 0;
        this.IsReplenishmentTranche = 0;
        this.MaxSumTranche = null;
        this.MinReplenishmentAmount = null;
        this.LastReplenishmentDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.FrequencyPayment = null;
        this.IsIndividualRate = 0;
        this.IndividualInterestRate = 0;
        this.IsCapitalization = 0;
        this.Comment = null;
        this.PrimaryAccount = null;
        this.DebitAccount = null;
        this.ReturnAccount = null;
        this.InterestAccount = null;
        this.Branch = null;
		this.ApplyBonusProlongation = null;
		this.InterestRateCapitalization = null;
		this.CapitalizationTerm = null;

		this.InterestRateBonus = null;
		this.BonusDescription = null;
		this.InterestRateGeneral = null;
		this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        //this.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        //this.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
    }
    ReplenishmentTranche.prototype = new MainInfo();

    function EditReplenishmentTranche() {

        this.ProcessId = null;
        this.ObjectId = null;
        this.CurrencyId = null;
        this.CustomerId = 0;
        this.StartDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.ExpiryDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.NumberTrancheDays = 0;
        this.AmountTranche = 0;
        this.InterestRate = null;
        this.IsProlongation = null;
        this.NumberProlongation = null;
        this.InterestRateProlongation = 0;
        this.IsReplenishmentTranche = 0;
        this.MaxSumTranche = null;
        this.MinReplenishmentAmount = null;
        this.LastReplenishmentDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.FrequencyPayment = null;
        this.IsIndividualRate = 0;
        this.IndividualInterestRate = 0;
        this.IsCapitalization = 0;
        this.Comment = null;
        this.PrimaryAccount = null;
        this.DebitAccount = null;
        this.ReturnAccount = null;
        this.InterestAccount = null;
        this.Branch = null;
		this.ApplyBonusProlongation = null;
		this.InterestRateCapitalization = null;
		this.CapitalizationTerm = null;

		this.InterestRateBonus = null;
		this.BonusDescription = null;
		this.InterestRateGeneral = null;
		this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        //this.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        //this.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
    }
    EditReplenishmentTranche.prototype = new MainInfo();

    function EarlyRepaymentTranche() {
        this.ProcessId = null;
        this.ObjectId = null;
        this.CurrencyId = null;
        this.CustomerId = 0;
        this.StartDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.ExpiryDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.NumberTrancheDays = 0;
        this.AmountTranche = 0;
        this.InterestRate = null;
        this.IsProlongation = null;
        this.NumberProlongation = null;
        this.InterestRateProlongation = 0;
        this.IsReplenishmentTranche = 0;
        this.MaxSumTranche = null;
        this.MinReplenishmentAmount = null;
        this.LastReplenishmentDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        this.FrequencyPayment = null;
        this.IsIndividualRate = 0;
        this.IndividualInterestRate = 0;
        this.IsCapitalization = 0;
        this.Comment = null;
        this.PrimaryAccount = null;
        this.DebitAccount = null;
        this.ReturnAccount = null;
        this.InterestAccount = null;
        this.Branch = null;
        this.PenaltyRate = null;
        this.AdditionalComment = null;
		this.ApplyBonusProlongation = null;
		this.InterestRateCapitalization = null;
        this.CapitalizationTerm = null;

        this.InterestRateBonus = null;
        this.BonusDescription = null;
        this.InterestRateGeneral = null;
        this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        //this.OperatorSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
        //this.ControllerSysTime = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
    }
    EarlyRepaymentTranche.prototype = new MainInfo();

    function DepositDemand() {
        this.dbo = null;                              //№ ДБО
        this.dboDate = null;                          //Дата відкриття ДБО
        this.replenishmentOnDayRegistration = true;   //(flag) Поповнення в день оформлення
        this.payingInterest = "Щомісячно";            //Варіанти виплати %
        this.interestRate = 0.0;                      //% ставка
        this.individualInterestRate = false;          //Флаг 'Індивідуальна % ставка'
        this.individualInterestRateValue = 0.0;       //Індивідуальна % ставка
        this.comment = "";                            //Коментар
        this.accDebit = null;                         //Рахунок для списання
        this.accDebitBalance = 0.0;                   //Залишок на рахунку для списання
        this.accCreit = null;                         //Рахунок для повернення      
        this.calculationType = 1;                     //Метод нарахування відсотків

        this.InterestRateBonus = null;
        this.BonusDescription = null;
        this.InterestRateGeneral = null;
        this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        this.InterestRateProlongation = 0;
        this.InterestRateCapitalization = null;


    }
    DepositDemand.prototype = new MainInfo();

    function CloseDepositDemand() {
        this.dbo = null;                              //№ ДБО
        this.dboDate = null;                          //Дата відкриття ДБО
        this.replenishmentOnDayRegistration = true;   //(flag) Поповнення в день оформлення
        this.payingInterest = "Щомісячно";            //Варіанти виплати %
        this.interestRate = 0.0;                      //% ставка
        this.individualInterestRate = false;          //Флаг 'Індивідуальна % ставка'
        this.individualInterestRateValue = 0.0;       //Індивідуальна % ставка
        this.comment = "";                            //Коментар
        this.accDebit = null;                         //Рахунок для списання
        this.accDebitBalance = 0.0;                   //Залишок на рахунку для списання
        this.accCreit = null;                         //Рахунок для повернення
        this.calculationType = 1;                     //Метод нарахування відсотків

        this.InterestRateBonus = null;
        this.BonusDescription = null;
        this.InterestRateGeneral = null;
        this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        this.InterestRateProlongation = 0;
        this.InterestRateCapitalization = null;

    }
	CloseDepositDemand.prototype = new MainInfo();

	function EditDepositDemand() {
		this.dbo = null;                              //№ ДБО
		this.dboDate = null;                          //Дата відкриття ДБО
		this.replenishmentOnDayRegistration = true;   //(flag) Поповнення в день оформлення
		this.payingInterest = "Щомісячно";            //Варіанти виплати %
		this.interestRate = 0.0;                      //% ставка
		this.individualInterestRate = false;          //Флаг 'Індивідуальна % ставка'
		this.individualInterestRateValue = 0.0;       //Індивідуальна % ставка
		this.comment = "";                            //Коментар
		this.accDebit = null;                         //Рахунок для списання
		this.accDebitBalance = 0.0;                   //Залишок на рахунку для списання
        this.accCredit = null;                         //Рахунок для повернення      
        this.calculationType = 1;                     //Метод нарахування відсотків

        this.InterestRateBonus = null;
        this.BonusDescription = null;
        this.InterestRateGeneral = null;
        this.InterestRatePayment = null;
        this.InterestRateReplenishment = null;
        this.InterestRateProlongation = 0;
        this.InterestRateCapitalization = null;
	}
	EditDepositDemand.prototype = new MainInfo();

    function ChangeDepositDemand() {
        this.ProcessId = null;
        this.CalculationType = 1;                     //Метод нарахування відсотків
        this.Comment = "";

    }
    EditDepositDemand.prototype = new MainInfo();


    function trancheinfo() {
        this.transhNum = 0.0;
        this.dateOpen = null;
        this.sum = 0.0;
        this.curr = "UAH";
    }
    trancheinfo.prototype = new MainInfo();





    var _modelsFactory = {
        placementTranche: PlacementTranche,
        replacementTranche: ReplacementTranche,
        replenishmentTranche: ReplenishmentTranche,
        earlyRepaymentTranche: EarlyRepaymentTranche,
        editreplenishmentTranche: EditReplenishmentTranche,
        depositDemand: DepositDemand,
        trancheinfo: trancheinfo,
		closeDepositDemand: CloseDepositDemand,
        editDepositDemand: EditDepositDemand,
        changeDepositDemand: ChangeDepositDemand 

    };

    return {
        initFormData: function (formId) { return new _modelsFactory[formId]; },
        initUserInfo: function () { return { FIO: "", ROLE: -1 }; }
    }
});
//ТестРелиз
