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
    public partial class VWcsBidPartners
    {
        public List<VWcsBidPartnersRecord> SelectBidPartners(Decimal? BID_ID, String TYPE_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            this.Filter.TYPE_ID.Equal(TYPE_ID);
            return Select();
        }
        public List<VWcsBidPartnersRecord> SelectBidPartner(Decimal? BID_ID, Decimal? PARTNER_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            this.Filter.PARTNER_ID.Equal(PARTNER_ID);
            return Select();
        }
    }
}