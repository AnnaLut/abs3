using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CreateFilterResult
/// </summary>
public class CreateFilterResult
{
    public CreateFilterResult()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public string FilterName { get; set; }
    public string WHERE_CLAUSE { get; set; }
    public string FilterTypeDescription { get; set; }
}