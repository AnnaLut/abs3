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

    public partial class VCimBoundPayments
    {
        public List<VCimBoundPaymentsRecord> SelectInBoundPayments(Decimal? CONTR_ID, Decimal? CONTR_TYPE, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);
            this.Filter.DIRECT.Equal(0);
            if (CONTR_TYPE.HasValue && CONTR_TYPE == 3)
                this.Filter.PAY_FLAG.Equal(0);
            else
            {
                this.Filter.PAY_FLAG.Greater(1);
                this.Filter.PAY_FLAG.Less(4);
            }

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "vdat desc, bound_id desc" : SortExpression));
        }

        public List<VCimBoundPaymentsRecord> SelectOutBoundPayments(Decimal? CONTR_ID, Decimal? CONTR_TYPE, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);
            this.Filter.DIRECT.Equal(1);
            if (CONTR_TYPE.HasValue && CONTR_TYPE == 3)
                this.Filter.PAY_FLAG.Equal(0);
            else
            {
                this.Filter.PAY_FLAG.Greater(1);
                this.Filter.PAY_FLAG.Less(4);
            }

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "vdat desc, bound_id desc" : SortExpression));
        }

        public List<VCimBoundPaymentsRecord> SelectInBoundAddPayments(Decimal? CONTR_ID, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);
            this.Filter.DIRECT.Equal(0);
            List<decimal?> flags = new List<decimal?>();
            flags.Add(1);
            flags.Add(4);
            flags.Add(5);
            flags.Add(6);
            this.Filter.PAY_FLAG.In(flags);

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "vdat desc, bound_id desc" : SortExpression));
        }

        public List<VCimBoundPaymentsRecord> SelectOutBoundAddPayments(Decimal? CONTR_ID, String SortExpression)
        {
            this.Filter.CONTR_ID.Equal(CONTR_ID);
            this.Filter.DIRECT.Equal(1);
            List<decimal?> flags = new List<decimal?>();
            flags.Add(1);
            flags.Add(4);
            flags.Add(5);
            flags.Add(6);
            this.Filter.PAY_FLAG.In(flags);

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "vdat desc, bound_id desc" : SortExpression));
        }
    }
}