using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// модель для частичной инкассации
    /// </summary>
    public class PartialCashinModel
    {
        public List<ATMCurrencyListModel> List { get; set; }
        public String Currency { get; set; }
    }
}