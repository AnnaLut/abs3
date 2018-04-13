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

    public partial class VCimCredgraphPayment
    {
        public List<VCimCredgraphPaymentRecord> SelectPayments(Decimal? CONTR_ID, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "dat ASC" : SortExpression));
        }
    }
}