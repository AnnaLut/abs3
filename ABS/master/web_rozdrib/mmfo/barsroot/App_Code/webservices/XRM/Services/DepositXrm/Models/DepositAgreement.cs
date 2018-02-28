using System;
using System.Collections.Generic;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class XRMDepositAgreementAccount
    {
        public String nls;
        public String mfo;
        public String okpo;
        public String nmk;
    }
    public class XRMDepositAgreementTrusteeOpt
    {
        public Int16? flag1;
        public Int16? flag2;
        public Int16? flag3;
        public Int16? flag4;
        public Int16? flag5;
        public Int16? flag6;
        public Int16? flag7;
        public Int16? flag8;
    }
    public class XRMDepositAgreementReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public String Branch;
        public Decimal DptId;
        public Int16 AgreementType;
        public Decimal InitCustid;                              // РНК инициатора ДС
        public Decimal TrustCustid;                             // РНК 3-ї ососби                
        public Decimal Trustid;                                 // ДУ 3й особи
        public XRMDepositAgreementAccount TransferDPT;          // параметры возврата депозита
        public XRMDepositAgreementAccount TransferINT;          // параметры выплаты процентов
        public Decimal? Amountcash;                             // сума готівкою (ДУ про зміну суми договору)
        public Decimal? Amountcashless;                         // сума безготівкою(ДУ про зміну суми договору)
        public DateTime? DateBegin;
        public DateTime? DateEnd;
        public Decimal? RateReqId;
        public Decimal? RateValue;
        public DateTime? RateDate;
        public Decimal? DenomAmount;
        public String Denomcount;
        public XRMDepositAgreementTrusteeOpt DATrusteeOpt;      // опции при заключении доверенности на депозит 
        public Decimal? DenomRef;
        public Decimal? ComissRef;
        public Decimal? DocRef;                                 // реф.документу поповнення / частк.зняття (ДУ про зміну суми договору)
        public Decimal? ComissReqId;                            // идентификатор запроса на отмену комисии
        public String TemplateId;                               // ІД шаблону ДУ
        public Int16? freq;                                     // нова періодичність виплати відсотків
        public String Access_others;                            // поле інше в шаблоні доступу додугод
    }
    public class XRMDepositAgreementResult
    {
        public Decimal? AgrementId;
        public decimal Status;
        public string ErrMessage;
    }

    #region  DepositAdditionAgreementDoc
    public class XRMDepositAdditionalAgreementReq
    {
        public Decimal TransactionId;
        public String UserLogin;
        public Int16 OperationType;
        public String KF;
        public Decimal? Rnk;
        public Int16 TypeId;
        public Int32? DptId;
        public Int32? AgrId;
    }

    public class XRMDepositAdditionalAgreementRes
    {
        //public byte[] Doc;
        public string Doc;
        public int ResultCode;
        public string ResultMessage;
    }
    #endregion DepositAdditionAgreementDoc
}