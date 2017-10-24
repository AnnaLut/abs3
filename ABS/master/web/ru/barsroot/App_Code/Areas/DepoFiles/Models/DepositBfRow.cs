using System;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class DepositBfRow
    {
        public decimal? CUST_ID { get; set; }
        public decimal? ACC_ID { get; set; }
        public string ACC_NUM { get; set; }
        public string ACC_TYPE { get; set; }
        public string ASVO_ACCOUNT { get; set; }
        public string CUST_NAME { get; set; }
        public string CUST_CODE { get; set; }
        public string DOC_SERIAL { get; set; }
        public string DOC_NUMBER { get; set; }
        public string DOC_ISSUED { get; set; }
        public DateTime CUST_BDAY { get; set; }
        public DateTime DOC_DATE { get; set; }
        public string BRANCH_NAME { get; set; }
    }
}