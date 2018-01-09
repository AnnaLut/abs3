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
    public sealed class VWcsSubproductScoringRecord : BbRecord
    {
        public VWcsSubproductScoringRecord(): base()
        {
            fillFields();
        }
        public VWcsSubproductScoringRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSubproductScoringRecord(BbDataSource Parent, OracleDecimal RowScn, String SUBPRODUCT_ID, String SCORING_ID, String SCORING_NAME, Decimal? QUEST_CNT)
            : this(Parent)
        {
            this.SUBPRODUCT_ID = SUBPRODUCT_ID;
            this.SCORING_ID = SCORING_ID;
            this.SCORING_NAME = SCORING_NAME;
            this.QUEST_CNT = QUEST_CNT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SUBPRODUCT_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_SCORING", ObjectTypes.View, "Карта скоринга (фин. сост.) субпродукта (Представление)", "Идентификатор субродукта"));
            Fields.Add( new BbField("SCORING_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_SCORING", ObjectTypes.View, "Карта скоринга (фин. сост.) субпродукта (Представление)", "Идентификатор карты скоринга"));
            Fields.Add( new BbField("SCORING_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SUBPRODUCT_SCORING", ObjectTypes.View, "Карта скоринга (фин. сост.) субпродукта (Представление)", "Наименование карты скоринга"));
            Fields.Add( new BbField("QUEST_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SUBPRODUCT_SCORING", ObjectTypes.View, "Карта скоринга (фин. сост.) субпродукта (Представление)", "Кол-во вопросов в карте"));        
        }
        public String SUBPRODUCT_ID { get { return (String)FindField("SUBPRODUCT_ID").Value; } set {SetField("SUBPRODUCT_ID", value);} }
        public String SCORING_ID { get { return (String)FindField("SCORING_ID").Value; } set {SetField("SCORING_ID", value);} }
        public String SCORING_NAME { get { return (String)FindField("SCORING_NAME").Value; } set {SetField("SCORING_NAME", value);} }
        public Decimal? QUEST_CNT { get { return (Decimal?)FindField("QUEST_CNT").Value; } set {SetField("QUEST_CNT", value);} }
    }

    public sealed class VWcsSubproductScoringFilters : BbFilters
    {
        public VWcsSubproductScoringFilters(BbDataSource Parent) : base (Parent)
        {
            SUBPRODUCT_ID = new BBVarchar2Filter(this, "SUBPRODUCT_ID");
            SCORING_ID = new BBVarchar2Filter(this, "SCORING_ID");
            SCORING_NAME = new BBVarchar2Filter(this, "SCORING_NAME");
            QUEST_CNT = new BBDecimalFilter(this, "QUEST_CNT");
        }
        public BBVarchar2Filter SUBPRODUCT_ID;
        public BBVarchar2Filter SCORING_ID;
        public BBVarchar2Filter SCORING_NAME;
        public BBDecimalFilter QUEST_CNT;
    }

    public partial class VWcsSubproductScoring : BbTable<VWcsSubproductScoringRecord, VWcsSubproductScoringFilters>
    {
        public VWcsSubproductScoring() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSubproductScoring(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSubproductScoringRecord> Select(VWcsSubproductScoringRecord Item)
        {
            List<VWcsSubproductScoringRecord> res = new List<VWcsSubproductScoringRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSubproductScoringRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (Decimal?)null : Convert.ToDecimal(rdr[4]))
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