/**
 * Created by serhii.karchavets on 23-Nov-17.
 */

angular.module(globalSettings.modulesAreas).factory("saveDataService", function () {
    var _forms = {
        placementTranche: {
            //это то что отправл€ю
            prepareData4Save: function (formData) {
                return {
                    ProcessId:                      formData.processid,
                    ObjectId:                       formData.objectid,
                    CurrencyId:                     formData.CurrencyId,
                    CustomerId:                     formData.CustomerId,
                    StartDate:                      formData.StartDate,
                    ExpiryDate:                     formData.ExpiryDate,
                    NumberTrancheDays:              formData.NumberTrancheDays,
                    AmountTranche:                  formData.amountTranche.replace(/,/g, '.'),
                    InterestRate:                   formData.InterestRate,
                    IsProlongation:                 +formData.IsProlongation,
                    NumberProlongation:             formData.NumberProlongation,
                    InterestRateProlongation:       formData.InterestRateProlongation,
                    IsReplenishmentTranche:         +formData.IsReplenishmentTranche,
                    MaxSumTranche:                  formData.MaxSumTranche,
                    MinReplenishmentAmount: formData.MinReplenishmentAmount,
                    LastReplenishmentDate:          formData.LastReplenishmentDate,
                    FrequencyPayment:               +formData.FrequencyPayment,
                    IsIndividualRate:               formData.IsIndividualRate,
                    IndividualInterestRate:         formData.IndividualInterestRate,
                    IsCapitalization:               formData.IsCapitalization,
                    Comment:                        formData.Comment,
                    PrimaryAccount: formData.Primaryaccount,
                    DebitAccount:                   formData.DebitAccount,
                    ReturnAccount:                  formData.ReturnAccount,
                    InterestAccount:                formData.InterestAccount,
                    Branch:                         formData.Branch,

                    ApplyBonusProlongation:         +formData.ApplyBonusProlongation,
                    InterestRateCapitalization:     formData.InterestRateCapitalization,
                    CapitalizationTerm:             formData.CapitalizationTerm
                };
            }
        },
        replacementTranche: {
            prepareData4Save: function (formData){
                return {
                    ProcessId:                      formData.processid,
                    ObjectId:                       formData.objectid,
                    CurrencyId:                     formData.CurrencyId,
                    CustomerId:                     formData.CustomerId,
                    StartDate:                      formData.StartDate,
                    ExpiryDate:                     formData.ExpiryDate,
                    NumberTrancheDays:              formData.NumberTrancheDays,
                    AmountTranche:                  formData.amountTranche.replace(/,/g, '.'),
                    InterestRate:                   formData.interestRate,
                    IsProlongation:                 +formData.isProlongation,
                    NumberProlongation:             formData.NumberProlongation,
                    InterestRateProlongation:       formData.InterestRateProlongation,
                    IsReplenishmentTranche:         +formData.isReplenishmentTranche,
                    MaxSumTranche:                  formData.MaxSumTranche,
                    MinReplenishmentAmount:         formData.MinReplenishmentAmount,
                    LastReplenishmentDate:          formData.LastReplenishmentDate,
                    FrequencyPayment:               formData.FrequencyPayment,
                    IsIndividualRate:               +formData.IsIndividualRate,
                    IndividualInterestRate:         formData.IndividualInterestRate,
                    IsCapitalization:               +formData.IsCapitalization,
                    Comment:                        formData.Comment,
                    PrimaryAccount:                 formData.Primaryaccount,
                    DebitAccount:                   formData.DebitAccount,
                    ReturnAccount:                  formData.ReturnAccount,
                    InterestAccount:                formData.InterestAccount,
                    Branch:                         formData.Branch,

                    ApplyBonusProlongation: +formData.ApplyBonusProlongation,
                    InterestRateCapitalization: formData.InterestRateCapitalization,
                    CapitalizationTerm: formData.CapitalizationTerm
                };
            }
        },
        earlyRepaymentTranche: {
            prepareData4Save: function (formData){
                return {
                    ProcessId: formData.processid,
                    ObjectId: formData.objectid,
                    CurrencyId: formData.CurrencyId,
                    CustomerId: formData.CustomerId,
                    StartDate: formData.StartDate,
                    ExpiryDate: formData.ExpiryDate,
                    NumberTrancheDays: formData.NumberTrancheDays,
                    AmountTranche: formData.amountTranche.replace(/,/g, '.'),
                    InterestRate: formData.interestRate,
                    IsProlongation: +formData.isProlongation,
                    NumberProlongation: formData.NumberProlongation,
                    InterestRateProlongation: formData.InterestRateProlongation,
                    IsReplenishmentTranche: +formData.isReplenishmentTranche,
                    MaxSumTranche: formData.MaxSumTranche,
                    MinReplenishmentAmount: formData.MinReplenishmentAmount,
                    LastReplenishmentDate: formData.LastReplenishmentDate,
                    FrequencyPayment: formData.FrequencyPayment,
                    IsIndividualRate: +formData.IsIndividualRate,
                    IndividualInterestRate: formData.IndividualInterestRate,
                    IsCapitalization: +formData.IsCapitalization,
                    Comment: formData.Comment,
                    PrimaryAccount: formData.PrimaryAccount,
                    DebitAccount: formData.DebitAccount,
                    ReturnAccount: formData.ReturnAccount,
                    InterestAccount: formData.InterestAccount,
                    Branch: formData.Branch,

                    ApplyBonusProlongation: +formData.ApplyBonusProlongation,
                    InterestRateCapitalization: formData.InterestRateCapitalization,
                    CapitalizationTerm: formData.CapitalizationTerm
                };
            }
        },
        replenishmentTranche: {
            prepareData4Save: function (formData) {
                return {
                    ProcessId: formData.processid,
                    ObjectId: formData.objectid,
                    CurrencyId: formData.CurrencyId,
                    CustomerId: formData.CustomerId,
                    StartDate: formData.StartDate,
                    ExpiryDate: formData.ExpiryDate,
                    NumberTrancheDays: formData.NumberTrancheDays,
                    AmountTranche: formData.amountTranche.replace(/,/g, '.'),
                    InterestRate: formData.interestRate,
                    IsProlongation: +formData.isProlongation,
                    NumberProlongation: formData.NumberProlongation,
                    InterestRateProlongation: formData.InterestRateProlongation,
                    IsReplenishmentTranche: +formData.isReplenishmentTranche,
                    MaxSumTranche: formData.MaxSumTranche,
                    MinReplenishmentAmount: formData.MinReplenishmentAmount,
                    LastReplenishmentDate: formData.LastReplenishmentDate,
                    FrequencyPayment: formData.FrequencyPayment,
                    IsIndividualRate: +formData.IsIndividualRate,
                    IndividualInterestRate: formData.IndividualInterestRate,
                    IsCapitalization: +formData.IsCapitalization,
                    Comment: formData.Comment,
                    PrimaryAccount: formData.PrimaryAccount,
                    DebitAccount: formData.DebitAccount,
                    ReturnAccount: formData.ReturnAccount,
                    InterestAccount: formData.InterestAccount,
                    Branch: formData.Branch,

                    ApplyBonusProlongation: +formData.ApplyBonusProlongation,
                    InterestRateCapitalization: formData.InterestRateCapitalization,
                    CapitalizationTerm: formData.CapitalizationTerm
                };
            }
        },
        editreplenishmentTranche: {
            prepareData4Save: function (formData) {
                return {
                    ProcessId: formData.processid,
                    ObjectId: formData.objectid,
                    CurrencyId: formData.CurrencyId,
                    CustomerId: formData.CustomerId,
                    StartDate: formData.StartDate,
                    ExpiryDate: formData.ExpiryDate,
                    NumberTrancheDays: formData.NumberTrancheDays,
                    AmountTranche: formData.amountTranche.replace(/,/g, '.'),
                    InterestRate: formData.interestRate,
                    IsProlongation: +formData.isProlongation,
                    NumberProlongation: formData.NumberProlongation,
                    InterestRateProlongation: formData.InterestRateProlongation,
                    IsReplenishmentTranche: +formData.isReplenishmentTranche,
                    MaxSumTranche: formData.MaxSumTranche,
                    MinReplenishmentAmount: formData.MinReplenishmentAmount,
                    LastReplenishmentDate: formData.LastReplenishmentDate,
                    FrequencyPayment: formData.FrequencyPayment,
                    IsIndividualRate: +formData.IsIndividualRate,
                    IndividualInterestRate: formData.IndividualInterestRate,
                    IsCapitalization: +formData.IsCapitalization,
                    Comment: formData.Comment,
                    PrimaryAccount: formData.PrimaryAccount,
                    DebitAccount: formData.DebitAccount,
                    ReturnAccount: formData.ReturnAccount,
                    InterestAccount: formData.InterestAccount,
                    Branch: formData.Branch,

                    ApplyBonusProlongation: +formData.ApplyBonusProlongation,
                    InterestRateCapitalization: formData.InterestRateCapitalization,
                    CapitalizationTerm: formData.CapitalizationTerm
                };
            }
        },
        depositDemand: {
            prepareData4Save: function (formData) {
                return {
                    dbo:                                        formData.dbo,
                    replenishmentOnDayRegistration:             formData.replenishmentOnDayRegistration,
                    sumValue:                                   formData.sumValue.replace(/,/g, '.'),
                    currency:                                   formData.currency,
                    accCreit:                                   formData.accCreit,
                    accDebit:                                   formData.accDebit,
                    interestRate:                               formData.interestRate,
                    individualInterestRate:                     formData.individualInterestRate,
                    individualInterestRateValue:                formData.individualInterestRateValue,
                    comment:                                    formData.comment,
                    calculationType:                            formData.calculationType
                };
            }
		},
		closeDepositDemand: {
			prepareData4Save: function (formData) {
				return {
					dbo: formData.dbo,
					replenishmentOnDayRegistration: formData.replenishmentOnDayRegistration,
                    sumValue: formData.sumValue.replace(/,/g, '.'),
					currency: formData.currency,
					accCreit: formData.accCreit,
					accDebit: formData.accDebit,
					interestRate: formData.interestRate,
					individualInterestRate: formData.individualInterestRate,
					individualInterestRateValue: formData.individualInterestRateValue,
                    comment: formData.comment,
                    calculationType: formData.calculationType
				};
			}
		},
		editDepositDemand: {
			prepareData4Save: function (formData) {
				return {
					dbo: formData.dbo,
					replenishmentOnDayRegistration: formData.replenishmentOnDayRegistration,
                    sumValue: formData.sumValue.replace(/,/g, '.'),
					currency: formData.currency,
					accCreit: formData.accCreit,
					accDebit: formData.accDebit,
					interestRate: formData.interestRate,
					individualInterestRate: formData.individualInterestRate,
					individualInterestRateValue: formData.individualInterestRateValue,
                    comment: formData.comment,
                    calculationType: formData.calculationType
				};
			}
        },
        changeDepositDemand: {
            prepareData4Save: function (formData) {
                return {
                    ProcessId: formData.ProcessId,
                    CalculationType: formData.CalculationType,
                    Comment: formData.Comment
                };
            }
        }
    };

    return {
        prepareData4Save: function (formId, formData) {
            return _forms[formId].prepareData4Save(formData);
        }
    }
});