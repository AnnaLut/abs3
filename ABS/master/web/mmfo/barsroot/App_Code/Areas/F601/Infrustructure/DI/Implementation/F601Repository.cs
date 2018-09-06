using System;
using System.Collections.Generic;
using System.Linq;
using BarsWeb.Areas.F601.Models;
using Oracle.DataAccess.Client;
using Bars.Classes;
using System.Data;
using Oracle.DataAccess.Types;

namespace BarsWeb.Areas.F601.Infrastructure.DI.Abstract
{
    /// <summary>
    /// Summary description for F601Repository
    /// </summary>
    public class F601Repository : IF601Repository
    {
        public F601Repository() { }

        public string GetCreditInfoDetail(long id)
        {
            string objectData = string.Empty;
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "NBU_GATEWAY.NBU_SERVICE_UTL.show_data_for_session";
                    cmd.Parameters.Add("p_res", OracleDbType.Clob, ParameterDirection.ReturnValue);
                    cmd.Parameters.Add("p_session_id", OracleDbType.Int32, id, ParameterDirection.Input);
                    cmd.ExecuteNonQuery();

                    using (OracleClob resClob = (OracleClob)cmd.Parameters["p_res"].Value) {
                        if (resClob.Length != 0)
                        {
                            objectData = resClob.Value;
                        }
                    }
                }
            }

            return objectData;
        }

        public List<CreditInfoObject> GetCreditInfoList()
        {
            List<CreditInfoObject> sessionList = new List<CreditInfoObject>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = @"select t.id, t.object_type_name, t.object_code, 
                                                t.object_name, t.session_state, t.session_creation_time,
                                                t.session_activity_time, t.session_details 
                                                                from nbu_gateway.v_nbu_session t";

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            sessionList.Add(new CreditInfoObject()
                            {
                                Id = Convert.ToInt64(reader["id"]),
                                ObjectType = Convert.ToString(reader["object_type_name"]),
                                ObjectCode = Convert.ToString(reader["object_code"]),
                                Name = Convert.ToString(reader["object_name"]),
                                Status = Convert.ToString(reader["session_state"]),
                                PacketCreationDate = Convert.ToDateTime(reader["session_creation_time"]),
                                PacketTransmissionDate = Convert.ToDateTime(reader["session_activity_time"]),
                                ErrorsDescription = Convert.ToString(reader["session_details"]),
                            });
                        }
                    }
                }
            }

            return sessionList;
        }

        public List<string> GetStatusesList()
        {
            List<string> statusesList = new List<string>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = @"select distinct(t.session_state) from nbu_gateway.v_nbu_session t";

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            statusesList.Add(Convert.ToString(reader["session_state"]));
                        }
                    }
                }
            }

            return statusesList;
        }

        public List<string> GetObjectTypesList()
        {
            List<string> objectTypesList = new List<string>();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = @"select distinct(t.object_type_name) from nbu_gateway.v_nbu_session t";

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            objectTypesList.Add( Convert.ToString(reader["object_type_name"]));
                        }
                    }
                }
            }

            return objectTypesList;
        }

        public string GetPrivateKeyId()
        {
            return "asd456";
        }

        public List<ToSignObject> GetSignDataList(long number)
        {
            List<ToSignObject> resList = new List<ToSignObject>();
            ToSignObject toSignItem = new ToSignObject();
            using (OracleConnection connection = OraConnector.Handler.UserConnection)
            {
                using (OracleCommand cmd = connection.CreateCommand())
                {
                    cmd.CommandText = @"select t.id, t.data_to_sign from nbu_gateway.v_nbu_session_to_sign t where rownum<=:p_number";
                    cmd.Parameters.Add("p_number", OracleDbType.Int32, number, ParameterDirection.Input);

                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            resList.Add(new ToSignObject()
                            {
                                SessionId = Convert.ToInt32(reader["id"]),
                                PayloadToSign = Convert.ToString(reader["data_to_sign"])
                            });
                        }
                    }
                }
            }

            return resList;
        }

        public void PutSignedObject(int id, string nbuObject)
        {
            OracleConnection connection = OraConnector.Handler.UserConnection;
            OracleCommand cmd = connection.CreateCommand();
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "NBU_GATEWAY.NBU_SERVICE_UTL.put_sign";
                cmd.Parameters.Add("p_session_id", OracleDbType.Int32, id, ParameterDirection.Input);
                cmd.Parameters.Add("p_data", OracleDbType.Clob, nbuObject, ParameterDirection.Input);
                cmd.ExecuteNonQuery();
            }
            finally
            {
                cmd.Dispose();
                connection.Dispose();
                connection.Close();
            }
        }
    }
}