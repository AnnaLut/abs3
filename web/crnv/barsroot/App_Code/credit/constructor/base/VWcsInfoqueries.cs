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
    public sealed class VWcsInfoqueriesRecord : BbRecord
    {
        public VWcsInfoqueriesRecord(): base()
        {
            fillFields();
        }
        public VWcsInfoqueriesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsInfoqueriesRecord(BbDataSource Parent, OracleDecimal RowScn, String IQUERY_ID, String IQUERY_NAME, String TYPE_ID, String TYPE_NAME, String PLSQL)
            : this(Parent)
        {
            this.IQUERY_ID = IQUERY_ID;
            this.IQUERY_NAME = IQUERY_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.PLSQL = PLSQL;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("IQUERY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_INFOQUERIES", ObjectTypes.View, "Информационные запросы (Представление)", "Идентификатор информационного запроса"));
            Fields.Add( new BbField("IQUERY_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_INFOQUERIES", ObjectTypes.View, "Информационные запросы (Представление)", "Наименование информационного запроса"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_INFOQUERIES", ObjectTypes.View, "Информационные запросы (Представление)", "Идентификатор типа инфо-запроса"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_INFOQUERIES", ObjectTypes.View, "Информационные запросы (Представление)", "Наименование типа инфо-запроса"));
            Fields.Add( new BbField("PLSQL", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_INFOQUERIES", ObjectTypes.View, "Информационные запросы (Представление)", "plsql блок описывающий запрос"));        
        }
        public String IQUERY_ID { get { return (String)FindField("IQUERY_ID").Value; } set {SetField("IQUERY_ID", value);} }
        public String IQUERY_NAME { get { return (String)FindField("IQUERY_NAME").Value; } set {SetField("IQUERY_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String PLSQL { get { return (String)FindField("PLSQL").Value; } set {SetField("PLSQL", value);} }
    }

    public sealed class VWcsInfoqueriesFilters : BbFilters
    {
        public VWcsInfoqueriesFilters(BbDataSource Parent) : base (Parent)
        {
            IQUERY_ID = new BBVarchar2Filter(this, "IQUERY_ID");
            IQUERY_NAME = new BBVarchar2Filter(this, "IQUERY_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            PLSQL = new BBVarchar2Filter(this, "PLSQL");
        }
        public BBVarchar2Filter IQUERY_ID;
        public BBVarchar2Filter IQUERY_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter PLSQL;
    }

    public partial class VWcsInfoqueries : BbTable<VWcsInfoqueriesRecord, VWcsInfoqueriesFilters>
    {
        public VWcsInfoqueries() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsInfoqueries(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsInfoqueriesRecord> Select(VWcsInfoqueriesRecord Item)
        {
            List<VWcsInfoqueriesRecord> res = new List<VWcsInfoqueriesRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsInfoqueriesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]))
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