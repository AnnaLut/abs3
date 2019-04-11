using System;

namespace BarsWeb.Areas.Subvention.Models
{
    public class Document
    {
        public string ExtReqId { set; get; }
        public string ReceiverAccNum { set; get; }
        public string ReceiverName { set; get; }
        public string ReceiverIdentCode { set; get; }
        public string ReceiverBankCode { set; get; }
        public decimal? Amount { set; get; }
        public string Purpose { set; get; }
        public string Signature { set; get; }
        public decimal? ExtRowId { set; get; }
        public decimal? Ref { set; get; }
        public string Err { set; get; }
        public decimal? FeeRate { set; get; }
        public decimal? ReceiverRnk { set; get; }
        public string PayerAccNum { set; get; }
        public string PayerBankCode { set; get; }
        public short? PayType { set; get; }
        public DateTime? SysTime { set; get; }
        public int State
        {
            get
            {
                return null == Ref ? -1 : 0;
            }
        }
    }
}