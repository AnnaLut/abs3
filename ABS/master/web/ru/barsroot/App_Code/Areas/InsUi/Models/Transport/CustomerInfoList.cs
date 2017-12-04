using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CustomerInfoList
    {
        /// <summary>
        /// Признак юр.особа/фіз.особа
        /// </summary>
        public bool legal { get; set; }
        /// <summary>
        /// ІПН/ОКПО
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// ПІБ/найменування
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// Адреса
        /// </summary>
        public string address { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string birthDate { get; set; }
        /// <summary>
        /// Документ контрагента
        /// </summary>
        public InsuredDocuments document { get; set; }
    }
}