using System;

namespace BarsWeb.Areas.Crkr.Models
{
    public class CrcaProfile
    {
        public string ID { get; set; }
        public string FIO { get; set; }


        public DateTime? CLIENTBDATE { get; set; }
        public string DOCTYPE { get; set; }
        public string DOCSERIAL { get; set; }
        public string DOCNUMBER { get; set; }
        public DateTime? DOCDATE { get; set; }
        public string FULLADDRESS { get; set; }
        public string ICOD { get; set; }
        public string BRANCH { get; set; }
        public DateTime? REGISTRYDATE { get; set; }
        public string NSC { get; set; } //Номер рахунку АСВО

        private string _ost = null;
        public decimal OST { get; set; }

        public string KV { get; set; }
        public string KV_SHORT { get; set; }
        public DateTime? DATO { get; set; }
        public string OB22 { get; set; }
        public decimal ACTUAL_STATE { get; set; }
        public decimal STATE_ID { get; set; }
        public string STATUS { get; set; }

        private readonly string _document = null;

        public string DOCUMENT
        {
            get
            {
                if(_document == null)
                    return DOCSERIAL + " " + DOCNUMBER;
                return _document;
            }
        }

        public string KK { get; set; }
    }
}