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
    public partial class VWcsBidStates
    {
        public List<VWcsBidStatesRecord> SelectDispBidStates(Decimal? BID_ID, String SortExpression)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            this.Filter.IS_DISP.Equal(1);
            return Select(SortExpression);
        }
        public Boolean HasState(Decimal? BID_ID, String STATE_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            this.Filter.STATE_ID.Equal(STATE_ID);
            
            return Select().Count > 0 ? true : false;
        }
    }
}