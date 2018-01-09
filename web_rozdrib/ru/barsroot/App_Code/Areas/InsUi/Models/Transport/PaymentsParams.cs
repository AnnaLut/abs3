using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class PaymentsParams
    {
        public Payment payment { get; set; }
        public PaymentDealParams contract { get; set; }
        /*public int contractId { get; set; }
        public string contractCode { get; set; }
        public string contractSalePointExternalId { get; set; }*/
        public string currentUserExternalId { get; set; }
    }
}