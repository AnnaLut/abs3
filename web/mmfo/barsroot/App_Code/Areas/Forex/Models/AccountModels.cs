using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AccountModels
/// </summary>
/// 
namespace BarsWeb.Areas.Forex.Models
{
    public class AccountModels
    {     
        public decimal REF { get; set; }
        public DateTime? FDAT { get; set; }
        public string TT { get; set; }
        public decimal? SDn { get; set; }
        public decimal? SKn { get; set; }
        public decimal? SOS { get; set; }
        public string NMS { get; set; }
        public string NLS { get; set; }
        public decimal? KV { get; set; }
        public decimal? Dig { get; set; }       
    }
}