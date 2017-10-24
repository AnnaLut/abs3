using System;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.DptAdm.Models
{
    public class DPT_RESULT
    {
        public OracleDecimal res { get; set; }
        public String mess { get; set; }

    }
}