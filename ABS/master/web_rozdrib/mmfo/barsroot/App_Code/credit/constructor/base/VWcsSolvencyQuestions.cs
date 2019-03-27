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
    public sealed class VWcsSolvencyQuestionsRecord : BbRecord
    {
        public VWcsSolvencyQuestionsRecord(): base()
        {
            fillFields();
        }
        public VWcsSolvencyQuestionsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSolvencyQuestionsRecord(BbDataSource Parent, OracleDecimal RowScn, String SOLVENCY_ID, String QUESTION_ID, String QUESTION_NAME, String QUESTION_DESC, String TYPE_ID, String TYPE_NAME, String CALC_PROC)
            : this(Parent)
        {
            this.SOLVENCY_ID = SOLVENCY_ID;
            this.QUESTION_ID = QUESTION_ID;
            this.QUESTION_NAME = QUESTION_NAME;
            this.QUESTION_DESC = QUESTION_DESC;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.CALC_PROC = CALC_PROC;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SOLVENCY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Идентификатор карты кредитоспособности"));
            Fields.Add( new BbField("QUESTION_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Идентификатор вопроса"));
            Fields.Add( new BbField("QUESTION_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Наименование вопроса"));
            Fields.Add( new BbField("QUESTION_DESC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Наименование вопроса расширеное"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Тип вопроса"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Наименование типа вопроса"));
            Fields.Add( new BbField("CALC_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SOLVENCY_QUESTIONS", ObjectTypes.View, "Вопросы карты кредитоспособности (Представление)", "Текст вычисления"));        
        }
        public String SOLVENCY_ID { get { return (String)FindField("SOLVENCY_ID").Value; } set {SetField("SOLVENCY_ID", value);} }
        public String QUESTION_ID { get { return (String)FindField("QUESTION_ID").Value; } set {SetField("QUESTION_ID", value);} }
        public String QUESTION_NAME { get { return (String)FindField("QUESTION_NAME").Value; } set {SetField("QUESTION_NAME", value);} }
        public String QUESTION_DESC { get { return (String)FindField("QUESTION_DESC").Value; } set {SetField("QUESTION_DESC", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public String CALC_PROC { get { return (String)FindField("CALC_PROC").Value; } set {SetField("CALC_PROC", value);} }
    }

    public sealed class VWcsSolvencyQuestionsFilters : BbFilters
    {
        public VWcsSolvencyQuestionsFilters(BbDataSource Parent) : base (Parent)
        {
            SOLVENCY_ID = new BBVarchar2Filter(this, "SOLVENCY_ID");
            QUESTION_ID = new BBVarchar2Filter(this, "QUESTION_ID");
            QUESTION_NAME = new BBVarchar2Filter(this, "QUESTION_NAME");
            QUESTION_DESC = new BBVarchar2Filter(this, "QUESTION_DESC");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            CALC_PROC = new BBVarchar2Filter(this, "CALC_PROC");
        }
        public BBVarchar2Filter SOLVENCY_ID;
        public BBVarchar2Filter QUESTION_ID;
        public BBVarchar2Filter QUESTION_NAME;
        public BBVarchar2Filter QUESTION_DESC;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBVarchar2Filter CALC_PROC;
    }

    public partial class VWcsSolvencyQuestions : BbTable<VWcsSolvencyQuestionsRecord, VWcsSolvencyQuestionsFilters>
    {
        public VWcsSolvencyQuestions() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSolvencyQuestions(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSolvencyQuestionsRecord> Select(VWcsSolvencyQuestionsRecord Item)
        {
            List<VWcsSolvencyQuestionsRecord> res = new List<VWcsSolvencyQuestionsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSolvencyQuestionsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]))
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