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

namespace cim
{
    public partial class VCimUnboundVmd
    {
        public List<VCimUnboundVmdRecord> SelectDeclarations(Decimal? DIRECT, Boolean FILTER_OKPO, String CUST_OKPO, String SortExpression, int maximumRows, int startRowIndex)
        {
            if (DIRECT.HasValue)
                this.Filter.DIRECT.Equal(DIRECT);
            if (FILTER_OKPO && !String.IsNullOrEmpty(CUST_OKPO))
                this.Filter.OKPO.Equal(CUST_OKPO);
            return this.Select(SortExpression, maximumRows, startRowIndex);
        }
    }
}