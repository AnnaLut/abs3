using System;

namespace Bars.WebServices.XRM.Services.SKRN.Models
{
    public class OpenNewDealRequest
    {
        /// <summary>
        /// ID сейфу
        /// </summary>
        public Int64? NSk { get; set; }
        /// <summary>
        /// номер договору (символьний для друку)
        /// </summary>
        public string NDoc { get; set; }
        /// <summary>
        /// вид сейфу
        /// </summary>
        public Int64? OSk { get; set; }
        /// <summary>
        /// номер ключа
        /// </summary>
        public String KeyNumber { get; set; }
        /// <summary>
        /// кількість виданих клієнту ключів
        /// </summary>
        public int? KeyCount { get; set; }
        /// <summary>
        /// ID тарифу
        /// </summary>
        public int? TarifId { get; set; }
        /// <summary>
        /// дата початку договору
        /// </summary>
        public DateTime? DealStartDate { get; set; }
        /// <summary>
        /// дата кінця договору
        /// </summary>
        public DateTime? DealEndDate { get; set; }
        /// <summary>
        /// RNK клієнта
        /// </summary>
        public Int64? Rnk { get; set; }
    }

    public class OpenNewBoxResponse
    {
        /// <summary>
        /// Номер відкритого договору
        /// </summary>
        public Int64? Nd { get; set; }
    }
}