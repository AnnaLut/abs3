using System.Collections.Generic;

namespace Areas.Finmom.Models
{
    public class KendoGridDs<T>
    {
        public IEnumerable<T> Data { get; set; }
        public decimal Total { get; set; }
    }
}