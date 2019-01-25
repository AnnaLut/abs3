using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// номиналы купюр, код валюты и их количество в АТМ
    /// </summary>
    public class ATMCurrencyListModel
    {
        public String Cur_code { get; set; }
        public String Nominal { get; set; }
        public String Rev { get; set; }
        public Int32 Count { get; set; }
    }
}