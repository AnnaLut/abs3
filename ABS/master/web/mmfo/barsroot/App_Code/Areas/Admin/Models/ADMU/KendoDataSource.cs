
using System;
using System.Collections.Generic;

namespace BarsWeb.Areas.Admin.Models.ADMU
{
    public class KendoDataSource<T>
    {
        public IEnumerable<T> Data { get; set; }
        public int Total { get; set; }
    }
}

