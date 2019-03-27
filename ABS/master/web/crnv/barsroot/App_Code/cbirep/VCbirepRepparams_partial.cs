/*
    AUTOGENERATED! Do not modify this code.
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web.Configuration;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace Bars.ObjLayer.CbiRep
{
    public partial class VCbirepRepparams
    {
        public VCbirepRepparamsRecord FindRepByRepID(Decimal? REP_ID)
        {
            this.Filter.REP_ID.Equal(REP_ID);
            List<VCbirepRepparamsRecord> tab = this.Select();

            if (tab.Count == 0) throw new Bars.Exception.BarsException(String.Format("Звіту № {0} не знайдено", REP_ID.ToString()));
            else return tab[0];
        }
        public VCbirepRepparamsRecord FindRepByKodZ(Decimal? KODZ)
        {
            this.Filter.KODZ.Equal(KODZ);
            List<VCbirepRepparamsRecord> tab = this.Select();

            if (tab.Count == 0) throw new Bars.Exception.BarsException(String.Format("Звіту № {0} не знайдено", KODZ.ToString()));
            else return tab[0];
        }
    }
}