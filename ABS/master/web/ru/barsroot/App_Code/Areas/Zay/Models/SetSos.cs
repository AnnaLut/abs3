using System;

namespace BarsWeb.Areas.Zay.Models
{
    /// <summary>
    /// -- Удовлетворение заявки
    /// </summary>
    public class SetSos
    {
	    public decimal Id { get; set; }
        public decimal? KursF { get; set; }
        public decimal Sos { get; set; }
        public DateTime? Vdate { get; set; }
        public decimal? CloseType { get; set; }
        public DateTime Fdat { get; set; }
    }
}