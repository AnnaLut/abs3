using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sberutl.Models
{
    public class OBPC_SALARY_IMPORT_LOG
    {
        public Int32 FILE_ID { get; set; }
        public String FILE_NAME { get; set; }
        public DateTime CRT_DATE { get; set; }
        public Decimal? REF { get; set; }
        public String NLS { get; set; }
        public String FIO { get; set; }
        public String INN { get; set; }
        public Decimal SUMMA { get; set; }
        public String STATUS { get; set; }
        public String ERROR { get; set; }
        public String LINK { get; set; }
    }
}
