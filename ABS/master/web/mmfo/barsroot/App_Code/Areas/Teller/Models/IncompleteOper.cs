using System;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// Модель незавершенной операции
    /// </summary>
    public class IncompleteOper
    {
        /// <summary>
        /// ИД операции АТМ
        /// </summary>
        public String ATM_ID { get; set; }

        /// <summary>
        /// Время операции АТМ
        /// </summary>
        public DateTime? ATM_TIME { get; set; }

        /// <summary>
        /// Тип операции АТМ
        /// </summary>
        public String ATM_OP_TYPE { get; set; }

        /// <summary>
        /// Валюта операции АТМ
        /// </summary>
        public String ATM_CUR { get; set; }

        /// <summary>
        /// Сумма операции АТМ
        /// </summary>
        public Decimal? ATM_AMN { get; set; }

        /// <summary>
        /// Номер пользователя АТМ
        /// </summary>
        public Int64? ATM_USER { get; set; }

        /// <summary>
        /// Тип операции Теллер
        /// </summary>
        public String TEL_OP_TYPE { get; set; }

        /// <summary>
        /// Сумма операции Теллер
        /// </summary>
        public Decimal? TEL_AMN { get; set; }

        /// <summary>
        /// Валюта операции Теллер
        /// </summary>
        public String TEL_CUR { get; set; }

        /// <summary>
        /// Пользователь Теллера
        /// </summary>
        public String TEL_USER { get; set; }

        /// <summary>
        /// Время операции Теллера
        /// </summary>
        public DateTime? TEL_TIME { get; set; }

        /// <summary>
        /// ИД незавершенной операции Теллера
        /// </summary>
        public Int64? TEL_ID { get; set; }
    }
}