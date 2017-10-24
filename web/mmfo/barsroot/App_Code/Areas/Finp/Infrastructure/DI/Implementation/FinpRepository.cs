using System;
using System.Data;
using System.Linq;
using BarsWeb.Areas.Finp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Finp.Infrastructure.Repository.DI.Abstract;
using Areas.Finp.Models;
using BarsWeb.Areas.Finp.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;

namespace BarsWeb.Areas.Finp.Infrastucture.DI.Implementation
{
    public class FinpRepository : IFinpRepository
    {
        readonly FinpEntities _entities;
        public FinpRepository(IFinpModel model)
        {
		    _entities = model.FinpEntities;
        }

        public IQueryable<V_FINP_ANSWERS> GetAnswers(decimal? sessionId)
        {
            return _entities.V_FINP_ANSWERS.Where(i => i.SESSION_ID == sessionId);
        }
        public IQueryable<V_FINP_QUESTIONS> GetQuestions()
        {
            return _entities.V_FINP_QUESTIONS.OrderBy(i => i.ID);
        }

        public IQueryable<V_FINP_SURVEY_GROUPS> GetSurveyGroups(string surveyId)
        {
            return _entities.V_FINP_SURVEY_GROUPS.Where(i => i.SURVEY_ID == surveyId).OrderBy(i => i.ORD);
        }
        public IQueryable<V_FINP_SURVEY_GROUPS_HIDE> GetSurveyGroupsHide(int sessionId, string surveyId)
        {
            return _entities.V_FINP_SURVEY_GROUPS_HIDE.Where(i => i.SESSION_ID == sessionId && i.SURVEY_ID == surveyId).OrderBy(i => i.ORD);
        }
        public IQueryable<V_FINP_SURVEY_QUESTIONS_HIDE> GetSurveyQuestions(int sessionId, string surveyId, string groupId)
        {
            return _entities.V_FINP_SURVEY_QUESTIONS_HIDE.Where(i => i.SESS_ID == sessionId).Where(i => i.GROUP_ID == groupId).Where(j => j.SURVEY_ID == surveyId).OrderBy(i => i.ORD);
        }
        public IQueryable<V_FINP_QUESTION_REFER_PARAMS> GetSurveyQuestionRefParams()
        {
            return _entities.V_FINP_QUESTION_REFER_PARAMS;
        }
        public IQueryable<V_FINP_QUESTION_LIST_ITEMS> GetSurveyQuestionListItems()
        {
            return _entities.V_FINP_QUESTION_LIST_ITEMS;
        }
        public IQueryable<V_FINP_QUESTION_LIST_ITEMS> GetQuestionListItems()
        {
            return _entities.V_FINP_QUESTION_LIST_ITEMS/*.Where(i => i.QUESTION_ID == questionId && i.VISIBLE == visible).OrderBy(o => o.ORD)*/;
        }
        public IQueryable<V_FINP_SESSIONS> GetSessions()
        {
            return _entities.V_FINP_SESSIONS;
        }
        public IQueryable<V_FINP_SESSIONS> GetSessionFiltered(string typeId, string methodId)
        {
            var session = _entities.V_FINP_SESSIONS.Where(i => i.TYPE_ID == typeId).Where(i => i.METH_ID == methodId).OrderBy(i => i.ID);
            return session;
        }
        public IQueryable<V_FINP_SESSIONS> GetSessionObjectSrc(string typeId, decimal srcObjId)
        {
            var session = _entities.V_FINP_SESSIONS.Where(i => i.TYPE_ID == typeId).Where(j => j.SRC_OBJ_ID == srcObjId).OrderBy(i => i.ID);
            return session;
        }
        public IQueryable<FINP_METHODS> GetMethods()
        {
            return _entities.FINP_METHODS.OrderBy(i => i.ID);
        }
        public IQueryable<FINP_OBJ_TYPES> GetObjectTypes()
        {
            return _entities.FINP_OBJ_TYPES.OrderBy(i => i.ID);
        }

        public FinpSessionModel GetSessionModels()
        {
            var sessionModel = new FinpSessionModel
            {
                Sessions = GetSessions(),
                Metods = GetMethods(),
                ObjectTypes = GetObjectTypes(),
                QuestionListItems = GetQuestionListItems()

            };

            return sessionModel;
        }

        public FinpQuestionParamsModel GetQuestionParamsModels(int sessionId, string surveyId, string groupId)
        {
            var questModel = new FinpQuestionParamsModel
            {
                SurQuestionParams = GetSurveyQuestions(sessionId, surveyId, groupId),
                SurQuestionRefParams = GetSurveyQuestionRefParams(),
                SurQuestionListItem = GetSurveyQuestionListItems(),
                SesAnswers = GetAnswers(sessionId)
            };

            return questModel;
        }

        public string GetSurveyId(string methId)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            var surveyId = "";
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                cmd.CommandText = "select survey_id from finp_methods where id = " + methId;

                var reader = cmd.ExecuteReader();


                while(reader.Read())
                {
                    surveyId = reader["survey_id"].ToString();
                }
            }
            finally
            {
                connection.Dispose();
                connection.Close();
            }

            return surveyId;
        }

        public int CreateSession(string objType, int objId, string methId, int countGuarantor)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            var sessionId = new int();
            try
            {
                OracleCommand cmd = connection.CreateCommand();
                var objectId = new int();

                var srcObjId = _entities.ExecuteStoreQuery<int>("select id from finp_objects where src_obj_id = " + objId).FirstOrDefault();

                if (srcObjId == 0)
                {
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "finp_pack.create_object";

                    cmd.Parameters.Add("p_obj_type_id", OracleDbType.Varchar2, 100, objType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_obj_type_id", OracleDbType.Int16, objId, ParameterDirection.Input);
                    cmd.Parameters.Add("obj_id", OracleDbType.Int16, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    objectId = Convert.ToInt16(cmd.Parameters["obj_id"].Value.ToString());
                }
                else
                {
                    objectId = srcObjId;
                }

                var objMeth = _entities.ExecuteStoreQuery<String>("select meth_id from finp_obj_meths where obj_id = " + objectId + " and meth_id = " + methId).FirstOrDefault();

                if (String.IsNullOrEmpty(objMeth))
                {
                    _entities.FINP_PACK_SET_OBJ_METH(objectId, methId, 1);
                }

                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "finp_pack.create_session";

                cmd.Parameters.Add("p_obj_id", OracleDbType.Int16, objectId, ParameterDirection.Input);
                cmd.Parameters.Add("p_meth_id", OracleDbType.Varchar2, methId, ParameterDirection.Input);
                cmd.Parameters.Add("session_id", OracleDbType.Int16, ParameterDirection.Output);
                cmd.Parameters.Add("p_count_guarantor", OracleDbType.Int64, countGuarantor, ParameterDirection.Input);
                

                cmd.ExecuteNonQuery();

                sessionId = Convert.ToInt16(cmd.Parameters["session_id"].Value.ToString());
            }
            catch(OracleException e)
            { 

            }
            finally
            {
                connection.Close();
            }

            return sessionId;
        }

        public void SetAnswers(int sessionId, string questionId, string value)
        {
            _entities.FINP_UTL_SET_ANSWER(sessionId, questionId, value, (decimal?)null);
        }

        public void SetStatus(int sessionId, string statusId, string comment)
        {
            _entities.FINP_PACK_SET_STATUS(sessionId, statusId, comment);
        }

        public void RemoveAnswers(int sessionId, string questionId)
        { 
            _entities.FINP_UTL_REMOVE_ANSWER(sessionId, questionId);
        }
    }
}