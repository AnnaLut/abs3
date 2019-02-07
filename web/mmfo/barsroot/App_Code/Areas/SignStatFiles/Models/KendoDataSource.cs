using System.Collections.Generic;

namespace BarsWeb.Areas.SignStatFiles.Models
{
    public class KendoDataSource<T>
    {
        public IEnumerable<T> Data { get; set; }
        public int Total { get; set; }
    }
}
