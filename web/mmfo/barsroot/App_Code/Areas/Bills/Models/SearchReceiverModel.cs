using System;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель поиска решения!
    /// </summary>
    public class SearchReceiverModel
    {
        public DateTime ResolutionDate { get; set; }
        public String ResolutionNumber { get; set; }
        public String Err { get; set; }
    }
}