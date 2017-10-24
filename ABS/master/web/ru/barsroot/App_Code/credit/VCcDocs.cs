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
    public sealed class VCcDocsRecord : BbRecord
    {
        public VCcDocsRecord(): base()
        {
            fillFields();
        }
        public VCcDocsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VCcDocsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? ND, String CC_ID, DateTime? SDATE, String SCHEME_ID, String SCHEME_NAME, Decimal? ADDS, DateTime? VERSION, Decimal? STATE, String TEXT, String COMM, String DONEBY)
            : this(Parent)
        {
            this.ND = ND;
            this.CC_ID = CC_ID;
            this.SDATE = SDATE;
            this.SCHEME_ID = SCHEME_ID;
            this.SCHEME_NAME = SCHEME_NAME;
            this.ADDS = ADDS;
            this.VERSION = VERSION;
            this.STATE = STATE;
            this.TEXT = TEXT;
            this.COMM = COMM;
            this.DONEBY = DONEBY;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ND", OracleDbType.Decimal, false, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Номер договора (референц)"));
            Fields.Add( new BbField("CC_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Идентификатор договора"));
            Fields.Add( new BbField("SDATE", OracleDbType.Date, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Дата заключения договора"));
            Fields.Add( new BbField("SCHEME_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Идентификатор шаблона"));
            Fields.Add( new BbField("SCHEME_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Наименование шаблона"));
            Fields.Add( new BbField("ADDS", OracleDbType.Decimal, false, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Номер доп.соглашения"));
            Fields.Add( new BbField("VERSION", OracleDbType.Date, false, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Версия (дата и время создания)"));
            Fields.Add( new BbField("STATE", OracleDbType.Decimal, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Статус договора"));
            Fields.Add( new BbField("TEXT", OracleDbType.Clob, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Текст договора"));
            Fields.Add( new BbField("COMM", OracleDbType.Varchar2, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Комментарий"));
            Fields.Add( new BbField("DONEBY", OracleDbType.Varchar2, true, false, false, false, false, "V_CC_DOCS", ObjectTypes.View, "Напечатаные документы по договорам", "Исполнитель"));        
        }
        public Decimal? ND { get { return (Decimal?)FindField("ND").Value; } set {SetField("ND", value);} }
        public String CC_ID { get { return (String)FindField("CC_ID").Value; } set {SetField("CC_ID", value);} }
        public DateTime? SDATE { get { return (DateTime?)FindField("SDATE").Value; } set {SetField("SDATE", value);} }
        public String SCHEME_ID { get { return (String)FindField("SCHEME_ID").Value; } set {SetField("SCHEME_ID", value);} }
        public String SCHEME_NAME { get { return (String)FindField("SCHEME_NAME").Value; } set {SetField("SCHEME_NAME", value);} }
        public Decimal? ADDS { get { return (Decimal?)FindField("ADDS").Value; } set {SetField("ADDS", value);} }
        public DateTime? VERSION { get { return (DateTime?)FindField("VERSION").Value; } set {SetField("VERSION", value);} }
        public Decimal? STATE { get { return (Decimal?)FindField("STATE").Value; } set {SetField("STATE", value);} }
        public String TEXT { get { return (String)FindField("TEXT").Value; } set {SetField("TEXT", value);} }
        public String COMM { get { return (String)FindField("COMM").Value; } set {SetField("COMM", value);} }
        public String DONEBY { get { return (String)FindField("DONEBY").Value; } set {SetField("DONEBY", value);} }
    }

    public sealed class VCcDocsFilters : BbFilters
    {
        public VCcDocsFilters(BbDataSource Parent) : base (Parent)
        {
            ND = new BBDecimalFilter(this, "ND");
            CC_ID = new BBVarchar2Filter(this, "CC_ID");
            SDATE = new BBDateFilter(this, "SDATE");
            SCHEME_ID = new BBVarchar2Filter(this, "SCHEME_ID");
            SCHEME_NAME = new BBVarchar2Filter(this, "SCHEME_NAME");
            ADDS = new BBDecimalFilter(this, "ADDS");
            VERSION = new BBDateFilter(this, "VERSION");
            STATE = new BBDecimalFilter(this, "STATE");
            COMM = new BBVarchar2Filter(this, "COMM");
            DONEBY = new BBVarchar2Filter(this, "DONEBY");
        }
        public BBDecimalFilter ND;
        public BBVarchar2Filter CC_ID;
        public BBDateFilter SDATE;
        public BBVarchar2Filter SCHEME_ID;
        public BBVarchar2Filter SCHEME_NAME;
        public BBDecimalFilter ADDS;
        public BBDateFilter VERSION;
        public BBDecimalFilter STATE;
        public BBVarchar2Filter COMM;
        public BBVarchar2Filter DONEBY;
    }

    public partial class VCcDocs : BbTable<VCcDocsRecord, VCcDocsFilters>
    {
        public VCcDocs() : base(new BbConnection(OraConnector.Handler.IOraConnection.GetUserConnectionString()))
        {
        }
        public VCcDocs(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VCcDocsRecord> Select(VCcDocsRecord Item)
        {
            List<VCcDocsRecord> res = new List<VCcDocsRecord>();
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                OracleDataReader rdr = ExecuteReader(Item);
                try
                {
                    while (rdr.Read())
                    {
                        res.Add(new VCcDocsRecord(
                            this,
                            rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                            rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (DateTime?)null : Convert.ToDateTime(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (Decimal?)null : Convert.ToDecimal(rdr[6]), 
                        rdr.IsDBNull(7) ?  (DateTime?)null : Convert.ToDateTime(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (String)null : Convert.ToString(rdr[11]))
                        );
                    }
                }
                finally
                {
                    rdr.Close();
                    rdr.Dispose();
                }
            }
            finally
            {
                if (ConnectionResult.New == connectionResult)
                    Connection.CloseConnection();
            }
            return res;
        }
    }
}
