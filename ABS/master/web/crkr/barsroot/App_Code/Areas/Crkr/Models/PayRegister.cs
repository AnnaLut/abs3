using System;

namespace BarsWeb.Areas.Crkr.Models
{
    public class PayRegister
    {
        public string ID { get; set; }
        public DateTime DATE_VAL_REG { get; set; }
        public string FIO_COMPEN { get; set; }
        public string FIO_CLIENT { get; set; }
        public string DOCSERIAL { get; set; }
        public string DOCNUMBER { get; set; }
        public string MFO { get; set; }
        public string NLS { get; set; }
        public string AMOUNT { get; set; }
        public string REGDATE { get; set; }
        public string CHANGEDATE { get; set; }
        public string BRANCH { get; set; }
        public string STATE_NAME { get; set; }
        public string MSG { get; set; }
        public string REF_OPER { get; set; }
    }
}