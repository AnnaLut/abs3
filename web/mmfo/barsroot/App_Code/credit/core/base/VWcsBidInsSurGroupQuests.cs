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
    public sealed class VWcsBidInsSurGroupQuestsRecord : BbRecord
    {
        public VWcsBidInsSurGroupQuestsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidInsSurGroupQuestsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidInsSurGroupQuestsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String INSURANCE_ID, Decimal? INSURANCE_NUM, String SURVEY_ID, String GROUP_ID, String RECTYPE_ID, String NEXT_RECTYPE_ID, String QUESTION_ID, String QUESTION_NAME, String TYPE_ID, Decimal? IS_CALCABLE, Decimal? IS_REQUIRED, Decimal? IS_READONLY, Decimal? IS_REWRITABLE, Decimal? IS_CHECKABLE, String CHECK_PROC)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.INSURANCE_ID = INSURANCE_ID;
            this.INSURANCE_NUM = INSURANCE_NUM;
            this.SURVEY_ID = SURVEY_ID;
            this.GROUP_ID = GROUP_ID;
            this.RECTYPE_ID = RECTYPE_ID;
            this.NEXT_RECTYPE_ID = NEXT_RECTYPE_ID;
            this.QUESTION_ID = QUESTION_ID;
            this.QUESTION_NAME = QUESTION_NAME;
            this.TYPE_ID = TYPE_ID;
            this.IS_CALCABLE = IS_CALCABLE;
            this.IS_REQUIRED = IS_REQUIRED;
            this.IS_READONLY = IS_READONLY;
            this.IS_REWRITABLE = IS_REWRITABLE;
            this.IS_CHECKABLE = IS_CHECKABLE;
            this.CHECK_PROC = CHECK_PROC;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("INSURANCE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Идентификатор страховки"));
            Fields.Add( new BbField("INSURANCE_NUM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "№ страховки"));
            Fields.Add( new BbField("SURVEY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Идентификатор анкеты"));
            Fields.Add( new BbField("GROUP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Идентификатор групы карты-анкеты"));
            Fields.Add( new BbField("RECTYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Тип записи (вопрос/раздел)"));
            Fields.Add( new BbField("NEXT_RECTYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Тип записи след. строки (вопрос/раздел)"));
            Fields.Add( new BbField("QUESTION_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Идентификатор вопроса"));
            Fields.Add( new BbField("QUESTION_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Наименование вопроса"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Тип"));
            Fields.Add( new BbField("IS_CALCABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Вычисляемое ли поле"));
            Fields.Add( new BbField("IS_REQUIRED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Обязателен для заполнения"));
            Fields.Add( new BbField("IS_READONLY", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Только чтение"));
            Fields.Add( new BbField("IS_REWRITABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Возможность перезаписи"));
            Fields.Add( new BbField("IS_CHECKABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Проверяется ли поле"));
            Fields.Add( new BbField("CHECK_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INS_SUR_GROUP_QUESTS", ObjectTypes.View, "Вопросы анкеты страховки (Представление)", "Текст проверки"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String INSURANCE_ID { get { return (String)FindField("INSURANCE_ID").Value; } set {SetField("INSURANCE_ID", value);} }
        public Decimal? INSURANCE_NUM { get { return (Decimal?)FindField("INSURANCE_NUM").Value; } set {SetField("INSURANCE_NUM", value);} }
        public String SURVEY_ID { get { return (String)FindField("SURVEY_ID").Value; } set {SetField("SURVEY_ID", value);} }
        public String GROUP_ID { get { return (String)FindField("GROUP_ID").Value; } set {SetField("GROUP_ID", value);} }
        public String RECTYPE_ID { get { return (String)FindField("RECTYPE_ID").Value; } set {SetField("RECTYPE_ID", value);} }
        public String NEXT_RECTYPE_ID { get { return (String)FindField("NEXT_RECTYPE_ID").Value; } set {SetField("NEXT_RECTYPE_ID", value);} }
        public String QUESTION_ID { get { return (String)FindField("QUESTION_ID").Value; } set {SetField("QUESTION_ID", value);} }
        public String QUESTION_NAME { get { return (String)FindField("QUESTION_NAME").Value; } set {SetField("QUESTION_NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public Decimal? IS_CALCABLE { get { return (Decimal?)FindField("IS_CALCABLE").Value; } set {SetField("IS_CALCABLE", value);} }
        public Decimal? IS_REQUIRED { get { return (Decimal?)FindField("IS_REQUIRED").Value; } set {SetField("IS_REQUIRED", value);} }
        public Decimal? IS_READONLY { get { return (Decimal?)FindField("IS_READONLY").Value; } set {SetField("IS_READONLY", value);} }
        public Decimal? IS_REWRITABLE { get { return (Decimal?)FindField("IS_REWRITABLE").Value; } set {SetField("IS_REWRITABLE", value);} }
        public Decimal? IS_CHECKABLE { get { return (Decimal?)FindField("IS_CHECKABLE").Value; } set {SetField("IS_CHECKABLE", value);} }
        public String CHECK_PROC { get { return (String)FindField("CHECK_PROC").Value; } set {SetField("CHECK_PROC", value);} }
    }

    public sealed class VWcsBidInsSurGroupQuestsFilters : BbFilters
    {
        public VWcsBidInsSurGroupQuestsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            INSURANCE_ID = new BBVarchar2Filter(this, "INSURANCE_ID");
            INSURANCE_NUM = new BBDecimalFilter(this, "INSURANCE_NUM");
            SURVEY_ID = new BBVarchar2Filter(this, "SURVEY_ID");
            GROUP_ID = new BBVarchar2Filter(this, "GROUP_ID");
            RECTYPE_ID = new BBVarchar2Filter(this, "RECTYPE_ID");
            NEXT_RECTYPE_ID = new BBVarchar2Filter(this, "NEXT_RECTYPE_ID");
            QUESTION_ID = new BBVarchar2Filter(this, "QUESTION_ID");
            QUESTION_NAME = new BBVarchar2Filter(this, "QUESTION_NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            IS_CALCABLE = new BBDecimalFilter(this, "IS_CALCABLE");
            IS_REQUIRED = new BBDecimalFilter(this, "IS_REQUIRED");
            IS_READONLY = new BBDecimalFilter(this, "IS_READONLY");
            IS_REWRITABLE = new BBDecimalFilter(this, "IS_REWRITABLE");
            IS_CHECKABLE = new BBDecimalFilter(this, "IS_CHECKABLE");
            CHECK_PROC = new BBVarchar2Filter(this, "CHECK_PROC");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter INSURANCE_ID;
        public BBDecimalFilter INSURANCE_NUM;
        public BBVarchar2Filter SURVEY_ID;
        public BBVarchar2Filter GROUP_ID;
        public BBVarchar2Filter RECTYPE_ID;
        public BBVarchar2Filter NEXT_RECTYPE_ID;
        public BBVarchar2Filter QUESTION_ID;
        public BBVarchar2Filter QUESTION_NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBDecimalFilter IS_CALCABLE;
        public BBDecimalFilter IS_REQUIRED;
        public BBDecimalFilter IS_READONLY;
        public BBDecimalFilter IS_REWRITABLE;
        public BBDecimalFilter IS_CHECKABLE;
        public BBVarchar2Filter CHECK_PROC;
    }

    public partial class VWcsBidInsSurGroupQuests : BbTable<VWcsBidInsSurGroupQuestsRecord, VWcsBidInsSurGroupQuestsFilters>
    {
        public VWcsBidInsSurGroupQuests() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidInsSurGroupQuests(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidInsSurGroupQuestsRecord> Select(VWcsBidInsSurGroupQuestsRecord Item)
        {
            List<VWcsBidInsSurGroupQuestsRecord> res = new List<VWcsBidInsSurGroupQuestsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidInsSurGroupQuestsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (String)null : Convert.ToString(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (Decimal?)null : Convert.ToDecimal(rdr[12]), 
                        rdr.IsDBNull(13) ?  (Decimal?)null : Convert.ToDecimal(rdr[13]), 
                        rdr.IsDBNull(14) ?  (Decimal?)null : Convert.ToDecimal(rdr[14]), 
                        rdr.IsDBNull(15) ?  (Decimal?)null : Convert.ToDecimal(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]))
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