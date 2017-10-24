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
    public sealed class VWcsBidTemplatesRecord : BbRecord
    {
        public VWcsBidTemplatesRecord(): base()
        {
            fillFields();
        }
        public VWcsBidTemplatesRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidTemplatesRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String TEMPLATE_ID, String TEMPLATE_NAME, String FILE_NAME, String PRINT_STATE_ID, String PRINT_STATE_NAME, String SCAN_QID, String WS_ID, Decimal? WS_NUM, String DOCEXP_TYPE_ID, Byte[] IMG, Decimal? IS_SCAN_REQUIRED)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.TEMPLATE_ID = TEMPLATE_ID;
            this.TEMPLATE_NAME = TEMPLATE_NAME;
            this.FILE_NAME = FILE_NAME;
            this.PRINT_STATE_ID = PRINT_STATE_ID;
            this.PRINT_STATE_NAME = PRINT_STATE_NAME;
            this.SCAN_QID = SCAN_QID;
            this.WS_ID = WS_ID;
            this.WS_NUM = WS_NUM;
            this.DOCEXP_TYPE_ID = DOCEXP_TYPE_ID;
            this.IMG = IMG;
            this.IS_SCAN_REQUIRED = IS_SCAN_REQUIRED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("TEMPLATE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Идентификатор шаблона"));
            Fields.Add( new BbField("TEMPLATE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Наименование шаблона"));
            Fields.Add( new BbField("FILE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Имя файла шаблона из папки TEMPLATE.RPT"));
            Fields.Add( new BbField("PRINT_STATE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Идентификатор этапа печати"));
            Fields.Add( new BbField("PRINT_STATE_NAME", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Наименование этапа печати"));
            Fields.Add( new BbField("SCAN_QID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Идентификатор вопроса-сканкопии печатного документа"));
            Fields.Add( new BbField("WS_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Рабочее пространство"));
            Fields.Add( new BbField("WS_NUM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Номер рабочего пространства"));
            Fields.Add( new BbField("DOCEXP_TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Формат экспорта"));
            Fields.Add( new BbField("IMG", OracleDbType.Blob, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Сканкопия"));
            Fields.Add( new BbField("IS_SCAN_REQUIRED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_TEMPLATES", ObjectTypes.View, "Шаблоны заявки (Представление)", "Обязательно ли сканирование отпечатаного шаблона"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String TEMPLATE_ID { get { return (String)FindField("TEMPLATE_ID").Value; } set {SetField("TEMPLATE_ID", value);} }
        public String TEMPLATE_NAME { get { return (String)FindField("TEMPLATE_NAME").Value; } set {SetField("TEMPLATE_NAME", value);} }
        public String FILE_NAME { get { return (String)FindField("FILE_NAME").Value; } set {SetField("FILE_NAME", value);} }
        public String PRINT_STATE_ID { get { return (String)FindField("PRINT_STATE_ID").Value; } set {SetField("PRINT_STATE_ID", value);} }
        public String PRINT_STATE_NAME { get { return (String)FindField("PRINT_STATE_NAME").Value; } set {SetField("PRINT_STATE_NAME", value);} }
        public String SCAN_QID { get { return (String)FindField("SCAN_QID").Value; } set {SetField("SCAN_QID", value);} }
        public String WS_ID { get { return (String)FindField("WS_ID").Value; } set {SetField("WS_ID", value);} }
        public Decimal? WS_NUM { get { return (Decimal?)FindField("WS_NUM").Value; } set {SetField("WS_NUM", value);} }
        public String DOCEXP_TYPE_ID { get { return (String)FindField("DOCEXP_TYPE_ID").Value; } set {SetField("DOCEXP_TYPE_ID", value);} }
        public Byte[] IMG { get { return (Byte[])FindField("IMG").Value; } set {SetField("IMG", value);} }
        public Decimal? IS_SCAN_REQUIRED { get { return (Decimal?)FindField("IS_SCAN_REQUIRED").Value; } set {SetField("IS_SCAN_REQUIRED", value);} }
    }

    public sealed class VWcsBidTemplatesFilters : BbFilters
    {
        public VWcsBidTemplatesFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            TEMPLATE_ID = new BBVarchar2Filter(this, "TEMPLATE_ID");
            TEMPLATE_NAME = new BBVarchar2Filter(this, "TEMPLATE_NAME");
            FILE_NAME = new BBVarchar2Filter(this, "FILE_NAME");
            PRINT_STATE_ID = new BBVarchar2Filter(this, "PRINT_STATE_ID");
            PRINT_STATE_NAME = new BBVarchar2Filter(this, "PRINT_STATE_NAME");
            SCAN_QID = new BBVarchar2Filter(this, "SCAN_QID");
            WS_ID = new BBVarchar2Filter(this, "WS_ID");
            WS_NUM = new BBDecimalFilter(this, "WS_NUM");
            DOCEXP_TYPE_ID = new BBVarchar2Filter(this, "DOCEXP_TYPE_ID");
            IS_SCAN_REQUIRED = new BBDecimalFilter(this, "IS_SCAN_REQUIRED");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter TEMPLATE_ID;
        public BBVarchar2Filter TEMPLATE_NAME;
        public BBVarchar2Filter FILE_NAME;
        public BBVarchar2Filter PRINT_STATE_ID;
        public BBVarchar2Filter PRINT_STATE_NAME;
        public BBVarchar2Filter SCAN_QID;
        public BBVarchar2Filter WS_ID;
        public BBDecimalFilter WS_NUM;
        public BBVarchar2Filter DOCEXP_TYPE_ID;
        public BBDecimalFilter IS_SCAN_REQUIRED;
    }

    public partial class VWcsBidTemplates : BbTable<VWcsBidTemplatesRecord, VWcsBidTemplatesFilters>
    {
        public VWcsBidTemplates() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidTemplates(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidTemplatesRecord> Select(VWcsBidTemplatesRecord Item)
        {
            List<VWcsBidTemplatesRecord> res = new List<VWcsBidTemplatesRecord>();
            OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidTemplatesRecord(
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
                        rdr.IsDBNull(11) ?  (Byte[])null : (Byte[])rdr[11], 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]))
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