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

namespace cim
{

    public partial class VCimCredgraphPeriod
    {
        public List<VCimCredgraphPeriodRecord> SelectPeriods(Decimal? CONTR_ID, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "end_date ASC" : SortExpression));
        }
    }
}