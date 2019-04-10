using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class BackDepositDemand
{
    public string ProcessId { get; set; }
    //public string trancheId { get; set; }
    public string StateCode { get; set; }
    public string Dbo { get; set; }
    public string DboDate { get; set; }
    public string Rnk { get; set; }
    public string Okpo { get; set; }
    public string Name { get; set; }
    public string Type {get; set; }
    public string StateName { get; set; }
    //public BackDepositDemand Type { get; set; }
}

public enum BackDepositDemandType { NEW_ON_DEMAND, CLOSE_ON_DEMAND, CHANGE_CALCULATION_TYPE }