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
    public sealed class VWcsBidScancopyQuestionsRecord : BbRecord
    {
        public VWcsBidScancopyQuestionsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidScancopyQuestionsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidScancopyQuestionsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String SCOPY_ID, String QUESTION_ID, String QUESTION_NAME, String TYPE_ID, String TYPE_NAME, Decimal? IS_REQUIRED)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.SCOPY_ID = SCOPY_ID;
            this.QUESTION_ID = QUESTION_ID;
            this.QUESTION_NAME = QUESTION_NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.IS_REQUIRED = IS_REQUIRED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("SCOPY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Идентификатор карты сканкопий"));
            Fields.Add( new BbField("QUESTION_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Идентификатор вопроса сканкопии"));
            Fields.Add( new BbField("QUESTION_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Наименование вопроса сканкопии"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Идентификатор типа сканкопии"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Наименование типа сканкопии"));
            Fields.Add( new BbField("IS_REQUIRED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_SCANCOPY_QUESTIONS", ObjectTypes.View, "Вопросы карты сканкопий клиента по заявке (Представление)", "Обязательный для заполнения"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String SCOPY_ID { get { return (String)FindField("SCOPY_ID").Value; } set {SetField("SCOPY_ID", value);} }
        public String QUESTION_ID { get { return (String)FindField("QUESTION_ID").Value; } set {SetField("QUESTION_ID", value);} }
        public String QUESTION_NAME { get { return (String)FindField("QUESTION_NAME").Value; } set {SetField("QUESTION_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public Decimal? IS_REQUIRED { get { return (Decimal?)FindField("IS_REQUIRED").Value; } set {SetField("IS_REQUIRED", value);} }
    }

    public sealed class VWcsBidScancopyQuestionsFilters : BbFilters
    {
        public VWcsBidScancopyQuestionsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            SCOPY_ID = new BBVarchar2Filter(this, "SCOPY_ID");
            QUESTION_ID = new BBVarchar2Filter(this, "QUESTION_ID");
            QUESTION_NAME = new BBVarchar2Filter(this, "QUESTION_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            IS_REQUIRED = new BBDecimalFilter(this, "IS_REQUIRED");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter SCOPY_ID;
        public BBVarchar2Filter QUESTION_ID;
        public BBVarchar2Filter QUESTION_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBDecimalFilter IS_REQUIRED;
    }

    public partial class VWcsBidScancopyQuestions : BbTable<VWcsBidScancopyQuestionsRecord, VWcsBidScancopyQuestionsFilters>
    {
        public VWcsBidScancopyQuestions() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidScancopyQuestions(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidScancopyQuestionsRecord> Select(VWcsBidScancopyQuestionsRecord Item)
        {
            List<VWcsBidScancopyQuestionsRecord> res = new List<VWcsBidScancopyQuestionsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidScancopyQuestionsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (Decimal?)null : Convert.ToDecimal(rdr[7]))
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