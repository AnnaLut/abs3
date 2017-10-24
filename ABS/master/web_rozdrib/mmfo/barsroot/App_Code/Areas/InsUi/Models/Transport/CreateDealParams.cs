using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CreateDealParams
    {
        /// <summary>
        /// Тип страхового договору
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// Ід. договора в системі EWA
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// Номер відділення
        /// </summary>
        public SalePoints salePoint { get; set; }
        /// <summary>
        /// Ім'я користувача
        /// </summary>
        public User user { get; set; }
        /// <summary>
        /// Страхова компанія
        /// </summary>
        public Tariff tariff { get; set; }
        /// <summary>
        /// Номер договору
        /// </summary>
        public string number { get; set; }
        /// <summary>
        /// Номер договору
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// Дата початку договору(yyyy-MM-dd)
        /// </summary>
        public string dateFrom { get; set; }
        /// <summary>
        /// Дата закінчення договору(yyyy-MM-dd)
        /// </summary>
        public string dateTo { get; set; }
        /// <summary>
        /// Інформація про застраховану особу
        /// </summary>
        public CreateCustomerInfo customer { get; set; }
        /// <summary>
        /// Страхова премія (у випадку фіксованої премії)
        /// </summary>
        public decimal baseTariff { get; set; }
        /// <summary>
        /// Сума договору
        /// </summary>
        public decimal payment { get; set; }
        public decimal? insuranceAmount { get; set; }
        /// <summary>
        /// Платіжний документ в АБС
        /// </summary>
        public List<Payment> payments { get; set; }
        public string state { get; set; }
    }
}