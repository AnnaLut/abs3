using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class Payments
    {
        /// <summary>
        /// REF
        /// </summary>
        public string number { get; set; }
        /// <summary>
        /// Призначення платежу
        /// </summary>
        public string purpose { get; set; }
    }
}