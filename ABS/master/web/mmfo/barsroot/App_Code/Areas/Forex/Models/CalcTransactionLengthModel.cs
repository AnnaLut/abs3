using System;
using System.Collections.Generic;
using System.Data.Objects;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CalcTransactionLengthModel
/// </summary>
public class CalcTransactionLengthModel 
{
    public CalcTransactionLengthModel()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DateTime CurrentDate { get; set; }
    public DateTime DateA { get; set; }
    public DateTime DateB { get; set; }

}