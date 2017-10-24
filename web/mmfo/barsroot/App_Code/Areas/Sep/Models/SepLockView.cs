using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace BarsWeb.Areas.Sep.Models
{
    public class SepLockView
	{
        public decimal? REC /*recid*/{ get; set; }
        public string MFOA/*mfoa*/ { get; set; }
        public string MFOB/*mfob*/ { get; set; }
        public string NLSA/*nlsa*/ { get; set; }
        public string NLSB/*nlsb*/ { get; set; }
        public string NAM_A/*nama*/ { get; set; }
        public string NAM_B/*namb*/ { get; set; }
        public decimal? S/*s*/ { get; set; }
        public string SPROP/*sprop*/ { get; set; }
        public string LCV/*lcv*/ { get; set; }
        public string NAZN/*nazn*/ { get; set; }
        public DateTime? DAT_A/*data*/ { get; set; }
        public DateTime? DATP/*datp*/ { get; set; }
        public string FN_A/*fna*/ { get; set; }
        public string ID_A/*ida*/ { get; set; }
        public string ID_B/*idb*/ { get; set; }
        public string DAT_PROP/*datprop*/ { get; set; }
        public string BANK_A/*banka*/ { get; set; }
        public string BANK_B/*bankb*/ { get; set; }
        public string VOB_NAME/*vobname*/ { get; set; }
        public DateTime? DAT_2/*dat_2*/ { get; set; }
        public DateTime? DATK/*datk*/ { get; set; }
    }
}