using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Summary description for PFU_DEATHS_NOTIFY
/// </summary>

namespace BarsWeb.Areas.Pfu.Models.Grids
{
    public class V_PFU_DEATHS_RECORDS
    {
        public decimal? ID { get; set; }
        public decimal? LIST_ID { get; set; }
        public decimal? REC_NUM { get; set; }
        public string LAST_NAME { get; set; }
        public string FIRST_NAME { get; set; }
        public string FATHER_NAME { get; set; }
        public string OKPO { get; set; }
        public string DOC_NUM { get; set; }
        public string NUM_ACC { get; set; }
        public string BANK_MFO { get; set; }
        public string BANK_NUM { get; set; }
        public DateTime? DATE_DEAD { get; set; }
        public string DEATH_AKT { get; set; }
        public DateTime? DATE_AKT { get; set; }
        public decimal? SUM_OVER { get; set; }
        public string PERIOD { get; set; }
        public DateTime? DATE_PAY { get; set; }
        public decimal? SUM_PAY { get; set; }
        public decimal? TYPE_BLOCK { get; set; }
        public string PFU_NUM { get; set; }
        public string STATE { get; set; }
        public decimal? REST { get; set; }
        public decimal? REST_2909 { get; set; } 
        public DateTime? RESDATE { get; set; }

        public decimal? REF { get; set; }
        public string COMM { get; set; }
        public decimal? SUM_PAYED { get; set; }
    }
}