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
    public sealed class VWcsScoringsRecord : BbRecord
    {
        public VWcsScoringsRecord(): base()
        {
            fillFields();
        }
        public VWcsScoringsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsScoringsRecord(BbDataSource Parent, OracleDecimal RowScn, String SCORING_ID, String SCORING_NAME, Decimal? QUEST_CNT, String RESULT_QID)
            : this(Parent)
        {
            this.SCORING_ID = SCORING_ID;
            this.SCORING_NAME = SCORING_NAME;
            this.QUEST_CNT = QUEST_CNT;
            this.RESULT_QID = RESULT_QID;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SCORING_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SCORINGS", ObjectTypes.View, "Карты скоринга (Представление)", "Идентификатор карты скоринга"));
            Fields.Add( new BbField("SCORING_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SCORINGS", ObjectTypes.View, "Карты скоринга (Представление)", "Наименование карты скоринга"));
            Fields.Add( new BbField("QUEST_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SCORINGS", ObjectTypes.View, "Карты скоринга (Представление)", "Кол-во вопросов в карте"));
            Fields.Add( new BbField("RESULT_QID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SCORINGS", ObjectTypes.View, "Карты скоринга (Представление)", "Идентификатор вопроса-результата вычисления скор. балла"));        
        }
        public String SCORING_ID { get { return (String)FindField("SCORING_ID").Value; } set {SetField("SCORING_ID", value);} }
        public String SCORING_NAME { get { return (String)FindField("SCORING_NAME").Value; } set {SetField("SCORING_NAME", value);} }
        public Decimal? QUEST_CNT { get { return (Decimal?)FindField("QUEST_CNT").Value; } set {SetField("QUEST_CNT", value);} }
        public String RESULT_QID { get { return (String)FindField("RESULT_QID").Value; } set {SetField("RESULT_QID", value);} }
    }

    public sealed class VWcsScoringsFilters : BbFilters
    {
        public VWcsScoringsFilters(BbDataSource Parent) : base (Parent)
        {
            SCORING_ID = new BBVarchar2Filter(this, "SCORING_ID");
            SCORING_NAME = new BBVarchar2Filter(this, "SCORING_NAME");
            QUEST_CNT = new BBDecimalFilter(this, "QUEST_CNT");
            RESULT_QID = new BBVarchar2Filter(this, "RESULT_QID");
        }
        public BBVarchar2Filter SCORING_ID;
        public BBVarchar2Filter SCORING_NAME;
        public BBDecimalFilter QUEST_CNT;
        public BBVarchar2Filter RESULT_QID;
    }

    public partial class VWcsScorings : BbTable<VWcsScoringsRecord, VWcsScoringsFilters>
    {
        public VWcsScorings() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsScorings(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsScoringsRecord> Select(VWcsScoringsRecord Item)
        {
            List<VWcsScoringsRecord> res = new List<VWcsScoringsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsScoringsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]))
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