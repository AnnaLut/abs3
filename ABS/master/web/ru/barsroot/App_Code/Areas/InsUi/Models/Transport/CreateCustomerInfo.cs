using System;

namespace BarsWeb.Areas.InsUi.Models.Transport
{
    public class CreateCustomerInfo
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
        /// Наявність ОКПО
        /// </summary>
        public bool dontHaveCode { get; set; }
        /// <summary>
        /// ПІБ/найменування
        /// </summary>
        public string name { get; set; }
        public string nameLast { get; set; }
        public string nameFirst { get; set; }
        public string nameMiddle { get; set; }
        /// <summary>
        /// Адреса
        /// </summary>
        public string address { get; set; }
        /// <summary>
        /// Контактний номер телефона
        /// </summary>
        public string phone { get; set; }
        /// <summary>
        /// Контактний E-mail
        /// </summary>
        public string email { get; set; }
        /// <summary>
        /// Дата народження
        /// </summary>
        public string birthDate { get; set; }
        /// <summary>
        /// Документ контрагента
        /// </summary>
        public InsuredDocuments document { get; set; }
    }
}