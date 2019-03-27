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
    public sealed class VWcsStopsRecord : BbRecord
    {
        public VWcsStopsRecord(): base()
        {
            fillFields();
        }
        public VWcsStopsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsStopsRecord(BbDataSource Parent, OracleDecimal RowScn, String STOP_ID, String STOP_NAME, String TYPE_ID, String TYPE_NAME, String RESULT_QID, String PLSQL)
            : this(Parent)
        {
            this.STOP_ID = STOP_ID;
            this.STOP_NAME = STOP_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.RESULT_QID = RESULT_QID;
            this.PLSQL = PLSQL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("STOP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "Идентификатор"));
            Fields.Add( new BbField("STOP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "Наименование"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "Тип"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "Наименование типа"));
            Fields.Add( new BbField("RESULT_QID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "Ид. вопроса результата выполнения"));
            Fields.Add( new BbField("PLSQL", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_STOPS", ObjectTypes.View, "Стопы (Представление)", "plsql блок описывающий стоп"));        
        }
        public String STOP_ID { get { return (String)FindField("STOP_ID").Value; } set {SetField("STOP_ID", value);} }
        public String STOP_NAME { get { return (String)FindField("STOP_NAME").Value; } set {SetField("STOP_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String RESULT_QID { get { return (String)FindField("RESULT_QID").Value; } set {SetField("RESULT_QID", value);} }
        public String PLSQL { get { return (String)FindField("PLSQL").Value; } set {SetField("PLSQL", value);} }
    }

    public sealed class VWcsStopsFilters : BbFilters
    {
        public VWcsStopsFilters(BbDataSource Parent) : base (Parent)
        {
            STOP_ID = new BBVarchar2Filter(this, "STOP_ID");
            STOP_NAME = new BBVarchar2Filter(this, "STOP_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            RESULT_QID = new BBVarchar2Filter(this, "RESULT_QID");
            PLSQL = new BBVarchar2Filter(this, "PLSQL");
        }
        public BBVarchar2Filter STOP_ID;
        public BBVarchar2Filter STOP_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter RESULT_QID;
        public BBVarchar2Filter PLSQL;
    }

    public partial class VWcsStops : BbTable<VWcsStopsRecord, VWcsStopsFilters>
    {
        public VWcsStops() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsStops(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsStopsRecord> Select(VWcsStopsRecord Item)
        {
            List<VWcsStopsRecord> res = new List<VWcsStopsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsStopsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]))
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