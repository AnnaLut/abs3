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
    public sealed class VCimApeRecord : BbRecord
    {
        public VCimApeRecord(): base()
        {
            fillFields();
        }
        public VCimApeRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCimApeRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? CONTR_ID, Decimal? APE_ID, String NUM, Decimal? KV, Decimal? S, Decimal? RATE, Decimal? KV_K, Decimal? S_VK, DateTime? BEGIN_DATE, DateTime? END_DATE, String COMMENTS, Decimal? ZS_VK, String EA_URL)
            : this(Parent)
        {
            this.CONTR_ID = CONTR_ID;
            this.APE_ID = APE_ID;
            this.NUM = NUM;
            this.KV = KV;
            this.S = S;
            this.RATE = RATE;
            this.KV_K = KV_K;
            this.S_VK = S_VK;
            this.BEGIN_DATE = BEGIN_DATE;
            this.END_DATE = END_DATE;
            this.COMMENTS = COMMENTS;
            this.ZS_VK = ZS_VK;
            this.EA_URL = EA_URL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("CONTR_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "ID контракту"));
            Fields.Add( new BbField("APE_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "ID акту цінової експертизи"));
            Fields.Add( new BbField("NUM", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Номер акту цінової експертизи"));
            Fields.Add( new BbField("KV", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Код валюти акту цінової експертизи"));
            Fields.Add( new BbField("S", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Сума у валюті акту"));
            Fields.Add( new BbField("RATE", OracleDbType.Decimal, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Курс"));
            Fields.Add( new BbField("KV_K", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Код валюти контракту"));
            Fields.Add( new BbField("S_VK", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Сума  у валюті контракту"));
            Fields.Add( new BbField("BEGIN_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Дата акту цінової експертизи"));
            Fields.Add( new BbField("END_DATE", OracleDbType.Date, false, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Дата, до якої дійсний актцінової експертизи"));
            Fields.Add( new BbField("COMMENTS", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Примітка"));
            Fields.Add( new BbField("ZS_VK", OracleDbType.Decimal, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Залишок сума  у валюті контракту"));
            Fields.Add( new BbField("EA_URL", OracleDbType.Varchar2, true, false, false, false, false, "V_CIM_APE", ObjectTypes.View, "Акти цінової експертизи v 1.00.01", "Адреса сервера електронного архіву ВК"));        
        }
        public Decimal? CONTR_ID { get { return (Decimal?)FindField("CONTR_ID").Value; } set {SetField("CONTR_ID", value);} }
        public Decimal? APE_ID { get { return (Decimal?)FindField("APE_ID").Value; } set {SetField("APE_ID", value);} }
        public String NUM { get { return (String)FindField("NUM").Value; } set {SetField("NUM", value);} }
        public Decimal? KV { get { return (Decimal?)FindField("KV").Value; } set {SetField("KV", value);} }
        public Decimal? S { get { return (Decimal?)FindField("S").Value; } set {SetField("S", value);} }
        public Decimal? RATE { get { return (Decimal?)FindField("RATE").Value; } set {SetField("RATE", value);} }
        public Decimal? KV_K { get { return (Decimal?)FindField("KV_K").Value; } set {SetField("KV_K", value);} }
        public Decimal? S_VK { get { return (Decimal?)FindField("S_VK").Value; } set {SetField("S_VK", value);} }
        public DateTime? BEGIN_DATE { get { return (DateTime?)FindField("BEGIN_DATE").Value; } set {SetField("BEGIN_DATE", value);} }
        public DateTime? END_DATE { get { return (DateTime?)FindField("END_DATE").Value; } set {SetField("END_DATE", value);} }
        public String COMMENTS { get { return (String)FindField("COMMENTS").Value; } set {SetField("COMMENTS", value);} }
        public Decimal? ZS_VK { get { return (Decimal?)FindField("ZS_VK").Value; } set {SetField("ZS_VK", value);} }
        public String EA_URL { get { return (String)FindField("EA_URL").Value; } set {SetField("EA_URL", value);} }
    }

    public sealed class VCimApeFilters : BbFilters
    {
        public VCimApeFilters(BbDataSource Parent) : base (Parent)
        {
            CONTR_ID = new BBDecimalFilter(this, "CONTR_ID");
            APE_ID = new BBDecimalFilter(this, "APE_ID");
            NUM = new BBVarchar2Filter(this, "NUM");
            KV = new BBDecimalFilter(this, "KV");
            S = new BBDecimalFilter(this, "S");
            RATE = new BBDecimalFilter(this, "RATE");
            KV_K = new BBDecimalFilter(this, "KV_K");
            S_VK = new BBDecimalFilter(this, "S_VK");
            BEGIN_DATE = new BBDateFilter(this, "BEGIN_DATE");
            END_DATE = new BBDateFilter(this, "END_DATE");
            COMMENTS = new BBVarchar2Filter(this, "COMMENTS");
            ZS_VK = new BBDecimalFilter(this, "ZS_VK");
            EA_URL = new BBVarchar2Filter(this, "EA_URL");
        }
        public BBDecimalFilter CONTR_ID;
        public BBDecimalFilter APE_ID;
        public BBVarchar2Filter NUM;
        public BBDecimalFilter KV;
        public BBDecimalFilter S;
        public BBDecimalFilter RATE;
        public BBDecimalFilter KV_K;
        public BBDecimalFilter S_VK;
        public BBDateFilter BEGIN_DATE;
        public BBDateFilter END_DATE;
        public BBVarchar2Filter COMMENTS;
        public BBDecimalFilter ZS_VK;
        public BBVarchar2Filter EA_URL;
    }

    public partial class VCimApe : BbTable<VCimApeRecord, VCimApeFilters>
    {
        public VCimApe() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VCimApe(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCimApeRecord> Select(VCimApeRecord Item)
        {
            List<VCimApeRecord> res = new List<VCimApeRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCimApeRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (Decimal?)null : Convert.ToDecimal(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (DateTime?)null : Convert.ToDateTime(rdr[9]), 
                        rdr.IsDBNull(10) ?  (DateTime?)null : Convert.ToDateTime(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]))
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