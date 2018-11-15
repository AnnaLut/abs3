using Newtonsoft.Json;
using System;

namespace Bars.EAD.Structs.Params
{
    /// <summary>
    /// Параметри - Данные документа
    /// </summary>
    public class DocumentData
    {
        [JsonProperty("RNK")]
        public UInt64? Rnk;
        [JsonProperty("doc_id")]
        public String DocPrintNumber;
        [JsonProperty("doc_type")]
        public String StructCode;
        [JsonProperty("doc_request_number")]
        public String DocRequestNumber;
        [JsonProperty("agr_code")]
        public Double? AgreementID;
        [JsonProperty("agr_type")]
        public String AgrType;
        [JsonProperty("account_type")]
        public String AccountType;
        [JsonProperty("account_number")]
        public String AccountNumber;
        [JsonProperty("account_currency")]
        public String AccountCurrency;

        public DocumentData(String DocPrintNumber)
        {
            this.DocPrintNumber = DocPrintNumber;
        }
        public DocumentData(Decimal rnk, Double? AgreementID, String StructCode)
        {
            this.Rnk = Convert.ToUInt64(rnk);
            this.AgreementID = AgreementID;
            this.StructCode = StructCode;
        }
        public DocumentData(Decimal rnk, Double? agreementID, String structCode, String docRequestNumber, String agrType, String accountType, String accountNumber, String accountCurrency)
        {
            this.Rnk = Convert.ToUInt64(rnk);
            this.AgreementID = agreementID;
            this.StructCode = structCode;
            this.DocRequestNumber = docRequestNumber;
            this.AgrType = agrType;
            this.AccountType = accountType;
            this.AccountNumber = accountNumber;
            this.AccountCurrency = accountCurrency;
        }
    }
}