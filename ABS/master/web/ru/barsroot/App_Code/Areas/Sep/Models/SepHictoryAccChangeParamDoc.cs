using System;

namespace BarsWeb.Areas.Sep.Models
{
    public class SepHistoryAccChangeParamDoc
    {
        public string TABNAME { get; set; }
        public string SEMANTIC { get; set; }
        public string PARNAME { get; set; }
        public string VALOLD { get; set; }
        public string VALNEW { get; set; }
        public DateTime ? DAT { get; set; }
        public string ISP { get; set; }
        public string FIO { get; set; } 
    }
}