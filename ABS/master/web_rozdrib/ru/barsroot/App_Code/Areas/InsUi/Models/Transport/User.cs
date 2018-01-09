using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class User
    {
        /// <summary>
        /// Прізвище
        /// </summary>
        public string lastName { get; set; }
        /// <summary>
        /// Ім"я
        /// </summary>
        public string firstName { get; set; }
        /// <summary>
        /// По-батькові
        /// </summary>
        public string middleName { get; set; }
        /// <summary>
        /// ОКПО
        /// </summary>
        public string code { get; set; }
        public string externalId { get; set; }
        public string email { get; set; }
    }
}