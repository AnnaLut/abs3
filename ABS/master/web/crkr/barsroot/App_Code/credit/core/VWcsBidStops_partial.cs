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

namespace credit
{
    public partial class VWcsBidStops
    {
        public List<VWcsBidStopsRecord> SelectBidStops(Decimal? BID_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            return Select();
        }
        public List<VWcsBidStopsRecord> SelectBidSFactors(Decimal? BID_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            this.Filter.TYPE_ID.Equal("FACTOR");
            return Select();
        }
    }
}