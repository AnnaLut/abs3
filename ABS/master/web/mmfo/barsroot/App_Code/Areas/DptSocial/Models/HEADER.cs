using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Bars.Areas.DptSocial.Models
{
    public class HEADER
    {
        public decimal ID { get; set; }
        public string FILE_NAME { get; set; }
        public string MAIN_FILIAL_NUMBER { get; set; }   //      5
        public string SUB_FILIAL_NUMBER { get; set; }    //      5
        public string FILE_PAYOFFDATE { get; set; }     //      2
        public string SEPARATOR { get; set; }          //      1
        public string REGION_CODE { get; set; }         //      3
        public decimal HEADER_LENGRH { get; set; }        // 3
        public DateTime DTCREATED { get; set; }          // 8
        public decimal NUM_INFO { get; set; }         // 6
        public string MFO_A { get; set; }                // 9
        public string NLS_A { get; set; }                // 9
        public string MFO_B { get; set; }                // 9
        public string NLS_B { get; set; }                // 9
        public decimal DK { get; set; }                  // 1
        public decimal SUM { get; set; }             // 19
        public decimal TYP { get; set; }             // 2
        public string NUMBER { get; set; }               // 10
        public string ADDEXIST { get; set; }            // 1
        public string NMK_A { get; set; }                // 27
        public string NMK_B { get; set; }                // 27
        public string NAZN { get; set; }             // 160
        public decimal BRANCH_CODE { get; set; }     // 5
        public decimal DPT_CODE { get; set; }            // 3
        public string EXEC_ORD { get; set; }         // 10
        public string KS_EP { get; set; }               // 32
    }
}