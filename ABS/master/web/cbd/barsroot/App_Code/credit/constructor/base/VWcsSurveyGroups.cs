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
    public sealed class VWcsSurveyGroupsRecord : BbRecord
    {
        public VWcsSurveyGroupsRecord(): base()
        {
            fillFields();
        }
        public VWcsSurveyGroupsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsSurveyGroupsRecord(BbDataSource Parent, OracleDecimal RowScn, String SURVEY_ID, String GROUP_ID, String GROUP_NAME, String DNSHOW_IF, Decimal? ORD, String RESULT_QID, Decimal? QUEST_CNT)
            : this(Parent)
        {
            this.SURVEY_ID = SURVEY_ID;
            this.GROUP_ID = GROUP_ID;
            this.GROUP_NAME = GROUP_NAME;
            this.DNSHOW_IF = DNSHOW_IF;
            this.ORD = ORD;
            this.RESULT_QID = RESULT_QID;
            this.QUEST_CNT = QUEST_CNT;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("SURVEY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Идентификатор карты-анкеты"));
            Fields.Add( new BbField("GROUP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Идентификатор"));
            Fields.Add( new BbField("GROUP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Наименование"));
            Fields.Add( new BbField("DNSHOW_IF", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Условие по которому не показывать группу"));
            Fields.Add( new BbField("ORD", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Порядок отображения"));
            Fields.Add( new BbField("RESULT_QID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Идентификатор вопроса-результата заполнения группы"));
            Fields.Add( new BbField("QUEST_CNT", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты (Представление)", "Кол-во вопросов в групе"));        
        }
        public String SURVEY_ID { get { return (String)FindField("SURVEY_ID").Value; } set {SetField("SURVEY_ID", value);} }
        public String GROUP_ID { get { return (String)FindField("GROUP_ID").Value; } set {SetField("GROUP_ID", value);} }
        public String GROUP_NAME { get { return (String)FindField("GROUP_NAME").Value; } set {SetField("GROUP_NAME", value);} }
        public String DNSHOW_IF { get { return (String)FindField("DNSHOW_IF").Value; } set {SetField("DNSHOW_IF", value);} }
        public Decimal? ORD { get { return (Decimal?)FindField("ORD").Value; } set {SetField("ORD", value);} }
        public String RESULT_QID { get { return (String)FindField("RESULT_QID").Value; } set {SetField("RESULT_QID", value);} }
        public Decimal? QUEST_CNT { get { return (Decimal?)FindField("QUEST_CNT").Value; } set {SetField("QUEST_CNT", value);} }
    }

    public sealed class VWcsSurveyGroupsFilters : BbFilters
    {
        public VWcsSurveyGroupsFilters(BbDataSource Parent) : base (Parent)
        {
            SURVEY_ID = new BBVarchar2Filter(this, "SURVEY_ID");
            GROUP_ID = new BBVarchar2Filter(this, "GROUP_ID");
            GROUP_NAME = new BBVarchar2Filter(this, "GROUP_NAME");
            DNSHOW_IF = new BBVarchar2Filter(this, "DNSHOW_IF");
            ORD = new BBDecimalFilter(this, "ORD");
            RESULT_QID = new BBVarchar2Filter(this, "RESULT_QID");
            QUEST_CNT = new BBDecimalFilter(this, "QUEST_CNT");
        }
        public BBVarchar2Filter SURVEY_ID;
        public BBVarchar2Filter GROUP_ID;
        public BBVarchar2Filter GROUP_NAME;
        public BBVarchar2Filter DNSHOW_IF;
        public BBDecimalFilter ORD;
        public BBVarchar2Filter RESULT_QID;
        public BBDecimalFilter QUEST_CNT;
    }

    public partial class VWcsSurveyGroups : BbTable<VWcsSurveyGroupsRecord, VWcsSurveyGroupsFilters>
    {
        public VWcsSurveyGroups() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsSurveyGroups(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsSurveyGroupsRecord> Select(VWcsSurveyGroupsRecord Item)
        {
            List<VWcsSurveyGroupsRecord> res = new List<VWcsSurveyGroupsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsSurveyGroupsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (String)null : Convert.ToString(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (String)null : Convert.ToString(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (Decimal?)null : Convert.ToDecimal(rdr[5]), 
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