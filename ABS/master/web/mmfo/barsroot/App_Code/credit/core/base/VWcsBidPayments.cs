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
    public sealed class VWcsBidPaymentsRecord : BbRecord
    {
        public VWcsBidPaymentsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidPaymentsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidPaymentsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String PAYMENT_ID, String PAYMENT_NAME)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.PAYMENT_ID = PAYMENT_ID;
            this.PAYMENT_NAME = PAYMENT_NAME;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_PAYMENTS", ObjectTypes.View, "Привязка типов выдачи к суб-продукту (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("PAYMENT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_PAYMENTS", ObjectTypes.View, "Привязка типов выдачи к суб-продукту (Представление)", "Идентификатор типа выдачи"));
            Fields.Add( new BbField("PAYMENT_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_PAYMENTS", ObjectTypes.View, "Привязка типов выдачи к суб-продукту (Представление)", "Наименование типа выдачи"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String PAYMENT_ID { get { return (String)FindField("PAYMENT_ID").Value; } set {SetField("PAYMENT_ID", value);} }
        public String PAYMENT_NAME { get { return (String)FindField("PAYMENT_NAME").Value; } set {SetField("PAYMENT_NAME", value);} }
    }

    public sealed class VWcsBidPaymentsFilters : BbFilters
    {
        public VWcsBidPaymentsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            PAYMENT_ID = new BBVarchar2Filter(this, "PAYMENT_ID");
            PAYMENT_NAME = new BBVarchar2Filter(this, "PAYMENT_NAME");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter PAYMENT_ID;
        public BBVarchar2Filter PAYMENT_NAME;
    }

    public partial class VWcsBidPayments : BbTable<VWcsBidPaymentsRecord, VWcsBidPaymentsFilters>
    {
        public VWcsBidPayments() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidPayments(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidPaymentsRecord> Select(VWcsBidPaymentsRecord Item)
        {
            List<VWcsBidPaymentsRecord> res = new List<VWcsBidPaymentsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidPaymentsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]))
                    );
                }
            }
                        finally
            {
                DisposeDataReader(rdr);
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}