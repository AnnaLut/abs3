using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DepositAccountModel
/// </summary>
public class DepositAccountModel
{
    public DateTime? start_date { get; set; }
    public DateTime? close_date { get; set; }
    public string account_number { get; set; }
    public string currency_name { get; set; }
    public decimal? account_balance { get; set; }
    public decimal? currency_id { get; set; }
    public string deposit_code { get; set; }
    public string deposit_name { get; set; }
    public decimal account_id { get; set; }
    public decimal? customer_id { get; set; }
}