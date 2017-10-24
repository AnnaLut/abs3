using System;
using System.Text;

namespace BarsWeb.Areas.Crkr.Models
{
    public class DepositProfile
    {
        public decimal ID { get; set; }
        public decimal RNK { get; set; }
        public string FIO { get; set; }
        public string CLIENTBDATE { get; set; }
        public string KKNAME { get; set; }
        public string PERCENT { get; set; }
        public string BRANCH { get; set; }
        public string NSC { get; set; }
        public string OST { get; set; }
        public string STATUS { get; set; }
        public string DATO { get; set; }
        public string DATL { get; set; }
        public DateTime DOCDATE { get; set; }
        public string IDA { get; set; }
        public string REGISTRYDATE { get; set; }
        public string KV_SHORT { get; set; }
        public string OB22 { get; set; }
        public string REASON_CHANGE_STATUS { get; set; }
        public string DOCTYPE { get; set; }
        public string DOCSERIAL { get; set; }
        public string DOCNUMBER { get; set; }
        public string DOCORG { get; set; }
        public decimal RNK_BUR { get; set; }
        public string FIO_RECEIVER { get; set; }
        public decimal STATE_ID { get; set; }
    }
}