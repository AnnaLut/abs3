using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Bills.Model
{
    /// <summary>
    /// Модель используемая для формирование строки url для Kendo grid (список найденных клиентов по РНК)
    /// </summary>
    public class CustomerViewModel
    {
        public String Param { get; set; }
        public String SqlType { get; set; }
        public Int32 Count { get; set; }
    }
}