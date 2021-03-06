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
    public sealed class VWcsBidStopsRecord : BbRecord
    {
        public VWcsBidStopsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidStopsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidStopsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String STOP_ID, String STOP_NAME, String TYPE_ID, String TYPE_NAME, Decimal? FIRED)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.STOP_ID = STOP_ID;
            this.STOP_NAME = STOP_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.FIRED = FIRED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("STOP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Идентификатор стопа"));
            Fields.Add( new BbField("STOP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Наименование стопа"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Идентификатор типа"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Наименование типа"));
            Fields.Add( new BbField("FIRED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_STOPS", ObjectTypes.View, "Стопы зявки (Представление)", "Сработал ли стоп"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String STOP_ID { get { return (String)FindField("STOP_ID").Value; } set {SetField("STOP_ID", value);} }
        public String STOP_NAME { get { return (String)FindField("STOP_NAME").Value; } set {SetField("STOP_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public Decimal? FIRED { get { return (Decimal?)FindField("FIRED").Value; } set {SetField("FIRED", value);} }
    }

    public sealed class VWcsBidStopsFilters : BbFilters
    {
        public VWcsBidStopsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            STOP_ID = new BBVarchar2Filter(this, "STOP_ID");
            STOP_NAME = new BBVarchar2Filter(this, "STOP_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            FIRED = new BBDecimalFilter(this, "FIRED");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter STOP_ID;
        public BBVarchar2Filter STOP_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBDecimalFilter FIRED;
    }

    public partial class VWcsBidStops : BbTable<VWcsBidStopsRecord, VWcsBidStopsFilters>
    {
        public VWcsBidStops() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidStops(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidStopsRecord> Select(VWcsBidStopsRecord Item)
        {
            List<VWcsBidStopsRecord> res = new List<VWcsBidStopsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidStopsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]))
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