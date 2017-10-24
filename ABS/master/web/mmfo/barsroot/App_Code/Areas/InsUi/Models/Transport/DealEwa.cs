using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class DealEwa
    {
        public string type { get; set; }
        public SalePointsEwa salePoint { get; set; }
        public UserEwa user { get; set; }
        public TariffEwa tariff { get; set; }
        public string date { get; set; }
        public string dateFrom { get; set; }
        public string dateTo { get; set; }
        public CustomerEwa customer { get; set; }
        public InsuranceObjEwa insuranceObject { get; set; }
        public string state { get; set; }
        public List<CustomFields> customFields { get; set; }
        public decimal? coverageDays { get; set; }
    }
}