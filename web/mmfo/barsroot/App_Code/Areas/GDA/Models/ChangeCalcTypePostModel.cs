using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ChangeCalcTypePostModel
/// </summary>
public class ChangeCalcTypePostModel
{
    public int ProcessId { get; set; }
    public int CalculationType { get; set; }
    public string Comment { get; set; }

    public string CanSave { get; set; }
}