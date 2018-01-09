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

namespace Bars.Ins
{
    public partial class VInsDealStsHistory
    {
        public List<VInsDealStsHistoryRecord> SelectDealStsHistory(Decimal? DEAL_ID)
        {
            this.Filter.DEAL_ID.Equal(DEAL_ID);
            return this.Select();
        }
    }
}