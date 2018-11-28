using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных взыскателя для отображения со списком векселей!
    /// </summary>
    public class ReceiversForBills
    {
        public Int32 EXP_ID { get; set; }
        public String NAME { get; set; }
        public String INN { get; set; }
        public Decimal? EXPECTED_AMOUNT { get; set; }
        public String DOC_NO { get; set; }
        public String DOC_WHO { get; set; }
        public String STATUS { get; set; }
        public Boolean EnableButton = false;
    }
}