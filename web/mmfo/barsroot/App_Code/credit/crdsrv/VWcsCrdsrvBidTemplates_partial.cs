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
    public partial class VWcsCrdsrvBidTemplates
    {
        public List<VWcsCrdsrvBidTemplatesRecord> SelectCrdsrvBidTemplates(Decimal? BID_ID, String WS_ID)
        {
            this.Filter.BID_ID.Equal(BID_ID);
            List<String> ws = new List<String>(new string[] { WS_ID, "MAIN" });
            this.Filter.WS_ID.In(ws);
            return Select();
        }
    }
}