using System;
using System.ComponentModel;

namespace BarsWeb.Areas.CRSOUR.ViewModels
{
    /// <summary>
    /// Заявка
    /// </summary>
    public class SimpleClaim
    {
        [DisplayName("ID заявки")]
        public decimal? Id { get; set; }

        [DisplayName("Тип заявки/зміни")]
        public string ClaimType { get; set; }

        [DisplayName("Номер угоди")]
        public string DealNumber { get; set; }

        [DisplayName("Продавець")]
        public string LenderCode { get; set; }

        [DisplayName("Покупець")]
        public string BorrowerCode { get; set; }

        [DisplayName("Дата заключення угоди")]
        public DateTime? StartDate { get; set; }

        [DisplayName("Дата погашення угоди")]
        public DateTime? EndDate { get; set; }

        [DisplayName("Сума")]
        public decimal? Sum { get; set; }

        [DisplayName("Валюта")]
        public string Currency { get; set; }

        [DisplayName("Початок дії ставки")]
        public DateTime? RateDate { get; set; }

        [DisplayName("Відсоткова ставка")]
        public decimal? Rate { get; set; }

        [DisplayName("Коментар Аллегро")]
        public string Comment { get; set; }
     
        /// <summary>
        /// Помечать поле EndDate в гриде цветом
        /// </summary>
        public decimal? EndDateFlag { get; set; }
        
        /// <summary>
        /// Помечать поле Sum в гриде цветом
        /// </summary>
        public decimal? SumFlag { get; set; }
        
        /// <summary>
        /// Помечать поле RateDate в гриде цветом
        /// </summary>
        public decimal? RateDateFlag { get; set; }
        
        /// <summary>
        /// Помечать Rate поле в гриде цветом
        /// </summary>
        public decimal? RateFlag { get; set; }
    }
}
