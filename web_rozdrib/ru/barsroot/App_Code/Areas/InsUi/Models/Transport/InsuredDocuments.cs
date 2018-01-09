using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class InsuredDocuments
    {
        /// <summary>
        /// Тип документу
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// Серія
        /// </summary>
        public string series { get; set; }
        /// <summary>
        /// Номер
        /// </summary>
        public string number { get; set; }
        /// <summary>
        /// Дата документа
        /// </summary>
        public string date { get; set; }
        /// <summary>
        /// Ким виданий
        /// </summary>
        public string issuedBy { get; set; }
    }
}