/* 
 Licensed under the Apache License, Version 2.0

 http://www.apache.org/licenses/LICENSE-2.0
 */
using System;
using System.Xml.Serialization;
using System.Collections.Generic;
namespace Xml2CSharp
{
    [XmlRoot(ElementName = "CONDITION")]
    public class CONDITION
    {
        [XmlElement("ID")]
        public string Id { get; set; }
        [XmlElement("INTEREST_OPTION_ID")]
        public string InterestOptionId { get; set; }
        [XmlElement("CURRENCY_ID")]
        public string CurrencyId { get; set; }
        [XmlElement("TERM_UNIT")]
        public string TermUnit { get; set; }
        [XmlElement("TERM_FROM")]
        public string TermFrom { get; set; }
        [XmlElement("AMOUNT_FROM")]
        public string AmountFrom { get; set; }
        [XmlElement("INTEREST_RATE")]
        public string InterestRate { get; set; }
        [XmlElement("CURRENCY")]
        public string Currency { get; set; }
        [XmlElement("PAYMENT_TERM_ID")]
        public string PaymentTermId { get; set; }
        [XmlElement(ElementName = "PAYMENT_TERM")]
        public string PaymentTerm { get; set; }
        [XmlElement(ElementName = "APPLY_TO_FIRST")]
        public string ApplyToFirst { get; set; }
        [XmlElement(ElementName = "APPLY_TO_FIRST_NAME")]
        public string ApplyToFirstName { get; set; }
        [XmlElement(ElementName = "RATE_FROM")]
        public string RateFrom { get; set; }
        [XmlElement(ElementName = "PENALTY_RATE")]
        public string PenaltyRate { get; set; }
        [XmlElement(ElementName = "MIN_SUM_TRANCHE")]
        public string MinSumTranche { get; set; }
        [XmlElement(ElementName = "MAX_SUM_TRANCHE")]
        public string MaxSumTranche { get; set; }
        [XmlElement(ElementName = "MIN_REPLENISHMENT_AMOUNT")]
        public string MinReplenishmentAmount { get; set; }
        [XmlElement(ElementName = "MAX_REPLENISHMENT_AMOUNT")]
        public string MaxReplenishmentAmount { get; set; }
        [XmlElement(ElementName = "TRANCHE_TERM")]
        public string TranchTerm { get; set; }
        [XmlElement(ElementName = "DAYS_TO_CLOSE_REPLENISH")]
        public string DaysToCloseReplenish { get; set; }

        [XmlElement(ElementName = "CALCULATION_TYPE_ID")]
        public string CalculationTypeId { get; set; }

        [XmlElement(ElementName = "CALCULATION_TYPE_NAME")]
        public string CalculationTypeName { get; set; }
        [XmlElement(ElementName = "IS_REPLENISHMENT")]
        public string IsReplenishment { get; set; }

        [XmlElement(ElementName = "IS_PROLONGATION")]
        public string IsProlongation { get; set; }
    }

    [XmlRoot(ElementName = "CONDITIONS")]
    public class CONDITIONS
    {
        [XmlElement("CONDITION")]
        public List<CONDITION> Condition { get; set; }
    }

    [XmlRoot(ElementName = "OPTION")]
    public class OPTION
    {
        [XmlElement("ID")]
        public string Id { get; set; }
        [XmlElement("VALID_FROM")]
        public string ValidFrom { get; set; }
        [XmlElement("VALID_THROUGH")]
        public string ValidThrough { get; set; }
        [XmlElement("IS_ACTIVE")]
        public string IsActive { get; set; }
        [XmlElement("USER_ID")]
        public string UserId { get; set; }
        [XmlElement("SYS_TIME")]
        public string SysTime { get; set; }
        [XmlElement("CONDITIONS")]
        public CONDITIONS Conditions { get; set; }
        [XmlElement("OPTION_DESCRIPTION")]
        public string OptionDescription { get; set; }

        [XmlElement("ID_")]
        public string Id_ { get; set; }

        [XmlElement("CALCULATION_TYPE_ID")]
        public string CalculationTypeId { get; set; }
    }

    [XmlRoot(ElementName = "OPTIONS")]
    public class OPTIONS
    {
        [XmlElement("OPTION")]
        public List<OPTION> Option { get; set; }
    }

    [XmlRoot(ElementName = "KIND")]
    public class KIND
    {
        [XmlElement(ElementName = "TYPE_CODE")]
        public string TYPE_CODE { get; set; }
        [XmlElement(ElementName = "ID")]
        public string ID { get; set; }
        [XmlElement(ElementName = "TYPE_ID")]
        public string TYPE_ID { get; set; }
        [XmlElement(ElementName = "KIND_CODE")]
        public string KIND_CODE { get; set; }
        [XmlElement(ElementName = "KIND_NAME")]
        public string KIND_NAME { get; set; }
        [XmlElement(ElementName = "IS_ACTIVE")]
        public string IS_ACTIVE { get; set; }
        [XmlElement(ElementName = "OPTIONS")]
        public OPTIONS OPTIONS { get; set; }
    }

    [XmlRoot(ElementName = "KINDS")]
    public class KINDS
    {
        [XmlElement("KIND")]
        public KIND Kind { get; set; }
    }

    [XmlRoot(ElementName = "GENERAL")]
    public class GENERAL
    {
        [XmlElement("KINDS")]
        public KINDS Kinds { get; set; }
    }

    [XmlRoot(ElementName = "BONUS")]
    public class BONUS
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "PAYMENT")]
    public class PAYMENT
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "CAPITALIZATION")]
    public class CAPITALIZATION
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "PROLONGATION")]
    public class PROLONGATION
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "PENALTY_RATE")]
    public class PENALTY_RATE
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "TRANCHE_AMOUNT_SETTING")]
    public class TRANCHE_AMOUNT_SETTING
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "REPLENISHMENT_TRANCHE")]
    public class REPLENISHMENT_TRANCHE
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "REPLENISHMENT")]
    public class REPLENISHMENT
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "DEPOSIT_ON_DEMAND")]
    public class DEPOSIT_ON_DEMAND
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "DEPOSIT_ON_DEMAND_CALC")]
    public class DEPOSIT_ON_DEMAND_CALC
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }

    [XmlRoot(ElementName = "RATE_FOR_BLOCKED_TRANCHE")]
    public class RATE_FOR_BLOCKED_TRANCHE
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }


    [XmlRoot(ElementName = "PROLONGATION_BONUS")]
    public class PROLONGATION_BONUS
    {
        [XmlElement(ElementName = "KINDS")]
        public KINDS KINDS { get; set; }
    }
    [XmlRoot(ElementName = "ROOT")]
    public class ROOT
    {
        [XmlElement("GENERAL")]
        public GENERAL General { get; set; }
        [XmlElement(ElementName = "BONUS")]
        public BONUS BONUS { get; set; }
        [XmlElement("PAYMENT")]
        public PAYMENT PAYMENT { get; set; }
        [XmlElement(ElementName = "CAPITALIZATION")]
        public CAPITALIZATION CAPITALIZATION { get; set; }
        [XmlElement(ElementName = "PROLONGATION")]
        public PROLONGATION PROLONGATION { get; set; }
        [XmlElement(ElementName = "PENALTY_RATE")]
        public PENALTY_RATE PENALTY_RATE { get; set; }
        [XmlElement(ElementName = "TRANCHE_AMOUNT_SETTING")]
        public TRANCHE_AMOUNT_SETTING TRANCHE_AMOUNT_SETTING { get; set; }
        [XmlElement(ElementName = "REPLENISHMENT_TRANCHE")]
        public REPLENISHMENT_TRANCHE REPLENISHMENT_TRANCHE { get; set; }

        [XmlElement(ElementName = "REPLENISHMENT")]
        public REPLENISHMENT REPLENISHMENT { get; set; }

        [XmlElement(ElementName = "DEPOSIT_ON_DEMAND")]
        public DEPOSIT_ON_DEMAND DEPOSIT_ON_DEMAND { get; set; }

        [XmlElement(ElementName = "DEPOSIT_ON_DEMAND_CALC")]
        public DEPOSIT_ON_DEMAND_CALC DEPOSIT_ON_DEMAND_CALC { get; set; }

        [XmlElement(ElementName = "RATE_FOR_BLOCKED_TRANCHE")]
        public RATE_FOR_BLOCKED_TRANCHE RATE_FOR_BLOCKED_TRANCHE { get; set; }

        [XmlElement(ElementName = "PROLONGATION_BONUS")]
        public PROLONGATION_BONUS PROLONGATION_BONUS { get; set; }
    }

}
