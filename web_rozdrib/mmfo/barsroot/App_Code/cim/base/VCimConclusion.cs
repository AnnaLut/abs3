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

namespace cim
{
    public sealed class VCimConclusionRecord : BbRecord
    {
        public VCimConclusionRecord(): base()
        {
            fillFields();
        }
        public VCimConclusionRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimConclusionRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ID, Decimal? CONTR_ID, Decimal? ORG_ID, String ORG_NAME, String OUT_NUM, DateTime? OUT_DATE, Decimal? KV, Decimal? S, DateTime? BEGIN_DATE, DateTime? END_DATE, Decimal? S_DOC, DateTime? CREATE_DATE, Decimal? CREATE_UID)
            : this(Parent)
        {
            this.ID = ID;
            this.CONTR_ID = CONTR_ID;
            this.ORG_ID = ORG_ID;
            this.ORG_NAME = ORG_NAME;
            this.OUT_NUM = OUT_NUM;
            this.OUT_DATE = OUT_DATE;
            this.KV = KV;
            this.S = S;
            this.BEGIN_DATE = BEGIN_DATE;
            this.END_DATE = END_DATE;
            this.S_DOC = S_DOC;
            this.CREATE_DATE = CREATE_DATE;
            this.CREATE_UID = CREATE_UID;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "ID висновку"));
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "ID контракту"));
            Fields.Add( new BbField("ORG_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "id органу, який видав висновок"));
            Fields.Add( new BbField("ORG_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Назва органу, який видав висновок"));
            Fields.Add( new BbField("OUT_NUM", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Вихідний номер висновку"));
            Fields.Add( new BbField("OUT_DATE", OracleDbType.Date, true, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Вихідна дата висновку"));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Код валюти"));
            Fields.Add( new BbField("S", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Сума висновку"));
            Fields.Add( new BbField("BEGIN_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Дата початку строку"));
            Fields.Add( new BbField("END_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Дата закінчення строку"));
            Fields.Add( new BbField("S_DOC", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Сума пов`язаних документів"));
            Fields.Add( new BbField("CREATE_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Дата введення висновку"));
            Fields.Add( new BbField("CREATE_UID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_CONCLUSION", ObjectTypes.View, "Висновки", "Користувач, який ввів висновок"));        
        }
        public Decimal? ID { get { return (Decimal?)FindField("ID").Value; } set {SetField("ID", value);} }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public Decimal? ORG_ID { get { return (Decimal?)FindField("ORG_ID").Value; } set {SetField("ORG_ID", value);} }
        public String ORG_NAME { get { return (String)FindField("ORG_NAME").Value; } set {SetField("ORG_NAME", value);} }
        public String OUT_NUM { get { return (String)FindField("OUT_NUM").Value; } set {SetField("OUT_NUM", value);} }
        public DateTime? OUT_DATE { get { return (DateTime?)FindField("OUT_DATE").Value; } set {SetField("OUT_DATE", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? S { get { return (Decimal?)FindField("S").Value; } set {SetField("S", value);} }
        public DateTime? BEGIN_DATE { get { return (DateTime?)FindField("BEGIN_DATE").Value; } set {SetField("BEGIN_DATE", value);} }
        public DateTime? END_DATE { get { return (DateTime?)FindField("END_DATE").Value; } set {SetField("END_DATE", value);} }
        public Decimal? S_DOC { get { return (Decimal?)FindField("S_DOC").Value; } set {SetField("S_DOC", value);} }
        public DateTime? CREATE_DATE { get { return (DateTime?)FindField("CREATE_DATE").Value; } set {SetField("CREATE_DATE", value);} }
        public Decimal? CREATE_UID { get { return (Decimal?)FindField("CREATE_UID").Value; } set {SetField("CREATE_UID", value);} }
    }

    public sealed class VCimConclusionFilters : BbFilters
    {
        public VCimConclusionFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBDecimalFilter(this, "ID");
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            ORG_ID = new BBDecimalFilter(this, "ORG_ID");
            ORG_NAME = new BBVarchar2Filter(this, "ORG_NAME");
            OUT_NUM = new BBVarchar2Filter(this, "OUT_NUM");
            OUT_DATE = new BBDateFilter(this, "OUT_DATE");
            KV = new BBDecimalFilter(this, "KV");
            S = new BBDecimalFilter(this, "S");
            BEGIN_DATE = new BBDateFilter(this, "BEGIN_DATE");
            END_DATE = new BBDateFilter(this, "END_DATE");
            S_DOC = new BBDecimalFilter(this, "S_DOC");
            CREATE_DATE = new BBDateFilter(this, "CREATE_DATE");
            CREATE_UID = new BBDecimalFilter(this, "CREATE_UID");
        }
        public BBDecimalFilter ID;
        public BBDecimalFilter CONTR_ID;
        public BBDecimalFilter ORG_ID;
        public BBVarchar2Filter ORG_NAME;
        public BBVarchar2Filter OUT_NUM;
        public BBDateFilter OUT_DATE;
        public BBDecimalFilter KV;
        public BBDecimalFilter S;
        public BBDateFilter BEGIN_DATE;
        public BBDateFilter END_DATE;
        public BBDecimalFilter S_DOC;
        public BBDateFilter CREATE_DATE;
        public BBDecimalFilter CREATE_UID;
    }

    public partial class VCimConclusion : BbTable<VCimConclusionRecord, VCimConclusionFilters>
    {
        public VCimConclusion() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimConclusion(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimConclusionRecord> Select(VCimConclusionRecord Item)
        {
            List<VCimConclusionRecord> res = new List<VCimConclusionRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimConclusionRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (DateTime?)null : Convert.ToDateTime(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (DateTime?)null : Convert.ToDateTime(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]))
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