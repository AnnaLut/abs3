using System.Collections.Generic;

namespace LcsServices //BarsWeb.Areas.LimitControl.Models
{
    /// <summary>
    /// Розширення для класу Operation
    /// </summary>
    public partial class Operation
    {
        public List<Equivalent> EquivalentList { get; set; }
    }
    public class Equivalent
    {
        public int? Сurrency { get; set; }
        public decimal? Sum { get; set; }
    }
}  
