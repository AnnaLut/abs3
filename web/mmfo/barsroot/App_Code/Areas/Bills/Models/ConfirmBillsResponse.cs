using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных подтверждения векселя!
    /// </summary>
    public class ConfirmBillsResponse
    {
        public Int32 EXP_ID { get; set; }
        public String BILL_NO { get; set; }
    }
}