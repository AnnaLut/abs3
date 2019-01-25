using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DateTimeHelper
/// </summary>
public class DateTimeHelper
{
    public DateTimeHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static  bool IsTimeBetween(string timeFrom, string timeTo)
    {
        try
        {

            if (string.IsNullOrEmpty(timeFrom) || string.IsNullOrEmpty(timeTo))
                throw new ArgumentNullException(timeFrom, "timeFrom or timeTo is null or Empty");
            DateTime from = DateTime.ParseExact(timeFrom, "HH:mm:ss",
                                        CultureInfo.InvariantCulture);
            DateTime to = DateTime.ParseExact(timeTo, "HH:mm:ss",
                                        CultureInfo.InvariantCulture);

            return from < DateTime.Now && DateTime.Now < to;

        }
        catch (Exception ex)
        {
            throw new Exception("can not pars to dateTime variables timeFrom: {0}, or timeTo{1}");
        }
    }
}