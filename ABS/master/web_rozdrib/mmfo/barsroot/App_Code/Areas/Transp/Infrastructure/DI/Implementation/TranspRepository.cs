using Bars.Classes;
using BarsWeb.Areas.Transp.Infrastructure.DI.Abstract;
using BarsWeb.Areas.Transp.Models.ApiModels;
using BarsWeb.Infrastructure.Repository.DI.Abstract;
using Models;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;


namespace BarsWeb.Areas.Transp.Infrastructure.DI.Implementation
{
    public class TranspRepository : ITranspRepository
    {
        private EntitiesBars _entities;
        public TranspRepository(IAppModel model)
        {
            _entities = model.Entities;
        }


        public InputTypes GetReqType(string typeName)
        {
            string ReqState = String.Empty;
            string Sql = String.Empty;
            try
            {
                Sql = @"select t.type_name,
                               t.type_desc,
                               t.sess_type,
                               t.act_type,
                               t.output_data_type,
                               t.input_data_type,
                               t.priority,
                               (select m.mime_types from barstrans.dict_mime_types m where m.id = t.cont_type) as cont_type,
                               t.json2xml,
                               t.xml2json,
                               t.compress_type,
                               t.input_decompress,
                               t.output_compress,
                               t.input_base_64,
                               t.output_base_64,
                               t.store_head,
                               t.add_head,
                               t.check_sum,
                               t.loging
                          from barstrans.input_types t
                         where type_name = upper(:TypeName)";

               return _entities.ExecuteStoreQuery<InputTypes>(Sql, new OracleParameter[1] { new OracleParameter("TypeName", OracleDbType.Varchar2, typeName, ParameterDirection.Input) }).First();

            }

            catch (Exception e)
            {

                throw new Exception("Error at selecting req Type: " + e.Message, e);

            }
        }


        public string InsertReq(string ReqType, string HttpType, string ActionType, string UserName, string GetParams)
        {

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.insert_req";
                    cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, ReqType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_http_type", OracleDbType.Varchar2, 255, HttpType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_act_type", OracleDbType.Varchar2, 255, string.IsNullOrEmpty(ActionType) ? "DIRECT" : ActionType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user", OracleDbType.Varchar2, 255, UserName, ParameterDirection.Input);
                    cmd.Parameters.Add("p_get_params", OracleDbType.Clob, GetParams, ParameterDirection.Input);
                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 36, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    return cmd.Parameters["p_req_id"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_req_id"].Value.ToString();


                }

                catch (Exception e)
                {

                    throw new Exception("Error at saving request types: " + e.Message, e);

                }

            }

        }

        public string InsertReq(string ReqType, string HttpType, string ActionType, string UserName, string GetParams, string ReqBody)
        {

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.insert_req_body";
                    cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, ReqType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_http_type", OracleDbType.Varchar2, 255, HttpType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_act_type", OracleDbType.Varchar2, 255, string.IsNullOrEmpty(ActionType) ? "DIRECT" : ActionType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user", OracleDbType.Varchar2, 255, UserName, ParameterDirection.Input);
                    cmd.Parameters.Add("p_get_params", OracleDbType.Clob, GetParams, ParameterDirection.Input);
                    cmd.Parameters.Add("p_body", OracleDbType.Clob, ReqBody, ParameterDirection.Input);
                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 36, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    return cmd.Parameters["p_req_id"].Status == OracleParameterStatus.NullFetched ? String.Empty : cmd.Parameters["p_req_id"].Value.ToString();


                }

                catch (Exception e)
                {

                    throw new Exception("Error at saving request types: " + e.Message, e);

                }

            }

        }

        public void InsertReqParams(string ReqId, string ParamType, KeyValuePair<string, string>[] ReqParams)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "barstrans.transp_utl.insert_req_params";

                foreach (KeyValuePair<string, string> get_val in ReqParams)
                {
                    try
                    {

                        cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 255, ReqId, ParameterDirection.Input);
                        cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, ParamType, ParameterDirection.Input);
                        cmd.Parameters.Add("p_tag", OracleDbType.Varchar2, 255, get_val.Key, ParameterDirection.Input);
                        cmd.Parameters.Add("p_value", OracleDbType.Varchar2, 255, get_val.Value, ParameterDirection.Input);

                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }

                    catch (Exception e)
                    {

                        throw new Exception("Error at saving request params: " + e.Message, e);

                    }

                }

            }

        }

        public void InsertReqParams(string ReqId, string ParamType, string ReqParams)
        {
            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "barstrans.transp_utl.insert_req_params";
                try
                {

                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 255, ReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_type", OracleDbType.Varchar2, 255, ParamType, ParameterDirection.Input);
                    cmd.Parameters.Add("p_params", OracleDbType.Clob, ReqParams, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();
                }

                catch (Exception e)
                {

                    throw new Exception("Error at saving request params: " + e.Message, e);

                }

            }

        }

        public void ProcessRequest(string ReqId)
        {

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.process_req";
                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 255, ReqId, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();

                }

                catch (Exception e)
                {

                    throw new Exception("Error at processing request: " + e.Message, e);

                }

            }

        }

        public string GetRespData(string ReqId, string UserName)
        {
            string RespData = String.Empty;

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.get_resp_data";
                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 255, ReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user", OracleDbType.Varchar2, 255, UserName, ParameterDirection.Input);
                    cmd.Parameters.Add("p_resp", OracleDbType.Clob, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    if (cmd.Parameters["p_resp"].Status != OracleParameterStatus.NullFetched)
                    {
                        using (OracleClob RespClob = (OracleClob)cmd.Parameters["p_resp"].Value)
                        {
                            RespData = RespClob.Value;
                        }
                    }

                    return RespData;
                }

                catch (Exception e)
                {

                    throw new Exception("Error at selecting req body: " + e.Message, e);

                }

            }

        }

        public List<KeyValuePair<string, string>> GetRespParams(string reqId)
        {
            string Sql = String.Empty;
            try
            {
                Sql = @"select r.tag, r.value from barstrans.input_resp_params r
                where R.RESP_ID =:ReqId";

                return _entities.ExecuteStoreQuery<KeyValuePair<string, string>>(Sql, new OracleParameter[1] { new OracleParameter("TypeName", OracleDbType.Varchar2, reqId, ParameterDirection.Input) }).ToList();


            }

            catch (Exception e)
            {

                throw new Exception("Error at selecting req body: " + e.Message, e);

            }
        }

        public string GetReqStatus(string ReqId, string UserName)
        {

            using (OracleConnection con = OraConnector.Handler.UserConnection)
            using (OracleCommand cmd = con.CreateCommand())
            {
                try
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.get_req_status";
                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 255, ReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_user", OracleDbType.Varchar2, 255, UserName, ParameterDirection.Input);
                    cmd.Parameters.Add("p_state", OracleDbType.Varchar2, 4000, null, ParameterDirection.Output);

                    cmd.ExecuteNonQuery();

                    return cmd.Parameters["p_state"].Status == OracleParameterStatus.NullFetched ? "Request with id param.Value do not exists" : cmd.Parameters["p_state"].Value.ToString();

                }

                catch (Exception e)
                {

                    throw new Exception("Error at get request status: " + e.Message, e);

                }

            }

        }

        public void InputLoger(string ReqId, string Act, string State, string Message)
        {
            try
            {
                using (OracleConnection con = OraConnector.Handler.UserConnection)
                using (OracleCommand cmd = con.CreateCommand())
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.resive_loger";

                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 36, ReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_act", OracleDbType.Varchar2, 255, Act, ParameterDirection.Input);
                    cmd.Parameters.Add("p_state", OracleDbType.Varchar2, 255, State, ParameterDirection.Input);
                    cmd.Parameters.Add("p_message", OracleDbType.Varchar2, 4000, Message, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();

                }
            }

            catch (Exception e)
            {

                throw new Exception("Error at loging: " + e.Message, e);

            }
            
        }

        public void InputLoger(string ReqId, string Act, string State, string Message, string LargeMessage)
        {
            try
            {
                using (OracleConnection con = OraConnector.Handler.UserConnection)
                using (OracleCommand cmd = con.CreateCommand())
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "barstrans.transp_utl.resive_loger";

                    cmd.Parameters.Add("p_req_id", OracleDbType.Varchar2, 36, ReqId, ParameterDirection.Input);
                    cmd.Parameters.Add("p_act", OracleDbType.Varchar2, 255, Act, ParameterDirection.Input);
                    cmd.Parameters.Add("p_state", OracleDbType.Varchar2, 255, State, ParameterDirection.Input);
                    cmd.Parameters.Add("p_message", OracleDbType.Varchar2, 4000, Message, ParameterDirection.Input);
                    cmd.Parameters.Add("p_large_message", OracleDbType.Clob, LargeMessage, ParameterDirection.Input);

                    cmd.ExecuteNonQuery();

                }
            }

            catch (Exception e)
            {

                throw new Exception("Error at loging: " + e.Message, e);

            }

        }
    }
}