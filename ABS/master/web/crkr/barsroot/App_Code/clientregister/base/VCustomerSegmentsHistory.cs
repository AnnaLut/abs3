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

namespace clientregister
{
    public sealed class VCustomerSegmentsHistoryRecord : BbRecord
    {
        public VCustomerSegmentsHistoryRecord(): base()
        {
            fillFields();
        }
        public VCustomerSegmentsHistoryRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustomerSegmentsHistoryRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ROWNUMBER, String ATTRIBUTE_NAME, Decimal? ATTRIBUTE_ID, Decimal? RNK, Decimal? ID, Decimal? PREV_ID, Decimal? PREV_VAL, DateTime? PREV_VAL_DATE_START, DateTime? PREV_DATE_STOP, String ATTRIBUTE_VAL)
            : this(Parent)
        {
            this.ROWNUMBER = ROWNUMBER;
            this.ATTRIBUTE_NAME = ATTRIBUTE_NAME;
            this.ATTRIBUTE_ID = ATTRIBUTE_ID;
            this.RNK = RNK;
            this.ID = ID;
            this.PREV_ID = PREV_ID;
            this.PREV_VAL = PREV_VAL;
            this.PREV_VAL_DATE_START = PREV_VAL_DATE_START;
            this.PREV_DATE_STOP = PREV_DATE_STOP;
            this.ATTRIBUTE_VAL = ATTRIBUTE_VAL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ROWNUMBER", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ATTRIBUTE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ATTRIBUTE_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PREV_ID", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PREV_VAL", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PREV_VAL_DATE_START", OracleDbType.Date, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PREV_DATE_STOP", OracleDbType.Date, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ATTRIBUTE_VAL", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS_HISTORY", ObjectTypes.View, "", ""));        
        }
        public Decimal? ROWNUMBER { get { return (Decimal?)FindField("ROWNUMBER").Value; } set {SetField("ROWNUMBER", value);} }
        public String ATTRIBUTE_NAME { get { return (String)FindField("ATTRIBUTE_NAME").Value; } set {SetField("ATTRIBUTE_NAME", value);} }
        public Decimal? ATTRIBUTE_ID { get { return (Decimal?)FindField("ATTRIBUTE_ID").Value; } set {SetField("ATTRIBUTE_ID", value);} }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public Decimal? PREV_ID { get { return (Decimal?)FindField("PREV_ID").Value; } set {SetField("PREV_ID", value);} }
        public Decimal? PREV_VAL { get { return (Decimal?)FindField("PREV_VAL").Value; } set {SetField("PREV_VAL", value);} }
        public DateTime? PREV_VAL_DATE_START { get { return (DateTime?)FindField("PREV_VAL_DATE_START").Value; } set {SetField("PREV_VAL_DATE_START", value);} }
        public DateTime? PREV_DATE_STOP { get { return (DateTime?)FindField("PREV_DATE_STOP").Value; } set {SetField("PREV_DATE_STOP", value);} }
        public String ATTRIBUTE_VAL { get { return (String)FindField("ATTRIBUTE_VAL").Value; } set {SetField("ATTRIBUTE_VAL", value);} }
    }

    public sealed class VCustomerSegmentsHistoryFilters : BbFilters
    {
        public VCustomerSegmentsHistoryFilters(BbDataSource Parent) : base (Parent)
        {
            ROWNUMBER = new BBDecimalFilter(this, "ROWNUMBER");
            ATTRIBUTE_NAME = new BBVarchar2Filter(this, "ATTRIBUTE_NAME");
            ATTRIBUTE_ID = new BBDecimalFilter(this, "ATTRIBUTE_ID");
            RNK = new BBDecimalFilter(this, "RNK");
            ID = new BBDecimalFilter(this, "ID");
            PREV_ID = new BBDecimalFilter(this, "PREV_ID");
            PREV_VAL = new BBDecimalFilter(this, "PREV_VAL");
            PREV_VAL_DATE_START = new BBDateFilter(this, "PREV_VAL_DATE_START");
            PREV_DATE_STOP = new BBDateFilter(this, "PREV_DATE_STOP");
            ATTRIBUTE_VAL = new BBVarchar2Filter(this, "ATTRIBUTE_VAL");
        }
        public BBDecimalFilter ROWNUMBER;
        public BBVarchar2Filter ATTRIBUTE_NAME;
        public BBDecimalFilter ATTRIBUTE_ID;
        public BBDecimalFilter RNK;
        public BBDecimalFilter ID;
        public BBDecimalFilter PREV_ID;
        public BBDecimalFilter PREV_VAL;
        public BBDateFilter PREV_VAL_DATE_START;
        public BBDateFilter PREV_DATE_STOP;
        public BBVarchar2Filter ATTRIBUTE_VAL;
    }

    public partial class VCustomerSegmentsHistory : BbTable<VCustomerSegmentsHistoryRecord, VCustomerSegmentsHistoryFilters>
    {
        public VCustomerSegmentsHistory() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCustomerSegmentsHistory(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustomerSegmentsHistoryRecord> Select(VCustomerSegmentsHistoryRecord Item)
        {
            List<VCustomerSegmentsHistoryRecord> res = new List<VCustomerSegmentsHistoryRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCustomerSegmentsHistoryRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (DateTime?)null : Convert.ToDateTime(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]))
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