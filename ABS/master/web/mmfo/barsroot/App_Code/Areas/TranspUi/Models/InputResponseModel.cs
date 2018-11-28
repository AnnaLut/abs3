using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InputResponseModel
/// </summary>
public class InputResponseModel
{
    public string ReqId { get; set; }
    public DateTime? InsertTime { get; set; }
    public DateTime? ConvertTime { get; set; }
    public DateTime? SendTime { get; set; }
}