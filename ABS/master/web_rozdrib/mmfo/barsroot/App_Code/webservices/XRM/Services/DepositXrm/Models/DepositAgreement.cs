using System;
using System.Collections.Generic;
using System.Text;

namespace Bars.WebServices.XRM.Services.DepositXrm.Models
{
    public class Account
    {
        public string Nls { get; set; }
        public string Mfo { get; set; }
        public string Okpo { get; set; }
        public string Nmk { get; set; }
    }
    public class TrusteeOpt
    {
        public override string ToString()
        {            
            StringBuilder sb = new StringBuilder();
            sb.Append(IntToStr(Flag1));
            sb.Append(IntToStr(Flag2));
            sb.Append(IntToStr(Flag3));
            sb.Append(IntToStr(Flag4));
            sb.Append(IntToStr(Flag5));
            sb.Append(IntToStr(Flag6));
            sb.Append(IntToStr(Flag7));
            sb.Append(IntToStr(Flag8));
            return sb.ToString();
        }
        private string IntToStr(int? val)
        {
            if (null == val) return "0";
            return Convert.ToString(val);
        }
        public int? Flag1 { get; set; }
        public int? Flag2 { get; set; }
        public int? Flag3 { get; set; }
        public int? Flag4 { get; set; }
        public int? Flag5 { get; set; }
        public int? Flag6 { get; set; }
        public int? Flag7 { get; set; }
        public int? Flag8 { get; set; }
    }
    public class DepositAgreementRequest
    {
        public string Kf { get; set; }
        public string Branch { get; set; }
        public decimal DptId { get; set; }
        public short AgreementType { get; set; }
        public decimal InitCustid { get; set; }                              // РНК инициатора ДС
        public decimal TrustCustid { get; set; }                             // РНК 3-ї ососби                
        public decimal Trustid { get; set; }                                 // ДУ 3й особи
        public Account TransferDPT { get; set; }          // параметры возврата депозита
        public Account TransferINT { get; set; }          // параметры выплаты процентов
        public decimal? Amountcash { get; set; }                             // сума готівкою (ДУ про зміну суми договору)
        public decimal? Amountcashless { get; set; }                         // сума безготівкою(ДУ про зміну суми договору)
        public DateTime? DateBegin { get; set; }
        public DateTime? DateEnd { get; set; }
        public decimal? RateReqId { get; set; }
        public decimal? RateValue { get; set; }
        public DateTime? RateDate { get; set; }
        public decimal? DenomAmount { get; set; }
        public String Denomcount { get; set; }
        public TrusteeOpt DATrusteeOpt { get; set; }      // опции при заключении доверенности на депозит 
        public decimal? DenomRef { get; set; }
        public decimal? ComissRef { get; set; }
        public decimal? DocRef { get; set; }                                // реф.документу поповнення / частк.зняття (ДУ про зміну суми договору)
        public decimal? ComissReqId { get; set; }                           // идентификатор запроса на отмену комисии
        public string TemplateId { get; set; }                              // ІД шаблону ДУ
        public short? Frequency { get; set; }                               // нова періодичність виплати відсотків
        public string AccessOthers { get; set; }                            // поле інше в шаблоні доступу додугод
    }
    public class DepositAgreementRsponse
    {
        public decimal? AgrementId { get; set; }
    }

    #region  DepositAdditionAgreementDoc
    public class AdditionalAgreementRequest
    {
        public string Kf { get; set; }
        public decimal? Rnk { get; set; }
        public short TypeId { get; set; }
        public int? DptId { get; set; }
        public int? AgrId { get; set; }
    }

    public class AdditionalAgreementResponse
    {
        public string Doc { get; set; }
        public decimal? DocId { get; set; }
    }
    #endregion DepositAdditionAgreementDoc
}