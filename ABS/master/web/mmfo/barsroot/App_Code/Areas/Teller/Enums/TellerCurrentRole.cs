using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.Teller.Enums
{
    /// <summary>
    /// Текущая роль пользователя
    /// </summary>
    public enum TellerCurrentRole
    {
        None = 0,
        Teller = 1,
        Tempockassa = 2
    }
}