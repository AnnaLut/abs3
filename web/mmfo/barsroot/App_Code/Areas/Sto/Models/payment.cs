using System;
namespace BarsWeb.Areas.Sto
{
    public class payment
    {
        public decimal IDS { get; set; }
        public decimal ord { get; set; }
        public string tt { get; set; }
        public decimal vob { get; set; }
        public decimal dk { get; set; }
        public string nlsa { get; set; }
        public decimal kva { get; set; }
        public string nlsb { get; set; }            
        public decimal kvb { get; set; } 
        public string mfob { get; set; }            
        public string polu { get; set; }            
        public string nazn { get; set; }       
        public string fsum { get; set; } 
        public string okpo { get; set; } 
        public DateTime DAT1{ get; set; } 
        public DateTime DAT2{ get; set; } 
        public decimal FREQ { get; set; } 
        public decimal WEND { get; set; } 
        public string DR { get; set; } 
        public decimal nd { get; set; }             
        public DateTime? sdate{ get; set; }
        public decimal idd { get; set; }             
        public decimal status { get; set; }   
        public string status_text { get; set; }
        public string govBuyCode { get; set; }
    }
}