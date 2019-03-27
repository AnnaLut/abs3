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

namespace Bars.EAD
{
    public sealed class VEadSyncQueueRecord : BbRecord
    {
        public VEadSyncQueueRecord(): base()
        {
            fillFields();
        }
        public VEadSyncQueueRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VEadSyncQueueRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? SYNC_ID, DateTime? CRT_DATE, String TYPE_ID, String TYPE_NAME, String OBJ_ID, String RNK, String STATUS_ID, String STATUS_NAME, String ERR_TEXT, Decimal? ERR_COUNT, String MESSAGE_ID, DateTime? MESSAGE_DATE, String RESPONCE_ID, DateTime? RESPONCE_DATE)
            : this(Parent)
        {
            this.SYNC_ID = SYNC_ID;
            this.CRT_DATE = CRT_DATE;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.OBJ_ID = OBJ_ID;
            this.RNK = RNK;
            this.STATUS_ID = STATUS_ID;
            this.STATUS_NAME = STATUS_NAME;
            this.ERR_TEXT = ERR_TEXT;
            this.ERR_COUNT = ERR_COUNT;
            this.MESSAGE_ID = MESSAGE_ID;
            this.MESSAGE_DATE = MESSAGE_DATE;
            this.RESPONCE_ID = RESPONCE_ID;
            this.RESPONCE_DATE = RESPONCE_DATE;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SYNC_ID", OracleDbType.Decimal, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Ідентифікатор"));
            Fields.Add( new BbField("CRT_DATE", OracleDbType.Date, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Дата створення"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Ід. типу повідомлення"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Найм. типу повідомлення"));
            Fields.Add( new BbField("OBJ_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Ід. обєкту (для док. - ід документу, для клієнта - РНК і тп)"));
            Fields.Add( new BbField("RNK", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "RNK"));
            Fields.Add( new BbField("STATUS_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Найм. статусу"));
            Fields.Add( new BbField("STATUS_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", ""));
            Fields.Add( new BbField("ERR_TEXT", OracleDbType.Varchar2, true, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Текст помилки"));
            Fields.Add( new BbField("ERR_COUNT", OracleDbType.Decimal, false, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Кіл-ть спроб з помилкою"));
            Fields.Add( new BbField("MESSAGE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Ід. повідомлення"));
            Fields.Add( new BbField("MESSAGE_DATE", OracleDbType.Date, true, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Дата відправки повідомлення"));
            Fields.Add( new BbField("RESPONCE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Ід. відповіді"));
            Fields.Add( new BbField("RESPONCE_DATE", OracleDbType.Date, true, false, false, false, false, "V_EAD_SYNC_QUEUE", ObjectTypes.View, "Черга повідомлень для синхронізаціх з ЕА (представлення)", "Дата відповіді"));        
        }
        public Decimal? SYNC_ID { get { return (Decimal?)FindField("SYNC_ID").Value; } set {SetField("SYNC_ID", value);} }
        public DateTime? CRT_DATE { get { return (DateTime?)FindField("CRT_DATE").Value; } set {SetField("CRT_DATE", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String OBJ_ID { get { return (String)FindField("OBJ_ID").Value; } set {SetField("OBJ_ID", value);} }
        public String RNK { get { return (String)FindField("RNK").Value; } set { SetField("RNK", value); } }
        public String STATUS_ID { get { return (String)FindField("STATUS_ID").Value; } set {SetField("STATUS_ID", value);} }
        public String STATUS_NAME { get { return (String)FindField("STATUS_NAME").Value; } set {SetField("STATUS_NAME", value);} }
        public String ERR_TEXT { get { return (String)FindField("ERR_TEXT").Value; } set {SetField("ERR_TEXT", value);} }
        public Decimal? ERR_COUNT { get { return (Decimal?)FindField("ERR_COUNT").Value; } set {SetField("ERR_COUNT", value);} }
        public String MESSAGE_ID { get { return (String)FindField("MESSAGE_ID").Value; } set {SetField("MESSAGE_ID", value);} }
        public DateTime? MESSAGE_DATE { get { return (DateTime?)FindField("MESSAGE_DATE").Value; } set {SetField("MESSAGE_DATE", value);} }
        public String RESPONCE_ID { get { return (String)FindField("RESPONCE_ID").Value; } set {SetField("RESPONCE_ID", value);} }
        public DateTime? RESPONCE_DATE { get { return (DateTime?)FindField("RESPONCE_DATE").Value; } set {SetField("RESPONCE_DATE", value);} }
    }

    public sealed class VEadSyncQueueFilters : BbFilters
    {
        public VEadSyncQueueFilters(BbDataSource Parent) : base (Parent)
        {
            SYNC_ID = new BBDecimalFilter(this, "SYNC_ID");
            CRT_DATE = new BBDateFilter(this, "CRT_DATE");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            OBJ_ID = new BBVarchar2Filter(this, "OBJ_ID");
            RNK = new BBVarchar2Filter(this, "RNK");
            STATUS_ID = new BBVarchar2Filter(this, "STATUS_ID");
            STATUS_NAME = new BBVarchar2Filter(this, "STATUS_NAME");
            ERR_TEXT = new BBVarchar2Filter(this, "ERR_TEXT");
            ERR_COUNT = new BBDecimalFilter(this, "ERR_COUNT");
            MESSAGE_ID = new BBVarchar2Filter(this, "MESSAGE_ID");
            MESSAGE_DATE = new BBDateFilter(this, "MESSAGE_DATE");
            RESPONCE_ID = new BBVarchar2Filter(this, "RESPONCE_ID");
            RESPONCE_DATE = new BBDateFilter(this, "RESPONCE_DATE");
        }
        public BBDecimalFilter SYNC_ID;
        public BBDateFilter CRT_DATE;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter OBJ_ID;
        public BBVarchar2Filter RNK;
        public BBVarchar2Filter STATUS_ID;
        public BBVarchar2Filter STATUS_NAME;
        public BBVarchar2Filter ERR_TEXT;
        public BBDecimalFilter ERR_COUNT;
        public BBVarchar2Filter MESSAGE_ID;
        public BBDateFilter MESSAGE_DATE;
        public BBVarchar2Filter RESPONCE_ID;
        public BBDateFilter RESPONCE_DATE;
    }

    public partial class VEadSyncQueue : BbTable<VEadSyncQueueRecord, VEadSyncQueueFilters>
    {
        public VEadSyncQueue() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VEadSyncQueue(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VEadSyncQueueRecord> Select(VEadSyncQueueRecord Item)
        {
            List<VEadSyncQueueRecord> res = new List<VEadSyncQueueRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VEadSyncQueueRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (DateTime?)null : Convert.ToDateTime(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]),
                        rdr.IsDBNull(5) ? (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]), 
                        rdr.IsDBNull(12) ?  (DateTime?)null : Convert.ToDateTime(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (DateTime?)null : Convert.ToDateTime(rdr[14]))
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