using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// Модель списка валют и их количества для темпокассы
    /// </summary>
    public class NonAtmAmount
    {
        public String Cur_code { get; set; }
        public Decimal Non_atm_amount { get; set; }
    }
}