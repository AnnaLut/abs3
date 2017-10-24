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
    public sealed class VWcsQuestionsRecord : BbRecord
    {
        public VWcsQuestionsRecord(): base()
        {
            fillFields();
        }
        public VWcsQuestionsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsQuestionsRecord(BbDataSource Parent, OracleDecimal RowScn, String ID, String NAME, String TYPE_ID, String TYPE_NAME, Decimal? IS_CALCABLE, String CALC_PROC)
            : this(Parent)
        {
            this.ID = ID;
            this.NAME = NAME;
            this.TYPE_ID = TYPE_ID;
            this.TYPE_NAME = TYPE_NAME;
            this.IS_CALCABLE = IS_CALCABLE;
            this.CALC_PROC = CALC_PROC;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Идентификатор"));
            Fields.Add( new BbField("NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Наименование"));
            Fields.Add( new BbField("TYPE_ID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Идентификатор типа"));
            Fields.Add( new BbField("TYPE_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Наименование типа"));
            Fields.Add( new BbField("IS_CALCABLE", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Вычисляемое ли поле"));
            Fields.Add( new BbField("CALC_PROC", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_QUESTIONS", ObjectTypes.View, "Вопросы (Представление)", "Текст вычисления"));        
        }
        public String ID { get { return (String)FindField("ID").Value; } set {SetField("ID", value);} }
        public String NAME { get { return (String)FindField("NAME").Value; } set {SetField("NAME", value);} }
        public String TYPE_ID { get { return (String)FindField("TYPE_ID").Value; } set {SetField("TYPE_ID", value);} }
        public String TYPE_NAME { get { return (String)FindField("TYPE_NAME").Value; } set {SetField("TYPE_NAME", value);} }
        public Decimal? IS_CALCABLE { get { return (Decimal?)FindField("IS_CALCABLE").Value; } set {SetField("IS_CALCABLE", value);} }
        public String CALC_PROC { get { return (String)FindField("CALC_PROC").Value; } set {SetField("CALC_PROC", value);} }
    }

    public sealed class VWcsQuestionsFilters : BbFilters
    {
        public VWcsQuestionsFilters(BbDataSource Parent) : base (Parent)
        {
            ID = new BBVarchar2Filter(this, "ID");
            NAME = new BBVarchar2Filter(this, "NAME");
            TYPE_ID = new BBVarchar2Filter(this, "TYPE_ID");
            TYPE_NAME = new BBVarchar2Filter(this, "TYPE_NAME");
            IS_CALCABLE = new BBDecimalFilter(this, "IS_CALCABLE");
            CALC_PROC = new BBVarchar2Filter(this, "CALC_PROC");
        }
        public BBVarchar2Filter ID;
        public BBVarchar2Filter NAME;
        public BBVarchar2Filter TYPE_ID;
        public BBVarchar2Filter TYPE_NAME;
        public BBDecimalFilter IS_CALCABLE;
        public BBVarchar2Filter CALC_PROC;
    }

    public partial class VWcsQuestions : BbTable<VWcsQuestionsRecord, VWcsQuestionsFilters>
    {
        public VWcsQuestions() : base(new BbConnection())
        {
            //base.Connection.RoleName = "WR_WCS";
        }
        public VWcsQuestions(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsQuestionsRecord> Select(VWcsQuestionsRecord Item)
        {
            List<VWcsQuestionsRecord> res = new List<VWcsQuestionsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsQuestionsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]))
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