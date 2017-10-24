using System;
using System.Collections.Generic;
using ibank.core;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;
using System.Data;
namespace credit
{

    public class WcsUtl : BbPackage
    {
        public WcsUtl(BbConnection Connection, AutoCommit AutoCommitMode) : base(Connection, AutoCommitMode) {}
        public WcsUtl(BbConnection Connection) : base(Connection, AutoCommit.Enabled) {}
        public void SET_WS_ID ( String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_WS_ID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_WS_NUM ( Decimal? P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Decimal,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_WS_NUM", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_RS_ID ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_RS_ID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CALC_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CALC_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CALC_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_VAL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SETUP_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID,  String P_RS_ID,  Decimal? P_RS_IQS_TCNT,  String P_RS_STATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RS_ID", OracleDbType.Varchar2,P_RS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RS_IQS_TCNT", OracleDbType.Decimal,P_RS_IQS_TCNT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_RS_STATE_ID", OracleDbType.Varchar2,P_RS_STATE_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SETUP_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void RUN_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.RUN_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID,  String P_WS_ID,  String P_STATUS_ID,  String P_ERR_MSG)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Varchar2,P_STATUS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERR_MSG", OracleDbType.Varchar2,P_ERR_MSG, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.STOP_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID,  String P_WS_ID,  String P_STATUS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATUS_ID", OracleDbType.Varchar2,P_STATUS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.STOP_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.STOP_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void STOP_IQUERY ( Decimal? P_BID_ID,  String P_IQUERY_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_IQUERY_ID", OracleDbType.Varchar2,P_IQUERY_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.STOP_IQUERY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void GET_QUEST_PARAMS ( Decimal? P_BID_ID,  String P_QUESTION_ID, out Decimal? P_TEXT_LENG_MIN, out Decimal? P_TEXT_LENG_MAX, out String P_TEXT_VAL_DEFAULT, out Decimal? P_TEXT_WIDTH, out Decimal? P_TEXT_ROWS, out Decimal? P_NMBDEC_VAL_MIN, out Decimal? P_NMBDEC_VAL_MAX, out Decimal? P_NMBDEC_VAL_DEFAULT, out DateTime? P_DAT_VAL_MIN, out DateTime? P_DAT_VAL_MAX, out DateTime? P_DAT_VAL_DEFAULT, out Decimal? P_LIST_SID_DEFAULT, out String P_REFER_SID_DEFAULT, out Decimal? P_TAB_ID, out String P_KEY_FIELD, out String P_SEMANTIC_FIELD, out String P_SHOW_FIELDS, out String P_WHERE_CLAUSE, out Decimal? P_BOOL_VAL_DEFAULT,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_VAL_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MIN", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MAX", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_DEFAULT", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_LIST_SID_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_REFER_SID_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_WHERE_CLAUSE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_BOOL_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_QUEST_PARAMS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_TEXT_LENG_MIN = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
            P_TEXT_LENG_MAX = parameters[3].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[3].Value).Value;
            P_TEXT_VAL_DEFAULT = parameters[4].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[4].Value).Value;
            P_TEXT_WIDTH = parameters[5].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[5].Value).Value;
            P_TEXT_ROWS = parameters[6].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[6].Value).Value;
            P_NMBDEC_VAL_MIN = parameters[7].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[7].Value).Value;
            P_NMBDEC_VAL_MAX = parameters[8].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[8].Value).Value;
            P_NMBDEC_VAL_DEFAULT = parameters[9].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[9].Value).Value;
            P_DAT_VAL_MIN = parameters[10].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[10].Value).Value;
            P_DAT_VAL_MAX = parameters[11].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[11].Value).Value;
            P_DAT_VAL_DEFAULT = parameters[12].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[12].Value).Value;
            P_LIST_SID_DEFAULT = parameters[13].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[13].Value).Value;
            P_REFER_SID_DEFAULT = parameters[14].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[14].Value).Value;
            P_TAB_ID = parameters[15].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[15].Value).Value;
            P_KEY_FIELD = parameters[16].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[16].Value).Value;
            P_SEMANTIC_FIELD = parameters[17].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[17].Value).Value;
            P_SHOW_FIELDS = parameters[18].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[18].Value).Value;
            P_WHERE_CLAUSE = parameters[19].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[19].Value).Value;
            P_BOOL_VAL_DEFAULT = parameters[20].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[20].Value).Value;
        }
        public void GET_QUEST_PARAMS ( Decimal? P_BID_ID,  String P_QUESTION_ID, out Decimal? P_TEXT_LENG_MIN, out Decimal? P_TEXT_LENG_MAX, out String P_TEXT_VAL_DEFAULT, out Decimal? P_TEXT_WIDTH, out Decimal? P_TEXT_ROWS, out Decimal? P_NMBDEC_VAL_MIN, out Decimal? P_NMBDEC_VAL_MAX, out Decimal? P_NMBDEC_VAL_DEFAULT, out DateTime? P_DAT_VAL_MIN, out DateTime? P_DAT_VAL_MAX, out DateTime? P_DAT_VAL_DEFAULT, out Decimal? P_LIST_SID_DEFAULT, out String P_REFER_SID_DEFAULT, out Decimal? P_TAB_ID, out String P_KEY_FIELD, out String P_SEMANTIC_FIELD, out String P_SHOW_FIELDS, out String P_WHERE_CLAUSE, out Decimal? P_BOOL_VAL_DEFAULT,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_VAL_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MIN", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MAX", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_DEFAULT", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_LIST_SID_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_REFER_SID_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_WHERE_CLAUSE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_BOOL_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_QUEST_PARAMS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_TEXT_LENG_MIN = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
            P_TEXT_LENG_MAX = parameters[3].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[3].Value).Value;
            P_TEXT_VAL_DEFAULT = parameters[4].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[4].Value).Value;
            P_TEXT_WIDTH = parameters[5].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[5].Value).Value;
            P_TEXT_ROWS = parameters[6].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[6].Value).Value;
            P_NMBDEC_VAL_MIN = parameters[7].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[7].Value).Value;
            P_NMBDEC_VAL_MAX = parameters[8].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[8].Value).Value;
            P_NMBDEC_VAL_DEFAULT = parameters[9].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[9].Value).Value;
            P_DAT_VAL_MIN = parameters[10].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[10].Value).Value;
            P_DAT_VAL_MAX = parameters[11].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[11].Value).Value;
            P_DAT_VAL_DEFAULT = parameters[12].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[12].Value).Value;
            P_LIST_SID_DEFAULT = parameters[13].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[13].Value).Value;
            P_REFER_SID_DEFAULT = parameters[14].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[14].Value).Value;
            P_TAB_ID = parameters[15].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[15].Value).Value;
            P_KEY_FIELD = parameters[16].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[16].Value).Value;
            P_SEMANTIC_FIELD = parameters[17].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[17].Value).Value;
            P_SHOW_FIELDS = parameters[18].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[18].Value).Value;
            P_WHERE_CLAUSE = parameters[19].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[19].Value).Value;
            P_BOOL_VAL_DEFAULT = parameters[20].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[20].Value).Value;
        }
        public void GET_QUEST_PARAMS ( Decimal? P_BID_ID,  String P_QUESTION_ID, out Decimal? P_TEXT_LENG_MIN, out Decimal? P_TEXT_LENG_MAX, out String P_TEXT_VAL_DEFAULT, out Decimal? P_TEXT_WIDTH, out Decimal? P_TEXT_ROWS, out Decimal? P_NMBDEC_VAL_MIN, out Decimal? P_NMBDEC_VAL_MAX, out Decimal? P_NMBDEC_VAL_DEFAULT, out DateTime? P_DAT_VAL_MIN, out DateTime? P_DAT_VAL_MAX, out DateTime? P_DAT_VAL_DEFAULT, out Decimal? P_LIST_SID_DEFAULT, out String P_REFER_SID_DEFAULT, out Decimal? P_TAB_ID, out String P_KEY_FIELD, out String P_SEMANTIC_FIELD, out String P_SHOW_FIELDS, out String P_WHERE_CLAUSE, out Decimal? P_BOOL_VAL_DEFAULT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_LENG_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_VAL_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MIN", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_MAX", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_NMBDEC_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MIN", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_MAX", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_DAT_VAL_DEFAULT", OracleDbType.Date,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_LIST_SID_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_REFER_SID_DEFAULT", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_WHERE_CLAUSE", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_BOOL_VAL_DEFAULT", OracleDbType.Decimal,null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_QUEST_PARAMS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_TEXT_LENG_MIN = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[2].Value).Value;
            P_TEXT_LENG_MAX = parameters[3].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[3].Value).Value;
            P_TEXT_VAL_DEFAULT = parameters[4].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[4].Value).Value;
            P_TEXT_WIDTH = parameters[5].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[5].Value).Value;
            P_TEXT_ROWS = parameters[6].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[6].Value).Value;
            P_NMBDEC_VAL_MIN = parameters[7].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[7].Value).Value;
            P_NMBDEC_VAL_MAX = parameters[8].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[8].Value).Value;
            P_NMBDEC_VAL_DEFAULT = parameters[9].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[9].Value).Value;
            P_DAT_VAL_MIN = parameters[10].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[10].Value).Value;
            P_DAT_VAL_MAX = parameters[11].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[11].Value).Value;
            P_DAT_VAL_DEFAULT = parameters[12].Status ==  OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)parameters[12].Value).Value;
            P_LIST_SID_DEFAULT = parameters[13].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[13].Value).Value;
            P_REFER_SID_DEFAULT = parameters[14].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[14].Value).Value;
            P_TAB_ID = parameters[15].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[15].Value).Value;
            P_KEY_FIELD = parameters[16].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[16].Value).Value;
            P_SEMANTIC_FIELD = parameters[17].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[17].Value).Value;
            P_SHOW_FIELDS = parameters[18].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[18].Value).Value;
            P_WHERE_CLAUSE = parameters[19].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[19].Value).Value;
            P_BOOL_VAL_DEFAULT = parameters[20].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[20].Value).Value;
        }
        public void SET_NULL_2_HIDED_QUESTS ( Decimal? P_BID_ID,  String P_SURVEY_ID,  String P_SGROUP_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_NULL_2_HIDED_QUESTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_NULL_2_HIDED_QUESTS ( Decimal? P_BID_ID,  String P_SURVEY_ID,  String P_SGROUP_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_NULL_2_HIDED_QUESTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void SET_NULL_2_HIDED_QUESTS ( Decimal? P_BID_ID,  String P_SURVEY_ID,  String P_SGROUP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SET_NULL_2_HIDED_QUESTS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void CLEAR_PRESCORING_BIDS ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CLEAR_PRESCORING_BIDS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void REGISTER_SPOUSE_AS_GUARANTOR ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.REGISTER_SPOUSE_AS_GUARANTOR", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PREFILL_FROM_CUSTOMERS ( Decimal? P_DEST_BID_ID,  String P_DEST_WS_ID,  Decimal? P_DEST_WS_NUMBER,  Decimal? P_SRC_RNK)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEST_BID_ID", OracleDbType.Decimal,P_DEST_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_ID", OracleDbType.Varchar2,P_DEST_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_NUMBER", OracleDbType.Decimal,P_DEST_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_RNK", OracleDbType.Decimal,P_SRC_RNK, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PREFILL_FROM_CUSTOMERS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PREFILL_AUTH_FROM_BIDS ( Decimal? P_DEST_BID_ID,  String P_DEST_WS_ID,  Decimal? P_DEST_WS_NUMBER,  String P_DEST_AUTH_ID,  Decimal? P_SRC_BID_ID,  String P_SRC_WS_ID,  Decimal? P_SRC_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEST_BID_ID", OracleDbType.Decimal,P_DEST_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_ID", OracleDbType.Varchar2,P_DEST_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_NUMBER", OracleDbType.Decimal,P_DEST_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_AUTH_ID", OracleDbType.Varchar2,P_DEST_AUTH_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_BID_ID", OracleDbType.Decimal,P_SRC_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_WS_ID", OracleDbType.Varchar2,P_SRC_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_WS_NUMBER", OracleDbType.Decimal,P_SRC_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PREFILL_AUTH_FROM_BIDS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void PREFILL_SURVEY_FROM_BIDS ( Decimal? P_DEST_BID_ID,  String P_DEST_WS_ID,  Decimal? P_DEST_WS_NUMBER,  String P_DEST_SURVEY_ID,  Decimal? P_SRC_BID_ID,  String P_SRC_WS_ID,  Decimal? P_SRC_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DEST_BID_ID", OracleDbType.Decimal,P_DEST_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_ID", OracleDbType.Varchar2,P_DEST_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_WS_NUMBER", OracleDbType.Decimal,P_DEST_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DEST_SURVEY_ID", OracleDbType.Varchar2,P_DEST_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_BID_ID", OracleDbType.Decimal,P_SRC_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_WS_ID", OracleDbType.Varchar2,P_SRC_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SRC_WS_NUMBER", OracleDbType.Decimal,P_SRC_WS_NUMBER, ParameterDirection.Input));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PREFILL_SURVEY_FROM_BIDS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
        }
        public void IMPORT_SBPMACS ( String P_XML, out Decimal? P_ERROR_CODE, out String P_PROTOCOL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_XML", OracleDbType.Clob,P_XML, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_ERROR_CODE", OracleDbType.Decimal,null, ParameterDirection.Output));
            parameters.Add(new OracleParameter("P_PROTOCOL", OracleDbType.Varchar2,4000, null, ParameterDirection.Output));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.IMPORT_SBPMACS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            P_ERROR_CODE = parameters[1].Status ==  OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)parameters[1].Value).Value;
            P_PROTOCOL = parameters[2].Status ==  OracleParameterStatus.NullFetched ? (String)null : ((OracleString)parameters[2].Value).Value;
        }
        public String HEADER_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HEADER_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String BODY_VERSION ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.BODY_VERSION", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_WS_ID ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_WS_ID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_WS_NUM ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_WS_NUM", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_RS_ID ()
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_RS_ID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_FORMATED_DAYS_STRING ( Decimal? P_DAYS)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_DAYS", OracleDbType.Decimal,P_DAYS, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_FORMATED_DAYS_STRING", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String PARSE_SQL ( Decimal? P_BID_ID,  String P_PLSQL,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLSQL", OracleDbType.Varchar2,P_PLSQL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PARSE_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String PARSE_SQL ( Decimal? P_BID_ID,  String P_PLSQL,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLSQL", OracleDbType.Varchar2,P_PLSQL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PARSE_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String PARSE_SQL ( Decimal? P_BID_ID,  String P_PLSQL)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_PLSQL", OracleDbType.Varchar2,P_PLSQL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.PARSE_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_SQL ( Decimal? BID_ID_,  String QUESTION_ID_,  String PLSQL_,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_SQL ( Decimal? BID_ID_,  String QUESTION_ID_,  String PLSQL_,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_SQL ( Decimal? BID_ID_,  String QUESTION_ID_,  String PLSQL_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("QUESTION_ID_", OracleDbType.Varchar2,QUESTION_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_SQL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_CHECK ( Decimal? BID_ID_,  String PLSQL_,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_CHECK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_CHECK ( Decimal? BID_ID_,  String PLSQL_,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_CHECK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String EXEC_CHECK ( Decimal? BID_ID_,  String PLSQL_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_", OracleDbType.Varchar2,PLSQL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.EXEC_CHECK", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String CALC_SQL_LINE ( Decimal? BID_ID_,  String PLSQL_LINE_,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_LINE_", OracleDbType.Varchar2,PLSQL_LINE_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_LINE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String CALC_SQL_LINE ( Decimal? BID_ID_,  String PLSQL_LINE_,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_LINE_", OracleDbType.Varchar2,PLSQL_LINE_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_LINE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String CALC_SQL_LINE ( Decimal? BID_ID_,  String PLSQL_LINE_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_LINE_", OracleDbType.Varchar2,PLSQL_LINE_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_LINE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? CALC_SQL_BOOL ( Decimal? BID_ID_,  String PLSQL_BOOL_,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_BOOL_", OracleDbType.Varchar2,PLSQL_BOOL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CALC_SQL_BOOL ( Decimal? BID_ID_,  String PLSQL_BOOL_,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_BOOL_", OracleDbType.Varchar2,PLSQL_BOOL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CALC_SQL_BOOL ( Decimal? BID_ID_,  String PLSQL_BOOL_)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("BID_ID_", OracleDbType.Decimal,BID_ID_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("PLSQL_BOOL_", OracleDbType.Varchar2,PLSQL_BOOL_, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CALC_SQL_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_ANSW_NUMB ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_NUMB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_NUMB ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_NUMB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_NUMB ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_NUMB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_DECIMAL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DECIMAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_DECIMAL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DECIMAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_DECIMAL ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DECIMAL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public DateTime? GET_ANSW_DATE ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
        public DateTime? GET_ANSW_DATE ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
        public DateTime? GET_ANSW_DATE ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Date, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_DATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDate res = (OracleDate)ReturnValue;
            return res.IsNull ? (DateTime?)null : res.Value;
        }
        public Decimal? GET_ANSW_LIST ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_LIST ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_LIST ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_ANSW_LIST_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_LIST_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_LIST_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_LIST_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_REFER_TEXT ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_REFER_TEXT", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_ANSW_BOOL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_BOOL ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_ANSW_BOOL ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BOOL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Byte[] GET_ANSW_BLOB ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public Byte[] GET_ANSW_BLOB ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public Byte[] GET_ANSW_BLOB ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public String GET_ANSW_XML ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Clob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_XML", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleClob res = (OracleClob)ReturnValue;
            String resString = res.IsNull ? (String)null : res.Value;
            res.Close();
            res.Dispose();
            return resString;
        }
        public String GET_ANSW_XML ( Decimal? P_BID_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Clob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_XML", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleClob res = (OracleClob)ReturnValue;
            String resString = res.IsNull ? (String)null : res.Value;
            res.Close();
            res.Dispose();
            return resString;
        }
        public String GET_ANSW_XML ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Clob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_XML", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleClob res = (OracleClob)ReturnValue;
            String resString = res.IsNull ? (String)null : res.Value;
            res.Close();
            res.Dispose();
            return resString;
        }
        public String GET_ANSW_FORMATED ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_FOR_EXPORT,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FOR_EXPORT", OracleDbType.Decimal,P_FOR_EXPORT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_FORMATED ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_FOR_EXPORT,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FOR_EXPORT", OracleDbType.Decimal,P_FOR_EXPORT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_FORMATED ( Decimal? P_BID_ID,  String P_QUESTION_ID,  Decimal? P_FOR_EXPORT)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_FOR_EXPORT", OracleDbType.Decimal,P_FOR_EXPORT, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_ANSW_FORMATED ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSW_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE,  Decimal? P_BID_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER,  String P_QUESTION_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE,  Decimal? P_BID_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE,  Decimal? P_BID_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE,  Decimal? P_BID_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE,  Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_VAL_FORMATED ( String P_VAL,  String P_TYPE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_VAL", OracleDbType.Varchar2,P_VAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_VAL_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_QUEST_NAME ( String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_QUEST_NAME", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_CREDITDATA_QID ( Decimal? P_BID_ID,  String P_CRDDATA_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CRDDATA_ID", OracleDbType.Varchar2,P_CRDDATA_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_CREDITDATA_QID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_CREDITDATA ( Decimal? P_BID_ID,  String P_CRDDATA_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CRDDATA_ID", OracleDbType.Varchar2,P_CRDDATA_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_CREDITDATA", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Byte[] GET_SBP_MAC_BLOB ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public Byte[] GET_SBP_MAC_BLOB ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public Byte[] GET_SBP_MAC_BLOB ( String P_SUBPRODUCT_ID,  String P_MAC_ID)
        {
            this.InitConnection();
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Blob, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_BLOB", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleBlob res = (OracleBlob)ReturnValue;
            Byte[] resByte = res.IsNull ? (Byte[])null : res.Value;
            res.Close();
            res.Dispose();
            return resByte;
        }
        public String GET_SBP_MAC ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_MAC ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_MAC ( String P_SUBPRODUCT_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_MAC_FORMATED ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH,  DateTime? P_APPLY_DATE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_APPLY_DATE", OracleDbType.Date,P_APPLY_DATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_MAC_FORMATED ( String P_SUBPRODUCT_ID,  String P_MAC_ID,  String P_BRANCH)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_BRANCH", OracleDbType.Varchar2,P_BRANCH, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_MAC_FORMATED ( String P_SUBPRODUCT_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_MAC_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_MAC ( Decimal? P_BID_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_MAC", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_MAC_FORMATED ( Decimal? P_BID_ID,  String P_MAC_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_MAC_ID", OracleDbType.Varchar2,P_MAC_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_MAC_FORMATED", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? GET_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_QUESTION_ID,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_QUESTION_ID,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_GENERAL_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_TYPE,  String P_WS_ID,  Decimal? P_WS_NUMBER)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_NUMBER", OracleDbType.Decimal,P_WS_NUMBER, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_GENERAL_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_GENERAL_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_TYPE,  String P_WS_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_WS_ID", OracleDbType.Varchar2,P_WS_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_GENERAL_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_GENERAL_SCORE ( Decimal? P_BID_ID,  String P_SCORING_ID,  String P_TYPE)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SCORING_ID", OracleDbType.Varchar2,P_SCORING_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2,P_TYPE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_GENERAL_SCORE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_STOP ( Decimal? P_BID_ID,  String P_STOP_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STOP_ID", OracleDbType.Varchar2,P_STOP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_STOP", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? CHECK_BID_STATE_HIST ( Decimal? P_BID_ID,  String P_STATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.CHECK_BID_STATE_HIST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_BID_STATE ( Decimal? P_BID_ID,  String P_STATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_BID_STATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAD_BID_STATE ( Decimal? P_BID_ID,  String P_STATE_ID,  Decimal? P_CHECKOUTED,  String P_CNGACTION)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECKOUTED", OracleDbType.Decimal,P_CHECKOUTED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CNGACTION", OracleDbType.Varchar2,P_CNGACTION, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAD_BID_STATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAD_BID_STATE ( Decimal? P_BID_ID,  String P_STATE_ID,  Decimal? P_CHECKOUTED)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CHECKOUTED", OracleDbType.Decimal,P_CHECKOUTED, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAD_BID_STATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAD_BID_STATE ( Decimal? P_BID_ID,  String P_STATE_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_STATE_ID", OracleDbType.Varchar2,P_STATE_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAD_BID_STATE", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_BID_STATES ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_BID_STATES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_BID_GARANTEES ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_BID_GARANTEES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_GARANTEES ( String P_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_GARANTEES", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public String GET_SBP_DOCS ( String P_SUBPRODUCT_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_SBP_DOCS", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? HAS_SUR_GRP_QUEST_REL ( String P_SURVEY_ID,  String P_SGROUP_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_SUR_GRP_QUEST_REL", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_RELATED_SURVEY ( String P_SURVEY_ID,  String P_SGROUP_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SURVEY_ID", OracleDbType.Varchar2,P_SURVEY_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_SGROUP_ID", OracleDbType.Varchar2,P_SGROUP_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_RELATED_SURVEY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? HAS_RELATED_CREDITDATA ( String P_SUBPRODUCT_ID,  String P_CRDDATA_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_SUBPRODUCT_ID", OracleDbType.Varchar2,P_SUBPRODUCT_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_CRDDATA_ID", OracleDbType.Varchar2,P_CRDDATA_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.HAS_RELATED_CREDITDATA", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_INTEREST ( Decimal? P_IN_BAL,  Decimal? P_INTEREST_RATE,  DateTime? P_DATE_START,  DateTime? P_DATE_END)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_IN_BAL", OracleDbType.Decimal,P_IN_BAL, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_INTEREST_RATE", OracleDbType.Decimal,P_INTEREST_RATE, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_START", OracleDbType.Date,P_DATE_START, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_END", OracleDbType.Date,P_DATE_END, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_INTEREST", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? SHOW_IN_SURVEY ( Decimal? P_BID_ID,  String P_QUESTION_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2,P_QUESTION_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.SHOW_IN_SURVEY", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public String GET_ANSWERS_DIFF ( Decimal? P_BID_ID,  DateTime? P_DATE_FROM,  DateTime? P_DATE_TO)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_FROM", OracleDbType.Date,P_DATE_FROM, ParameterDirection.Input));
            parameters.Add(new OracleParameter("P_DATE_TO", OracleDbType.Date,P_DATE_TO, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Varchar2, 4000, null, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_ANSWERS_DIFF", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleString res = (OracleString)ReturnValue;
            return res.IsNull ? (String)null : res.Value;
        }
        public Decimal? BID_CREATE_KACKO_FROM_AUTO ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.BID_CREATE_KACKO_FROM_AUTO", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
        public Decimal? GET_KACKO_BID_ID ( Decimal? P_BID_ID)
        {
            List<OracleParameter> parameters = new List<OracleParameter>();
            parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal,P_BID_ID, ParameterDirection.Input));
            parameters.Add(new OracleParameter("$$RETVAL$$", OracleDbType.Decimal, ParameterDirection.ReturnValue));
            object ReturnValue = null;
            ExecuteNonQuery("WCS_UTL.GET_KACKO_BID_ID", parameters.ToArray(), CommandType.StoredProcedure, out ReturnValue);
            OracleDecimal res = (OracleDecimal)ReturnValue;
            return res.IsNull ? (Decimal?)null : res.Value;
        }
    }
}