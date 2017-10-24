using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FullPaymentData
/// </summary>
public class FullPaymentData
{
    public decimal SWREF { get; set; }
    public string SLCV { get; set; }
    public string TT { get; set; }
    public bool IS_IMPMSGDOCGETPARAMS { get; set; }
    public string SENDER { get; set; }

    public byte g_sUserF { get; set; }
    public bool is_TransactionType { get; set; }
}