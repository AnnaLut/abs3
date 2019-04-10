using Areas.GDA.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CloseDepositModel
/// </summary>
public class CloseDepositModel
{
    public string processId { get; set; }
    public string objectId { get; set; }
    public SMBDepositOnDemand deposite { get; set; }
}