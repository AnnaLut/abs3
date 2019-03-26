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
    public sealed class VWcsCrdsrvBidInfoqueriesRecord : BbRecord
    {
        public VWcsCrdsrvBidInfoqueriesRecord(): base()
        {
            fillFields();
        }
        public VWcsCrdsrvBidInfoqueriesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsCrdsrvBidInfoqueriesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String TYPE_ID, String TYPE_NAME, String SERVICE_ID, String SERVICE_NAME, String SRV_HIERARCHY, String SRV_HIERARCHY_NAME, String WS_ID, Decimal? ACT_LEVEL, String IQUERY_ID, String IQUERY_NAME, String IQUERY_TEXT, Decimal? IS_REQUIRED, Decimal? STATUS, String STATUS_MSG, Decimal? PROCESSED, Decimal? ORD)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.SERVICE_ID = SERVICE_ID;
            this.SERVICE_NAME = SERVICE_NAME;
            this.SRV_HIERARCHY = SRV_HIERARCHY;
            this.SRV_HIERARCHY_NAME = SRV_HIERARCHY_NAME;
            this.WS_ID = WS_ID;
            this.ACT_LEVEL = ACT_LEVEL;
            this.IQUERY_ID = IQUERY_ID;
            this.IQUERY_NAME = IQUERY_NAME;
            this.IQUERY_TEXT = IQUERY_TEXT;
            this.IS_REQUIRED = IS_REQUIRED;
            this.STATUS = STATUS;
            this.STATUS_MSG = STATUS_MSG;
            this.PROCESSED = PROCESSED;
            this.ORD = ORD;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Идентификатор типа инфо-запроса"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Наименование типа инфо-запроса"));
            Fields.Add( new BbField("SERVICE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Идентификатор службы"));
            Fields.Add( new BbField("SERVICE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Наименование службы"));
            Fields.Add( new BbField("SRV_HIERARCHY", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Уровень службы"));
            Fields.Add( new BbField("SRV_HIERARCHY_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Наименование уровеня службы"));
            Fields.Add( new BbField("WS_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Рабочее пространство ответов"));
            Fields.Add( new BbField("ACT_LEVEL", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Уровень активации"));
            Fields.Add( new BbField("IQUERY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Идентификатор информационного запроса"));
            Fields.Add( new BbField("IQUERY_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Наименование информационного запроса"));
            Fields.Add( new BbField("IQUERY_TEXT", OracleDbType.Clob, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Текст ручного запроса"));
            Fields.Add( new BbField("IS_REQUIRED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Обязательность"));
            Fields.Add( new BbField("STATUS", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Статус"));
            Fields.Add( new BbField("STATUS_MSG", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Текст статуса"));
            Fields.Add( new BbField("PROCESSED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Выполнялся"));
            Fields.Add( new BbField("ORD", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_CRDSRV_BID_INFOQUERIES", ObjectTypes.View, "Информационные запросы заявки (Представление)", "Порядок"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String SERVICE_ID { get { return (String)FindField("SERVICE_ID").Value; } set {SetField("SERVICE_ID", value);} }
        public String SERVICE_NAME { get { return (String)FindField("SERVICE_NAME").Value; } set {SetField("SERVICE_NAME", value);} }
        public String SRV_HIERARCHY { get { return (String)FindField("SRV_HIERARCHY").Value; } set {SetField("SRV_HIERARCHY", value);} }
        public String SRV_HIERARCHY_NAME { get { return (String)FindField("SRV_HIERARCHY_NAME").Value; } set {SetField("SRV_HIERARCHY_NAME", value);} }
        public String WS_ID { get { return (String)FindField("WS_ID").Value; } set {SetField("WS_ID", value);} }
        public Decimal? ACT_LEVEL { get { return (Decimal?)FindField("ACT_LEVEL").Value; } set {SetField("ACT_LEVEL", value);} }
        public String IQUERY_ID { get { return (String)FindField("IQUERY_ID").Value; } set {SetField("IQUERY_ID", value);} }
        public String IQUERY_NAME { get { return (String)FindField("IQUERY_NAME").Value; } set {SetField("IQUERY_NAME", value);} }
        public String IQUERY_TEXT { get { return (String)FindField("IQUERY_TEXT").Value; } set {SetField("IQUERY_TEXT", value);} }
        public Decimal? IS_REQUIRED { get { return (Decimal?)FindField("IS_REQUIRED").Value; } set {SetField("IS_REQUIRED", value);} }
        public Decimal? STATUS { get { return (Decimal?)FindField("STATUS").Value; } set {SetField("STATUS", value);} }
        public String STATUS_MSG { get { return (String)FindField("STATUS_MSG").Value; } set {SetField("STATUS_MSG", value);} }
        public Decimal? PROCESSED { get { return (Decimal?)FindField("PROCESSED").Value; } set {SetField("PROCESSED", value);} }
        public Decimal? ORD { get { return (Decimal?)FindField("ORD").Value; } set {SetField("ORD", value);} }
    }

    public sealed class VWcsCrdsrvBidInfoqueriesFilters : BbFilters
    {
        public VWcsCrdsrvBidInfoqueriesFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            SERVICE_ID = new BBVarchar2Filter(this, "SERVICE_ID");
            SERVICE_NAME = new BBVarchar2Filter(this, "SERVICE_NAME");
            SRV_HIERARCHY = new BBVarchar2Filter(this, "SRV_HIERARCHY");
            SRV_HIERARCHY_NAME = new BBVarchar2Filter(this, "SRV_HIERARCHY_NAME");
            WS_ID = new BBVarchar2Filter(this, "WS_ID");
            ACT_LEVEL = new BBDecimalFilter(this, "ACT_LEVEL");
            IQUERY_ID = new BBVarchar2Filter(this, "IQUERY_ID");
            IQUERY_NAME = new BBVarchar2Filter(this, "IQUERY_NAME");
            IS_REQUIRED = new BBDecimalFilter(this, "IS_REQUIRED");
            STATUS = new BBDecimalFilter(this, "STATUS");
            STATUS_MSG = new BBVarchar2Filter(this, "STATUS_MSG");
            PROCESSED = new BBDecimalFilter(this, "PROCESSED");
            ORD = new BBDecimalFilter(this, "ORD");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter SERVICE_ID;
        public BBVarchar2Filter SERVICE_NAME;
        public BBVarchar2Filter SRV_HIERARCHY;
        public BBVarchar2Filter SRV_HIERARCHY_NAME;
        public BBVarchar2Filter WS_ID;
        public BBDecimalFilter ACT_LEVEL;
        public BBVarchar2Filter IQUERY_ID;
        public BBVarchar2Filter IQUERY_NAME;
        public BBDecimalFilter IS_REQUIRED;
        public BBDecimalFilter STATUS;
        public BBVarchar2Filter STATUS_MSG;
        public BBDecimalFilter PROCESSED;
        public BBDecimalFilter ORD;
    }

    public partial class VWcsCrdsrvBidInfoqueries : BbTable<VWcsCrdsrvBidInfoqueriesRecord, VWcsCrdsrvBidInfoqueriesFilters>
    {
        public VWcsCrdsrvBidInfoqueries() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsCrdsrvBidInfoqueries(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsCrdsrvBidInfoqueriesRecord> Select(VWcsCrdsrvBidInfoqueriesRecord Item)
        {
            List<VWcsCrdsrvBidInfoqueriesRecord> res = new List<VWcsCrdsrvBidInfoqueriesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsCrdsrvBidInfoqueriesRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (Decimal?)null : Convert.ToDecimal(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (Decimal?)null : Convert.ToDecimal(rdr[16]), 
                        rdr.IsDBNull(17) ?  (Decimal?)null : Convert.ToDecimal(rdr[17]))
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