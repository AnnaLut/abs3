using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BarsWeb.Areas.Dcp.Models
{
    public class ccDoc
    {
        public decimal? REF { get; set; }
        public string TT { get; set; }
        public decimal? DK { get; set; }
        public decimal? VOB { get; set; }
        public string ND { get; set; }
        public DateTime DOC { get; set; }
        public DateTime POS { get; set; }
        public DateTime VAL1 { get; set; }
        public DateTime VAL2 { get; set; }
        public string NLSA { get; set; }
        public string NAMA { get; set; }
        public string MFOA { get; set; }
        public string NBA { get; set; }
        public decimal? KVA { get; set; }
        public decimal? SA { get; set; }
        public string OKPOA { get; set; }
        public string NLSB { get; set; }
        public string NAMB { get; set; }
        public string MFOB { get; set; }
        public string NBB { get; set; }
        public decimal? KVB { get; set; }
        public decimal? SB { get; set; }
        public string OKPOB { get; set; }
        public string NAZN { get; set; }
        public string DREC { get; set; }
        public string OPERID { get; set; }
        public string ISSIGN { get; set; }
        public decimal? SK { get; set; }
        public decimal? PRTY { get; set; }
    }
}




/*ccDoc.SetDoc(nRef, sTT, 1, IifN(VOB=NUMBER_Null, 6, VOB), ND, dDAT, dDAT, dDAT, dDAT, 
     NLSA, NAMA, MFOA, '', nBaseVal, S*100, OKPOA, 
     NLSB, NAMB, MFOB, '', nBaseVal, S*100, OKPOB, 
     NAZN, sDrec, GetIdOper(), '', NUMBER_Null, nPrty)
*/