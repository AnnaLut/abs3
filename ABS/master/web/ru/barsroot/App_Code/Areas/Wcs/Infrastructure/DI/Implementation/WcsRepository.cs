using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Models;
using Areas.Wcs.Models;
using BarsWeb.Models;
using System.Linq;
using System;
using System.Text;
using System.Web;
using System.Collections.Generic;
using System.Globalization;
using System.Threading;
using System.Threading.Tasks;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

namespace BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation
{
    public class WcsRepository : IWcsRepository
    {
        private WcsEntities _entities;
        
        public IQueryable<ScoringQuestion> GetScoringQuestion(int bidId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<ScoringQuestion> questions = new List<ScoringQuestion>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from v_wcs_scor_main_questions where bid_id = :p_bid_id";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bidId, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();
                
                while (reader.Read())
                {
                    ScoringQuestion q = new ScoringQuestion();
                    q.bidId = Convert.ToInt32(reader.GetDecimal(0));// null; //reader.GetInt64(0);
                    q.questionId = reader.GetString(1);
                    q.Name = reader.GetString(2);
                    q.scoreCust = reader.GetString(3);
                    q.valueCust = reader.GetString(4);
                    q.scoreClass = String.IsNullOrEmpty(reader.GetValue(5).ToString()) ? String.Empty : reader.GetString(5);
                    q.valueClass = String.IsNullOrEmpty(reader.GetValue(6).ToString()) ? String.Empty : reader.GetString(6);
                    q.Ord = Convert.ToInt32(reader.GetDecimal(7));
                    q.listGuarant = GetScoringQuestionGuar(q.bidId,q.questionId);
                    questions.Add(q);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return questions.AsQueryable();
        }

        public IQueryable<ScoringQuestionGuar> GetScoringQuestionGuar(int? bidId, string questionId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<ScoringQuestionGuar> list = new List<ScoringQuestionGuar>();

            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from v_wcs_scor_main_guarantees where bid_id = :p_bid_id and question_id = :p_question_id";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bidId, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_question_id", OracleDbType.Varchar2, questionId, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ScoringQuestionGuar q = new ScoringQuestionGuar();
                    q.bidId = Convert.ToInt32(reader.GetDecimal(0));
                    q.garanteeNum = Convert.ToInt32(reader.GetDecimal(1));
                    q.questionId = reader.GetString(2);
                    q.scoreCust = reader.GetString(3);
                    q.valueCust = reader.GetString(4);
                    q.Ord = Convert.ToInt32(reader.GetDecimal(5));
                    list.Add(q);
                }
            }
            catch (OracleException e)
            {
                return null;
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return list.AsQueryable();
        }

        public ScoringResult GetResult(int? bidId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            ScoringResult result = new ScoringResult();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select wcs_utl.get_answ_list_text(:p_bid_id,'CRISK_OBU') as Obu,
                                           wcs_utl.get_answ_list_text(:p_bid_id,'CRISK_NBU') as Nbu
                                      from dual";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bidId, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    result.rObu = reader.GetString(0);
                    result.rNbu = reader.GetString(1);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return result;
        }

        public int GetCountGarantees(int? bidId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            int countGarantee = 0;
            try
            {                
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select count(1) as cnt from v_wcs_bid_garantees where bid_id = :p_bid_id and wcs_utl.get_answ_list(bid_id,'GRT_2_20',ws_id,garantee_num) = 0";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bidId, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    countGarantee = reader.GetInt32(0);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return countGarantee;
        }

        public IQueryable<ServiceList> GetServiceList()
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<ServiceList> list = new List<ServiceList>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from wcs_services where id not in('CREDIT_SERVICE','SECRETARY_CC','VISA')";

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    ServiceList sList = new ServiceList();
                    sList.Id = reader.GetString(0);
                    sList.Name = reader.GetString(1);
                    list.Add(sList);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return list.AsQueryable();
        }

        public void SetServices(string bidId, string services)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "bars.wcs_utl.set_answ";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, Convert.ToDecimal(bidId), System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_question_id", OracleDbType.Varchar2, "REQUIRED_SRVS", System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_val", OracleDbType.Varchar2, services, System.Data.ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
        public string GetValue(string bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            var strList = "";
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select bars.wcs_utl.get_answ(:p_bid_id,:p_question_id) from dual";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, Convert.ToDecimal(bid_id), System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_question_id", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    strList = reader.IsDBNull(0) ? "" : reader.GetString(0);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return strList;
        }

        public IQueryable<GroupList> GetGroups(decimal bid_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<GroupList> groups = new List<GroupList>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from v_wcs_bid_survey_groups where bid_id = :p_bid_id";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    GroupList group = new GroupList();
                    group.BID_ID = Convert.ToInt32(reader[0].ToString());
                    group.SURVEY_ID = reader[1].ToString();
                    group.GROUP_ID = reader[2].ToString();
                    group.GROUP_NAME = reader[3].ToString();
                    group.RESULT_QID = reader[4].ToString();
                    group.IS_FILLED = Convert.ToInt16(reader[5].ToString());
                    groups.Add(group);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return groups.AsQueryable();
        }

        public IQueryable<GroupQuestionList> GetGroupQuestions(decimal bid_id, string survey_id, string group_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            List<GroupQuestionList> groupQuestions = new List<GroupQuestionList>();
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select * from vw_wcs_bid_survey_group_quests where bid_id = :p_bid_id and survey_id = :p_survey_id and group_id = :p_group_id";
                cmd.Parameters.Add("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_survey_id", OracleDbType.Varchar2, survey_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("p_group_id", OracleDbType.Varchar2, group_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    //інформація по питанню
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.CommandText = "";
                    cmd.CommandText = "wcs_utl.get_quest_params";
                    GroupQuestionList groupQuestion = new GroupQuestionList();
                    groupQuestion.BID_ID = Convert.ToInt32(reader[0].ToString());
                    groupQuestion.SURVEY_ID = reader[1].ToString();
                    groupQuestion.GROUP_ID = reader[2].ToString();
                    groupQuestion.RECTYPE_ID = reader[3].ToString();
                    groupQuestion.NEXT_RECTYPE_ID = reader[4].ToString();
                    groupQuestion.QUESTION_ID = reader[5].ToString();
                    groupQuestion.QUESTION_NAME = reader[6].ToString();
                    groupQuestion.TYPE_ID = reader[7].ToString();
                    groupQuestion.IS_CALCABLE = Convert.ToInt16(reader[8].ToString());
                    groupQuestion.IS_REQUIRED = Convert.ToInt16(reader[9].ToString());
                    groupQuestion.IS_READONLY = Convert.ToInt16(reader[10].ToString());
                    groupQuestion.IS_REWRITABLE = Convert.ToInt16(reader[11].ToString());
                    groupQuestion.IS_CHECKABLE = Convert.ToInt16(reader[12].ToString());
                    groupQuestion.DNSHOW_IF = Convert.ToInt16(reader[14].ToString());
                    //параметри питання
                    QuestionParameters questParams = new QuestionParameters();
                    cmd.Parameters.Clear();
                    cmd.Parameters.Add(new OracleParameter("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("P_QUESTION_ID", OracleDbType.Varchar2, groupQuestion.QUESTION_ID, System.Data.ParameterDirection.Input));
                    cmd.Parameters.Add(new OracleParameter("P_TEXT_LENG_MIN", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_TEXT_LENG_MAX", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_TEXT_VAL_DEFAULT", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_TEXT_WIDTH", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_TEXT_ROWS", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_NMBDEC_VAL_MIN", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_NMBDEC_VAL_MAX", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_NMBDEC_VAL_DEFAULT", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_DAT_VAL_MIN", OracleDbType.Date, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_DAT_VAL_MAX", OracleDbType.Date, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_DAT_VAL_DEFAULT", OracleDbType.Date, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_LIST_SID_DEFAULT", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_REFER_SID_DEFAULT", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_TAB_ID", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_KEY_FIELD", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_SEMANTIC_FIELD", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_SHOW_FIELDS", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_WHERE_CLAUSE", OracleDbType.Varchar2, 4000, null, System.Data.ParameterDirection.Output));
                    cmd.Parameters.Add(new OracleParameter("P_BOOL_VAL_DEFAULT", OracleDbType.Decimal, null, System.Data.ParameterDirection.Output));
                    cmd.ExecuteNonQuery();
                    questParams.TEXT_LENG_MIN = cmd.Parameters[2].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[2].Value).Value;
                    questParams.TEXT_LENG_MAX = cmd.Parameters[3].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[3].Value).Value;
                    questParams.TEXT_VAL_DEFAULT = cmd.Parameters[4].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)cmd.Parameters[4].Value).Value;
                    questParams.TEXT_WIDTH = cmd.Parameters[5].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[5].Value).Value;
                    questParams.TEXT_ROWS = cmd.Parameters[6].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[6].Value).Value;
                    questParams.NMBDEC_VAL_MIN = cmd.Parameters[7].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[7].Value).Value;
                    questParams.NMBDEC_VAL_MAX = cmd.Parameters[8].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[8].Value).Value;
                    questParams.NMBDEC_VAL_DEFAULT = cmd.Parameters[9].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[9].Value).Value;
                    questParams.DAT_VAL_MIN = cmd.Parameters[10].Status == OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)cmd.Parameters[10].Value).Value;
                    questParams.DAT_VAL_MAX = cmd.Parameters[11].Status == OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)cmd.Parameters[11].Value).Value;
                    questParams.DAT_VAL_DEFAULT = cmd.Parameters[12].Status == OracleParameterStatus.NullFetched ? (DateTime?)null : ((OracleDate)cmd.Parameters[12].Value).Value;
                    questParams.LIST_SID_DEFAULT = cmd.Parameters[13].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[13].Value).Value;
                    questParams.REFER_SID_DEFAULT = cmd.Parameters[14].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)cmd.Parameters[14].Value).Value;
                    questParams.KEY_FIELD = cmd.Parameters[16].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)cmd.Parameters[16].Value).Value;
                    questParams.SEMANTIC_FIELD = cmd.Parameters[17].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)cmd.Parameters[17].Value).Value;
                    questParams.SHOW_FIELDS = cmd.Parameters[18].Status == OracleParameterStatus.NullFetched ? (String)null : ((OracleString)cmd.Parameters[18].Value).Value;
                    questParams.WHERE_CLAUSE = cmd.Parameters[19].Status == OracleParameterStatus.NullFetched ? (String)null : BidParseSql(bid_id,((OracleString)cmd.Parameters[19].Value).Value).Replace("'", "$");
                    questParams.BOOL_VAL_DEFAULT = cmd.Parameters[20].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[20].Value).Value;
                    //якщо тип REFER обираємо TABNAME
                    string tabName = String.Empty;
                    if (groupQuestion.TYPE_ID == "REFER")
                    {
                        decimal? tabId = cmd.Parameters[15].Status == OracleParameterStatus.NullFetched ? (Decimal?)null : ((OracleDecimal)cmd.Parameters[15].Value).Value;
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.CommandText = "";
                        cmd.CommandText = "select tabname from meta_tables where tabid = :p_tabid";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new OracleParameter("p_tabid", OracleDbType.Varchar2, tabId, System.Data.ParameterDirection.Input));
                        OracleDataReader readerTab = cmd.ExecuteReader();
                        if (readerTab.Read())
                        {
                            tabName = readerTab[0].ToString();
                        }
                    }
                    questParams.TAB_NAME = tabName;
                    //якщо тип LIST наповнюєм значення
                    if (groupQuestion.TYPE_ID == "LIST")
                    {
                        List<QuestionList> questionListItems = new List<QuestionList>();
                        cmd.CommandType = System.Data.CommandType.Text;
                        cmd.CommandText = "";
                        cmd.CommandText = "select question_id, ord, text from v_wcs_question_list_items where question_id = :p_question_id and visible = 1 order by ord";
                        cmd.Parameters.Clear();
                        cmd.Parameters.Add(new OracleParameter("p_question_id", OracleDbType.Varchar2, groupQuestion.QUESTION_ID, System.Data.ParameterDirection.Input));
                        OracleDataReader readerList = cmd.ExecuteReader();
                        while (readerList.Read())
                        {
                            QuestionList questionList = new QuestionList();
                            questionList.QUESTION_ID = readerList[0].ToString();
                            questionList.ORD = Convert.ToDecimal(readerList[1].ToString());
                            questionList.TEXT = readerList[2].ToString();
                            questionListItems.Add(questionList);
                        }
                        groupQuestion.QUEST_LIST_ITEMS = questionListItems;
                    }
                    //якщо питання вирраховується
                    if (groupQuestion.IS_CALCABLE == 1)
                    {
                        CalcAnsw(groupQuestion.BID_ID, groupQuestion.QUESTION_ID);
                    }

                    bool hasAnsw = HasAnsw(groupQuestion.BID_ID, groupQuestion.QUESTION_ID) == 1 ? true : false;
                    string value = "";

                    switch (groupQuestion.TYPE_ID)
                    {
                        case "TEXT": value = hasAnsw ? GetAnswText(groupQuestion.BID_ID, groupQuestion.QUESTION_ID) : questParams.TEXT_VAL_DEFAULT; break;
                        case "NUMB": value = hasAnsw ? GetAnswNumb(groupQuestion.BID_ID, groupQuestion.QUESTION_ID).ToString() : questParams.NMBDEC_VAL_DEFAULT.ToString(); break;
                        case "DECIMAL": value = hasAnsw ? GetAnswDecimal(groupQuestion.BID_ID, groupQuestion.QUESTION_ID).ToString() : questParams.NMBDEC_VAL_DEFAULT.ToString(); break;
                        case "DATE": value = hasAnsw ? String.Format("{0:dd.MM.yyyy}", GetAnswDate(groupQuestion.BID_ID, groupQuestion.QUESTION_ID)) : String.Format("{0:dd.MM.yyyy}", questParams.DAT_VAL_DEFAULT); break;
                        case "LIST": value = hasAnsw ? GetAnswList(groupQuestion.BID_ID, groupQuestion.QUESTION_ID).ToString() : questParams.LIST_SID_DEFAULT.ToString(); break;
                        case "REFER": value = hasAnsw ? GetAnswRefer(groupQuestion.BID_ID, groupQuestion.QUESTION_ID) : questParams.REFER_SID_DEFAULT; break;
                        case "BOOL": value = hasAnsw ? GetAnswBool(groupQuestion.BID_ID, groupQuestion.QUESTION_ID).ToString() : questParams.BOOL_VAL_DEFAULT.ToString(); break;
                    }
                    //якщо питання має залежні, помічаємо
                    var related = HasRelatedSurvey(groupQuestion.SURVEY_ID, groupQuestion.GROUP_ID, groupQuestion.QUESTION_ID);
                    groupQuestion.HAS_RELATED = related;
                    groupQuestion.VALUE = value;
                    groupQuestion.QUEST_PARAMS = questParams;
                    groupQuestions.Add(groupQuestion);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
            return groupQuestions.AsQueryable();
        }

        public IQueryable<QuestRelationResult> GetRelationQuestion(decimal bid_id, string survey_id, string group_id, string question_id, string val)
        {
            List<QuestRelationResult> relationQuestions = new List<QuestRelationResult>();
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                if (!String.IsNullOrEmpty(val))
                {
                    SetAnsw(bid_id, question_id, val);
                }
                else
                {
                    DelAnsw(bid_id, question_id);
                }
                SetNullHidedQuests(bid_id, survey_id, group_id);
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = @"select cqid,
                                           wcs_utl.calc_sql_bool(:p_bid_id, dnshow_if) as dnshow_if,
                                           tab_name,
                                           show_fields,
                                           where_clause,
                                           type_id,
                                           has_rel
                                      from mvw_wcs_sur_grp_quest_relation 
                                     where survey_id = :p_survey_id
                                       and question_id = :p_question_id";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_SURVEY_ID", OracleDbType.Varchar2, survey_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    QuestRelationResult relationQuestion = new QuestRelationResult();
                    relationQuestion.CQID = reader[0].ToString();
                    relationQuestion.CQ_TYPE_ID = reader[5].ToString();
                    relationQuestion.DNSHOW_IF = String.IsNullOrEmpty(reader[1].ToString()) ? (bool?)null : reader[1].ToString() == "1" ? true : false;
                    relationQuestion.TAB_NAME = reader[2].ToString();
                    relationQuestion.SHOW_FIELDS = reader[3].ToString();
                    relationQuestion.WHERE_CLAUSE = BidParseSql(bid_id, reader[4].ToString()).Replace("'", "$");
                    relationQuestion.CALC_RESULT = GetAnsw(bid_id, relationQuestion.CQID);
                    relationQuestion.HAS_REL = Convert.ToDecimal(reader[6].ToString());
                    relationQuestions.Add(relationQuestion);
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return relationQuestions.AsQueryable();
        }

        public void SetAllAnsw(List<ParamsSetAnswers> param)
        {
            string SurGrpRes = "_SURGRPRES";
            foreach (var item in param)
            {
                if (!String.IsNullOrEmpty(item.value))
                {
                    SetAnsw(item.bidId, item.questionId, item.value);
                }
                else
                {
                    DelAnsw(item.bidId, item.questionId);
                }
                if (param.Last().questionId == item.questionId) SetAnsw(item.bidId, item.groupId + SurGrpRes, "1");
            }
        }

        public void SetAnsw(decimal bid_id, string question_id, string val)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.set_answ";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_VAL", OracleDbType.Varchar2, val, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public void DelAnsw(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_pack.answ_del";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public void SetNullHidedQuests(decimal bid_id, string survey_id, string group_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.set_null_2_hided_quests";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_SURVEY_ID", OracleDbType.Varchar2, survey_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_SGROUP_ID", OracleDbType.Varchar2, group_id, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public bool CalcSqlBool(decimal bid_id, string plsql_bool)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            bool res = false;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.calc_sql_bool(:p_bid_id, :p_plsql_bool) as val from dual";
                cmd.Parameters.Add(new OracleParameter("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_plsql_bool", OracleDbType.Varchar2, plsql_bool, System.Data.ParameterDirection.Input));
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    res = String.IsNullOrEmpty(reader[0].ToString()) ? false : Convert.ToDecimal(reader[0].ToString()) == 1 ? true : false;
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return res;
        }

        public string CheckQuestion(decimal bid_id, string survey_id, string group_id, string question_id, string val)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string calc_proc = String.Empty;
            string res_proc = String.Empty;
            if (!String.IsNullOrEmpty(val))
            {
                SetAnsw(bid_id, question_id, val);
            }
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select check_proc from v_wcs_survey_group_questions where survey_id=:p_survey_id and group_id=:p_group_id and question_id=:p_question_id";
                cmd.Parameters.Add(new OracleParameter("p_survey_id", OracleDbType.Varchar2, survey_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_group_id", OracleDbType.Varchar2, group_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_question_id", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input));
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    calc_proc = String.IsNullOrEmpty(reader[0].ToString()) ? String.Empty : reader[0].ToString().Replace("'","\'");
                }
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.exec_check";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, res_proc, System.Data.ParameterDirection.ReturnValue));
                cmd.Parameters.Add(new OracleParameter("bid_id_", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("plsql_", OracleDbType.Varchar2, 4000, calc_proc, System.Data.ParameterDirection.Input));
                
                cmd.ExecuteNonQuery();
                res_proc = cmd.Parameters["res_"].Value.ToString().Replace("1: ORA-20001: ","");
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return res_proc;
        }

        public void CalcAnsw(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.calc_answ";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public Decimal? HasAnsw(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal? isHasAnsw = 0;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.has_answ(:p_bid_id, :p_question_id) as val from dual";
                cmd.Parameters.Add(new OracleParameter("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_question_id", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input));
                OracleDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    isHasAnsw = String.IsNullOrEmpty(reader[0].ToString()) ? 0 : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return isHasAnsw;
        }

        public string GetAnsw(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string answer = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? String.Empty : reader[0].ToString();
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public string GetAnswText(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string answer = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_text(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? String.Empty : reader[0].ToString();
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public Decimal? GetAnswNumb(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal? answer = (Decimal?)null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_numb(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? (Decimal?)null : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public Decimal? GetAnswDecimal(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal? answer = (Decimal?)null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_decimal(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? (Decimal?)null : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public DateTime? GetAnswDate(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            DateTime? answer = (DateTime?)null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_date(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? (DateTime?)null : Convert.ToDateTime(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public Decimal? GetAnswList(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal? answer = (Decimal?)null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_list(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? (Decimal?)null : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public string GetAnswRefer(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string answer = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_refer(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? String.Empty : reader[0].ToString();
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public Decimal? GetAnswBool(decimal bid_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal? answer = (Decimal?)null;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.get_answ_bool(:p_bid_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_BID_ID", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    answer = String.IsNullOrEmpty(reader[0].ToString()) ? (Decimal?)null : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return answer;
        }

        public Decimal HasRelatedSurvey(string survey_id, string sgroup_id, string question_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            Decimal result = 0;
            try
            {
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.CommandText = "select wcs_utl.has_sur_grp_quest_rel(:p_survey_id, :p_sgroup_id, :p_question_id) from dual";
                cmd.Parameters.Add("P_SURVEY_ID", OracleDbType.Varchar2, survey_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_SGROUP_ID", OracleDbType.Varchar2, sgroup_id, System.Data.ParameterDirection.Input);
                cmd.Parameters.Add("P_QUESTION_ID", OracleDbType.Varchar2, question_id, System.Data.ParameterDirection.Input);

                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    result = String.IsNullOrEmpty(reader[0].ToString()) ? 0 : Convert.ToDecimal(reader[0].ToString());
                }
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return result;
        }

        public void DeleteState(decimal bid_id)
        {
            if (HasBidState(bid_id, "NEW_SURVEY"))
            {
                // чекин состояния
                BidStateCheckIn(bid_id, "NEW_SURVEY");
                // завершаем состояние и переходим на след
                BidStateDel(bid_id, "NEW_SURVEY");
            }

            if (HasBidState(bid_id, "NEW_FT_SURVEY"))
            {
                // чекин состояния
                BidStateCheckIn(bid_id, "NEW_FT_SURVEY");
                // завершаем состояние и переходим на след
                BidStateDel(bid_id, "NEW_FT_SURVEY");
            }
        }

        public bool HasBidState(decimal bid_id, string state_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            bool res = false;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.has_bid_state";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Decimal, System.Data.ParameterDirection.ReturnValue));
                cmd.Parameters.Add(new OracleParameter("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_state_id", OracleDbType.Varchar2, 4000, state_id, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
                res = Convert.ToDecimal(cmd.Parameters["res_"].Value.ToString()) == 1 ? true : false;
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return res;
        }

        public void BidStateCheckIn(decimal bid_id, string state_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_pack.bid_state_check_in";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("bid_id_", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("state_id_", OracleDbType.Varchar2, 4000, state_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("user_comment_", OracleDbType.Varchar2, 4000, String.Empty, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public void BidStateCheckOut(decimal bid_id, string state_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_pack.bid_state_check_out";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("bid_id_", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("state_id_", OracleDbType.Varchar2, 4000, state_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("user_comment_", OracleDbType.Varchar2, 4000, String.Empty, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public void BidStateDel(decimal bid_id, string state_id)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_pack.bid_state_del";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("bid_id_", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("state_id_", OracleDbType.Varchar2, 4000, state_id, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
        }

        public string BidParseSql(decimal bid_id, string sql) 
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            string res = String.Empty;
            try
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "wcs_utl.parse_sql";
                cmd.Parameters.Clear();
                cmd.Parameters.Add(new OracleParameter("res_", OracleDbType.Varchar2, 4000, res, System.Data.ParameterDirection.ReturnValue));
                cmd.Parameters.Add(new OracleParameter("p_bid_id", OracleDbType.Decimal, bid_id, System.Data.ParameterDirection.Input));
                cmd.Parameters.Add(new OracleParameter("p_plsql", OracleDbType.Varchar2, 4000, sql, System.Data.ParameterDirection.Input));

                cmd.ExecuteNonQuery();
                res = cmd.Parameters["res_"].Value.ToString();
            }
            finally
            {
                cmd.Dispose();
                connection.Close();
                connection.Dispose();
            }
            return res;
        }
    }
}