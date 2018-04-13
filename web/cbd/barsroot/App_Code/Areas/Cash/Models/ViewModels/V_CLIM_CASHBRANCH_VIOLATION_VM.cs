using System;
using Areas.Cash.Models;

namespace BarsWeb.Areas.Cash.Models.ViewModels
{
    public partial class V_CLIM_CASHBRANCH_VIOLATION_VM : V_CLIM_CASHBRANCH_VIOLATION_MD
    {
        public string ROW_ID = Guid.NewGuid().ToString();

        public String LIM_TYPE = "BRANCH";
    }
}