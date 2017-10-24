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

namespace Bars.ObjLayer.CbiRep
{
    public sealed class VCbirepRepparamsRecord : BbRecord
    {
        public VCbirepRepparamsRecord(): base()
        {
            fillFields();
        }
        public VCbirepRepparamsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCbirepRepparamsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? REP_ID, String REP_NAME, String REP_DESC, String PARAM, Decimal? NDAT, String MASK, String NAMEW, Decimal? IDF, Decimal? KODZ, String ZAP_NAME, String NAMEF, String BINDVARS, String CREATE_STMT, String RPT_TEMPLATE, Decimal? KODR, String FORM_PROC, String DEFAULT_VARS, String BIND_SQL, String TXT, String PKEY, String FORM)
            : this(Parent)
        {
            this.REP_ID = REP_ID;
            this.REP_NAME = REP_NAME;
            this.REP_DESC = REP_DESC;
            this.PARAM = PARAM;
            this.NDAT = NDAT;
            this.MASK = MASK;
            this.NAMEW = NAMEW;
            this.IDF = IDF;
            this.KODZ = KODZ;
            this.ZAP_NAME = ZAP_NAME;
            this.NAMEF = NAMEF;
            this.BINDVARS = BINDVARS;
            this.CREATE_STMT = CREATE_STMT;
            this.RPT_TEMPLATE = RPT_TEMPLATE;
            this.KODR = KODR;
            this.FORM_PROC = FORM_PROC;
            this.DEFAULT_VARS = DEFAULT_VARS;
            this.BIND_SQL = BIND_SQL;
            this.TXT = TXT;
            this.PKEY = PKEY;
            this.FORM = FORM;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("REP_ID", OracleDbType.Decimal, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("REP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("REP_DESC", OracleDbType.Varchar2, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PARAM", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NDAT", OracleDbType.Decimal, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("MASK", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NAMEW", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("IDF", OracleDbType.Decimal, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("KODZ", OracleDbType.Decimal, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("ZAP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("NAMEF", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BINDVARS", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("CREATE_STMT", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("RPT_TEMPLATE", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("KODR", OracleDbType.Decimal, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("FORM_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("DEFAULT_VARS", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("BIND_SQL", OracleDbType.Varchar2, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("TXT", OracleDbType.Clob, true, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("PKEY", OracleDbType.Varchar2, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));
            Fields.Add( new BbField("FORM", OracleDbType.Varchar2, false, false, false, false, false, "V_CBIREP_REPPARAMS", ObjectTypes.View, "", ""));        
        }
        public Decimal? REP_ID { get { return (Decimal?)FindField("REP_ID").Value; } set {SetField("REP_ID", value);} }
        public String REP_NAME { get { return (String)FindField("REP_NAME").Value; } set {SetField("REP_NAME", value);} }
        public String REP_DESC { get { return (String)FindField("REP_DESC").Value; } set {SetField("REP_DESC", value);} }
        public String PARAM { get { return (String)FindField("PARAM").Value; } set {SetField("PARAM", value);} }
        public Decimal? NDAT { get { return (Decimal?)FindField("NDAT").Value; } set {SetField("NDAT", value);} }
        public String MASK { get { return (String)FindField("MASK").Value; } set {SetField("MASK", value);} }
        public String NAMEW { get { return (String)FindField("NAMEW").Value; } set {SetField("NAMEW", value);} }
        public Decimal? IDF { get { return (Decimal?)FindField("IDF").Value; } set {SetField("IDF", value);} }
        public Decimal? KODZ { get { return (Decimal?)FindField("KODZ").Value; } set {SetField("KODZ", value);} }
        public String ZAP_NAME { get { return (String)FindField("ZAP_NAME").Value; } set {SetField("ZAP_NAME", value);} }
        public String NAMEF { get { return (String)FindField("NAMEF").Value; } set {SetField("NAMEF", value);} }
        public String BINDVARS { get { return (String)FindField("BINDVARS").Value; } set {SetField("BINDVARS", value);} }
        public String CREATE_STMT { get { return (String)FindField("CREATE_STMT").Value; } set {SetField("CREATE_STMT", value);} }
        public String RPT_TEMPLATE { get { return (String)FindField("RPT_TEMPLATE").Value; } set {SetField("RPT_TEMPLATE", value);} }
        public Decimal? KODR { get { return (Decimal?)FindField("KODR").Value; } set {SetField("KODR", value);} }
        public String FORM_PROC { get { return (String)FindField("FORM_PROC").Value; } set {SetField("FORM_PROC", value);} }
        public String DEFAULT_VARS { get { return (String)FindField("DEFAULT_VARS").Value; } set {SetField("DEFAULT_VARS", value);} }
        public String BIND_SQL { get { return (String)FindField("BIND_SQL").Value; } set {SetField("BIND_SQL", value);} }
        public String TXT { get { return (String)FindField("TXT").Value; } set {SetField("TXT", value);} }
        public String PKEY { get { return (String)FindField("PKEY").Value; } set {SetField("PKEY", value);} }
        public String FORM { get { return (String)FindField("FORM").Value; } set {SetField("FORM", value);} }
    }

    public sealed class VCbirepRepparamsFilters : BbFilters
    {
        public VCbirepRepparamsFilters(BbDataSource Parent) : base (Parent)
        {
            REP_ID = new BBDecimalFilter(this, "REP_ID");
            REP_NAME = new BBVarchar2Filter(this, "REP_NAME");
            REP_DESC = new BBVarchar2Filter(this, "REP_DESC");
            PARAM = new BBVarchar2Filter(this, "PARAM");
            NDAT = new BBDecimalFilter(this, "NDAT");
            MASK = new BBVarchar2Filter(this, "MASK");
            NAMEW = new BBVarchar2Filter(this, "NAMEW");
            IDF = new BBDecimalFilter(this, "IDF");
            KODZ = new BBDecimalFilter(this, "KODZ");
            ZAP_NAME = new BBVarchar2Filter(this, "ZAP_NAME");
            NAMEF = new BBVarchar2Filter(this, "NAMEF");
            BINDVARS = new BBVarchar2Filter(this, "BINDVARS");
            CREATE_STMT = new BBVarchar2Filter(this, "CREATE_STMT");
            RPT_TEMPLATE = new BBVarchar2Filter(this, "RPT_TEMPLATE");
            KODR = new BBDecimalFilter(this, "KODR");
            FORM_PROC = new BBVarchar2Filter(this, "FORM_PROC");
            DEFAULT_VARS = new BBVarchar2Filter(this, "DEFAULT_VARS");
            BIND_SQL = new BBVarchar2Filter(this, "BIND_SQL");
            PKEY = new BBVarchar2Filter(this, "PKEY");
            FORM = new BBVarchar2Filter(this, "FORM");
        }
        public BBDecimalFilter REP_ID;
        public BBVarchar2Filter REP_NAME;
        public BBVarchar2Filter REP_DESC;
        public BBVarchar2Filter PARAM;
        public BBDecimalFilter NDAT;
        public BBVarchar2Filter MASK;
        public BBVarchar2Filter NAMEW;
        public BBDecimalFilter IDF;
        public BBDecimalFilter KODZ;
        public BBVarchar2Filter ZAP_NAME;
        public BBVarchar2Filter NAMEF;
        public BBVarchar2Filter BINDVARS;
        public BBVarchar2Filter CREATE_STMT;
        public BBVarchar2Filter RPT_TEMPLATE;
        public BBDecimalFilter KODR;
        public BBVarchar2Filter FORM_PROC;
        public BBVarchar2Filter DEFAULT_VARS;
        public BBVarchar2Filter BIND_SQL;
        public BBVarchar2Filter PKEY;
        public BBVarchar2Filter FORM;
    }

    public partial class VCbirepRepparams : BbTable<VCbirepRepparamsRecord, VCbirepRepparamsFilters>
    {
        public VCbirepRepparams() : base(new BbConnection())
        {
        }
        public VCbirepRepparams(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCbirepRepparamsRecord> Select(VCbirepRepparamsRecord Item)
        {
            List<VCbirepRepparamsRecord> res = new List<VCbirepRepparamsRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VCbirepRepparamsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (String)null : Convert.ToString(rdr[18]), 
                        rdr.IsDBNull(19) ?  (String)null : Convert.ToString(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]))
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