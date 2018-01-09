using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.Ins
{
    public enum AccessTypes
    {
        User,
        Manager,
        Controller,
        Head
    }

    public enum AccessModes
    {
        View,
        Payment,
        AddAgr,
        Edit
    }

    public static class Common
    {
        # region Публичные свойства
        public static System.Globalization.DateTimeFormatInfo dtfi
        {
            get
            {
                System.Globalization.DateTimeFormatInfo tmp = new System.Globalization.DateTimeFormatInfo();
                tmp.ShortDatePattern = "dd.MM.yyyy";

                return tmp;
            }
        }
        # endregion
    }
}