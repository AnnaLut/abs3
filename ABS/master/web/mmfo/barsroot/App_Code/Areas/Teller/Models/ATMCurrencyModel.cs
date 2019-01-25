using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// код валюты и количество
    /// </summary>
    public class ATMCurrencyModel
    {
        public String Cur_code { get; set; }
        public Int32 Amount { get; set; }
    }
}