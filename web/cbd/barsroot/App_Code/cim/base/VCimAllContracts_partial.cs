using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using System.Web.Configuration;
using System.Windows.Forms.VisualStyles;
using barsroot.cim;
using barsroot.core;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using ibank.core;
using Bars.Classes;

namespace cim
{

    public partial class VCimAllContracts
    {
        public List<VCimAllContractsRecord> SelectContracts(Decimal? contr_type, Decimal? contr_kv, Decimal? contr_status, Boolean owner_flag, Boolean client_flag, Decimal? direct, String okpo, Decimal? payflag, String SortExpression, int maximumRows, int startRowIndex)
        {
            if (direct.HasValue && payflag.HasValue)
            {
                if (!string.IsNullOrEmpty(okpo) && client_flag)
                    this.Filter.OKPO.Equal(okpo);
                this.Filter.STATUS_ID.NotEqual(1);
                this.Filter.STATUS_ID.NotEqual(9);
                this.Filter.STATUS_ID.NotEqual(10);
                // основні 
                //(direct <платежу> =0 and contr_type!=1 or direct <платежу> =1 and status_id!=2 and status_id!=3 and contr_type!=0) and okpo=cust_okpo  <платежу> 
                if (payflag == 0)
                {
                    if (direct == 0)
                        this.Filter.CONTR_TYPE.NotEqual(1);
                    else if (direct == 1)
                    {
                        this.Filter.CONTR_TYPE.NotEqual(0);
                        this.Filter.STATUS_ID.NotEqual(2);
                        this.Filter.STATUS_ID.NotEqual(3);
                    }
                }
                // додаткові
                // (direct <платежу> =0  or direct <платежу> =1 and status_id!=2 and status_id!=3) and okpo=cust_okpo  <платежу> 
                else if (payflag == 1)
                {
                    if (direct == 1)
                    {
                        this.Filter.STATUS_ID.NotEqual(2);
                        this.Filter.STATUS_ID.NotEqual(3);
                    }
                }
                // торгові
                else if (payflag == 2)
                {
                    if (direct == 0)
                        this.Filter.CONTR_TYPE.Equal(1);
                    else if (direct == 1)
                        this.Filter.CONTR_TYPE.Equal(0);
                }
            }
            if (contr_type.HasValue && contr_type != -1)
                this.Filter.CONTR_TYPE.Equal(contr_type);

            if (contr_kv.HasValue)
                this.Filter.KV.Equal(contr_kv);

            if (contr_status.HasValue)
            {
                if (contr_status.Value == -1)
                    this.Filter.STATUS_ID.NotEqual(1);
                else 
                    this.Filter.STATUS_ID.Equal(contr_status);
            }

            if (owner_flag && HttpContext.Current.Session[barsroot.cim.Constants.StateKeys.UserId] != null)
            {
                this.Filter.OWNER_UID.Equal(Convert.ToDecimal(HttpContext.Current.Session[barsroot.cim.Constants.StateKeys.UserId]));
            }

            return this.Select((String.IsNullOrEmpty(SortExpression) ? "contr_id DESC" : SortExpression), maximumRows, startRowIndex);
        }
    }
}