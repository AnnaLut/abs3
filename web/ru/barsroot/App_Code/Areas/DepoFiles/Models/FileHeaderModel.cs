using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.DepoFiles.Models
{
    public class FileHeaderModel
    {
        public decimal id { get; set; }
        public string filename { get; set; }
        public string mainFilialNumber { get; set; }   //      5
        public string subFilialNumber { get; set; }    //      5
        public string filePayoffDate { get; set; }     //      2
        public string separator { get; set; }          //      1
        public string regionCode { get; set; }         //      3
        public decimal headerLength { get; set; }        // 3
        public DateTime dtCreated { get; set; }          // 8
        public decimal numInfo { get; set; }         // 6
        public string MFO_A { get; set; }                // 9
        public string NLS_A { get; set; }                // 9
        public string MFO_B { get; set; }                // 9
        public string NLS_B { get; set; }                // 9
        public decimal DK { get; set; }                  // 1
        public decimal Sum { get; set; }             // 19
        public decimal Typ { get; set; }             // 2
        public string Number { get; set; }               // 10
        public string AddExists { get; set; }            // 1
        public string NMK_A { get; set; }                // 27
        public string NMK_B { get; set; }                // 27
        public string Nazn { get; set; }             // 160
        public decimal Branch_code { get; set; }     // 5
        public decimal Dpt_code { get; set; }            // 3
        public string Exec_ord { get; set; }         // 10
        public string KS_EP { get; set; }               // 32
    }
}