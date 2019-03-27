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
    public sealed class VWcsGaranteesRecord : BbRecord
    {
        public VWcsGaranteesRecord(): base()
        {
            fillFields();
        }
        public VWcsGaranteesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsGaranteesRecord(BbDataSource Parent, OracleDecimal RowScn, String GARANTEE_ID, String GARANTEE_NAME, Decimal? GRT_TABLE_ID, String GRT_TABLE_NAME, String SCOPY_ID, String SCOPY_NAME, String SURVEY_ID, String SURVEY_NAME, Decimal? INS_CNT, Decimal? TPL_CNT, String WS_ID)
            : this(Parent)
        {
            this.GARANTEE_ID = GARANTEE_ID;
            this.GARANTEE_NAME = GARANTEE_NAME;
            this.GRT_TABLE_ID = GRT_TABLE_ID;
            this.GRT_TABLE_NAME = GRT_TABLE_NAME;
            this.SCOPY_ID = SCOPY_ID;
            this.SCOPY_NAME = SCOPY_NAME;
            this.SURVEY_ID = SURVEY_ID;
            this.SURVEY_NAME = SURVEY_NAME;
            this.INS_CNT = INS_CNT;
            this.TPL_CNT = TPL_CNT;
            this.WS_ID = WS_ID;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("GARANTEE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Идентификатор"));
            Fields.Add( new BbField("GARANTEE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Наименование"));
            Fields.Add( new BbField("GRT_TABLE_ID", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", ""));
            Fields.Add( new BbField("GRT_TABLE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", ""));
            Fields.Add( new BbField("SCOPY_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Идентификатор карты сканкопий"));
            Fields.Add( new BbField("SCOPY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Наименование карты сканкопий"));
            Fields.Add( new BbField("SURVEY_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Идентификатор анкеты"));
            Fields.Add( new BbField("SURVEY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Наименование анкеты"));
            Fields.Add( new BbField("INS_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Кол-во привязаных типов страховок"));
            Fields.Add( new BbField("TPL_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Кол-во привязаных шаблонов"));
            Fields.Add( new BbField("WS_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_GARANTEES", ObjectTypes.View, "Внутр. типы залогов (Представление)", "Идентификатор рабочего пространства"));        
        }
        public String GARANTEE_ID { get { return (String)FindField("GARANTEE_ID").Value; } set {SetField("GARANTEE_ID", value);} }
        public String GARANTEE_NAME { get { return (String)FindField("GARANTEE_NAME").Value; } set {SetField("GARANTEE_NAME", value);} }
        public Decimal? GRT_TABLE_ID { get { return (Decimal?)FindField("GRT_TABLE_ID").Value; } set {SetField("GRT_TABLE_ID", value);} }
        public String GRT_TABLE_NAME { get { return (String)FindField("GRT_TABLE_NAME").Value; } set {SetField("GRT_TABLE_NAME", value);} }
        public String SCOPY_ID { get { return (String)FindField("SCOPY_ID").Value; } set {SetField("SCOPY_ID", value);} }
        public String SCOPY_NAME { get { return (String)FindField("SCOPY_NAME").Value; } set {SetField("SCOPY_NAME", value);} }
        public String SURVEY_ID { get { return (String)FindField("SURVEY_ID").Value; } set {SetField("SURVEY_ID", value);} }
        public String SURVEY_NAME { get { return (String)FindField("SURVEY_NAME").Value; } set {SetField("SURVEY_NAME", value);} }
        public Decimal? INS_CNT { get { return (Decimal?)FindField("INS_CNT").Value; } set {SetField("INS_CNT", value);} }
        public Decimal? TPL_CNT { get { return (Decimal?)FindField("TPL_CNT").Value; } set {SetField("TPL_CNT", value);} }
        public String WS_ID { get { return (String)FindField("WS_ID").Value; } set {SetField("WS_ID", value);} }
    }

    public sealed class VWcsGaranteesFilters : BbFilters
    {
        public VWcsGaranteesFilters(BbDataSource Parent) : base (Parent)
        {
            GARANTEE_ID = new BBVarchar2Filter(this, "GARANTEE_ID");
            GARANTEE_NAME = new BBVarchar2Filter(this, "GARANTEE_NAME");
            GRT_TABLE_ID = new BBDecimalFilter(this, "GRT_TABLE_ID");
            GRT_TABLE_NAME = new BBVarchar2Filter(this, "GRT_TABLE_NAME");
            SCOPY_ID = new BBVarchar2Filter(this, "SCOPY_ID");
            SCOPY_NAME = new BBVarchar2Filter(this, "SCOPY_NAME");
            SURVEY_ID = new BBVarchar2Filter(this, "SURVEY_ID");
            SURVEY_NAME = new BBVarchar2Filter(this, "SURVEY_NAME");
            INS_CNT = new BBDecimalFilter(this, "INS_CNT");
            TPL_CNT = new BBDecimalFilter(this, "TPL_CNT");
            WS_ID = new BBVarchar2Filter(this, "WS_ID");
        }
        public BBVarchar2Filter GARANTEE_ID;
        public BBVarchar2Filter GARANTEE_NAME;
        public BBDecimalFilter GRT_TABLE_ID;
        public BBVarchar2Filter GRT_TABLE_NAME;
        public BBVarchar2Filter SCOPY_ID;
        public BBVarchar2Filter SCOPY_NAME;
        public BBVarchar2Filter SURVEY_ID;
        public BBVarchar2Filter SURVEY_NAME;
        public BBDecimalFilter INS_CNT;
        public BBDecimalFilter TPL_CNT;
        public BBVarchar2Filter WS_ID;
    }

    public partial class VWcsGarantees : BbTable<VWcsGaranteesRecord, VWcsGaranteesFilters>
    {
        public VWcsGarantees() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsGarantees(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsGaranteesRecord> Select(VWcsGaranteesRecord Item)
        {
            List<VWcsGaranteesRecord> res = new List<VWcsGaranteesRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsGaranteesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]))
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