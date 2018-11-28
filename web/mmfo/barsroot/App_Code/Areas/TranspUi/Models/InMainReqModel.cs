using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for InMainReqModel
/// </summary>
public class InMainReqModel
{
    public string Id { get; set; }
    public string HttpType { get; set; }
    public string TypeName { get; set; }
    public string TypeDesc { get; set; }
    public string ReqAction { get; set; }
    public string ReqUser { get; set; }
    public string FullName { get; set; }
    public DateTime? InsertTime { get; set; }
    public DateTime? ConvertTime { get; set; }
    public string Status { get; set; }
    public DateTime? ProcessedTime { get; set; }
}