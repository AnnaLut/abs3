using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PaymentData
/// </summary>
public class PaymentData
{
    public string name{get; set;}
    public string flags{get; set;}
    public byte? fli{get; set;}
    public byte? flv { get; set;}
    public byte? dk { get; set;}
    public decimal? sk{get; set;}
    public string nlsa{get; set;}
    public string nlsb{get; set;}
    public short? KV{get; set;}
    public short? KVK{get; set;}
}