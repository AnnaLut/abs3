using BarsWeb.Areas.Wcs.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Wcs.Models;
using BarsWeb.Models;
using System.Linq;
using System;
using System.Collections.Generic;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using Bars.Classes;

namespace BarsWeb.Areas.Wcs.Infrastructure.DI.Implementation
{
    public class WcsRepository : IWcsRepository
    {
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
                    q.Ord = Convert.ToInt32(reader.GetDecimal(5));
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
    }
}