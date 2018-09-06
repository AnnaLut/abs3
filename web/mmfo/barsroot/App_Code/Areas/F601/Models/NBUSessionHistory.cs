using System;

namespace BarsWeb.Areas.F601.Models
{
    /// <summary>
    /// Історія сеансів передчі 601 звіту в НБУ
    /// </summary>
    public class NBUSessionHistory
    {
        public decimal? ID { get; set; }
        public decimal? REPORT_ID { get; set; } // реф на материнську таблицю NBUReportInstance
        public decimal? OBJECT_ID { get; set; } // реф на дочірню таблицю
        public decimal? OBJECT_TYPE_ID { get; set; } // тип об'єкту даних що містиься в дочірній таблиці
        public string OBJECT_TYPE_NAME { get; set; } // назва типу об'єкту даних що містиься в дочірній таблиці
        public string OBJECT_KF { get; set; } // код філії до якої належить об'єкт даних що містиься в дочірній таблиці
        public string OBJECT_CODE { get; set; } // № договору
        public string OBJECT_NAME { get; set; } // назва договору
        public DateTime? SESSION_CREATION_TIME { get; set; } //Дата створення сесії
        public DateTime? SESSION_ACTIVITY_TIME { get; set; } //Дата відправки? сесії
        public decimal? SESSION_TYPE_ID { get; set; } // код типу сесії
        public string SESSION_TYPE_NAME { get; set; } // назва типу сесії
        public decimal? STATE_ID { get; set; } // Код результату обробки
        public string SESSION_STATE { get; set; } // Назва результату обробки
        public string SESSION_DETAILS { get; set; } // Текст результату обробки
    }
}