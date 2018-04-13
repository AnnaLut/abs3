using System;

namespace BarsWeb.Areas.Escr.Models
{
    public class EscrSendParam
    {
        public DateTime dateFrom { get; set; }
        public DateTime dateTo { get; set; }
        public decimal registerId { get; set; }
    }
}