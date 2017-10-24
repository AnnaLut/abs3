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
    public sealed class VCustomerSegmentsRecord : BbRecord
    {
        public VCustomerSegmentsRecord(): base()
        {
            fillFields();
        }
        public VCustomerSegmentsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCustomerSegmentsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? RNK, String CUSTOMER_SEGMENT_ACTIVITY, String CUSTOMER_SEGMENT_FINANCIAL, String CUSTOMER_SEGMENT_BEHAVIOR, Decimal? CUSTOMER_SEGMENT_PRODUCTS_AMNT, Decimal? CUSTOMER_SEGMENT_TRANSACTIONS, String CSA_DATE_START, String CSA_DATE_STOP, String CSF_DATE_START, String CSF_DATE_STOP, String CSB_DATE_START, String CSB_DATE_STOP, String CSP_DATE_START, String CSP_DATE_STOP, String CST_DATE_START, String CST_DATE_STOP, String CUSTOMER_SEGMENT_SOCIAL_VIP, DateTime? CSV_DATE_START, DateTime? CSV_DATE_STOP, String VIP_CUSTOMER_FLAG)
            : this(Parent)
        {
            this.RNK = RNK;
            this.CUSTOMER_SEGMENT_ACTIVITY = CUSTOMER_SEGMENT_ACTIVITY;
            this.CUSTOMER_SEGMENT_FINANCIAL = CUSTOMER_SEGMENT_FINANCIAL;
            this.CUSTOMER_SEGMENT_BEHAVIOR = CUSTOMER_SEGMENT_BEHAVIOR;
            this.CUSTOMER_SEGMENT_PRODUCTS_AMNT = CUSTOMER_SEGMENT_PRODUCTS_AMNT;
            this.CUSTOMER_SEGMENT_TRANSACTIONS = CUSTOMER_SEGMENT_TRANSACTIONS;
            this.CSA_DATE_START = CSA_DATE_START;
            this.CSA_DATE_STOP = CSA_DATE_STOP;
            this.CSF_DATE_START = CSF_DATE_START;
            this.CSF_DATE_STOP = CSF_DATE_STOP;
            this.CSB_DATE_START = CSB_DATE_START;
            this.CSB_DATE_STOP = CSB_DATE_STOP;
            this.CSP_DATE_START = CSP_DATE_START;
            this.CSP_DATE_STOP = CSP_DATE_STOP;
            this.CST_DATE_START = CST_DATE_START;
            this.CST_DATE_STOP = CST_DATE_STOP;
            this.CUSTOMER_SEGMENT_SOCIAL_VIP = CUSTOMER_SEGMENT_SOCIAL_VIP;
            this.CSV_DATE_START = CSV_DATE_START;
            this.CSV_DATE_STOP = CSV_DATE_STOP;
            this.VIP_CUSTOMER_FLAG = VIP_CUSTOMER_FLAG;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("RNK", OracleDbType.Decimal, false, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_ACTIVITY", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_FINANCIAL", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_BEHAVIOR", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_PRODUCTS_AMNT", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_TRANSACTIONS", OracleDbType.Decimal, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSA_DATE_START", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSA_DATE_STOP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSF_DATE_START", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSF_DATE_STOP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSB_DATE_START", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSB_DATE_STOP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSP_DATE_START", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSP_DATE_STOP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CST_DATE_START", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CST_DATE_STOP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CUSTOMER_SEGMENT_SOCIAL_VIP", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSV_DATE_START", OracleDbType.Date, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CSV_DATE_STOP", OracleDbType.Date, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("VIP_CUSTOMER_FLAG", OracleDbType.Varchar2, true, false, false, false, false, "V_CUSTOMER_SEGMENTS", ObjectTypes.View, "", ""));        
        }
        public Decimal? RNK { get { return (Decimal?)FindField("RNK").Value; } set {SetField("RNK", value);} }
        public String CUSTOMER_SEGMENT_ACTIVITY { get { return (String)FindField("CUSTOMER_SEGMENT_ACTIVITY").Value; } set {SetField("CUSTOMER_SEGMENT_ACTIVITY", value);} }
        public String CUSTOMER_SEGMENT_FINANCIAL { get { return (String)FindField("CUSTOMER_SEGMENT_FINANCIAL").Value; } set {SetField("CUSTOMER_SEGMENT_FINANCIAL", value);} }
        public String CUSTOMER_SEGMENT_BEHAVIOR { get { return (String)FindField("CUSTOMER_SEGMENT_BEHAVIOR").Value; } set {SetField("CUSTOMER_SEGMENT_BEHAVIOR", value);} }
        public Decimal? CUSTOMER_SEGMENT_PRODUCTS_AMNT { get { return (Decimal?)FindField("CUSTOMER_SEGMENT_PRODUCTS_AMNT").Value; } set {SetField("CUSTOMER_SEGMENT_PRODUCTS_AMNT", value);} }
        public Decimal? CUSTOMER_SEGMENT_TRANSACTIONS { get { return (Decimal?)FindField("CUSTOMER_SEGMENT_TRANSACTIONS").Value; } set {SetField("CUSTOMER_SEGMENT_TRANSACTIONS", value);} }
        public String CSA_DATE_START { get { return (String)FindField("CSA_DATE_START").Value; } set {SetField("CSA_DATE_START", value);} }
        public String CSA_DATE_STOP { get { return (String)FindField("CSA_DATE_STOP").Value; } set {SetField("CSA_DATE_STOP", value);} }
        public String CSF_DATE_START { get { return (String)FindField("CSF_DATE_START").Value; } set {SetField("CSF_DATE_START", value);} }
        public String CSF_DATE_STOP { get { return (String)FindField("CSF_DATE_STOP").Value; } set {SetField("CSF_DATE_STOP", value);} }
        public String CSB_DATE_START { get { return (String)FindField("CSB_DATE_START").Value; } set {SetField("CSB_DATE_START", value);} }
        public String CSB_DATE_STOP { get { return (String)FindField("CSB_DATE_STOP").Value; } set {SetField("CSB_DATE_STOP", value);} }
        public String CSP_DATE_START { get { return (String)FindField("CSP_DATE_START").Value; } set {SetField("CSP_DATE_START", value);} }
        public String CSP_DATE_STOP { get { return (String)FindField("CSP_DATE_STOP").Value; } set {SetField("CSP_DATE_STOP", value);} }
        public String CST_DATE_START { get { return (String)FindField("CST_DATE_START").Value; } set {SetField("CST_DATE_START", value);} }
        public String CST_DATE_STOP { get { return (String)FindField("CST_DATE_STOP").Value; } set {SetField("CST_DATE_STOP", value);} }
        public String CUSTOMER_SEGMENT_SOCIAL_VIP { get { return (String)FindField("CUSTOMER_SEGMENT_SOCIAL_VIP").Value; } set {SetField("CUSTOMER_SEGMENT_SOCIAL_VIP", value);} }
        public DateTime? CSV_DATE_START { get { return (DateTime?)FindField("CSV_DATE_START").Value; } set {SetField("CSV_DATE_START", value);} }
        public DateTime? CSV_DATE_STOP { get { return (DateTime?)FindField("CSV_DATE_STOP").Value; } set {SetField("CSV_DATE_STOP", value);} }
        public String VIP_CUSTOMER_FLAG { get { return (String)FindField("VIP_CUSTOMER_FLAG").Value; } set {SetField("VIP_CUSTOMER_FLAG", value);} }
    }

    public sealed class VCustomerSegmentsFilters : BbFilters
    {
        public VCustomerSegmentsFilters(BbDataSource Parent) : base (Parent)
        {
            RNK = new BBDecimalFilter(this, "RNK");
            CUSTOMER_SEGMENT_ACTIVITY = new BBVarchar2Filter(this, "CUSTOMER_SEGMENT_ACTIVITY");
            CUSTOMER_SEGMENT_FINANCIAL = new BBVarchar2Filter(this, "CUSTOMER_SEGMENT_FINANCIAL");
            CUSTOMER_SEGMENT_BEHAVIOR = new BBVarchar2Filter(this, "CUSTOMER_SEGMENT_BEHAVIOR");
            CUSTOMER_SEGMENT_PRODUCTS_AMNT = new BBDecimalFilter(this, "CUSTOMER_SEGMENT_PRODUCTS_AMNT");
            CUSTOMER_SEGMENT_TRANSACTIONS = new BBDecimalFilter(this, "CUSTOMER_SEGMENT_TRANSACTIONS");
            CSA_DATE_START = new BBVarchar2Filter(this, "CSA_DATE_START");
            CSA_DATE_STOP = new BBVarchar2Filter(this, "CSA_DATE_STOP");
            CSF_DATE_START = new BBVarchar2Filter(this, "CSF_DATE_START");
            CSF_DATE_STOP = new BBVarchar2Filter(this, "CSF_DATE_STOP");
            CSB_DATE_START = new BBVarchar2Filter(this, "CSB_DATE_START");
            CSB_DATE_STOP = new BBVarchar2Filter(this, "CSB_DATE_STOP");
            CSP_DATE_START = new BBVarchar2Filter(this, "CSP_DATE_START");
            CSP_DATE_STOP = new BBVarchar2Filter(this, "CSP_DATE_STOP");
            CST_DATE_START = new BBVarchar2Filter(this, "CST_DATE_START");
            CST_DATE_STOP = new BBVarchar2Filter(this, "CST_DATE_STOP");
            CUSTOMER_SEGMENT_SOCIAL_VIP = new BBVarchar2Filter(this, "CUSTOMER_SEGMENT_SOCIAL_VIP");
            CSV_DATE_START = new BBDateFilter(this, "CSV_DATE_START");
            CSV_DATE_STOP = new BBDateFilter(this, "CSV_DATE_STOP");
            VIP_CUSTOMER_FLAG = new BBVarchar2Filter(this, "VIP_CUSTOMER_FLAG");
        }
        public BBDecimalFilter RNK;
        public BBVarchar2Filter CUSTOMER_SEGMENT_ACTIVITY;
        public BBVarchar2Filter CUSTOMER_SEGMENT_FINANCIAL;
        public BBVarchar2Filter CUSTOMER_SEGMENT_BEHAVIOR;
        public BBDecimalFilter CUSTOMER_SEGMENT_PRODUCTS_AMNT;
        public BBDecimalFilter CUSTOMER_SEGMENT_TRANSACTIONS;
        public BBVarchar2Filter CSA_DATE_START;
        public BBVarchar2Filter CSA_DATE_STOP;
        public BBVarchar2Filter CSF_DATE_START;
        public BBVarchar2Filter CSF_DATE_STOP;
        public BBVarchar2Filter CSB_DATE_START;
        public BBVarchar2Filter CSB_DATE_STOP;
        public BBVarchar2Filter CSP_DATE_START;
        public BBVarchar2Filter CSP_DATE_STOP;
        public BBVarchar2Filter CST_DATE_START;
        public BBVarchar2Filter CST_DATE_STOP;
        public BBVarchar2Filter CUSTOMER_SEGMENT_SOCIAL_VIP;
        public BBDateFilter CSV_DATE_START;
        public BBDateFilter CSV_DATE_STOP;
        public BBVarchar2Filter VIP_CUSTOMER_FLAG;
    }

    public partial class VCustomerSegments : BbTable<VCustomerSegmentsRecord, VCustomerSegmentsFilters>
    {
        public VCustomerSegments() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCustomerSegments(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCustomerSegmentsRecord> Select(VCustomerSegmentsRecord Item)
        {
            List<VCustomerSegmentsRecord> res = new List<VCustomerSegmentsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCustomerSegmentsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (DateTime?)null : Convert.ToDateTime(rdr[18]), 
                        rdr.IsDBNull(19) ?  (DateTime?)null : Convert.ToDateTime(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]))
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