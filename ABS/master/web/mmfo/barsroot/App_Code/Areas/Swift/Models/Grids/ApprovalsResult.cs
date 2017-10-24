using System;

/// <summary>
/// Summary description for ApprovalsResult
/// </summary>
public class ApprovalsResult
{
    public decimal SWREF { get; set; }
    public decimal? MT { get; set; }
    public string TRN { get; set; }
    public string SENDER_BIC { get; set; }
    public string SENDER_NAME { get; set; }
    public string RECEIVER_BIC { get; set; }
    public string RECEIVER_NAME { get; set; }
    public string CURRENCY { get; set; }
    public decimal? AMOUNT { get; set; }
    public DateTime? VDATE { get; set; }
    public decimal REF { get; set; }
    public string NEXTVISAGRP { get; set; }
    public decimal? EDITSTATUS { get; set; }
}