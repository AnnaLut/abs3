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
    public sealed class VWcsBidInsSurveyGroupsRecord : BbRecord
    {
        public VWcsBidInsSurveyGroupsRecord(): base()
        {
            fillFields();
        }
        public VWcsBidInsSurveyGroupsRecord(BbDataSource Parent) : base (Parent)
        {
            fillFields();
        }
        public VWcsBidInsSurveyGroupsRecord(BbDataSource Parent, OracleDecimal RowScn, Decimal? BID_ID, String INSURANCE_ID, Decimal? INSURANCE_NUM, String SURVEY_ID, String GROUP_ID, String GROUP_NAME, String RESULT_QID, Decimal? IS_FILLED)
            : this(Parent)
        {
            this.BID_ID = BID_ID;
            this.INSURANCE_ID = INSURANCE_ID;
            this.INSURANCE_NUM = INSURANCE_NUM;
            this.SURVEY_ID = SURVEY_ID;
            this.GROUP_ID = GROUP_ID;
            this.GROUP_NAME = GROUP_NAME;
            this.RESULT_QID = RESULT_QID;
            this.IS_FILLED = IS_FILLED;
            this.RowScn = RowScn;
            this.IsRowscnSupported = false;
            this.ClearChanges();
        }
        private void fillFields()
        {
            Fields.Add( new BbField("BID_ID", OracleDbType.Decimal, false, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Идентификатор заявки"));
            Fields.Add( new BbField("INSURANCE_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Идентификатор страховки"));
            Fields.Add( new BbField("INSURANCE_NUM", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "№ страховки"));
            Fields.Add( new BbField("SURVEY_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Идентификатор анкеты"));
            Fields.Add( new BbField("GROUP_ID", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Идентификатор групы карты-анкеты"));
            Fields.Add( new BbField("GROUP_NAME", OracleDbType.Varchar2, false, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Наименование групы карты-анкеты"));
            Fields.Add( new BbField("RESULT_QID", OracleDbType.Varchar2, true, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Идентификатор вопроса-результата заполнения группы"));
            Fields.Add( new BbField("IS_FILLED", OracleDbType.Decimal, true, false, false, false, false, "V_WCS_BID_INS_SURVEY_GROUPS", ObjectTypes.View, "Групы анкеты страховки заявки (Представление)", "Флаг заполнености группы"));        
        }
        public Decimal? BID_ID { get { return (Decimal?)FindField("BID_ID").Value; } set {SetField("BID_ID", value);} }
        public String INSURANCE_ID { get { return (String)FindField("INSURANCE_ID").Value; } set {SetField("INSURANCE_ID", value);} }
        public Decimal? INSURANCE_NUM { get { return (Decimal?)FindField("INSURANCE_NUM").Value; } set {SetField("INSURANCE_NUM", value);} }
        public String SURVEY_ID { get { return (String)FindField("SURVEY_ID").Value; } set {SetField("SURVEY_ID", value);} }
        public String GROUP_ID { get { return (String)FindField("GROUP_ID").Value; } set {SetField("GROUP_ID", value);} }
        public String GROUP_NAME { get { return (String)FindField("GROUP_NAME").Value; } set {SetField("GROUP_NAME", value);} }
        public String RESULT_QID { get { return (String)FindField("RESULT_QID").Value; } set {SetField("RESULT_QID", value);} }
        public Decimal? IS_FILLED { get { return (Decimal?)FindField("IS_FILLED").Value; } set {SetField("IS_FILLED", value);} }
    }

    public sealed class VWcsBidInsSurveyGroupsFilters : BbFilters
    {
        public VWcsBidInsSurveyGroupsFilters(BbDataSource Parent) : base (Parent)
        {
            BID_ID = new BBDecimalFilter(this, "BID_ID");
            INSURANCE_ID = new BBVarchar2Filter(this, "INSURANCE_ID");
            INSURANCE_NUM = new BBDecimalFilter(this, "INSURANCE_NUM");
            SURVEY_ID = new BBVarchar2Filter(this, "SURVEY_ID");
            GROUP_ID = new BBVarchar2Filter(this, "GROUP_ID");
            GROUP_NAME = new BBVarchar2Filter(this, "GROUP_NAME");
            RESULT_QID = new BBVarchar2Filter(this, "RESULT_QID");
            IS_FILLED = new BBDecimalFilter(this, "IS_FILLED");
        }
        public BBDecimalFilter BID_ID;
        public BBVarchar2Filter INSURANCE_ID;
        public BBDecimalFilter INSURANCE_NUM;
        public BBVarchar2Filter SURVEY_ID;
        public BBVarchar2Filter GROUP_ID;
        public BBVarchar2Filter GROUP_NAME;
        public BBVarchar2Filter RESULT_QID;
        public BBDecimalFilter IS_FILLED;
    }

    public partial class VWcsBidInsSurveyGroups : BbTable<VWcsBidInsSurveyGroupsRecord, VWcsBidInsSurveyGroupsFilters>
    {
        public VWcsBidInsSurveyGroups() : base(new BbConnection())
        {
            // base.Connection.RoleName = "WR_WCS";
        }
        public VWcsBidInsSurveyGroups(BbConnection Connection)
            : base(Connection)
        {
        }
        public override List<VWcsBidInsSurveyGroupsRecord> Select(VWcsBidInsSurveyGroupsRecord Item)
        {
            List<VWcsBidInsSurveyGroupsRecord> res = new List<VWcsBidInsSurveyGroupsRecord>();
                        OracleDataReader rdr = null;
            ConnectionResult connectionResult = Connection.InitConnection();
            try
            {
                rdr = ExecuteReader(Item);
                while (rdr.Read())
                {
                    res.Add(new VWcsBidInsSurveyGroupsRecord(
                        this,
                        rdr.IsDBNull(0) ? OracleDecimal.Null : rdr.GetOracleDecimal(0),
                        rdr.IsDBNull(1) ?  (Decimal?)null : Convert.ToDecimal(rdr[1]), 
                        rdr.IsDBNull(2) ?  (String)null : Convert.ToString(rdr[2]), 
                        rdr.IsDBNull(3) ?  (Decimal?)null : Convert.ToDecimal(rdr[3]), 
                        rdr.IsDBNull(4) ?  (String)null : Convert.ToString(rdr[4]), 
                        rdr.IsDBNull(5) ?  (String)null : Convert.ToString(rdr[5]), 
                        rdr.IsDBNull(6) ?  (String)null : Convert.ToString(rdr[6]), 
                        rdr.IsDBNull(7) ?  (String)null : Convert.ToString(rdr[7]), 
                        rdr.IsDBNull(8) ?  (Decimal?)null : Convert.ToDecimal(rdr[8]))
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