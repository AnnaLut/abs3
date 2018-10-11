using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetFileFromCl
/// </summary>
namespace BarsWeb.Areas.Zay.Models
{
    public class GetFileFromClModel
    {
        public GetFileFromClModel()
        {

        }
        public long ID { get; set; }
        public string ADR{get;set;}
        public string NMK { get; set; } 
        public string BANK_NAME { get; set; } 
        public string ADDRESS_BANK { get; set; }  
        public string PHONE { get; set; } 
        public double KOM { get; set; }  
        public string FNAMEKB { get; set; }
    }
}