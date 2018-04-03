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

    public partial class VCimAllContracts
    {
        public List<VCimAllContractsRecord> SelectContracts(Decimal? contr_type, Decimal? contr_kv, Decimal? contr_status, String SortExpression, int maximumRows, int startRowIndex)
        {
            if (contr_type.HasValue && contr_type != -1)
                this.Filter.CONTR_TYPE.Equal(contr_type);

            if (contr_kv.HasValue && contr_kv != null)
                this.Filter.KV.Equal(contr_kv);

            if (contr_status.HasValue && contr_status != null)
                this.Filter.STATUS_ID.Equal(contr_status);

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "contr_id DESC" : SortExpression), maximumRows, startRowIndex);
        }
    }
}