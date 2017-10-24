using System;

namespace Areas.Pfu.Models
{
    public class RecBlockedResult
    {
        public decimal REF { get; set; } // Референс документу
        public string TT { get; set; }	// Код операції
        public string DOC_DATE { get; set; }    // Дата документу
        public decimal FILE_ID { get; set; }    //        ID реєстру
        public decimal ID { get; set; }
        public string MFO { get; set; } //        МФО
        public string NLS { get; set; } //        Номер рахунку отримувача
        public string OKPO { get; set; }    // ІНН
        public string FIO { get; set; } // ПІП
        public decimal? SUMA { get; set; }  //   Сума
        public int? SOS { get; set; }   // Стан оплати документу
        public decimal? GROUPID { get; set; }   // Група візування
        public string USERNAME { get; set; }    // Користувач
        public string GROUPNAME { get; set; }	// Назва групи візування
    }
}
