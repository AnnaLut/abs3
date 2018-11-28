using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных ожидаемого взыскателя!
    /// </summary>
    public class ExpectedReceivers
    {
        public Int32 EXP_ID { get; set; }
        public Int32? RESOLUTION_ID { get; set; }
        public String RECEIVER_NAME { get; set; }
        public String RECEIVER_CODE { get; set; }
        public String RECEIVER_DOC_NO { get; set; }
        public String CURRENCY_ID { get; set; }
        public Decimal? AMOUNT { get; set; }
        public String STATE { get; set; }
        public String RES_CODE { get; set; }
        public DateTime RES_DATE { get; set; }
    }
}