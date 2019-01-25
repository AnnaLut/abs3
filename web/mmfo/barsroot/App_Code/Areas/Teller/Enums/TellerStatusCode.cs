using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Teller.Enums
{
    /// <summary>
    /// состояние автомата
    /// </summary>
    public enum TellerStatusCode
    {
        Buisy = 0,
        PickUpCash = 1,
        PickUpStored = 2
    }
}