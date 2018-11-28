using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// модель данных выдержки (витяг)!
    /// </summary>
    public class Extract
    {
        public Int32 Extract_number_id { get; set; }
        public DateTime? EXTRACT_DATE { get; set; }
    }
}