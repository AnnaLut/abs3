using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepFileDocParams
    {
        public string FileName { get; set; }
        public string FileCreated { get; set; }
        public string AccessFlags { get; set; }
        public string Mode { get; set; }
        public bool IsIncoming { get; set; }
        public bool PaymentStateFlag { get; set; }
      
        public int? nn { get; set; }
        public int? kv { get; set; }
        
    }
}