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
    public sealed class VWcsQuestionParamsRecord : BbRecord
    {
        public VWcsQuestionParamsRecord(): base()
        {
            fillFields();
        }
        public VWcsQuestionParamsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsQuestionParamsRecord(BbDataSource Parent, OracleDecimal RowScn, String ID, String NAME, String TYPE_ID, String TYPE_NAME, Decimal? IS_CALCABLE, String CALC_PROC, String TEXT_LENG_MIN, String TEXT_LENG_MAX, String TEXT_VAL_DEFAULT, Decimal? TEXT_WIDTH, Decimal? TEXT_ROWS, String NMBDEC_VAL_MIN, String NMBDEC_VAL_MAX, String NMBDEC_VAL_DEFAULT, String DAT_VAL_MIN, String DAT_VAL_MAX, String DAT_VAL_DEFAULT, String LIST_SID_DEFAULT, Decimal? TAB_ID, String KEY_FIELD, String SEMANTIC_FIELD, String SHOW_FIELDS, String WHERE_CLAUSE, String REFER_SID_DEFAULT, String BOOL_VAL_DEFAULT)
            : this(Parent)
        {
            this.ID = ID;
            this.NAME = NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.IS_CALCABLE = IS_CALCABLE;
            this.CALC_PROC = CALC_PROC;
            this.TEXT_LENG_MIN = TEXT_LENG_MIN;
            this.TEXT_LENG_MAX = TEXT_LENG_MAX;
            this.TEXT_VAL_DEFAULT = TEXT_VAL_DEFAULT;
            this.TEXT_WIDTH = TEXT_WIDTH;
            this.TEXT_ROWS = TEXT_ROWS;
            this.NMBDEC_VAL_MIN = NMBDEC_VAL_MIN;
            this.NMBDEC_VAL_MAX = NMBDEC_VAL_MAX;
            this.NMBDEC_VAL_DEFAULT = NMBDEC_VAL_DEFAULT;
            this.DAT_VAL_MIN = DAT_VAL_MIN;
            this.DAT_VAL_MAX = DAT_VAL_MAX;
            this.DAT_VAL_DEFAULT = DAT_VAL_DEFAULT;
            this.LIST_SID_DEFAULT = LIST_SID_DEFAULT;
            this.TAB_ID = TAB_ID;
            this.KEY_FIELD = KEY_FIELD;
            this.SEMANTIC_FIELD = SEMANTIC_FIELD;
            this.SHOW_FIELDS = SHOW_FIELDS;
            this.WHERE_CLAUSE = WHERE_CLAUSE;
            this.REFER_SID_DEFAULT = REFER_SID_DEFAULT;
            this.BOOL_VAL_DEFAULT = BOOL_VAL_DEFAULT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Идентификатор"));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Наименование"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Идентификатор типа"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Наименование типа"));
            Fields.Add( new BbField("IS_CALCABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Вычисляемое ли поле"));
            Fields.Add( new BbField("CALC_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Текст вычисления"));
            Fields.Add( new BbField("TEXT_LENG_MIN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Минимальная длина текстового поля"));
            Fields.Add( new BbField("TEXT_LENG_MAX", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Максимальная длина текстового поля"));
            Fields.Add( new BbField("TEXT_VAL_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение текстового поля"));
            Fields.Add( new BbField("TEXT_WIDTH", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Ширина текстового поля"));
            Fields.Add( new BbField("TEXT_ROWS", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Кол-во рядков текстового поля"));
            Fields.Add( new BbField("NMBDEC_VAL_MIN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Минимальное значение числа"));
            Fields.Add( new BbField("NMBDEC_VAL_MAX", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Максимальное значение числа"));
            Fields.Add( new BbField("NMBDEC_VAL_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение числа"));
            Fields.Add( new BbField("DAT_VAL_MIN", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Минимальное значение даты"));
            Fields.Add( new BbField("DAT_VAL_MAX", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Максимальное значение даты"));
            Fields.Add( new BbField("DAT_VAL_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение даты"));
            Fields.Add( new BbField("LIST_SID_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение выбраное из списка"));
            Fields.Add( new BbField("TAB_ID", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Идентификатор таблицы справочника"));
            Fields.Add( new BbField("KEY_FIELD", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Ключевое поле"));
            Fields.Add( new BbField("SEMANTIC_FIELD", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Поле семантики"));
            Fields.Add( new BbField("SHOW_FIELDS", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Поля для отображения (перечисление через запятую)"));
            Fields.Add( new BbField("WHERE_CLAUSE", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Условие отбора (включая слово where)"));
            Fields.Add( new BbField("REFER_SID_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение выбраное из справочника"));
            Fields.Add( new BbField("BOOL_VAL_DEFAULT", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTION_PARAMS", ObjectTypes.View, "Парамерты вопроса заявки (Представление)", "Дефолтное значение булевого вопроса"));        
        }
        public String ID { get { return (String)FindField("ID").Value; } set {SetField("ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public Decimal? IS_CALCABLE { get { return (Decimal?)FindField("IS_CALCABLE").Value; } set {SetField("IS_CALCABLE", value);} }
        public String CALC_PROC { get { return (String)FindField("CALC_PROC").Value; } set {SetField("CALC_PROC", value);} }
        public String TEXT_LENG_MIN { get { return (String)FindField("TEXT_LENG_MIN").Value; } set {SetField("TEXT_LENG_MIN", value);} }
        public String TEXT_LENG_MAX { get { return (String)FindField("TEXT_LENG_MAX").Value; } set {SetField("TEXT_LENG_MAX", value);} }
        public String TEXT_VAL_DEFAULT { get { return (String)FindField("TEXT_VAL_DEFAULT").Value; } set {SetField("TEXT_VAL_DEFAULT", value);} }
        public Decimal? TEXT_WIDTH { get { return (Decimal?)FindField("TEXT_WIDTH").Value; } set {SetField("TEXT_WIDTH", value);} }
        public Decimal? TEXT_ROWS { get { return (Decimal?)FindField("TEXT_ROWS").Value; } set {SetField("TEXT_ROWS", value);} }
        public String NMBDEC_VAL_MIN { get { return (String)FindField("NMBDEC_VAL_MIN").Value; } set {SetField("NMBDEC_VAL_MIN", value);} }
        public String NMBDEC_VAL_MAX { get { return (String)FindField("NMBDEC_VAL_MAX").Value; } set {SetField("NMBDEC_VAL_MAX", value);} }
        public String NMBDEC_VAL_DEFAULT { get { return (String)FindField("NMBDEC_VAL_DEFAULT").Value; } set {SetField("NMBDEC_VAL_DEFAULT", value);} }
        public String DAT_VAL_MIN { get { return (String)FindField("DAT_VAL_MIN").Value; } set {SetField("DAT_VAL_MIN", value);} }
        public String DAT_VAL_MAX { get { return (String)FindField("DAT_VAL_MAX").Value; } set {SetField("DAT_VAL_MAX", value);} }
        public String DAT_VAL_DEFAULT { get { return (String)FindField("DAT_VAL_DEFAULT").Value; } set {SetField("DAT_VAL_DEFAULT", value);} }
        public String LIST_SID_DEFAULT { get { return (String)FindField("LIST_SID_DEFAULT").Value; } set {SetField("LIST_SID_DEFAULT", value);} }
        public Decimal? TAB_ID { get { return (Decimal?)FindField("TAB_ID").Value; } set {SetField("TAB_ID", value);} }
        public String KEY_FIELD { get { return (String)FindField("KEY_FIELD").Value; } set {SetField("KEY_FIELD", value);} }
        public String SEMANTIC_FIELD { get { return (String)FindField("SEMANTIC_FIELD").Value; } set {SetField("SEMANTIC_FIELD", value);} }
        public String SHOW_FIELDS { get { return (String)FindField("SHOW_FIELDS").Value; } set {SetField("SHOW_FIELDS", value);} }
        public String WHERE_CLAUSE { get { return (String)FindField("WHERE_CLAUSE").Value; } set {SetField("WHERE_CLAUSE", value);} }
        public String REFER_SID_DEFAULT { get { return (String)FindField("REFER_SID_DEFAULT").Value; } set {SetField("REFER_SID_DEFAULT", value);} }
        public String BOOL_VAL_DEFAULT { get { return (String)FindField("BOOL_VAL_DEFAULT").Value; } set {SetField("BOOL_VAL_DEFAULT", value);} }
    }

    public sealed class VWcsQuestionParamsFilters : BbFilters
    {
        public VWcsQuestionParamsFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBVarchar2Filter(this, "ID");
            NAME = new BBVarchar2Filter(this, "NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            IS_CALCABLE = new BBDecimalFilter(this, "IS_CALCABLE");
            CALC_PROC = new BBVarchar2Filter(this, "CALC_PROC");
            TEXT_LENG_MIN = new BBVarchar2Filter(this, "TEXT_LENG_MIN");
            TEXT_LENG_MAX = new BBVarchar2Filter(this, "TEXT_LENG_MAX");
            TEXT_VAL_DEFAULT = new BBVarchar2Filter(this, "TEXT_VAL_DEFAULT");
            TEXT_WIDTH = new BBDecimalFilter(this, "TEXT_WIDTH");
            TEXT_ROWS = new BBDecimalFilter(this, "TEXT_ROWS");
            NMBDEC_VAL_MIN = new BBVarchar2Filter(this, "NMBDEC_VAL_MIN");
            NMBDEC_VAL_MAX = new BBVarchar2Filter(this, "NMBDEC_VAL_MAX");
            NMBDEC_VAL_DEFAULT = new BBVarchar2Filter(this, "NMBDEC_VAL_DEFAULT");
            DAT_VAL_MIN = new BBVarchar2Filter(this, "DAT_VAL_MIN");
            DAT_VAL_MAX = new BBVarchar2Filter(this, "DAT_VAL_MAX");
            DAT_VAL_DEFAULT = new BBVarchar2Filter(this, "DAT_VAL_DEFAULT");
            LIST_SID_DEFAULT = new BBVarchar2Filter(this, "LIST_SID_DEFAULT");
            TAB_ID = new BBDecimalFilter(this, "TAB_ID");
            KEY_FIELD = new BBVarchar2Filter(this, "KEY_FIELD");
            SEMANTIC_FIELD = new BBVarchar2Filter(this, "SEMANTIC_FIELD");
            SHOW_FIELDS = new BBVarchar2Filter(this, "SHOW_FIELDS");
            WHERE_CLAUSE = new BBVarchar2Filter(this, "WHERE_CLAUSE");
            REFER_SID_DEFAULT = new BBVarchar2Filter(this, "REFER_SID_DEFAULT");
            BOOL_VAL_DEFAULT = new BBVarchar2Filter(this, "BOOL_VAL_DEFAULT");
        }
        public BBVarchar2Filter ID;
        public BBVarchar2Filter NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBDecimalFilter IS_CALCABLE;
        public BBVarchar2Filter CALC_PROC;
        public BBVarchar2Filter TEXT_LENG_MIN;
        public BBVarchar2Filter TEXT_LENG_MAX;
        public BBVarchar2Filter TEXT_VAL_DEFAULT;
        public BBDecimalFilter TEXT_WIDTH;
        public BBDecimalFilter TEXT_ROWS;
        public BBVarchar2Filter NMBDEC_VAL_MIN;
        public BBVarchar2Filter NMBDEC_VAL_MAX;
        public BBVarchar2Filter NMBDEC_VAL_DEFAULT;
        public BBVarchar2Filter DAT_VAL_MIN;
        public BBVarchar2Filter DAT_VAL_MAX;
        public BBVarchar2Filter DAT_VAL_DEFAULT;
        public BBVarchar2Filter LIST_SID_DEFAULT;
        public BBDecimalFilter TAB_ID;
        public BBVarchar2Filter KEY_FIELD;
        public BBVarchar2Filter SEMANTIC_FIELD;
        public BBVarchar2Filter SHOW_FIELDS;
        public BBVarchar2Filter WHERE_CLAUSE;
        public BBVarchar2Filter REFER_SID_DEFAULT;
        public BBVarchar2Filter BOOL_VAL_DEFAULT;
    }

    public partial class VWcsQuestionParams : BbTable<VWcsQuestionParamsRecord, VWcsQuestionParamsFilters>
    {
        public VWcsQuestionParams() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsQuestionParams(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsQuestionParamsRecord> Select(VWcsQuestionParamsRecord Item)
        {
            List<VWcsQuestionParamsRecord> res = new List<VWcsQuestionParamsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsQuestionParamsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (String)null : Convert.ToString(rdr[8]), 
                        rdr.IsDBNull(9) ?  (String)null : Convert.ToString(rdr[9]), 
                        rdr.IsDBNull(10) ?  (Decimal?)null : Convert.ToDecimal(rdr[10]), 
                        rdr.IsDBNull(11) ?  (Decimal?)null : Convert.ToDecimal(rdr[11]), 
                        rdr.IsDBNull(12) ?  (String)null : Convert.ToString(rdr[12]), 
                        rdr.IsDBNull(13) ?  (String)null : Convert.ToString(rdr[13]), 
                        rdr.IsDBNull(14) ?  (String)null : Convert.ToString(rdr[14]), 
                        rdr.IsDBNull(15) ?  (String)null : Convert.ToString(rdr[15]), 
                        rdr.IsDBNull(16) ?  (String)null : Convert.ToString(rdr[16]), 
                        rdr.IsDBNull(17) ?  (String)null : Convert.ToString(rdr[17]), 
                        rdr.IsDBNull(18) ?  (String)null : Convert.ToString(rdr[18]), 
                        rdr.IsDBNull(19) ?  (Decimal?)null : Convert.ToDecimal(rdr[19]), 
                        rdr.IsDBNull(20) ?  (String)null : Convert.ToString(rdr[20]), 
                        rdr.IsDBNull(21) ?  (String)null : Convert.ToString(rdr[21]), 
                        rdr.IsDBNull(22) ?  (String)null : Convert.ToString(rdr[22]), 
                        rdr.IsDBNull(23) ?  (String)null : Convert.ToString(rdr[23]), 
                        rdr.IsDBNull(24) ?  (String)null : Convert.ToString(rdr[24]), 
                        rdr.IsDBNull(25) ?  (String)null : Convert.ToString(rdr[25]))
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