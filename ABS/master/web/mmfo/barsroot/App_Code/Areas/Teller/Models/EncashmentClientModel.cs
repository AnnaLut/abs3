using BarsWeb.Areas.Teller.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Model
{
    /// <summary>
    /// Модель передаваемая на сервер для формирования окна для инкасации
    /// TellerCurrentRole:
    ///     темпокасса или АТМ
    /// </summary>
    public class EncashmentClientModel
    {
        public String EncashmentType { get; set; }

        public IEnumerable<TellerCurrency> Currency { get; set; }
        public TellerCurrentRole Role { get; set; }
        public String NonAmount { get; set; }
        public List<NonAtmAmount> NonAtmAmount { get; set; }
        public Int32 ToxFlag { get; set; }
    }
}